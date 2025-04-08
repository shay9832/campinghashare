package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminInspectListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminInspectListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-inspectList.action",method = RequestMethod.GET)
    public String adminInspectList(Model model) {

        IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

        model.addAttribute("list",dao.list());

        return "admin-inspectList";

    }
}
