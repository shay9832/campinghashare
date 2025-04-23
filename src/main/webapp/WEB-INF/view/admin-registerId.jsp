<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 등록</title>
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

<jsp:include page="header.jsp" />

<div class="container">
    <div class="register-container">
        <h2 class="register-title">관리자 계정 등록</h2>
        <form id="adminRegisterForm" action="${pageContext.request.contextPath}/insertadmin.action" method="post" onsubmit="return checkSubmit();">
            <div class="form-group">
                <label class="form-label">아이디 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="adminId" name="adminId" class="form-input" placeholder="영문+숫자 4~12자" required>
                    <button type="button" id="idCheckBtn" class="verify-btn">중복 확인</button>
                </div>
                <p id="adminIdError" class="form-error">사용 불가한 아이디입니다.</p>
                <p id="adminIdSuccess" class="form-success">사용 가능한 아이디입니다.</p>
            </div>

            <div class="form-group">
                <label class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" id="adminPw" name="adminPw" class="form-input" placeholder="8~16자 영문+숫자" required>
                <p id="pwError" class="form-error">비밀번호는 8~16자 영문+숫자 조합이어야 합니다.</p>
            </div>

            <div class="form-group">
                <label class="form-label">비밀번호 확인 <span class="required-field">*</span></label>
                <input type="password" id="adminPwConfirm" class="form-input" placeholder="비밀번호 재입력" required>
                <p id="pwConfirmError" class="form-error">비밀번호가 일치하지 않습니다.</p>
            </div>

            <div class="form-group">
                <label class="form-label">전화번호</label>
                <input type="text" id="adminTel" name="adminTel" class="form-input" placeholder="예: 010-0000-0000">
            </div>

            <div class="button-container">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/admin-login.action'">이전</button>
                <button type="submit" id="submitBtn" class="btn btn-primary">등록</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function checkSubmit() {
        alert("관리자 계정 등록 완료되었습니다.");
        return true;
    }

    let idChecked = false;

    document.getElementById("idCheckBtn").addEventListener("click", function () {
        const adminId = document.getElementById("adminId").value;

        if (!/^[a-zA-Z][a-zA-Z0-9]{3,11}$/.test(adminId)) {
            alert("아이디는 영문자로 시작하고 4~12자의 영문+숫자 조합이어야 합니다.");
            return;
        }

        fetch('${pageContext.request.contextPath}/admin-idcheck.action?adminId=' + encodeURIComponent(adminId))
            .then(res => res.text())
            .then(result => {
                const successMsg = document.getElementById("adminIdSuccess");
                const errorMsg = document.getElementById("adminIdError");
                if (result.trim() === "사용 가능한 아이디입니다.") {
                    successMsg.style.display = 'block';
                    errorMsg.style.display = 'none';
                    idChecked = true;
                } else {
                    successMsg.style.display = 'none';
                    errorMsg.style.display = 'block';
                    idChecked = false;
                }
                checkFormValid();
            });
    });

    document.getElementById("adminPw").addEventListener("input", function () {
        const pw = this.value;
        const errorMsg = document.getElementById("pwError");
        const regex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;
        errorMsg.style.display = regex.test(pw) ? 'none' : 'block';
        checkFormValid();
    });

    document.getElementById("adminPwConfirm").addEventListener("input", function () {
        const pw = document.getElementById("adminPw").value;
        const pwConfirm = this.value;
        document.getElementById("pwConfirmError").style.display = (pw === pwConfirm) ? 'none' : 'block';
        checkFormValid();
    });

    function checkFormValid() {
        const pw = document.getElementById("adminPw").value;
        const pwConfirm = document.getElementById("adminPwConfirm").value;
        const regex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;
        const isValidPw = regex.test(pw);
        const isMatch = pw === pwConfirm;

        document.getElementById("submitBtn").disabled = !(idChecked && isValidPw && isMatch);
    }
</script>

</body>
</html>