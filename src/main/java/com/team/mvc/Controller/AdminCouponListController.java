package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminCouponListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminCouponListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-couponList.action",method= RequestMethod.GET)
    public String adminCouponList(Model model){

        IAdminCouponListDAO adminCouponListDAO = sqlSession.getMapper(IAdminCouponListDAO.class);

        try {

            model.addAttribute("getList",adminCouponListDAO.getList());
            model.addAttribute("getTypes",adminCouponListDAO.getTypes());

        }
        catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorMessage", "쿠폰 목록을 불러오는 중 오류가 발생했습니다.");
        }




        return "admin-couponList";
    }
}
