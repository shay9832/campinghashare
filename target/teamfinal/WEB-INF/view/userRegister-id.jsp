<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 정보입력</title>
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

<!-- 헤더 포함 -->
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
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

            <div class="form-group">
                <label for="userId" class="form-label">아이디 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="userId" name="userId" class="form-input" placeholder="영문자로 시작, 영문+숫자 4~12자" required>
                    <button type="button" id="idCheck" class="verify-btn">중복확인</button>
                </div>
                <p class="form-error" id="userIdError">사용 불가한 아이디입니다.</p>
                <p class="form-error" id="userIdFormatError">영문자로 시작, 영문과 숫자만 사용하여 4~12자로 작성해 주세요.</p>
                <p class="form-success" id="userIdSuccess">사용 가능한 아이디입니다.</p>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" id="password" name="password" class="form-input" placeholder="영문, 숫자를 포함한 8~16자의 비밀번호를 입력해주세요." required>
                <p class="form-help">필수 입력 항목입니다.</p>
                <p class="form-error" id="passwordError">영문, 숫자 포함 8자 이상~16자 이하로 작성 필요</p>
            </div>

            <div class="form-group">
                <label for="passwordConfirm" class="form-label">비밀번호 확인 <span class="required-field">*</span></label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-input" placeholder="비밀번호 확인" required>
                <p class="form-error" id="passwordConfirmError">위 비밀번호와 불일치</p>
            </div>

            <div class="form-group">
                <label for="nickname" class="form-label">닉네임 <span class="required-field">*</span></label>
                <div class="input-group">
                    <input type="text" id="nickname" name="nickname" class="form-input" placeholder="한글 2~6자 이내로 입력해주세요." required>
                    <button type="button" id="nicknameCheck" class="verify-btn">중복확인</button>
                </div>
                <p class="form-help">필수 입력 항목입니다. 한글로만 2~6자 이내로 작성해 주세요.</p>
                <p class="form-error" id="nicknameError">사용 불가한 닉네임입니다.</p>
                <p class="form-error" id="nicknameFormatError">한글로만 2~6자 이내로 작성해 주세요.</p>
                <p class="form-success" id="nicknameSuccess">사용 가능한 닉네임입니다.</p>
            </div>

            <!-- 이전 / 다음 페이지 이동 버튼 -->
            <div class="button-container">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/register-terms'">이전</button>
                <button type="button" class="btn btn-primary" id="nextBtn">다음</button>
            </div>
        </form>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const userId = document.getElementById('userId');
        const password = document.getElementById('password');
        const passwordConfirm = document.getElementById('passwordConfirm');
        const nickname = document.getElementById('nickname');
        const emailDomain = document.getElementById('emailDomain');
        const directDomainInput = document.getElementById('directDomainInput');

        // 아이디 유효성 검사
        userId.addEventListener('input', function() {
            const idRegex = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
            const userIdFormatError = document.getElementById('userIdFormatError');

            if (!idRegex.test(this.value)) {
                userIdFormatError.style.display = 'block';
                document.getElementById('userIdSuccess').style.display = 'none';
                document.getElementById('userIdError').style.display = 'none';
            } else {
                userIdFormatError.style.display = 'none';
            }
        });

        // 아이디 중복 확인
        document.getElementById('idCheck').addEventListener('click', function() {
            const idRegex = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
            const userIdValue = userId.value;

            if (!idRegex.test(userIdValue)) {
                document.getElementById('userIdFormatError').style.display = 'block';
                document.getElementById('userIdSuccess').style.display = 'none';
                document.getElementById('userIdError').style.display = 'none';
                return;
            }

            // 서버로 중복 확인 요청을 보내는 코드
            // 여기서는 예시로 특정 아이디('admin', 'test123')는 이미 존재한다고 가정
            if (userIdValue === 'admin' || userIdValue === 'test123') {
                document.getElementById('userIdError').style.display = 'block';
                document.getElementById('userIdSuccess').style.display = 'none';
                document.getElementById('userIdFormatError').style.display = 'none';
            } else {
                document.getElementById('userIdSuccess').style.display = 'block';
                document.getElementById('userIdError').style.display = 'none';
                document.getElementById('userIdFormatError').style.display = 'none';
            }
        });

        // 비밀번호 유효성 검사
        password.addEventListener('input', function() {
            const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
            const passwordError = document.getElementById('passwordError');

            if (!pwRegex.test(this.value)) {
                passwordError.style.display = 'block';
            } else {
                passwordError.style.display = 'none';
            }

            // 비밀번호 확인 필드가 비어있지 않은 경우, 일치 여부 확인
            if (passwordConfirm.value !== '') {
                checkPasswordMatch();
            }
        });

        // 비밀번호 확인 일치 검사
        passwordConfirm.addEventListener('input', checkPasswordMatch);

        function checkPasswordMatch() {
            const passwordConfirmError = document.getElementById('passwordConfirmError');

            if (password.value !== passwordConfirm.value) {
                passwordConfirmError.style.display = 'block';
            } else {
                passwordConfirmError.style.display = 'none';
            }
        }

        // 닉네임 유효성 검사
        nickname.addEventListener('input', function() {
            const nicknameRegex = /^[가-힣]{2,6}$/;
            const nicknameFormatError = document.getElementById('nicknameFormatError');

            if (!nicknameRegex.test(this.value)) {
                nicknameFormatError.style.display = 'block';
                document.getElementById('nicknameSuccess').style.display = 'none';
                document.getElementById('nicknameError').style.display = 'none';
            } else {
                nicknameFormatError.style.display = 'none';
            }
        });

        // 닉네임 중복 확인
        document.getElementById('nicknameCheck').addEventListener('click', function() {
            const nicknameRegex = /^[가-힣]{2,6}$/;
            const nicknameValue = nickname.value;

            if (!nicknameRegex.test(nicknameValue)) {
                document.getElementById('nicknameFormatError').style.display = 'block';
                document.getElementById('nicknameSuccess').style.display = 'none';
                document.getElementById('nicknameError').style.display = 'none';
                return;
            }

            // 서버로 중복 확인 요청을 보내는 코드
            // 여기서는 예시로 특정 닉네임('관리자', '홍길동')은 이미 존재한다고 가정
            if (nicknameValue === '관리자' || nicknameValue === '홍길동') {
                document.getElementById('nicknameError').style.display = 'block';
                document.getElementById('nicknameSuccess').style.display = 'none';
                document.getElementById('nicknameFormatError').style.display = 'none';
            } else {
                document.getElementById('nicknameSuccess').style.display = 'block';
                document.getElementById('nicknameError').style.display = 'none';
                document.getElementById('nicknameFormatError').style.display = 'none';
            }
        });

        // 이메일 도메인 선택시 직접입력 옵션 처리
        emailDomain.addEventListener('change', function() {
            if (this.value === 'direct') {
                directDomainInput.style.display = 'block';
            } else {
                directDomainInput.style.display = 'none';
            }
        });

        // 다음 버튼 클릭 시 유효성 검사
        document.getElementById('nextBtn').addEventListener('click', function() {
            const idRegex = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
            const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
            const nicknameRegex = /^[가-힣]{2,6}$/;

            let isValid = true;

            // 아이디 검사
            if (!idRegex.test(userId.value)) {
                document.getElementById('userIdFormatError').style.display = 'block';
                isValid = false;
            } else if (document.getElementById('userIdSuccess').style.display !== 'block') {
                alert('아이디 중복확인을 진행해주세요.');
                isValid = false;
            }

            // 비밀번호 검사
            if (!pwRegex.test(password.value)) {
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            }

            // 비밀번호 확인 검사
            if (password.value !== passwordConfirm.value) {
                document.getElementById('passwordConfirmError').style.display = 'block';
                isValid = false;
            }

            // 닉네임 검사
            if (!nicknameRegex.test(nickname.value)) {
                document.getElementById('nicknameFormatError').style.display = 'block';
                isValid = false;
            } else if (document.getElementById('nicknameSuccess').style.display !== 'block') {
                alert('닉네임 중복확인을 진행해주세요.');
                isValid = false;
            }

            // 유효성 검사 통과 시 폼 제출
            if (isValid) {
                document.getElementById('registerForm').submit();
            }
        });
    });
</script>
</body>
</html>