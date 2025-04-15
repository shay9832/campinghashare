package com.team.mvc.Controller;

import com.team.mvc.DTO.RegisterStorenDTO;
import com.team.mvc.Interface.IRegisterStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class RegisterStorenController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value ="/storenRegister-storage-info.action", method = RequestMethod.GET)
    public String getEquipInfo(@RequestParam("equip_code") int equipCode,
                               Model model) {
        IRegisterStorenDAO dao = sqlSession.getMapper(IRegisterStorenDAO.class);
        RegisterStorenDTO dto = dao.getEquipInfo(equipCode);

        model.addAttribute("equipInfo", dto);

        return "storenRegister-storage-info";
    }
}
