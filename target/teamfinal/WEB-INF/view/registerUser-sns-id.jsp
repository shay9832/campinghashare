<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>registerUser-sns-id.jsp</title>
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

        .form-error {
            font-size: var(--font-xxs);
            color: var(--color-error);
            margin-top: var(--spacing-xs);
            display: none;
        }

        .form-success {
            font-size: var(--font-xxs);
            color: var(--color-success);
            margin-top: var(--spacing-xs);
            display: none;
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

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-xl);
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
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>
        <form action="${pageContext.request.contextPath}/register.action" method="post">
            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" class="form-input" name="userName" value="${loginUser.userName}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">전화번호</label>
                <input type="text" class="form-input" name="userTel" value="${loginUser.userTel}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" class="form-input" name="userId" value="${loginUser.userId}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">비밀번호 *</label>
                <input type="password" class="form-input" name="password" placeholder="8~16자, 영문+숫자 조합" required>
            </div>
            <div class="form-group">
                <label class="form-label">비밀번호 확인 *</label>
                <input type="password" class="form-input" name="passwordConfirm" placeholder="비밀번호 확인" required>
            </div>
            <div class="form-group">
                <label class="form-label">닉네임 *</label>
                <div class="input-group">
                    <input type="text" class="form-input" id="nickname" name="nickname" placeholder="2~6자 한글" required>
                    <button type="button" class="verify-btn" onclick="checkNickname()">중복확인</button>
                </div>
                <p class="form-error" id="nicknameError">사용 불가한 닉네임입니다.</p>
                <p class="form-success" id="nicknameSuccess">사용 가능한 닉네임입니다.</p>
            </div>
            <div class="button-container">
                <button type="button" class="btn" onclick="history.back()">이전</button>
                <button type="submit" class="btn btn-primary">다음</button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script>
    function checkNickname() {
        const nickname = document.getElementById('nickname').value;
        if (!/^[\uAC00-\uD7A3]{2,6}$/.test(nickname)) {
            document.getElementById('nicknameError').style.display = 'block';
            document.getElementById('nicknameSuccess').style.display = 'none';
            return;
        }
        fetch(`${pageContext.request.contextPath}/nicknamecheck.action?nickname=` + encodeURIComponent(nickname))
            .then(res => res.text())
            .then(result => {
                if (result === 'usable') {
                    document.getElementById('nicknameSuccess').style.display = 'block';
                    document.getElementById('nicknameError').style.display = 'none';
                } else {
                    document.getElementById('nicknameError').style.display = 'block';
                    document.getElementById('nicknameSuccess').style.display = 'none';
                }
            });
    }
</script>
</body>
</html>
