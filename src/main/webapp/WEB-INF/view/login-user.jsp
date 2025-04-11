<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login-user.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

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
            background-color: var(--color-maple);
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

        .social-login {
            text-align: center;
            margin-top: 20px;
        }

        .social-text {
            color: var(--text-secondary);
            font-size: var(--font-xs);
            margin-bottom: 20px;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .kakao-icon {
            background-color: #fee500;
        }

        .naver-icon {
            background-color: #1ec800;
        }

        .login-help {
            text-align: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: var(--font-xs);
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <main class="main-content">
        <div class="login-container">
            <div class="login-logo">
                <a href="${pageContext.request.contextPath}/main.action">
                    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고">
                </a>
                <h1 class="login-title">로그인/회원가입</h1>
            </div>

            <form action="${pageContext.request.contextPath}/login-user.action" method="post">
            <input type="text" name="userId" placeholder="아이디" class="login-input" required>
                <input type="password" name="password" placeholder="비밀번호" class="login-input" required>

                <button type="submit" class="login-button">로그인</button>
            </form>

            <div class="login-options">
                <a href="${pageContext.request.contextPath}/login-user-passwordreset.action" class="text-secondary">비밀번호 재설정</a>
                <a href="${pageContext.request.contextPath}/registeruser-tel.action" class="text-secondary">회원가입</a>
            </div>

            <div class="social-login">
                <p class="social-text">SNS계정으로 간편 로그인/회원가입</p>
                <div class="social-icons">
                    <a href="${pageContext.request.contextPath}/oauth/kakao.action" class="social-icon kakao-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/kakao_logo.png" alt="카카오_로고">
                    </a>
                    <a href="${pageContext.request.contextPath}/oauth/naver.action" class="social-icon naver-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/naver_logo.png" alt="네이버_로고">
                    </a>
                </div>
            </div>

            <div class="login-help">
                <a href="#" class="text-secondary">고객센터로 이동</a>
            </div>
        </div>
    </main>
</div>


<!-- 로그인 실패 시 알림 출력 -->
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    if (error === '1') {
        alert('아이디 또는 비밀번호가 일치하지 않습니다.');
    }
</script>
</body>
</html>
