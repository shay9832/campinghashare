package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminCommunityStatisticsDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminCommunityStatisticsController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-communityStatistics.action",method= RequestMethod.GET)
    public String adminCommunityStatistics(){

        IAdminCommunityStatisticsDAO adminCommunityStatisticsDAO = sqlSession.getMapper(IAdminCommunityStatisticsDAO.class);

        return "admin-communityStatistics";
    }

}
