<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>login-user-passwordReset.jsp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container" style="max-width: 500px; margin: 40px auto;">
    <h2 style="text-align: center; margin-bottom: 30px;">비밀번호 재설정</h2>

    <form action="${pageContext.request.contextPath}/login-user-passwordreset.action" method="post" class="form-area">
        <div class="form-group">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" id="userId" name="userId" class="form-input" placeholder="아이디 입력" required>
        </div>

        <div class="form-group">
            <label for="userName" class="form-label">이름</label>
            <input type="text" id="userName" name="userName" class="form-input" placeholder="이름 입력" required>
        </div>

        <div class="form-group">
            <label for="userTel" class="form-label">전화번호</label>
            <input type="text" id="userTel" name="userTel" class="form-input" placeholder="전화번호 입력 (예: 010-1234-5678)" required>
        </div>

        <div class="form-group">
            <label for="newPassword" class="form-label">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="8~16자, 영문+숫자 포함" required>
        </div>

        <button type="submit" class="btn btn-primary" style="margin-top: 20px;">비밀번호 재설정</button>

        <c:if test="${resetError}">
            <p class="form-error" style="color: red; margin-top: 15px;">입력한 정보가 일치하지 않습니다. 다시 확인해 주세요.</p>
        </c:if>

        <c:if test="${resetSuccess}">
            <p class="form-success" style="color: green; margin-top: 15px;">비밀번호가 성공적으로 변경되었습니다.</p>
        </c:if>
    </form>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
