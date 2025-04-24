<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>header.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="icon" href="<c:url value='/favicon.ico' />" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />

</head>
<body>

<!-- 메인 헤더 -->
<header class="header-container" id="mainHeader">
    <div class="header__top">
        <a href="${pageContext.request.contextPath}/main.action" class="main-logo-link">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" class="logo" />
        </a>
        <div class="top__menu">
            <c:choose>
                <c:when test="${not empty sessionScope.loginAdmin}">
                    <span class="header-nickname">${sessionScope.loginAdmin.adminId} 관리자님</span>
                    <button type="submit" class="btn-admin-page"
                            onclick="location.href='${pageContext.request.contextPath}/admin-main.action'">관리자 페이지</button>
                    <a href="${pageContext.request.contextPath}/admin-logout.action"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
                    <a href="#">사이트맵</a>
                </c:when>

                <c:when test="${isUser}">
                    <c:set var="user" value="${sessionScope.loginUser}" />
                    <span class="header-nickname">${user.nickname} 님</span>
                    <button class="add-equip"
                            onclick="location.href='${pageContext.request.contextPath}/equipregister-majorcategory.action'">내 장비 등록</button>
                    <a href="${pageContext.request.contextPath}/logout.action"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
                    <a href="#">사이트맵</a>
                </c:when>

                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login-user.action">로그인</a>
                    <a href="${pageContext.request.contextPath}/registeruser-tel.action">회원가입</a>
                    <a href="#">사이트맵</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="header__bottom">
        <div class="toggle-menu">
            <button id="categoryToggleMain">
                <i class="fa-solid fa-bars"></i>카테고리
            </button>

            <!-- 카테고리 드롭다운 메뉴 -->
            <div class="category-dropdown" id="categoryDropdownMain">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/rentalsearch-main.action">ALL</a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/rentalsearch-main.action">브랜드</a>
                        <ul class="left-category-sub">
                            <li><a href="${pageContext.request.contextPath}/rentalsearch-main.action">ALL</a></li>
                            <li><a href="#">가나다</a></li>
                            <li><a href="#">라바사</a></li>
                            <li><a href="#">아자카</a></li>
                            <li><a href="#">타파하</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">텐트/쉘터</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">텐트</a></li>
                            <li><a href="#">쉘터/타프</a></li>
                            <li><a href="#">설치용부속품</a></li>
                            <li><a href="#">보조텐트류</a></li>
                            <li><a href="#">바닥보호시트</a></li>
                            <li><a href="#">기타용품</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">조명/전력장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">랜턴</a></li>
                            <li><a href="#">헤드랜턴</a></li>
                            <li><a href="#">전원장치</a></li>
                            <li><a href="#">기타조명</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">조리장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">버너/스토브</a></li>
                            <li><a href="#">취사도구</a></li>
                            <li><a href="#">식기류</a></li>
                            <li><a href="#">수납용품</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">냉/난방장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">아이스박스</a></li>
                            <li><a href="#">난로/히터</a></li>
                            <li><a href="#">선풍기/서큘레이터</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">수납/운반용품</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">캐리어/카트</a></li>
                            <li><a href="#">수납박스</a></li>
                            <li><a href="#">테이블수납</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">기타장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">의자/테이블</a></li>
                            <li><a href="#">침구류</a></li>
                            <li><a href="#">캠핑소품</a></li>
                            <li><a href="#">기타</a></li>
                        </ul>
                    </li>
                </ul>
            </div>

            <div class="toggle-container">
                <input type="radio" name="toggle" id="trade-radio" class="toggle-radio" checked />
                <input type="radio" name="toggle" id="community-radio" class="toggle-radio" />
                <div class="toggle-slider"></div>
                <div class="toggle-options">
                    <a href="${pageContext.request.contextPath}/main.action" class="toggle-option trade-option">거래</a>
                    <a href="${pageContext.request.contextPath}/boardmain.action" class="toggle-option community-option">커뮤니티</a>
                </div>
            </div>
        </div>

        <c:if test="${isUser}">
            <div class="user-menu">
                <!-- 종 아이콘과 알림 카운트 (수정된 부분) -->
                <div class="notification-wrapper">
                    <a href="#" class="notification-link">
                        <div class="header__notification">
                            <i class="fa-solid fa-bell" id="notiBell" style="height: 20px !important; width: auto !important; font-size: 20px !important;"></i>
                            <span id="notiCount" class="noti-count-badge">0</span>
                        </div>
                        <span>알림</span>
                    </a>
                    <!-- 알림 영역 (초기 숨김) -->
                    <div id="notiBox" class="noti-dropdown-container" style="display: none;"></div>
                </div>
                <a href="#" class="notification-link">
                    <div class="header__notification">
                        <i class="fa-solid fa-bell" id="notiBell" style="height: 20px !important; width: auto !important; font-size: 20px !important;"></i>
                        <span id="notiCount" class="noti-count-badge">0</span>
                    </div>
                    <span>알림</span>
                </a>
                <!-- 알림 영역 (초기 숨김) -->
                <div id="notiBox" style="display: none;"></div>
                <a href="${pageContext.request.contextPath}/mypage-main.action"><i class="fa-solid fa-user" style="height: 20px !important; width: auto !important; font-size: 20px !important;"></i> <span>마이페이지</span></a>
                <a href="${pageContext.request.contextPath}/mypage-diary.action"><i class="fa-solid fa-book" style="height: 20px !important; width: auto !important; font-size: 20px !important;"></i> <span>캠핑일지</span></a>
            </div>
        </c:if>
    </div>
</header>

<!-- 미니 헤더 - 완전히 독립된 구조 -->
<div class="mini-header" id="miniHeader" style="display: none; opacity: 0;">
    <div class="left-wrap">
        <!-- 카테고리 버튼 독립 -->
        <div style="position: relative; z-index: 99998;">
            <button id="categoryToggleMini" class="standalone-button">
                <i class="fa-solid fa-bars"></i>
            </button>

            <!-- 미니 헤더용 카테고리 드롭다운 -->
            <div class="category-dropdown" id="categoryDropdownMini">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/rentalsearch-main.action">ALL</a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/rentalsearch-main.action">브랜드</a>
                        <ul class="left-category-sub">
                            <li><a href="${pageContext.request.contextPath}/rentalsearch-main.action">ALL</a></li>
                            <li><a href="#">가나다</a></li>
                            <li><a href="#">라바사</a></li>
                            <li><a href="#">아자카</a></li>
                            <li><a href="#">타파하</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">텐트/쉘터</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">텐트</a></li>
                            <li><a href="#">쉘터/타프</a></li>
                            <li><a href="#">설치용부속품</a></li>
                            <li><a href="#">보조텐트류</a></li>
                            <li><a href="#">바닥보호시트</a></li>
                            <li><a href="#">기타용품</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">조명/전력장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">랜턴</a></li>
                            <li><a href="#">헤드랜턴</a></li>
                            <li><a href="#">전원장치</a></li>
                            <li><a href="#">기타조명</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">조리장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">버너/스토브</a></li>
                            <li><a href="#">취사도구</a></li>
                            <li><a href="#">식기류</a></li>
                            <li><a href="#">수납용품</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">냉/난방장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">아이스박스</a></li>
                            <li><a href="#">난로/히터</a></li>
                            <li><a href="#">선풍기/서큘레이터</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">수납/운반용품</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">캐리어/카트</a></li>
                            <li><a href="#">수납박스</a></li>
                            <li><a href="#">테이블수납</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">기타장비</a>
                        <ul class="left-category-sub">
                            <li><a href="#">ALL</a></li>
                            <li><a href="#">의자/테이블</a></li>
                            <li><a href="#">침구류</a></li>
                            <li><a href="#">캠핑소품</a></li>
                            <li><a href="#">기타</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 로고 독립 -->
        <a href="${pageContext.request.contextPath}/main.action" class="standalone-logo-link">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" class="logo" />
        </a>

        <!-- 토글 컨테이너 -->
        <div class="toggle-container">
            <input type="radio" name="toggle-mini" id="trade-radio-mini" class="toggle-radio" checked />
            <input type="radio" name="toggle-mini" id="community-radio-mini" class="toggle-radio" />
            <div class="toggle-slider"></div>
            <div class="toggle-options">
                <a href="${pageContext.request.contextPath}/main.action" class="toggle-option trade-option">거래</a>
                <a href="${pageContext.request.contextPath}/boardmain.action" class="toggle-option community-option">커뮤니티</a>
            </div>
        </div>
    </div>
    <div class="mini-menu">
        <c:choose>
            <c:when test="${not empty sessionScope.loginAdmin}">
                <span class="header-nickname">${sessionScope.loginAdmin.adminId} 관리자님</span>
                <button type="submit" class="btn-admin-page"
                        onclick="location.href='${pageContext.request.contextPath}/admin-main.action'">관리자 페이지</button>
                <a href="${pageContext.request.contextPath}/admin-logout.action"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
                <a href="#">사이트맵</a>
            </c:when>

            <c:when test="${isUser}">
                <c:set var="user" value="${sessionScope.loginUser}" />
                <span class="header-nickname">${user.nickname} 님</span>
                <button class="add-equip"
                        onclick="location.href='${pageContext.request.contextPath}/equipregister-majorcategory.action'">내 장비 등록</button>
                <a href="${pageContext.request.contextPath}/logout.action"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
                <!-- 종 아이콘과 알림 카운트 (미니 헤더용) -->
                <div class="notification-wrapper mini">
                    <a href="#" class="notification-link mini">
                        <div class="header__notification">
                            <i class="fa-solid fa-bell" id="notiBellMini" style="position: relative; cursor: pointer;"></i>
                            <span id="notiCountMini" class="noti-count-badge">0</span>
                        </div>
                    </a>
                    <!-- 알림 영역 (초기 숨김) -->
                    <div id="notiBoxMini" class="noti-dropdown-container" style="display: none;"></div>
                </div>
                <a href="#" class="notification-link">
                    <div class="header__notification">
                        <i class="fa-solid fa-bell" id="notiBellMini" style="position: relative; cursor: pointer;"></i>
                        <span id="notiCountMini" class="noti-count-badge">0</span>
                    </div>
                </a>
                <div id="notiBoxMini" style="display: none; position: fixed; z-index: 9999;"></div>
                <div id="notiBox" style="display: none; position: absolute; top: 100%; right: 0;"></div>
                <a href="${pageContext.request.contextPath}/mypage-main.action"><i class="fa-solid fa-user"></i></a>
                <a href="${pageContext.request.contextPath}/mypage-diary.action"><i class="fa-solid fa-book"></i></a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login-user.action">로그인</a>
                <a href="${pageContext.request.contextPath}/registerUser-tel.action">회원가입</a>
                <a href="#">사이트맵</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    // 알림 관련 JS
    document.addEventListener("DOMContentLoaded", function() {
        const isUser = ${isUser};  // JSP에서 ${isUser} 값을 JavaScript로 전달

        if (isUser) {

            // 메인 헤더 알림 요소
            const notiLink = document.querySelector('.notification-link');
            const notiBox = document.getElementById("notiBox");
            const notiCount = document.getElementById("notiCount");

            // 미니 헤더 알림 요소
            const notiLinkMini = document.querySelector('.notification-link.mini');
            const notiBoxMini = document.getElementById("notiBoxMini");
            const notiCountMini = document.getElementById("notiCountMini");

            // 메인 헤더 알림창 토글
            if (notiLink && notiBox && notiCount) {
                notiLink.addEventListener("click", function(e) {
                    e.preventDefault();
                    e.stopPropagation();

                    if (notiBox.style.display === "none" || notiBox.style.display === "") {
                        // 알림창 로드 및 표시
            const notiLink = document.querySelector('.notification-link');
            const notiBox = document.getElementById("notiBox");
            const notiCount = document.getElementById("notiCount");
            const notiBellMini = document.getElementById("notiBellMini");
            const notiBoxMini = document.getElementById("notiBoxMini");
            const notiCountMini = document.getElementById("notiCountMini");

            // 메인 헤더 알림창 toggle
            if (notiLink && notiBox && notiCount) {
                notiLink.addEventListener("click", (e) => {
                    e.preventDefault(); // 링크 기본 동작 방지
                    e.stopPropagation(); // 이벤트 버블링 방지

                    if (notiBox.style.display === "none" || notiBox.style.display === "") {
                        // 위치 조정: 알림 아이콘 바로 아래에 표시
                        const rect = notiLink.getBoundingClientRect();
                        notiBox.style.top = `${rect.bottom}px`;
                        notiBox.style.right = `${window.innerWidth - rect.right}px`;

                        fetch("/noti.action")
                            .then(res => res.text())
                            .then(html => {
                                notiBox.innerHTML = html;
                                notiBox.style.display = "block";

                                // 미니 헤더의 알림창은 닫기
                                if (notiBoxMini) notiBoxMini.style.display = "none";
                            });
                    } else {
                        notiBox.style.display = "none";
                    }
                });
            }

            // 미니 헤더 알림창 토글
            if (notiLinkMini && notiBoxMini && notiCountMini) {
                notiLinkMini.addEventListener("click", function(e) {
                    e.preventDefault();
                    e.stopPropagation();

                    if (notiBoxMini.style.display === "none" || notiBoxMini.style.display === "") {
                        // 알림창 로드 및 표시
                        fetch("/noti.action")
                            .then(res => res.text())
                            .then(html => {
                                notiBoxMini.innerHTML = html;
                                notiBoxMini.style.display = "block";

                                // 메인 헤더의 알림창은 닫기
                                if (notiBox) notiBox.style.display = "none";
                            });
                    } else {
                        notiBoxMini.style.display = "none";
                    }
                });
            // 미니 헤더 알림창 toggle (동일한 방식으로 구현)
            if (notiBellMini && notiBoxMini && notiCountMini) {
                const miniNotiLink = notiBellMini.closest('.notification-link');
                if (miniNotiLink) {
                    miniNotiLink.addEventListener("click", (e) => {
                        e.preventDefault();
                        e.stopPropagation();

                        if (notiBoxMini.style.display === "none" || notiBoxMini.style.display === "") {
                            // 위치 조정: 알림 아이콘 바로 아래에 표시
                            const rect = miniNotiLink.getBoundingClientRect();
                            notiBoxMini.style.position = "fixed";
                            notiBoxMini.style.top = `${rect.bottom}px`;
                            notiBoxMini.style.right = `${window.innerWidth - rect.right}px`;

                            fetch("/noti.action")
                                .then(res => res.text())
                                .then(html => {
                                    notiBoxMini.innerHTML = html;
                                    notiBoxMini.style.display = "block";
                                });
                        } else {
                            notiBoxMini.style.display = "none";
                        }
                    });
                }
            }

            // 페이지 로딩 시 읽지 않은 알림 수 가져오기
            fetch("/noti/count.action")
                .then(res => res.text())
                .then(count => {
                    const countNum = parseInt(count);
                    if (countNum > 0) {
                    if (parseInt(count) > 0) {
                        // 메인 헤더와 미니 헤더의 알림 카운트 모두 업데이트
                        if (notiCount) {
                            notiCount.textContent = count;
                            notiCount.style.display = "inline-block";
                        }
                        if (notiCountMini) {
                            notiCountMini.textContent = count;
                            notiCountMini.style.display = "inline-block";
                        }
                    } else {
                        if (notiCount) notiCount.style.display = "none";
                        if (notiCountMini) notiCountMini.style.display = "none";
                    }
                });

            // 외부 클릭 시 알림창 닫기
            document.addEventListener("click", function(e) {
                // 메인 헤더 알림 영역 외부 클릭
                if (notiBox && notiLink &&
                    !notiBox.contains(e.target) &&
                    !notiLink.contains(e.target)) {
                    notiBox.style.display = "none";
                }

                // 미니 헤더 알림 영역 외부 클릭
                if (notiBoxMini && notiLinkMini &&
                    !notiBoxMini.contains(e.target) &&
                    !notiLinkMini.contains(e.target)) {
            document.addEventListener("click", (e) => {
                if (notiBox && notiLink && !notiBox.contains(e.target) && !notiLink.contains(e.target)) {
                    notiBox.style.display = "none";
                }
                if (notiBoxMini && notiBellMini && !notiBoxMini.contains(e.target) && !notiBellMini.closest('.notification-link').contains(e.target)) {
                    notiBoxMini.style.display = "none";
                }
            });
        }
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        let notiVisible = false;

        $('#notiBell').click(function (e) {
            e.preventDefault();

            if (notiVisible) {
                $('#notiPopupArea').hide();
                notiVisible = false;
            } else {
                $('#notiPopupArea').load('${pageContext.request.contextPath}/noti.action', function () {
                    $(this).show();
                    notiVisible = true;
                    $.ajax({
                        url: '${pageContext.request.contextPath}/noti-read.action',
                        method: 'POST'
                    });
                });
            }
        });

        // 외부 클릭 시 알림창 닫기
        document.addEventListener("click", function(e) {
            const notiLink = document.querySelector('.notification-link');
            const notiBox = document.getElementById("notiBox");

            if (notiLink && notiBox) {
                if (!notiBox.contains(e.target) && !notiLink.contains(e.target)) {
                    notiBox.style.display = "none";
                }
            }
        });

        const path = window.location.pathname;

        const miniHeader = document.getElementById("miniHeader");
        const mainHeader = document.getElementById("mainHeader");

        const categoryDropdownMain = document.getElementById("categoryDropdownMain");
        const categoryToggleMain = document.getElementById("categoryToggleMain");
        const categoryDropdownMini = document.getElementById("categoryDropdownMini");
        const categoryToggleMini = document.getElementById("categoryToggleMini");

        // ===== (1) 렌탈 검색 메인에서는 기본적으로 항상 펼쳐진 상태 유지 (메인 + 미니) =====
        if (path.includes("rentalsearch-main.action")) {
            const style = document.createElement("style");
            style.textContent = `
        #categoryDropdownMain,
        #categoryDropdownMini {
            display: block !important;
            opacity: 1 !important;
            visibility: visible !important;
            transition: none !important;
        }
        .category-dropdown {
            transition: none !important;
        }
    `;
            document.head.appendChild(style);

            // 위치 조정 (메인)
            if (categoryDropdownMain && categoryToggleMain) {
                requestAnimationFrame(() => {
                    const buttonRect = categoryToggleMain.getBoundingClientRect();
                    const parentRect = categoryToggleMain.parentElement.getBoundingClientRect();
                    categoryDropdownMain.style.top = (buttonRect.bottom - parentRect.top) + 'px';
                    categoryDropdownMain.style.left = (buttonRect.left - parentRect.left) + 'px';
                });
            }

            // 위치 조정 (미니)
            if (categoryDropdownMini && categoryToggleMini) {
                requestAnimationFrame(() => {
                    const toggleBtnRect = categoryToggleMini.getBoundingClientRect();
                    categoryDropdownMini.style.position = 'fixed'; // 고정 포지션 사용
                    categoryDropdownMini.style.top = `${toggleBtnRect.bottom}px`;  // 버튼 바로 아래
                    categoryDropdownMini.style.left = `${toggleBtnRect.left}px`;   // 버튼과 왼쪽 정렬
                    categoryDropdownMini.style.zIndex = '999999'; // z-index 확실하게 높이기
                });
            }
        }

        // ===== (2) 탭 토글 라디오 상태 설정 =====
        const currentPath = window.location.pathname;

        // board 관련 외에도 커뮤니티성 페이지를 포함시킴
        const isCommunityPage =
            currentPath.includes("board") ||
            currentPath.includes("notice") ||
            currentPath.includes("event") ||
            currentPath.includes("faq") ||
            currentPath.includes("qna");

        if (isCommunityPage) {
            document.getElementById("community-radio").checked = true;
            document.getElementById("community-radio-mini").checked = true;
        } else {
            document.getElementById("trade-radio").checked = true;
            document.getElementById("trade-radio-mini").checked = true;
        }

        // ===== (3) 탭 클릭 이벤트 (거래/커뮤니티) =====
        const tradeOption = document.querySelectorAll(".trade-option");
        const communityOption = document.querySelectorAll(".community-option");

        tradeOption.forEach(el => {
            el.addEventListener("click", function(e) {
                e.preventDefault();
                document.getElementById("trade-radio").checked = true;
                document.getElementById("trade-radio-mini").checked = true;
                setTimeout(() => {
                    window.location.href = this.getAttribute("href");
                }, 300);
            });
        });

        communityOption.forEach(el => {
            el.addEventListener("click", function(e) {
                e.preventDefault();
                document.getElementById("community-radio").checked = true;
                document.getElementById("community-radio-mini").checked = true;
                setTimeout(() => {
                    window.location.href = this.getAttribute("href");
                }, 300);
            });
        });

        // ===== (4) 헤더 토글 클릭 시 메뉴 열기/닫기 =====
        categoryToggleMain.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();
            const dropdown = categoryDropdownMain;
            const rect = this.getBoundingClientRect();
            const parent = this.parentElement.getBoundingClientRect();

            if (dropdown.classList.contains("active")) {
                dropdown.classList.remove("active");
                dropdown.style.display = 'none';
            } else {
                dropdown.classList.add("active");
                dropdown.style.display = 'block';
                dropdown.style.top = (rect.bottom - parent.top) + 'px';
                dropdown.style.left = (rect.left - parent.left) + 'px';
                categoryDropdownMini.classList.remove("active");
                categoryDropdownMini.style.display = 'none';
            }
        });

        categoryToggleMini.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            const dropdown = categoryDropdownMini;

            if (dropdown.classList.contains("active")) {
                dropdown.classList.remove("active");
                dropdown.style.display = 'none';
            } else {
                dropdown.classList.add("active");
                dropdown.style.display = 'block';

                // 버튼 위치 기준으로 드롭다운 위치 계산
                const rect = this.getBoundingClientRect();
                dropdown.style.position = 'fixed';
                dropdown.style.top = rect.bottom + 'px';
                dropdown.style.left = rect.left + 'px';
                dropdown.style.zIndex = '999999';

                categoryDropdownMain.classList.remove("active");
                categoryDropdownMain.style.display = 'none';
            }
        });


        // ===== (5) 외부 클릭 시 드롭다운 닫기 =====
        document.addEventListener("click", function(e) {
            if (!categoryToggleMain.contains(e.target) && !categoryDropdownMain.contains(e.target)) {
                categoryDropdownMain.classList.remove("active");
                categoryDropdownMain.style.display = 'none';
            }
            if (!categoryToggleMini.contains(e.target) && !categoryDropdownMini.contains(e.target)) {
                categoryDropdownMini.classList.remove("active");
                categoryDropdownMini.style.display = 'none';
            }
        });

        // ===== (6) 서브카테고리 마우스오버 =====
        document.querySelectorAll('.category-dropdown > ul > li').forEach(item => {
            item.addEventListener('mouseenter', function() {
                const subMenu = this.querySelector('.left-category-sub');
                if (subMenu) {
                    const rect = this.getBoundingClientRect();
                    subMenu.style.top = rect.top + 'px';
                    subMenu.style.left = rect.right + 'px';
                    subMenu.style.display = 'block';
                }
            });
            item.addEventListener('mouseleave', function() {
                const subMenu = this.querySelector('.left-category-sub');
                if (subMenu) {
                    subMenu.style.display = 'none';
                }
            });
        });

        // ===== (7) 스크롤 시 헤더 전환 처리 (메인 ↔ 미니) =====
        window.addEventListener("scroll", function() {
            const scrollY = window.scrollY;

            if (scrollY > 150) {
                miniHeader.style.display = "flex";
                setTimeout(() => {
                    miniHeader.style.opacity = "1";
                    mainHeader.style.opacity = "0";
                    mainHeader.style.pointerEvents = "none";
                    categoryDropdownMain.classList.remove("active");
                }, 10);
            } else {
                miniHeader.style.opacity = "0";
                mainHeader.style.opacity = "1";
                mainHeader.style.pointerEvents = "auto";
                categoryDropdownMini.classList.remove("active");
                setTimeout(() => {
                    if (window.scrollY <= 150) {
                        miniHeader.style.display = "none";
                    }
                }, 300);
            }
        }, { passive: true });

        // ===== (8) 초기 로딩 시 헤더 상태 설정 =====
        if (window.scrollY > 150) {
            miniHeader.style.display = "flex";
            miniHeader.style.opacity = "1";
            mainHeader.style.opacity = "0";
            mainHeader.style.pointerEvents = "none";
        }
    });
</script>

</body>
</html>