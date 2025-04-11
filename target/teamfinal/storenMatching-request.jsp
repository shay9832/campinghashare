<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    String matching_done = request.getParameter("matching_done");
    System.out.println(matching_done);

    // 렌탈 정보 저장할 변수
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우 피크(SNOW PEAK)"; // "기타"인 경우, 평균 미표시 및 권장 가격 문구 변경됨
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";             // 장비 사이즈
    String storagePeriod = "3 개월";         // 보관 개월 수
    String equipmentGrade = "C";            // 장비 등급
    int newPrice = 3050000;                 // 신품 가격(사용자 기존 입력)
    int avgNewPrice = 2500000;              // 평균 신품 가격
    int avgRentalPrice = 20000;             // 평균 렌탈 가격
    int dailyRentalPrice = 25000;           // 일일 렌탈 가격

    // 브랜드가 '기타'인지 확인하는 변수
    boolean isOtherBrand = "기타".equals(brand);

    // 신품 가격 대비 차이율 계산 (브랜드가 '기타'가 아닌 경우에만)
    int priceDiff = 0;
    String priceDiffSymbol = "-";                   // 변화 없음(중립)
    String priceDiffClass = "text-secondary";       // 중립

    // 브랜드가 '기타'가 아닌 경우
    if (!isOtherBrand) {
        priceDiff = (int)(((double)(newPrice - avgNewPrice) / avgNewPrice) * 100);
        priceDiffSymbol = priceDiff > 0 ? "▲" : "▼";
        if (priceDiff == 0) priceDiffSymbol = "-";

        // 차이에 따른 '평균가 비교 정보' 색상 결정 (신품 가격)
        if (priceDiff > 0) {
            priceDiffClass = "text-coral";
        } else if (priceDiff < 0) {
            priceDiffClass = "text-success";
        }

        // 절대값 연산
        priceDiff = Math.abs(priceDiff);
    }

    // 렌탈 가격 대비 차이율 계산
    int rentalPriceDiff = 0;
    String rentalPriceDiffSymbol = "-";  // 변화 없음(중립)
    String rentalPriceDiffClass = "text-secondary";  // 중립

    // 브랜드가 '기타'가 아닌 경우에만 계산
    if (!isOtherBrand) {
        rentalPriceDiff = (int)(((double)(dailyRentalPrice - avgRentalPrice) / avgRentalPrice) * 100);
        rentalPriceDiffSymbol = rentalPriceDiff > 0 ? "▲" : "▼";
        if (rentalPriceDiff == 0) rentalPriceDiffSymbol = "-";

        // 차이에 따른 색상 결정
        if (rentalPriceDiff > 0) {
            rentalPriceDiffClass = "text-coral";
        } else if (rentalPriceDiff < 0) {
            rentalPriceDiffClass = "text-success";
        }

        // 절대값 연산
        rentalPriceDiff = Math.abs(rentalPriceDiff);
    }

    // 천 단위 콤마 포맷팅
    NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
    String priceFormatted = nf.format(newPrice);
    String avgPriceFormatted = nf.format(avgNewPrice);
    String avgRentalPriceFormatted = nf.format(avgRentalPrice);
    String dailyRentalPriceFormatted = nf.format(dailyRentalPrice);
%>
<html>
<head>
    <title>storenMatching-request.jsp</title>

    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/matching.css">

</head>

<body>
<header>
    <jsp:include page="WEB-INF/view/header.jsp"/>
</header>

<!-- 매칭 신청 확인 모달 -->
<div id="matching-confirm-modal" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청하시겠습니까?</p>
        <div class="modal-buttons">
            <button id="confirm" class="confirm-btn">확인</button>
            <button id="cancel" class="cancel-btn">취소</button>
        </div>
    </div>
</div>

<div id="matching-confirm-modal2" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청되었습니다.</p>
        <div class="modal-buttons single-button">
            <button id="confirm2" class="confirm-btn">확인</button>
        </div>
    </div>
</div>

<!-- 메인 컨테이너 -->
<div class="main-container">
    <div class="top-section">
        <div class="top-content">
            <!-- 왼쪽 컬럼: 이미지 및 작성자 정보 -->
            <div class="left-column card">
                <!-- 이미지 영역 -->
                <div class="main-image-container">
                    <div class="main-image">
                        <button class="image-nav-btn prev-btn">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <span class="image-counter">1/5</span>
                        <button class="image-nav-btn next-btn">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>

                <!-- 썸네일 영역 -->
                <div class="thumbnail-container d-flex">
                    <div class="thumbnail active"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                </div>

                <!-- 작성자 정보 -->
                <div class="user-info d-flex align-items-center mb-2">
                    <span class="font-medium">가나초콜릿</span>
                    <img src="/resources/images/rank-icon5.png" class="rank-icon ml-2">
                    <span class="text-secondary text-xs">(신뢰도 00% / 신고 0회 접수)</span>
                    <button class="report-btn btn-sm btn-text ml-auto">신고</button>
                </div>
                <div class="text-tertiary text-xs">2025.06.01 등록</div>
            </div>

            <!-- 오른쪽 컬럼: 장비 정보 및 렌탈 신청 -->
            <div class="right-column card">
                <!-- 장비 정보 테이블 -->
                <table class="info-table w-100">
                    <tr>
                        <th class="text-secondary">장비명</th>
                        <td><%= equipmentName %></td>
                    </tr>
                    <tr>
                        <th class="text-secondary">카테고리</th>
                        <td><%= equipmentCategory %></td>
                    </tr>
                    <tr>
                        <th class="text-secondary">브랜드</th>
                        <td><%= brand %></td>
                    </tr>
                    <tr>
                        <th class="text-secondary">신품 가격</th>
                        <td>
                            <span class="price font-bold text-lg"><%= priceFormatted %>원</span>
                            <% if (!isOtherBrand) { %>
                            <span class="<%= priceDiffClass %> ml-2">(평균 대비 <%= priceDiff %>%<%= priceDiffSymbol %>)</span>
                            <span class="avg-price">
                                평균 신품 가격
                                <span class="avg-price-value"><%= avgPriceFormatted %></span>
                                <span class="tooltip-trigger" style="margin-left: 4px;">
                                    <i class="fa-solid fa-circle-question"></i>
                                    <span class="tooltip-content">
                                        유저들이 직접 입력한 해당 장비 '신품 가격'의 평균입니다.<br>
                                        (보통 공식 홈페이지, 쇼핑몰 가격 기준으로 입력)
                                    </span>
                                </span>
                            </span>
                            <% } %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-secondary">장비 등급</th>
                        <td>
                            <span class="grade-badge grade-<%= equipmentGrade %>"><%= equipmentGrade %></span>
                            <span class="grade-link text-maple">(상세 내용 보기)</span>
                        </td>
                    </tr>
                </table>

                <hr>

                <!-- 렌탈 신청 폼 -->
                <table class="info-table w-100">
                    <tr>
                        <th class="text-secondary">렌탈 가능 기간</th>
                        <td>2025.06.01 - 2025.09.30</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">렌탈 가격</th>
                        <td>
                            <span class="price rental-price-value font-bold"><%= dailyRentalPriceFormatted %>원/일</span>
                            <% if (!isOtherBrand) { %>
                            <span id="priceCompare" class="<%= rentalPriceDiffClass %> ml-3">(평균 대비 <%= rentalPriceDiff %>%<%= rentalPriceDiffSymbol %>)</span>
                            <span class="avg-price">
                                평균 렌탈 가격
                                <span class="avg-price-value"><%= avgRentalPriceFormatted %>원/일</span>
                                <span class="tooltip-trigger" style="margin-left: 4px;">
                                    <i class="fa-solid fa-circle-question"></i>
                                    <span class="tooltip-content">
                                        유저들이 직접 입력한 해당 장비 '렌탈 가격'의 평균입니다.
                                    </span>
                                </span>
                            </span>
                            <% } %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-secondary">렌탈 기간</th>
                        <td>
                            <div class="date-container">
                                <div class="date-range-container">
                                    <input type="text" id="date-range" placeholder="날짜 선택" readonly>
                                    <span class="date-range-icon">
                                    <i class="fa-regular fa-calendar"></i>
                                </span>
                                </div>
                            </div>
                            <div id="rental-days" class="font-bold">(0일)</div>
                        </td>
                    </tr>
                </table>

                <!-- 총 렌탈 금액 -->
                <div class="total-price">
                    <span class="font-medium">총 렌탈 금액</span>
                    <span id="total-price-value" class="font-bold">0원</span>
                </div>

                <!-- 매칭 신청 버튼 -->
                <%
                    if ("true".equals(matching_done)) {
                %>
                <button class="match-btn disabled" disabled="disabled">매칭 중</button>
                <%
                } else {
                %>
                <button class="match-btn btn-primary btn-block">매칭 신청</button>
                <%
                    }
                %>
            </div>
        </div>

        <!-- 장비 내용 -->
        <div class="card content-section">
            <h3 class="font-bold">장비 관련 내용</h3>
            <p>
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>

        <!-- 거래 주의사항 -->
        <div class="card content-section">
            <h3 class="font-bold">거래 시 주의사항</h3>
            <p>
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/view/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 페이지 로드 시 JavaScript 전역 변수 설정 -->
<script type="text/javascript">
    // JSP 변수 JavaScript 변수로 설정 - 이렇게 하면 나중에 타입 변환 문제 없음
    var dailyRentalPrice = <%= dailyRentalPrice %>;
</script>

<script type="text/javascript">
    // 총 렌탈 금액 계산 및 표시 함수
    function calculateTotalPrice(days) {
        if (typeof days !== 'number' || days <= 0) {
            $('#rental-days').text(`(0일)`);
            $('#total-price-value').text(`0원`);
            return;
        }

        const totalPrice = dailyRentalPrice * days;
        const formattedPrice = totalPrice.toLocaleString('ko-KR');

        $('#rental-days').text(`(${days}일)`);
        $('#total-price-value').text(`${formattedPrice}원`);

        console.log(`계산 완료: ${days}일 x ${dailyRentalPrice}원 = ${totalPrice}원`);
    }

    // 모달 관련 함수 초기화
    function initializeModals() {
        console.log('모달 초기화 중...');

        $(".match-btn:not(.disabled)").on('click', function () {
            if ($('#date-range').val() === '') {
                alert('렌탈 기간을 선택해주세요.');
                return;
            }
            $("#matching.css-confirm-modal").show().css("display", "flex");
            $("body").css("overflow", "hidden");
        });

        $("#cancel").on("click", function() {
            $("#matching.css-confirm-modal").hide();
            $("body").css("overflow", "auto");
        });

        $("#confirm").on('click', function () {
            $("#matching.css-confirm-modal").hide();
            $("#matching.css-confirm-modal2").show().css("display", "flex");
            $("body").css("overflow", "hidden");
        });

        $("#confirm2").on("click", function() {
            $(location).attr("href", "storenMatching-request.jsp?matching_done=true");
        });

        console.log('모달 초기화 완료');
    }

    // DateRangePicker 초기화 함수
    function initializeDateRangePicker() {
        console.log('DateRangePicker 초기화 중...');

        try {
            const minDate = moment('2025-06-01');
            const maxDate = moment('2025-09-30');
            console.log('일일 렌탈 가격:', dailyRentalPrice);

            function calculateDays(startDate, endDate) {
                return moment(endDate).diff(moment(startDate), 'days') + 1;
            }

            const initialStartDate = minDate.clone();
            const initialEndDate = minDate.clone().add(2, 'days');

            $('#date-range').val(
                initialStartDate.format('YYYY.MM.DD') + ' - ' + initialEndDate.format('YYYY.MM.DD')
            );

            const initialDays = calculateDays(initialStartDate, initialEndDate);
            calculateTotalPrice(initialDays);

            $('#date-range').daterangepicker({
                opens: 'right',
                autoApply: true,
                minDate: minDate,
                maxDate: maxDate,
                startDate: initialStartDate,
                endDate: initialEndDate,
                locale: {
                    format: 'YYYY.MM.DD',
                    separator: ' - ',
                    applyLabel: '적용',
                    cancelLabel: '취소',
                    fromLabel: '시작일',
                    toLabel: '종료일',
                    daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                    firstDay: 0
                }
            }, function(start, end, label) {
                console.log('날짜 선택됨:', start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
                const days = calculateDays(start, end);
                calculateTotalPrice(days);
            });

            console.log('DateRangePicker 초기화 완료');
        } catch (error) {
            console.error('DateRangePicker 초기화 중 오류 발생:', error);
            forceInitialize();
        }
    }

    // 이미지 내비게이션 초기화 함수
    function initializeImageNavigation() {
        console.log('이미지 내비게이션 초기화 중...');
        let currentImageIndex = 0;
        const totalImages = 5;

        function updateImageCounter() {
            document.querySelector('.image-counter').textContent = `${currentImageIndex + 1}/${totalImages}`;
        }

        function updateThumbnailActive() {
            document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
                thumb.classList.toggle('active', index === currentImageIndex);
            });
        }

        document.querySelector('.prev-btn').addEventListener('click', function() {
            currentImageIndex = (currentImageIndex - 1 + totalImages) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        document.querySelector('.next-btn').addEventListener('click', function() {
            currentImageIndex = (currentImageIndex + 1) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
            thumb.addEventListener('click', function() {
                currentImageIndex = index;
                updateImageCounter();
                updateThumbnailActive();
            });
        });

        document.querySelector('.grade-link').addEventListener('click', function() {
            alert('장비 등급 상세내용이 표시됩니다');
        });

        console.log('이미지 내비게이션 초기화 완료');
    }

    // 툴팁 초기화 함수
    function initializeTooltips() {
        console.log('툴팁 초기화 중...');
        document.querySelectorAll('.tooltip-trigger').forEach(function(trigger) {
            trigger.addEventListener('mouseenter', function() {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) tooltip.style.display = 'block';
            });
            trigger.addEventListener('mouseleave', function() {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) tooltip.style.display = 'none';
            });
        });
        console.log('툴팁 초기화 완료');
    }

    // 강제 초기화 함수
    function forceInitialize() {
        console.log('강제 초기화 실행...');

        if ($('#total-price-value').text() !== '0원') {
            console.log('이미 초기화가 완료되어 있습니다.');
            return;
        }

        const days = 3;
        calculateTotalPrice(days);

        if ($('#date-range').val() === '') {
            $('#date-range').val('2025.06.01 - 2025.06.03');
        }

        console.log(`강제 초기화 완료: ${days}일`);
    }

    // 문서 로드 시 실행
    $(document).ready(function() {
        console.log("문서 준비됨. jQuery 작동 확인");

        initializeModals();
        initializeDateRangePicker();
        initializeImageNavigation();
        initializeTooltips();

        setTimeout(forceInitialize, 500);
    });
</script>



</body>
</html>