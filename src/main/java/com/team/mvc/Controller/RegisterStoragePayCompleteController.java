package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;


@Controller
public class RegisterStoragePayCompleteController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="storenRegister-storage-pay-complete.action",method = RequestMethod.GET)
    public String storenRegisterStoragePayComplete(@RequestParam("equipName") String equipName,
                                                   @ModelAttribute("userCode") Integer userCode,
                                                   Model model) {

        model.addAttribute("equipName", equipName);
        model.addAttribute("userCode", userCode);

        return "storenRegister-storage-pay-complete";
    }
}
