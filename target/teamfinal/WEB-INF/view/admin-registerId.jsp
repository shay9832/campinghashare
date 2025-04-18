<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>registerAdmin-id.jsp</title>

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
            justify-content: flex-end;
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
        <h2 class="register-title">관리자 계정 등록</h2>

        <form action="${pageContext.request.contextPath}/admin/insertadmin.action" method="post" id="registerForm">
            <!-- 관리자 ID -->
            <div class="form-group">
                <label for="adminId" class="form-label">아이디 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="adminId" name="adminId" class="form-input" placeholder="영문+숫자 4~12자" required>
                    <button type="button" id="idCheck" class="verify-btn">중복확인</button>
                </div>
                <p class="form-error" id="adminIdError">사용 불가한 아이디입니다.</p>
                <p class="form-success" id="adminIdSuccess">사용 가능한 아이디입니다.</p>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label for="adminPw" class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" id="adminPw" name="adminPw" class="form-input" placeholder="영문, 숫자 포함 8~16자" required>
            </div>

            <!-- 전화번호 -->
            <div class="form-group">
                <label for="adminTel" class="form-label">전화번호</label>
                <input type="text" id="adminTel" name="adminTel" class="form-input" placeholder="업무용 전화번호">
            </div>

            <div class="button-container">
                <button type="submit" class="btn btn-primary">등록</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    // ID 중복 확인 AJAX
    document.getElementById('idCheck').addEventListener('click', function () {
        const adminId = document.getElementById('adminId').value;
        if (!/^[a-zA-Z][a-zA-Z0-9]{3,11}$/.test(adminId)) {
            alert("아이디는 영문자로 시작하고 4~12자의 영문+숫자 조합이어야 합니다.");
            return;
        }

        fetch('${pageContext.request.contextPath}/admin/admin-idcheck.action?adminId=' + encodeURIComponent(adminId))
            .then(res => res.text())
            .then(result => {
                const successMsg = document.getElementById('adminIdSuccess');
                const errorMsg = document.getElementById('adminIdError');
                if (result === 'usable') {
                    successMsg.style.display = 'block';
                    errorMsg.style.display = 'none';
                } else {
                    successMsg.style.display = 'none';
                    errorMsg.style.display = 'block';
                }
            });
    });
</script>

</body>
</html>
