package com.team.mvc.config;

import com.team.mvc.DTO.UserDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalUserCodeAdvice {

    @ModelAttribute("userCode")
    public Integer populateUserCode(HttpSession session) {
        Object userCodeObj = session.getAttribute("userCode");

        // loginUser 객체에서도 userCode를 추출하는 로직 추가
        if (userCodeObj == null) {
            Object loginUserObj = session.getAttribute("loginUser");
            if (loginUserObj instanceof UserDTO) {
                UserDTO loginUser = (UserDTO) loginUserObj;
                Integer code = loginUser.getUserCode();
                // userCode 값을 세션에 다시 저장
                if (code != null) {
                    session.setAttribute("userCode", code);
                    return code;
                }
            }
        }

        if (userCodeObj instanceof Integer) {
            return (Integer) userCodeObj;
        } else if (userCodeObj instanceof String) {
            try {
                return Integer.parseInt((String) userCodeObj);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
}