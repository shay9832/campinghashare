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

import java.util.List;

@Controller
public class RentalSearchController {

    @Autowired
    private IRentalSearchService rentalSearchService;

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
    @RequestMapping(value="/storenmatching-request.action")
    public String rentalMatchingRequest(Model model) {
        return "storenMatching-request";
    }
}
