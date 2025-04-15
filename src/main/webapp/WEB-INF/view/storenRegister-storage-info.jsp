<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.team.mvc.DTO.RegisterStorenDTO" %>
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

    // 평균 가격 예시는 고정값 (향후 DB에서 계산되면 바꾸면 됨)
    int averagePrice = 2500000;

    // 가격 차이 퍼센트 계산
    int priceDiffPercentage = 0;
    String priceDiffArrow = "";
    if (averagePrice > 0) {
        priceDiffPercentage = (int)(((originalPrice - averagePrice) / (double)averagePrice) * 100);
        priceDiffArrow = priceDiffPercentage >= 0 ? "▲" : "▼";
        priceDiffPercentage = Math.abs(priceDiffPercentage);
    }
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
                            <c:if test="${info.photoList != null && not empty info.photoList}">
                                <c:forEach var="photo" items="${info.photoList}" varStatus="status">
                                    <c:if test="${photo != null && not empty photo.attachmentPath}">
                                        <div class="photo-preview">
                                            <img src="${photo.attachmentPath}" alt="장비 사진 ${status.index + 1}" />
                                        </div>
                                    </c:if>
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
                        <div class="d-flex align-items-center ml-4">
                            <span class="price-diff">평균 대비 <%= priceDiffPercentage %>%<%= priceDiffArrow %></span>
                            <span class="text-secondary ml-2">평균 신품 가격 <%= formatter.format(averagePrice) %>원</span>
                            <div class="info-icon tooltip-trigger ml-2">
                                <i class="fa-solid fa-circle-question"></i>
                                <div class="tooltip-content">이 가격은 최근 등록된 동일 상품의 평균 가격입니다.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row text-center text-tertiary font-italic">
                    ※ 상단 정보는 '내가 소유한 장비' 메뉴에서 수정 가능
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
                <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
                <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
                <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
            </ul>
        </div>
    </div>

    <!-- form 전송 시 hidden 파라미터 -->
    <form action="storenRegister-storage-pay-info.action" method="GET" id="storenForm">
            <input type="hidden" name="equip_code" value="<%= equipInfo.getEquip_code() %>">
            <input type="hidden" id="selectedSize" name="equipSize" value="M">
            <input type="hidden" id="selectedDays" name="storageDays" value="1">
            <input type="hidden" id="selectedTotalPrice" name="storageCost" value="90000">

        <div class="button-container">
            <a href="${pageContext.request.contextPath}/storenRegister-storage-pay.action?equip_code=${equipCode}" class="btn">이전</a>
            <button type="submit" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/storenRegister-storage-pay.action?equip_code=${equipCode}'">다음</button>
        </div>
    </form>
</main>

<jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>