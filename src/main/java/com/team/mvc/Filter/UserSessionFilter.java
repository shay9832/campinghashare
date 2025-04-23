package com.team.mvc.Filter;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class UserSessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 응답 인코딩 설정
        httpRequest.setCharacterEncoding("UTF-8");
        httpResponse.setCharacterEncoding("UTF-8");

        String uri = httpRequest.getRequestURI();
        String ctx = httpRequest.getContextPath();
        String uriLower = uri.toLowerCase();

        // 로그인 없이 접근 가능한 경로 정리
        boolean isExcluded = uriLower.startsWith(ctx + "/resources/") ||
                uriLower.startsWith(ctx + "/favicon.ico") ||
                uriLower.startsWith(ctx + "/login-user") ||
                uriLower.startsWith(ctx + "/logout") ||
                uriLower.startsWith(ctx + "/sitemap.action") ||
                uriLower.startsWith(ctx + "/registeruser-tel.action") ||
                uriLower.startsWith(ctx + "/registeruser-tel-verify.action") ||
                uriLower.startsWith(ctx + "/user-exists-check.action") ||
                uriLower.startsWith(ctx + "/registeruser-id.action") ||
                uriLower.startsWith(ctx + "/user-idcheck.action") ||
                uriLower.startsWith(ctx + "/user-nicknamecheck.action") ||
                uriLower.startsWith(ctx + "/insertuser.action") ||
                uriLower.startsWith(ctx + "/boardmain.action") ||
                uriLower.startsWith(ctx + "/error") ||
                uriLower.startsWith(ctx + "/admin") ||
                uriLower.startsWith(ctx + "/admin-") ||
                uriLower.contains("/admin-registerid.action") ||
                uriLower.contains("/insertadmin.action") ||
                uriLower.equals(ctx + "/") ||
                uriLower.equals(ctx + "/main.action");


        // 세션 체크
        HttpSession session = httpRequest.getSession(false);

        if (!isExcluded &&
                (session == null ||
                        (session.getAttribute("loginUser") == null && session.getAttribute("loginAdmin") == null))) {

            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.setContentType("application/json;charset=UTF-8");

                PrintWriter writer = httpResponse.getWriter();
                writer.write("{\"error\":\"로그인이 필요합니다.\"}");
                writer.flush();
                return;
            } else {
                httpResponse.sendRedirect(ctx + "/login-user.action");
                return;
            }
        }

        // 필터 통과
        chain.doFilter(request, response);
    }

}