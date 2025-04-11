<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>registerUser-tel.jsp</title>

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

        .auth-button {
            width: 100%;
            padding: 20px;
            background-color: var(--color-maple);
            color: white;
            font-weight: bold;
            border: none;
            border-radius: var(--radius-sm);
            cursor: pointer;
            margin: 40px auto;
        }

        .form-label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: var(--font-medium);
            color: var(--text-primary);
            font-size: var(--font-sm);
        }

        .form-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-sm);
            background-color: var(--color-gray-50);
        }

        .input-group {
            display: flex;
            gap: var(--spacing-xs);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-xl);
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

        <form action="${pageContext.request.contextPath}/registeruser-tel-verify.action" method="post">
            <div class="agreement-section">
                <h3 class="agreement-title">약관동의</h3>

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" id="all-agree">
                        <span class="ml-2">전체동의</span>
                    </label>
                </div>

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" name="agreement" required>
                        <span class="ml-2">만 14세 이상입니다</span>
                        <span class="form-text ml-2">(필수)</span>
                    </label>
                    <a href="#" class="arrow"><i class="fas fa-chevron-right"></i></a>
                </div>

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" name="agreement" required>
                        <span class="ml-2">이용약관</span>
                        <span class="form-text ml-2">(필수)</span>
                    </label>
                    <a href="#" class="arrow"><i class="fas fa-chevron-right"></i></a>
                </div>
            </div>

            <!-- ✅ PASS 인증 요청 폼 -->
            <form action="${pageContext.request.contextPath}/registeruser-tel-verify.action" method="post">
                <button type="submit" class="auth-button">PASS 인증</button>
            </form>

            <!-- PASS 인증 완료 후 노출 -->
            <c:if test="${not empty userName && not empty userTel}">
            <hr style="margin: 30px 0;">
            <div class="form-group">
                <label class="form-label">인증된 이름</label>
                <input type="text" class="form-input" value="${userName}" readonly>

                <label class="form-label">인증된 전화번호</label>
                <input type="text" class="form-input" value="${userTel}" readonly>
            </div>

            <form action="${pageContext.request.contextPath}/registeruser-id.action" method="get">
                <input type="hidden" name="userName" value="${userName}">
                <input type="hidden" name="userTel" value="${userTel}">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/main'">이전</button>
                <button type="submit" class="btn btn-primary">다음</button>
            </form>
            </c:if>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.getElementById('all-agree').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('input[name="agreement"]');
        checkboxes.forEach(cb => cb.checked = this.checked);
    });

    document.querySelectorAll('input[name="agreement"]').forEach(cb => {
        cb.addEventListener('change', () => {
            const allChecked = [...document.querySelectorAll('input[name="agreement"]')].every(cb => cb.checked);
            document.getElementById('all-agree').checked = allChecked;
        });
    });
</script>
</body>
</html>