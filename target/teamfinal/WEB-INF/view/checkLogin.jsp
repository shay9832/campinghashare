<%
    // 세션에서 로그인 정보 확인
    Integer user_code = (Integer) session.getAttribute("user_code");

    // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    if(user_code == null) {
        response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
        return;
    }
%>
