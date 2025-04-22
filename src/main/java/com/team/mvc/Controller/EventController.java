package com.team.mvc.Controller;

import com.team.mvc.DTO.EventDTO;
import com.team.mvc.DTO.Pagenation;
import com.team.mvc.Interface.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EventController {

    @Autowired
    private IEventService eventService;

    // 이벤트 목록 페이지
    @RequestMapping("/event.action")
    public String event(@RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "size", defaultValue = "9") int size,
                        @RequestParam(value = "status", required = false) String status,
                        @RequestParam(value = "serchType", required = false) String searchType,
                        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                        Model model) {

        // 검색 파라미터 설정
        Map<String, Object> map = new HashMap<>();
        map.put("page", page);
        map.put("size", size);
        map.put("status", status);
        map.put("searchType", searchType);
        map.put("searchKeyword", searchKeyword);

        // 전체 이벤트 개수 조회
        int totalCount = eventService.countEvents(map);

        // 페이지네이션 객체 생성
        Pagenation pagenation = new Pagenation(page, totalCount, size, 10);

        // 이벤트 목록 조회
        List<EventDTO> eventList = eventService.listEvent(map);

        // 모델에 데이터 추가
        model.addAttribute("eventList", eventList);
        model.addAttribute("pagenation", pagenation);
        model.addAttribute("status", status);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("searchType", searchType);

        return "event";
    }
}
