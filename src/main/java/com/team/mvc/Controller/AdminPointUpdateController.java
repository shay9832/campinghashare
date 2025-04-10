package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminPointUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminPointUpdateController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-pointUpdate.action",method = RequestMethod.GET)
    public String adminPointUpdate(){

        IAdminPointUpdateDAO adminPointUpdateDAO = sqlSession.getMapper(IAdminPointUpdateDAO.class);

        return "admin-pointUpdate";
    }
}
