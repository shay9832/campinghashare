<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

</head>
<body>
<jsp:include page="header.jsp" />

<div class="container container-wide mypage-container section">
    <jsp:include page="mypage-sidebar.jsp" />
    <div class="mypage-main-content">

        <div class="container">
            <h2>회원 탈퇴</h2>

            <form method="post" action="${pageContext.request.contextPath}/mypage-exituser.action">
                <div>
                    <label for="userId">아이디</label>
                    <input type="text" name="userId" id="userId" required>
                </div>
                <div>
                    <label for="userPw">비밀번호</label>
                    <input type="password" name="userPw" id="userPw" required>
                </div>
                <div>
                    <button type="submit">탈퇴하기</button>
                </div>
            </form>

            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>

            <script>
                <c:if test="${exitSuccess}">
                alert("탈퇴 완료되었습니다.");
                window.location.href = "${pageContext.request.contextPath}/main.action";
                </c:if>
            </script>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />

</body>
</html>
