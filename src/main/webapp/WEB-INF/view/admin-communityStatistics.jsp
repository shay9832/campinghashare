<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 시스템 - 커뮤니티 통계</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-communityStatistics.css">
</head>

<body>
<!-- 헤더 영역 -->
<div id="header">
  <h1>관리자 시스템</h1>
</div>

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
      <form action="${pageContext.request.contextPath}/admin-payUpdate.action" method="get">
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
    <div class="submenu" style="max-height: 200px;">
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

  <!-- 콘텐츠 영역 -->
  <div id="content">
    <!-- 콘텐츠 헤더 -->
    <div class="content-header">
      <h2>커뮤니티 통계</h2>
    </div>

    <!-- 탭 메뉴 -->
    <div class="tabs">
      <button class="tab-btn active" data-tab="board-activity">게시판 활성도</button>
      <button class="tab-btn" data-tab="report-analysis">신고유형 분석</button>
      <button class="tab-btn" data-tab="new-posts">신규 게시글 현황</button>
    </div>

    <!-- 검색 필터 -->
    <div class="content-search-info">
      <span>기간</span>
      <div class="content-search-date">
        <input type="date" value="2025-03-01">
        <span>~</span>
        <input type="date" value="2025-04-06">
      </div>

      <span>게시판</span>
      <select>
        <option>전체</option>
        <option>공지사항</option>
        <option>자유게시판</option>
        <option>질문과답변</option>
        <option>장비리뷰</option>
        <option>거래게시판</option>
      </select>

      <div class="content-search-btn">
        <input type="button" value="검색하기">
      </div>
    </div>

    <!-- 다운로드 버튼 -->
    <button class="download-btn">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
        <polyline points="7 10 12 15 17 10"></polyline>
        <line x1="12" y1="15" x2="12" y2="3"></line>
      </svg>
      통계 데이터 내보내기
    </button>

    <!-- 게시판 활성도 탭 콘텐츠 -->
    <div class="tab-content active" id="board-activity">
      <!-- 통계 카드 -->
      <div class="statistics-cards">
        <div class="statistic-card">
          <h3>전체 게시글 수</h3>
          <div class="value">36,542</div>
          <div class="change positive">+8.4% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>전체 댓글 수</h3>
          <div class="value">148,976</div>
          <div class="change positive">+12.3% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>총 조회수</h3>
          <div class="value">2,856,421</div>
          <div class="change positive">+15.7% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>가장 활성화된 게시판</h3>
          <div class="value">자유게시판</div>
          <div class="change">전체 활동의 42%</div>
        </div>
      </div>

      <!-- 게시판 활성도 차트 -->
      <div class="chart-container">
        <!-- 차트가 들어갈 자리 (실제 구현 시 차트 라이브러리 사용) -->
        <img src="/api/placeholder/800/350" alt="게시판 활성도 차트 예시" style="width: 100%; height: 100%; object-fit: contain;">
      </div>

      <!-- 게시판 활성도 테이블 -->
      <div class="statistics-table">
        <table>
          <tr>
            <th>게시판명</th>
            <th>게시글수</th>
            <th>댓글수</th>
            <th>조회수</th>
            <th>활성도 점수</th>
          </tr>
          <tr>
            <td>자유게시판</td>
            <td>12,485</td>
            <td>85,236</td>
            <td>1,247,856</td>
            <td>100</td>
          </tr>
          <tr>
            <td>장비리뷰</td>
            <td>8,954</td>
            <td>32,845</td>
            <td>782,148</td>
            <td>75</td>
          </tr>
          <tr>
            <td>질문과답변</td>
            <td>6,587</td>
            <td>18,542</td>
            <td>425,687</td>
            <td>58</td>
          </tr>
          <tr>
            <td>거래게시판</td>
            <td>7,254</td>
            <td>10,248</td>
            <td>356,478</td>
            <td>45</td>
          </tr>
          <tr>
            <td>공지사항</td>
            <td>1,262</td>
            <td>2,105</td>
            <td>44,252</td>
            <td>12</td>
          </tr>
        </table>
      </div>
    </div>

    <!-- 신고유형 분석 탭 콘텐츠 -->
    <div class="tab-content" id="report-analysis">
      <!-- 통계 카드 -->
      <div class="statistics-cards">
        <div class="statistic-card">
          <h3>전체 신고 수</h3>
          <div class="value">1,854</div>
          <div class="change negative">-5.2% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>게시글 신고</h3>
          <div class="value">627</div>
          <div class="change negative">-8.7% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>댓글 신고</h3>
          <div class="value">1,227</div>
          <div class="change negative">-3.4% 전월 대비</div>
        </div>
        <div class="statistic-card">
          <h3>가장 많은 신고 유형</h3>
          <div class="value">욕설/비방</div>
          <div class="change">전체의 48%</div>
        </div>
      </div>

      <!-- 신고유형 분석 차트 -->
      <div class="chart-container">
        <!-- 차트가 들어갈 자리 (실제 구현 시 차트 라이브러리 사용) -->
        <img src="/api/placeholder/800/350" alt="신고유형 분석 차트 예시" style="width: 100%; height: 100%; object-fit: contain;">
      </div>

      <!-- 신고유형 분석 테이블 -->
      <div class="statistics-table">
        <table>
          <tr>
            <th>신고유형</th>
            <th>게시글 신고수</th>
            <th>댓글 신고수</th>
            <th>총 신고수</th>
            <th>비율</th>
          </tr>
          <tr>
            <td><span class="report-type-badge type-abuse">욕설/비방</span></td>
            <td>325</td>
            <td>564</td>
            <td>889</td>
            <td>48.0%</td>
          </tr>
          <tr>
            <td><span class="report-type-badge type-spam">스팸</span></td>
            <td>142</td>
            <td>287</td>
            <td>429</td>
            <td>23.1%</td>
          </tr>
          <tr>
            <td><span class="report-type-badge type-adult">음란물</span></td>
            <td>85</td>
            <td>187</td>
            <td>272</td>
            <td>14.7%</td>
          </tr>
          <tr>
            <td><span class="report-type-badge type-etc">광고</span></td>
            <td>43</td>
            <td>114</td>
            <td>157</td>
            <td>8.5%</td>
          </tr>
          <tr>
            <td><span class="report-type-badge type-etc">저작권 위반</span></td>
            <td>32</td>
            <td>75</td>
            <td>107</td>
            <td>5.8%</td>
          </tr>
        </table>
      </div>
    </div>

    <!-- 신규 게시글 현황 탭 콘텐츠 -->
    <div class="tab-content" id="new-posts">
      <!-- 통계 카드 -->
      <div class="statistics-cards">
        <div class="statistic-card">
          <h3>오늘 신규 게시글</h3>
          <div class="value">243</div>
          <div class="change positive">+18.5% 어제 대비</div>
        </div>
        <div class="statistic-card">
          <h3>오늘 신규 댓글</h3>
          <div class="value">867</div>
          <div class="change positive">+12.3% 어제 대비</div>
        </div>
        <div class="statistic-card">
          <h3>최근 7일 평균</h3>
          <div class="value">215 게시글/일</div>
          <div class="change positive">+7.8% 전주 대비</div>
        </div>
        <div class="statistic-card">
          <h3>신규 게시글 최다 게시판</h3>
          <div class="value">자유게시판</div>
          <div class="change">오늘 86개 게시글</div>
        </div>
      </div>

      <!-- 신규 게시글 추이 차트 -->
      <div class="chart-container">
        <!-- 차트가 들어갈 자리 (실제 구현 시 차트 라이브러리 사용) -->
        <img src="/api/placeholder/800/350" alt="신규 게시글 추이 차트 예시" style="width: 100%; height: 100%; object-fit: contain;">
      </div>

      <!-- 신규 게시글 현황 테이블 -->
      <div class="statistics-table">
        <table>
          <tr>
            <th>게시판명</th>
            <th>신규 게시글수</th>
            <th>전일 대비</th>
            <th>주간 평균 대비</th>
          </tr>
          <tr>
            <td>자유게시판</td>
            <td>86</td>
            <td class="change positive">+15.2%</td>
            <td class="change positive">+8.7%</td>
          </tr>
          <tr>
            <td>장비리뷰</td>
            <td>52 <span class="new-marker">NEW</span></td>
            <td class="change positive">+22.4%</td>
            <td class="change positive">+18.3%</td>
          </tr>
          <tr>
            <td>질문과답변</td>
            <td>48</td>
            <td class="change positive">+10.5%</td>
            <td class="change positive">+5.2%</td>
          </tr>
          <tr>
            <td>거래게시판</td>
            <td>43</td>
            <td class="change positive">+8.2%</td>
            <td class="change positive">+2.8%</td>
          </tr>
          <tr>
            <td>공지사항</td>
            <td>14</td>
            <td class="change positive">+16.7%</td>
            <td class="change positive">+7.9%</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  // 드롭다운 메뉴 기능 구현
  const menuButtons = document.querySelectorAll('.menu-button');

  menuButtons.forEach(button => {
    button.addEventListener('click', function() {
      this.classList.toggle('active');
      const submenu = this.nextElementSibling;

      if (submenu.style.maxHeight) {
        submenu.style.maxHeight = null;
      } else {
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
      }
    });
  });

  // 탭 전환 기능
  const tabButtons = document.querySelectorAll('.tab-btn');
  const tabContents = document.querySelectorAll('.tab-content');

  tabButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 모든 탭 버튼에서 active 클래스 제거
      tabButtons.forEach(btn => btn.classList.remove('active'));
      // 현재 클릭한 버튼에 active 클래스 추가
      this.classList.add('active');

      // 모든 탭 콘텐츠 숨기기
      tabContents.forEach(content => content.classList.remove('active'));
      // 클릭한 탭에 해당하는 콘텐츠 표시
      const tabId = this.getAttribute('data-tab');
      document.getElementById(tabId).classList.add('active');
    });
  });

  // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
  document.querySelectorAll('.menu-button.active').forEach(button => {
    const submenu = button.nextElementSibling;
    submenu.style.maxHeight = submenu.scrollHeight + 'px';
  });

  // 데이터 다운로드 기능
  document.querySelector('.download-btn').addEventListener('click', function() {
    alert('통계 데이터가 Excel 파일로 다운로드됩니다.');
    // 실제 구현 시 서버에 AJAX 요청하여 파일 다운로드 처리
  });
</script>
</body>
</html></title>
</head>
<body>

</body>
</html>
