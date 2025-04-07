<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 이메일 변경</title>
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
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container mypage-container section">
    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
<<<<<<< Updated upstream
                    <li><a href="myPage-infoEdit.jsp" class="sidebar-link active">회원 정보 수정</a></li>
=======
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link active">회원 정보 수정</a></li>
>>>>>>> Stashed changes
                    <li><a href="#" class="sidebar-link">회원 등급</a></li>
                    <li><a href="#" class="sidebar-link">신뢰도</a></li>
                    <li><a href="#" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
<<<<<<< Updated upstream
                    <li><a href="#" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="#" class="sidebar-link">내가 작성한 글</a></li>
=======
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
>>>>>>> Stashed changes
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <!-- 이메일 변경 -->
        <div id="email-change-view" class="content-box">
            <h3 class="content-box-title mb-4">회원 정보 수정 - 이메일 변경</h3>

            <div class="form-group">
                <label class="form-label">새 이메일</label>
                <div class="input-container">
                    <input type="email" class="form-control" id="email-input" placeholder="예) abc1234@test.com" value="">
                </div>
            </div>

            <div class="form-group mt-3">
                <div class="input-container">
                    <button class="btn btn-secondary w-100" id="verification-btn">인증번호 받기</button>
                </div>
            </div>

            <div class="form-group mt-4" id="verification-area" style="display: none;">
                <label class="form-label">인증번호 입력</label>
                <div class="input-container d-flex">
                    <input type="text" class="form-control" id="verification-code" placeholder="1234">
                    <button class="btn btn-primary ml-2" id="verify-btn">확인</button>
                </div>
                <div class="form-text text-error" id="verification-error" style="display: none;">인증번호가 다릅니다.</div>
                <div class="text-right mt-1">
                    <button class="btn-text" id="resend-btn">재발송</button>
                </div>
            </div>

            <div class="form-group mt-4">
                <div class="form-switch">
                    <label class="form-check">
                        <span>이메일 수신동의</span>
                        <div class="toggle-container ml-3">
                            <input type="checkbox" id="email-subscribe" class="toggle-input" checked>
                            <label for="email-subscribe" class="toggle-label">
                                <span class="toggle-on">ON</span>
                                <span class="toggle-off">OFF</span>
                            </label>
                        </div>
                    </label>
                </div>
            </div>

            <div class="button-container mt-4">
                <button class="btn btn-primary" id="complete-email-btn">수정</button>
            </div>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script>
    $(document).ready(function() {
        // 인증번호 받기 버튼 클릭
        $("#verification-btn").click(function() {
            const email = $("#email-input").val();

            if (!email) {
                alert('이메일을 입력해주세요.');
                return;
            }

            if (!isValidEmail(email)) {
                alert('유효한 이메일 주소를 입력해주세요.');
                return;
            }

            // 인증번호 입력 영역 표시
            $("#verification-area").show();
            alert('인증번호가 발송되었습니다.');
        });

        // 인증번호 확인 버튼 클릭
        $("#verify-btn").click(function() {
            const code = $("#verification-code").val();

            // 테스트를 위해 '1234'가 인증번호라고 가정
            if (code === '1234') {
                alert('인증이 완료되었습니다.');
                $("#verification-error").hide();
            } else {
                $("#verification-error").show();
            }
        });

        // 인증번호 재발송 버튼 클릭
        $("#resend-btn").click(function() {
            alert('인증번호가 재발송되었습니다.');
        });

        // 이메일 수정 완료 버튼 클릭
        $("#complete-email-btn").click(function() {
            const email = $("#email-input").val();

            if (!email) {
                alert('이메일을 입력해주세요.');
                return;
            }

            if (!isValidEmail(email)) {
                alert('유효한 이메일 주소를 입력해주세요.');
                return;
            }

            alert('이메일이 성공적으로 변경되었습니다.');
            window.location.href = 'edit-profile.html';
        });

        // 이메일 유효성 검사 함수
        function isValidEmail(email) {
            const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return regex.test(email);
        }
    });
</script>
</body>
</html>
