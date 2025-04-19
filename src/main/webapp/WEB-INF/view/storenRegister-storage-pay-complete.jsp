<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장비 등록 완료</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<main class="main-content container">
    <div class="complete-message">
        '장비 등록'이(가) 완료되었습니다.
    </div>

    <div class="button-container" style="margin-top: 30px; text-align: center;">
        <a href="${pageContext.request.contextPath}/main.action" class="btn">메인으로</a>
        <a href="${pageContext.request.contextPath}/mypage-myequip.action" class="btn btn-primary">내가 소유한 장비</a>
    </div>
</main>

<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>
