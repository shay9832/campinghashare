<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.team.mvc.DTO.MatchingRequestDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 천 단위 콤마 형식 지정
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();

    // 렌탈 금액 천 단위 콤마 형식 위해 먼저 꺼내오기
    MatchingRequestDTO matchingRequestDTO = (MatchingRequestDTO)request.getAttribute("matching");
    String rentalCostStr = "";
    if (matchingRequestDTO != null) {
        rentalCostStr = formatter.format(matchingRequestDTO.getRental_pay());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>storenMatching-rental-pay.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="header.jsp"/>

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title">스토렌 신청 (렌탈비 결제)</h1>

        <!-- 배송지 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">배송 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">받는사람</label>
                    <div class="form-input">
                        <span class="info-text">${user.userName}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">휴대전화</label>
                    <div class="form-input">
                        <span class="info-text">${user.userTel}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">주소</label>
                    <div class="form-input">
                        <div class="zipcode-row">
                            <input type="text" id="postcode" class="form-control" placeholder="우편번호" value="${user.zipCode}">
                            <button onclick="execDaumPostcode()" class="btn">우편번호 찾기</button>
                        </div>
                        <input type="text" id="address" class="form-control mt-2" placeholder="주소" value="${user.address1}" readonly="readonly">
                        <input type="text" id="detailAddress" class="form-control mt-2" placeholder="상세주소" value="${user.address2}">

                        <!-- 우편번호 검색 API 컨테이너 (기본 숨김) -->
                        <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
                            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 신청 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">신청 정보</h3>
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
                <div class="form-row mt-3">
                    <label class="form-label">카테고리(대)</label>
                    <div class="form-input">
                        <span class="info-text">${storen.equipmentDTO.majorCategory}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">카테고리(중)</label>
                    <div class="form-input">
                        <span class="info-text">${storen.equipmentDTO.middleCategory}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">브랜드</label>
                    <div class="form-input">
                        <span class="info-text">${storen.equipmentDTO.brand}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비명</label>
                    <div class="form-input">
                        <span class="info-text">${storen.equipmentDTO.equip_name}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비 등급</label>
                    <div class="form-input">
                        <span class="grade-badge grade-" + ${storen.equip_grade}>${storen.equip_grade}</span>
                        <a href="storenregister-inspecresult.action" class="text-link">(상세 내용 보기)</a>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">렌탈 기간</label>
                    <div class="form-input">
                        <span class="info-text">${matching.rental_start_date} ~ ${matching.rental_end_date} (${matching.rental_duration}일)</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">총 렌탈 비용</label>
                    <div class="form-input">
                        <span class="info-text"><%= rentalCostStr %>원</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 할인 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">할인</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">보유 쿠폰</label>
                    <div style="margin-left: auto; display: flex; align-items: center; gap: 10px;">
                        <div>${couponList.size()}장</div>
                        <button class="btn btn-secondary">쿠폰 적용</button>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">쿠폰 할인 금액</div>
                    <div class="col-6 text-right text-coral" id="couponPrice">- 0원</div>
                </div>
                <div id="appliedCouponInfo" style="display: none; margin-top: 10px;">
                    <div class="d-flex justify-content-between align-items-center">
                        <span id="appliedCouponName" class="text-secondary"></span>
                        <button id="cancelCoupon" class="btn btn-sm btn-danger">적용 취소</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 결제 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">결제 정보</h3>
            </div>
            <div class="card-body">
                <div class="row mb-2">
                    <div class="col-6">주문상품</div>
                    <div class="col-6 text-right" id="originalPrice"><%= rentalCostStr %>원</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">배송비</div>
                    <div class="col-6 text-right">+0원</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">할인</div>
                    <div class="col-6 text-right text-coral" id="discountPrice">- 0원</div>
                </div>
                <hr class="my-3">
                <div class="row">
                    <div class="col-6 font-weight-bold">최종 결제 금액</div>
                    <div class="col-6 text-right font-weight-bold text-primary" id="finalPrice"><%= rentalCostStr %>원</div>
                </div>
            </div>
        </div>

        <!-- 결제 수단 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">결제 수단</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">결제수단 선택</label>
                    <div class="form-input">
                        <div class="form-check form-check-inline">
                            <input type="radio" class="form-check-input" name="payment_method" id="credit_card" value="credit_card" checked>
                            <label class="form-check-label" for="credit_card">신용카드</label>
                        </div>
                        <div class="form-check form-check-inline ml-3">
                            <input type="radio" class="form-check-input" name="payment_method" id="bank_transfer" value="bank_transfer">
                            <label class="form-check-label" for="bank_transfer">무통장 입금</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 약관 동의 및 주문 확인 -->
        <div class="info-section card mt-4">
            <div class="card-body">
                <div class="form-check text-center mb-4">
                    <input type="checkbox" class="form-check-input" name="confirm_order" id="confirm_order">
                    <label class="form-check-label" for="confirm_order">주문 내용을 확인하였으며, 결제 진행에 동의합니다.</label>
                </div>
            </div>
        </div>

        <!-- 주문 확인 메시지 (체크박스 클릭 시 활성화) -->
        <div class="complete-message" id="orderConfirmMessage" style="display: none;">
            주문 내용을 확인하였습니다.
        </div>

        <!-- 이전/다음 버튼 -->
        <div class="button-container">
            <a href="mypage-matchinglist.action" class="btn">이전</a>
            <button class="btn btn-primary pay-now-btn">결제하기</button>
        </div>
    </div>
</main>

<!-- 쿠폰 선택 패널 - 기본적으로 숨김 -->
<div id="couponPanel" class="info-section card" style="display: none; position: absolute; width: 80%; max-width: 800px; z-index: 1000; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h3 class="card-title">쿠폰 선택</h3>
        <button type="button" class="close" id="closeCouponPanel" style="background: none; border: none; font-size: 1.5rem;">&times;</button>
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
        <div style="max-height: 300px; overflow-y: auto;">
            <table class="table">
                <thead>
                <tr>
                    <th class="p-2 text-center" style="width: 33.33%;">할인율</th>
                    <th class="p-2 text-center" style="width: 33.33%;">쿠폰명</th>
                    <th class="p-2 text-center" style="width: 33.33%;">참고사항</th>
                </tr>
                </thead>
                <tbody>
                <!-- 쿠폰 리스트 -->
                <c:forEach var="coupon" items="${couponList}">
                    <tr class="coupon-row" style="cursor: pointer;"
                        data-coupon-id="${coupon.coupon_id}"
                        data-discount="${coupon.coupon_discount}"
                        data-name="${coupon.coupon_name}">
                        <td class="p-3">
                            <div>
                                <input type="radio" name="coupon_name" id="coupon_${coupon.coupon_id}"
                                       class="coupon-radio"
                                       data-discount="${coupon.coupon_discount}"
                                       data-name="${coupon.coupon_name}">
                                <label for="coupon_${coupon.coupon_id}">${coupon.coupon_discount}% 할인</label>
                            </div>
                        </td>
                        <td class="p-3">${coupon.coupon_name}</td>
                        <td class="p-3">
                            <ul style="margin: 0; padding-left: 20px;">
                                <li>최대 할인율: ${coupon.coupon_discount}%</li>
                                <li>만료 예정: ${coupon.coupon_end_date}까지</li>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 버튼 영역 -->
        <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
            <button type="button" class="btn" id="cancelCouponBtn">취소</button>
            <button type="button" class="btn" id="resetCouponBtn">초기화</button>
            <button type="button" class="btn" id="applyCouponBtn">적용</button>
        </div>
    </div>
</div>

<!-- 배경 오버레이 -->
<div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;"></div>

<!-- 푸터 포함 -->
<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        // 초기 상태에서 결제 버튼 비활성화
        $(".btn-primary.pay-now-btn").prop("disabled", true);

        // 결제 수단 버튼 선택 처리
        $("input[name='payment_method']").click(function() {
            // 모든 결제 옵션에서 체크 해제
            $("input[name='payment_method']").prop("checked", false);
            // 선택된 결제 옵션 체크
            $(this).prop("checked", true);
        });

        // 쿠폰 적용 버튼 클릭 이벤트
        $(".btn-secondary").click(function() {
            // 현재 버튼의 위치 가져오기
            const buttonOffset = $(this).offset();
            const buttonHeight = $(this).outerHeight();

            // 쿠폰 패널 위치 설정 (버튼 바로 아래)
            $("#couponPanel").css({
                position: "absolute",
                top: (buttonOffset.top + buttonHeight) + "px",
                left: "50%",
                transform: "translateX(-50%)",
                zIndex: 1000
            });

            // 쿠폰 패널과 오버레이 표시
            $("#couponPanel").show();
            $("#overlay").show();
        });

        // 취소 버튼 클릭 이벤트
        $("#cancelCouponBtn, #closeCouponPanel, #overlay").click(function() {
            // 쿠폰 패널과 오버레이 숨기기
            $("#couponPanel").hide();
            $("#overlay").hide();
        });

        // 쿠폰 행 클릭 이벤트
        $(document).on('click', '.coupon-row', function() {
            // 해당 행의 라디오 버튼 체크
            const radioBtn = $(this).find('input[type="radio"]');

            // 모든 라디오 버튼 초기화
            $('input[name="coupon_name"]').prop('checked', false);

            // 클릭한 행의 라디오 버튼 체크
            radioBtn.prop('checked', true);
        });

        // 라디오 버튼 클릭 시 이벤트 버블링 방지
        $(document).on('click', '.coupon-radio', function(e) {
            e.stopPropagation();
        });

        // 적용 버튼 클릭 시 버블링 방지
        $("#applyCouponBtn, #resetCouponBtn").click(function(e) {
            e.stopPropagation();
        });

        // 쿠폰 패널 내부 클릭 시 패널 닫힘 방지
        $("#couponPanel").click(function(e) {
            e.stopPropagation();
        });

        // 초기화 버튼 클릭 이벤트
        $("#resetCouponBtn").click(function() {
            // 선택된 라디오 버튼 초기화
            $('input[name="coupon_name"]').prop('checked', false);
        });

        // 적용 버튼 클릭 이벤트
        $("#applyCouponBtn").click(function() {
            const selectedCoupon = $('input[name="coupon_name"]:checked');

            if (selectedCoupon.length > 0) {
                // 선택된 쿠폰 정보 가져오기
                const discountAmount = selectedCoupon.data('discount');
                const couponName = selectedCoupon.data('name');

                // 쿠폰 할인 금액 표시 업데이트
                updateCouponDiscount(discountAmount, couponName);

                // 쿠폰 패널과 오버레이 숨기기
                $("#couponPanel").hide();
                $("#overlay").hide();
            } else {
                alert("쿠폰을 선택해주세요.");
            }
        });

        // 할인 금액 업데이트 및 최종 금액 계산 함수 (퍼센트 계산)
        function updateCouponDiscount(discountRate, couponName) {
            // 상품 가격 가져오기 (천 단위 콤마 제거 후 숫자로 변환)
            const productPriceText = $("#originalPrice").text();
            const productPrice = parseInt(productPriceText.replace(/[^0-9]/g, ''));

            // 할인 금액 계산 (퍼센트 기준)
            const discountAmount = Math.floor(productPrice * (discountRate / 100));

            // 쿠폰 할인 금액 표시 업데이트
            const formattedDiscount = new Intl.NumberFormat('ko-KR').format(discountAmount);
            $("#couponPrice").html('- ' + formattedDiscount + '원');
            $("#discountPrice").html('- ' + formattedDiscount + '원');

            // 쿠폰명 표시 및 적용 취소 버튼 표시
            $("#appliedCouponName").text('적용된 쿠폰: ' + couponName);
            $("#appliedCouponInfo").show();

            // 쿠폰명 저장
            if (!$("#selectedCouponName").length) {
                $("body").append('<input type="hidden" id="selectedCouponName" value="">');
                $("body").append('<input type="hidden" id="selectedDiscountRate" value="">');
            }
            $("#selectedCouponName").val(couponName);
            $("#selectedDiscountRate").val(discountRate);

            // 최종 결제 금액 계산 (상품가격 - 할인금액)
            const finalAmount = productPrice - discountAmount;
            const formattedFinalAmount = new Intl.NumberFormat('ko-KR').format(finalAmount);

            // 최종 결제 금액 업데이트
            $("#finalPrice").text(formattedFinalAmount + '원');
        }

        // 쿠폰 취소 버튼 클릭 이벤트
        $(document).on('click', '#cancelCoupon', function() {
            // 쿠폰 할인 금액 초기화
            $("#couponPrice").html(`- 0원`);
            $("#discountPrice").html(`- 0원`);

            // 쿠폰 정보 숨김
            $("#appliedCouponInfo").hide();

            // 쿠폰 선택 해제
            $('input[name="coupon_name"]').prop('checked', false);

            // 쿠폰 정보 초기화
            $("#selectedCouponName").val('');
            $("#selectedDiscountRate").val('');

            // 최종 금액 원래대로 복원
            const productPriceText = $("#originalPrice").text();
            const productPrice = parseInt(productPriceText.replace(/[^0-9]/g, ''));
            const formattedPrice = new Intl.NumberFormat('ko-KR').format(productPrice);
            $("#finalPrice").text(formattedPrice + '원');
        });

        // 지불하기 버튼 클릭 이벤트
        $(".pay-now-btn").click(function(e) {  // e 파라미터 추가
            e.preventDefault(); // 기본 이벤트 방지
            e.stopPropagation(); // 상위 요소로 이벤트 전파 방지

            // 쿠폰 할인 금액 가져오기
            const discountText = $("#CouponPrice").text();
            const discountAmount = parseInt(discountText.replace(/[^0-9]/g, '')) || 0;

            // 최종 결제 금액 가져오기
            const finalAmountText = $("#finalPrice").text();
            const finalAmount = parseInt(finalAmountText.replace(/[^0-9]/g, ''));

            // selectedCouponId 가져오기
            const selectedCouponId = $('input[name="coupon_name"]:checked').attr('id') || '';

            // 결제 AJAX 요청
            $.ajax({
                url: '/api/payment',
                type: 'POST',
                data: {
                    methodId: $('input[name="payment_method"]:checked').val(),
                    requestId: ${matching.matching_req_id}, // JSP EL 표현식
                    amount: finalAmount,
                    couponId: selectedCouponId
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('결제가 완료되었습니다.');
                        // 결제 완료 페이지로 이동
                        window.location.href = "storenmatching-rental-pay-complete.action";
                    } else {
                        alert('결제 중 오류가 발생했습니다: ' + (response.message || '알 수 없는 오류'));
                    }
                },
                error: function(xhr, status, error) {
                    console.error("결제 실패:", error);
                    alert('결제 중 오류가 발생했습니다.');
                }
            });
        });


        // 체크박스 토글 처리
        $("#confirm_order").change(function() {
            if($(this).is(":checked")) {
                // 체크박스 체크 시 결제 버튼 활성화
                $(".btn-primary.pay-now-btn").prop("disabled", false);
                // 주문 확인 메시지 표시
                $("#orderConfirmMessage").show();
            } else {
                // 체크박스 해제 시 결제 버튼 비활성화
                $(".btn-primary.pay-now-btn").prop("disabled", true);
                // 주문 확인 메시지 숨김
                $("#orderConfirmMessage").hide();
            }
        });



    });
</script>

<!-- 다음 우편번호/주소 API 소스 코드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    // 우편번호 검색창 접기 함수
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    // 우편번호 검색 실행 함수
    function execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다. (검색창 닫은 후 위치 복원)
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;

                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }

</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>