package com.team.mvc.Controller;

import com.team.mvc.Interface.IRegisterStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RegisterStorenController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value ="/Equip", method = RequestMethod.GET)
    public String categoryList(Model model) {
        IRegisterStorenDAO dao = sqlSession.getMapper(IRegisterStorenDAO.class);

        model.addAttribute("list",dao.list());

        return "Equip";
    }
}
