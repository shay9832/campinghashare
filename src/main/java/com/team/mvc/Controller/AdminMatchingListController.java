package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminMatchingListDAO;
import org.apache.ibatis.session.SqlSession;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminMatchingListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-matchingList.action",method = RequestMethod.GET)
    public String adminMatchingList(@ModelAttribute("adminId") String adminId, Model model){

        IAdminMatchingListDAO dao = sqlSession.getMapper(IAdminMatchingListDAO.class);

        model.addAttribute("getList",dao.getList());
        model.addAttribute("getLists",dao.getLists());


        return "admin-matchingList";
    }
}
