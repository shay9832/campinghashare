<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.team.mvc.DTO.RegisterStorenDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    DecimalFormat formatter = new DecimalFormat("#,###");

    // 컨트롤러에서 전달받은 장비 정보 객체
    RegisterStorenDTO equipInfo = (RegisterStorenDTO) request.getAttribute("equipInfo");

    // null 체크 후 값 꺼내기
    String majorCategory = equipInfo != null ? equipInfo.getMajorCategory() : "N/A";
    String middleCategory = equipInfo != null ? equipInfo.getMiddleCategory() : "N/A";
    String brand = equipInfo != null ? equipInfo.getBrand() : "N/A";
    String equipName = equipInfo != null ? equipInfo.getEquip_name() : "N/A";
    int originalPrice = equipInfo != null ? equipInfo.getOriginal_price() : 0;
%>
<html>
<head>
    <title>스토렌 신청</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            let count = 1;
            let dailyPrice = 3000;

            // 페이지 로딩 시 초기 총 보관 비용 계산
            updateRentalPrice();

            $('.size-option').click(function() {
                $('.size-option').removeClass('active');
                $(this).addClass('active');
                dailyPrice = parseInt($(this).data('price'));
                $('#storageCost').text(dailyPrice.toLocaleString());
                $('#dailyPrice').text(dailyPrice.toLocaleString());
                updateRentalPrice();
                $('#selectedSize').val($(this).text());
            });

            $('.decrease').click(function() {
                let days = parseInt($('#rentalDays').val()) || 1;
                if (days > 1) {
                    $('#rentalDays').val(days - 1).trigger('input');
                }
            });

            $('.increase').click(function() {
                let days = parseInt($('#rentalDays').val()) || 1;
                if (days < 30) {
                    $('#rentalDays').val(days + 1).trigger('input');
                }
            });

            $('#rentalDays').on('input change', function() {
                const days = parseInt($(this).val()) || 1;
                $('#selectedDays').val(days);
                updateRentalPrice();
            });

            function updateRentalPrice() {
                const days = parseInt($('#rentalDays').val()) || 1;
                const total = dailyPrice * days * 30;
                $('#totalPrice').text(total.toLocaleString());
                $('#selectedTotalPrice').val(total);
            }

            // 툴팁 이벤트 처리 추가
            $(document).on('mouseenter', '.tooltip-trigger', function () {
                $(this).find('.tooltip-content').stop().fadeIn(200);
            });

            $(document).on('mouseleave', '.tooltip-trigger', function () {
                $(this).find('.tooltip-content').stop().fadeOut(200);
            });
        });
    </script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title page-title-storen-register">스토렌 신청(보관 정보 입력)</h1>

        <!-- 내 장비 정보 섹션 -->
        <div class="info-section card">
            <div class="card-header">
                <h3 class="card-title">내 장비 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">장비 사진</label>
                    <div class="form-input">
                        <div class="image-upload d-flex gap-3">
                            <c:if test="${not empty info.photoList}">
                                <c:forEach var="photo" items="${info.photoList}" varStatus="status">
                                    <div class="photo-preview">
                                        <img src="${pageContext.request.contextPath}${photo.attachmentPath}" alt="장비 사진 ${status.index + 1}" />
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="form-row"><label class="form-label">카테고리(대)</label><div class="form-input"><span class="info-text"><%= majorCategory %></span></div></div>
                <div class="form-row"><label class="form-label">카테고리(중)</label><div class="form-input"><span class="info-text"><%= middleCategory %></span></div></div>
                <div class="form-row"><label class="form-label">브랜드</label><div class="form-input"><span class="info-text"><%= brand %></span></div></div>
                <div class="form-row"><label class="form-label">장비명</label><div class="form-input"><span class="info-text"><%= equipName %></span></div></div>
                <div class="form-row">
                    <label class="form-label">신품가격</label>
                    <div class="form-input d-flex align-items-center">
                        <span class="info-text"><%= formatter.format(equipInfo.getOriginal_price()) %> 원</span>

                        <!-- 평균 가격 비교 정보 -->
                        <c:if test="${avgNewPrice > 0}">
                            <div class="d-flex align-items-center ml-4">
                                <span class="price-diff ${priceDiffClass}">평균 대비 ${priceDiff}%${priceDiffSymbol}</span>
                                <span class="text-secondary ml-2">평균 신품 가격 ${formattedAvgPrice}원</span>
                                <div class="info-icon tooltip-trigger ml-2">
                                    <i class="fa-solid fa-circle-question"></i>
                                    <div class="tooltip-content">유저들이 입력한 평균 신품 가격 기준입니다.</div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="form-row text-center text-tertiary font-italic">
                </div>
            </div>
        </div>

        <!-- 렌탈 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">렌탈 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">장비 사이즈</label>
                    <div class="form-input">
                        <div class="d-flex align-items-center">
                            <div class="size-options d-flex">
                                <div class="size-option" data-price="1000">XS</div>
                                <div class="size-option" data-price="2000">S</div>
                                <div class="size-option active" data-price="3000">M</div>
                                <div class="size-option" data-price="4000">L</div>
                                <div class="size-option" data-price="5000">XL</div>
                            </div>
                            <div class="ml-4 font-bold">
                                보관 비용 <span id="storageCost">3,000</span>원/일
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <label class="form-label">보관 개월 수</label>
                    <div class="form-input">
                        <div class="d-flex align-items-center">
                            <div class="counter-container">
                                <button class="decrease">-</button>
                                <input type="number" id="rentalDays" value="1" min="1" max="30" class="counter-value">
                                <button class="increase">+</button>
                            </div>
                            <span class="ml-2">개월(30일 기준)</span>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <label class="form-label">총 보관 비용</label>
                    <div class="form-input">
                        <div class="font-weight-bold">
                            <span id="totalPrice" style="font-weight: bold">3,000</span>원
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 등록 시 주의사항 -->
        <div class="notice-container">
            <div class="notice-title">거래 시 주의사항</div>
            <ul class="notice-list">
                <li><strong>스토렌 신청 시, 신청 즉시 자체 운송으로 수거 진행됩니다.</strong></li>
                <li><strong>플랫폼 창고 입고 후, 장비 검수 진행 예정입니다.</strong></li>
                <li><strong>장비 검수 결과, A~E 등급이면 스토렌 서비스 이용 가능하나 F등급일 경우 소유자분께 반환될 예정입니다.</strong></li>
            </ul>
        </div>
    </div>

    <!-- form 전송 시 hidden 파라미터 -->
    <form action="storenRegister-storage-pay.action" method="GET" id="storenForm">
        <input type="hidden" name="equip_code" value="<%= equipInfo.getEquip_code() %>">
        <input type="hidden" id="selectedSize" name="equipSize" value="M">
        <input type="hidden" id="selectedDays" name="storageDays" value="1">
        <input type="hidden" id="selectedTotalPrice" name="storageCost" value="90000">

        <div class="button-container">
            <a href="${pageContext.request.contextPath}/mypage-myequip.action" class="btn">이전</a>
            <button type="submit" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/storenRegister-storage-pay.action?equip_code=${equipCode}'">다음</button>
        </div>
    </form>
</main>

<jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>