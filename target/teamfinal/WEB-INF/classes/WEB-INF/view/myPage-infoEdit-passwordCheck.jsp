<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 마이페이지</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
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
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container container-wide mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link active">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">회원 정보 수정 - 비밀번호 확인</h2>
            <p class="page-description">회원 정보를 수정하기 위해서는 비밀번호를 입력해야 합니다.</p>
        </div>

        <!-- 비밀번호 확인 콘텐츠 -->
        <div class="register-container">
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" class="form-input" placeholder="(현재 회원의 아이디 자동표시)" value="${userId}" readonly required>
            </div>

            <div class="form-group mt-3">
                <label class="form-label">비밀번호 <span class="required-field">*</span></label>
                <input type="password" name="password" class="form-input" id="password" required>
                <div class="form-error" id="password-void" style="display: none;">비밀번호를 입력하세요!</div>
                <div class="form-error" id="password-error" style="display: none;">비밀번호가 다릅니다.</div>
            </div>

            <div class="button-container">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/mypage-main.action'">이전</button>
                <button type="submit" class="btn btn-primary" id="checkPasswordBtn">다음</button>
            </div>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 비밀번호 입력 필드에서 키를 입력할 때마다 실행
        $("#password").keyup(function() {
            $("#password-error").hide();

            const password = $(this).val().trim();  // 입력된 비밀번호 값

            if (password) {  // 비밀번호가 있으면
                $("#password-void").hide();  // '비밀번호를 입력하세요' 메시지 숨김
            } else {  // 비밀번호가 없으면
                $("#password-void").show();  // '비밀번호를 입력하세요' 메시지 보임
            }
        });

        // 비밀번호 확인 버튼 클릭
        $("#checkPasswordBtn").click(function() {
            const password = $("#password").val().trim();

            if (!password)
            {
                $("#password-void").show();
                $("#password").focus();
                return;
            }

            $.ajax({
                url: "/mypage-password-check.action",
                type: "POST",
                data: { password: password },
                success: function (result) {
                    if (result === "success") {
                        window.location.href = "/mypage-infoedit.action";
                    } else {
                        $("#password-error").show();
                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>