package com.team.mvc.Filter;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.nio.charset.Charset;

public class UserSessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String uri = httpRequest.getRequestURI();
        String ctx = httpRequest.getContextPath();

        // 로그인 없이 접근 가능한 경로 정리 (정적 리소스 + 공용 페이지 + admin 전용)
        boolean isExcluded = uri.startsWith(ctx + "/resources/") ||
                uri.startsWith(ctx + "/favicon.ico") ||
                uri.startsWith(ctx + "/login-user") ||
                uri.startsWith(ctx + "/logout") ||
                uri.startsWith(ctx + "/registeruser-") ||
                uri.startsWith(ctx + "/idcheck.action") ||
                uri.startsWith(ctx + "/nicknamecheck.action") ||
                uri.startsWith(ctx + "/oauth/") ||
                uri.startsWith(ctx + "/board") ||
                uri.startsWith(ctx + "/event.action") ||
                uri.startsWith(ctx + "/notice.action") ||
                uri.startsWith(ctx + "/inspec-result.action") ||
                uri.startsWith(ctx + "/rentalsearch-main.action") ||
                uri.startsWith(ctx + "/storenmatching-request.action") ||
                uri.startsWith(ctx + "/api/storen/check-matching-status") ||
                uri.startsWith(ctx + "/api/") ||
                uri.startsWith(ctx + "/get") ||
                uri.startsWith(ctx + "/error") ||
                uri.startsWith(ctx + "/admin") ||
                uri.contains("/main.action") ||
                uri.equals("/main.action");

        if (!isExcluded &&
                (session == null ||
                        (session.getAttribute("loginUser") == null && session.getAttribute("loginAdmin") == null))) {

            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
                return;
            } else {
                httpResponse.sendRedirect(ctx + "/login-user.action");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
