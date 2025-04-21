<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>registerUser-tel.jsp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">

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

        .agreement-item {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .agreement-item label {
            flex: 1;
            cursor: pointer;
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
            margin: 40px auto 0 auto;
        }

        /* 모달 내 input 스타일 */
        .modal-body input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: var(--font-sm);
        }

        .modal-footer {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        /* 메시지 스타일 */
        #responseMessage {
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #ffe6e6;
            border-radius: 6px;
            font-size: var(--font-sm);
        }

        /* 인증 요청 버튼 스타일 */
        #submitBtn {
            margin-left: 10px;
        }

        #submitBtn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        .button-group {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>

        <form id="passForm" action="${pageContext.request.contextPath}/registeruser-tel-verify.action" method="post">
            <div class="agreement-section">
                <h3 class="agreement-title">약관동의</h3>

                <div class="agreement-item">
                    <label><input type="checkbox" id="all-agree"> 전체동의</label>
                </div>

                <div class="agreement-item">
                    <label><input type="checkbox" name="agreement" required> 만 14세 이상입니다 (필수)</label>
                </div>

                <div class="agreement-item">
                    <label><input type="checkbox" name="agreement" required> 이용약관에 동의합니다 (필수)</label>
                </div>
            </div>

            <!-- PASS 인증 버튼 -->
            <button type="button" class="auth-button" onclick="checkAgreementAndOpenModal()">PASS 인증</button>
        </form>
    </div>
</div>

<!-- 모달 -->
<div id="authModal" class="modal modal-md">
    <div class="modal-header">
        <h3 class="modal-title">PASS 인증</h3>
        <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
    </div>
    <div class="modal-body">
        <input type="text" id="inputName" placeholder="이름 입력" class="form-input">
        <input type="text" id="inputTel" placeholder="전화번호 입력 (예: 010-0000-0000)" class="form-input">
    </div>
    <div class="modal-footer">
        <span id="responseMessage" style="color:red; display:none;">중복된 정보로 가입 불가합니다.</span>
        <div class="button-group">
            <button type="button" class="btn btn-secondary" onclick="closeModal()">이전</button>
            <button type="button" class="btn" id="submitBtn" onclick="submitModalInfo()" disabled>인증 요청</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.getElementById('all-agree').addEventListener('change', function () {
        const boxes = document.querySelectorAll('input[name="agreement"]');
        boxes.forEach(cb => cb.checked = this.checked);
    });

    document.querySelectorAll('input[name="agreement"]').forEach(cb => {
        cb.addEventListener('change', () => {
            const allChecked = [...document.querySelectorAll('input[name="agreement"]')].every(cb => cb.checked);
            document.getElementById('all-agree').checked = allChecked;
        });
    });

    // 모달창의 입력 필드에 이벤트 리스너 추가
    document.getElementById('inputName').addEventListener('input', checkFormValidity);
    document.getElementById('inputTel').addEventListener('input', checkFormValidity);

    // 입력 필드의 유효성 검사 및 버튼 활성화
    function checkFormValidity() {
        const name = document.getElementById("inputName").value.trim();
        const tel = document.getElementById("inputTel").value.trim();
        const submitBtn = document.getElementById("submitBtn");

        // 이름과 전화번호가 모두 입력되었을 때만 버튼 활성화
        if (name && tel) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    // 약관 동의 확인 후 모달 열기
    function checkAgreementAndOpenModal() {
        const agreements = document.querySelectorAll('input[name="agreement"]');
        const allChecked = [...agreements].every(cb => cb.checked);

        if (!allChecked) {
            alert("필수 약관에 모두 동의해주세요.");
            return;
        }

        openModal();
    }

    function openModal() {
        document.getElementById("authModal").classList.add("show");
        // 모달이 열릴 때 입력 필드 초기화 및 버튼 비활성화
        document.getElementById("inputName").value = "";
        document.getElementById("inputTel").value = "";
        document.getElementById("submitBtn").disabled = true;
        document.getElementById("responseMessage").style.display = "none";
    }

    function closeModal() {
        document.getElementById("authModal").classList.remove("show");
    }

    function submitModalInfo() {
        const name = document.getElementById("inputName").value.trim();
        const tel = document.getElementById("inputTel").value.trim();
        const responseMessage = document.getElementById("responseMessage");
        const submitBtn = document.getElementById("submitBtn");

        if (!name || !tel) {
            alert("이름과 전화번호를 모두 입력해주세요.");
            return;
        }

        // 버튼 비활성화 (중복 클릭 방지)
        submitBtn.disabled = true;
        submitBtn.textContent = "처리 중...";

        // 이름과 전화번호 중복 확인
        $.ajax({
            url: '${pageContext.request.contextPath}/user-exists-check.action',
            method: 'GET',
            data: { userName: name, userTel: tel },
            success: function(response) {
                console.log("Response received: " + response);

                if (response === 'AVAILABLE') {
                    // 가입 가능한 경우
                    responseMessage.style.display = 'none';

                    // 인증 진행
                    const form = document.getElementById("passForm");
                    const hiddenName = document.createElement("input");
                    hiddenName.type = "hidden";
                    hiddenName.name = "userName";
                    hiddenName.value = name;

                    const hiddenTel = document.createElement("input");
                    hiddenTel.type = "hidden";
                    hiddenTel.name = "userTel";
                    hiddenTel.value = tel;

                    form.appendChild(hiddenName);
                    form.appendChild(hiddenTel);
                    form.submit();
                } else {
                    // 중복된 정보일 경우
                    responseMessage.style.display = 'block';
                    responseMessage.innerText = '중복된 정보로 가입 불가합니다.';
                    submitBtn.disabled = false;
                    submitBtn.textContent = "인증 요청";
                }
            },
            error: function(xhr, status, error) {
                console.log("Error occurred: " + error);
                alert("중복 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
                submitBtn.disabled = false;
                submitBtn.textContent = "인증 요청";
            }
        });
    }
</script>

</body>
</html>