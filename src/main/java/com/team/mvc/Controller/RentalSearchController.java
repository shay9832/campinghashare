package com.team.mvc.Controller;

import com.team.mvc.DTO.MatchingRequestDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.DTO.StorenRequestDTO;
import com.team.mvc.Interface.ISearchMatchingRequestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RentalSearchController {

    @Autowired
    private ISearchMatchingRequestService searchMatchingRequestService;

    // 스토렌 장비검색 페이지
    @RequestMapping(value = "/rentalserach-main.action")
    public String rentalSerachMain(Model model) {

//        // 초기에는 스토렌 소유자의 매칭 신청이 들어온 내역만 로드
//        List<StorenDTO> storenList = /*서비스인터페이스*/.listStroen();    //매개변수 유저코드 없이 전체 스토렌 조회하는 메소드 필요
//        model.addAttribute("StorenList", storenList);
//        model.addAttribute("activeTab", "storen"); // 초기 탭 지정

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

