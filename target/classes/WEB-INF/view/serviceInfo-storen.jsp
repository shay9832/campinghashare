<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampingHaShare - 스토렌 서비스 설명</title>
  <!-- 외부 라이브러리 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
  <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
    }

    body {
      background-color: #f8f9fa;
      color: #333;
      line-height: 1.6;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    header {
      background-color: #fff;
      color: #333;
      padding: 20px 0;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 28px;
      font-weight: bold;
      color: var(--color-maple);
    }

    .nav-links {
      display: flex;
      list-style: none;
    }

    .nav-links li {
      margin-left: 30px;
    }

    .nav-links a {
      color: #333;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s;
    }

    .nav-links a:hover {
      color: var(--color-maple);
    }

    .login-btn, .signup-button {
      padding: 8px 16px;
      border-radius: 4px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      margin-left: 10px;
    }

    .login-btn {
      color: #333;
      border: 1px solid #ddd;
    }

    .signup-button {
      background-color: var(--color-maple);
      color: white;
    }

    .login-btn:hover {
      background-color: #f0f0f0;
    }

    .signup-button:hover {
      background-color: var(--color-maple);
    }

    .hero {
      background: linear-gradient(var(--color-beige-light), var(--color-beige)), url('/api/placeholder/1200/600') center/cover;
      padding: 100px 0;
      text-align: center;
    }

    .hero_text-contain-2 {
      margin-bottom: 30px;
    }

    .gradient-hero1, .gradient-hero2 {
      font-size: 48px;
      margin-bottom: 10px;
      font-weight: 700;
    }

    .gradient-hero1 {
      color: #333;
    }

    .gradient-hero2 {
      color: var(--color-maple);
    }

    .hero_p-wrap {
      max-width: 700px;
      margin: 0 auto 40px;
    }

    .hero_p-2 {
      font-size: 20px;
      color: #666;
      line-height: 1.6;
    }

    .hero_cta-button, .hero_cta-button-2 {
      display: inline-block;
      padding: 15px 40px;
      border-radius: 50px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      margin: 0 10px;
    }

    .hero_cta-button {
      background-color: var(--color-maple);
      color: white;
      border: none;
    }

    .hero_cta-button-2 {
      background-color: white;
      color: var(--color-maple);
      border: 1px solid var(--color-maple);
    }

    .hero_cta-button:hover {
      background-color: var(--color-maple);
      transform: translateY(-3px);
    }

    .hero_cta-button-2:hover {
      background-color: #fff5f5;
      transform: translateY(-3px);
    }

    .decks {
      padding: 80px 0;
      background-color: #fff;
      display: flex;
      align-items: center;
    }

    .decks__text {
      flex: 1;
      padding: 0 40px;
      font-style: normal;
    }

    .decks__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 20px;
      line-height: 1.3;
    }

    .decks__text-paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.6;
      margin-bottom: 20px;
    }

    .decks__wrapper {
      flex: 1;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
      padding: 0 40px;
    }

    .decks__grid {
      overflow: hidden;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }

    .decks__grid:hover {
      transform: translateY(-10px);
    }

    .decks__image {
      width: 100%;
      height: auto;
      display: block;
    }

    .formatting {
      padding: 80px 0;
      background-color: #f8f9fa;
    }

    .formatting__wrapper {
      display: flex;
      align-items: center;
    }

    .div-block-5 {
      flex: 1;
      padding: 0 40px;
    }

    .image-6 {
      width: 100%;
      height: auto;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .formatting_text {
      flex: 1;
      padding: 0 40px;
    }

    .formatting__heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 10px;
    }

    .heading_final {
      font-size: 36px;
      color: var(--color-maple);
      margin-bottom: 20px;
    }

    .formatting__paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.6;
      margin-bottom: 20px;
    }

    .text-span-4 {
      color: var(--color-maple);
      font-weight: bold;
    }

    .integrations {
      padding: 80px 0;
      background-color: #fff;
    }

    .integrations__wrapper {
      display: flex;
      align-items: center;
    }

    .integrations__text {
      flex: 1;
      padding: 0 40px;
    }

    .integrations__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 10px;
    }

    .integrations__text-paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.6;
      margin-bottom: 20px;
    }

    .text-span-5 {
      color: var(--color-maple);
      font-weight: bold;
    }

    .div-block-3 {
      flex: 1;
      padding: 0 40px;
    }

    .image-5 {
      width: 100%;
      height: auto;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .how-it-works {
      padding: 80px 0;
      background-color: #f8f9fa;
      text-align: center;
    }

    .section-header {
      margin-bottom: 50px;
    }

    .section-header h2 {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
    }

    .section-header p {
      color: #666;
      max-width: 700px;
      margin: 0 auto;
      font-size: 18px;
    }

    .steps {
      display: flex;
      justify-content: space-between;
      margin-top: 40px;
      flex-wrap: wrap;
    }

    .step {
      flex-basis: 23%;
      text-align: center;
      padding: 30px 20px;
      background: white;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      margin-bottom: 20px;
      transition: transform 0.3s;
    }

    .step:hover {
      transform: translateY(-10px);
    }

    .step-num {
      display: inline-block;
      width: 60px;
      height: 60px;
      background-color: var(--color-maple);
      color: white;
      border-radius: 50%;
      font-size: 24px;
      font-weight: bold;
      line-height: 60px;
      margin-bottom: 20px;
    }

    .step h3 {
      font-size: 22px;
      margin-bottom: 15px;
      color: #333;
    }

    .step p {
      color: #666;
      font-size: 16px;
    }

    .sharing {
      padding: 80px 0;
      background-color: #fff;
      text-align: center;
    }

    .sharing__text {
      margin-bottom: 40px;
    }

    .sharing__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
    }

    .sharing__text-paragraph {
      color: #666;
      font-size: 18px;
      max-width: 700px;
      margin: 0 auto;
    }

    .text-span-8 {
      color: var(--color-maple);
      font-weight: bold;
    }

    .div-block-6 {
      display: flex;
      justify-content: center;
      margin-bottom: 40px;
    }

    .div-block-7, .div-block-8, .div-block-9, .div-block-10 {
      margin: 0 20px;
    }

    .image-14, .image-15, .image-16, .image-17 {
      width: 80px;
      height: 80px;
    }

    .sharing__wrapper {
      max-width: 800px;
      margin: 0 auto;
    }

    .sharing__image {
      width: 100%;
      height: auto;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .news {
      padding: 80px 0;
      background-color: #f8f9fa;
    }

    .news__wrapper {
      max-width: 1000px;
      margin: 0 auto;
    }

    .news__card-content {
      text-align: center;
      margin-bottom: 40px;
    }

    .news__card-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
    }

    .news__card-paragraph {
      color: #666;
      font-size: 18px;
      max-width: 700px;
      margin: 0 auto 40px;
    }

    .bbb-container-1 {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 40px;
    }

    .bbb-wrap-9 {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      overflow: hidden;
      transition: transform 0.3s;
    }

    .bbb-wrap-9:hover {
      transform: translateY(-10px);
    }

    .bbb-wrap-1-1 {
      display: block;
      text-decoration: none;
    }

    .bbb-pic-1 {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }

    .title-items {
      padding: 15px 15px 5px;
      font-size: 16px;
      font-weight: bold;
      color: #333;
    }

    .bbb-text-9 {
      padding: 0 15px;
      font-size: 18px;
      color: var(--color-maple);
      font-weight: bold;
    }

    .bbb-text-1-2 {
      padding: 0 15px 15px;
      font-size: 14px;
      color: #888;
    }

    .news__card-button {
      display: inline-block;
      padding: 15px 40px;
      background-color: var(--color-maple);
      color: white;
      border-radius: 50px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
    }

    .news__card-button:hover {
      background-color: var(--color-maple);
      transform: translateY(-3px);
    }

    .news__card-buttontext {
      color: white;
      font-size: 18px;
    }

    .cta {
      padding: 80px 0;
      background-color: var(--color-maple);
      color: white;
      text-align: center;
    }

    .cta__container {
      max-width: 700px;
      margin: 0 auto;
    }

    .cta__heading {
      font-size: 36px;
      margin-bottom: 40px;
    }

    .cta_mobile_heading {
      display: none;
    }

    .cta-div {
      margin-bottom: 20px;
    }

    .cta__input-wrapper {
      display: flex;
      max-width: 500px;
      margin: 0 auto;
    }

    .input-phone-number {
      flex: 1;
      position: relative;
    }

    .text-block-32 {
      position: absolute;
      top: 15px;
      left: 20px;
      color: #666;
      font-size: 14px;
    }

    .cta__input {
      width: 100%;
      padding: 15px 20px 15px 120px;
      border: none;
      border-radius: 50px 0 0 50px;
      font-size: 16px;
    }

    .cta__button {
      padding: 15px 30px;
      background-color: #333;
      color: white;
      border: none;
      border-radius: 0 50px 50px 0;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s;
    }

    .cta__button:hover {
      background-color: #555;
    }

    .cta__disclaimer {
      color: white;
      font-size: 14px;
      max-width: 500px;
      margin: 20px auto 0;
    }

    .text-span-7 {
      font-weight: bold;
    }

    .footer {
      padding: 60px 0 30px;
      background-color: #333;
      color: white;
    }

    .footer__wrapper {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      padding: 0 20px;
    }

    .footer__credits {
      flex: 1;
    }

    .footer__logo {
      display: block;
      margin-bottom: 20px;
    }

    .image {
      height: 40px;
    }

    .footer__copyright {
      font-size: 14px;
      color: #aaa;
      margin-bottom: 5px;
    }

    .footer__links-wrapper {
      flex: 1;
      padding-left: 40px;
    }

    .footer__heading {
      font-size: 18px;
      margin-bottom: 20px;
      color: white;
    }

    .footer__link {
      display: block;
      color: #aaa;
      text-decoration: none;
      margin-bottom: 10px;
      transition: color 0.3s;
    }

    .footer__link:hover {
      color: white;
    }

    .footer__sm {
      flex: 1;
      padding-left: 40px;
    }

    .footer__heading-2 {
      font-size: 18px;
      margin-bottom: 20px;
      color: white;
    }

    .footer__sm-wrapper {
      display: flex;
      flex-direction: column;
    }

    .footer__sm-link {
      display: flex;
      align-items: center;
      color: #aaa;
      text-decoration: none;
      margin-bottom: 15px;
      transition: color 0.3s;
    }

    .footer__sm-link:hover {
      color: white;
    }

    .footer__sm-icon {
      margin-right: 10px;
      width: 20px;
      height: 20px;
    }

    .insta-link {
      font-size: 14px;
    }

    .image-52 {
      width: 20px;
      height: 20px;
      margin-right: 10px;
    }

    @media (max-width: 991px) {
      .decks, .formatting__wrapper, .integrations__wrapper {
        flex-direction: column;
      }

      .decks__text, .formatting_text, .integrations__text {
        margin-bottom: 40px;
        text-align: center;
      }

      .bbb-container-1 {
        grid-template-columns: repeat(2, 1fr);
      }

      .step {
        flex-basis: 48%;
      }
    }

    @media (max-width: 767px) {
      .nav-links {
        display: none;
      }

      .gradient-hero1, .gradient-hero2 {
        font-size: 36px;
      }

      .hero_p-2 {
        font-size: 18px;
      }

      .decks__wrapper {
        grid-template-columns: 1fr;
      }

      .step {
        flex-basis: 100%;
      }

      .bbb-container-1 {
        grid-template-columns: 1fr;
      }

      .cta__heading {
        display: none;
      }

      .cta_mobile_heading {
        display: block;
        font-size: 28px;
        margin-bottom: 40px;
      }

      .cta__input-wrapper {
        flex-direction: column;
      }

      .cta__input {
        border-radius: 50px;
        margin-bottom: 15px;
      }

      .cta__button {
        border-radius: 50px;
      }

      .footer__wrapper {
        flex-direction: column;
      }

      .footer__credits, .footer__links-wrapper, .footer__sm {
        margin-bottom: 40px;
        padding-left: 0;
      }
    }
  </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<section class="hero">
  <div class="container">
    <div class="hero_text-contain-2">
      <h1 class="gradient-hero1">보관하면서</h1>
      <h1 class="gradient-hero2">수익까지 창출!</h1>
    </div>
    <div class="hero_p-wrap">
      <p class="hero_p-2">사용하지 않는 캠핑장비를 스토렌에 맡기고<br>공간도 확보하고 보관 기간 동안 렌탈 수익도 얻으세요.</p>
    </div>
    <div>
      <a href="#" class="hero_cta-button">캠핑장비 등록하기</a>
      <a href="#" class="hero_cta-button-2">대여 가능 상품 보기</a>
    </div>
  </div>
</section>

<section class="decks">
  <address class="decks__text">
    <h2 class="decks__text-heading">지금 그 캠핑장비로<br>수익을 만들 수 있어요!</h2>
    <p class="decks__text-paragraph">집에서 뒹굴고 있는 캠핑장비를 방치하지 말고 스토렌에 맡기세요!<br>
      대여가 성사될 때마다 꼬박꼬박 수익을 만들 수 있을 거에요.<br>
      불안하시다고요? 걱정하지 마세요!<br>
      여러분의 장비는 '스토렌케어'라는 보험으로 보호됩니다.</p>
  </address>
  <div class="decks__wrapper">
    <div class="decks__grid">
      <img src="/api/placeholder/600/400" alt="캠핑 텐트" class="decks__image">
    </div>
    <div class="decks__grid">
      <img src="/api/placeholder/600/400" alt="캠핑 의자" class="decks__image">
    </div>
    <div class="decks__grid">
      <img src="/api/placeholder/600/400" alt="캠핑 테이블" class="decks__image">
    </div>
    <div class="decks__grid">
      <img src="/api/placeholder/600/400" alt="캠핑 조리도구" class="decks__image">
    </div>
  </div>
</section>

<section class="formatting">
  <div class="container">
    <div class="formatting__wrapper">
      <div class="div-block-5">
        <img src="/api/placeholder/600/800" alt="캠핑장비 보관 이미지" class="image-6">
      </div>
      <div class="formatting_text">
        <h2 class="formatting__heading">필요한 곳에서,</h2>
        <h2 class="formatting__heading">필요한 캠핑장비를,</h2>
        <h2 class="heading_final">필요한 기간 동안</h2>
        <p class="formatting__paragraph formatting__paragraph--space">
          "다음 캠핑 때는 무슨 장비가 필요할까? 새로 사자니 보관할 공간도 없는데..."<br>
          "이번에 산 텐트 한 번 쓰고 다시 쓸 일이 있을까?"<br>
          "캠핑 물품이 집안을 차지하는 공간이 너무 크네, 다른 용도로 써야 할텐데..."
        </p>
        <p class="formatting__paragraph">스토렌을 통해 필요한 만큼만 빌려쓰고, 사용하지 않는 장비는 <span class="text-span-4">수익을 창출</span>하세요!</p>
      </div>
    </div>
  </div>
</section>

<section class="integrations">
  <div class="container">
    <div class="integrations__wrapper">
      <div class="integrations__text">
        <h2 class="integrations__text-heading">방치 말고,</h2>
        <h2 class="integrations__text-heading">팔지 말고,</h2>
        <h2 class="heading_final">스토렌에 맡기세요</h2>
        <p class="integrations__text-paragraph">
          집 한구석에 방치되고 있는 캠핑장비를<br>스토렌에 맡기고 수익을 창출해보세요.<br>
          구매한 가격보다 더 큰 수익을 만들 수도 있습니다.
        </p>
        <p class="integrations__text-paragraph">스토렌을 통해 <span class="text-span-5">'보관'과 '렌탈'을 동시에</span> 경험하세요!</p>
      </div>
      <div class="div-block-3">
        <img src="/api/placeholder/600/600" alt="스토렌 서비스 이미지" class="image-5">
      </div>
    </div>
  </div>
</section>

<section class="how-it-works">
  <div class="container">
    <div class="section-header">
      <h2>스토렌 이용방법</h2>
      <p>간단한 4단계로 캠핑장비 보관과 렌탈 수익을 경험해보세요.</p>
    </div>
    <div class="steps">
      <div class="step">
        <div class="step-num">1</div>
        <h3>장비 등록</h3>
        <p>웹사이트에서 캠핑장비를 등록하고 스토렌 서비스를 신청합니다.</p>
      </div>
      <div class="step">
        <div class="step-num">2</div>
        <h3>수거 및 검수</h3>
        <p>택배기사가 자택으로 방문해 장비를 수거하고, 전문가가 체크리스트에 따라 검수합니다.</p>
      </div>
      <div class="step">
        <div class="step-num">3</div>
        <h3>보관 및 렌탈</h3>
        <p>검수 완료된 장비는 보관되며, 렌탈 신청이 들어오면 자동으로 매칭됩니다.</p>
      </div>
      <div class="step">
        <div class="step-num">4</div>
        <h3>반환</h3>
        <p>보관 기간이 끝나면 장비는 소유자에게 자동으로 반환됩니다.</p>
      </div>
    </div>
  </div>
</section>

<section class="sharing">
  <div class="container">
    <div class="sharing__text">
      <h2 class="sharing__text-heading">스토렌과 시작하는<br>공유의 첫 걸음</h2>
      <p class="sharing__text-paragraph">스토렌은 <span class="text-span-8">지속 가능한 소비</span>를 위해 노력하고 있습니다</p>
    </div>
    <div class="div-block-6">
      <div class="div-block-7">
        <img src="/api/placeholder/80/80" alt="환경 아이콘 1" class="image-14">
      </div>
      <div class="div-block-8">
        <img src="/api/placeholder/80/80" alt="환경 아이콘 2" class="image-15">
      </div>
      <div class="div-block-9">
        <img src="/api/placeholder/80/80" alt="환경 아이콘 3" class="image-16">
      </div>
      <div class="div-block-10">
        <img src="/api/placeholder/80/80" alt="환경 아이콘 4" class="image-17">
      </div>
    </div>
    <div class="sharing__wrapper">
      <img src="/api/placeholder/800/500" alt="환경 보호 이미지" class="sharing__image">
    </div>
  </div>
</section>

<section class="news">
  <div class="container">
    <div class="news__wrapper">
      <div class="news__card-content">
        <h3 class="news__card-heading">인기 대여 캠핑 장비</h3>
        <p class="news__card-paragraph">지금 스토렌에서 가장 인기 있는 캠핑 장비를 확인해보세요!</p>
        <div class="bbb-container-1">
          <div class="bbb-wrap-9">
            <a href="#" class="bbb-wrap-1-1">
              <img src="/api/placeholder/300/200" alt="텐트 세트" class="bbb-pic-1">
            </a>
            <div class="title-items">원터치 텐트 캠핑 세트</div>
            <div class="bbb-text-9">8,000원 / 일</div>
            <div class="bbb-text-1-2">50,400원 / 주</div>
          </div>
          <div class="bbb-wrap-9">
            <a href="#" class="bbb-wrap-1-1">
              <img src="/api/placeholder/300/200" alt="그리들" class="bbb-pic-1">
            </a>
            <div class="title-items">키친아트 IH 그리들 36cm</div>
            <div class="bbb-text-9">3,000원 / 일</div>
            <div class="bbb-text-1-2">18,900원 / 주</div>
          </div>
          <div class="bbb-wrap-9">
            <a href="#" class="bbb-wrap-1-1">
              <img src="/api/placeholder/300/200" alt="캠핑 의자" class="bbb-pic-1">
            </a>
            <div class="title-items">접이식 캠핑 체어 세트</div>
            <div class="bbb-text-9">5,000원 / 일</div>
            <div class="bbb-text-1-2">31,500원 / 주</div>
          </div>
          <div class="bbb-wrap-9">
            <a href="#" class="bbb-wrap-1-1">
              <img src="/api/placeholder/300/200" alt="코펠 세트" class="bbb-pic-1">
            </a>
            <div class="title-items">코베아 코펠 풀 세트</div>
            <div class="bbb-text-9">4,000원 / 일</div>
            <div class="bbb-text-1-2">25,200원 / 주</div>
          </div>
        </div>
        <a href="#" class="news__card-button">
          <div class="news__card-buttontext">대여하러 가기 >></div>
        </a>
      </div>
    </div>
  </div>
</section>

<section class="cta">
  <div class="container">
    <div class="cta__container">
      <h2 class="cta__heading">스토렌 출시 소식, 가장 먼저 알려드릴게요!</h2>
      <h2 class="cta_mobile_heading">스토렌 출시 소식,<br>가장 먼저 알려드릴게요!</h2>
      <form class="cta-div">
        <div class="cta__input-wrapper">
          <div class="input-phone-number">
            <div class="text-block-32">휴대폰 번호</div>
            <input class="cta__input" placeholder="ex. 01012345678" type="tel" required>
          </div>
          <input type="submit" class="cta__button" value="등록하기">
        </div>
        <div class="cta__disclaimer">
          <span class="text-span-7">서비스 출시 소식 알림</span>을 위한 수집으로, 기타 마케팅 수신 동의로 간주하지 않습니다.
        </div>
      </form>
    </div>
  </div>
</section>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />
</body>
</html>
