<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>storenRegister-storage-pay-coupon.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 800px; margin: 0 auto;">
    <div class="info-section card w-100">
        <div class="card-header">
            <h3 class="card-title">쿠폰 조회</h3>
        </div>

        <div class="card-body">
            <!-- 쿠폰 유의사항 섹션 -->
            <div class="mb-4">
                <h4 class="font-medium mb-2">쿠폰 관련 유의 사항</h4>
                <div class="text-secondary">
                    <ul class="list-disc pl-4">
                        <li>쿠폰은 주문 당 1장만 사용 가능합니다.</li>
                    </ul>
                </div>
            </div>

            <!-- 쿠폰 리스트 섹션 -->
            <div class="overflow-auto" style="max-height: 400px;">
                <table class="border-collapse">
                    <thead>
                    <tr class="bg-primary text-light" style="position: sticky; top: 0; z-index: 1;">
                        <th class="p-2 text-center small" style="width: 33.33%;">할인 금액</th>
                        <th class="p-2 text-center small" style="width: 33.33%;">쿠폰명</th>
                        <th class="p-2 text-center small" style="width: 33.33%;">참고사항</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 첫 번째 쿠폰 -->
                    <tr class="border-bottom">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon1">
                                <label class="form-check-label" for="coupon1">10,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">상품 할인 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 10,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 두 번째 쿠폰 -->
                    <tr class="border-bottom bg-secondary">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon2">
                                <label class="form-check-label" for="coupon2">27,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">신규 고객 특별 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 27,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 세 번째 쿠폰 -->
                    <tr class="border-bottom">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon3">
                                <label class="form-check-label" for="coupon3">50,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">VIP 전용 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 50,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 네 번째 쿠폰 -->
                    <tr class="border-bottom bg-secondary">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon4">
                                <label class="form-check-label" for="coupon4">15,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">시즌 할인 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 15,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 다섯 번째 쿠폰 -->
                    <tr class="border-bottom">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon5">
                                <label class="form-check-label" for="coupon5">30,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">생일 축하 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 30,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 여섯 번째 쿠폰 -->
                    <tr class="border-bottom bg-secondary">
                        <td class="p-3" style="width: 33.33%;">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon6">
                                <label class="form-check-label" for="coupon6">20,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3" style="width: 33.33%;">회원가입 쿠폰</td>
                        <td class="p-3" style="width: 33.33%;">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 20,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 일곱 번째 쿠폰 -->
                    <tr class="border-bottom">
                        <td class="p-3">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon7">
                                <label class="form-check-label" for="coupon7">12,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3">주말 특별 쿠폰</td>
                        <td class="p-3">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 12,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 여덟 번째 쿠폰 -->
                    <tr class="border-bottom bg-secondary">
                        <td class="p-3">
                            <div class="form-check form-check-inline justify-content-center">
                                <input type="radio" class="form-check-input" name="coupon_name" id="coupon8">
                                <label class="form-check-label" for="coupon8">8,000원 할인</label>
                            </div>
                        </td>
                        <td class="p-3">첫 구매 쿠폰</td>
                        <td class="p-3">
                            <ul class="mb-0">
                                <li>최대 할인 금액: 8,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- 버튼 영역 -->
            <div class="button-container d-flex justify-content-end gap-3 mt-4">
                <button href="#" class="btn">취소</button>
                <button class="btn btn-secondary" onclick="resetCoupon()">초기화</button>
                <button href="#" class="btn btn-primary" onclick="completeCoupon()">적용</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    // 초기화 버튼 클릭 시 실행되는 함수
    function resetCoupon() {
        // 체크된 라디오 버튼 초기화
        const radios = document.querySelectorAll('input[name="coupon_name"]');
        radios.forEach(radio => {
            radio.checked = false;
        });
    }

    // 완료 버튼 클릭 시 실행되는 함수
    function completeCoupon() {
        // 선택된 쿠폰 확인
        const selectedCoupon = document.querySelector('input[name="coupon_name"]:checked');
        if (selectedCoupon) {
            // 선택된 쿠폰이 있으면 알림 표시 및 팝업창 닫기
            alert("쿠폰이 적용되었습니다.");
            window.close(); // 팝업창 닫기
        } else {
            // 선택된 쿠폰이 없으면 알림 표시
            alert("쿠폰을 선택해주세요.");
        }
    }

    // 부모 창과의 통신 기능
    function applySelectedCoupon() {
        const selectedCoupon = document.querySelector('input[name="coupon_name"]:checked');
        if (selectedCoupon && window.opener && !window.opener.closed) {
            let couponId = selectedCoupon.id;
            let couponAmount = 0;
            let couponName = "";

            // 선택된 쿠폰 정보 확인
            if (couponId === "coupon1") {
                couponAmount = 10000;
                couponName = "상품 할인 쿠폰";
            } else if (couponId === "coupon2") {
                couponAmount = 27000;
                couponName = "신규 고객 특별 쿠폰";
            } else if (couponId === "coupon3") {
                couponAmount = 50000;
                couponName = "VIP 전용 쿠폰";
            } else if (couponId === "coupon4") {
                couponAmount = 15000;
                couponName = "시즌 할인 쿠폰";
            } else if (couponId === "coupon5") {
                couponAmount = 30000;
                couponName = "생일 축하 쿠폰";
            } else if (couponId === "coupon6") {
                couponAmount = 20000;
                couponName = "회원가입 쿠폰";
            } else if (couponId === "coupon7") {
                couponAmount = 12000;
                couponName = "주말 특별 쿠폰";
            } else if (couponId === "coupon8") {
                couponAmount = 8000;
                couponName = "첫 구매 쿠폰";
            }

            // 부모 창에 쿠폰 정보 전달
            if (couponAmount > 0) {
                try {
                    // 부모 창의 쿠폰 정보 업데이트 함수 호출
                    window.opener.updateCouponInfo(couponName, couponAmount);
                } catch (e) {
                    console.error("부모 창과의 통신 중 오류 발생:", e);
                }
            }
        }
    }

    // 완료 버튼 클릭 시 부모 창에 쿠폰 정보 전달
    document.querySelector('.btn-primary').addEventListener('click', function() {
        const selectedCoupon = document.querySelector('input[name="coupon_name"]:checked');
        if (selectedCoupon) {
            applySelectedCoupon();
        }
    });
</script>
</body>
</html>