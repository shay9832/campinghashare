package com.team.mvc.Controller;

import com.team.mvc.DTO.RegisterStorenDTO;
import com.team.mvc.DTO.RegisterStorenPayDTO;
import com.team.mvc.Interface.IRegisterStorenDAO;
import com.team.mvc.Interface.IRegisterStorenPayDAO;
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
public class RegisterStorenPayInfoController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="storenRegister-storage-pay-info.action",method = RequestMethod.GET)
    public String storenRegisterStoragePayComplete(@RequestParam("equip_code") int equip_code,
                                                   @RequestParam("finalStorageCost") int finalStorageCost,
                                                   @ModelAttribute("userCode") Integer userCode,
                                                   Model model) {

        IRegisterStorenPayDAO payDao = sqlSession.getMapper(IRegisterStorenPayDAO.class);
        RegisterStorenPayDTO addressInfo = payDao.getUserAddressInfo(userCode);

        IRegisterStorenDAO storenDao = sqlSession.getMapper(IRegisterStorenDAO.class);
        RegisterStorenDTO equipInfo = storenDao.getEquipInfo(equip_code);

        model.addAttribute("equip_code", equip_code);
        model.addAttribute("finalStorageCost", finalStorageCost);

        return "storenRegister-storage-pay-info";
    }
}
