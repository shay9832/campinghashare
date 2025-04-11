package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminEquipListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminEquipListController {
    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-equipList.action", method = RequestMethod.GET)
    public String adminEquipList(Model model) {

        IAdminEquipListDAO dao = sqlSession.getMapper(IAdminEquipListDAO.class);


        model.addAttribute("getList", dao.getList());
        model.addAttribute("getLists", dao.getLists());



        return "admin-equipList";

    }

}
