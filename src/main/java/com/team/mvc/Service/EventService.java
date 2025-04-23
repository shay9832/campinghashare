package com.team.mvc.Service;

import com.team.mvc.DTO.EventDTO;
import com.team.mvc.Interface.IEventDAO;
import com.team.mvc.Interface.IEventService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class EventService implements IEventService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<EventDTO> listEvent(Map<String, Object> map) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        List<EventDTO> eventList = dao.listEvent(map);

        // 현재 날짜를 기준으로 이벤트 상태 설정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowStr = sdf.format(new Date());

        for (EventDTO event : eventList) {
            // 이벤트 상태 설정 (진행중, 진해예정, 종료)
            try {
                Date startDate = sdf.parse(event.getEventStartDate());
                Date endDate = sdf.parse(event.getEventEndDate());
                Date now = sdf.parse(nowStr);

                if (startDate.after(now)) {
                    event.setStatus("coming"); // 진행예정
                } else if (endDate.before(now)) {
                    event.setStatus("ended"); // 종료
                } else {
                    event.setStatus("going"); // 진행중
                }
            } catch (ParseException e) {
                event.setStatus("going"); // 파싱 오류 시 기본값
                e.printStackTrace();
            }

        }

        return eventList;
    }

    @Override
    public EventDTO getEvent(int eventId) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        EventDTO event = dao.getEvent(eventId);

        // 현재 날짜를 기준으로 이벤트 상태 설정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowStr = sdf.format(new Date());

        try {
            Date startDate = sdf.parse(event.getEventStartDate());
            Date endDate = sdf.parse(event.getEventEndDate());
            Date now = sdf.parse(nowStr);

            if (startDate.after(now)) {
                event.setStatus("coming");
            } else if (endDate.before(now)) {
                event.setStatus("ended");
            } else {
                event.setStatus("going");
            }


        } catch (ParseException e) {
            event.setStatus("going");
            e.printStackTrace();
        }

        return event;
    }

    @Override
    public int countEvents(Map<String, Object> map) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        return dao.countEvents(map);
    }

    @Override
    public int insertEvent(EventDTO dto) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        return dao.insertEvent(dto);
    }

    @Override
    public int updateEvent(EventDTO dto) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        return dao.updateEvent(dto);
    }

    @Override
    public int deleteEvent(int eventId) {
        IEventDAO dao = sqlSession.getMapper(IEventDAO.class);
        return dao.deleteEvent(eventId);
    }


}
