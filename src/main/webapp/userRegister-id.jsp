<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>0-4-register-id.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        .register-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
        }

        .register-title {
            text-align: center;
            margin-bottom: var(--spacing-xl);
            color: var(--text-primary);
            font-size: var(--font-lg);
            font-weight: var(--font-bold);
        }

        .register-subtitle {
            text-align: center;
            color: var(--text-secondary);
            font-size: var(--font-sm);
            margin-bottom: var(--spacing-xl);
        }

        .social-login {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-xl);
        }

        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        .facebook-btn {
            background-color: #3b5998;
        }

        .kakao-btn {
            background-color: #FEE500;
            color: #3C1E1E;
        }

        .naver-btn {
            background-color: #03C75A;
        }

        .register-divider {
            margin: var(--spacing-xl) 0;
            border-top: 1px solid var(--border-light);
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: var(--font-medium);
            color: var(--text-primary);
            font-size: var(--font-sm);
        }

        .form-group {
            margin-bottom: var(--spacing-lg);
        }

        .form-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-sm);
        }

        .input-group {
            display: flex;
            gap: var(--spacing-xs);
        }

        .required-field {
            color: var(--color-coral);
        }

        .form-help {
            font-size: var(--font-xxs);
            color: var(--text-tertiary);
            margin-top: var(--spacing-xs);
        }

        .agreement-section {
            margin-top: var(--spacing-xl);
        }

        .agreement-title {
            font-size: var(--font-sm);
            font-weight: var(--font-medium);
            margin-bottom: var(--spacing-md);
        }

        .agreement-item {
            display: flex;
            align-items: center;
            padding: var(--spacing-xs) 0;
            border-bottom: 1px solid var(--border-light);
        }

        .agreement-item label {
            display: flex;
            align-items: center;
            cursor: pointer;
            width: 100%;
        }

        .agreement-item .arrow {
            margin-left: auto;
        }

        .register-btn {
            width: 100%;
            background-color: var(--color-maple);
            color: white;
            padding: var(--spacing-md);
            border: none;
            border-radius: var(--radius-sm);
            font-size: var(--font-md);
            cursor: pointer;
            transition: background-color var(--transition-normal);
        }

        .register-btn:hover {
            background-color: var(--btn-primary-hover-bg);
        }

        .login-link {
            text-align: center;
            margin-top: var(--spacing-lg);
            font-size: var(--font-sm);
            color: var(--text-secondary);
        }

        .login-link a {
            color: var(--color-maple);
            font-weight: var(--font-medium);
            text-decoration: none;
        }

        .verify-btn {
            padding: 10px 15px;
            background-color: var(--color-gray-200);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            cursor: pointer;
            white-space: nowrap;
        }

        .verify-btn:hover {
            background-color: var(--color-gray-300);
        }

        @media (max-width: 768px) {
            .register-container {
                padding: var(--spacing-md);
                margin: 20px 15px;
            }

            .input-group {
                flex-direction: column;
            }

            .verify-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="email" class="form-label">아이디 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="userId" name="userId" class="form-input" placeholder="아이디" required>
                </div>
                <p class="form-help">필수 입력 항목입니다.</p>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" id="password" name="password" class="form-input" placeholder="영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요." required>
                <p class="form-help">필수 입력 항목입니다.</p>
            </div>

            <div class="form-group">
                <label for="password-confirm" class="form-label">비밀번호 확인 <span class="required-field">*</span></label>
                <input type="password" id="password-confirm" name="passwordConfirm" class="form-input" placeholder="비밀번호 확인" required>
                <p class="form-help">확인을 위해 비밀번호를 한 번 더 입력해주세요.</p>
            </div>

            <div class="form-group">
                <label for="nickname" class="form-label">닉네임 <span class="required-field">*</span></label>
                <input type="text" id="nickname" name="nickname" class="form-input" placeholder="다른 유저와 겹치지 않도록 입력해주세요. (2~20자)" required>
                <p class="form-help">사용 중인 별명입니다.</p>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">이메일</label>
                <div class="input-group">
                    <input type="email" id="email" name="email" class="form-input" placeholder="이메일">
                    <div class="form-text">@</div>
                    <select class="form-input">
                        <option selected>선택해주세요</option>
                        <option>naver.com</option>
                        <option>gmail.com</option>
                        <option>daum.net</option>
                        <option>직접입력</option>
                    </select>
                </div>
            </div>

            <!-- 이전 / 다음 페이지 이동 버튼 -->
            <div class="button-container">
                <button class="btn">이전</button>
                <button class="btn btn-primary">다음</button>
            </div>
        </form>
    </div>
</div>


<!-- 푸터 포함 -->
<jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>