<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 회원 정보 수정</title>
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
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link active">회원 정보 수정</a></li>
                    <li><a href="myPage-trust.jsp" class="sidebar-link">신뢰도</a></li>
                    <li><a href="myPage-point.jsp" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="myPage-inspecList.jsp" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="myPage-delivery.jsp" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="myPage-wishlist.jsp" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="" class="sidebar-link title">
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
        <!-- 회원 정보 수정 화면 (이미지 4) -->
            <div id="edit-profile-view" class="content-box">
                <h3 class="content-box-title mb-4">회원 정보</h3>

                <div class="form-row">
                    <div class="form-label">이름</div>
                    <div class="form-input">유진이</div>
                </div>

                <div class="form-row">
                    <div class="form-label">아이디</div>
                    <div class="form-input">abc1234</div>
                </div>

                <div class="form-row">
                    <div class="form-label">휴대폰번호</div>
                    <div class="form-input d-flex align-items-center">
                        <div>010-0000-0000</div>
                        <button class="btn btn-outline-primary ml-3">인증 변경</button>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-label">이메일</div>
                    <div class="form-input d-flex align-items-center">
                        <div>abc1234@test.com</div>
                        <span class="text-success ml-2">이메일 수신동의 OK</span>
                        <button class="btn btn-primary ml-auto" id="edit-email-btn">수정</button>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-label">닉네임</div>
                    <div class="form-input d-flex align-items-center">
                        <div>가나초콜릿</div>
                        <span class="text-muted ml-2">수정횟수 1/5</span>
                        <button class="btn btn-primary ml-auto" id="edit-nickname-btn">수정</button>
                    </div>
                </div>

                <div class="form-row mt-5">
                    <button class="btn btn-block btn-outline-primary" id="change-password-btn">비밀번호 변경</button>
                </div>

                <div class="form-row mt-3">
                    <button class="btn btn-block btn-outline-primary">주소 변경</button>
                </div>
            </div>
        </div>
    </div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script>
    $(document).ready(function() {
        // 닉네임 수정 버튼 클릭
        $("#edit-nickname-btn").click(function() {
            window.location.href = 'myPage-infoEdit-nickname.jsp';
        });

        // 이메일 수정 버튼 클릭
        $("#edit-email-btn").click(function() {
            window.location.href = 'myPage-infoEdit-email.jsp';
        });

        // 비밀번호 변경 버튼 클릭
        $("#change-password-btn").click(function() {
            window.location.href = 'myPage-infoEdit-passwordCheck.jsp';
        });
    });
</script>
</body>
</html>