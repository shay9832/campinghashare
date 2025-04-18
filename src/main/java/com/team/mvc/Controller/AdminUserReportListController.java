package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminUserReportListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminUserReportListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-userReportList.action",method = RequestMethod.GET)
    public String adminUserReportList(@ModelAttribute("adminId") String adminId, Model model){

        IAdminUserReportListDAO adminUserReportListDAO = sqlSession.getMapper(IAdminUserReportListDAO.class);

        return "admin-userReportList";
    }
}
