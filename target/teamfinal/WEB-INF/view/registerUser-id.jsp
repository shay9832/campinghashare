<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>registerUser-id.jsp</title>

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

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

        <form action="${pageContext.request.contextPath}/register.action" method="post" id="registerForm">

            <!-- FlashAttribute로 전달된 값 표시 -->
            <div class="form-group">
                <label class="form-label">이름</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${userName}" readonly>
                    <input type="hidden" name="userName" value="${userName}">
                </div>

                <label class="form-label">전화번호</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${userTel}" readonly>
                    <input type="hidden" name="userTel" value="${userTel}">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">아이디 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="userId" name="userId" class="form-input" required>
                    <button type="button" class="verify-btn" id="idCheck">중복확인</button>
                </div>
                <p class="form-error" id="userIdError">사용 불가한 아이디입니다.</p>
                <p class="form-success" id="userIdSuccess">사용 가능한 아이디입니다.</p>
            </div>

            <div class="form-group">
                <label class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" name="password" class="form-input" required>
            </div>

            <!-- 닉네임 -->
            <div class="form-group">
                <label class="form-label">닉네임 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" name="nickname" class="form-input" required>
                    <button type="button" class="verify-btn" id="nicknameCheck">중복확인</button>
                </div>
                <p class="form-error" id="nicknameError">사용 불가한 닉네임입니다.</p>
                <p class="form-success" id="nicknameSuccess">사용 가능한 닉네임입니다.</p>
            </div>

            <div class="button-container">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/registeruser-tel.action'">이전</button>
                <button type="submit" class="btn btn-primary">다음</button>
            </div>
        </form>
    </div>
</div>


<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.getElementById("idCheck").addEventListener("click", function () {
        const userId = document.getElementById("userId").value;
        fetch("${pageContext.request.contextPath}/idcheck.action?userId=" + userId)
            .then(res => res.text())
            .then(result => {
                document.getElementById("userIdSuccess").style.display = result === "usable" ? "block" : "none";
                document.getElementById("userIdError").style.display = result === "duplicated" ? "block" : "none";
            });
    });

    document.getElementById("nicknameCheck").addEventListener("click", function () {
        const nickname = document.querySelector("input[name='nickname']").value;
        fetch("${pageContext.request.contextPath}/nicknamecheck.action?nickname=" + nickname)
            .then(res => res.text())
            .then(result => {
                document.getElementById("nicknameSuccess").style.display = result === "usable" ? "block" : "none";
                document.getElementById("nicknameError").style.display = result === "duplicated" ? "block" : "none";
            });
    });
</script>
</body>
</html>