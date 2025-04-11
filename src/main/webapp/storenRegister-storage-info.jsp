<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>storenRegister-storage-info.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<jsp:include page="WEB-INF/view/header.jsp"/>

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
                            <div class="image-placeholder"></div>
                            <div class="image-placeholder"></div>
                        </div>
                    </div>
                </div>

                <div class="form-row"><label class="form-label">카테고리(대)</label><div class="form-input"><span class="info-text">텐트/쉘터</span></div></div>
                <div class="form-row"><label class="form-label">카테고리(중)</label><div class="form-input"><span class="info-text">텐트</span></div></div>
                <div class="form-row"><label class="form-label">브랜드</label><div class="form-input"><span class="info-text">스노우피크</span></div></div>
                <div class="form-row"><label class="form-label">장비명</label><div class="form-input"><span class="info-text">스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653</span></div></div>
                <div class="form-row">
                    <label class="form-label">신품가격</label>
                    <div class="form-input d-flex align-items-center">
                        <span class="info-text">3,050,000 원</span>
                        <div class="d-flex align-items-center ml-4">
                            <span class="price-diff">(평균 대비 22%▲)</span>
                            <span class="text-secondary ml-2">평균 신품 가격 2,500,000원</span>
                            <div class="info-icon tooltip-trigger ml-2">
                                <i class="fa-solid fa-circle-question"></i>
                                <div class="tooltip-content">이 가격은 최근 등록된 동일 상품의 평균 가격입니다.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row text-center text-tertiary font-italic">
                    ※ 상단 정보는 '내 소유 장비 목록' 메뉴에서 수정 가능
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

    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <a href="#" class="btn">이전</a>
        <a href="storenRegister-storage-pay.jsp" class="btn btn-primary">다음</a>
    </div>
</main>

<jsp:include page="WEB-INF/view/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
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
            updateRentalPrice();
        });

        function updateRentalPrice() {
            const days = parseInt($('#rentalDays').val()) || 1;
            const total = dailyPrice * days * 30;
            $('#totalPrice').text(total.toLocaleString());
        }

        updateRentalPrice();
    });
</script>

</body>
</html>