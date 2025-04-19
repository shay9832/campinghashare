package com.team.mvc.config;

import com.team.mvc.DTO.UserDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalUserCodeAdvice {

    @ModelAttribute("isUser")
    public boolean isUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        return (loginUser instanceof UserDTO);
    }

    @ModelAttribute("userCode")
    public Integer populateUserCode(HttpSession session) {
        // 세션에서 'userCode' 값을 직접 확인
        Object userCodeObj = session.getAttribute("userCode");

        // 'userCode'가 세션에 없으면, 'loginUser' 객체에서 'userCode'를 추출하여 반환
        if (userCodeObj == null) {
            Object loginUserObj = session.getAttribute("loginUser");
            if (loginUserObj instanceof UserDTO) {
                UserDTO loginUser = (UserDTO) loginUserObj;
                Integer code = loginUser.getUserCode();

                // 'userCode' 값을 세션에 저장하고 반환
                if (code != null) {
                    // 세션에 중복 저장 방지: 이미 존재하면 재저장하지 않음
                    if (session.getAttribute("userCode") == null) {
                        session.setAttribute("userCode", code);
                    }
                    return code;
                }
            }
        }

        // 'userCode' 값이 세션에 있을 경우 바로 반환
        if (userCodeObj instanceof Integer) {
            return (Integer) userCodeObj;
        } else if (userCodeObj instanceof String) {
            try {
                return Integer.parseInt((String) userCodeObj);
            } catch (NumberFormatException e) {
                return null;  // 숫자로 변환할 수 없으면 null 반환
            }
        }

        return null; // 'userCode'가 없으면 null 반환
    }
}
