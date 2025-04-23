<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

        <form action="${pageContext.request.contextPath}/insertUser.action" method="post" id="registerForm">

            <!-- 세션에서 전달된 값 표시 -->
            <div class="form-group">
                <label class="form-label">이름</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${userName}" readonly>
                </div>

                <label class="form-label">전화번호</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${userTel}" readonly>
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

            <!-- 비밀번호 입력 -->
            <div class="form-group">
                <label class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" id="password" name="password" class="form-input" required>
                <p class="form-error" id="passwordError">비밀번호는 8~16자 영문+숫자 조합이어야 합니다.</p>
                <p class="form-success" id="passwordSuccess">사용 가능한 비밀번호입니다.</p>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label class="form-label">비밀번호 확인 <span class="required-field">*</span></label>
                <input type="password" id="passwordConfirm" class="form-input" required>
                <p class="form-error" id="passwordConfirmError">비밀번호가 일치하지 않습니다.</p>
                <p class="form-success" id="passwordConfirmSuccess">비밀번호가 일치합니다.</p>
            </div>

            <!-- 닉네임 -->
            <div class="form-group">
                <label class="form-label">닉네임 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="nickname" name="nickname" class="form-input" required>
                    <button type="button" class="verify-btn" id="nicknameCheck">중복확인</button>
                </div>
                <p class="form-error" id="nicknameError">사용 불가한 닉네임입니다.</p>
                <p class="form-success" id="nicknameSuccess">사용 가능한 닉네임입니다.</p>
            </div>

            <div class="button-container">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/registeruser-tel.action'">이전</button>
                <button type="submit" class="btn btn-primary" id="submitBtn" disabled>회원가입</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    let idChecked = false;
    let nicknameChecked = false;

    // 아이디 중복 확인
    document.getElementById("idCheck").addEventListener("click", function () {
        const userId = document.getElementById("userId").value;
        if (!userId) {
            alert("아이디를 입력해주세요.");
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/user-idcheck.action',
            method: 'GET',
            data: { userId: userId },
            dataType: 'text',
            success: function(response) {
                console.log("ID check response:", response);

                if (response === "사용 가능한 아이디입니다.") {
                    document.getElementById("userIdSuccess").style.display = "block";
                    document.getElementById("userIdSuccess").textContent = response;
                    document.getElementById("userIdError").style.display = "none";
                    idChecked = true;
                } else {
                    document.getElementById("userIdSuccess").style.display = "none";
                    document.getElementById("userIdError").style.display = "block";
                    document.getElementById("userIdError").textContent = response;
                    idChecked = false;
                }
                checkFormValidity();
            },
            error: function(xhr, status, error) {
                console.error("ID check error:", error);
                alert("중복 확인 중 오류가 발생했습니다.");
            }
        });
    });

    // 닉네임 중복 확인
    document.getElementById("nicknameCheck").addEventListener("click", function () {
        const nickname = document.getElementById("nickname").value;
        if (!nickname) {
            alert("닉네임을 입력해주세요.");
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/user-nicknamecheck.action',
            method: 'GET',
            data: { nickname: nickname },
            dataType: 'text',
            success: function(response) {
                console.log("Nickname check response:", response);

                if (response === "사용 가능한 닉네임입니다.") {
                    document.getElementById("nicknameSuccess").style.display = "block";
                    document.getElementById("nicknameSuccess").textContent = response;
                    document.getElementById("nicknameError").style.display = "none";
                    nicknameChecked = true;
                } else {
                    document.getElementById("nicknameSuccess").style.display = "none";
                    document.getElementById("nicknameError").style.display = "block";
                    document.getElementById("nicknameError").textContent = response;
                    nicknameChecked = false;
                }
                checkFormValidity();
            },
            error: function(xhr, status, error) {
                console.error("Nickname check error:", error);
                alert("중복 확인 중 오류가 발생했습니다.");
            }
        });
    });

    // 아이디나 닉네임이 변경되면 중복 확인 상태 리셋
    document.getElementById("userId").addEventListener("input", function() {
        idChecked = false;
        document.getElementById("userIdSuccess").style.display = "none";
        document.getElementById("userIdError").style.display = "none";
        checkFormValidity();
    });

    document.getElementById("nickname").addEventListener("input", function() {
        nicknameChecked = false;
        document.getElementById("nicknameSuccess").style.display = "none";
        document.getElementById("nicknameError").style.display = "none";
        checkFormValidity();
    });

    // 비밀번호 유효성 검사
    document.getElementById("password").addEventListener("input", function() {
        const password = this.value;
        const passwordConfirm = document.getElementById("passwordConfirm").value;

        // 비밀번호 길이 검사 및 영문/숫자 조합 확인
        const isValidPassword = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/.test(password);

        if (isValidPassword) {
            document.getElementById("passwordSuccess").style.display = "block";
            document.getElementById("passwordError").style.display = "none";
        } else {
            document.getElementById("passwordSuccess").style.display = "none";
            document.getElementById("passwordError").style.display = "block";
        }

        // 비밀번호 확인란과 일치하는지 검사
        if (passwordConfirm) {
            if (password === passwordConfirm) {
                document.getElementById("passwordConfirmSuccess").style.display = "block";
                document.getElementById("passwordConfirmError").style.display = "none";
            } else {
                document.getElementById("passwordConfirmSuccess").style.display = "none";
                document.getElementById("passwordConfirmError").style.display = "block";
            }
        }

        checkFormValidity();
    });

    // 비밀번호 확인
    document.getElementById("passwordConfirm").addEventListener("input", function() {
        const password = document.getElementById("password").value;
        const passwordConfirm = this.value;

        if (password === passwordConfirm) {
            document.getElementById("passwordConfirmSuccess").style.display = "block";
            document.getElementById("passwordConfirmError").style.display = "none";
        } else {
            document.getElementById("passwordConfirmSuccess").style.display = "none";
            document.getElementById("passwordConfirmError").style.display = "block";
        }
        checkFormValidity();
    });

    // 폼 전체 유효성 검사
    function checkFormValidity() {
        const password = document.getElementById("password").value;
        const passwordConfirm = document.getElementById("passwordConfirm").value;
        const submitBtn = document.getElementById("submitBtn");

        const passwordLengthValid = password.length >= 8;
        const passwordsMatch = password === passwordConfirm;

        if (idChecked && nicknameChecked && passwordLengthValid && passwordsMatch) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    // 폼 제출 시 최종 확인 + 알림 추가
    document.getElementById("registerForm").addEventListener("submit", function (e) {
        e.preventDefault();

        if (!idChecked) {
            alert("아이디 중복 확인을 해주세요.");
            return;
        }
        if (!nicknameChecked) {
            alert("닉네임 중복 확인을 해주세요.");
            return;
        }

        const pw = document.getElementById("password").value;
        const pwConfirm = document.getElementById("passwordConfirm").value;

        if (pw.length < 8 || !/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/.test(pw)) {
            alert("비밀번호는 8~16자 영문+숫자 조합이어야 합니다.");
            return;
        }
        if (pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }

        // 최종 alert 후 서버 전송
        alert("회원 가입이 완료되었습니다.");
        this.action = "${pageContext.request.contextPath}/insertUser.action";
        this.submit();
    });
</script>
</body>
</html>