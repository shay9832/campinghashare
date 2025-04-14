package com.team.mvc.Controller;

import com.team.mvc.DTO.Pagenation;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IRentalSearchService;
import com.team.mvc.Interface.IStorenDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class RentalSearchController {

    @Autowired
    private IRentalSearchService rentalSearchService;

    // 스토렌 장비검색 페이지
    @RequestMapping("/rentalsearch-main.action")
    public String rentalSearchMain(@RequestParam(value = "page", defaultValue = "1") int page,
                                   @RequestParam(value = "size", defaultValue = "100") int size,
                                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                   @RequestParam(value = "tab", required = false, defaultValue = "all") String tab,
                                   Model model) {
        // 키워드 유무에 따라 적절한 메서드 호출
        List<StorenDTO> storenList;
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // 검색어가 있는 경우 검색 메서드 사용
            storenList = rentalSearchService.searchStorenKeyword(searchKeyword);
        } else {
            // 검색어가 없는 경우 전체 목록 조회
            storenList = rentalSearchService.listStoren();
        }

        // 탭에 따라 데이터 필터링
        List<StorenDTO> filteredList;

        if ("storen".equals(tab)) {
            // 스토렌 탭 - 스토렌 유형만 필터링
            filteredList = storenList.stream()
                    .filter(dto -> "STOREN".equals(dto.getType()))
                    .collect(Collectors.toList());
        } else {
            // 스토렌 탭이 아니면 빈 리스트 반환 (데이터 표시 안 함)
            filteredList = new ArrayList<>();
        }

        model.addAttribute("storenList", filteredList);
        model.addAttribute("activeTab", tab);

        // 전체 스토렌 장비 수 (필터링된 목록 기준)
        int totalStorenCount = filteredList.size();

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalStorenCount, size, 10);

        model.addAttribute("totalStorenCount", totalStorenCount);
        model.addAttribute("pagenation", pagenation);
        model.addAttribute("searchKeyword", searchKeyword);  // 검색어 유지

        return "rentalSearch-main";
    }

    // 특정 스토렌 장비글 페이지
    @RequestMapping(value="/storenmatching-request.action")
    public String rentalMatchingRequest(Model model) {
        return "storenMatching-request";
    }
}
