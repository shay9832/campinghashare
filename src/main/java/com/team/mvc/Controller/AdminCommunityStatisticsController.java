package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminCommunityStatisticsDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminCommunityStatisticsController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-communityStatistics.action",method= RequestMethod.GET)
    public String adminCommunityStatistics(@ModelAttribute("adminId") String adminId, Model model) {

        IAdminCommunityStatisticsDAO adminCommunityStatisticsDAO = sqlSession.getMapper(IAdminCommunityStatisticsDAO.class);

        return "admin-communityStatistics";
    }

}
