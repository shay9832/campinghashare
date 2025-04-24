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

        /* 메인 배너 */
        .main-banner {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
            border: 1px solid #e1e1e1;
            display: flex;
            align-items: center;
            justify-content: center;
            margin : 0 auto 20px;
        }

        .banner-content {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            z-index: 2;
        }

        .banner-text {
            color: #404040;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .service-intro-btn {
            display: inline-block;
            padding: 8px 15px;
            background-color: white;
            color: #333;
            border-radius: 5px;
            font-size: 14px;
            text-decoration: none;
            border: 1px solid #ddd;
        }

        .banner-prev,
        .banner-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #999;
            font-size: 24px;
            cursor: pointer;
            z-index: 10;
        }

        .banner-prev {
            left: 10px;
        }

        .banner-next {
            right: 10px;
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

        /* 아이템 슬라이더 */
        .item-slider {
            position: relative;
            padding: 0 20px 20px;
        }

        .slider-container {
            display: flex;
            gap: 15px;
            overflow-x: hidden;
            padding: 10px 0;
            scroll-behavior: smooth;
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

        .mini-banner-item {
            width: 48%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
        }

        /* 슬라이더 버튼 */
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

        .slider-prev {
            left: 0;
        }

        .slider-next {
            right: 0;
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
                    <img src="${pageContext.request.contextPath}/resources/images/banner7.png" alt="배너1" style="width:100%; height:100%; object-fit: cover;">
                    <div class="banner-content">
                        <div class="banner-text">서비스 소개</div>
                    </div>
                </div>
                <div class="banner-item">
                    <img src="${pageContext.request.contextPath}/resources/images/banner2.jpg" alt="배너2" style="width:100%; height:100%; object-fit: cover;">
                    <div class="banner-content">
                        <div class="banner-text">특별 프로모션 - 30% 할인</div>
                    </div>
                </div>
                <div class="banner-item">
                    <img src="${pageContext.request.contextPath}/resources/images/banner4.jpeg" alt="배너3" style="width:100%; height:100%; object-fit: cover;">
                    <div class="banner-content">
                        <div class="banner-text">신규 상품 소개</div>
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
                        <p class="product-title">스노우피크 아메니티 돔 M 텐트 5인용</p>
                        <p class="product-brand">스노우피크</p>
                        <p class="product-category">텐트/쉘터</p>
                        <p class="product-price">45,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">콜맨 퍼펙트 랜턴 295 LED 캠핑등</p>
                        <p class="product-brand">콜맨</p>
                        <p class="product-category">조명/랜턴</p>
                        <p class="product-price">18,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">로고스 체어 캠핑 의자 접이식 릴렉스</p>
                        <p class="product-brand">로고스</p>
                        <p class="product-category">의자/테이블</p>
                        <p class="product-price">12,000원/일</p>
                    </div>
                </div>
                <div class="product-card">
                    <div class="product-image">
                        <div class="product-placeholder"></div>
                    </div>
                    <div class="product-info">
                        <p class="product-title">네이처하이크 침낭 코튼 사계절 백패킹</p>
                        <p class="product-brand">네이처하이크</p>
                        <p class="product-category">침낭/매트</p>
                        <p class="product-price">20,000원/일</p>
                    </div>
                </div>
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
            <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="미니배너 1" class="mini-banner-item">
            <img src="${pageContext.request.contextPath}/resources/images/banner2.jpg" alt="미니배너 2" class="mini-banner-item">
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    $(document).ready(function() {
        // 배너 슬라이드 CSS 강제 수정
        $(".banner-slide").css({
            "display": "flex",
            "width": "300%", // 3개의 배너를 위한 너비
            "height": "100%",
            "transition": "transform 1s ease-in-out"
        });

        $(".banner-item").css({
            "flex": "0 0 100%", // 부모 컨테이너의 1/3이 아닌 전체 main-banner의 100%를 차지하도록
            "width": "100%",
            "height": "100%",
            "position": "relative"
        });

        // main-banner의 너비를 고정
        $(".main-banner").css({
            "width": "100%",
            "overflow": "hidden"
        });

        // 배너 관련 변수
        var bannerIndex = 0;
        var bannerCount = $(".banner-item").length;
        var autoSlideInterval;

        console.log("Banner items found:", bannerCount);

        // 배너 위치 업데이트 함수
        function updateBannerPosition() {
            // 이제 각 배너가 100%이므로 100%씩 이동
            $(".banner-slide").css("transform", "translateX(-" + (bannerIndex * 100) + "%)");
            console.log("Banner position updated to:", bannerIndex);
        }

        // 이전 배너 버튼 클릭 이벤트
        $(".banner-prev").off("click").on("click", function(e) {
            e.preventDefault();
            bannerIndex = (bannerIndex - 1 + bannerCount) % bannerCount;
            updateBannerPosition();

            // 자동 슬라이드 재시작
            clearInterval(autoSlideInterval);
            startAutoSlide();

            console.log("Prev clicked, new index:", bannerIndex);
        });

        // 다음 배너 버튼 클릭 이벤트
        $(".banner-next").off("click").on("click", function(e) {
            e.preventDefault();
            bannerIndex = (bannerIndex + 1) % bannerCount;
            updateBannerPosition();

            // 자동 슬라이드 재시작
            clearInterval(autoSlideInterval);
            startAutoSlide();

            console.log("Next clicked, new index:", bannerIndex);
        });

        // 자동 슬라이드 시작 함수
        function startAutoSlide() {
            autoSlideInterval = setInterval(function() {
                bannerIndex = (bannerIndex + 1) % bannerCount;
                updateBannerPosition();
                console.log("Auto slide triggered, new index:", bannerIndex);
            }, 5000);
        }

        // 배너에 마우스 올리면 자동 전환 멈춤
        $(".main-banner").hover(
            function() {
                clearInterval(autoSlideInterval);
                console.log("Auto slide paused");
            },
            function() {
                startAutoSlide();
                console.log("Auto slide resumed");
            }
        );

        // 초기 배너 위치 설정 및 자동 슬라이드 시작
        updateBannerPosition();
        startAutoSlide();
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