<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    // 임시 변수 설정
    String matching_done = request.getParameter("matching_done");
    String selectedDateRange = request.getParameter("dateRange");
    String selectedDays = request.getParameter("days");
    String selectedPrice = request.getParameter("price");

    // 장비 관련 임시 데이터
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우 피크(SNOW PEAK)";
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";
    String storagePeriod = "3 개월";
    String equipmentGrade = "C";
    int newPrice = 3050000;
    int avgNewPrice = 2500000;
    int avgRentalPrice = 20000;
    int dailyRentalPrice = 25000;

    // 기타 브랜드 여부 확인
    boolean isOtherBrand = "기타".equals(brand);

    // 신품 가격 비교
    int priceDiff = 0;
    String priceDiffSymbol = "-";
    String priceDiffClass = "text-secondary";

    if (!isOtherBrand) {
        priceDiff = (int)(((double)(newPrice - avgNewPrice) / avgNewPrice) * 100);
        priceDiffSymbol = priceDiff > 0 ? "▲" : priceDiff < 0 ? "▼" : "-";
        priceDiffClass = priceDiff > 0 ? "text-coral" : priceDiff < 0 ? "text-success" : "text-secondary";
        priceDiff = Math.abs(priceDiff);
    }

    // 평균 렌탈 가격 비교
    int rentalPriceDiff = 0;
    String rentalPriceDiffSymbol = "-";
    String rentalPriceDiffClass = "text-secondary";

    if (!isOtherBrand) {
        rentalPriceDiff = (int)(((double)(dailyRentalPrice - avgRentalPrice) / avgRentalPrice) * 100);
        rentalPriceDiffSymbol = rentalPriceDiff > 0 ? "▲" : rentalPriceDiff < 0 ? "▼" : "-";
        rentalPriceDiffClass = rentalPriceDiff > 0 ? "text-coral" : rentalPriceDiff < 0 ? "text-success" : "text-secondary";
        rentalPriceDiff = Math.abs(rentalPriceDiff);
    }

    // 숫자 포맷
    NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
    String priceFormatted = nf.format(newPrice);
    String avgPriceFormatted = nf.format(avgNewPrice);
    String avgRentalPriceFormatted = nf.format(avgRentalPrice);
    String dailyRentalPriceFormatted = nf.format(dailyRentalPrice);
%>

<html>
<head>
    <title>storenMatching-request.jsp</title>

    <!-- 외부 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- 내부 리소스 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/matching.css">

    <!-- favicon 추가 - 404 오류 방지 -->
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>

<body>
<header>
    <jsp:include page="WEB-INF/view/header.jsp"/>
</header>

<!-- [A] 매칭 신청 확인 모달 1 - 매칭 신청 여부 확인 -->
<div id="matching-confirm-modal" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청하시겠습니까?</p>
        <div class="modal-buttons">
            <button id="confirm" class="confirm-btn">확인</button>
            <button id="cancel" class="cancel-btn">취소</button>
        </div>
    </div>
</div>

<!-- [B] 매칭 신청 확인 모달 2 - 매칭 신청 완료 안내 -->
<div id="matching-confirm-modal2" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청되었습니다.</p>
        <div class="modal-buttons single-button">
            <button id="confirm2" class="confirm-btn">확인</button>
        </div>
    </div>
</div>

<!-- [C] 메인 컨테이너 -->
<div class="main-container">
    <div class="top-section">
        <div class="top-content">
            <!-- 왼쪽: 이미지 카드 영역 -->
            <div class="left-column card">
                <div class="main-image-container">
                    <div class="main-image">
                        <button class="image-nav-btn prev-btn"><i class="fas fa-chevron-left"></i></button>
                        <span class="image-counter">1/5</span>
                        <button class="image-nav-btn next-btn"><i class="fas fa-chevron-right"></i></button>
                    </div>
                </div>
                <div class="thumbnail-container d-flex">
                    <div class="thumbnail active"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                </div>
                <div class="user-info d-flex align-items-center mb-2">
                    <span class="font-medium">가나초콜릿</span>
                    <img src="/resources/images/rank-icon5.png" class="rank-icon ml-2">
                    <span class="text-secondary text-xs">(신뢰도 00% / 신고 0회 접수)</span>
                    <button class="report-btn btn-sm btn-text ml-auto">신고</button>
                </div>
                <div class="text-tertiary text-xs">2025.06.01 등록</div>
            </div>

            <!-- 오른쪽: 장비 정보 & 렌탈 신청 -->
            <div class="right-column card">
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
                            <span class="grade-link text-maple" onclick="location.href=''">(상세 내용 보기)</span>
                        </td>
                    </tr>
                </table>
                <hr>

                <!-- [D] 렌탈 신청 폼 -->
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
                                    <input type="text" id="date-range" placeholder="날짜 선택" readonly
                                           value="<%= selectedDateRange != null ? selectedDateRange : "" %>">
                                    <span class="date-range-icon">
                                        <i class="fa-regular fa-calendar"></i>
                                    </span>
                                </div>
                            </div>
                            <!-- 렌탈 일수 표시 -->
                            <div id="rental-days"><%= selectedDays != null ? "(" + selectedDays + "일)" : "(0일)" %></div>
                        </td>
                    </tr>
                </table>

                <div class="total-price">
                    <span class="font-medium">총 렌탈 금액</span>
                    <!-- 총 렌탈 금액 표시 -->
                    <div id="total-price-value"><%= selectedPrice != null ? selectedPrice : "0원" %></div>
                </div>

                <%
                    // [E] 매칭 중이면 버튼 disabled 처리
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

        <div class="card content-section">
            <h3 class="font-bold">장비 관련 내용</h3>
            <p>
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>
        <div class="card content-section">
            <h3 class="font-bold">거래 시 주의사항</h3>
            <p>
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/view/footer.jsp"/>

<!-- [G] 스크립트 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
    // [H] JSP 값 가져오기 - 렌탈 가격 정보
    var dailyRentalPrice = <%= dailyRentalPrice %>;
    var selectedDateRange = "<%= selectedDateRange != null ? selectedDateRange : "" %>";
    var selectedDays = "<%= selectedDays != null ? selectedDays : "0" %>";
    var selectedPrice = "<%= selectedPrice != null ? selectedPrice : "0원" %>";
    let lastValidDays = selectedDays !== "0" ? parseInt(selectedDays) : 0;
    let lastValidPrice = selectedPrice !== "0원" ? selectedPrice : "0원";
</script>

<script type="text/javascript">
    $(document).ready(function () {
        initializeModals();       // 모달 초기화
        initializeDateRangePicker(); // 날짜 선택기 초기화
        initializeImageNavigation(); // 이미지 내비게이션 초기화
        initializeTooltips();     // 툴팁 초기화
    });

    // [1] 모달 관련 초기화 함수
    function initializeModals() {
        // 매칭 신청 버튼 클릭 이벤트 - 날짜 선택 확인 후 모달 표시
        $(".match-btn:not(.disabled)").on('click', function () {
            if ($('#date-range').val() === '') {
                alert('렌탈 기간을 선택해주세요.');
                return;
            }
            $("#matching-confirm-modal").css("display", "flex");
            $("body").css("overflow", "hidden");
        });

        // 취소 버튼 클릭 이벤트 - 모달 닫기
        $("#cancel").on("click", function () {
            $("#matching-confirm-modal").hide();
            $("body").css("overflow", "auto");
        });

        // 첫 번째 모달의 확인 버튼 클릭 이벤트 - 두 번째 모달 표시
        $("#confirm").on("click", function () {
            $("#matching-confirm-modal").hide();
            $("#matching-confirm-modal2").css("display", "flex");
        });

        // 두 번째 모달의 확인 버튼 클릭 이벤트 - 매칭 완료 처리
        $("#confirm2").on("click", function () {
            // 수정: 선택된 날짜 범위와 일수 파라미터도 함께 전달
            const dateRange = $('#date-range').val();
            const days = lastValidDays;
            const price = lastValidPrice;

            // 매칭 완료 후에도 기존에 선택한 정보를 유지하기 위해 파라미터로 전달
            location.href = "storenMatching-request.jsp?matching_done=true&dateRange=" +
                encodeURIComponent(dateRange) + "&days=" + days + "&price=" +
                encodeURIComponent(price);
        });
    }

    // [2] 날짜 선택기 초기화 함수
    function initializeDateRangePicker() {
        // 날짜 범위 설정 - 렌탈 가능 기간 기준
        const minDate = moment('2025-06-01');   // 렌탈 시작 가능일
        const maxDate = moment('2025-09-30');   // 렌탈 종료 가능일

        // 이미 선택된 날짜 범위가 있으면 파싱
        let initialStartDate = minDate;
        let initialEndDate = minDate;

        // 선택된 날짜 범위가 있으면 해당 값을 초기 날짜로 설정
        if (selectedDateRange && selectedDateRange !== "") {
            const dateRangeParts = selectedDateRange.split(' - ');
            if (dateRangeParts.length === 2) {
                initialStartDate = moment(dateRangeParts[0], 'YYYY.MM.DD');
                initialEndDate = moment(dateRangeParts[1], 'YYYY.MM.DD');
            }
        }

        // DateRangePicker 초기화 - 날짜 선택 UI 생성
        $('#date-range').daterangepicker({
            autoApply: true,         // 자동 적용 (선택 즉시 값 적용)
            opens: 'right',          // 오른쪽에 달력 표시
            minDate: minDate,        // 최소 날짜 설정
            maxDate: maxDate,        // 최대 날짜 설정
            startDate: initialStartDate,  // 초기 시작 날짜
            endDate: initialEndDate,      // 초기 종료 날짜
            locale: {
                format: 'YYYY.MM.DD',  // 날짜 형식
                separator: ' - ',      // 구분자
                applyLabel: '적용',
                cancelLabel: '취소',
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] // 월 이름
            }
        });

        // 이미 선택된 날짜 범위가 없으면 날짜 필드 비우기
        if (!selectedDateRange || selectedDateRange === "") {
            $('#date-range').val('');
        }

        // 날짜 선택 이벤트 등록 - 날짜 선택 시 렌탈 일수 및 금액 계산
        $('#date-range').on('apply.daterangepicker', function(ev, picker) {
            // 선택된 날짜 범위 표시 (YYYY.MM.DD - YYYY.MM.DD 형식)
            $(this).val(picker.startDate.format('YYYY.MM.DD') + ' - ' + picker.endDate.format('YYYY.MM.DD'));

            // 날짜 차이 계산 (종료일 - 시작일 + 1일) - 대여 일수
            const days = picker.endDate.diff(picker.startDate, 'days') + 1;

            // 일수 표시 업데이트 (템플릿 리터럴 사용 X - JSP 내 안정성 문제 때문에 변경함)
            const daysText = '(' + days + '일)';
            document.getElementById('rental-days').textContent = daysText;

            // 총 금액 계산 및 업데이트 (일별 가격 * 일수)
            const totalPrice = dailyRentalPrice * days;
            const formattedPrice = totalPrice.toLocaleString('ko-KR') + '원';
            document.getElementById('total-price-value').textContent = formattedPrice;

            // 유효한 값 저장 (이후 참조용)
            lastValidDays = days;
            lastValidPrice = formattedPrice;
        });
    }

    // [3] 이미지 내비게이션 초기화 함수
    function initializeImageNavigation() {
        let currentImageIndex = 0;
        const totalImages = 5;

        // 이미지 카운터 업데이트 함수
        function updateImageCounter() {
            document.querySelector('.image-counter').textContent = `${currentImageIndex + 1}/${totalImages}`;
        }

        // 썸네일 활성화 상태 업데이트 함수
        function updateThumbnailActive() {
            document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
                thumb.classList.toggle('active', index === currentImageIndex);
            });
        }

        // 이전 버튼 클릭 이벤트
        document.querySelector('.prev-btn')?.addEventListener('click', () => {
            currentImageIndex = (currentImageIndex - 1 + totalImages) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        // 다음 버튼 클릭 이벤트
        document.querySelector('.next-btn')?.addEventListener('click', () => {
            currentImageIndex = (currentImageIndex + 1) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        // 썸네일 클릭 이벤트
        document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
            thumb.addEventListener('click', () => {
                currentImageIndex = index;
                updateImageCounter();
                updateThumbnailActive();
            });
        });
    }

    // [4] 툴팁 초기화 함수
    function initializeTooltips() {
        // 모든 툴팁 트리거에 마우스 진입/이탈 이벤트 등록
        document.querySelectorAll('.tooltip-trigger').forEach((trigger) => {
            // 마우스 진입 시 툴팁 표시
            trigger.addEventListener('mouseenter', function () {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) {
                    tooltip.style.display = 'block';
                }
            });

            // 마우스 이탈 시 툴팁 숨김
            trigger.addEventListener('mouseleave', function () {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) {
                    tooltip.style.display = 'none';
                }
            });
        });
    }
</script>

</body>
</html>