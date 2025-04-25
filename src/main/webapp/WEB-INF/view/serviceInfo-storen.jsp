<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampingHaShare - 캠핑 장비 공유 플랫폼</title>
  <!-- 외부 라이브러리 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
  <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
  <style>
    .section-title {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }

    .section-title h2 {
      font-size: 32px;
      font-weight: bold;
      color: #333;
    }

    .section-title .view-all {
      font-size: 16px;
      color: var(--color-maple);
      text-decoration: none;
    }

    .item-slider {
      position: relative;
    }

    .slider-container {
      display: flex;
      gap: 20px;
      overflow-x: auto;
      scroll-behavior: smooth;
      padding-bottom: 10px;
    }

    .product-card {
      flex: 0 0 auto;
      width: 240px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.05);
      overflow: hidden;
      transition: transform 0.3s;
    }

    .product-card:hover {
      transform: translateY(-5px);
    }

    .product-image {
      width: 100%;
      height: 180px;
      background-color: #eee;
      position: relative;
    }

    .product-placeholder {
      width: 100%;
      height: 100%;
      background: #ddd url('/resources/images/banner1.jpg') center/cover no-repeat;
    }

    .product-info {
      padding: 15px;
      text-align: left;
    }

    .product-title {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 8px;
      color: #333;
    }

    .product-brand, .product-category {
      font-size: 14px;
      color: #666;
      margin-bottom: 3px;
    }

    .product-price {
      font-size: 15px;
      font-weight: bold;
      color: var(--color-maple);
    }

    .slider-nav {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background: white;
      border: none;
      font-size: 18px;
      cursor: pointer;
      box-shadow: 0 3px 6px rgba(0,0,0,0.1);
      padding: 10px;
      border-radius: 50%;
      z-index: 10;
    }

    .slider-prev {
      left: -20px;
    }

    .slider-next {
      right: -20px;
    }

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

    /* 네비게이션 스타일 - 헤더는 include로 처리 */

    /* 히어로 섹션 */
    .hero {
      background: linear-gradient(rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0.85)), url('${pageContext.request.contextPath}/resources/images/camping-bg.jpg') center/cover;
      padding: 120px 0 100px;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('${pageContext.request.contextPath}/resources/images/pattern.png');
      opacity: 0.05;
      z-index: 0;
    }

    .hero_text-contain-2 {
      margin-bottom: 30px;
      position: relative;
      z-index: 1;
    }

    .gradient-hero1, .gradient-hero2 {
      font-size: 48px;
      margin-bottom: 10px;
      font-weight: 700;
      letter-spacing: -0.5px;
    }

    .gradient-hero1 {
      color: #333;
    }

    .gradient-hero2 {
      color: var(--color-maple);
      position: relative;
      display: inline-block;
    }

    .gradient-hero2::after {
      content: '';
      position: absolute;
      bottom: 5px;
      left: 0;
      width: 100%;
      height: 8px;
      background-color: rgba(230, 115, 92, 0.2);
      z-index: -1;
    }

    .hero_p-wrap {
      max-width: 700px;
      margin: 0 auto 40px;
      position: relative;
      z-index: 1;
    }

    .hero_p-2 {
      font-size: 20px;
      color: #555;
      line-height: 1.7;
    }

    .hero_cta-button, .hero_cta-button-2 {
      display: inline-block;
      padding: 16px 42px;
      border-radius: 50px;
      text-decoration: none;
      font-weight: 500;
      font-size: 17px;
      transition: all 0.3s;
      margin: 0 10px;
      position: relative;
      z-index: 1;
    }

    .hero_cta-button {
      background-color: var(--color-maple);
      color: white;
      border: none;
      box-shadow: 0 4px 10px rgba(230, 115, 92, 0.3);
    }

    .hero_cta-button-2 {
      background-color: white;
      color: var(--color-maple);
      border: 1px solid var(--color-maple);
    }

    .hero_cta-button:hover {
      background-color: var(--color-maple);
      transform: translateY(-3px);
      box-shadow: 0 6px 15px rgba(230, 115, 92, 0.4);
    }

    .hero_cta-button-2:hover {
      background-color: rgba(230, 115, 92, 0.05);
      transform: translateY(-3px);
    }

    /* 서비스 소개 섹션 */
    .decks {
      padding: 100px 0;
      background-color: #fff;
      display: flex;
      align-items: center;
      position: relative;
      overflow: hidden;
    }

    .decks::after {
      content: '';
      position: absolute;
      bottom: -50px;
      right: -50px;
      width: 200px;
      height: 200px;
      background-color: rgba(230, 115, 92, 0.05);
      border-radius: 50%;
      z-index: 0;
    }

    .decks__text {
      flex: 1;
      padding: 0 50px;
      font-style: normal;
      position: relative;
      z-index: 1;
    }

    .decks__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 25px;
      line-height: 1.3;
      position: relative;
      padding-bottom: 15px;
    }

    .decks__text-heading::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 60px;
      height: 3px;
      background-color: var(--color-maple);
    }

    .decks__text-paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.7;
      margin-bottom: 25px;
    }

    .decks__text-paragraph strong {
      color: var(--color-maple);
    }

    .decks__wrapper {
      flex: 1;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 25px;
      padding: 0 40px;
      position: relative;
      z-index: 1;
    }

    .decks__grid {
      overflow: hidden;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.08);
      transition: transform 0.3s, box-shadow 0.3s;
      position: relative;
    }

    .decks__grid:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.12);
    }

    .decks__grid::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(to bottom, rgba(0,0,0,0) 70%, rgba(0,0,0,0.2));
      z-index: 1;
    }

    .decks__image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s;
    }

    .decks__grid:hover .decks__image {
      transform: scale(1.05);
    }

    /* 콘셉트 설명 섹션 */
    .formatting {
      padding: 100px 0;
      background-color: #f8f9fa;
      position: relative;
      overflow: hidden;
    }

    .formatting::before {
      content: '';
      position: absolute;
      top: -50px;
      left: -50px;
      width: 200px;
      height: 200px;
      background-color: rgba(230, 115, 92, 0.05);
      border-radius: 50%;
      z-index: 0;
    }

    .formatting__wrapper {
      display: flex;
      align-items: center;
      position: relative;
      z-index: 1;
    }

    .div-block-5 {
      flex: 1;
      padding: 0 50px;
      position: relative;
    }

    .div-block-5::after {
      content: '';
      position: absolute;
      top: 20px;
      left: 20px;
      width: calc(100% - 40px);
      height: calc(100% - 40px);
      border: 2px dashed var(--color-maple);
      border-radius: 12px;
      z-index: 0;
      opacity: 0.2;
    }

    .image-6 {
      width: 100%;
      height: auto;
      border-radius: 12px;
      box-shadow: 0 15px 30px rgba(0,0,0,0.1);
      position: relative;
      z-index: 1;
    }

    .formatting_text {
      flex: 1;
      padding: 0 50px;
    }

    .formatting__heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 5px;
      line-height: 1.2;
    }

    .heading_final {
      font-size: 36px;
      color: var(--color-maple);
      margin-bottom: 25px;
      position: relative;
      display: inline-block;
    }

    .heading_final::after {
      content: '';
      position: absolute;
      bottom: 5px;
      left: 0;
      width: 100%;
      height: 8px;
      background-color: rgba(230, 115, 92, 0.2);
      z-index: -1;
    }

    .formatting__paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.7;
      margin-bottom: 25px;
    }

    .formatting__paragraph--space {
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      border-left: 3px solid var(--color-maple);
    }

    .text-span-4 {
      color: var(--color-maple);
      font-weight: bold;
    }

    /* 서비스 특징 섹션 */
    .integrations {
      padding: 100px 0;
      background-color: #fff;
      position: relative;
      overflow: hidden;
    }

    .integrations::after {
      content: '';
      position: absolute;
      bottom: -50px;
      right: -50px;
      width: 200px;
      height: 200px;
      background-color: rgba(230, 115, 92, 0.05);
      border-radius: 50%;
      z-index: 0;
    }

    .integrations__wrapper {
      display: flex;
      align-items: center;
      position: relative;
      z-index: 1;
    }

    .integrations__text {
      flex: 1;
      padding: 0 50px;
    }

    .integrations__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 5px;
      line-height: 1.2;
    }

    .integrations__text-paragraph {
      color: #666;
      font-size: 18px;
      line-height: 1.7;
      margin-bottom: 25px;
    }

    .text-span-5 {
      color: var(--color-maple);
      font-weight: bold;
    }

    .div-block-3 {
      flex: 1;
      padding: 0 50px;
      position: relative;
    }

    .div-block-3::before {
      content: '';
      position: absolute;
      bottom: -20px;
      right: 30px;
      width: 80px;
      height: 80px;
      background-color: var(--color-maple);
      opacity: 0.1;
      border-radius: 50%;
      z-index: 0;
    }

    .div-block-3::after {
      content: '';
      position: absolute;
      top: -20px;
      left: 30px;
      width: 60px;
      height: 60px;
      background-color: var(--color-maple);
      opacity: 0.1;
      border-radius: 50%;
      z-index: 0;
    }

    .image-5 {
      width: 100%;
      height: auto;
      border-radius: 12px;
      box-shadow: 0 15px 30px rgba(0,0,0,0.1);
      position: relative;
      z-index: 1;
    }

    /* 이용 방법 섹션 */
    .how-it-works {
      padding: 100px 0;
      background-color: #f8f9fa;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .how-it-works::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('${pageContext.request.contextPath}/resources/images/pattern.png');
      opacity: 0.05;
      z-index: 0;
    }

    .section-header {
      margin-bottom: 60px;
      position: relative;
      z-index: 1;
    }

    .section-header h2 {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .section-header h2::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background-color: var(--color-maple);
    }

    .section-header p {
      color: #666;
      max-width: 700px;
      margin: 0 auto;
      font-size: 18px;
      line-height: 1.7;
    }

    .steps {
      display: flex;
      justify-content: space-between;
      margin-top: 40px;
      flex-wrap: wrap;
      position: relative;
      z-index: 1;
    }

    .steps::before {
      content: '';
      position: absolute;
      top: 30px;
      left: 10%;
      right: 10%;
      height: 2px;
      background-color: #e5e5e5;
      z-index: -1;
    }

    .step {
      flex-basis: 23%;
      text-align: center;
      padding: 40px 20px;
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.05);
      margin-bottom: 20px;
      transition: transform 0.3s, box-shadow 0.3s;
      position: relative;
      z-index: 2;
    }

    .step:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.1);
    }

    .step-num {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 70px;
      height: 70px;
      background-color: var(--color-maple);
      color: white;
      border-radius: 50%;
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 25px;
      box-shadow: 0 8px 15px rgba(230, 115, 92, 0.3);
    }

    .step h3 {
      font-size: 22px;
      margin-bottom: 15px;
      color: #333;
    }

    .step p {
      color: #666;
      font-size: 16px;
      line-height: 1.6;
    }

    /* 공유 가치 섹션 */
    .sharing {
      padding: 100px 0;
      background-color: #fff;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .sharing::after {
      content: '';
      position: absolute;
      bottom: -50px;
      right: -50px;
      width: 200px;
      height: 200px;
      background-color: rgba(230, 115, 92, 0.05);
      border-radius: 50%;
      z-index: 0;
    }

    .sharing__text {
      margin-bottom: 60px;
      position: relative;
      z-index: 1;
    }

    .sharing__text-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .sharing__text-heading::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background-color: var(--color-maple);
    }

    .sharing__text-paragraph {
      color: #666;
      font-size: 18px;
      max-width: 700px;
      margin: 25px auto 0;
      line-height: 1.7;
    }

    .text-span-8 {
      color: var(--color-maple);
      font-weight: bold;
    }

    .div-block-6 {
      display: flex;
      justify-content: center;
      margin-bottom: 60px;
      position: relative;
      z-index: 1;
    }

    .div-block-7, .div-block-8, .div-block-9, .div-block-10 {
      margin: 0 25px;
      transition: transform 0.3s;
    }

    .div-block-7:hover, .div-block-8:hover, .div-block-9:hover, .div-block-10:hover {
      transform: translateY(-5px);
    }

    .image-14, .image-15, .image-16, .image-17 {
      width: 100px;
      height: 100px;
      padding: 15px;
      background-color: #fff;
      border-radius: 50%;
      box-shadow: 0 8px 15px rgba(0,0,0,0.08);
    }

    .sharing__wrapper {
      max-width: 900px;
      margin: 0 auto;
      position: relative;
      z-index: 1;
    }

    .sharing__image {
      width: 100%;
      height: auto;
      border-radius: 15px;
      box-shadow: 0 15px 30px rgba(0,0,0,0.1);
    }

    /* 인기 장비 섹션 */
    .news {
      padding: 100px 0;
      background-color: #f8f9fa;
      position: relative;
      overflow: hidden;
    }

    .news::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('${pageContext.request.contextPath}/resources/images/pattern.png');
      opacity: 0.05;
      z-index: 0;
    }

    .news__wrapper {
      max-width: 1100px;
      margin: 0 auto;
      position: relative;
      z-index: 1;
    }

    .news__card-content {
      text-align: center;
      margin-bottom: 60px;
    }

    .news__card-heading {
      font-size: 36px;
      color: #333;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .news__card-heading::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background-color: var(--color-maple);
    }

    .news__card-paragraph {
      color: #666;
      font-size: 18px;
      max-width: 700px;
      margin: 25px auto 40px;
      line-height: 1.7;
    }

    .bbb-container-1 {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 25px;
      margin-bottom: 60px;
    }

    .bbb-wrap-9 {
      background-color: white;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.05);
      overflow: hidden;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .bbb-wrap-9:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.1);
    }

    .bbb-wrap-1-1 {
      display: block;
      text-decoration: none;
    }

    .bbb-pic-1 {
      width: 100%;
      height: 200px;
      object-fit: cover;
      transition: transform 0.5s;
    }

    .bbb-wrap-9:hover .bbb-pic-1 {
      transform: scale(1.05);
    }

    .title-items {
      padding: 20px 20px 5px;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      height: 70px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .bbb-text-9 {
      padding: 0 20px 5px;
      font-size: 18px;
      color: var(--color-maple);
      font-weight: bold;
    }

    .bbb-text-1-2 {
      padding: 0 20px 20px;
      font-size: 14px;
      color: #888;
    }

    .news__card-button {
      display: inline-block;
      padding: 16px 42px;
      background-color: var(--color-maple);
      color: white;
      border-radius: 50px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      box-shadow: 0 8px 15px rgba(230, 115, 92, 0.3);
    }

    .news__card-button:hover {
      background-color: var(--color-maple);
      transform: translateY(-3px);
      box-shadow: 0 12px 20px rgba(230, 115, 92, 0.4);
    }

    .news__card-buttontext {
      color: white;
      font-size: 17px;
    }

    /* CTA 섹션 */
    .cta {
      padding: 100px 0;
      background-color: var(--color-maple);
      color: white;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .cta::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('${pageContext.request.contextPath}/resources/images/pattern.png');
      opacity: 0.05;
      z-index: 0;
    }

    .cta::after {
      content: '';
      position: absolute;
      bottom: -100px;
      right: -100px;
      width: 300px;
      height: 300px;
      background-color: rgba(255, 255, 255, 0.1);
      border-radius: 50%;
      z-index: 0;
    }

    .cta__container {
      max-width: 700px;
      margin: 0 auto;
      position: relative;
      z-index: 1;
    }

    .cta__heading {
      font-size: 38px;
      margin-bottom: 40px;
      line-height: 1.3;
    }

    .cta_mobile_heading {
      display: none;
    }

    .cta-div {
      margin-top: 40px;
    }

    .cta__button {
      display: inline-block;
      padding: 18px 50px;
      background-color: white;
      color: var(--color-maple);
      border: none;
      border-radius: 50px;
      font-size: 18px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .cta__button:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 25px rgba(0, 0, 0, 0.15);
    }

    /* 반응형 스타일 */
    @media (max-width: 991px) {
      .decks, .formatting__wrapper, .integrations__wrapper {
        flex-direction: column;
      }

      .decks__text, .formatting_text, .integrations__text {
        margin-bottom: 60px;
        text-align: center;
        padding: 0 20px;
      }

      .decks__text-heading::after {
        left: 50%;
        transform: translateX(-50%);
      }

      .div-block-5, .div-block-3 {
        padding: 0 20px;
      }

      .bbb-container-1 {
        grid-template-columns: repeat(2, 1fr);
      }

      .step {
        flex-basis: 48%;
      }
    }

    @media (max-width: 767px) {
      .hero {
        padding: 80px 0 60px;
      }

      .gradient-hero1, .gradient-hero2 {
        font-size: 36px;
      }

      .hero_p-2 {
        font-size: 18px;
      }

      .hero_cta-button, .hero_cta-button-2 {
        display: block;
        margin: 15px auto;
        max-width: 80%;
      }

      .decks, .formatting, .integrations, .how-it-works, .sharing, .news {
        padding: 70px 0;
      }

      .decks__wrapper {
        grid-template-columns: 1fr;
        padding: 0 20px;
      }

      .step {
        flex-basis: 100%;
      }

      .bbb-container-1 {
        grid-template-columns: 1fr;
        padding: 0 20px;
      }

      .cta__heading {
        display: none;
      }

      .cta_mobile_heading {
        display: block;
        font-size: 28px;
        margin-bottom: 40px;
      }

      .div-block-6 {
        flex-wrap: wrap;
      }

      .div-block-7, .div-block-8, .div-block-9, .div-block-10 {
        flex-basis: 45%;
        margin-bottom: 30px;
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
      <h1 class="gradient-hero1">캠핑 장비 공유의 새로운 시작</h1>
      <h1 class="gradient-hero2">보관하며 수익까지!</h1>
    </div>
    <div class="hero_p-wrap">
      <p class="hero_p-2">사용하지 않는 캠핑장비를 '캠핑하쉐어'에 맡기고<br>소중한 공간도 확보하고 보관 기간 동안 추가 수익도 얻으세요.</p>
    </div>
  </div>
</section>

<section class="formatting">
  <div class="container">
    <div class="formatting__wrapper">
      <div class="div-block-5">
        <img src="${pageContext.request.contextPath}/resources/images/banner2.jpg" alt="캠핑장비 보관 이미지" class="image-6">
      </div>
      <div class="formatting_text">
        <h2 class="formatting__heading">필요한 곳에서,</h2>
        <h2 class="formatting__heading">필요한 캠핑장비를,</h2>
        <h2 class="heading_final">필요한 기간 동안</h2>
        <p class="formatting__paragraph formatting__paragraph--space">
          "다음 캠핑 때는 무슨 장비가 필요할까? 보관할 공간도 없는데..."<br>
          "이번에 산 텐트 한 번 쓰고 다시 쓸 일이 있을까?"<br>
          "캠핑 물품이 차지하는 공간이 너무 크네, 다른 용도로 써야 할텐데..."
        </p>
        <p class="formatting__paragraph">스토렌을 통해 필요한 만큼만 빌려쓰고, 미사용 장비로 <span class="text-span-4">수익을 창출</span>하세요!</p>
      </div>
    </div>
  </div>
</section>

<section class="integrations">
  <div class="container">
    <div class="integrations__wrapper">
      <div class="integrations__text">
        <h2 class="integrations__text-heading">방치하지 말고,</h2>
        <h2 class="integrations__text-heading">판매하지 말고,</h2>
        <h2 class="heading_final">스토렌에 맡기세요</h2>
        <p class="integrations__text-paragraph">
          집 한구석에 방치되고 있는 캠핑장비를<br>스토렌에 맡기고 수익을 창출해보세요.<br>
          장기적으로 봤을 때 구매 가격 이상의 수익도 가능합니다.
        </p>
        <p class="integrations__text-paragraph">스토렌을 통해 <span class="text-span-5">'보관'과 '렌탈'을 동시에</span> 해결하세요!</p>
      </div>
      <div class="div-block-3">
        <img src="${pageContext.request.contextPath}/resources/images/banner10.jpg" alt="스토렌 서비스 이미지" class="image-5">
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
        <p>웹사이트에서 캠핑장비의 정보와 사진을 등록하고 스토렌 서비스를 신청합니다.</p>
      </div>
      <div class="step">
        <div class="step-num">2</div>
        <h3>수거 및 검수</h3>
        <p>택배기사가 방문하여 장비를 수거하고, 전문 담당자가 상태를 꼼꼼히 확인합니다.</p>
      </div>
      <div class="step">
        <div class="step-num">3</div>
        <h3>보관 및 렌탈</h3>
        <p>검수 완료된 장비는 안전하게 보관되며, 렌탈 신청이 들어오면 자동으로 대여됩니다.</p>
      </div>
      <div class="step">
        <div class="step-num">4</div>
        <h3>수익 & 반환</h3>
        <p>대여 수익이 쌓이고, 보관 기간 종료 시 장비는 깨끗하게 정리되어 돌아옵니다.</p>
      </div>
    </div>
  </div>
</section>

<section class="sharing">
  <div class="container">
    <div class="sharing__text">
      <h2 class="sharing__text-heading">함께 나누는 캠핑 문화</h2>
      <p class="sharing__text-paragraph">'캠핑하쉐어'는 <span class="text-span-8">지속 가능한 소비</span>를 위한 공유 경제를 지향합니다</p>
    </div>
    <div class="sharing__wrapper">
      <img src="${pageContext.request.contextPath}/resources/images/banner9.jpg" alt="공유 캠핑 문화 이미지" class="sharing__image">
    </div>
  </div>
</section>

<%--<section class="news">--%>
<%--  <div class="container">--%>
<%--    <div class="news__wrapper">--%>
<%--      <!-- 스토렌 MD Pick 섹션 -->--%>
<%--      <div class="section-title">--%>
<%--        <h2>스토렌 MD Pick!</h2>--%>
<%--        <a href="${pageContext.request.contextPath}/rentalsearch-main.action?tab=storen" class="view-all">전체보기</a>--%>
<%--      </div>--%>

<%--      <div class="item-slider" id="md-picks">--%>
<%--        <button class="slider-nav slider-prev"><i class="fas fa-chevron-left"></i></button>--%>
<%--        <div class="slider-container">--%>
<%--          <c:choose>--%>
<%--            <c:when test="${not empty mdPickList}">--%>
<%--              <c:forEach var="storen" items="${mdPickList}">--%>
<%--                <div class="product-card">--%>
<%--                  <div class="product-image">--%>
<%--                    <c:choose>--%>
<%--                      <c:when test="${!empty storen.equipmentDTO && !empty storen.equipmentDTO.attachments && storen.equipmentDTO.attachments.size() > 0}">--%>
<%--                        <img src="${storen.equipmentDTO.attachments.get(0).attachmentPath}" alt="상품 이미지" style="width:100%; height:100%; object-fit: cover;">--%>
<%--                      </c:when>--%>
<%--                      <c:otherwise>--%>
<%--                        <div class="product-placeholder"></div>--%>
<%--                      </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                  </div>--%>
<%--                  <div class="product-info">--%>
<%--                    <p class="product-title">${storen.storen_title}</p>--%>
<%--                    <c:if test="${!empty storen.equipmentDTO}">--%>
<%--                      <p class="product-brand">${storen.equipmentDTO.brand}</p>--%>
<%--                      <p class="product-category">${storen.equipmentDTO.majorCategory}</p>--%>
<%--                    </c:if>--%>
<%--                    <p class="product-price">${storen.daily_rent_price}원/일</p>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--              </c:forEach>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--              <p>추천할 스토렌 상품이 없습니다.</p>--%>
<%--            </c:otherwise>--%>
<%--          </c:choose>--%>
<%--        </div>--%>
<%--        <button class="slider-nav slider-next"><i class="fas fa-chevron-right"></i></button>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</section>--%>

<section class="cta">
  <div class="container">
    <div class="cta__container">
      <h2 class="cta__heading">지금 바로 캠핑하쉐어와 함께하세요!</h2>
      <h2 class="cta_mobile_heading">지금 바로<br>캠핑하쉐어와 함께하쉐요!</h2>
      <div class="cta-div">
        <a href="${pageContext.request.contextPath}/registeruser-tel.action" style="text-decoration: none; display: inline-block;">
          <button class="cta__button">가입하기</button>
        </a>
      </div>
    </div>
  </div>
</section>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const slider = document.querySelector('#md-picks .slider-container');
    const nextBtn = document.querySelector('#md-picks .slider-next');
    const prevBtn = document.querySelector('#md-picks .slider-prev');

    nextBtn.addEventListener('click', () => {
      slider.scrollBy({ left: 300, behavior: 'smooth' });
    });

    prevBtn.addEventListener('click', () => {
      slider.scrollBy({ left: -300, behavior: 'smooth' });
    });
  });
</script>

</body>
</html>