package com.team.mvc.Service;

import com.team.mvc.DTO.NotificationDTO;
import com.team.mvc.Interface.INotificationDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationService {

    @Autowired
    private SqlSession sqlSession;

    // 알림 목록 조회 (최근 7일 이내)
    public List<NotificationDTO> getNotificationsByUserCode(int userCode) {
        INotificationDAO dao = sqlSession.getMapper(INotificationDAO.class);
        return dao.getNotificationsByUserCode(userCode);  // 알림 목록 조회
    }

    // 전체 알림 읽음 처리
    public void markAllAsRead(int userCode) {
        INotificationDAO dao = sqlSession.getMapper(INotificationDAO.class);
        dao.insertReadLogForAll(userCode);  // 전체 읽음 처리 로그 삽입
    }
}
