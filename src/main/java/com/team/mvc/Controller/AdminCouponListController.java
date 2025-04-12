package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminCouponListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminCouponListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-couponList.action",method= RequestMethod.GET)
    public String adminCouponList(){

        IAdminCouponListDAO adminCouponListDAO = sqlSession.getMapper(IAdminCouponListDAO.class);

        return "admin-couponList";
    }
}
