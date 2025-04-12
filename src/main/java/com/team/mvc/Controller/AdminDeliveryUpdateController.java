package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminDeliveryUpdateController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-deliveryUpdate.action",method = RequestMethod.GET)
    public String adminDeliveryUpdate(){
        return "admin-deliveryUpdate";
    }
}
