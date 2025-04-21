<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
        <!-- 회원 정보 수정 화면 -->
            <div id="edit-profile-view" class="register-container">
                <h2 class="register-title">회원정보</h2>

                <div class="form-group">
                    <div class="form-row">
                        <label class="form-label">이름</label>
                        <div class="input-group">
                            <input type="text" class="form-input" value="${user.userName}" readonly>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label">전화번호</label>
                        <div class="input-group justify-content-center" style="flex-direction:row;">
                            <input type="text" class="form-input" value="${user.userTel}" readonly
                            style="width:80%;">
                            <button class="verify-btn" style="width:20%;">인증 변경</button>
                        </div>
                    </div>
                </div>

                <hr class="my-7" />

                <div class="form-group">
                    <div class="form-row">
                        <div style="flex-direction: row;">
                        <label class="form-label">이메일</label>
                            <c:choose>
                                <c:when test="${user.emailConsent = '동의'}">
                                    <span class="text-success ml-auto mr-auto">이메일수신 OK</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger ml-auto mr-auto">이메일수신 NO</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="input-group justify-content-center" style="flex-direction:row;">
                            <input type="text" class="form-input" value="${user.userEmail}" readonly
                                style="width:80%;">
                            <button class="btn btn-primary ml-auto" id="edit-email-btn">수정</button>
                        </div>
                    </div>
                    <div class="form-row">
                        <div style="flex-direction: row;">
                            <label class="form-label">닉네임</label>
                            <span class="text-muted ml-auto mr-auto">수정횟수 1/5</span>
                        </div>
                        <div class="input-group justify-content-center" style="flex-direction:row;">
                            <input type="text" class="form-input" value="${user.nickname}" readonly
                                   style="width:80%;">
                            <button class="btn btn-primary ml-auto" id="edit-nickname-btn">수정</button>
                        </div>
                    </div>
                </div>

                <hr class="my-7" />

                <div class="form-row mt-5">
                    <button class="btn btn-block btn-outline-primary" id="change-password-btn">비밀번호 변경</button>
                </div>

                <div class="form-row mt-3">
                    <button class="btn btn-block btn-outline-primary" id="change-address-btn">주소 변경</button>
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
            window.location.href = 'mypage-infoedit-nickname.action';
        });

        // 이메일 수정 버튼 클릭
        $("#edit-email-btn").click(function() {
            window.location.href = 'mypage-infoedit-email.action';
        });

        // 비밀번호 변경 버튼 클릭
        $("#change-password-btn").click(function() {
            window.location.href = 'myPage-infoedit-passwordcheck.action';
        });
    });
</script>
</body>
</html>