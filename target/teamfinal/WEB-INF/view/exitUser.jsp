<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<div class="withdraw-container">
    <h2>회원 탈퇴</h2>

    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>

    <p>회원 탈퇴를 위해 비밀번호를 입력해 주세요.</p>

    <form action="${pageContext.request.contextPath}/confirmAndExit.action" method="post">
        <input type="hidden" name="userId" value="${loginUser.userId}" />
        <label for="userPw">비밀번호 확인:</label>
        <input type="password" id="userPw" name="userPw" required />
        <br>
        <button type="submit">탈퇴하기</button>
        <a href="${pageContext.request.contextPath}/main.action">취소</a>
    </form>
</div>

</body>
</html>
