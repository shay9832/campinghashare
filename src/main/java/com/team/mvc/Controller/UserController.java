package com.team.mvc.Controller;

import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private SqlSession sqlSession;

    // 로그인 페이지 요청
    @RequestMapping(value = "/login-user.action", method = RequestMethod.GET)
    public String loginPage() {
        return "login-user";
    }

    // 로그인 처리 (유저 코드 포함)
    @RequestMapping(value = "/login-user.action", method = RequestMethod.POST)
    public String login(UserDTO dto, HttpSession session, RedirectAttributes redirect) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        UserDTO loginUser = dao.login(dto);

        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            session.setAttribute("userCode", loginUser.getUserCode());
            return "redirect:/main.action";
        } else {
            redirect.addAttribute("error", "1");
            return "redirect:/login-user.action";
        }
    }

    // 메인 페이지 - 회원/비회원 모두 접근 가능
    @RequestMapping(value = "/main.action", method = RequestMethod.GET)
    public String mainPage() {
        return "main"; // JSP 내부(header 포함)에서 sessionScope.loginUser로 분기
    }

    // 로그아웃 처리
    @RequestMapping(value = "/logout.action", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main.action";
    }

    // 회원가입 폼 진입
    @RequestMapping(value = "/registeruser-tel.action", method = RequestMethod.GET)
    public String registerTelPage() {
        return "registerUser-tel";
    }

    // PASS 인증 후 → 이름/전화번호
    // FlashAttribute로 전달
    @RequestMapping(value = "/registeruser-tel-verify.action", method = RequestMethod.POST)
    public String verifyUser(@RequestParam("userName") String userName,
                             @RequestParam("userTel") String userTel,
                             RedirectAttributes redirect) {
        redirect.addFlashAttribute("userName", userName);
        redirect.addFlashAttribute("userTel", userTel);
        return "redirect:/registeruser-tel.action";
    }

    // 다음 단계
    @RequestMapping(value = "/registeruser-id.action", method = RequestMethod.GET)
    public String registerUserIdPage() {
        return "registerUser-id";
    }

    // 회원가입 완료 처리
    @RequestMapping(value = "/register.action", method = RequestMethod.POST)
    public String register(UserDTO dto) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);

        int userCode = dao.getNextUserCode();
        dto.setUserCode(userCode);

        dao.register(dto);
        dao.insertNicknameLog(dto);

        return "redirect:/login-user.action";
    }

    // 아이디 중복 확인 (AJAX)
    @RequestMapping(value = "/idcheck.action", method = RequestMethod.GET)
    @ResponseBody
    public String idCheck(@RequestParam("userId") String userId) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int count = dao.idCheck(userId);
        return (count == 0) ? "usable" : "duplicated";
    }

    // 닉네임 중복 확인 (AJAX)
    @RequestMapping(value = "/nicknamecheck.action", method = RequestMethod.GET)
    @ResponseBody
    public String nicknameCheck(@RequestParam("nickname") String nickname) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int count = dao.nicknameCheck(nickname);
        return (count == 0) ? "usable" : "duplicated";
    }

    // 비밀번호 재설정 페이지
    @RequestMapping(value = "/login-user-passwordreset.action", method = RequestMethod.GET)
    public String passwordResetPage() {
        return "login-user-passwordReset";
    }

    // 비밀번호 재설정 처리
    @RequestMapping(value = "/login-user-passwordreset.action", method = RequestMethod.POST)
    public String resetPassword(@RequestParam("userId") String userId,
                                @RequestParam("userName") String userName,
                                @RequestParam("userTel") String userTel,
                                @RequestParam("newPassword") String newPassword,
                                RedirectAttributes redirect) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int verified = dao.verifyUser(userId, userName, userTel);

        if (verified == 1) {
            dao.updatePassword(userId, newPassword);
            redirect.addFlashAttribute("resetSuccess", true);
            return "redirect:/login-user.action";
        } else {
            redirect.addFlashAttribute("resetError", true);
            return "redirect:/login-user-passwordreset.action";
        }
    }

    // 마이페이지
    @RequestMapping("/mypage-main.action")
    public String myPage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login-user.action";
        }
        return "mypage-main";
    }

    // 장비 등록
    @RequestMapping("/equip-register.action")
    public String registerEquipPage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login-user.action";
        }
        return "equipRegister";
    }

    // 알림
    @RequestMapping("/notifications.action")
    public String notifications(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login-user.action";
        }
        return "notifications";
    }

    // 캠핑일지
    @RequestMapping("/mypage-diary.action")
    public String campingLog(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login-user.action";
        }
        return "mypageDiary";
    }
}
