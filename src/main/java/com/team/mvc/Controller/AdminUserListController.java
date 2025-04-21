package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminUserListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminUserListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-userList.action",method = RequestMethod.GET)
    public String adminUserList(Model model){

        IAdminUserListDAO dao = sqlSession.getMapper(IAdminUserListDAO.class);

        model.addAttribute("getList",dao.getList());


        return "admin-userList";
    }
}
