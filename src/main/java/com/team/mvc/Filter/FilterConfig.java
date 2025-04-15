//package com.team.mvc.Filter;
//
//import org.springframework.boot.web.servlet.FilterRegistrationBean;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class FilterConfig {
//
//    @Bean
//    public FilterRegistrationBean<UserSessionFilter> userSessionFilter() {
//        FilterRegistrationBean<UserSessionFilter> registrationBean = new FilterRegistrationBean<>();
//
//        // 필터 클래스 등록
//        registrationBean.setFilter(new UserSessionFilter());
//
//        // 필터가 적용될 URL 패턴 지정
//        registrationBean.addUrlPatterns(
//                "/mypage-*",              // 마이페이지 관련 URL
//                "/equip-register.action", // 장비 등록 URL
//                "/diary-*"                // 캠핑일지 URL
//        );
//
//        // 필터 우선순위 설정 (낮을수록 먼저 실행)
//        registrationBean.setOrder(1);  // 우선순위 1인 필터 먼저 실행
//        return registrationBean;
//    }
//
//    @Bean
//    public FilterRegistrationBean<AdminSessionFilter> adminSessionFilter() {
//        FilterRegistrationBean<AdminSessionFilter> registrationBean = new FilterRegistrationBean<>();
//
//        // 필터 클래스 등록
//        registrationBean.setFilter(new AdminSessionFilter());
//
//        // 필터가 적용될 URL 패턴 지정
//        registrationBean.addUrlPatterns("/admin-*");  // 관리자 관련 URL에 필터 적용
//
//        // 필터 우선순위 설정 (낮을수록 먼저 실행)
//        registrationBean.setOrder(2);  // AdminSessionFilter는 두 번째로 실행됩니다.
//        return registrationBean;
//    }
//}
