package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminEventUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminEventUpdateController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-eventUpdate.action",method = RequestMethod.GET)
    public String adminEventUpdate(){

        IAdminEventUpdateDAO adminEventUpdateDAO = sqlSession.getMapper(IAdminEventUpdateDAO.class);

        return "admin-eventUpdate";
    }
}
