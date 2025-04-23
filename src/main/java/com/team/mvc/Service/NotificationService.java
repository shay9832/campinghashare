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

    public List<NotificationDTO> getNotificationsByUserCode(int userCode) {
        INotificationDAO dao = sqlSession.getMapper(INotificationDAO.class);
        return dao.getNotificationsByUserCode(userCode);
    }

    public void markAllAsRead(int userCode) {
        INotificationDAO dao = sqlSession.getMapper(INotificationDAO.class);
        dao.insertReadLogForAll(userCode);
    }
}
