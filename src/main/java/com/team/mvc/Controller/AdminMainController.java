package com.team.mvc.Controller;
import com.team.mvc.DTO.AdminDTO;
import jakarta.servlet.http.HttpSession;
import com.team.mvc.Interface.IAdminMainDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminMainController {

    // 자동 의존성 주입
    @Autowired
    private SqlSession sqlSession;

    // 관리자 메인 페이지
    @RequestMapping(value = "/admin-main.action", method = RequestMethod.GET)
    public String adminMain(HttpSession session, Model model) {
        AdminDTO loginAdmin = (AdminDTO) session.getAttribute("loginAdmin");

        if (loginAdmin == null) {
            return "redirect:/admin-login.action"; // 세션이 없으면 로그인 페이지로 리다이렉트
        }

        model.addAttribute("loginAdmin", loginAdmin);

        IAdminMainDAO dao = sqlSession.getMapper(IAdminMainDAO.class);
        model.addAttribute("count", dao.count());  // 관리자가 볼 데이터 카운트 등

        return "admin-main";  // 관리자 메인 페이지 반환
    }
}
