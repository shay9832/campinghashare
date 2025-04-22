package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminCreateCouponDTO;
import com.team.mvc.Interface.IAdminCreateCouponDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminCreateCouponController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-createCoupon.action",method = RequestMethod.GET)
    public String adminCreateCoupon(@RequestParam(value="couponName",required = false) String couponName,
                                    @RequestParam(value="couponDiscount",required = false) Integer couponDiscount,
                                    @RequestParam(value="couponMonth",required = false) String couponMonth,
                                    AdminCreateCouponDTO dto,
                                    Model model){


        IAdminCreateCouponDAO dao = sqlSession.getMapper(IAdminCreateCouponDAO.class);


        dto.setCouponName(couponName);
        dto.setCouponDiscount(couponDiscount);
        dto.setCouponMonth(couponMonth);




        return "admin-createCoupon";
    }
}
