package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminUserReportDTO;
import com.team.mvc.Interface.IAdminAllService;
import com.team.mvc.Interface.IAdminMainDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class AdminMainController {

    // 자동 의존성 주입
    @Autowired
    private IAdminAllService adminAllService;

    @RequestMapping(value = "/admin-main.action", method = RequestMethod.GET)
    public String adminMain(Model model) {


        List<AdminUserReportDTO> reportDTO = adminAllService.getList();

        model.addAttribute("report", reportDTO);

        return "admin-main";
    }
}
