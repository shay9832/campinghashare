<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>0-3-register-tel.jsp</title>
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
    </style>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

            <div class="agreement-section">
                <h3 class="agreement-title">약관동의</h3>

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" id="all-agree">
                        <span class="ml-2">전체동의</span>
                        <span class="form-text ml-2">선택항목에 대한 동의 포함</span>
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

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" name="agreement" required>
                        <span class="ml-2">개인정보 마케팅 활용 동의</span>
                        <span class="form-text ml-2">(선택)</span>
                    </label>
                    <a href="#" class="arrow"><i class="fas fa-chevron-right"></i></a>
                </div>

                <div class="agreement-item">
                    <label>
                        <input type="checkbox" name="agreement" required>
                        <span class="ml-2">이벤트, 쿠폰, 특가 알림 및 SMS 등 수신</span>
                        <span class="form-text ml-2">(선택)</span>
                    </label>
                    <a href="#" class="arrow"><i class="fas fa-chevron-right"></i></a>
                </div>
            </div>

            <button type="submit" class="auth-button">PASS 인증</button>

        <div class="form-group">
            <label for="userName" class="form-label">이름 <span class="required-field"></span></label>
            <div class="input-group">
                <input type="text" id="userName" name="userName" class="form-input" disabled="disabled" style="background-color: var(--color-gray-50);" value="고길동">
            </div>
            <label for="userTel" class="form-label">전화번호 <span class="required-field"></span></label>
            <div class="input-group">
                <input type="text" id="userTel" name="userTel" class="form-input" disabled="disabled" style="background-color: var(--color-gray-50);" value="010-0000-0000">
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
<script>
    // 전체 동의 체크박스 기능
    document.getElementById('all-agree').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('input[name="agreement"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    // 개별 체크박스 변경시 전체 동의 체크박스 상태 업데이트
    document.querySelectorAll('input[name="agreement"]').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allChecked = Array.from(document.querySelectorAll('input[name="agreement"]'))
                .every(item => item.checked);
            document.getElementById('all-agree').checked = allChecked;
        });
    });
</script>
</body>
</html>