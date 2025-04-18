package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminCreateCouponController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-createCoupon.action",method = RequestMethod.GET)
    public String adminCreateCoupon(@ModelAttribute("adminId") String adminId, Model model) {


        return "admin-createCoupon";
    }
}
