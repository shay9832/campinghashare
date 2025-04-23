<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>관리자 로그인</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        .login-container {
            max-width: 480px;
            margin: 20px auto;
            padding: 0;
        }

        .login-logo {
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .login-logo img {
            width: 90px;
            height: 60px;
            margin-bottom: 20px;
        }

        .login-title {
            font-size: var(--font-lg);
            font-weight: var(--font-bold);
            color: var(--color-maple);
        }

        .login-input {
            width: 100%;
            max-width: 320px;
            height: 35px;
            padding: 0 12px;
            margin: 0 auto 10px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-sm);
            display: block;
        }

        .login-input::placeholder {
            font-size: var(--font-sm);
            font-family: inherit;
            color: var(--text-secondary);
            opacity: 1;
        }

        .login-button {
            width: 100%;
            max-width: 320px;
            height: 35px;
            padding: 0;
            background-color: #3f861d;
            color: white;
            border: none;
            border-radius: var(--radius-sm);
            font-size: var(--font-md);
            cursor: pointer;
            margin: 0 auto 10px;
            display: block;
        }

        .login-options {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0;
            font-size: var(--font-sm);
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <main class="main-content">
        <div class="login-container">
            <div class="login-logo">
                <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고">
                <h1 class="login-title">관리자 로그인</h1>
            </div>

            <form action="${pageContext.request.contextPath}/admin-login.action" method="post">
                <input type="text" name="adminId" placeholder="아이디" class="login-input" required>
                <input type="password" name="adminPw" placeholder="비밀번호" class="login-input" required>
                <button type="submit" class="login-button">로그인</button>
            </form>

            <div class="login-options">
                <a href="${pageContext.request.contextPath}/admin-registerid.action" class="text-secondary">관리자 등록</a>
            </div>
        </div>
    </main>
</div>

<c:if test="${not empty loginError}">
    <script>
        alert('${loginError}');
    </script>
</c:if>

</body>
</html>
