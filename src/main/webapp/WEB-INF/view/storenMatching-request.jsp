<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.team.mvc.DTO.StorenDTO" %>
<%
    // 임시 변수 설정
    String selectedDateRange = "";
    String selectedDays = "0";
    String selectedPrice = "0원";
    String matching_done = "false";

    StorenDTO storen = (StorenDTO)request.getAttribute("storen");

    // JSP 파일 상단에 추가
    if (storen != null && selectedDateRange == null) {
        // DB에서 가져온 날짜를 초기 값으로 설정
        selectedDateRange = storen.getRental_start_date() + " ~ " + storen.getRental_end_date();
        // 날짜 차이 계산 로직 (moment.js와 같은 라이브러리로 일수 계산)
    }

    // 장비 관련 임시 데이터
    String equipmentGrade = "C";
    int avgNewPrice = 2500000;
    int avgRentalPrice = 20000;

    // 이미지 관련 임시 데이터
    int totalImages = 5;

    // 기타 브랜드 여부 확인
    boolean isOtherBrand = "기타".equals(storen.getEquipmentDTO().getBrand());

    // 신품 가격 비교
    int priceDiff = 0;
    String priceDiffSymbol = "-";
    String priceDiffClass = "text-secondary";

    if (!isOtherBrand) {
        priceDiff = (int)(((double)(storen.getEquipmentDTO().getOriginal_price() - avgNewPrice) / avgNewPrice) * 100);
        priceDiffSymbol = priceDiff > 0 ? "▲" : priceDiff < 0 ? "▼" : "-";
        priceDiffClass = priceDiff > 0 ? "text-coral" : priceDiff < 0 ? "text-success" : "text-secondary";
        priceDiff = Math.abs(priceDiff);
    }

    // 평균 렌탈 가격 비교
    int rentalPriceDiff = 0;
    String rentalPriceDiffSymbol = "-";
    String rentalPriceDiffClass = "text-secondary";

    if (!isOtherBrand) {
        rentalPriceDiff = (int)(((double)(storen.getDaily_rent_price() - avgRentalPrice) / avgRentalPrice) * 100);
        rentalPriceDiffSymbol = rentalPriceDiff > 0 ? "▲" : rentalPriceDiff < 0 ? "▼" : "-";
        rentalPriceDiffClass = rentalPriceDiff > 0 ? "text-coral" : rentalPriceDiff < 0 ? "text-success" : "text-secondary";
        rentalPriceDiff = Math.abs(rentalPriceDiff);
    }

    // 숫자 포맷
    NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
    String priceFormatted = nf.format(storen.getEquipmentDTO().getOriginal_price());
    String avgPriceFormatted = nf.format(avgNewPrice);
    String avgRentalPriceFormatted = nf.format(avgRentalPrice);
    String dailyRentalPriceFormatted = nf.format(storen.getDaily_rent_price());
%>
<html>
<head>
    <title>storenMatching-request.jsp</title>

    <!-- 외부 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">

    <!-- 내부 리소스 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/matching.css">

    <!-- 매칭신청 버튼 비활성화 시, hover 액션 안 되도록 처리 -->
    <style>
        .btn-primary.disabled:hover {
            background-color: #aaa;
            border-color: var(--btn-primary-hover-border);
            color: var(--btn-primary-text);
            pointer-events: none !important; /* hover 자체를 감지하지 않음 */
        }

    </style>
</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
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
                        <button class="image-nav-btn next-btn"><i class="fas fa-chevron-right"></i></button>
                        <span class="image-counter">1/<%= totalImages %></span>
                    </div>
                </div>
                <div class="thumbnail-container d-flex">
                    <% for(int i=0; i<totalImages; i++) { %>
                    <div class="thumbnail <%= (i==0) ? "active" : "" %>" data-index="<%= i %>"></div>
                    <% } %>
                </div>
                <div class="user-info d-flex align-items-center mb-2">
                    <span class="font-medium">${owner.nickname}</span>
                    <img src="/resources/images/rank-icon5.png" class="rank-icon ml-2">
                    <span class="text-secondary text-xs">(신뢰도 ${owner.totalTrust}% / 신고 0회 접수)</span>
                    <button class="report-btn btn-sm btn-text ml-auto">신고</button>
                </div>
                <div class="text-tertiary text-xs">${storen.created_date} 등록</div>
            </div>

            <!-- 오른쪽: 장비 정보 & 렌탈 신청 -->
            <div class="right-column card">
                <table class="info-table w-100">
                    <tr>
                        <th class="text-secondary">장비명</th>
                        <td>${storen.equipmentDTO.equip_name}</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">카테고리</th>
                        <td>${storen.equipmentDTO.majorCategory} > ${storen.equipmentDTO.middleCategory}</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">브랜드</th>
                        <td>${storen.equipmentDTO.brand}</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">신품 가격</th>
                        <td>
                            <span class="price font-bold text-lg"><%=priceFormatted%>원</span>
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
                        <td>${storen.rental_start_date} ~ ${storen.rental_end_date}</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">렌탈 가격</th>
                        <td>
                            <span class="price rental-price-value font-bold"><%=dailyRentalPriceFormatted%>원/일</span>
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
                ${storen.storen_content}
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

<jsp:include page="footer.jsp"/>

<!-- [G] 스크립트 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
    // [H] JSP 값 가져오기 - 렌탈 가격 정보
    var dailyRentalPrice = ${storen.daily_rent_price};
    var selectedDateRange = "<%= selectedDateRange != null ? selectedDateRange : "" %>";
    var selectedDays = "<%= selectedDays != null ? selectedDays : "0" %>";
    var selectedPrice = "<%= selectedPrice != null ? selectedPrice : "0원" %>";
    let lastValidDays = selectedDays !== "0" ? parseInt(selectedDays) : 0;
    let lastValidPrice = selectedPrice !== "0원" ? selectedPrice : "0원";

    // 이미지 관련 설정
    var totalImages = <%= totalImages %>;
</script>

<script type="text/javascript">
    $(document).ready(function () {
        initializeModals();       // 모달 초기화
        initializeDateRangePicker(); // 날짜 선택기 초기화
        initializeImageNavigation(); // 이미지 내비게이션 초기화
        initializeTooltips();     // 툴팁 초기화

        // 현재 사용자의 매칭 상태 확인
        checkMatchingStatus();
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
        // 두 번째 모달의 확인 버튼 클릭 이벤트 - 매칭 완료 처리 (AJAX 방식)
        $("#confirm2").on("click", function () {
            // 수정: 선택된 날짜 범위와 일수 파라미터도 함께 전달
            //const dateRange = $('#date-range').val();
            //const days = lastValidDays;
            //const price = lastValidPrice;

            // 매칭 완료 후에도 기존에 선택한 정보를 유지하기 위해 파라미터로 전달
            // location.href = "storenMatching-request.jsp?matching_done=true&dateRange=" +
            //     encodeURIComponent(dateRange) + "&days=" + days + "&price=" +
            //     encodeURIComponent(price);

            // DateRangePicker에서 선택된 날짜 객체 가져오기
            const dateRangePicker = $('#date-range').data('daterangepicker');

            // 시작일과 종료일 추출 (YYYY-MM-DD 형식으로 변환)
            const rentalStartDate = dateRangePicker.startDate.format('YYYY-MM-DD');
            const rentalEndDate = dateRangePicker.endDate.format('YYYY-MM-DD');

            // AJAX 요청으로 매칭 신청 데이터 전송
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/api/storen/matching-request",
                data: {
                    storenId: ${storen.storen_id}, // 장비 ID
                    rentalStartDate: rentalStartDate,
                    rentalEndDate: rentalEndDate,
                },
                success: function(response) {
                    // 성공 시 모달 닫기
                    $("#matching-confirm-modal2").hide();
                    $("body").css("overflow", "auto");

                    if (response.success) {
                        // 매칭 버튼을 비활성화하고 '매칭 중'으로 변경
                        $(".match-btn").addClass("disabled").attr("disabled", "disabled").text("매칭 중");

                        // 성공 메시지 표시
                        Swal.fire({
                            icon: 'success',
                            title: '매칭 신청 완료',
                            text: '매칭 신청이 완료되었습니다. 장비 소유자의 승인을 기다려주세요.'
                        });
                    } else {
                        // 오류 메시지 표시
                        Swal.fire({
                            icon: 'error',
                            title: '매칭 신청 실패',
                            text: response.message || '매칭 신청에 실패했습니다. 다시 시도해주세요.'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    // 오류 처리
                    $("#matching-confirm-modal2").hide();
                    $("body").css("overflow", "auto");

                    Swal.fire({
                        icon: 'error',
                        title: '매칭 신청 실패',
                        text: '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
                    });

                    console.error("매칭 신청 오류:", error);
                }
            });
        });
    }

    // [2] 날짜 선택기 초기화 함수
    function initializeDateRangePicker() {
        // 날짜 범위 설정 - 렌탈 가능 기간 기준
        // 날짜 체크 예시
        const minDate = '${storen.rental_start_date != null ? storen.rental_start_date : ""}';  //렌탈가능시작일
        const maxDate = '${storen.rental_end_date != null ? storen.rental_end_date : ""}';      //렌탈가능종료일

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
                format: 'YYYY-MM-DD',  // 날짜 형식
                separator: ' ~ ',      // 구분자
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
            $(this).val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));

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

    // [3] 이미지 내비게이션 초기화 함수 (개선)
    function initializeImageNavigation() {
        let currentImageIndex = 0;

        // 이미지 카운터 업데이트 함수
        function updateImageCounter() {
            const counterText = (currentImageIndex + 1) + '/' + totalImages;
            document.querySelector('.image-counter').textContent = counterText;
        }

        // 썸네일 활성화 상태 업데이트 함수
        function updateThumbnailActive() {
            document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
                if (index === currentImageIndex) {
                    thumb.classList.add('active');
                } else {
                    thumb.classList.remove('active');
                }
            });
        }

        // 이전 버튼 클릭 이벤트
        document.querySelector('.prev-btn').addEventListener('click', function(e) {
            e.preventDefault(); // 기본 동작 방지
            currentImageIndex = (currentImageIndex - 1 + totalImages) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        // 다음 버튼 클릭 이벤트
        document.querySelector('.next-btn').addEventListener('click', function(e) {
            e.preventDefault(); // 기본 동작 방지
            currentImageIndex = (currentImageIndex + 1) % totalImages;
            updateImageCounter();
            updateThumbnailActive();
        });

        // 썸네일 클릭 이벤트
        document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
            thumb.addEventListener('click', function() {
                currentImageIndex = index;
                updateImageCounter();
                updateThumbnailActive();
            });
        });

        // 초기 상태 설정
        updateImageCounter();
        updateThumbnailActive();
    }

    // [4] 툴팁 초기화 함수 (화살표 없는 툴팁 사용)
    function initializeTooltips() {
        // 모든 툴팁 트리거에 이벤트 등록
        document.querySelectorAll('.tooltip-trigger').forEach((trigger) => {
            const tooltip = trigger.querySelector('.tooltip-content');
            if (!tooltip) return;

            // 툴팁에 기본 클래스 추가
            tooltip.classList.add('tooltip-top');

            // 마우스 진입 시
            trigger.addEventListener('mouseenter', function(e) {
                // 툴팁 표시
                tooltip.style.display = 'block';

                // 위치 계산
                positionTooltip(tooltip, trigger);
            });

            // 마우스 이탈 시 툴팁 숨김
            trigger.addEventListener('mouseleave', function() {
                tooltip.style.display = 'none';
            });
        });

        // 스크롤 시 열려 있는 툴팁 위치 조정
        window.addEventListener('scroll', function() {
            const visibleTooltips = document.querySelectorAll('.tooltip-content[style*="display: block"]');
            visibleTooltips.forEach(tooltip => {
                const trigger = tooltip.parentElement;
                if (trigger) positionTooltip(tooltip, trigger);
            });
        });

        // 윈도우 크기 변경 시 열려 있는 툴팁 위치 조정
        window.addEventListener('resize', function() {
            const visibleTooltips = document.querySelectorAll('.tooltip-content[style*="display: block"]');
            visibleTooltips.forEach(tooltip => {
                const trigger = tooltip.parentElement;
                if (trigger) positionTooltip(tooltip, trigger);
            });
        });
    }

    // 툴팁 위치 계산 함수
    function positionTooltip(tooltip, trigger) {
        // 트리거 요소의 위치 정보
        const triggerRect = trigger.getBoundingClientRect();

        // 툴팁 요소의 크기
        const tooltipWidth = tooltip.offsetWidth;
        const tooltipHeight = tooltip.offsetHeight;

        // 윈도우 크기
        const windowWidth = window.innerWidth;
        const windowHeight = window.innerHeight;

        // 기본 위치 - 트리거 위에 표시 (간격 약간 줄임)
        let top = triggerRect.top - tooltipHeight - 5;
        let left = triggerRect.left + (triggerRect.width / 2) - (tooltipWidth / 2);

        // 상단에 공간이 부족한 경우 아래에 표시
        const showBelow = top < 10;
        if (showBelow) {
            top = triggerRect.bottom + 5; // 간격 조정
            tooltip.classList.remove('tooltip-top');
            tooltip.classList.add('tooltip-bottom');
        } else {
            tooltip.classList.remove('tooltip-bottom');
            tooltip.classList.add('tooltip-top');
        }

        // 좌우 공간 확인 및 조정
        if (left < 10) {
            left = 10; // 왼쪽 경계에 맞춤
        } else if (left + tooltipWidth > windowWidth - 10) {
            left = windowWidth - tooltipWidth - 10; // 오른쪽 경계에 맞춤
        }

        // 위치 설정
        tooltip.style.top = `${top}px`;
        tooltip.style.left = `${left}px`;
    }


    // 매칭 상태 확인 함수
    function checkMatchingStatus() {
        console.log("storenId 값 확인:", ${storen.storen_id});
        $.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/api/storen/check-matching-status",
            data: {
                storenId: "${storen.storen_id}"
            },
            success: function(response) {
                //alert("매칭상태정보를 잘 가져왔습니다!" + response.hasMatching);
                if (response.hasMatching) {
                    // 이미 매칭 신청한 경우 UI 업데이트
                    $(".match-btn").addClass("disabled").attr("disabled", "disabled").text("매칭승인대기");

                    // 선택했던 날짜 범위 복원
                    if (response.dateRange) {
                        $('#date-range').val(response.dateRange);
                    }

                    // 일수와 가격 표시 복원
                    $('#rental-days').text('(' + response.days + '일)');
                    $('#total-price-value').text(response.price);
                }
            }
        });
    }
</script>

</body>
</html>