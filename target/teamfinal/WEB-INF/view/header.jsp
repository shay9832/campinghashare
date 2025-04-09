<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
        <!-- 필요 시 추가 -->
    </ul>
</div>
<div class="sidebar-backdrop" id="sidebarBackdrop"></div>

<!-- 미니 헤더 -->
<div class="mini-header" id="miniHeader">
    <div class="left-wrap">
        <div class="toggle-menu">
            <button id="categoryToggleMain-mini">
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
        <button class="add-equip">내 장비 등록</button>
        <a href="#"><i class="fa-solid fa-bell"></i> 알림</a>
        <a href="#"><i class="fa-solid fa-user"></i> 마이페이지</a>
        <a href="#"><i class="fa-solid fa-book"></i> 캠핑일지</a>
    </div>
</div>

<!-- 메인 헤더 -->
<header class="header-container" id="mainHeader">
    <div class="header__top">
        <a href="/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" class="logo" /></a>
        <div class="top__menu">
            <button class="add-equip">내 장비 등록</button>
            <a href="#">로그인</a>
            <a href="#">회원가입</a>
            <a href="#">사이트맵</a>
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
        <div class="user-menu">
            <a href="#"><i class="fa-solid fa-bell"></i> <span>알림</span></a>
            <a href="#"><i class="fa-solid fa-user"></i> <span>마이페이지</span></a>
            <a href="#"><i class="fa-solid fa-book"></i> <span>캠핑일지</span></a>
        </div>
    </div>
</header>

<script>
    const miniHeader = document.getElementById("miniHeader");
    const mainHeader = document.getElementById("mainHeader");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            mainHeader.classList.add("hidden");
            miniHeader.style.display = "flex";
        } else {
            mainHeader.classList.remove("hidden");
            miniHeader.style.display = "none";
        }
    });

    const sidebar = document.getElementById("categorySidebar");
    const backdrop = document.getElementById("sidebarBackdrop");

    document.getElementById("categoryToggleMain").addEventListener("click", () => {
        sidebar.classList.add("active");
        backdrop.classList.add("active");
    });

    document.getElementById("categoryToggleMini").addEventListener("click", () => {
        sidebar.classList.add("active");
        backdrop.classList.add("active");
    });

    document.getElementById("sidebarClose").addEventListener("click", () => {
        sidebar.classList.remove("active");
        backdrop.classList.remove("active");
    });

    backdrop.addEventListener("click", () => {
        sidebar.classList.remove("active");
        backdrop.classList.remove("active");
    });

    // 서브메뉴 드롭
    $(".category-sidebar li").hover(function () {
        $(this).find(".left-category-sub").stop(true, true).slideDown(100);
    }, function () {
        $(this).find(".left-category-sub").stop(true, true).slideUp(100);
    });
</script>

</body>
</html>
