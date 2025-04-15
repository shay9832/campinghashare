///**
// * 일반 사용자 세션 확인 필터
// * 로그인되지 않은 사용자가 특정 경로에 접근할 경우 로그인 페이지로 리다이렉트
// */
//
//package com.team.mvc.Filter;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//
//@Component
//public class UserSessionFilter implements Filter {
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//
//        String requestURI = httpRequest.getRequestURI();
//        HttpSession session = httpRequest.getSession(false);
//
//        // 로그인 검사 예외 URL (로그인, 회원가입, 비밀번호 재설정 등)
//        boolean isLoginRequest = requestURI.contains("/login-user")
//                || requestURI.contains("/registeruser-")
//                || requestURI.contains("/password");
//
//        // 로그인되지 않은 경우 리다이렉트
//        if (!isLoginRequest && (session == null || session.getAttribute("loginUser") == null)) {
//
//            // AJAX 요청인 경우 401 응답
//            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
//                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//                httpResponse.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
//                return;
//            } else {
//                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login-user.action");
//                return;
//            }
//        }
//
//        chain.doFilter(request, response);
//    }
//}
