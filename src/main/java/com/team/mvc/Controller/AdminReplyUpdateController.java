package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminReplyUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminReplyUpdateController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-replyUpdate.action",method = RequestMethod.GET)
    public String adminReplyUpdate(){

        IAdminReplyUpdateDAO adminReplyUpdateDAO = sqlSession.getMapper(IAdminReplyUpdateDAO.class);

        return "admin-replyUpdate";
    }
}
