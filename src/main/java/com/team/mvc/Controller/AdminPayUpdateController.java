package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminPayUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminPayUpdateController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-payUpdate.action",method = RequestMethod.GET)
    public String adminPayUpdate(){

        IAdminPayUpdateDAO adminPayUpdateDAO = sqlSession.getMapper(IAdminPayUpdateDAO.class);



        return "admin-payUpdate";
    }
}
