package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminEquipStatisticsDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminEquipStatisticsController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-equipStatistics.action",method = RequestMethod.GET)
    public String adminEquipStatistics(){

        IAdminEquipStatisticsDAO adminEquipStatisticsDAO = sqlSession.getMapper(IAdminEquipStatisticsDAO.class);

        return "admin-equipStatistics";
    }
}
