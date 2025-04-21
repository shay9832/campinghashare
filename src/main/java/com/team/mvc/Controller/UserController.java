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
import java.nio.charset.StandardCharsets;
import jakarta.servlet.http.HttpServletResponse;

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

    @RequestMapping(value = "/user-exists-check.action", method = RequestMethod.GET)
    @ResponseBody
    public String checkUserExists(@RequestParam("userName") String userName,
                                  @RequestParam("userTel") String userTel) {

        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
        int count = dao.getUserCountByNameTel(userName, userTel);  // 이름과 전화번호 중복 확인

        String result = (count > 0) ? "EXISTS" : "AVAILABLE";

        return result;
    }

    // PASS 인증 완료 → 이름/전화번호 세션에 저장하고 리다이렉트
    @RequestMapping(value = "/registeruser-tel-verify.action", method = RequestMethod.POST)
    public String verifyUser(@RequestParam("userName") String userName,
                             @RequestParam("userTel") String userTel,
                             HttpSession session) {
        // 세션에 사용자 정보 저장
        session.setAttribute("tempUserName", userName);
        session.setAttribute("tempUserTel", userTel);
        return "redirect:/registeruser-id.action";
    }

    // 회원가입 ID/Nickname 입력 페이지
    @RequestMapping(value = "/registeruser-id.action", method = RequestMethod.GET)
    public String registerUserIdPage(HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기
        String userName = (String) session.getAttribute("tempUserName");
        String userTel = (String) session.getAttribute("tempUserTel");

        // 세션에 정보가 없으면 첫 단계로 리다이렉트
        if (userName == null || userTel == null) {
            return "redirect:/registeruser-tel.action";
        }

        model.addAttribute("userName", userName);
        model.addAttribute("userTel", userTel);

        return "registerUser-id";
    }

    // 회원 정보 저장 처리
    @RequestMapping(value = "/insertUser.action", method = RequestMethod.POST)
    public String insertUser(UserDTO dto, HttpSession session, RedirectAttributes redirect) {
        // 세션에서 이름과 전화번호 가져오기
        String userName = (String) session.getAttribute("tempUserName");
        String userTel = (String) session.getAttribute("tempUserTel");

        // 세션에 정보가 없으면 첫 단계로 리다이렉트
        if (userName == null || userTel == null) {
            redirect.addFlashAttribute("error", "세션이 만료되었습니다. 다시 시도해주세요.");
            return "redirect:/registeruser-tel.action";
        }

        // DTO에 세션 정보 설정
        dto.setUserName(userName);
        dto.setUserTel(userTel);

        IUserDAO dao = sqlSession.getMapper(IUserDAO.class);

        try {
            // 시퀀스를 통해 USER_CODE 채번
            int userCode = dao.getNextUserCode();
            dto.setUserCode(userCode);

            // USER_CODE 테이블에 먼저 등록
            dao.insertUserCode(userCode);

            // USERS 테이블 등록
            dao.insertUser(dto);

            // NICKNAME_LOG 테이블 등록
            dao.insertNicknameLog(dto);

            // 회원가입 완료 후 세션에서 임시 정보 제거
            session.removeAttribute("tempUserName");
            session.removeAttribute("tempUserTel");

            // 회원가입 성공 메시지 전달 (String 타입으로 변경)
            redirect.addFlashAttribute("registerSuccess", "true");

            return "redirect:/login-user.action";

        } catch (Exception e) {
            e.printStackTrace();
            redirect.addFlashAttribute("error", "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "redirect:/registeruser-id.action";
        }
    }

    // 아이디 중복 확인 (AJAX)
    @RequestMapping(value = "/user-idcheck.action", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String checkUserId(@RequestParam("userId") String userId, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        try {
            IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
            int count = dao.getUserCountById(userId);

            String result = (count == 0) ? "사용 가능한 아이디입니다." : "중복된 아이디입니다.";
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }

    // 닉네임 중복 확인 (AJAX)
    @RequestMapping(value = "/user-nicknamecheck.action", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String checkNickname(@RequestParam("nickname") String nickname, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        try {
            IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
            int count = dao.getUserCountByNickname(nickname);

            String result = (count == 0) ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다.";
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
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
            redirect.addFlashAttribute("resetSuccess", "true");
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