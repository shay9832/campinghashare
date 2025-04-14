<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                            <button type="button" class="filter-btn active">전체</button><button type="button" class="filter-btn">스토렌</button><button type="button" class="filter-btn">렌탈</button>
                        </div>
                    </div>

                    <!-- 키워드 검색 영역 -->
                    <div class="keyword-section">
                        <div class="input-label">키워드</div>
                        <div class="search-container">
                            <label for="search-input" style="display:none">검색</label>
                            <input type="text" id="search-input" placeholder="키워드 검색(브랜드명, 장비명 등)">
                            <button type="submit" id="search-btn" class="search-icon-button">
                                <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                            </button>
                        </div>
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
                <p class="count">총 100개</p>
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
                    <li>
                        <a href="storen_matching_request.jsp">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-placeholder"></div>
                                    <button class="like-button">
                                        <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                    </button>
                                </div>
                                <div class="product-info">
                                    <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                    <p class="product-brand">코베아몰</p>
                                    <p class="product-category">텐트/쉘터</p>
                                    <p class="product-price">10,000원/일</p>
                                </div>
                            </div>
                        </a>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-placeholder"></div>
                                    <button class="like-button">
                                        <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                    </button>
                                </div>
                                <div class="product-info">
                                    <p class="product-title">빅애그론 대형 프리미엄 텐트 6-8인용</p>
                                    <p class="product-brand">캠핑몰</p>
                                    <p class="product-category">텐트/쉘터</p>
                                    <p class="product-price">15,000원/일</p>
                                </div>
                            </div>
                        </a>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-placeholder"></div>
                                    <button class="like-button">
                                        <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                    </button>
                                </div>
                                <div class="product-info">
                                    <p class="product-title">Coleman 리빙 쉘터 타프</p>
                                    <p class="product-brand">컬럼버스</p>
                                    <p class="product-category">쉘터/타프</p>
                                    <p class="product-price">8,000원/일</p>
                                </div>
                            </div>
                        </a>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-placeholder"></div>
                                    <button class="like-button">
                                        <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                    </button>
                                </div>
                                <div class="product-info">
                                    <p class="product-title">Swiss 리빙 쉘 핀란드 돔텐트</p>
                                    <p class="product-brand">아웃도어</p>
                                    <p class="product-category">텐트/쉘터</p>
                                    <p class="product-price">12,000원/일</p>
                                </div>
                            </div>
                        </a>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-placeholder"></div>
                                    <button class="like-button">
                                        <i class="fa-solid fa-heart" style="color: #f2e8cf;"></i>
                                    </button>
                                </div>
                                <div class="product-info">
                                    <p class="product-title">노스페이스 캠핑 쉘터 대형</p>
                                    <p class="product-brand">노스페이스</p>
                                    <p class="product-category">쉘터/타프</p>
                                    <p class="product-price">9,500원/일</p>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <button>◀</button>
                <button class="active">1</button>
                <button>2</button>
                <button>3</button>
                <button>4</button>
                <button>5</button>
                <button>6</button>
                <button>7</button>
                <button>8</button>
                <button>9</button>
                <button>10</button>
                <button>▶</button>
                <button>≫</button>
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
