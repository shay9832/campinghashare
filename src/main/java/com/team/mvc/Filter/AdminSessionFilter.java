package com.team.mvc.Filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.springframework.stereotype.Component;
import java.io.IOException;

/**
 * 관리자 로그인 여부를 확인하는 필터 클래스
 * - /admin- 또는 /admin/ 으로 시작하는 요청에 대해 관리자 세션 존재 여부를 체크함
 * - 세션에 adminId가 없으면 로그인 페이지로 리다이렉트하거나 401 응답 반환
 */
@Component
public class AdminSessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 세션에서 adminId 값 추출
        HttpSession session = httpRequest.getSession(false);
        String adminId = null;

        if (session != null) {
            // 세션에서 adminId 가져오기
            adminId = (String) session.getAttribute("adminId");
        }

        // 요청 URI 및 contextPath 추출
        String uri = httpRequest.getRequestURI();
        String ctx = httpRequest.getContextPath();

        // 관리자 페이지 요청 여부 판단
        boolean isAdminPage = uri.contains("admin-") || uri.contains("/admin/");

        // 로그인 페이지 제외 및 세션이 없으면 로그인 페이지로 리디렉션
        boolean isLoginPage = uri.contains("admin-login") || uri.contains("login-admin");

        // 관리자가 아닌 경우에 관리자 페이지 접근을 막음
        if (isAdminPage && !isLoginPage && adminId == null) {
            // AJAX 요청이면 401 응답
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
                return;
            } else {
                // 관리자 로그인 페이지로 리디렉션
                httpResponse.sendRedirect(ctx + "/admin-login.action");
                return;
            }
        }

        // 로그인 페이지, 리소스 등 접근 제외 경로는 세션 확인 없이 진행
        boolean isExcluded = uri.startsWith(ctx + "/resources/") ||
                uri.startsWith(ctx + "/favicon.ico") ||
                uri.startsWith(ctx + "/login-user") ||
                uri.startsWith(ctx + "/logout") ||
                uri.startsWith(ctx + "/registeruser-") ||
                uri.startsWith(ctx + "/idcheck.action") ||
                uri.startsWith(ctx + "/nicknamecheck.action") ||
                uri.startsWith(ctx + "/oauth/");

        if (!isExcluded && session.getAttribute("loginUser") == null) {
            // 로그인되지 않은 사용자가 로그인 필요 페이지에 접근할 때
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
                return;
            } else {
                httpResponse.sendRedirect(ctx + "/login-user.action");
                return;
            }
        }

        // 인증 통과 → 다음 필터 또는 컨트롤러로 요청 전달
        chain.doFilter(request, response);
    }
}
