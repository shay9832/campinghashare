package com.team.mvc.Controller;

import com.team.mvc.DTO.Pagenation;
import com.team.mvc.DTO.MatchingRequestDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IRentalSearchService;
import com.team.mvc.Interface.IStorenDAO;
import com.team.mvc.DTO.StorenRequestDTO;
import com.team.mvc.Interface.ISearchMatchingRequestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RentalSearchController {

    @Autowired
    private IRentalSearchService rentalSearchService;
    @Autowired
    private ISearchMatchingRequestService searchMatchingRequestService;

    // 스토렌 장비검색 페이지
    @RequestMapping("/rentalsearch-main.action")
    public String rentalSearchMain(@RequestParam(value = "page", defaultValue = "1") int page,
                                   @RequestParam(value = "size", defaultValue = "100") int size,
                                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                   Model model) {
        // 전체 스토렌 장비 리스트
        List<StorenDTO> storenList = rentalSearchService.listStoren();    //매개변수 유저코드 없이 전체 스토렌 조회하는 메소드
        model.addAttribute("storenList", storenList);

        // 전체 스토렌 장비 수
        int totalStorenCount = storenList.size();

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalStorenCount, size, 10);

        model.addAttribute("totalStorenCount", totalStorenCount);
        model.addAttribute("pagenation", pagenation);

        // 검색 조건인 담길 dto 생성
        StorenDTO dto = new StorenDTO();

        // 검색 조건 설정
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchKeyword", dto.getSearchKeyword());
        }

        return "rentalSearch-main";
    }

    // 특정 스토렌 장비글 페이지
    @RequestMapping(value = "/storenmatching-request.action")
    public String rentalMatchingRequest(Model model, @RequestParam("storenId") int transactionId, HttpSession session) {

        //임의의 유저코드 세션에 넣기
        session.setAttribute("user_code", 5);

        System.out.println("=== RentalSearchController : rentalMatchingRequest() -  STOREN : START ===");
        System.out.println("Transaction ID: " + transactionId);

        StorenRequestDTO storenRequest = searchMatchingRequestService.getStoren(transactionId);
        model.addAttribute("storen", storenRequest.getStorenDto());
        model.addAttribute("owner", storenRequest.getUserDto());

        return "storenMatching-request";
    }

    // 스토렌 장비 매칭신청 ajax 처리
    @PostMapping(value = "/api/storen/matching-request")
    @ResponseBody
    public Map<String, Object> storenMatchingRequest(@RequestParam("storenId") int storenId
            , @RequestParam("rentalStartDate") String rentalStartDate
            , @RequestParam("rentalEndDate") String rentalEndDate
            , HttpSession session) {

        // 세션에서 현재 로그인한 유저코드 가져오기
//        Integer user_code = (Integer) session.getAttribute("user_code");
//        if (user_code == null) {
//            response.put("success", false);
//            response.put("message", "로그인이 필요합니다.");
//            return response;
//        }

        // 결과 처리 담아둘 맵
        Map<String, Object> result = new HashMap<>();

        // 테스트용 임의로 로그인한 user_code 넣기
        session.setAttribute("user_code", 5);
        Integer user_code = (Integer) session.getAttribute("user_code");
        try {
            // 매칭 요청 저장
            boolean success = searchMatchingRequestService.insertMatchingRequest(storenId, user_code, rentalStartDate, rentalEndDate);

            if (success) {
                result.put("success", true);
                result.put("message", "매칭 신청이 완료되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "이미 매칭 신청한 장비입니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }


    // 매칭 상태 확인 (AJAX 요청용)
    @GetMapping("/api/storen/check-matching-status")
    @ResponseBody
    public Map<String, Object> checkStorenMatchingStatus(@RequestParam("storenId") int storenId,
                                                         HttpSession session) {
        // 결과 처리 담아둘 맵
        Map<String, Object> result = new HashMap<>();

        // 테스트용 임의로 로그인한 user_code 넣기
        session.setAttribute("user_code", 5);
        Integer user_code = (Integer) session.getAttribute("user_code");

        try {
            MatchingRequestDTO matching = searchMatchingRequestService.getMatchingByStorenAndUser(storenId, user_code);

            if (matching != null) {
                result.put("hasMatching", true);
                result.put("dateRange", matching.getRental_start_date() + " ~ " + matching.getRental_end_date());
                result.put("days", matching.getRental_duration());
                result.put("price", matching.getRental_pay());
            } else {
                System.out.println("matching은 null입니다.");
                result.put("hasMatching", false);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
            result.put("hasMatching", false);
            result.put("error", "서버 오류: " + e.getMessage());
        }

        return result;
    }
}

