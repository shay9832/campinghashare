package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminUserDropDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class AdminUserDropController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-userDrop.action",method = RequestMethod.GET)
    public String adminUserDrop(@ModelAttribute("adminId") String adminId, Model model){

        IAdminUserDropDAO adminUserDropDAO = sqlSession.getMapper(IAdminUserDropDAO.class);

        return "admin-userDrop";
    }
}
