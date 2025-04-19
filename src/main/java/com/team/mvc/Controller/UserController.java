package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminDTO;
import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;

@Controller
public class UserController {

    @Autowired
    private SqlSession sqlSession;

    // 서버 재시작 시 최초 페이지 설정
    @RequestMapping("/")
    public String rootRedirect() {
        return "redirect:/main.action";
    }

    // 로그인 페이지 진입
    @RequestMapping(value = "/login-user.action", method = RequestMethod.GET)
    public String loginPage() {
        return "login-user";
    }

    // 로그인 처리
    @RequestMapping(value = "/login-user.action", method = RequestMethod.POST)
    public String login(UserDTO dto, HttpSession session, RedirectAttributes redirect) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        UserDTO loginUser = dao.getUserByIdAndPw(dto);

        if (loginUser != null) {
            if (loginUser.getUserCode() != null) {
                // 로그인 성공 시 관리자 여부 설정
                if ("admin".equals(loginUser.getUserId())) {
                    loginUser.setAdmin(true);  // 관리자인 경우
                } else {
                    loginUser.setAdmin(false); // 관리자가 아닌 경우
                }

                // 세션에 로그인 사용자 정보 저장
                session.setAttribute("loginUser", loginUser);
                session.setAttribute("userCode", loginUser.getUserCode());

                redirect.addFlashAttribute("userCode", loginUser.getUserCode());
                return "redirect:/main.action";
            } else {
                redirect.addAttribute("error", "2");
                return "redirect:/login-user.action";
            }
        } else {
            redirect.addAttribute("error", "1");
            return "redirect:/login-user.action";
        }
    }

    // 메인 페이지 진입
    @RequestMapping("/main.action")
    public String mainPage(HttpSession session, Model model) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginAdmin = session.getAttribute("loginAdmin");

        if (loginUser instanceof UserDTO) {
            model.addAttribute("user", (UserDTO) loginUser);
        } else if (loginAdmin instanceof AdminDTO) {
            model.addAttribute("admin", (AdminDTO) loginAdmin);
        }

        // 로그인 안 된 상태라도 return "main" 허용
        return "main";
    }

    // 로그아웃 처리
    @RequestMapping(value = "/logout.action", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/main.action";
    }

    // 회원가입 첫 단계 - PASS 인증 후 이름, 전화번호 받는 페이지
    @RequestMapping(value = "/registeruser-tel.action", method = RequestMethod.GET)
    public String registerTelPage() {
        return "registerUser-tel";
    }

    // PASS 인증 완료 → 이름/전화번호 FlashAttribute로 다음 페이지 전달
    @RequestMapping(value = "/registeruser-tel-verify.action", method = RequestMethod.POST)
    public String verifyUser(@RequestParam("userName") String userName,
                             @RequestParam("userTel") String userTel,
                             RedirectAttributes redirect) {
        redirect.addFlashAttribute("userName", userName);
        redirect.addFlashAttribute("userTel", userTel);
        return "redirect:/registerUser-tel.action";
    }

    // 회원가입 ID/Nickname 입력 페이지
    @RequestMapping(value = "/registeruser-id.action", method = RequestMethod.GET)
    public String registerUserIdPage() {
        return "registerUser-id";
    }

    // 회원 정보 저장 처리
    @RequestMapping(value = "/insertUser.action", method = RequestMethod.POST)
    public String insertUser(UserDTO dto) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);

        // 시퀀스를 통해 USER_CODE 채번
        int userCode = dao.getNextUserCode();
        dto.setUserCode(userCode);

        dao.insertUser(dto);          // USERS 테이블 등록
        dao.insertNicknameLog(dto);  // NICKNAME_LOG 테이블 등록

        return "redirect:/login-user.action";
    }

    // 아이디 중복 확인 (AJAX)
    @RequestMapping(value = "/idcheck.action", method = RequestMethod.GET)
    @ResponseBody
    public String idCheck(@RequestParam("userId") String userId) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int count = dao.getUserCountById(userId);
        return (count == 0) ? "usable" : "duplicated";
    }

    // 닉네임 중복 확인 (AJAX)
    @RequestMapping(value = "/nicknamecheck.action", method = RequestMethod.GET)
    @ResponseBody
    public String nicknameCheck(@RequestParam("nickname") String nickname) {
        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int count = dao.getNicknameCount(nickname);
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
        int verified = dao.getUserCountByIdNameTel(userId, userName, userTel);

        if (verified == 1) {
            dao.updateUserPassword(userId, newPassword);
            redirect.addFlashAttribute("resetSuccess", true);
            return "redirect:/login-user.action";
        } else {
            redirect.addFlashAttribute("resetError", true);
            return "redirect:/login-user-passwordreset.action";
        }
    }

    // 장비 등록 페이지 접근 시 로그인 체크
    @RequestMapping("/equip-register.action")
    public String registerEquipPage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login-user.action";
        }
        return "equipRegister";
    }
}
