<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Admin Title</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-main.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <!-- 인라인 스타일 추가 -->
  <style>
    /* 대시보드 그리드 레이아웃 수정 - 한 열로 배치 */
    .dashboard-grid {
      display: block !important; /* 블록 레이아웃으로 변경 */
      width: 100% !important;
    }

    /* 위젯 스타일 */
    .widget {
      display: block !important;
      visibility: visible !important;
      opacity: 1 !important;
      background-color: white !important;
      border-radius: 4px !important;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
      overflow: hidden !important;
      margin-bottom: 20px !important;
      width: 100% !important; /* 항상 전체 너비 */
    }

    /* 차트 컨테이너 스타일 */
    .chart-container {
      height: 300px !important;
    }

    /* 탭 스타일링 수정 */
    .tabs {
      display: flex;
      border-bottom: 1px solid #ddd;
      margin-bottom: 15px;
    }

    .tab-btn {
      padding: 8px 15px;
      background-color: transparent;
      border: none;
      border-bottom: 2px solid transparent;
      cursor: pointer;
      font-weight: 500;
      margin-right: 10px;
      transition: all 0.3s ease;
    }

    .tab-btn:hover {
      color: #3f861d;
    }

    .tab-btn.active {
      color: #3f861d;
      border-bottom: 2px solid #3f861d;
    }

    .tab-content {
      display: none;
    }

    .tab-content.active {
      display: block;
    }

    /* 테이블 스타일 개선 */
    .report-table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
    }

    .report-table th,
    .report-table td {
      padding: 10px;
      text-align: center;
      border-bottom: 1px solid #eee;
      word-wrap: break-word;
    }

    .report-table th {
      background-color: #f5f5f5;
      font-weight: 500;
    }

    /* 더보기 버튼 스타일 */
    .more-btn {
      font-size: 12px;
      color: #666;
      text-decoration: none;
      padding: 4px 8px;
      border-radius: 4px;
      background-color: #f5f5f5;
      transition: all 0.2s ease;
    }

    .more-btn:hover {
      background-color: #e0e0e0;
      color: #333;
    }

    /* 위젯 헤더에 더보기 버튼 정렬 */
    .widget-header {
      padding: 15px;
      border-bottom: 1px solid #eee;
      font-weight: bold;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    /* 통계 요약 스타일 수정 */
    .summary-stats {
      display: flex !important;
      flex-direction: row !important;
      flex-wrap: wrap !important;
      justify-content: space-around !important;
      padding: 15px 0 !important;
    }

    .stat-item {
      flex: 1 !important;
      min-width: 100px !important;
      text-align: center !important;
      padding: 15px !important;
      margin: 5px !important;
      border-radius: 4px !important;
      background-color: #f5f5f5 !important;
    }

    .stat-value {
      font-size: 24px;
      font-weight: bold;
      color: #3f861d;
      margin-bottom: 5px;
    }

    .stat-label {
      font-size: 14px;
      color: #666;
    }

    /* 이벤트 상태 표시 스타일 */
    .status-active {
      display: inline-block;
      padding: 2px 8px;
      background-color: #4CAF50;
      color: white;
      border-radius: 12px;
      font-size: 12px;
    }

    .status-ended {
      display: inline-block;
      padding: 2px 8px;
      background-color: #9e9e9e;
      color: white;
      border-radius: 12px;
      font-size: 12px;
    }
  </style>
</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 표시 -->
<div id="header">
  <h1>관리자 시스템</h1>
</div>

<!-- 메인 컨테이너 -->
<div id="container">
  <!-- 좌측 메뉴 영역 - 원본 그대로 유지 -->
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

  <!-- 콘텐츠 영역 - 각 위젯이 세로로 한 줄씩 배치되도록 수정 -->
  <div id="content">
    <div class="dashboard-grid">
      <!-- 그래프 상세 위젯 -->
      <div class="widget">
        <div class="widget-header">그래프 상세</div>
        <div class="widget-content chart-container">
          <canvas id="myChart"></canvas>
        </div>
      </div>

      <!-- 신고 관리 위젯 -->
      <div class="widget">
        <div class="widget-header">
          신고 관리
          <a href="${pageContext.request.contextPath}/admin-userReport.action" class="more-btn">더보기</a>
        </div>
        <div class="widget-content">
          <div class="tabs">
            <button class="tab-btn active" data-tab="posts">게시물</button>
            <button class="tab-btn" data-tab="comments">댓글</button>
          </div>
          <div id="posts" class="tab-content active">
            <table class="report-table">
              <thead>
              <tr>
                <th width="10%">번호</th>
                <th width="25%">제목</th>
                <th width="25%">신고사유</th>
                <th width="20%">신고일</th>
                <th width="20%">처리상태</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="item" items="${report}" varStatus="status">
                <tr>
                  <td style="text-align: center;">${status.count}</td>
                  <td>${item.report_title}</td>
                  <td>${item.report_content}</td>
                  <td style="text-align: center;">${item.report_date}</td>
                  <td style="text-align: center;">${item.report_status}</td>
                </tr>
              </c:forEach>
              <!-- 예시 데이터 -->
              <c:if test="${empty report}">
                <tr>
                  <td style="text-align: center;">1</td>
                  <td>부적절한 게시물</td>
                  <td>광고성 게시글</td>
                  <td style="text-align: center;">2025-04-20</td>
                  <td style="text-align: center;">처리중</td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
          <div id="comments" class="tab-content">
            <table class="report-table">
              <thead>
              <tr>
                <th width="10%">번호</th>
                <th width="30%">댓글내용</th>
                <th width="25%">신고사유</th>
                <th width="15%">신고일</th>
                <th width="20%">처리상태</th>
              </tr>
              </thead>
              <tbody>
              <!-- 예시 데이터 -->
              <tr>
                <td style="text-align: center;">1</td>
                <td>부적절한 댓글...</td>
                <td>욕설/비방</td>
                <td style="text-align: center;">2025-04-22</td>
                <td style="text-align: center;">처리중</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- 일일 거래 및 금액 종합 위젯 -->
      <div class="widget">
        <div class="widget-header">
          일일 거래 및 금액 종합
          <a href="${pageContext.request.contextPath}/admin-payUpdate.action" class="more-btn">더보기</a>
        </div>
        <div class="widget-content">
          <div class="tabs">
            <button class="tab-btn active" data-tab="storen">스토렌</button>
            <button class="tab-btn" data-tab="rental">렌탈</button>
          </div>
          <div id="storen" class="tab-content active">
            <div class="summary-stats">
              <div class="stat-item">
                <div class="stat-value">${count.storenPaymentCount != null ? count.storenPaymentCount : 3}</div>
                <div class="stat-label">일일 거래수</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">₩ 245,000</div>
                <div class="stat-label">일일 거래액</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">₩ 81,667</div>
                <div class="stat-label">평균 거래액</div>
              </div>
            </div>
          </div>
          <div id="rental" class="tab-content">
            <div class="summary-stats">
              <div class="stat-item">
                <div class="stat-value">${count.rentalPaymentCount != null ? count.rentalPaymentCount : 5}</div>
                <div class="stat-label">일일 거래수</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">₩ 175,000</div>
                <div class="stat-label">일일 거래액</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">₩ 35,000</div>
                <div class="stat-label">평균 거래액</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 공지사항 위젯 추가 -->
      <div class="widget">
        <div class="widget-header">
          공지사항
          <a href="${pageContext.request.contextPath}/admin-noticeList.action" class="more-btn">더보기</a>
        </div>
        <div class="widget-content">
          <table class="report-table">
            <thead>
            <tr>
              <th width="10%">번호</th>
              <th width="50%">제목</th>
              <th width="15%">작성자</th>
              <th width="25%">작성일</th>
            </tr>
            </thead>
            <tbody>
            <!-- 예시 데이터 -->
            <tr>
              <td style="text-align: center;">1</td>
              <td>시스템 점검 안내 (4/25)</td>
              <td style="text-align: center;">관리자</td>
              <td style="text-align: center;">2025-04-23</td>
            </tr>
            <tr>
              <td style="text-align: center;">2</td>
              <td>4월 거래 정책 변경 안내</td>
              <td style="text-align: center;">관리자</td>
              <td style="text-align: center;">2025-04-18</td>
            </tr>
            <tr>
              <td style="text-align: center;">3</td>
              <td>신규 장비 등록 절차 변경 안내</td>
              <td style="text-align: center;">관리자</td>
              <td style="text-align: center;">2025-04-15</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 이벤트 현황 위젯 추가 -->
      <div class="widget">
        <div class="widget-header">
          이벤트 현황
          <a href="${pageContext.request.contextPath}/admin-eventUpdate.action" class="more-btn">더보기</a>
        </div>
        <div class="widget-content">
          <table class="report-table">
            <thead>
            <tr>
              <th width="10%">번호</th>
              <th width="40%">이벤트명</th>
              <th width="15%">시작일</th>
              <th width="15%">종료일</th>
              <th width="20%">상태</th>
            </tr>
            </thead>
            <tbody>
            <!-- 예시 데이터 -->
            <tr>
              <td style="text-align: center;">1</td>
              <td>신규 회원 가입 이벤트</td>
              <td style="text-align: center;">2025-04-01</td>
              <td style="text-align: center;">2025-04-30</td>
              <td style="text-align: center;"><span class="status-active">진행중</span></td>
            </tr>
            <tr>
              <td style="text-align: center;">2</td>
              <td>봄맞이 장비 할인 프로모션</td>
              <td style="text-align: center;">2025-04-10</td>
              <td style="text-align: center;">2025-05-10</td>
              <td style="text-align: center;"><span class="status-active">진행중</span></td>
            </tr>
            <tr>
              <td style="text-align: center;">3</td>
              <td>3월 리뷰 이벤트</td>
              <td style="text-align: center;">2025-03-01</td>
              <td style="text-align: center;">2025-03-31</td>
              <td style="text-align: center;"><span class="status-ended">종료</span></td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 차트 생성 스크립트 -->
<script>
  const userCount = ${count.newUserCount != null ? count.newUserCount : 5};
  const storenPaymentCount = ${count.storenPaymentCount != null ? count.storenPaymentCount : 3};
  const storagePaymentCount = ${count.storagePaymentCount != null ? count.storagePaymentCount : 10};
  const rentalPaymentCount = ${count.rentalPaymentCount != null ? count.rentalPaymentCount : 5};
  const totalPaymentCount = ${count.totalPaymentCount != null ? count.totalPaymentCount : 7};

  const ctx = document.getElementById('myChart').getContext('2d');
  const myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['신규 회원수','스토렌결제수','보관결제수','렌탈결제수','총결제수'],
      datasets: [{
        label: '일일 상황판',
        data: [userCount,storenPaymentCount,storagePaymentCount,rentalPaymentCount,totalPaymentCount],
        borderWidth: 2,
        backgroundColor: 'rgba(63, 134, 29, 0.2)',
        borderColor: 'rgba(63, 134, 29, 1)'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>

<!-- 탭 기능 자바스크립트 수정 -->
<script>
  // 탭 기능을 위한 이벤트 리스너 등록
  document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll('.tab-btn');

    tabBtns.forEach(btn => {
      btn.addEventListener('click', function() {
        // 이 버튼이 속한 탭 그룹 찾기
        const tabsContainer = this.closest('.tabs');
        const widgetContent = tabsContainer.closest('.widget-content');

        // 이 탭 그룹의 모든 버튼 비활성화
        const groupBtns = tabsContainer.querySelectorAll('.tab-btn');
        groupBtns.forEach(groupBtn => groupBtn.classList.remove('active'));

        // 클릭된 버튼 활성화
        this.classList.add('active');

        // 모든 탭 콘텐츠 숨기기
        const allTabContents = widgetContent.querySelectorAll('.tab-content');
        allTabContents.forEach(content => content.classList.remove('active'));

        // 선택된 탭 콘텐츠 표시
        const tabId = this.getAttribute('data-tab');
        document.getElementById(tabId).classList.add('active');
      });
    });
  });
</script>

<!-- 메뉴 스크립트 -->
<script>
  // 모든 메뉴 버튼 요소를 선택
  document.addEventListener('DOMContentLoaded', function() {
    const menuButtons = document.querySelectorAll('.menu-button');

    // 각 메뉴 버튼에 클릭 이벤트 리스너 추가
    menuButtons.forEach(button => {
      button.addEventListener('click', function() {
        // 클릭된 버튼에 'active' 클래스를 토글
        this.classList.toggle('active');

        // 버튼 다음에 오는 요소(하위메뉴)를 가져옴
        const submenu = this.nextElementSibling;

        // 하위메뉴가 열려있는지 확인
        if (submenu.style.maxHeight) {
          // 열려있으면 닫기
          submenu.style.maxHeight = null;
        } else {
          // 닫혀있으면 열기
          submenu.style.maxHeight = submenu.scrollHeight + 'px';
        }
      });
    });

    // 창 크기 변경 시 위젯이 항상 보이도록 설정
    window.addEventListener('resize', function() {
      const widgets = document.querySelectorAll('.widget');
      widgets.forEach(widget => {
        widget.style.visibility = 'visible';
        widget.style.display = 'block';
        widget.style.opacity = '1';
      });
    });
  });
</script>
</body>
</html>