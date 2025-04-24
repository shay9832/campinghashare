package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminMainDTO;
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

        // 신고리스트에서 신고게시글 불러오기
        List<AdminUserReportDTO> reportDTO = adminAllService.getList();
        // 세션에서 관리자 정보 가져오기
//        AdminDTO loginAdmin = (AdminDTO) session.getAttribute("loginAdmin");

        // 메인페이지 대시보드에 들어갈 각 통계값 불러오기
        AdminMainDTO mainDTO = adminAllService.count();



        model.addAttribute("main", mainDTO);
        model.addAttribute("report", reportDTO);
//        model.addAttribute("admin", loginAdmin);  // 추가된 부분

        return "admin-main";
    }
}
