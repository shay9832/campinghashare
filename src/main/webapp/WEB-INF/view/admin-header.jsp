<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>admin-header.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="icon" href="<c:url value='/favicon.ico' />" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
</head>
<body>

<!-- 상단 고정 헤더 영역 -->
<div id="header" style="position: sticky; top: 0; z-index: 999; background-color: #3f861d; padding: 15px; display: flex; justify-content: space-between; align-items: center; width: 100%; box-sizing: border-box;">
    <!-- 좌측: 제목 링크 -->
    <h1 style="margin: 0;">
        <a href="${pageContext.request.contextPath}/admin-main.action" style="color: white; text-decoration: none; font-weight: bold; font-size: 24px;">
            관리자 시스템
        </a>
    </h1>

    <!-- 우측: 로그인 정보 및 로그아웃 버튼 -->
    <div style="display: flex; gap: 10px; align-items: center;">
        <c:choose>
            <c:when test="${not empty sessionScope.loginAdmin}">
                <span style="color: var(--color-white); font-weight: bold; font-size: 13px;">
                    ${sessionScope.loginAdmin.adminId} 관리자님
                </span>
                <form action="${pageContext.request.contextPath}/admin-logout.action" method="get" style="margin: 0;">
                    <button type="submit" style="padding: 6px 12px; background-color: #ffffff; color: #3f861d; border: none; border-radius: 4px; font-size: 13px; font-weight: bold; cursor: pointer;">
                        로그아웃
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/main.action" method="get" style="margin: 0;">
                    <button type="submit" style="padding: 6px 12px; background-color: #435d3a; color: white; border: none; border-radius: 4px; font-size: 13px; font-weight: bold; cursor: pointer;">
                        유저페이지
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <span>세션에 관리자 정보가 없습니다.</span>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
