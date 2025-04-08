package com.team.mvc;

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
        return "admin-payUpdate";
    }
}
