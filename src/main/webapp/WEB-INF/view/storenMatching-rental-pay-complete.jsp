<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 완료된 프로세스 정보를 저장할 변수
    String processName = "렌탈비 결제";

    // 관련 메뉴명을 저장할 변수들
    String prevMenu = "메인으로";
    String nextMenu = "내가 대여한 장비 목록";

    // 주문 번호 생성
    String orderNumber = "10000000";

    // 결제 날짜 (현재 날짜)
    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    String orderDate = dateFormat.format(new java.util.Date());

    // 렌탈 정보
    String rentalPeriod = "2025.06.04 ~ 2025.06.10 (7일)";
    int totalAmount = 20000;

    // 천 단위 콤마 형식 지정
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>storenMatching-rental-pay-complete.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/matching.css">

</head>
<body>

<jsp:include page="header.jsp"/>

<main class="main-content container">
    <!-- 완료 메시지 표시 -->
    <div class="complete-message">
        '<%= processName %>'이(가) 완료되었습니다.
    </div>

    <!-- 주문 완료 정보 -->
    <div class="order-info">
        <div class="text-center mb-3">
            <i class="fas fa-check-circle fa-3x mb-2" style="color: var(--color-maple);"></i>
            <h2 class="mb-2">렌탈 신청이 완료되었습니다.</h2>
            <p>결제번호: <span class="info-highlight">${pay.paymentId}</span></p>
            <p>주문일시: ${matching.payment_date}</p>
        </div>
    </div>

    <!-- 주문 상세 정보 -->
    <div class="order-detail">
        <h3 class="mb-3">주문 상세 정보</h3>
        <div class="info-row">
            <div class="info-label font-bold">렌탈 기간</div>
            <div class="info-value">${matching.rental_start_date} ~ ${matching.rental_end_date}</div><br>
        </div>
        <div class="info-row">
            <div class="info-label font-bold">결제 금액</div>
            <div class="info-value">${matching.rental_pay}원</div><br>
        </div>
        <div class="info-row">
            <div class="info-label font-bold">배송 안내</div>
            <div class="info-value">
                * 대여하신 장비는 렌탈 시작일 이전 3~4일 내 배송 시작될 예정입니다.<br>
                * 배송 시작 시, 알림 메시지를 드릴 예정입니다.<br>
                * 배송 상태는 마이페이지 > 배송조회/내역에서 확인 가능합니다.
            </div>
        </div>
    </div>

    <div class="button-container">
        <button class="btn" onclick="location.href='main.action'"><%= prevMenu %></button>
        <button class="btn btn-primary" onclick="location.href='mypage-rentequip.action'"><%= nextMenu %></button>
    </div>
</main>

<!-- 푸터 포함 -->
<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>