<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 검색결과</title>
    <link rel="stylesheet" type="text/css" href="css/search_equip_css.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- noUiSlider 추가 (가격 범위 슬라이더) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
    <!-- 데이트픽커 추가 - daterangepicker 사용 -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // 왼쪽 카테고리 대분류에 마우스 올렸을 때/뗐을 때 오른쪽으로 중분류 나오게 처리
            $(".left-category > ul > li").hover(
                function () {
                    // 마우스를 올렸을 때
                    $(this).children(".left-category-sub").stop(true, true).fadeIn(50);
                },
                function() {
                    // 마우스를 뗐을 때
                    $(this).children(".left-category-sub").stop(true, true).fadeOut(50);
                });

            // 좋아요 버튼 토글
            $(".fa-solid").click(function () {
                var currentColor = $(this).css('color');
                if (currentColor === 'rgb(242, 232, 207)') {
                    $(this).css('color', '#e9745e');
                } else {
                    $(this).css('color', '#f2e8cf');
                }
            });

            // 가격 범위 슬라이더 초기화
            var priceSlider = document.getElementById('price-range');
            if(priceSlider) {
                noUiSlider.create(priceSlider, {
                    start: [0, 100000],
                    connect: true,
                    range: {
                        'min': 0,
                        'max': 100000
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

                // 값 업데이트
                var minPrice = document.getElementById('min-price');
                var maxPrice = document.getElementById('max-price');

                priceSlider.noUiSlider.on('update', function (values, handle) {
                    if (handle === 0) {
                        minPrice.textContent = values[0] + '원';
                    } else {
                        maxPrice.textContent = values[1] + '원';
                    }
                });
            }

            // 날짜 범위 피커 초기화 - 한글 설정
            $('#date-range').daterangepicker({
                locale: {
                    format: 'YYYY-MM-DD',
                    separator: ' ~ ',
                    applyLabel: '적용',
                    cancelLabel: '취소',
                    fromLabel: '시작일',
                    toLabel: '종료일',
                    customRangeLabel: '사용자 지정',
                    weekLabel: '주',
                    daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    firstDay: 0
                },
                opens: 'right',
                autoApply: false,
                startDate: moment().startOf('day'),
                endDate: moment().add(3, 'days').startOf('day'),
                autoUpdateInput: true,
                drops: 'down',
                showCustomRangeLabel: false
            });
        });
    </script>

    <style>
        /* 전체 레이아웃 */
        body {
            background-color: #f9f9f7;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .main-container {
            margin: 0 auto;
            padding: 20px;
            display: flex;
            flex-direction: row; /* 가로 방향 배치 확실히 */
            align-items: flex-start; /* 상단 정렬 */
        }

        .content {
            flex: 1; /* 남은 공간 모두 차지 */
            display: flex;
            gap: 20px;
            min-width: 0; /* 내용 넘침 방지 */
        }

        .left-category {
            width: 180px;
            flex-shrink: 0;
            background-color: white;
            border-radius: 4px;
            position: sticky;
            top: 20px;
        }

        .left-category ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .left-category > ul > li {
            border-bottom: 1px solid #f0f0f0;
        }

        .left-category > ul > li:last-child {
            border-bottom: none;
        }

        .left-category li a {
            display: block;
            padding: 12px 15px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.25s ease;
        }

        .left-category li a:hover {
            background-color: #F2E8CF;
            color: #2C5F2D;
        }

        .left-category li a.on {
            background-color: #E8E3D0;
            color: #2C5F2D;
            font-weight: bold;
        }

        .left-category-sub {
            position: absolute;
            top: 0;
            left: 100%;
            width: 150px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 0 4px 4px 0;
            display: none;
            z-index: 100;
        }

        /* 오른쪽 콘텐츠 영역 */
        .right-contents {
            flex: 1;
            min-width: 0; /* 내용이 넘치는 것 방지 */
        }

        /* 필터 컨테이너 */
        .filter-container {
            background-color: white;
            border-radius: 8px;
            padding: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        /* 필터 인풋 영역 */
        .search-inputs {
            gap: 5px;
        }

        .input-group {
            padding: 5px 5px;
        }

        .input-group.keyword-group {
            flex: 2; /* 키워드 입력란 더 넓게 */
        }

        .input-label {
            font-weight: bold;
            color: #2C5F2D;
            font-size: 14px;
        }

        .input-value {
            width: 100%;
        }

        /* 키워드 검색 */
        .search-container {
            position: relative;
            width: 100%;
        }

        .search-container label {
            display: none;
        }

        #search-input {
            width: 100%;
            padding: 10px 40px 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        #search-input::placeholder {
            color: #aaa;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #search-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
        }

        .noUi-connect {
            background: #2C5F2D;
        }

        .noUi-handle {
            border: 1px solid #2C5F2D;
            background: white;
            border-radius: 50%;
            width: 18px !important;
            height: 18px !important;
            top: -7px !important;
            right: -9px !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }

        .noUi-handle:before,
        .noUi-handle:after {
            display: none;
        }

        .price-range-values {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #666;
        }

        /* 날짜 필터 */
        .date-range-container {
            position: relative;
        }

        #date-range {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background-color: white;
            cursor: pointer;
            box-sizing: border-box;
        }

        .date-range-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }

        /* 필터 적용 버튼 영역 */
        .search-button-container {
            display: flex;
            align-items: flex-end;
            padding: 5px 5px;
            background-color: #f8f8f8;
            border-radius: 6px;
        }

        .filter-button {
            background-color: var(--color-maple-light);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            width: 100%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .filter-button:hover {
            background-color: var(--color-maple);
            transform: translateY(-2px);
        }

        .filter-button:active {
            transform: translateY(1px);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        /* 나머지 스타일은 이전과 동일 */
        /* ... (이전 코드의 나머지 부분) */
    </style>
</head>
<body>

<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>

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
                <a id="category2" href="" onclick="">취침용품</a>
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
                <a id="category3" href="" onclick="">캠핑가구</a>
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
            <!-- 필터 영역 - 3열 구조로 변경 -->
            <div class="filter-container">
                <div class="search-inputs">
                    <div class="input-group keyword-group">
                        <div class="input-label">키워드</div>
                        <div class="input-value">
                            <div class="search-container">
                                <form>
                                    <label for="search-input">검색</label>
                                    <input type="text" id="search-input" placeholder="키워드 검색(상품명 일부 키워드 / 브랜드명 등을 입력)">
                                    <button type="submit" id="search-btn" class="search-icon-button">
                                        <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="input-group">
                        <div class="input-label">일일 렌탈가격</div>
                        <div class="input-value">
                            <div class="price-range-container">
                                <div id="price-range" class="price-range-slider"></div>
                                <div class="price-range-values">
                                    <span id="min-price">0</span>
                                    <span id="max-price">100,000</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="input-group">
                        <div class="input-label">대여 일자</div>
                        <div class="input-value">
                            <div class="date-range-container">
                                <input type="text" id="date-range" value="2025-04-05 ~ 2025-04-26" readonly>
                                <span class="date-range-icon">
                                    <i class="fa-regular fa-calendar"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- 필터 적용 버튼 -->
                    <div>
                        <button class="filter-button">필터 적용</button>
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

            <!-- 상품 리스트 - 제품 카드 높이 고정 -->
            <div class="product-container">
                <ul>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="storen_matching_request.jsp"></a>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-placeholder"></div>
                                <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                            </div>
                            <div class="product-info">
                                <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                                <p class="product-brand">코베아몰</p>
                                <p class="product-category">텐트/쉘터</p>
                                <p class="product-price">10,000원/일</p>
                            </div>
                        </div>
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

<!-- footer 외부 jsp 참조-->
<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>