package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminUserReportDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminUserReportController {

    @Autowired
    private SqlSession sqlSession;


    @RequestMapping(value="/admin-userReport.action",method = RequestMethod.GET)
    public String adminUserReport(){

        IAdminUserReportDAO adminUserReportDAO = sqlSession.getMapper(IAdminUserReportDAO.class);

        return "admin-userReport";
    }
}
