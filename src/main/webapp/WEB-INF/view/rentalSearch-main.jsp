<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>rentalSearch-main.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<jsp:include page="${pageContext.request.contextPath}//WEB-INF/view/header.jsp"/>

<div class="main-container">
    <!-- 왼쪽 카테고리 메뉴 -->
    <div class="left-category">
        <ul>
            <li>
                <a id="all" href="" onclick="" class="on">ALL</a>
            </li>
            <li>
                <a id="brand" href="" onclick="">브랜드</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">가나다</a></li>
                    <li><a href="" onclick="">라바사</a></li>
                    <li><a href="" onclick="">아자카</a></li>
                    <li><a href="" onclick="">타파하</a></li>
                </ul>
            </li>
            <li>
                <a id="category1" href="" onclick="">텐트/쉘터</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
            <li>
                <a id="category4" href="" onclick="">조명/전력장비</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
            <li>
                <a id="category5" href="" onclick="">조리장비</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
            <li>
                <a id="category6" href="" onclick="">냉/난방장비</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
            <li>
                <a id="category7" href="" onclick="">수납/운반용품</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
            <li>
                <a id="category8" href="" onclick="">기타장비</a>
                <ul class="left-category-sub">
                    <li><a href="" onclick="">ALL</a></li>
                    <li><a href="" onclick="">텐트</a></li>
                    <li><a href="" onclick="">쉘터/타프</a></li>
                    <li><a href="" onclick="">설치용부속품</a></li>
                    <li><a href="" onclick="">보조텐트류</a></li>
                    <li><a href="" onclick="">바닥보호시트</a></li>
                    <li><a href="" onclick="">기타용품</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="content">
        <!-- 오른쪽 상품 검색 결과 부분 -->
        <div class="right-contents">
            <!-- 필터 영역 -->
            <div class="filter-container">
                <div class="filter-content">
                    <!-- 전체/스토렌/렌탈 버튼 -->
                    <div class="filter-type-section">
                        <div class="btn-group">
                            <a href="?tab=all${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                               class="filter-btn ${param.tab == 'all' || empty param.tab ? 'active' : ''}"
                               style="text-decoration: none">전체</a>
                            <a href="?tab=storen${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                               class="filter-btn ${param.tab == 'storen' ? 'active' : ''}"
                               style="text-decoration: none">스토렌</a>
                            <a href="?tab=rental${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                               class="filter-btn ${param.tab == 'rental' ? 'active' : ''}"
                               style="text-decoration: none">렌탈</a>
                        </div>
                    </div>

                    <!-- 키워드 검색 영역 -->
                    <div class="keyword-section">
                        <form id="searchForm" action="rentalsearch-main.action" method="GET">
                            <!-- 현재 탭 유지를 위한 히든 필드 -->
                            <input type="hidden" name="tab" value="${param.tab}">
                            <div class="input-label">키워드</div>
                            <div class="search-container">
                                <label for="search-input" style="display:none">검색</label>
                                <input type="text" name="searchKeyword" value="${searchKeyword}" id="search-input"
                                       placeholder="키워드 검색(브랜드명, 장비명 등)">
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

            <!-- 상품 개수 및 정렬 -->
            <div class="count-sort">
                <p class="count">총 ${totalStorenCount}개</p>
                <div class="dropdown-sort">
                    <select>
                        <option>정렬</option>
                        <option>최신순</option>
                        <option>낮은가격순</option>
                        <option>높은가격순</option>
                    </select>
                </div>
            </div>


            <!-- 상품 리스트 -->
            <div class="product-container">
                <ul>
                    <c:forEach var="storen" items="${storenList}">
                        <li>
                            <a href="storenmatching-request.action?storenId=${storen.storen_id}">
                                <div class="product-card">
                                    <div class="product-image">
                                        <div class="product-placeholder"></div>
                                        <button class="like-button">
                                            <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                        </button>
                                    </div>
                                    <div class="product-info">
                                        <p class="product-title">${storen.storen_title}</p>
                                        <!-- 수정된 부분: equipmentDTO 접근 방식 변경 -->
                                        <p class="product-brand">${storen.equipmentDTO.brand}</p>
                                        <p class="product-category">${storen.equipmentDTO.majorCategory}</p>
                                        <p class="product-price">${storen.daily_rent_price}원/일</p>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 페이지네이션 -->
            <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
                <div class="d-flex gap-1">
                    <!-- 첫 페이지로 -->
                    <c:if test="${pagenation.pageNum > 1}">
                        <a href="rentalsearch-main.action?page=1&tab=${param.tab}${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                           class="btn btn-sm">
                            <i class="fa-solid fa-angles-left"></i>
                        </a>
                    </c:if>

                    <!-- 이전 블록으로 -->
                    <c:if test="${pagenation.startPage > pagenation.blockSize}">
                        <a href="rentalsearch-main.action?page=${pagenation.prevPage}&tab=${param.tab}${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                           class="btn btn-sm">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </c:if>

                    <!-- 페이지 번호 -->
                    <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                        <a href="rentalsearch-main.action?page=${i}&tab=${param.tab}${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                           class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                    </c:forEach>

                    <!-- 다음 블록으로 -->
                    <c:if test="${pagenation.endPage < pagenation.totalPage}">
                        <a href="rentalsearch-main.action?page=${pagenation.nextPage}&tab=${param.tab}${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                           class="btn btn-sm">
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </c:if>

                    <!-- 마지막 페이지로 -->
                    <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                        <a href="rentalsearch-main.action?page=${pagenation.totalPage}&tab=${param.tab}${searchKeyword != null ? '&searchKeyword='.concat(searchKeyword) : ''}"
                           class="btn btn-sm">
                            <i class="fa-solid fa-angles-right"></i>
                        </a>
                    </c:if>
                </div>
            </div>
        </div><!-- .right-contents-->
    </div><!-- .content -->
</div><!-- .main-container-->

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/view/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    $(document).ready(function () {
        // DateRangePicker 초기화
        if ($('#date-range').length && typeof $.fn.daterangepicker === 'function') {
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
                    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
                }
            });

            let picker = $('#date-range').data('daterangepicker');
            picker.setStartDate(moment());
            picker.setEndDate(moment().add(3, 'days'));

            $('#date-range').on('apply.daterangepicker', function (ev, picker) {
                var startDate = picker.startDate.format('YYYY/MM/DD');
                var endDate = picker.endDate.format('YYYY/MM/DD');
                $(this).val(startDate + ' - ' + endDate);
            });

            $('#date-range').val(
                moment().format('YYYY/MM/DD') + ' - ' + moment().add(3, 'days').format('YYYY/MM/DD')
            );
        }

        // 가격 슬라이더 초기화
        var priceSlider = document.getElementById('price-range');
        if (priceSlider && typeof noUiSlider !== 'undefined') {
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

            let minPrice = document.getElementById('min-price');
            let maxPrice = document.getElementById('max-price');
            priceSlider.noUiSlider.on('update', function (values, handle) {
                if (handle === 0 && minPrice) minPrice.textContent = values[0] + '원';
                if (handle === 1 && maxPrice) maxPrice.textContent = values[1] + '원';
            });
        }

        // 전체/스토렌/렌탈 버튼 클릭 시 active 클래스 토글
        $('.filter-btn').on('click', function () {
            $('.filter-btn').removeClass('active');
            $(this).addClass('active');
        });


        // 검색 버튼 클릭 이벤트 처리
        $('#search-btn').on('click', function (e) {
            // 폼이 있으므로 별도 처리 필요 없음, 자동으로 submit 됨
        });

        // 엔터 키 처리
        $('#search-input').on('keypress', function (e) {
            if (e.which === 13) { // 엔터 키 코드
                $('#searchForm').submit();
            }
        });


        window.applyFilter = function () {
            Swal.fire({
                icon: 'success',
                title: '필터 적용 완료!',
                text: '조건에 맞게 필터링 되었습니다.',
                confirmButtonColor: '#2C5F2D'
            });
        };


    });
</script>
</body>
</html>
