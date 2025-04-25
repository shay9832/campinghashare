<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>header.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>
<header class="header-container">
    <div class="header__top">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="CampingHaShare" class="logo" />
        <div class="top__menu">
            <button href="#" class="add-equip">내 장비 등록</button> <a href="#">로그인</a>
            <a href="#">회원가입</a> <a href="#">사이트맵</a>
        </div>
    </div>
    <div class="header__bottom">
        <div class="toggle-menu">
            <button>
                <i class="fa-solid fa-bars"></i>카테고리
            </button>
            <div class="toggle-container">
                <input type="radio" name="toggle" id="trade-radio"
                       class="toggle-radio" checked /> <input
                    type="radio" name="toggle" id="community-radio"
                    class="toggle-radio">
                <div class="toggle-slider"></div>
                <div class="toggle-options">
                    <label for="trade-radio" class="toggle-option trade-option">거래</label>
                    <label for="community-radio"
                           class="toggle-option community-option">커뮤니티</label>
                </div>
            </div>
        </div>
        <div class="user-menu">
            <a href=""><i class="fa-solid fa-bell" style="font-size: 20px;"></i> <span>알림</span></a>
            <a href=""><i class="fa-solid fa-user" style="font-size: 20px;"></i> <span>마이페이지</span></a>
            <a href=""><i class="fa-solid fa-book" style="font-size: 20px;"></i> <span>캠핑일지</span></a>
        </div>
    </div>
</header>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

</body>
</html>