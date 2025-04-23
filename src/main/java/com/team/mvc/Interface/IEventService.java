package com.team.mvc.Interface;

import com.team.mvc.DTO.EventDTO;

import java.util.List;
import java.util.Map;

public interface IEventService {

    // 전체 이벤트 리스트 조회
    List<EventDTO> listEvent(Map<String, Object> map);

    // 이벤트 상세보기
    EventDTO getEvent(int eventId);

    // 이벤트 개수 조회 (페이징)
    int countEvents(Map<String, Object> map);

    // 이벤트 등록
    int insertEvent(EventDTO dto);

    // 이벤트 수정
    int updateEvent(EventDTO dto);

    // 이벤트 삭제
    int deleteEvent(int eventId);
}
