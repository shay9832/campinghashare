package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminDTO;
import com.team.mvc.Interface.IAdminDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private SqlSession sqlSession;

    // /admin 요청 시 로그인 상태 확인 후 분기
    @GetMapping("")
    public String handleAdminRoot(HttpSession session) {
        if (session.getAttribute("adminUser") != null) {
            return "redirect:/admin-main.action";
        } else {
            return "redirect:/admin/login-admin.action";
        }
    }

    // 로그인 페이지 출력
    @GetMapping("/login-admin.action")
    public String loginPage() {
        return "login-admin";
    }

    // 로그인 처리
    @PostMapping("/login-admin.action")
    public String login(AdminDTO dto, HttpSession session, RedirectAttributes redirect) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        AdminDTO admin = dao.getAdminByIdAndPw(dto);

        if (admin != null) {
            session.setAttribute("adminUser", admin);
            return "redirect:/admin-main.action";
        } else {
            redirect.addFlashAttribute("error", "1");
            return "redirect:/admin/login-admin.action";
        }
    }

    // 로그아웃 처리
    @GetMapping("/admin-logout.action")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login-admin.action";
    }

    // 관리자 회원가입 폼
    @GetMapping("/registeradmin-id.action")
    public String registerPage() {
        return "registerAdmin-id";
    }

    // 관리자 회원가입 처리
    @PostMapping("/insertadmin.action")
    public String insertAdmin(AdminDTO dto) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        int userCode = dao.getNextUserCode();
        dto.setUserCode(userCode);
        dao.insertAdmin(dto);
        return "redirect:/admin/login-admin.action";
    }

    // 관리자 ID 중복확인 (AJAX)
    @GetMapping("/admin-idcheck.action")
    @ResponseBody
    public String idCheck(@RequestParam("adminId") String adminId) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        int count = dao.getAdminCountById(adminId);
        return (count == 0) ? "usable" : "duplicated";
    }
}
