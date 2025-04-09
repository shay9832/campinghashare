<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 찜 목록</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container container-wide mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="myPage-trust.jsp" class="sidebar-link">신뢰도</a></li>
                    <li><a href="myPage-point.jsp" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="myPage-inspecList.jsp" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="myPage-delivery.jsp" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="myPage-wishlist.jsp" class="sidebar-link title active">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="" class="sidebar-link title">
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
            <h2 class="page-title">찜 목록</h2>
        </div>

        <!-- 검색 섹션 -->
        <div class="search-container mb-4">
            <input type="text" class="form-control" placeholder="어떤 장비를 찾으시나요?">
            <button class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <!-- 필터링 및 정렬 옵션 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex flex-wrap align-items-center">
                <div class="tab-nav">
                    <a class="tab-link active" href="#">전체</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">텐트/쉘터</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">취침용품</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">캠핑가구</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">조명/전력장비</a>
                </div>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="sort-container">
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>높은가격순</option>
                    <option>낮은가격순</option>
                    <option>이름순</option>
                </select>
            </div>
        </div>

        <!-- 찜 목록 카운트 -->
        <p class="product-count mb-3">총 12개의 찜 항목이 있습니다.</p>

        <!-- 상품 리스트 - 제품 카드 형태 -->
        <div class="product-container">
            <ul>
                <!-- 첫 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">코베아 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                            <p class="product-brand">코베아몰</p>
                            <p class="product-category">텐트/쉘터</p>
                            <p class="product-price">30,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 두 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">몬테라 sleeping bag 800+ 침낭</p>
                            <p class="product-brand">아웃도어스</p>
                            <p class="product-category">취침용품</p>
                            <p class="product-price">15,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 세 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">캠핑 테이블 접이식 야외 바베큐 테이블</p>
                            <p class="product-brand">캠핑매니아</p>
                            <p class="product-category">캠핑가구</p>
                            <p class="product-price">12,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 네 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">헬리녹스 캠핑 체어 경량 의자</p>
                            <p class="product-brand">아웃도어스</p>
                            <p class="product-category">캠핑가구</p>
                            <p class="product-price">8,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 다섯 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">LED 랜턴 충전식 캠핑 조명 야외 조명</p>
                            <p class="product-brand">라이팅월드</p>
                            <p class="product-category">조명/전력장비</p>
                            <p class="product-price">5,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 여섯 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">콜맨 투버너 스토브 휴대용 가스레인지</p>
                            <p class="product-brand">콜맨코리아</p>
                            <p class="product-category">조리장비</p>
                            <p class="product-price">7,500원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 일곱 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">실내외겸용 코베아 히터 가스난로</p>
                            <p class="product-brand">코베아몰</p>
                            <p class="product-category">냉/난방장비</p>
                            <p class="product-price">10,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 여덟 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">캠핑용 냉장고 아이스박스 쿨러</p>
                            <p class="product-brand">캠핑매니아</p>
                            <p class="product-category">냉/난방장비</p>
                            <p class="product-price">9,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 아홉 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">캠핑 랜턴 LED 충전식 캠핑용품</p>
                            <p class="product-brand">라이팅월드</p>
                            <p class="product-category">조명/전력장비</p>
                            <p class="product-price">8,500원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 열 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">네이쳐하이크 초경량 백패킹 텐트 1인용</p>
                            <p class="product-brand">네이처몰</p>
                            <p class="product-category">텐트/쉘터</p>
                            <p class="product-price">12,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 열한 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">캠핑용 접이식 테이블 야외 피크닉</p>
                            <p class="product-brand">아웃도어스</p>
                            <p class="product-category">캠핑가구</p>
                            <p class="product-price">7,000원/일</p>
                        </div>
                    </div>
                </li>

                <!-- 열두 번째 찜 항목 -->
                <li>
                    <a href="storen_matching_request.jsp"></a>
                    <div class="product-card">
                        <div class="product-image">
                            <div class="product-placeholder"></div>
                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                        </div>
                        <div class="product-info">
                            <p class="product-title">코베아 버너 3단 멀티 고화력 가스레인지</p>
                            <p class="product-brand">코베아몰</p>
                            <p class="product-category">조리장비</p>
                            <p class="product-price">6,500원/일</p>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination-container d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // 좋아요 버튼 클릭 이벤트 (하트 아이콘)
        $('.like-button').click(function() {
            const $productCard = $(this).closest('.product-card');
            const productTitle = $productCard.find('.product-title').text();

            if(confirm('"' + productTitle + '" 상품을 찜 목록에서 삭제하시겠습니까?')) {
                $productCard.closest('li').fadeOut(300, function() {
                    $(this).remove();
                    // 남은 찜 항목 수 업데이트
                    updateWishlistCount();
                });

                // 알림 메시지
                alert('"' + productTitle + '" 상품이 찜 목록에서 삭제되었습니다.');
            }
        });

        // 탭 필터 클릭 이벤트
        $('.tab-link').click(function(e) {
            e.preventDefault();
            $('.tab-link').removeClass('active');
            $(this).addClass('active');

            const category = $(this).text().trim();

            if (category === '전체') {
                $('.product-card').closest('li').show();
            } else {
                $('.product-card').closest('li').hide();
                $('.product-card').each(function() {
                    const productCategory = $(this).find('.product-category').text();
                    if (productCategory.includes(category)) {
                        $(this).closest('li').show();
                    }
                });
            }

            // 표시된 아이템 수 업데이트
            updateVisibleCount();
        });

        // 정렬 옵션 변경 이벤트
        $('.sort-select').change(function() {
            const sortOption = $(this).val();
            const $items = $('.product-card').parent('li').detach().toArray();

            // 정렬 기준에 따라 아이템 재정렬
            $items.sort(function(a, b) {
                const aInfo = $(a).find('.product-info');
                const bInfo = $(b).find('.product-info');

                if (sortOption === '최신순') {
                    // 기존 순서 유지 (이 예제에서는 변경 없음)
                    return 0;
                } else if (sortOption === '높은가격순') {
                    const aPrice = parseInt($(aInfo).find('.product-price').text().replace(/[^0-9]/g, ''));
                    const bPrice = parseInt($(bInfo).find('.product-price').text().replace(/[^0-9]/g, ''));
                    return bPrice - aPrice;
                } else if (sortOption === '낮은가격순') {
                    const aPrice = parseInt($(aInfo).find('.product-price').text().replace(/[^0-9]/g, ''));
                    const bPrice = parseInt($(bInfo).find('.product-price').text().replace(/[^0-9]/g, ''));
                    return aPrice - bPrice;
                } else if (sortOption === '이름순') {
                    const aName = $(aInfo).find('.product-title').text();
                    const bName = $(bInfo).find('.product-title').text();
                    return aName.localeCompare(bName, 'ko');
                }
            });

            // 정렬된 아이템 다시 추가
            $('.product-container ul').append($items);
        });

        // 검색 기능
        $('.search-button').click(function() {
            const searchText = $('.search-container input').val().toLowerCase();

            if (searchText.trim() === '') {
                $('.product-card').closest('li').show();
            } else {
                $('.product-card').closest('li').hide();
                $('.product-card').each(function() {
                    const title = $(this).find('.product-title').text().toLowerCase();
                    const brand = $(this).find('.product-brand').text().toLowerCase();
                    const category = $(this).find('.product-category').text().toLowerCase();
                    if (title.includes(searchText) || brand.includes(searchText) || category.includes(searchText)) {
                        $(this).closest('li').show();
                    }
                });
            }

            // 표시된 아이템 수 업데이트
            updateVisibleCount();
        });

        // 검색창 엔터키 이벤트
        $('.search-container input').keypress(function(e) {
            if (e.which === 13) {
                $('.search-button').click();
                return false;
            }
        });

        // 찜 목록 개수 업데이트 함수
        function updateWishlistCount() {
            const count = $('.product-card').length;
            $('.product-count').text('총 ' + count + '개의 찜 항목이 있습니다.');
        }

        // 현재 표시된 아이템 수 업데이트 함수
        function updateVisibleCount() {
            const visibleCount = $('.product-card:visible').length;
            $('.product-count').text('총 ' + visibleCount + '개의 찜 항목이 표시되고 있습니다.');
        }
    });
</script>

<style>
    /* 찜 목록 페이지 전용 CSS */
    .product-count {
        font-size: 14px;
        color: #666;
        margin-top: 10px;
    }

    /* 검색 컨테이너 스타일 */
    .search-container {
        position: relative;
        max-width: 500px;
        margin: 0 auto;
    }

    .search-container input {
        width: 100%;
        padding: 12px 20px;
        padding-right: 50px;
        border-radius: 50px;
        border: 1px solid #ddd;
        font-size: 14px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        transition: all 0.3s;
    }

    .search-container input:focus {
        outline: none;
        border-color: #2C5F2D;
        box-shadow: 0 2px 8px rgba(44, 95, 45, 0.15);
    }

    .search-button {
        position: absolute;
        right: 5px;
        top: 50%;
        transform: translateY(-50%);
        width: 40px;
        height: 40px;
        border: none;
        background-color: #2C5F2D;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s;
    }

    .search-button:hover {
        background-color: #224c23;
    }

    /* 탭 네비게이션 스타일 */
    .tab-nav {
        margin-right: 10px;
        margin-bottom: 10px;
    }

    .tab-link {
        display: inline-block;
        padding: 8px 16px;
        border-radius: 20px;
        text-decoration: none;
        color: #495057;
        background-color: #f8f9fa;
        transition: all 0.3s ease;
    }

    .tab-link:hover {
        background-color: #e9ecef;
    }

    .tab-link.active {
        background-color: #2C5F2D;
        color: white;
    }

    /* 정렬 컨테이너 스타일 */
    .sort-container {
        width: 120px;
    }

    .sort-select {
        padding: 8px 12px;
        border-radius: 4px;
        border: 1px solid #ddd;
        font-size: 14px;
        color: #495057;
        background-color: white;
        cursor: pointer;
    }

    .sort-select:focus {
        outline: none;
        border-color: #2C5F2D;
    }

    /* 상품 컨테이너 및 카드 스타일 */
    .product-container {
        margin-top: 20px;
        background-color: #f9f9f7;
        border-radius: 8px;
        padding: 20px;
    }

    .product-container ul {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        padding: 0;
        margin: 0;
        list-style-type: none;
    }

    .product-card {
        position: relative;
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        transition: all 0.3s;
        height: 100%;
        cursor: pointer;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .product-image {
        position: relative;
        width: 100%;
        padding-top: 75%; /* 4:3 비율 */
        background-color: #f8f8f8;
        border-radius: 8px 8px 0 0;
        overflow: hidden;
    }

    .product-placeholder {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: #f5f5f5;
        background-image: linear-gradient(45deg, #eee 25%, transparent 25%, transparent 75%, #eee 75%, #eee),
        linear-gradient(45deg, #eee 25%, transparent 25%, transparent 75%, #eee 75%, #eee);
        background-size: 20px 20px;
        background-position: 0 0, 10px 10px;
    }

    .like-button {
        position: absolute;
        bottom: 10px;
        right: 10px;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-color: white;
        border: none;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.2s;
        z-index: 2;
    }

    .like-button:hover {
        transform: scale(1.1);
        box-shadow: 0 3px 8px rgba(0,0,0,0.3);
    }

    .product-info {
        padding: 15px;
    }

    .product-title {
        font-size: 14px;
        font-weight: 500;
        color: #333;
        margin-bottom: 8px;
        line-height: 1.4;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .product-brand {
        font-size: 12px;
        color: #666;
        margin-bottom: 3px;
    }

    .product-category {
        font-size: 12px;
        color: #2C5F2D;
        margin-bottom: 8px;
        font-weight: 500;
    }

    .product-price {
        font-size: 15px;
        font-weight: 600;
        color: #333;
        margin-bottom: 0;
    }

    /* 페이지네이션 스타일 */
    .pagination-container {
        margin-top: 30px;
    }

    .pagination {
        display: flex;
        list-style: none;
        padding: 0;
        margin: 0;
        justify-content: center;
    }

    .page-item {
        margin: 0 3px;
    }

    .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border: 1px solid #ddd;
        border-radius: 4px;
        color: #555;
        text-decoration: none;
        font-size: 14px;
        transition: all 0.2s ease;
    }

    .page-item.active .page-link {
        background-color: #2C5F2D;
        color: white;
        border-color: #2C5F2D;
    }

    .page-item.disabled .page-link {
        color: #aaa;
        pointer-events: none;
        background-color: #f5f5f5;
    }

    .page-link:hover:not(.disabled):not(.active) {
        background-color: #f1f8f1;
        color: #2C5F2D;
        border-color: #2C5F2D;
    }

    /* 반응형 디자인 */
    @media (max-width: 1200px) {
        .product-container ul {
            grid-template-columns: repeat(3, 1fr);
        }
    }

    @media (max-width: 768px) {
        .product-container ul {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 576px) {
        .product-container ul {
            grid-template-columns: repeat(1, 1fr);
        }

        .tab-link {
            padding: 6px 12px;
            font-size: 13px;
        }
    }
</style>
</body>
</html>