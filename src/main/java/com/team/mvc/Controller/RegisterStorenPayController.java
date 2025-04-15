package com.team.mvc.Controller;

import com.team.mvc.DTO.RegisterStorenPayDTO;
import com.team.mvc.Interface.IRegisterStorenPayDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterStorenPayController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value = "storenRegister-storage-pay.action", method = {RequestMethod.GET, RequestMethod.POST})
    public String getPay(@RequestParam("equip_code") int equip_code,
                         @RequestParam("equipSize") String equipSize,
                         @RequestParam("storageDays") int storageDays,
                         @RequestParam("storageCost") int storageCost,
                         HttpSession session,
                         Model model) {

        int userCode = (int) session.getAttribute("userCode");

        IRegisterStorenPayDAO dao = sqlSession.getMapper(IRegisterStorenPayDAO.class);
        RegisterStorenPayDTO addressInfo = dao.getUserAddressInfo(userCode);

        model.addAttribute("equip_code", equip_code);
        model.addAttribute("equipSize", equipSize);
        model.addAttribute("storageDays", storageDays);
        model.addAttribute("storageCost", storageCost);
        model.addAttribute("discountAmount", 0);
        model.addAttribute("finalPayment", storageCost);
        model.addAttribute("addressInfo", addressInfo);

        return "storenRegister-storage-pay";
    }
}
