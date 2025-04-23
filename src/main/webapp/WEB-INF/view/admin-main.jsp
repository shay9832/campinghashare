<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>admin-main.jsp</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-main.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link>
</head>
<body>
<jsp:include page="/WEB-INF/view/admin-header.jsp" />

<!-- 메인 컨테이너 -->
<div id="container">
  <!-- 좌측 메뉴 영역 -->
  <div id="leftMenu">
    <!-- 장비 관리 메뉴 -->
    <button class="menu-button">장비 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-equipList.action" method="get">
        <button type="submit" class="submenu-btn">장비 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-equipStatistics.action" method="get">
        <button type="submit" class="submenu-btn">장비 통계</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get">
        <button type="submit" class="submenu-btn">브랜드 및 장비생성</button>
      </form>
    </div>

    <!-- 검수 관리 메뉴 -->
    <button class="menu-button">검수 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-inspectList.action" method="get">
        <button type="submit" class="submenu-btn">검수 관리</button>
      </form>
    </div>

    <!-- 매칭 관리 메뉴 -->
    <button class="menu-button">매칭 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-matchingList.action" method="get">
        <button type="submit" class="submenu-btn">매칭 관리</button>
      </form>
    </div>

    <!-- 결제 관리 메뉴 -->
    <button class="menu-button">결제 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-payment.action" method="get">
        <button type="submit" class="submenu-btn">결제 관리</button>
      </form>
    </div>

    <!-- 배송 관리 메뉴 -->
    <button class="menu-button">배송 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-deliveryUpdate.action" method="get">
        <button type="submit" class="submenu-btn">배송 관리</button>
      </form>
    </div>

    <!-- 게시판 관리 메뉴 -->
    <button class="menu-button">게시판 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="get">
        <button type="submit" class="submenu-btn">게시물 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-replyUpdate.action" method="get">
        <button type="submit" class="submenu-btn">댓글 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-communityStatistics.action" method="get">
        <button type="submit" class="submenu-btn">커뮤니티 통계</button>
      </form>
    </div>

    <!-- 회원 관리 메뉴 -->
    <button class="menu-button">회원 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-userList.action" method="get">
        <button type="submit" class="submenu-btn">회원 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-userDrop.action" method="get">
        <button type="submit" class="submenu-btn">회원 제재 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
        <button type="submit" class="submenu-btn">포인트 관리</button>
      </form>
    </div>

    <!-- 신고 관리 메뉴 -->
    <button class="menu-button">신고 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-userReport.action" method="get">
        <button type="submit" class="submenu-btn">신고 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-userReportList.action" method="get">
        <button type="submit" class="submenu-btn">신고 처리 내역</button>
      </form>
    </div>

    <!-- 포인트 관리 메뉴 -->
    <button class="menu-button">포인트 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
        <button type="submit" class="submenu-btn">포인트 관리</button>
      </form>
    </div>

    <!-- 쿠폰 관리 메뉴 -->
    <button class="menu-button">쿠폰 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-couponList.action" method="get">
        <button type="submit" class="submenu-btn">쿠폰 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-createCoupon.action" method="get">
        <button type="submit" class="submenu-btn">쿠폰 생성</button>
      </form>
    </div>

    <!-- 이벤트 관리 메뉴 -->
    <button class="menu-button">이벤트 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-eventUpdate.action" method="get">
        <button type="submit" class="submenu-btn">이벤트 관리</button>
      </form>
    </div>
  </div>

  <!-- 콘텐츠 영역 - 선택된 메뉴에 따라 내용이 표시될 영역 -->
  <div id="content">
    <div class="dashboard-grid">
      <!-- 상단 차트 위젯 (이미지의 8번 영역) -->
      <div class="widget widget-large">
        <div class="widget-header">그래프 상세</div>
        <div class="widget-content chart-container">
          <div>
            <canvas id="myChart" width="771" height="230"></canvas>
          </div>
        </div>
      </div>

      <!-- 우측 상단 프로필 위젯 -->
      <div class="widget widget-profile">
        <div class="widget-header">프로필</div>
        <div class="widget-content">
          <!-- 프로필 내용 -->
        </div>
      </div>

      <!-- 좌측 하단 게시물 위젯 (이미지의 9번 영역) -->
      <div class="widget widget-medium">
        <div class="widget-header">신고글 목록 <span class="badge">5</span></div>
        <div class="widget-content">
          <!-- 게시물 목록 내용 -->
          <c:forEach var="item" items="${report}">
            ${item.report_content}
          </c:forEach>
        </div>
      </div>

      <!-- 중앙 하단 공지사항 위젯 (이미지의 10번 영역) -->
      <div class="widget widget-medium">
        <div class="widget-header">일일 거래 및 금액 종합</div>
        <div class="widget-content">
          <!-- 공지사항 내용 -->
        </div>
      </div>

      <!-- 좌측 하단의 추가 위젯 (이미지의 11번 영역) -->
      <div class="widget widget-small">
        <div class="widget-header">최근 활동로그</div>
        <div class="widget-content">
          <!-- 활동로그 내용 -->
        </div>
      </div>

      <!-- 중앙 하단의 추가 위젯 (이미지의 12번 영역) -->
      <div class="widget widget-small">
        <div class="widget-header">캠핑장 소식</div>
        <div class="widget-content">
          <!-- 뉴스 내용 -->
        </div>
      </div>

      <!-- 우측 하단 채팅 위젯 -->
      <div class="widget widget-chat">
        <div class="widget-header">메시지 목록</div>
        <div class="widget-content">
          <!-- 메시지 내용 -->
        </div>
      </div>
    </div>
  </div>

</div>

<%--그래프용 스크립트--%>
<script>
  const userCount = ${count.newUserCount}
  const storenPaymentCount = ${count.storenPaymentCount}
  const storagePaymentCount = ${count.storagePaymentCount}
  const rentalPaymentCount = ${count.rentalPaymentCount}
  const totalPaymentCount = ${count.totalPaymentCount}

  const ctx = document.getElementById('myChart').getContext('2d');

  const myChart = new Chart(ctx, {
    type: 'line', // 'line', 'pie', 'doughnut', 'radar', 등 다양함
    data: {
      labels: ['신규 회원수','스토렌결제수','보관결제수','렌탈결제수','총결제수'],
      datasets: [{
        label: '일일 상황판',
        data: [userCount,storenPaymentCount,storagePaymentCount,rentalPaymentCount,totalPaymentCount],
        borderWidth: 1,
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          // ...
        ]
      }]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>


<!-- 자바스크립트 - 드롭다운 메뉴 기능 구현 -->
<script>
  // 모든 메뉴 버튼 요소를 선택하여 menuButtons 변수에 저장
  const menuButtons = document.querySelectorAll('.menu-button');

  // 각 메뉴 버튼에 클릭 이벤트 리스너 추가
  menuButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 클릭된 버튼에 'active' 클래스를 토글(있으면 제거, 없으면 추가)
      this.classList.toggle('active');

      // 버튼 다음에 오는 요소(하위메뉴)를 가져옴
      const submenu = this.nextElementSibling;

      // 하위메뉴가 열려있는지 확인 (maxHeight 스타일 속성이 설정되어 있는지)
      if (submenu.style.maxHeight) {
        // 열려있으면 닫기 (maxHeight를 null로 설정)
        submenu.style.maxHeight = null;
      } else {
        // 닫혀있으면 열기 (maxHeight를 내용 높이만큼 설정)
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
      }
    });
  });
</script>
</body>
</html>