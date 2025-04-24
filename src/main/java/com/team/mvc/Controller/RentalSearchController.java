package com.team.mvc.Controller;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.IRentalSearchService;
import com.team.mvc.Interface.IStorenDAO;
import com.team.mvc.Interface.ISearchMatchingRequestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
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
                                   @RequestParam(value = "size", defaultValue = "16") int size,
                                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                   @RequestParam(value = "tab", required = false, defaultValue = "all") String tab,
                                   @RequestParam(value = "minPrice", required = false, defaultValue = "0") int minPrice,
                                   @RequestParam(value = "maxPrice", required = false, defaultValue = "100000") int maxPrice,
                                   @RequestParam(value = "startDate", required = false) String startDate,
                                   @RequestParam(value = "endDate", required = false) String endDate,
                                   Model model) {
        // 디버깅 확인
        System.out.println("\nsearchKeyword: " + searchKeyword);
        System.out.println("minPrice: " + minPrice);
        System.out.println("maxPrice: " + maxPrice);
        System.out.println("startDate: " + startDate);
        System.out.println("endDate: " + endDate);

        // 키워드 유무에 따라 적절한 메서드 호출
//        List<StorenDTO> storenList;
//        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
//            // 검색어가 있는 경우 검색 메서드 사용
//            storenList = rentalSearchService.searchStorenKeyword(searchKeyword);
//        } else {
//            // 검색어가 없는 경우 전체 목록 조회
//            storenList = rentalSearchService.listStoren();
//        }

        // 검색 필터링(키워드, 가격, 날짜) 유무에 따라 메소드 호출
        List<StorenDTO> storenList;
        if ((searchKeyword == null || searchKeyword.trim().isEmpty()) &&
                (startDate == null || startDate.trim().isEmpty()) &&
                (endDate == null || endDate.trim().isEmpty()) &&
                minPrice == 0 && maxPrice == 100000) {
            // 검색 필터링이 아무것도 없다면 그냥 전체 스토렌 조회(매칭완료가 아닌 상태, 검수완료하여 등급이 나온 상태)
            storenList = rentalSearchService.listStoren();
        }
        else {
            // 검색 필터링이 뭐라도 있다면 검색된 스토렌 조회(매칭완료가 아닌 상태, 검수완료하여 등급이 나온 상태)
            storenList = rentalSearchService.searchStoren(
                    searchKeyword, minPrice, maxPrice, startDate, endDate);
        }

        // 탭에 따라 데이터 필터링
        List<StorenDTO> filteredList;

        if ("storen".equals(tab)) {
            // 스토렌 탭 - 스토렌 유형만 필터링
            filteredList = storenList.stream()
                    .filter(dto -> "STOREN".equals(dto.getType()))
                    .collect(Collectors.toList());
        } else if ("rental".equals(tab)) {
            // 렌탈 탭 - 렌탈 유형만 필터링
            filteredList = storenList.stream()
                    .filter(dto -> "RENTAL".equals(dto.getType()))
                    .collect(Collectors.toList());
        } else {
            // "all" 탭 또는 기타 - 모든 유형 표시
            filteredList = storenList;
        }


        // 전체 스토렌 장비 수 (필터링된 목록 기준)
        int totalStorenCount = filteredList.size();

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalStorenCount, size, 10);

        // 페이징에 따라 데이터 필터링 - 여기가 중요한 부분!
        int startIndex = (page - 1) * size;
        int endIndex = Math.min(startIndex + size, filteredList.size());

        // 현재 페이지에 해당하는 데이터만 추출
        List<StorenDTO> pagedList =
                (startIndex < filteredList.size()) ?
                        filteredList.subList(startIndex, endIndex) :
                        new ArrayList<>();


        model.addAttribute("storenList", pagedList);
        model.addAttribute("activeTab", tab);
        model.addAttribute("totalStorenCount", totalStorenCount);
        model.addAttribute("pagenation", pagenation);

        /* 검색어 및 필터 유지 */
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "rentalSearch-main";
    }

    // 특정 스토렌 장비글 페이지
    @RequestMapping(value = "/storenmatching-request.action")
    public String rentalMatchingRequest(Model model, @RequestParam("storenId") int transactionId,
                                        @ModelAttribute("userCode") Integer userCode)
    {
        System.out.println("=== RentalSearchController : rentalMatchingRequest() -  STOREN : START ===");
        System.out.println("Transaction ID: " + transactionId);
        System.out.println("userCode: " + userCode);


        StorenRequestDTO storenRequest = searchMatchingRequestService.getStoren(transactionId);
        model.addAttribute("userCode", userCode);
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
            , @ModelAttribute("userCode") Integer userCode) {

        // 결과 처리 담아둘 맵
        Map<String, Object> result = new HashMap<>();
        int user_code = userCode;

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
                                                         @ModelAttribute("userCode") Integer userCode) {
        // 결과 처리 담아둘 맵
        Map<String, Object> result = new HashMap<>();

        int user_code = userCode;

        //System.out.println("userCode = " + user_code + " storenId = " + storenId);

        try {
            MatchingRequestDTO matching = searchMatchingRequestService.getMatchingByStorenAndUser(storenId, user_code);

            if (matching != null) {
                result.put("hasMatching", true);
                result.put("startDate", matching.getRental_start_date());
                result.put("endDate", matching.getRental_end_date());
                result.put("days", matching.getRental_duration());
                result.put("price", matching.getRental_pay());
                result.put("status", matching.getPayment_status());
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

