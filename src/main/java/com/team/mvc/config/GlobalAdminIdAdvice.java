package com.team.mvc.config;

import com.team.mvc.DTO.AdminDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalAdminIdAdvice {

    @ModelAttribute("adminId")
    public String populateAdminId(HttpSession session) {
        Object adminIdObj = session.getAttribute("adminId");

        if (adminIdObj instanceof String) {
            return (String) adminIdObj;
        }

        Object loginAdminObj = session.getAttribute("loginAdmin");
        if (loginAdminObj instanceof AdminDTO) {
            AdminDTO loginAdmin = (AdminDTO) loginAdminObj;
            return loginAdmin.getAdminId();
        }

        return null;
    }
}
