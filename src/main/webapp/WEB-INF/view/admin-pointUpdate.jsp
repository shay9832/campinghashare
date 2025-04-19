<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 시스템 - 포인트 관리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-pointUpdate.css">
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

  <!-- 콘텐츠 영역 -->
  <div id="content">
    <!-- 콘텐츠 헤더 -->
    <div class="content-header">
      <h2>포인트 관리</h2>
    </div>

    <!-- 포인트 정보 요약 -->
    <div class="point-summary">
      <div class="total-users">
        <div class="summary-title">전체 회원 수</div>
        <div class="summary-value">12,458 명</div>
      </div>
      <div class="total-points">
        <div class="summary-title">전체 포인트 합계</div>
        <div class="summary-value">3,782,450 P</div>
      </div>
      <div class="points-today">
        <div class="summary-title">오늘 발생 포인트</div>
        <div class="summary-value">+24,750 P</div>
      </div>
    </div>

    <!-- 포인트 차트 영역 -->
    <div class="point-chart">
      <div class="chart-title">포인트 변동 추이</div>
      <div class="chart-container">
        <!-- 여기에 차트 표시 (실제 구현 시 차트 라이브러리 사용) -->
        <div style="text-align: center; padding-top: 120px; color: #888;">포인트 변동 추이 차트가 이곳에 표시됩니다.</div>
      </div>
    </div>

    <!-- 검색 영역 -->
    <div class="content-search-info">
      <span>포인트 유형</span>
      <select id="point-type-filter">
        <option value="all">전체</option>
        <option value="post">게시글 작성</option>
        <option value="popular">인기글 지정</option>
        <option value="event">이벤트 응모</option>
        <option value="report-post">게시글 신고</option>
        <option value="report-comment">댓글 신고</option>
        <option value="report-rental">렌탈 댓글 신고</option>
      </select>

      <span>변동 유형</span>
      <select id="change-type-filter">
        <option value="all">전체</option>
        <option value="increase">증가</option>
        <option value="decrease">감소</option>
      </select>

      <!-- 날짜 범위 선택 -->
      <div class="content-search-date">
        <input type="date" id="start-date-filter">
        <span>~</span>
        <input type="date" id="end-date-filter">
      </div>

      <!-- 검색어 입력 -->
      <div class="content-search-bar">
        <input type="search" id="search-input" placeholder="회원코드/이름 검색">
      </div>

      <!-- 검색 버튼 -->
      <div class="content-search-btn">
        <input type="button" id="search-btn" value="검색하기">
      </div>
    </div>

    <!-- 버튼 그룹 -->
    <div class="button-group">
      <button class="btn btn-primary" id="add-point-btn">포인트 지급</button>
      <button class="btn btn-info" id="export-excel-btn">엑셀 다운로드</button>
    </div>

    <!-- 탭 컨테이너 -->
    <div class="tab-container">
      <div class="tab-button-group">
        <button type="button" class="tab-button active" data-tab="all-point-tab">전체 내역</button>
        <button type="button" class="tab-button" data-tab="popular-point-tab">인기글 포인트</button>
        <button type="button" class="tab-button" data-tab="event-point-tab">이벤트 포인트</button>
        <button type="button" class="tab-button" data-tab="report-point-tab">신고 포인트</button>
      </div>

      <!-- 전체 내역 탭 -->
      <div id="all-point-tab" class="tab-content active">
        <div class="point-table">
          <table>
            <tr>
              <th class="col-member-code">회원 코드</th>
              <th class="col-member-name">회원 이름</th>
              <th class="col-point-type">포인트 변동 유형</th>
              <th class="col-point-change">변동 포인트</th>
              <th class="col-date">생성일</th>
              <th class="col-reference-id">이벤트 응모 ID</th>
              <th class="col-reference-id">이벤트 응모 포인트</th>
              <th class="col-actions">관리</th>
            </tr>

            <tr>
              <td>MEMBER004</td>
              <td>이철수</td>
              <td>이벤트 응모</td>
              <td class="point-positive">+100</td>
              <td>2023-04-16 11:38:55</td>
              <td>EVENT12345</td>
              <td>100</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>

            <tr>
              <td>MEMBER009</td>
              <td>정다영</td>
              <td>이벤트 응모</td>
              <td class="point-positive">+50</td>
              <td>2023-04-18 13:42:28</td>
              <td>EVENT12346</td>
              <td>50</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="pagination-btn">«</button>
          <button class="pagination-btn active">1</button>
          <button class="pagination-btn">»</button>
        </div>
      </div>


      <!-- 인기글 포인트 탭 -->
      <div id="popular-point-tab" class="tab-content">
        <div class="point-table">
          <table>
            <tr>
              <th class="col-member-code">회원 코드</th>
              <th class="col-member-name">회원 이름</th>
              <th class="col-point-type">포인트 변동 유형</th>
              <th class="col-point-change">변동 포인트</th>
              <th class="col-date">생성일</th>
              <th class="col-reference-id">인기글 지정 로그 ID</th>
              <th class="col-actions">관리</th>
            </tr>

            <tr>
              <td>MEMBER003</td>
              <td>김영희</td>
              <td>인기글 지정</td>
              <td class="point-positive">+50</td>
              <td>2023-04-16 09:15:42</td>
              <td>POP78901</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>

            <tr>
              <td>MEMBER008</td>
              <td>장현우</td>
              <td>인기글 지정</td>
              <td class="point-positive">+50</td>
              <td>2023-04-18 11:25:17</td>
              <td>POP78902</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="pagination-btn">«</button>
          <button class="pagination-btn active">1</button>
          <button class="pagination-btn">»</button>
        </div>
      </div>

      <!-- 이벤트 포인트 탭 -->
      <div id="event-point-tab" class="tab-content">
        <div class="point-table">
          <table>
            <tr>
              <th class="col-member-code">회원 코드</th>
              <th class="col-member-name">회원 이름</th>
              <th class="col-point-type">포인트 변동 유형</th>
              <th class="col-point-change">변동 포인트</th>
              <th class="col-date">생성일</th>
              <th class="col-reference-id">이벤트 응모 ID</th>
              <th class="col-reference-id">이벤트 응모 포인트</th>
              <th class="col-actions">관리</th>
            </tr>

            <tr>
              <td>MEMBER004</td>
              <td>이철수</td>
              <td>이벤트 응모</td>
              <td class="point-positive">+100</td>
              <td>2023-04-16 11:38:55</td>
              <td>EVENT12345</td>
              <td>100</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>

            <tr>
              <td>MEMBER009</td>
              <td>정다영</td>
              <td>이벤트 응모</td>
              <td class="point-positive">+50</td>
              <td>2023-04-18 13:42:28</td>
              <td>EVENT12346</td>
              <td>50</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="pagination-btn">«</button>
          <button class="pagination-btn active">1</button>
          <button class="pagination-btn">»</button>
        </div>
      </div>

      <!-- 신고 포인트 탭 -->
      <div id="report-point-tab" class="tab-content">
        <div class="point-table">
          <table>
            <tr>
              <th class="col-member-code">회원 코드</th>
              <th class="col-member-name">회원 이름</th>
              <th class="col-point-type">포인트 변동 유형</th>
              <th class="col-point-change">변동 포인트</th>
              <th class="col-date">생성일</th>
              <th class="col-reference-id">신고 접수 ID</th>
              <th class="col-reference-id">신고 처리 유형</th>
              <th class="col-actions">관리</th>
            </tr>

            <tr>
              <td>MEMBER005</td>
              <td>박민지</td>
              <td>게시글 신고</td>
              <td class="point-negative">-5</td>
              <td>2023-04-17 10:24:33</td>
              <td>REPORT23456</td>
              <td>부적절한 내용</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>

            <tr>
              <td>MEMBER010</td>
              <td>최준호</td>
              <td>댓글 신고</td>
              <td class="point-negative">-3</td>
              <td>2023-04-18 15:17:42</td>
              <td>REPORT23457</td>
              <td>욕설/비방</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>

            <tr>
              <td>MEMBER011</td>
              <td>김서연</td>
              <td>렌탈 댓글 신고</td>
              <td class="point-negative">-3</td>
              <td>2023-04-19 09:28:15</td>
              <td>REPORT23458</td>
              <td>광고/스팸</td>
              <td><button class="btn btn-primary action-btn view-detail-btn">상세</button></td>
            </tr>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="pagination-btn">«</button>
          <button class="pagination-btn active">1</button>
          <button class="pagination-btn">»</button>
        </div>
      </div>
    </div>

    <!-- 포인트 상세 모달 -->
    <div id="point-detail-modal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>포인트 상세 정보</h3>
          <span class="close-modal">&times;</span>
        </div>
        <div class="modal-body">
          <form id="point-detail-form">
            <div class="form-group">
              <label for="member-code">회원 코드</label>
              <input type="text" id="member-code" class="form-control" disabled>
            </div>

            <div class="form-group">
              <label for="member-name">회원 이름</label>
              <input type="text" id="member-name" class="form-control" disabled>
            </div>

            <div class="form-group">
              <label for="point-type">포인트 변동 유형</label>
              <input type="text" id="point-type" class="form-control" disabled>
            </div>

            <div class="form-group">
              <label for="point-change">변동 포인트</label>
              <input type="text" id="point-change" class="form-control" disabled>
            </div>

            <div class="form-group">
              <label for="created-date">생성일</label>
              <input type="text" id="created-date" class="form-control" disabled>
            </div>

            <div class="form-group">
              <label for="reference-id">참조 ID</label>
              <input type="text" id="reference-id" class="form-control" disabled>
            </div>

            <div id="additional-fields">
              <!-- 포인트 유형에 따라 추가 필드가 동적으로 생성됨 -->
            </div>

            <div class="form-group">
              <label for="point-memo">메모</label>
              <textarea id="point-memo" class="form-control" rows="3" disabled></textarea>
            </div>

            <div class="form-actions">
              <button type="button" class="btn btn-info" id="view-related-btn">관련 항목 보기</button>
              <button type="button" class="btn btn-primary" id="close-detail-btn">닫기</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 포인트 지급 모달 -->
    <div id="add-point-modal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>포인트 지급</h3>
          <span class="close-modal">&times;</span>
        </div>
        <div class="modal-body">
          <form id="add-point-form">
            <div class="form-group">
              <label for="target-member-code">대상 회원 코드</label>
              <input type="text" id="target-member-code" class="form-control" placeholder="회원 코드 입력">
            </div>

            <div class="form-group">
              <label for="target-member-name">대상 회원 이름</label>
              <input type="text" id="target-member-name" class="form-control" placeholder="회원 이름 입력">
            </div>

            <div class="form-group">
              <label for="add-point-type">포인트 유형</label>
              <select id="add-point-type" class="form-control">
                <option value="manual">수동 지급</option>
                <option value="event">이벤트 보상</option>
                <option value="compensation">보상 지급</option>
              </select>
            </div>

            <div class="form-group">
              <label for="point-amount">지급 포인트</label>
              <input type="number" id="point-amount" class="form-control" placeholder="포인트 입력">
            </div>

            <div class="form-group">
              <label for="add-point-memo">지급 사유</label>
              <textarea id="add-point-memo" class="form-control" rows="3" placeholder="지급 사유 입력"></textarea>
            </div>

            <div class="form-actions">
              <button type="button" class="btn btn-primary" id="cancel-add-point-btn">취소</button>
              <button type="submit" class="btn btn-primary" id="submit-add-point-btn">지급하기</button>
            </div>
          </form>
        </div>
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

  // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
  document.querySelectorAll('.menu-button.active').forEach(button => {
    const submenu = button.nextElementSibling;
    submenu.style.maxHeight = submenu.scrollHeight + 'px';
  });

  // 탭 전환 기능
  const tabButtons = document.querySelectorAll('.tab-button');
  tabButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 모든 탭 버튼 비활성화
      tabButtons.forEach(btn => btn.classList.remove('active'));

      // 현재 버튼 활성화
      this.classList.add('active');

      // 모든 탭 콘텐츠 숨기기
      const tabContents = document.querySelectorAll('.tab-content');
      tabContents.forEach(content => content.classList.remove('active'));

      // 선택한 탭 콘텐츠 표시
      const tabId = this.getAttribute('data-tab');
      document.getElementById(tabId).classList.add('active');
    });
  });

  // 모달 관련 변수
  const pointDetailModal = document.getElementById('point-detail-modal');
  const addPointModal = document.getElementById('add-point-modal');
  const closeModalButtons = document.querySelectorAll('.close-modal');

  // 모달 닫기 버튼
  closeModalButtons.forEach(button => {
    button.addEventListener('click', function() {
      pointDetailModal.style.display = 'none';
      addPointModal.style.display = 'none';
    });
  });

  // 모달 외부 클릭 시 닫기
  window.addEventListener('click', function(event) {
    if (event.target === pointDetailModal) {
      pointDetailModal.style.display = 'none';
    }
    if (event.target === addPointModal) {
      addPointModal.style.display = 'none';
    }
  });

  // 포인트 상세 모달 닫기 버튼
  document.getElementById('close-detail-btn').addEventListener('click', function() {
    pointDetailModal.style.display = 'none';
  });

  // 포인트 지급 모달 취소 버튼
  document.getElementById('cancel-add-point-btn').addEventListener('click', function() {
    addPointModal.style.display = 'none';
  });

  // 포인트 지급 버튼 클릭 시 모달 표시
  document.getElementById('add-point-btn').addEventListener('click', function() {
    // 모달 초기화
    document.getElementById('target-member-code').value = '';
    document.getElementById('target-member-name').value = '';
    document.getElementById('add-point-type').value = 'manual';
    document.getElementById('point-amount').value = '';
    document.getElementById('add-point-memo').value = '';

    // 모달 표시
    addPointModal.style.display = 'block';
  });

  // 포인트 지급 폼 제출
  document.getElementById('add-point-form').addEventListener('submit', function(event) {
    event.preventDefault();

    const targetMemberCode = document.getElementById('target-member-code').value;
    const targetMemberName = document.getElementById('target-member-name').value;
    const pointType = document.getElementById('add-point-type').value;
    const pointAmount = document.getElementById('point-amount').value;
    const pointMemo = document.getElementById('add-point-memo').value;

    // 폼 유효성 검사
    if (!targetMemberCode || !targetMemberName || !pointAmount) {
      alert('대상 회원 정보와 지급 포인트를 입력해주세요.');
      return;
    }

    // 실제 구현에서는 서버로 데이터를 전송하는 AJAX 요청을 구현
    console.log({
      action: '포인트 지급',
      targetMemberCode,
      targetMemberName,
      pointType,
      pointAmount,
      pointMemo
    });

    // 성공 메시지 표시
    alert('포인트가 성공적으로 지급되었습니다.');

    // 모달 닫기
    addPointModal.style.display = 'none';
  });

  // 엑셀 다운로드 버튼 클릭 이벤트
  document.getElementById('export-excel-btn').addEventListener('click', function() {
    // 실제 구현에서는 서버에 요청을 보내 엑셀 파일을 생성하고 다운로드
    alert('포인트 내역 엑셀 파일이 다운로드됩니다.');
  });

  // 포인트 상세 보기 버튼 클릭 시 모달 표시
  const viewDetailButtons = document.querySelectorAll('.view-detail-btn');
  viewDetailButtons.forEach(button => {
    button.addEventListener('click', function() {
      const row = this.closest('tr');
      const memberCode = row.cells[0].textContent;
      const memberName = row.cells[1].textContent;
      const pointType = row.cells[2].textContent;
      const pointChange = row.cells[3].textContent;
      const createdDate = row.cells[4].textContent;
      const referenceId = row.cells[5].textContent;

      // 모달 폼에 데이터 설정
      document.getElementById('member-code').value = memberCode;
      document.getElementById('member-name').value = memberName;
      document.getElementById('point-type').value = pointType;
      document.getElementById('point-change').value = pointChange;
      document.getElementById('created-date').value = createdDate;
      document.getElementById('reference-id').value = referenceId;

      // 추가 필드 컨테이너 비우기
      const additionalFieldsContainer = document.getElementById('additional-fields');
      additionalFieldsContainer.innerHTML = '';

      // 포인트 유형에 따라 다른 추가 필드 표시
      switch(pointType) {
        case '게시글 작성':
          // 게시글 관련 필드 추가
          break;
        case '인기글 지정':
          // 인기글 관련 필드 추가
          break;
        case '이벤트 응모':
          // 이벤트 응모 관련 필드 추가
          if (row.cells.length > 6) {
            additionalFieldsContainer.innerHTML = `
              <div class="form-group">
                <label for="event-point">이벤트 응모 포인트</label>
                <input type="text" id="event-point" class="form-control" value="${row.cells[6].textContent}" disabled>
              </div>
            `;
          }
          break;
        case '게시글 신고':
        case '댓글 신고':
        case '렌탈 댓글 신고':
          // 신고 관련 필드 추가
          if (row.cells.length > 6) {
            additionalFieldsContainer.innerHTML = `
              <div class="form-group">
                <label for="report-type">신고 처리 유형</label>
                <input type="text" id="report-type" class="form-control" value="${row.cells[6].textContent}" disabled>
              </div>
            `;
          }
          break;
      }

      // 메모 설정 (실제 데이터에서는 서버에서 가져올 것)
      document.getElementById('point-memo').value = "시스템에서 자동으로 발생한 포인트입니다.";

      // 모달 표시
      pointDetailModal.style.display = 'block';
    });
  });

  // 관련 항목 보기 버튼 클릭 이벤트
  document.getElementById('view-related-btn').addEventListener('click', function() {
    const pointType = document.getElementById('point-type').value;
    const referenceId = document.getElementById('reference-id').value;

    // 실제 구현에서는 유형에 따라 해당하는 페이지로 이동하거나 새 창에서 표시
    alert(`${pointType} 관련 항목 (ID: ${referenceId}) 상세 페이지로 이동합니다.`);
  });

  // 검색 기능
  document.getElementById('search-btn').addEventListener('click', function() {
    const pointType = document.getElementById('point-type-filter').value;
    const changeType = document.getElementById('change-type-filter').value;
    const startDate = document.getElementById('start-date-filter').value;
    const endDate = document.getElementById('end-date-filter').value;
    const searchText = document.getElementById('search-input').value;

    // 실제 구현에서는 서버에 검색 요청을 보내고 결과를 받아 처리
    console.log({
      action: '포인트 내역 검색',
      pointType,
      changeType,
      startDate,
      endDate,
      searchText
    });

    // 검색 결과에 따라 UI 업데이트 (예시)
    alert('검색 조건에 맞는 포인트 내역을 조회합니다.');
  });

  // 페이지네이션 버튼 클릭 이벤트
  const paginationButtons = document.querySelectorAll('.pagination-btn');
  paginationButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 페이지 버튼이 아닌 경우 (이전/다음 페이지)
      if (this.textContent === '«' || this.textContent === '»') {
        // 이전/다음 페이지 로직 처리
        return;
      }

      // 현재 활성화된 페이지 버튼 비활성화
      document.querySelector('.pagination-btn.active').classList.remove('active');

      // 클릭한 페이지 버튼 활성화
      this.classList.add('active');

      // 실제 구현에서는 서버에 해당 페이지 데이터 요청
      const page = this.textContent;
      console.log({
        action: '페이지 이동',
        page
      });
    });
  });
</script>
</body>
</html>
