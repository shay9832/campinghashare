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
        String adminId = (session != null) ? (String) session.getAttribute("adminId") : null;

        // 요청 URI 및 contextPath 추출
        String uri = httpRequest.getRequestURI();
        String ctx = httpRequest.getContextPath();

        String uriLower = uri.toLowerCase();

        // 관리자 페이지 요청 여부 판단
        boolean isAdminPage = uri.contains("admin-") || uri.contains("/admin/");

        // 로그인 페이지 제외 및 세션이 없으면 로그인 페이지로 리디렉션
        boolean isLoginPage = uri.contains("admin-login") || uri.contains("login-admin");

        // 로그인 페이지, 리소스 등 접근 제외 경로는 세션 확인 없이 진행
        boolean isExcluded = uriLower.startsWith(ctx + "/resources/") ||
                uriLower.startsWith(ctx + "/favicon.ico") ||
                uriLower.startsWith(ctx + "/admin") ||
                uriLower.startsWith(ctx + "/admin-") ||
                uriLower.startsWith(ctx + "/sitemap.action") ||
                uriLower.startsWith(ctx + "/registerAdmin-id.action") ||
                uriLower.startsWith(ctx + "/idcheck.action") ||
                uriLower.startsWith(ctx + "/nicknamecheck.action") ||
                uriLower.startsWith(ctx + "/error") ||
                uriLower.equals(ctx + "/") ||
                uriLower.equals(ctx + "/main.action");

        // 관리자 페이지인데 adminId가 없고 예외 경로도 아니면 차단
        if (isAdminPage && !isExcluded && adminId == null) {
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\":\"관리자 로그인이 필요합니다.\"}");
            } else {
                httpResponse.sendRedirect(ctx + "/admin-login.action");
            }
            return;
        }

        // 인증 통과 → 다음 필터 또는 컨트롤러로 요청 전달
        chain.doFilter(request, response);
    }
}
