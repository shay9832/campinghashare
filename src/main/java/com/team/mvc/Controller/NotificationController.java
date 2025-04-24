package com.team.mvc.Controller;

import com.team.mvc.DTO.NotificationDTO;
import com.team.mvc.Interface.INotificationDAO;
import org.apache.ibatis.session.SqlSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

@Controller
public class NotificationController {

    @Autowired
    private SqlSession sqlSession;  // SqlSession을 자동 주입

    // 알림 목록 페이지 요청 (JSP로 전달)
    @RequestMapping("/noti.action")
    public String showNotifications(HttpSession session, Model model) {
        Integer userCode = (Integer) session.getAttribute("userCode");

        if (userCode != null) {
            INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);  // SqlSession을 통해 DAO 얻기
            List<NotificationDTO> list = notificationDAO.getRecentNotifications(userCode);
            model.addAttribute("notificationList", list);
        }

        return "notification"; // /WEB-INF/view/notification.jsp
    }

    // 읽지 않은 알림 수 반환 (AJAX)
    @ResponseBody
    @GetMapping("/noti/count.action")
    public int getUnreadCount(HttpSession session) {
        Integer userCode = (Integer) session.getAttribute("userCode");
        if (userCode != null) {
            INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);  // SqlSession을 통해 DAO 얻기
            return notificationDAO.getUnreadNotificationCount(userCode);
        }
        return 0;
    }

    // 알림 전체 읽음 처리 (AJAX)
    @ResponseBody
    @PostMapping("/noti/readall.action")
    public int readAllNotifications(HttpSession session) {
        Integer userCode = (Integer) session.getAttribute("userCode");
        if (userCode != null) {
            INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);  // SqlSession을 통해 DAO 얻기
            return notificationDAO.markAllNotificationsAsRead(userCode);
        }
        return 0;
    }
}