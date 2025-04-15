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

<!-- 사이드바 -->
<div class="category-sidebar" id="categorySidebar">
    <button class="sidebar-close" id="sidebarClose"><i class="fa-solid fa-xmark"></i></button>
    <ul>
        <li><a href="#">ALL</a></li>
        <li>
            <a href="#">브랜드</a>
            <ul class="left-category-sub">
                <li><a href="#">ALL</a></li>
                <li><a href="#">가나다</a></li>
                <li><a href="#">라바사</a></li>
            </ul>
        </li>
        <li>
            <a href="#">텐트/쉘터</a>
            <ul class="left-category-sub">
                <li><a href="#">ALL</a></li>
                <li><a href="#">텐트</a></li>
                <li><a href="#">타프</a></li>
            </ul>
        </li>
    </ul>
</div>
<div class="sidebar-backdrop" id="sidebarBackdrop"></div>

<!-- 미니 헤더 -->
<div class="mini-header" id="miniHeader">
    <div class="left-wrap">
        <div class="toggle-menu">
            <button id="categoryToggleMini">
                <i class="fa-solid fa-bars"></i>
            </button>
            <a href="/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" class="logo" /></a>
            <div class="toggle-container">
                <input type="radio" name="toggle-mini" id="trade-radio-mini" class="toggle-radio" checked />
                <input type="radio" name="toggle-mini" id="community-radio-mini" class="toggle-radio" />
                <div class="toggle-slider"></div>
                <div class="toggle-options">
                    <label for="trade-radio-mini" class="toggle-option trade-option">거래</label>
                    <label for="community-radio-mini" class="toggle-option community-option">커뮤니티</label>
                </div>
            </div>
        </div>
    </div>
    <div class="mini-menu">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <span>${sessionScope.loginUser.nickname} 님</span>
                <button class="add-equip" onclick="location.href='${pageContext.request.contextPath}/equip-register.action'">내 장비 등록</button>
                <a href="${pageContext.request.contextPath}/notifications.action"><i class="fa-solid fa-bell"></i> 알림</a>
                <a href="${pageContext.request.contextPath}/mypage-main.action"><i class="fa-solid fa-user"></i> 마이페이지</a>
                <a href="${pageContext.request.contextPath}/mypage-diary.action"><i class="fa-solid fa-book"></i> 캠핑일지</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login-user.action">로그인</a>
                <a href="${pageContext.request.contextPath}/registeruser-tel.action">회원가입</a>
                <a href="${pageContext.request.contextPath}/sitemap.jsp">사이트맵</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 메인 헤더 -->
<header class="header-container" id="mainHeader">
    <div class="header__top">
        <a href="/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" class="logo" /></a>
        <div class="top__menu">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span>${sessionScope.loginUser.nickname} 님</span>
                    <button class="add-equip" onclick="location.href='${pageContext.request.contextPath}/register-equip.action'">내 장비 등록</button>
                    <a href="${pageContext.request.contextPath}/logout.action">로그아웃</a>
                    <a href="${pageContext.request.contextPath}/sitemap.jsp">사이트맵</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login-user.action">로그인</a>
                    <a href="${pageContext.request.contextPath}/registeruser-tel.action">회원가입</a>
                    <a href="${pageContext.request.contextPath}/sitemap.jsp">사이트맵</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="header__bottom">
        <div class="toggle-menu">
            <button id="categoryToggleMain">
                <i class="fa-solid fa-bars"></i>카테고리
            </button>
            <div class="toggle-container">
                <input type="radio" name="toggle" id="trade-radio" class="toggle-radio" checked />
                <input type="radio" name="toggle" id="community-radio" class="toggle-radio" />
                <div class="toggle-slider"></div>
                <div class="toggle-options">
                    <label for="trade-radio" class="toggle-option trade-option">거래</label>
                    <label for="community-radio" class="toggle-option community-option">커뮤니티</label>
                </div>
            </div>
        </div>
        <c:if test="${not empty sessionScope.loginUser}">
            <div class="user-menu">
                <a href="${pageContext.request.contextPath}/notifications.action">
                    <i class="fa-solid fa-bell"></i> <span>알림</span>
                </a>
                <a href="${pageContext.request.contextPath}/mypage-main.action">
                    <i class="fa-solid fa-user"></i> <span>마이페이지</span>
                </a>
                <a href="${pageContext.request.contextPath}/mypage-diary.action">
                    <i class="fa-solid fa-book"></i> <span>캠핑일지</span>
                </a>
            </div>
        </c:if>
    </div>
</header>

<script>
    const miniHeader = document.getElementById("miniHeader");
    const mainHeader = document.getElementById("mainHeader");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            mainHeader.classList.add("hidden");
            miniHeader.classList.add("active");
        } else {
            mainHeader.classList.remove("hidden");
            miniHeader.classList.remove("active");
        }
    });

    const sidebar = document.getElementById("categorySidebar");
    const backdrop = document.getElementById("sidebarBackdrop");

    const toggleMain = document.getElementById("categoryToggleMain");
    if (toggleMain) {
        toggleMain.addEventListener("click", () => {
            sidebar.classList.add("active");
            backdrop.classList.add("active");
        });
    }

    const toggleMini = document.getElementById("categoryToggleMini");
    if (toggleMini) {
        toggleMini.addEventListener("click", () => {
            sidebar.classList.add("active");
            backdrop.classList.add("active");
        });
    }

    const closeBtn = document.getElementById("sidebarClose");
    if (closeBtn) {
        closeBtn.addEventListener("click", () => {
            sidebar.classList.remove("active");
            backdrop.classList.remove("active");
        });
    }

    if (backdrop) {
        backdrop.addEventListener("click", () => {
            sidebar.classList.remove("active");
            backdrop.classList.remove("active");
        });
    }

    document.querySelectorAll('.category-sidebar li').forEach((item) => {
        item.addEventListener('mouseenter', () => {
            const sub = item.querySelector('.left-category-sub');
            if (sub) sub.style.display = 'block';
        });

        item.addEventListener('mouseleave', () => {
            const sub = item.querySelector('.left-category-sub');
            if (sub) sub.style.display = 'none';
        });
    });
</script>

</body>
</html>
