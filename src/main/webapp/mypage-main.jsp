<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 마이페이지</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 화살표 버튼 CSS -->
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/arrow-buttons.css">--%>
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-password-check.jsp" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="#" class="sidebar-link">회원 등급</a></li>
                    <li><a href="#" class="sidebar-link">신뢰도</a></li>
                    <li><a href="#" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-my-equip.jsp" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="#" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">마이 페이지</h2>
        </div>

        <!-- 회원 정보 섹션 -->
        <div class="content-box">
            <div class="user-info-section">
                <div class="user-info-content">
                    <div class="user-details">
                        <h3>가나초콜릿 님</h3>
                        <div class="user-status">
                            <span>회원 등급: 자연인</span>
                            <span class="profit-info">총 수익 +0,000,000원</span>
                        </div>
                        <div class="user-stats">
                            <div class="stat-item">
                                <span class="stat-label">포인트:</span>
                                <span class="stat-value">000</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">신뢰도:</span>
                                <span class="stat-value">00%</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">쿠폰:</span>
                                <span class="stat-value">00개</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 거래 내역 탭 섹션 -->
        <div class="tab-nav">
            <button class="tab-link active">
                <i class="fa fa-exchange-alt"></i> 등록 장비 내역: 0건
            </button>
            <button class="tab-link">
                <i class="fa fa-shopping-cart"></i> 대여 장비 내역: 0건
            </button>
            <button class="tab-link">
                <i class="fa fa-clipboard-list"></i> 찜 내역: 0건
            </button>
            <button class="tab-link">
                <i class="fa fa-comments"></i> 1:1 문의 내역: 0건
            </button>
        </div>
        <div class="content-box">
            <div class="transaction-content">
                <p class="no-content">등록한 장비가 없습니다.</p>
            </div>
        </div>

        <!-- 내가 작성한 글/댓글 탭 섹션 -->
        <div class="tab-nav">
            <button class="tab-link active">
                <i class="fa fa-pen"></i> 내가 작성한 글: 0건
            </button>
            <button class="tab-link">
                <i class="fa fa-comment"></i> 내가 작성한 댓글: 0건
            </button>
        </div>
        <div class="content-box">
            <div class="post-content">
                <p class="no-content">작성한 글이 없습니다.</p>
            </div>
        </div>

        <!-- 이용 내역 섹션 -->
        <div class="section-header">이용 내역</div>
        <div class="two-column-layout">
            <!-- 즉시 확인 필요 박스 (왼쪽) -->
            <div class="urgent-box">
                <div class="urgent-header">즉시 확인 필요</div>
                <div class="urgent-content">
                    <a href="#" class="urgent-item">
                        <div class="item-label">검수 결과 확인</div>
                        <div class="item-count">3</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">매칭 승인 대기</div>
                        <div class="item-count">5</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">주가 비용 결제 대기</div>
                        <div class="item-count">2</div>
                    </a>
                </div>
            </div>

            <!-- 거래 현황 박스 (오른쪽) -->
            <div class="transaction-status-box">
                <div class="status-header">거래 현황</div>
                <div class="status-content">
                    <!-- 스토렌 -->
                    <div class="status-row">
                        <div class="status-type">스토렌</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 렌탈 -->
                    <div class="status-row">
                        <div class="status-type">렌탈</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 보관 -->
                    <div class="status-row">
                        <div class="status-type">보관</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 찜 목록 섹션 -->
        <div class="product-list-section">
            <div class="section-header-with-link">
                <h3>찜 목록</h3>
                <a href="#" class="view-all-link">전체보기</a>
            </div>
            <div class="product-slider-container">
                <button class="slider-nav-button prev-button">
                    <i class="fa fa-chevron-left"></i>
                </button>

                <div class="product-slider">
                    <!-- 아이템 프리뷰 아이템들 -->
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="아이템 이미지">
                        </div>
                        <div class="product-info">
                            <div class="product-title">코베아 KOVEA W 4인용 거실형 텐트 패밀리 텐트</div>
                            <div class="product-brand">코베아몰</div>
                            <div class="product-price">30,000원</div>
                        </div>
                    </div>

                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="아이템 이미지">
                        </div>
                        <div class="product-info">
                            <div class="product-title">몬테라 sleeping bag 800+ 침낭</div>
                            <div class="product-brand">아웃도어스</div>
                            <div class="product-price">15,000원</div>
                        </div>
                    </div>

                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="아이템 이미지">
                        </div>
                        <div class="product-info">
                            <div class="product-title">캠핑 테이블 접이식 야외 바베큐 테이블</div>
                            <div class="product-brand">캠핑매니아</div>
                            <div class="product-price">12,000원</div>
                        </div>
                    </div>

                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="아이템 이미지">
                        </div>
                        <div class="product-info">
                            <div class="product-title">헬리녹스 캠핑 체어 경량 의자</div>
                            <div class="product-brand">아웃도어스</div>
                            <div class="product-price">8,000원</div>
                        </div>
                    </div>
                </div>

                <button class="slider-nav-button next-button">
                    <i class="fa fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script type="text/javascript">
    // 다음 찜 아이템 카드로 이동 기능 구현
    $(document).ready(function() {
        const $slider = $('.product-slider');
        const $prevButton = $('.prev-button');
        const $nextButton = $('.next-button');
        const $cards = $slider.find('.product-card');

        const cardWidth = $cards.outerWidth(true); // 카드 + 마진 포함
        const visibleWidth = $slider.innerWidth(); // 현재 보이는 영역 너비

        let currentScroll = 0;

        $nextButton.on('click', function() {
            // 한 번에 '카드 하나 분량'만큼 이동
            currentScroll = Math.min(currentScroll + cardWidth, $slider[0].scrollWidth - visibleWidth);
            $slider.animate({ scrollLeft: currentScroll }, 100);
        });

        $prevButton.on('click', function() {
            currentScroll = Math.max(currentScroll - cardWidth, 0);
            $slider.animate({ scrollLeft: currentScroll }, 100);
        });
    });
</script>
</body>
</html>