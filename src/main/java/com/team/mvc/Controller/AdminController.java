package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminMainDAO;
import com.team.mvc.DTO.AdminDTO;
import com.team.mvc.Interface.IAdminDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminController {

    @Autowired
    private SqlSession sqlSession;

    // 관리자 로그인 화면 진입 (GET)
    @RequestMapping(value = "/admin-login.action", method = RequestMethod.GET)
    public String adminLoginForm() {
        return "admin-login";
    }

    // 관리자 로그인 처리 후 리다이렉트 (admin-main.action은 AdminMainController에서 처리)
    @RequestMapping(value = "/admin-login.action", method = RequestMethod.POST)
    public String adminLogin(@RequestParam("adminId") String adminId,
                             @RequestParam("adminPw") String adminPw,
                             HttpSession session,
                             RedirectAttributes redirectAttr) {

        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        AdminDTO admin = dao.getAdminById(adminId);

        if (admin != null && adminPw != null && adminPw.equals(admin.getAdminPw())) {

            session.setAttribute("loginUser", admin);   // main.action에서도 공통 세션으로 인식되게 함
            session.setAttribute("loginAdmin", admin); // 로그인된 관리자 객체를 세션에 저장
            session.setAttribute("isAdmin", true); // 관리자인지 여부를 세션에 추가
            session.setAttribute("userCode", admin.getUserCode()); // userCode를 세션에 저장
            return "redirect:/admin-main.action";  // 관리자 메인 페이지로 리다이렉트
        } else {
            redirectAttr.addFlashAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/admin-login.action";  // 로그인 실패 시 로그인 페이지로 리디렉션
        }
    }

    // 관리자 로그아웃 처리
    @RequestMapping("/admin-logout.action")
    public String logoutAdmin(HttpSession session) {
        session.removeAttribute("loginAdmin");  // 로그인된 관리자 정보 세션에서 삭제
        session.removeAttribute("adminId"); // adminId도 세션에서 삭제

        return "redirect:/admin-login.action"; // 로그아웃 후 로그인 페이지로 리디렉션
    }

    // 관리자 회원가입 화면 진입
    @RequestMapping("/registeradmin-id.action")
    public String registerAdminId() {
        return "registerAdmin-id";
    }

    // 관리자 회원가입 처리
    @RequestMapping(value = "/insertadmin.action", method = RequestMethod.POST)
    public String insertAdmin(AdminDTO dto, Model model) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);

        if (dao.getAdminById(dto.getAdminId()) != null) {
            model.addAttribute("error", "이미 사용 중인 아이디입니다.");
            return "registerAdmin-id";
        }

        dao.insertAdmin(dto);
        return "redirect:/admin-login.action";
    }

    // 관리자 ID 중복 확인
    @RequestMapping(value = "/admin-idcheck.action", method = RequestMethod.GET)
    public String adminIdCheck(@RequestParam("adminId") String adminId, Model model) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        AdminDTO admin = dao.getAdminById(adminId);

        model.addAttribute("available", admin == null);  // 중복 여부 표시
        model.addAttribute("checkedId", adminId);  // 확인한 아이디 값
        return "admin-registerId"; // 중복 확인 후 해당 페이지로 이동
    }
}
