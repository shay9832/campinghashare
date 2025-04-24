<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 회원 정보 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
    <style>
        .register-container {
            max-width: 800px;
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
        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-xl);
        }
        .btn {
            padding: 10px 15px;
            font-size: var(--font-sm);
            border-radius: var(--radius-sm);
            cursor: pointer;
        }
        .btn-primary {
            background-color: var(--color-primary);
            color: white;
            border: none;
        }
        .btn-outline-primary {
            background: none;
            border: 1px solid var(--color-primary);
            color: var(--color-primary);
        }
        @media (max-width: 768px) {
            .register-container { padding: var(--spacing-md); margin: 20px 15px; }
            .input-group { flex-direction: column; }
            .verify-btn { width: 100%; }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container container-wide mypage-container section">
    <jsp:include page="mypage-sidebar.jsp" />
    <div class="mypage-main-content">
        <div id="edit-profile-view" class="register-container">
            <h2 class="register-title">회원정보 수정</h2>
            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" class="form-input" value="${user.userName}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">전화번호</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${user.userTel}" readonly>
                    <button class="btn btn-outline-primary">인증 변경</button>
                </div>
            </div>
            <hr>
            <div class="form-group">
                <label class="form-label">이메일
                    <c:choose>
                        <c:when test="${user.emailConsent == '동의'}">
                            <span class="text-success">(수신 동의)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">(수신 거부)</span>
                        </c:otherwise>
                    </c:choose>
                </label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${user.userEmail}" readonly>
                    <button class="btn btn-primary" id="edit-email-btn">수정</button>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">닉네임 <span class="text-muted">(수정 가능 횟수: ${user.nicknameChange}/5)</span></label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${user.nickname}" readonly>
                    <button class="btn btn-primary" id="edit-nickname-btn">수정</button>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <div class="input-group">
                    <input type="password" class="form-input" value="********" readonly>
                    <button class="btn btn-outline-primary" id="change-password-btn">변경</button>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">주소</label>
                <div class="input-group">
                    <input type="text" class="form-input" value="${user.zipCode} ${user.address1} ${user.address2}" readonly>
                    <button class="btn btn-outline-primary" id="change-address-btn">변경</button>
                </div>
            </div>
            <div class="button-container">
                <button class="btn btn-outline-primary" onclick="location.href='mypage-main.action'">뒤로가기</button>
                <button class="btn btn-primary" onclick="location.href='mypage-main.action'">마이페이지 홈</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
<script>
    $(function () {
        $('#edit-email-btn').click(() => location.href = 'mypage-infoedit-email.action');
        $('#edit-nickname-btn').click(() => location.href = 'mypage-infoedit-nickname.action');
        $('#change-password-btn').click(() => location.href = 'mypage-infoedit-password.action');
        $('#change-address-btn').click(() => location.href = 'mypage-infoedit-address.action');
    });
</script>
</body>
</html>
