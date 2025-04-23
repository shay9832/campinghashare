package com.team.mvc.Controller;

import com.team.mvc.DTO.NotificationDTO;
import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.INotificationDAO;
import com.team.mvc.Service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class NotificationController {

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private NotificationService notificationService;

    @RequestMapping("/noti.action")
    public String getNotifications(HttpSession session, Model model) {
        Integer userCode = (Integer) session.getAttribute("userCode");

        if (userCode != null) {
            List<NotificationDTO> notiList = notificationService.getNotificationsByUserCode(userCode);
            model.addAttribute("notiList", notiList);
        }

        return "notification";
    }

    @PostMapping("/noti-read.action")
    @ResponseBody
    public String readAllNotifications(HttpSession session) {
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        if (loginUser != null) {
            int userCode = loginUser.getUserCode();
            notificationService.markAllAsRead(userCode);
            return "success";
        }
        return "fail";
    }
}
