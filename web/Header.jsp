<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Noto Sans KR", sans-serif;
    }

    a {
        text-decoration: none;
        color: inherit;
    }


    .header-container {
        width: 100%;
        display: flex;
        flex-direction: column;
        border-bottom: 1px solid #e0e0e0;
    }

    .header__top {
        display: flex;
        justify-content: space-between;
        padding: 5px 20px;
    }

    .logo {
        height: 50px;
    }

    .top__menu {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .top__menu a {
        font-size: 12px;
        color: #666;
    }

    .top__menu button.add-equip {
        display: inline-block;
        background-color: #f2e8cf;
        color: #333;
        font-weight: 500;
        font-size: 12px;
        border-radius: 20px;
        padding: 2px 12px;
        line-height: 1.5;
        border: none;
        cursor: pointer;
    }

    .top__menu button.add-equip:hover {
        background-color: #e97451;
    }

    .header__bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
    }

    .toggle-menu {
        display: flex;
        gap: 15px;
        align-items: center;
    }

    .toggle-menu button {
        display: flex;
        align-items: center;
        gap: 8px;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 8px 15px;
        cursor: pointer;
        font-size: 14px;
    }

    .toggle-container {
        position: relative;
        width: 180px;
        height: 34px;
        border-radius: 17px;
        background-color: #e5e5e5;
        overflow: hidden;
    }

    .toggle-options {
        position: relative;
        display: flex;
        width: 100%;
        height: 100%;
        z-index: 2;
    }

    .toggle-option {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 14px;
        cursor: pointer;
        font-weight: bold;
        transition: color 0.3s;
    }

    .trade-option {
        color: #333;
    }

    .community-option {
        color: #555;
    }

    .toggle-slider {
        position: absolute;
        top: 0;
        left: 0;
        width: 50%;
        height: 100%;
        background-color: #e97451;
        border-radius: 17px;
        transition: all 0.3s ease;
        z-index: 1;
    }

    .toggle-radio {
        display: none;
    }

    #community-radio:checked ~ .toggle-slider {
        left: 50%;
        background-color: #2c5f2d;
    }

    #trade-radio:checked ~ .toggle-options .trade-option {
        color: #000;
    }

    #community-radio:checked ~ .toggle-options .trade-option {
        color: #555;
    }

    #community-radio:checked ~ .toggle-options .community-option {
        color: #fff;
    }

    .user-menu {
        display: flex;
        gap: 20px;
    }

    .user-menu a {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 12px;
        color: #333;
    }

    .user-menu i {
        font-size: 20px;
        margin-bottom: 3px;
    }

    @media ( max-width: 768px) {
        .top__menu {
            gap: 10px;
        }

        .toggle-container {
            width: 150px;
        }

        .user-menu {
            gap: 12px;
        }

        .user-menu span {
            display: none;
        }
    }

    @media ( max-width: 576px) {
        .toggle-container {
            display: none;
        }
    }
</style>
<header>
    <div class="header-container">
        <div class="header__top">
            <img src="images/logo.png" alt="CampingHaShare" class="logo"/>
            <div class="top__menu">
                <button href="#" class="add-equip">내 장비 등록</button>
                <a href="#">로그인</a> <a
                    href="#">회원가입</a> <a href="#">사이트맵</a>
            </div>
        </div>
        <div class="header__bottom">
            <div class="toggle-menu">
                <button>
                    <i class="fa-solid fa-bars"></i>카테고리
                </button>
                <div class="toggle-container">
                    <input type="radio" name="toggle" id="trade-radio"
                           class="toggle-radio" checked/> <input
                        type="radio" name="toggle" id="community-radio"
                        class="toggle-radio"/>
                    <div class="toggle-options">
                        <label for="trade-radio" class="toggle-option trade-option">거래</label>
                        <label for="community-radio"
                               class="toggle-option community-option">커뮤니티</label>
                    </div>
                    <div class="toggle-slider"></div>
                </div>
            </div>
            <div class="user-menu">
                <a href=""> <i class="fa-solid fa-bell"></i> <span>알림</span>
                </a> <a href=""> <i class="fa-solid fa-user"></i> <span>마이페이지</span>
            </a> <a href=""> <i class="fa-solid fa-book"></i> <span>캠핑일지</span>
            </a>
            </div>
        </div>
    </div>
</header>
