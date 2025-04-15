package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterStorenPayInfoController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="storenRegister-storage-pay-info.action",method = RequestMethod.GET)
    public String storenRegisterStoragePayComplete(@RequestParam("equipName") String equipName,
                                                   @RequestParam("finalPayment") int finalPayment,
                                                    Model model){

    model.addAttribute("equipName", equipName);
    model.addAttribute("finalPayment", finalPayment);



        return "storenRegister-storage-pay-info";
    }
}
