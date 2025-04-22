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
                <a href="#"><i class="fa-solid fa-bell" style="height: 20px !important; width: auto !important; font-size: 20px !important;"></i> <span>알림</span></a>
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
                <a href="#"><i class="fa-solid fa-bell"></i></a>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const miniHeader = document.getElementById("miniHeader");
        const mainHeader = document.getElementById("mainHeader");
        const categoryDropdownMain = document.getElementById("categoryDropdownMain");
        const categoryDropdownMini = document.getElementById("categoryDropdownMini");
        const categoryToggleMain = document.getElementById("categoryToggleMain");
        const categoryToggleMini = document.getElementById("categoryToggleMini");

        // 현재 URL 기반으로 토글 상태 설정
        const currentPath = window.location.pathname;
        const isCommunityPage = currentPath.includes("boardmain") || currentPath.includes("board");

        // 메인 토글 설정
        if(isCommunityPage) {
            document.getElementById("community-radio").checked = true;
        } else {
            document.getElementById("trade-radio").checked = true;
        }

        // 미니 토글 설정
        if(isCommunityPage) {
            document.getElementById("community-radio-mini").checked = true;
        } else {
            document.getElementById("trade-radio-mini").checked = true;
        }

        // 토글 클릭 이벤트 처리
        const tradeOption = document.querySelectorAll(".trade-option");
        const communityOption = document.querySelectorAll(".community-option");

        tradeOption.forEach(element => {
            element.addEventListener("click", function(e) {
                e.preventDefault();
                document.getElementById("trade-radio").checked = true;
                document.getElementById("trade-radio-mini").checked = true;

                // 애니메이션 시간 후 페이지 이동
                setTimeout(() => {
                    window.location.href = this.getAttribute("href");
                }, 300);
            });
        });

        communityOption.forEach(element => {
            element.addEventListener("click", function(e) {
                e.preventDefault();
                document.getElementById("community-radio").checked = true;
                document.getElementById("community-radio-mini").checked = true;

                // 애니메이션 시간 후 페이지 이동
                setTimeout(() => {
                    window.location.href = this.getAttribute("href");
                }, 300);
            });
        });

        // 메인 헤더 카테고리 버튼 클릭 이벤트
        categoryToggleMain.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();

            const dropdown = categoryDropdownMain;
            const buttonRect = this.getBoundingClientRect();
            const parentRect = this.parentElement.getBoundingClientRect();

            if (dropdown.classList.contains("active")) {
                dropdown.classList.remove("active");
                dropdown.style.display = 'none'; // ← 닫힐 때 display도 없애줘야 함
            } else {
                dropdown.classList.add("active");
                dropdown.style.display = 'block';
                dropdown.style.top = (buttonRect.bottom - parentRect.top) + 'px';
                dropdown.style.left = (buttonRect.left - parentRect.left) + 'px';
                categoryDropdownMini.classList.remove("active");
                categoryDropdownMini.style.display = 'none';
            }
        });

        // 미니 헤더 카테고리 버튼 클릭 이벤트
        categoryToggleMini.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();

            const dropdown = categoryDropdownMini;
            const buttonRect = this.getBoundingClientRect();
            const parentRect = this.parentElement.getBoundingClientRect();

            if (dropdown.classList.contains("active")) {
                dropdown.classList.remove("active");
                dropdown.style.display = 'none';
            } else {
                dropdown.classList.add("active");
                dropdown.style.display = 'block';
                dropdown.style.top = (buttonRect.bottom - parentRect.top + 4) + 'px';
                dropdown.style.left = (buttonRect.left - parentRect.left) + 'px';
                categoryDropdownMain.classList.remove("active");
                categoryDropdownMain.style.display = 'none';
            }
        });

        // 서브메뉴에 대한 마우스오버 이벤트 리스너 수정
        document.querySelectorAll('.category-dropdown > ul > li').forEach(item => {
            item.addEventListener('mouseenter', function() {
                const subMenu = this.querySelector('.left-category-sub');
                if (subMenu) {
                    const itemRect = this.getBoundingClientRect();
                    subMenu.style.top = itemRect.top + 'px';
                    subMenu.style.left = (itemRect.right + 2) + 'px'; // 약간의 간격 추가
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

        // 드롭다운 외부 클릭 시 닫기
        document.addEventListener("click", function(e) {
            // 메인 헤더 카테고리 드롭다운
            if (!categoryToggleMain.contains(e.target) && !categoryDropdownMain.contains(e.target)) {
                categoryDropdownMain.classList.remove("active");
                categoryDropdownMain.style.display = 'none';
            }

            // 미니 헤더 카테고리 드롭다운
            if (!categoryToggleMain.contains(e.target) && !categoryDropdownMain.contains(e.target)) {
                categoryDropdownMain.classList.remove("active");
                categoryDropdownMain.style.display = 'none';
            }
        });

        // 스크롤 기반 헤더 전환
        window.addEventListener("scroll", function() {
            const scrollY = window.scrollY;

            if (scrollY > 150) {
                // 스크롤 다운: 미니 헤더 표시, 메인 헤더 숨김
                miniHeader.style.display = "flex";
                setTimeout(() => {
                    miniHeader.style.opacity = "1";
                    mainHeader.style.opacity = "0";
                    mainHeader.style.pointerEvents = "none";

                    // 드롭다운 닫기
                    categoryDropdownMain.classList.remove("active");
                }, 10); // 약간의 지연으로 트랜지션 적용
            } else {
                // 스크롤 업: 메인 헤더 표시, 미니 헤더 숨김
                miniHeader.style.opacity = "0";
                mainHeader.style.opacity = "1";
                mainHeader.style.pointerEvents = "auto";

                // 드롭다운 닫기
                categoryDropdownMini.classList.remove("active");

                // 트랜지션 후 미니 헤더 완전히 숨김
                setTimeout(() => {
                    if (window.scrollY <= 150) { // 중간에 다시 스크롤 내려갔는지 확인
                        miniHeader.style.display = "none";
                    }
                }, 300); // 트랜지션 시간과 일치
            }
        }, { passive: true });

        // 초기 상태 설정
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