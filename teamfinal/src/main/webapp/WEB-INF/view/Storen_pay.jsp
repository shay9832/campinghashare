<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Storen_pay.css">
</head>
<body>

<jsp:include page="/WEB-INF/view/Header.jsp"></jsp:include>
<main>
    <!-- 스토렌 신청 제목 컨테이너 - 페이지 최상단 제목 -->
    <div class="main-container_top">
        <h1>스토렌 신청(보관비 결제)</h1>
    </div>

    <!-- 메인 컨테이너 - 배송지와 신청정보를 담는 전체 컨테이너 -->
    <div class="main-container">

        <!-- 배송지 정보 섹션 시작 - 사용자 배송 정보 입력 영역 -->
        <div class="delivery-section">
            <!-- 배송지 선택 헤더 - 섹션 제목 -->
            <div class="main-container_delivery">
                <h2>배송지 선택(최초 수거 & 반환 예정 주소)</h2>
            </div>

            <!-- 배송지 개인정보 영역 - 이름, 전화번호, 이메일 표시 -->
            <div class="main-container_delivery_content">
                <!-- 받는 사람 정보 행 -->
                <div class="delivery_pickup">
                    <span>받는 사람</span>
                    <span>차은우</span>
                </div>
                <!-- 휴대전화 정보 행 -->
                <div class="phone_number">
                    <span>휴대 전화</span>
                    <span>010-0000-0000</span>
                </div>
                <!-- 이메일 정보 행 -->
                <div class="e-mail">
                    <span>이메일</span>
                    <span>ssit@naver.com</span>
                </div>
            </div>

            <!-- 주소 입력 영역 - 배송 주소 검색 및 입력 -->
            <div class="main_container_delivery_address">
                <!-- 주소 레이블 -->
                <span>주소</span>
                <!-- 주소 입력 필드 컨테이너 -->
                <div class="address_input_container">
                    <!-- 우편번호 검색 행 - 검색창과 버튼 -->
                    <div class="address_search_row">
                        <input type="search" class="address_search" placeholder="우편번호">
                        <input type="button" value="주소 검색" class="btn_address">
                    </div>
                    <!-- 기본 주소 입력 필드 -->
                    <input type="text" class="address_one" placeholder="기본 주소">
                    <!-- 상세 주소 입력 필드 -->
                    <input type="text" class="address_two" placeholder="상세 주소">
                </div>
            </div>
        </div>
        <!-- 배송지 정보 섹션 끝 -->

        <!-- 신청 정보 섹션 시작 - 보관할 장비 정보 입력 영역 -->
        <div class="application-section">
            <!-- 신청 정보 헤더 - 섹션 제목 -->
            <div class="main_container_app_info">
                <h2>신청 정보</h2>
            </div>

            <!-- 신청 정보 내용 영역 - 장비 사진 및 세부 정보 입력 -->
            <div class="main_container_app_info_content">
                <!-- 장비 사진 업로드 행 -->
                <div class="form-row">
                    <div class="form-label">장비 사진</div>
                    <div class="form-input">
                        <div class="image-upload">
                            <!-- 이미지 플레이스홀더 1 - 첫번째 사진 업로드 영역 -->
                            <div class="image-placeholder"></div>
                            <!-- 이미지 플레이스홀더 2 - 두번째 사진 업로드 영역 -->
                            <div class="image-placeholder"></div>
                        </div>
                    </div>
                </div>

                <!-- 카테고리(대) 정보 행 -->
                <div class="form-row">
                    <div class="form-label">카테고리(대)</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="category_b">
                    </div>
                </div>

                <!-- 카테고리(중) 정보 행 -->
                <div class="form-row">
                    <div class="form-label">카테고리(중)</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="category_m">
                    </div>
                </div>

                <!-- 브랜드 정보 행 -->
                <div class="form-row">
                    <div class="form-label">브랜드</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="brand">
                    </div>
                </div>

                <!-- 장비명 정보 행 -->
                <div class="form-row">
                    <div class="form-label">장비명</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="equip_name">
                    </div>
                </div>

                <!-- 장비 사이즈 정보 행 -->
                <div class="form-row">
                    <div class="form-label">장비 사이즈</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="size">
                    </div>
                </div>

                <!-- 보관 기간 정보 행 -->
                <div class="form-row">
                    <div class="form-label">보관 기간</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="storage_period">
                    </div>
                </div>

                <!-- 총 보관 비용 정보 행 -->
                <div class="form-row">
                    <div class="form-label">총 보관 비용</div>
                    <div class="form-input">
                        <input type="text" disabled="disabled" class="all_sum">
                    </div>
                </div>
            </div>
            <!-- 신청 정보 내용 영역 끝 -->
        </div>
        <!-- 신청 정보 섹션 끝 -->


        <%--할인 섹션 시작--%>
        <div class="discount-section">
            <div class="discount-title">
                <h2>할인</h2>
            </div>
            <div class="discount-content">
                <!-- 쿠폰 할인 및 적용 버튼 행 -->
                <div class="discount-row">
                    <span class="discount_coupon">쿠폰 할인</span>
                    <div class="discount-right">
                        <input type="text" class="discount_sum">
                        <button class="apply_coupon">쿠폰 적용</button>
                    </div>
                </div>
                <!-- 보유 쿠폰 행 - 오른쪽 정렬 -->
                <div class="coupon-row">
                    <input type="text" class="have_coupon">
                </div>
            </div>
        </div>

        <!-- 결제 정보 섹션 시작 -->
        <div class="payment-info-section">
            <div class="payment-info-title">
                <h2>결제 정보</h2>
            </div>
            <div class="payment-info-content">
                <!-- 주문상품 정보 행 -->
                <div class="payment-row">
                    <span class="payment-label">주문상품</span>
                    <span class="payment-amount">30,000원</span>
                </div>
                <!-- 배송비 정보 행 -->
                <div class="payment-row">
                    <span class="payment-label">배송비</span>
                    <span class="payment-amount">3,000원</span>
                </div>
                <!-- 할인 정보 행 -->
                <div class="payment-row">
                    <span class="payment-label">할인</span>
                    <span class="payment-amount">-5,000원</span>
                </div>
                <!-- 구분선 -->
                <div class="payment-divider"></div>
                <!-- 최종 결제 금액 행 -->
                <div class="payment-row total-payment">
                    <span class="payment-label">최종 결제 금액</span>
                    <span class="payment-amount">28,000원</span>
                </div>
            </div>
        </div>
        <!-- 결제 정보 섹션 끝 -->

        <!-- 결제 수단 섹션 시작 -->
        <div class="payment-method-section">
            <div class="payment-method-title">
                <h2>결제 수단</h2>
            </div>
            <div class="payment-method-content">
                <div class="payment-method-label">결제수단 선택</div>
                <div class="payment-method-options">
                    <label class="payment-method-option">
                        <input type="radio" name="payment_method" value="credit_card" checked>
                        <span class="payment-method-text">신용카드</span>
                    </label>
                    <label class="payment-method-option">
                        <input type="radio" name="payment_method" value="bank_transfer">
                        <span class="payment-method-text">무통장 입금</span>
                    </label>
                </div>
            </div>
        </div>
        <!-- 결제 수단 섹션 끝 -->

        <!-- 주문 확인 및 버튼 섹션 시작 -->
        <div class="confirmation-section">
            <!-- 주문 확인 체크박스 -->
            <div class="order-confirmation">
                <label class="confirmation-label">
                    <input type="checkbox" name="confirm_order" id="confirm_order">
                    <span class="confirmation-text">주문 내용을 확인하였습니다.</span>
                </label>
            </div>

            <!-- 버튼 영역 -->
            <div class="button-container">
                <button type="button" class="btn-previous">이전</button>
                <button type="button" class="btn-payment">결제하기</button>
            </div>
        </div>
        <!-- 주문 확인 및 버튼 섹션 끝 -->


    </div>
    <!-- 메인 컨테이너 끝 -->

</main>

<jsp:include page="/WEB-INF/view/Footer.jsp"></jsp:include>
</body>
</html>
