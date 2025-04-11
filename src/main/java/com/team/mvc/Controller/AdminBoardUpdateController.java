package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminBoardUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminBoardUpdateController {
    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-boardUpdate.action",method = RequestMethod.GET)
    public String adminBoardUpdate(){

        IAdminBoardUpdateDAO dao = sqlSession.getMapper(IAdminBoardUpdateDAO.class);
        return "admin-boardUpdate";
    }
}
