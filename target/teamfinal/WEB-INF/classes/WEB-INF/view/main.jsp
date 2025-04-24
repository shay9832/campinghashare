<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main.jsp</title>

    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <style>
        body {
            background-color: white;
        }

        /* 메인 콘텐츠 영역 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 0;
            box-shadow: none;
        }

        /* ===== 메인 배너 스타일 ===== */
        .main-banner {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
            border: 1px solid #e1e1e1;
            margin: 0 auto 20px;
        }

        .banner-slide {
            display: flex;
            width: 300%; /* 배너 3개면 300% */
            height: 100%;
            transition: transform 0.5s ease;
        }

        .banner-item {
            flex: 0 0 33.333%; /* 전체 너비의 1/3 */
            height: 100%;
            position: relative;
        }

        .banner-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .banner-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            z-index: 5;
            width: 80%;
        }

        .banner-text {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
            text-shadow: 1px 1px 2px rgba(103, 103, 103, 0.7);
        }

        .banner-prev,
        .banner-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.7);
            border: none;
            color: #333;
            font-size: 24px;
            cursor: pointer;
            z-index: 10;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .banner-prev {
            left: 10px;
        }

        .banner-next {
            right: 10px;
        }

        /* ===== 하단 슬라이더 스타일 ===== */
        .item-slider {
            position: relative;
            padding: 0 20px 20px;
            overflow: hidden; /* 중요: overflow 설정 */
        }

        .slider-container {
            display: flex;
            gap: 15px;
            overflow-x: hidden; /* auto에서 hidden으로 변경 */
            white-space: nowrap;
            scroll-behavior: smooth;
            padding: 5px 0; /* 약간의 패딩 추가 */
        }

        .slider-prev,
        .slider-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.7);
            border: none;
            color: #333;
            font-size: 20px;
            cursor: pointer;
            z-index: 5;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .slider-prev {
            left: 5px;
        }

        .slider-next {
            right: 5px;
        }

        .slider-prev:hover,
        .slider-next:hover {
            background: rgba(255, 255, 255, 0.9);
        }

        .item-slider {
            position: relative;
            padding: 0 20px 20px;
        }

        .slider-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #999;
            font-size: 24px;
            cursor: pointer;
            z-index: 2;
        }

        /* 섹션 타이틀 */
        .section-title {
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title h2 {
            font-size: 20px;
            color: #333;
            margin: 0;
        }

        .view-all {
            color: #2C5F2D;
            text-decoration: none;
            font-size: 14px;
        }

        /* 아이템 카드 */
        .product-card {
            width: 220px;
            flex-shrink: 0;
            border: 1px solid #eee;
            border-radius: 5px;
            overflow: hidden;
            transition: all 0.3s ease;
            background-color: white;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            height: 150px;
            background-color: #f9f9f9;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-placeholder {
            position: relative;
            width: 60px;
            height: 60px;
        }

        .product-info {
            padding: 10px;
        }

        .product-title {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 40px;
        }

        .product-brand {
            font-size: 12px;
            color: #2C5F2D;
            margin-bottom: 3px;
        }

        .product-category {
            font-size: 12px;
            color: #777;
            margin-bottom: 5px;
        }

        .product-price {
            font-size: 14px;
            font-weight: bold;
            color: #333;
        }

        /* 리뷰 섹션 */
        .review-section {
            padding: 20px;
            border-bottom: 1px solid #e1e1e1;
        }

        .review-container {
            width: 100%;
            height: 100px;
            border: 1px solid #eee;
            border-radius: 5px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #f9f9f9;
            position: relative;
            overflow: hidden;
        }

        .review-slider {
            display: flex;
            position: absolute;
            width: calc(100% * 3);
            height: 100%;
            transition: transform 1s ease-in-out;
        }

        .review-item {
            width: calc(100% / 3);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .review-text {
            text-align: center;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .star-rating {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .star-rating i {
            color: #ddd;
            font-size: 20px;
            margin: 0 2px;
        }

        .star-rating i.active {
            color: #FFC107;
        }

        /* 하단 미니배너 스타일 */
        .footer-mini-banner {
            width: 100%;
            height: 80px;
            display: flex;
            justify-content: space-between;
            padding: 10px;
            margin-top: 30px;
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        .mini-banner-container {
            width: 48%;
            height: 100%;
            position: relative;
            border-radius: 5px;
            overflow: hidden;
        }

        .mini-banner-item {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
        }

        .mini-banner-content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .mini-banner-text {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 4px;
            text-shadow: 1px 1px 2px rgba(103, 103, 103, 0.7);
        }

        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .filter-options {
                flex-direction: column;
                align-items: flex-start;
            }

            .date-filter, .price-filter {
                width: 100%;
                margin-top: 10px;
            }

            .product-card {
                width: 180px;
            }
        }

        @media (max-width: 576px) {
            .product-card {
                width: 150px;
            }

            .product-image {
                height: 120px;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">

    <jsp:include page="header.jsp"/>

    <!-- 메인 콘텐츠 영역 -->
    <div class="container">
        <!-- 배너 슬라이드 -->
        <div class="main-banner">
            <button class="banner-prev"><i class="fas fa-chevron-left"></i></button>
            <div class="banner-slide">
                <div class="banner-item">
                    <a href="${pageContext.request.contextPath}/serviceinfo-storen.action">
                        <img src="${pageContext.request.contextPath}/resources/images/banner7.png" alt="배너1" style="width:100%; height:100%; object-fit: cover;">
                        <div class="banner-content">
                            <div class="banner-text" style="color:var(--color-maple);">서비스 소개</div>
                        </div>
                    </a>
                </div>
                <div class="banner-item">
                    <img src="${pageContext.request.contextPath}/resources/images/banner2.jpg" alt="배너2" style="width:100%; height:100%; object-fit: cover;">
                    <div class="banner-content">
                        <div class="banner-text" style="color:var(--color-white);">특별 프로모션 - 30% 할인</div>
                    </div>
                </div>
                <div class="banner-item">
                    <img src="${pageContext.request.contextPath}/resources/images/banner4.jpeg" alt="배너3" style="width:100%; height:100%; object-fit: cover;">
                    <div class="banner-content">
                        <div class="banner-text" style="color:var(--color-coral);">신규 상품 소개</div>
                    </div>
                </div>
            </div>
            <button class="banner-next"><i class="fas fa-chevron-right"></i></button>
        </div>

        <!-- 필터 영역 -->
        <div class="filter-container">
            <div class="filter-content">
                <!-- 전체/스토렌/렌탈 버튼 -->
                <div class="filter-type-section">
                    <div class="btn-group">
                        <button type="button" class="filter-btn active">전체</button><button type="button" class="filter-btn">스토렌</button><button type="button" class="filter-btn">렌탈</button>
                    </div>
                </div>

                <!-- 키워드 검색 영역 -->
                <div class="keyword-section">
                    <form id="searchForm" action="rentalsearch-main.action" method="GET">
                        <!-- 탭 유지를 위한 히든 필드 -->
                        <input type="hidden" name="tab" value="storen">
                        <!-- 가격 범위를 위한 히든 필드 -->
                        <input type="hidden" name="minPrice" id="hidden-min-price" value="0">
                        <input type="hidden" name="maxPrice" id="hidden-max-price" value="100000">
                        <!-- 날짜 범위를 위한 히든 필드 -->
                        <input type="hidden" name="startDate" id="hidden-start-date" value="">
                        <input type="hidden" name="endDate" id="hidden-end-date" value="">

                        <div class="input-label">키워드</div>
                        <div class="search-container">
                            <label for="search-input" style="display:none">검색</label>
                            <input type="text" id="search-input" name="searchKeyword" placeholder="키워드 검색(브랜드명, 장비명 등)">
                            <button type="submit" id="search-btn" class="search-icon-button">
                                <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <!-- 일일 렌탈가격 영역 -->
                <div class="price-section">
                    <div class="input-label">일일 렌탈가격</div>
                    <div class="price-range-container">
                        <div id="price-range" class="price-range-slider"></div>
                        <div class="price-range-values">
                            <span id="min-price">0원</span>
                            <span id="max-price">100,000원</span>
                        </div>
                    </div>
                </div>

                <!-- 대여일자 영역 -->
                <div class="date-section">
                    <div class="input-label">대여 일자</div>
                    <div class="date-container">
                        <div class="date-range-container">
                            <input type="text" id="date-range" placeholder="날짜 선택" readonly>
                            <span class="date-range-icon">
                        <i class="fa-regular fa-calendar"></i>
                    </span>
                        </div>
                        <!-- 필터 적용 버튼 -->
                        <div class="filter-button-container">
                            <button class="filter-button" onclick="applyFilter()">필터 적용</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 스토렌 MD Pick 섹션 -->
        <div class="section-title">
            <h2>스토렌 MD Pick!</h2>
            <a href="${pageContext.request.contextPath}/rentalsearch-main.action?tab=storen" class="view-all">전체보기</a>
        </div>
        <div class="item-slider" id="md-picks">
            <button class="slider-nav slider-prev"><i class="fas fa-chevron-left"></i></button>
            <div class="slider-container">
                <c:choose>
                <c:when test="${!empty mdPickList && mdPickList.size() > 0}">
                    <c:forEach var="storen" items="${mdPickList}">
                        <div class="product-card">
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${!empty storen.equipmentDTO && !empty storen.equipmentDTO.attachments && storen.equipmentDTO.attachments.size() > 0}">
                                        <img src="${storen.equipmentDTO.attachments.get(0).attachmentPath}" alt="상품 이미지" style="width:100%; height:100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-placeholder"></div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="product-info">
                                <p class="product-title">${storen.storen_title}</p>
                                <c:if test="${!empty storen.equipmentDTO}">
                                    <p class="product-brand">${storen.equipmentDTO.brand}</p>
                                    <p class="product-category">${storen.equipmentDTO.majorCategory}</p>
                                </c:if>
                                <p class="product-price">${storen.daily_rent_price}원/일</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>추천할 스토렌 상품이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <button class="slider-nav slider-next"><i class="fas fa-chevron-right"></i></button>
    </div>

        <!-- 한 줄 후기 섹션 -->
        <div class="review-section">
            <div class="review-container">
                <div class="review-slider">
                    <div class="review-item">
                        <div class="review-text">처음 이용했는데 너무 만족스러웠어요!</div>
                        <div class="star-rating">
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                        </div>
                    </div>
                    <div class="review-item">
                        <div class="review-text">배송이 빠르고 제품 상태가 좋았습니다.</div>
                        <div class="star-rating">
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                    <div class="review-item">
                        <div class="review-text">다음에도 이용할게요! 감사합니다.</div>
                        <div class="star-rating">
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star active"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 최근 등록된 렌탈 상품 섹션 -->
        <div class="section-title">
            <h2>최근 등록된 렌탈 상품</h2>
            <a href="${pageContext.request.contextPath}/rentalsearch-main.action?tab=rental" class="view-all">전체보기</a>
        </div>
        <div class="item-slider" id="recent-products">
            <button class="slider-nav slider-prev"><i class="fas fa-chevron-left"></i></button>
            <div class="slider-container">
                <!-- 첫 번째 세트 (4개) -->
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">코베아 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                        <p class="product-brand">코베아</p>
                        <p class="product-category">텐트/쉘터</p>
                        <p class="product-price">35,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">몽벨 실리콘 다용기가 800 #5 BLUE 면글라켓 식기세트 코펠</p>
                        <p class="product-brand">몽벨</p>
                        <p class="product-category">주방용품</p>
                        <p class="product-price">15,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">헬리녹스 HELINOX 테이블원 경량 접이식 캠핑 테이블</p>
                        <p class="product-brand">헬리녹스</p>
                        <p class="product-category">테이블</p>
                        <p class="product-price">30,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">캠핑문 Campingmoon 캠핑 취사 랜턴 우드스토브 화로대</p>
                        <p class="product-brand">캠핑문</p>
                        <p class="product-category">랜턴/버너</p>
                        <p class="product-price">25,000원/일</p>
                    </div>
                </div>

                <!-- 두 번째 세트 (4개) -->
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">블랙다이아몬드 등산스틱 트레일 프로</p>
                        <p class="product-brand">블랙다이아몬드</p>
                        <p class="product-category">등산용품</p>
                        <p class="product-price">22,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">매드락 감성 우드 캠핑 테이블</p>
                        <p class="product-brand">매드락</p>
                        <p class="product-category">테이블</p>
                        <p class="product-price">16,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">아이두젠 멀티 LED 충전식 캠핑 랜턴</p>
                        <p class="product-brand">아이두젠</p>
                        <p class="product-category">조명/랜턴</p>
                        <p class="product-price">14,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">반고 나이트스타 알파 300 침낭</p>
                        <p class="product-brand">반고</p>
                        <p class="product-category">침낭/매트</p>
                        <p class="product-price">18,000원/일</p>
                    </div>
                </div>
            </div>
            <button class="slider-nav slider-next"><i class="fas fa-chevron-right"></i></button>
        </div>

        <!-- 하단 배너 -->
        <div class="footer-mini-banner">
            <div class="mini-banner-container">
                <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="미니배너 1" class="mini-banner-item">
                <div class="mini-banner-content">
                    <div class="mini-banner-text" style="color:var(--color-coral);">회원가입 시 할인 쿠폰 증정</div>
                </div>
            </div>
            <div class="mini-banner-container">
                <img src="${pageContext.request.contextPath}/resources/images/banner6.png" alt="미니배너 2" class="mini-banner-item">
                <div class="mini-banner-content">
                    <div class="mini-banner-text" style="color:var(--color-white);">캠핑장비 A to Z</div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 메인 배너 순환 및 화살표 동작 수정을 위한 자바스크립트 코드 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 약간의 지연 후 실행 (모든 요소가 완전히 로드된 후)
        setTimeout(function() {

            /* ===== 1. 메인 배너 슬라이드 기능 ===== */
            var mainBanner = {
                container: $('.main-banner'),
                slide: $('.main-banner .banner-slide'),
                items: $('.main-banner .banner-item'),
                prevBtn: $('.main-banner .banner-prev'),
                nextBtn: $('.main-banner .banner-next'),
                currentIndex: 0,
                timer: null,
                totalItems: $('.main-banner .banner-item').length
            };

            console.log('메인 배너 초기화: 총 ' + mainBanner.totalItems + '개 배너');

            // 배너 위치 업데이트 함수
            function updateMainBannerPosition() {
                mainBanner.slide.css('transform', 'translateX(-' + (mainBanner.currentIndex * 33.333) + '%)');
                console.log('메인 배너 위치 업데이트: ' + mainBanner.currentIndex);
            }

            // 다음 배너로 이동
            function goToNextMainBanner() {
                mainBanner.currentIndex = (mainBanner.currentIndex + 1) % mainBanner.totalItems;
                updateMainBannerPosition();
            }

            // 이전 배너로 이동
            function goToPrevMainBanner() {
                mainBanner.currentIndex = (mainBanner.currentIndex - 1 + mainBanner.totalItems) % mainBanner.totalItems;
                updateMainBannerPosition();
            }

            // 자동 슬라이드 시작
            function startMainBannerAutoSlide() {
                stopMainBannerAutoSlide();
                mainBanner.timer = setInterval(goToNextMainBanner, 4000);
            }

            // 자동 슬라이드 중지
            function stopMainBannerAutoSlide() {
                if (mainBanner.timer) {
                    clearInterval(mainBanner.timer);
                    mainBanner.timer = null;
                }
            }

            // 메인 배너 이벤트 설정
            function setupMainBannerEvents() {
                // 이전 버튼 클릭
                mainBanner.prevBtn.off('click').on('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    stopMainBannerAutoSlide();
                    goToPrevMainBanner();
                    startMainBannerAutoSlide();
                    return false;
                });

                // 다음 버튼 클릭
                mainBanner.nextBtn.off('click').on('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    stopMainBannerAutoSlide();
                    goToNextMainBanner();
                    startMainBannerAutoSlide();
                    return false;
                });

                // 마우스 오버/아웃
                mainBanner.container.off('mouseenter mouseleave')
                    .on('mouseenter', stopMainBannerAutoSlide)
                    .on('mouseleave', startMainBannerAutoSlide);
            }

            // 메인 배너 초기화
            function initMainBanner() {
                updateMainBannerPosition();
                setupMainBannerEvents();
                startMainBannerAutoSlide();
                console.log('메인 배너 초기화 완료');
            }

            /* ===== 2. 하단 슬라이더 기능 ===== */
            function setupItemSliders() {
                setupSlider('#md-picks');
                setupSlider('#recent-products');
                console.log('하단 슬라이더 초기화 완료');
            }

            // 개별 슬라이더 설정 함수
            function setupSlider(sliderId) {
                var $slider = $(sliderId);
                var $container = $slider.find('.slider-container');
                var $prevBtn = $slider.find('.slider-prev');
                var $nextBtn = $slider.find('.slider-next');
                var cardWidth = $slider.find('.product-card').first().outerWidth(true) || 235;
                var visibleCards = Math.floor($container.width() / cardWidth);
                var scrollAmount = cardWidth * Math.max(1, Math.floor(visibleCards / 2));

                console.log(sliderId + ' 슬라이더 설정: 카드 너비 = ' + cardWidth + 'px, 보이는 카드 수 = ' + visibleCards);

                $prevBtn.off('click').on('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var currentScroll = $container.scrollLeft();
                    $container.animate({
                        scrollLeft: Math.max(0, currentScroll - scrollAmount)
                    }, 300);
                    return false;
                });

                $nextBtn.off('click').on('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var currentScroll = $container.scrollLeft();
                    var maxScroll = $container[0].scrollWidth - $container.width();
                    $container.animate({
                        scrollLeft: Math.min(maxScroll, currentScroll + scrollAmount)
                    }, 300);
                    return false;
                });

                $(window).on('resize', function() {
                    cardWidth = $slider.find('.product-card').first().outerWidth(true) || 235;
                    visibleCards = Math.floor($container.width() / cardWidth);
                    scrollAmount = cardWidth * Math.max(1, Math.floor(visibleCards / 2));
                });
            }

            /* ===== 3. 한 줄 후기 슬라이더 ===== */
            function setupReviewSlider() {
                var reviewIndex = 0;
                var reviewItems = $(".review-item").length;
                var reviewInterval;

                function updateReviewPosition() {
                    var offset = (100 / reviewItems) * reviewIndex;
                    $(".review-slider").css("transform", "translateX(-" + offset.toFixed(2) + "%)");
                }

                function startReviewSlide() {
                    if (reviewInterval) {
                        clearInterval(reviewInterval);
                    }

                    reviewInterval = setInterval(function() {
                        reviewIndex = (reviewIndex + 1) % reviewItems;
                        updateReviewPosition();
                    }, 3000);
                }

                updateReviewPosition();
                startReviewSlide();
                console.log('한 줄 후기 슬라이더 초기화 완료');
            }

            // 모든 슬라이더 초기화 실행
            initMainBanner();
            setupItemSliders();
            setupReviewSlider();

        }, 200); // 약간의 지연 (200ms) 추가하여 모든 요소가 렌더링된 후 실행
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        // 좋아요 버튼 토글
        $(".fa-solid").click(function () {
            var currentColor = $(this).css('color');
            if (currentColor === 'rgb(242, 232, 207)') {
                $(this).css('color', '#e9745e');
            } else {
                $(this).css('color', '#f2e8cf');
            }
        });

        // 거래/커뮤니티 토글
        $(".toggle-tab-btn").click(function() {
            $(".toggle-tab-btn").removeClass("active");
            $(this).addClass("active");
        });

        // 캘린더 초기화 datepicker 설정
        if ($('#date-range').length && typeof $.fn.daterangepicker === 'function') {
            if (!$('#date-range').data('daterangepicker')) {
                $('#date-range').daterangepicker({
                    opens: 'right',
                    autoApply: true,
                    locale: {
                        format: 'YYYY/MM/DD',
                        separator: ' - ',
                        applyLabel: '적용',
                        cancelLabel: '취소',
                        fromLabel: '시작일',
                        toLabel: '종료일',
                        daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
                    }
                });

                let picker = $('#date-range').data('daterangepicker');
                picker.setStartDate(moment());
                picker.setEndDate(moment().add(3, 'days'));

                $('#date-range').on('apply.daterangepicker', function(ev, picker) {
                    var startDate = picker.startDate.format('YYYY/MM/DD');
                    var endDate = picker.endDate.format('YYYY/MM/DD');
                    $(this).val(startDate + ' - ' + endDate);
                });

                $('#date-range').val(
                    moment().format('YYYY/MM/DD') + ' - ' + moment().add(3, 'days').format('YYYY/MM/DD')
                );
            }
        }

        // 날짜 선택 이벤트 핸들러 추가
        $('#date-range').on('apply.daterangepicker', function(ev, picker) {
            var startDate = picker.startDate.format('YYYY/MM/DD');
            var endDate = picker.endDate.format('YYYY/MM/DD');
            $(this).val(startDate + ' - ' + endDate);

            // hidden 필드 업데이트
            $('#hidden-start-date').val(picker.startDate.format('YYYY-MM-DD'));
            $('#hidden-end-date').val(picker.endDate.format('YYYY-MM-DD'));
        });

        // 가격 슬라이더 초기화
        var priceSlider = document.getElementById('price-range');
        if (priceSlider && typeof noUiSlider !== 'undefined') {
            if (!priceSlider.noUiSlider) {
                noUiSlider.create(priceSlider, {
                    start: [0, 100000],
                    connect: true,
                    range: {
                        min: 0,
                        max: 100000
                    },
                    step: 1000,
                    format: {
                        to: function (value) {
                            return Math.round(value).toLocaleString();
                        },
                        from: function (value) {
                            return Number(value.replace(/,/g, ''));
                        }
                    }
                });

                // 가격 표시 요소
                var minPriceDisplay = document.getElementById('min-price');
                var maxPriceDisplay = document.getElementById('max-price');

                // 슬라이더 업데이트 이벤트
                priceSlider.noUiSlider.on('update', function (values, handle) {
                    // 화면에 가격 표시 업데이트
                    if (handle === 0 && minPriceDisplay)
                        minPriceDisplay.textContent = values[0] + '원';
                    if (handle === 1 && maxPriceDisplay)
                        maxPriceDisplay.textContent = values[1] + '원';

                    // hidden 필드 업데이트
                    $('#hidden-min-price').val(values[0].replace(/,/g, ''));
                    $('#hidden-max-price').val(values[1].replace(/,/g, ''));
                });
            }
        }

        // 필터 검색을 위한 함수 정의
        // 가격 슬라이더 값 업데이트 이벤트 핸들러
        priceSlider.noUiSlider.on('update', function (values, handle) {
            if (handle === 0) minPrice.textContent = values[0] + '원';
            if (handle === 1) maxPrice.textContent = values[1] + '원';

            // hidden 필드 업데이트
            $('#hidden-min-price').val(values[0].replace(/,/g, ''));
            $('#hidden-max-price').val(values[1].replace(/,/g, ''));
        });

        $('.filter-btn').on('click', function () {
            $('.filter-btn').removeClass('active');
            $(this).addClass('active');
        });

        // MD Pick 슬라이더 네비게이션
        $("#md-picks .slider-prev").click(function() {
            var container = $(this).siblings(".slider-container");
            var scrollAmount = container.width();
            container.animate({ scrollLeft: '-=' + scrollAmount }, 300);
        });

        $("#md-picks .slider-next").click(function() {
            var container = $(this).siblings(".slider-container");
            var scrollAmount = container.width();
            container.animate({ scrollLeft: '+=' + scrollAmount }, 300);
        });

        // 최근 등록 상품 슬라이더 네비게이션
        $("#recent-products .slider-prev").click(function() {
            var container = $(this).siblings(".slider-container");
            var scrollAmount = container.width();
            container.animate({ scrollLeft: '-=' + scrollAmount }, 300);
        });

        $("#recent-products .slider-next").click(function() {
            var container = $(this).siblings(".slider-container");
            var scrollAmount = container.width();
            container.animate({ scrollLeft: '+=' + scrollAmount }, 300);
        });

        // 한 줄 후기 자동 슬라이더
        var reviewIndex = 0;
        var reviewItems = $(".review-item").length;

        setInterval(function() {
            reviewIndex = (reviewIndex + 1) % reviewItems;
            updateReviewPosition();
        }, 3000);

        function updateReviewPosition() {
            var offset = (100 / reviewItems) * reviewIndex;
            $(".review-slider").css("transform", "translateX(-" + offset.toFixed(2) + "%)");
        }

        // 처음에 0번째 슬라이드 보이도록 강제 렌더링
        updateReviewPosition();
    });

    window.applyFilter = function () {
        // 폼 제출
        $('#searchForm').submit();

        Swal.fire({
            icon: 'success',
            title: '필터 적용 완료!',
            text: '조건에 맞게 필터링 되었습니다.',
            confirmButtonColor: '#2C5F2D'
        });
    };
</script>

</body>
</html>