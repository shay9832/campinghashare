package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminMainDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminMainController {

    // 자동 의존성 주입
    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value = "/admin-main.action", method = RequestMethod.GET)
    public String adminMain(Model model) {

        IAdminMainDAO dao = sqlSession.getMapper(IAdminMainDAO.class);

        model.addAttribute("count",dao.count());
        return "admin-main";
    }
}
