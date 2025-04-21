<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title active">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
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

        <!-- 매칭 신청 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tabs">
                <div class="tab ${activeTab == 'storen' ? 'active' : ''}" data-tab="storen" id="storen-tab">스토렌</div>
                <div class="tab ${activeTab == 'rental' ? 'active' : ''}" data-tab="rental" id="rental-tab">렌탈</div>
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
            <p class="product-count mb-3">총 ${storenList.size()}개의 찜 항목이 있습니다.</p>

            <!-- 상품 리스트 - 제품 카드 형태 -->
            <div class="product-container">
                <c:choose>
                    <c:when test="${storenList != null && !empty storenList}">
                            <ul>
                            <c:forEach var="storen" items="${storenList}">
                                <li>
                                    <div class="product-card">
                                        <a href="storen_matching_request.action?storenId=${storen.storen_id}" class="product-link">
                                        <div class="product-image">
                                            <c:choose>
                                            <c:when test="${storen.equipmentDTO.attachments.get(0) != null && !empty storen.equipmentDTO.attachments}">
                                                <img src="${storen.equipmentDTO.attachments.get(0).attachmentPath}" alt="상품 이미지">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-placeholder"></div>
                                            </c:otherwise>
                                            </c:choose>
                                            <button class="like-button"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>
                                        </div>
                                        <div class="product-info">
                                            <p class="product-title">${storen.storen_title}</p>
                                            <p class="product-brand">${storen.equipmentDTO.brand}</p>
                                            <p class="product-category">${storen.equipmentDTO.majorCategory} > ${storen.equipmentDTO.middleCategory}</p>
                                            <p class="product-price">${storen.daily_rent_price}원/일</p>
                                        </div>
                                    </div>
                                    </a>
                                </li>
                            </c:forEach>
                            </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fa-solid fa-heart-crack"></i>
                            <p>찜한 상품이 없습니다</p>
                            <div class="hint">대여하고 싶은 상품을 찾으면 하트를 눌러서 찜해주세요!</div>
                        </div>
                    </c:otherwise>
                </c:choose>
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
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // URL에서 탭 정보 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        let tabFromUrl = urlParams.get('tab');

        // 메인 탭 초기화 (스토렌/렌탈)
        let activeMainTab = tabFromUrl || "storen"; // URL 파라미터 또는 기본값

        // 매칭 탭 전환 기능
        $('.tab').on('click', function() {
            const tabId = $(this).data('tab');

            // 현재 활성화된 탭이면 아무것도 하지 않음
            if(activeMainTab === tabId) return;

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 메인 탭 상태 저장
            activeMainTab = tabId;

            // 탭 전환 시 데이터 다시 로드
            loadWishData(activeMainTab);
        });

        // 좋아요 버튼 클릭 이벤트 (하트 아이콘)
        $(document).on('click', '.like-button', function(e) {
            e.preventDefault();         // 링크 이동 방지
            e.stopPropagation();        // 이벤트 버블링 중지
            const $productCard = $(this).closest('.product-card');
            const productTitle = $productCard.find('.product-title').text();
            const id = $(this).data('id');
            const type = $(this).data('type');

            if(confirm('"' + productTitle + '" 상품을 찜 목록에서 삭제하시겠습니까?')) {
                // AJAX로 DB에서 삭제 요청
                $.ajax({
                    url: '/api/wish/delete',
                    type: 'POST',
                    data: { id: id,
                            type: type},
                    success: function(response) {
                        if(response.success) {
                            // 화면에서 요소 제거
                            $productCard.closest('li').fadeOut(300, function() {
                                $(this).remove();
                                // 남은 찜 항목 수 업데이트
                                updateWishlistCount();
                            });

                            // 알림 메시지
                            alert('"' + productTitle + '" 상품이 찜 목록에서 삭제되었습니다.');
                        } else {
                            alert('삭제 중 오류가 발생했습니다: ' + response.message);
                        }
                    },
                    error: function() {
                        alert('서버 통신 중 오류가 발생했습니다.');
                    }
                });
            }
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

    function loadWishData(activeMainTab) {
        let apiUrl = '';

        // 메인 탭과 서브 탭에 따라 API URL 결정
        if (activeMainTab === 'storen') {
            apiUrl = '/api/wish/storen';
        } else { // 렌탈 탭
            apiUrl = '/api/wish/rental';
        }

        console.log("데이터 로드 중:", apiUrl, "메인탭:", activeMainTab);

        // 빈 테이블 초기화
        let targetDiv= $('.product-container');

        // AJAX 요청
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            cache: false, // 캐시 사용 안 함
            success: function(data) {
                console.log("데이터 로드 성공:", data.length, "건");

                if (data.length === 0) {
                    // 데이터가 없는 경우
                    // 찜 목록 개수 업데이트
                    $('.product-count').text('총 ' + 0 + '개의 찜 항목이 있습니다.');

                    targetDiv.html(
                        '<div class="empty-state" style="width:100%;">' +
                        '<i class="fa-solid fa-heart-crack"></i>' +
                        '<p>찜한 상품이 없습니다</p>' +
                        '<div class="hint">대여하고 싶은 상품을 찾으면 하트를 눌러서 찜해주세요!</div>' +
                        '</div>');
                    return;
                }

                // 데이터 렌더링
                renderData(data, targetDiv);

                // 찜 목록 개수 업데이트 함수
                updateWishlistCount();
            },
            error: function(xhr, status, error) {
                console.error("데이터 로드 실패:", error);

                // 찜 목록 개수 업데이트
                $('.product-count').text('총 ' + 0 + '개의 찜 항목이 있습니다.');

                // 에러 메시지 표시
                targetDiv.html(
                    '<div class="alert alert-danger" style="width:100%;" role="alert">' +
                    '<i class="fas fa-exclamation-circle me-2"></i>' +
                    '<p>데이터를 불러오는 중 오류가 발생했습니다.</p>' +
                    '<div class="hint">대여하고 싶은 상품을 찾으면 하트를 눌러서 찜해주세요!</div>' +
                    '</div>'
                );
            }
        });
    }

    function renderData(data, targetDiv) {
        let html = '';
        const formatter = new Intl.NumberFormat('ko-KR');

        html += '<ul>';
        data.forEach(function(item) {
            const attachments = item.equipmentDTO.attachments;
            if (Array.isArray(attachments) && attachments.length > 0 && attachments[0].attachmentPath) {
                imageSrc = `<img src="` + attachments[0].attachmentPath + `" alt="상품 이미지">`;
            }
            html +=
                '<li>' +
                '<div class="product-card">' +
                '<a href="storen_matching_request.action?storenId=' + item.storen_id + '">' +
                '<div class="product-image">' +
                imageSrc +
                '<button class="like-button" data-id="' + item.storen_id + '" data-type="storen"><i class="fa-solid fa-heart" style="color: #e9745e;"></i></button>' +
                '</div>' +
                '<div class="product-info">' +
                '<p class="product-title">' + item.storen_title + '</p>' +
                '<p class="product-brand">' + item.equipmentDTO.brand + '</p>' +
                '<p class="product-category">' + item.equipmentDTO.majorCategory + ' > ' + item.equipmentDTO.middleCategory + '</p>' +
                '<p class="product-price">' + formatter.format(parseInt(item.daily_rent_price)) + '원/일</p>' +
                '</div>' +
                '</div>' +
                '</a>' +
                '</li>';
        });
        html += '</ul>';
        targetDiv.html(html);
    }


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
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
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
    .product-link {
        display: block;
        text-decoration: none;
        color: inherit;
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