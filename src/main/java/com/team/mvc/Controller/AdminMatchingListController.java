package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminMatchingListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-matchingList.action",method = RequestMethod.GET)
    public String adminMatchingList(){
        return "admin-matchingList";
    }
}
