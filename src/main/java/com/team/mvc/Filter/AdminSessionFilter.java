package com.team.mvc.Filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 관리자 세션을 확인하는 필터
 * 관리자 로그인 상태가 아닌 경우 로그인 페이지로 리다이렉트
 */
@Component
public class AdminSessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 세션에서 adminId 확인
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();

        // 관리자 페이지에 대한 요청인지 확인 (admin-로 시작하는 URI)
        if (requestURI.contains("admin-")) {
            // 로그인 페이지는 예외 처리
            if (requestURI.contains("admin-login")) {
                chain.doFilter(request, response);
                return;
            }

            // 세션이 없거나 adminId가 없는 경우
            if (session == null || session.getAttribute("adminId") == null) {
                // AJAX 요청인 경우 401 응답
                if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                    httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    httpResponse.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
                    return;
                } else {
                    // 일반 요청인 경우 로그인 페이지로 리다이렉트
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin-login.action");
                    return;
                }
            }
        }

        // 세션이 유효하면 요청 계속 진행
        chain.doFilter(request, response);
    }
}