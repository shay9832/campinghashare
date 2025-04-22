<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 시스템 - 이벤트 관리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-eventUpdate.css">
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

  <!-- 콘텐츠 영역 - 실제 데이터와 컨트롤이 표시되는 부분 -->
  <div id="content">
    <!-- 콘텐츠 헤더 - 페이지 제목 -->
    <div class="content-header">
      <h2>이벤트 관리</h2>
      <div class="view-toggle">
        <button id="listViewBtn" class="active">리스트 뷰</button>
        <button id="albumViewBtn">앨범 뷰</button>
      </div>
    </div>

    <!-- 검색 영역 - 이벤트 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>검색유형</span>
      <select>
        <option>이벤트ID</option>
        <option>이벤트명</option>
        <option>관리자ID</option>
      </select>

      <!-- 이벤트 상태 선택 -->
      <span>이벤트상태</span>
      <select>
        <option>전체</option>
        <option>진행 중</option>
        <option>예정</option>
        <option>종료</option>
      </select>

      <!-- 날짜 범위 선택 -->
      <div class="content-search-date">
        <input type="date">
        <span>~</span>
        <input type="date">
      </div>

      <!-- 검색어 입력 -->
      <div class="content-search-bar">
        <input type="search" placeholder="검색어 입력">
      </div>

      <!-- 검색 버튼 -->
      <div class="content-search-btn">
        <input type="button" value="검색하기">
      </div>
    </div>

    <!-- 이벤트 정보 요약 - 주요 통계 -->
    <div class="event-count">
      <div class="event-all">
        <span>전체 이벤트 : 48개</span>
      </div>
      <div class="event-active">
        <span>진행 중 이벤트 : 12개</span>
      </div>
      <div class="event-upcoming">
        <span>예정 이벤트 : 8개</span>
      </div>
      <div class="event-ended">
        <span>종료 이벤트 : 28개</span>
      </div>
    </div>

    <!-- 액션 버튼 영역 -->
    <div class="action-buttons">
      <button class="action-button">이벤트 등록</button>
      <button class="action-button">선택 이벤트 종료</button>
      <button class="action-button">일괄 처리</button>
    </div>

    <!-- 리스트 뷰 - 테이블 형태로 이벤트 목록 표시 -->
    <div class="event-table" id="listView">
      <table>
        <tr>
          <!-- 테이블 헤더 - 각 열의 제목 -->
          <th class="col-select"><input type="checkbox" id="selectAll"></th>
          <th class="col-event-id">이벤트ID</th>
          <th class="col-admin-id">관리자ID</th>
          <th class="col-event-name">이벤트명</th>
          <th class="col-start-date">시작일</th>
          <th class="col-end-date">종료일</th>
          <th class="col-participants">참가자수</th>
          <th class="col-points">응모포인트</th>
          <th class="col-status">상태</th>
          <th class="col-actions">작업</th>
        </tr>

        <!-- 임박한 이벤트 행 - 배경색이 다름 -->
        <tr class="urgent-row">
          <td><input type="checkbox"></td>
          <td>EV0001</td>
          <td>admin_park</td>
          <td>봄맞이 장비 할인 이벤트</td>
          <td>2025-03-15</td>
          <td>2025-04-08</td> <!-- 임박한 종료일 -->
          <td>234</td>
          <td>500</td>
          <td><span class="status-badge status-urgent">임박</span></td>
          <td>
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0001')">참가자</button>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">종료</button>
          </td>
        </tr>

        <!-- 진행 중인 이벤트 행 -->
        <tr>
          <td><input type="checkbox"></td>
          <td>EV0002</td>
          <td>admin_kim</td>
          <td>신규 회원 웰컴 이벤트</td>
          <td>2025-03-20</td>
          <td>2025-04-20</td>
          <td>156</td>
          <td>300</td>
          <td><span class="status-badge status-active">진행 중</span></td>
          <td>
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0002')">참가자</button>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">종료</button>
          </td>
        </tr>

        <!-- 진행 중인 이벤트 행 -->
        <tr>
          <td><input type="checkbox"></td>
          <td>EV0003</td>
          <td>admin_lee</td>
          <td>포토 리뷰 이벤트</td>
          <td>2025-03-25</td>
          <td>2025-04-30</td>
          <td>87</td>
          <td>200</td>
          <td><span class="status-badge status-active">진행 중</span></td>
          <td>
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0003')">참가자</button>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">종료</button>
          </td>
        </tr>

        <!-- 예정된 이벤트 행 -->
        <tr>
          <td><input type="checkbox"></td>
          <td>EV0004</td>
          <td>admin_park</td>
          <td>서핑 장비 체험 이벤트</td>
          <td>2025-05-01</td>
          <td>2025-05-31</td>
          <td>0</td>
          <td>1000</td>
          <td><span class="status-badge status-upcoming">예정</span></td>
          <td>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">취소</button>
          </td>
        </tr>

        <!-- 종료된 이벤트 행 -->
        <tr>
          <td><input type="checkbox"></td>
          <td>EV0005</td>
          <td>admin_kim</td>
          <td>겨울 스포츠 장비 특가 이벤트</td>
          <td>2025-01-10</td>
          <td>2025-02-28</td>
          <td>453</td>
          <td>300</td>
          <td><span class="status-badge status-ended">종료</span></td>
          <td>
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0005')">참가자</button>
            <button class="action-btn">결과보기</button>
          </td>
        </tr>
      </table>
    </div>

    <!-- 앨범 뷰 - 카드 형태로 이벤트 목록 표시 -->
    <div class="event-grid" id="albumView">
      <!-- 임박한 이벤트 카드 -->
      <div class="event-card urgent">
        <div class="event-card-header">
          <img src="/api/placeholder/300/160" alt="이벤트 썸네일" class="event-card-thumbnail">
          <div class="event-card-overlay">
            <div class="event-card-title">봄맞이 장비 할인 이벤트</div>
            <div class="event-card-status">
              <span class="status-badge status-urgent">임박</span>
            </div>
          </div>
        </div>
        <div class="event-card-body">
          <div class="event-card-info">
            <div class="event-card-info-item">
              <div class="event-card-info-label">이벤트 ID</div>
              <div class="event-card-info-value">EV0001</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">관리자</div>
              <div class="event-card-info-value">admin_park</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">기간</div>
              <div class="event-card-info-value">2025-03-15 ~ 2025-04-08</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">참가자</div>
              <div class="event-card-info-value">234명</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">응모포인트</div>
              <div class="event-card-info-value">500점</div>
            </div>
          </div>
          <div class="event-card-actions">
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0001')">참가자</button>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">종료</button>
          </div>
        </div>
      </div>

      <!-- 진행 중인 이벤트 카드 -->
      <div class="event-card">
        <div class="event-card-header">
          <img src="/api/placeholder/300/160" alt="이벤트 썸네일" class="event-card-thumbnail">
          <div class="event-card-overlay">
            <div class="event-card-title">신규 회원 웰컴 이벤트</div>
            <div class="event-card-status">
              <span class="status-badge status-active">진행 중</span>
            </div>
          </div>
        </div>
        <div class="event-card-body">
          <div class="event-card-info">
            <div class="event-card-info-item">
              <div class="event-card-info-label">이벤트 ID</div>
              <div class="event-card-info-value">EV0002</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">관리자</div>
              <div class="event-card-info-value">admin_kim</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">기간</div>
              <div class="event-card-info-value">2025-03-20 ~ 2025-04-20</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">참가자</div>
              <div class="event-card-info-value">156명</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">응모포인트</div>
              <div class="event-card-info-value">300점</div>
            </div>
          </div>
          <div class="event-card-actions">
            <button class="action-btn view-btn" onclick="openParticipantModal('EV0002')">참가자</button>
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">종료</button>
          </div>
        </div>
      </div>

      <!-- 예정된 이벤트 카드 -->
      <div class="event-card">
        <div class="event-card-header">
          <img src="/api/placeholder/300/160" alt="이벤트 썸네일" class="event-card-thumbnail">
          <div class="event-card-overlay">
            <div class="event-card-title">서핑 장비 체험 이벤트</div>
            <div class="event-card-status">
              <span class="status-badge status-upcoming">예정</span>
            </div>
          </div>
        </div>
        <div class="event-card-body">
          <div class="event-card-info">
            <div class="event-card-info-item">
              <div class="event-card-info-label">이벤트 ID</div>
              <div class="event-card-info-value">EV0004</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">관리자</div>
              <div class="event-card-info-value">admin_park</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">기간</div>
              <div class="event-card-info-value">2025-05-01 ~ 2025-05-31</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">참가자</div>
              <div class="event-card-info-value">0명</div>
            </div>
            <div class="event-card-info-item">
              <div class="event-card-info-label">응모포인트</div>
              <div class="event-card-info-value">1000점</div>
            </div>
          </div>
          <div class="event-card-actions">
            <button class="action-btn">수정</button>
            <button class="action-btn delete-btn">취소</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 참가자 모달 -->
<div id="participantModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h3 class="modal-title">이벤트 참가자 목록</h3>
      <span class="modal-close">&times;</span>
    </div>
    <table class="participant-table">
      <thead>
      <tr>
        <th>회원코드</th>
        <th>회원닉네임</th>
        <th>응모포인트</th>
        <th>응모일</th>
      </tr>
      </thead>
      <tbody id="participantList">
      <!-- 참가자 데이터는 자바스크립트로 동적 로드 -->
      <tr>
        <td>USER1234</td>
        <td>산악인</td>
        <td>500</td>
        <td>2025-03-16</td>
      </tr>
      <tr>
        <td>USER2345</td>
        <td>바다사랑</td>
        <td>500</td>
        <td>2025-03-17</td>
      </tr>
      <tr>
        <td>USER3456</td>
        <td>캠핑왕</td>
        <td>500</td>
        <td>2025-03-18</td>
      </tr>
      <tr>
        <td>USER4567</td>
        <td>등산꾼</td>
        <td>500</td>
        <td>2025-03-20</td>
      </tr>
      <tr>
        <td>USER5678</td>
        <td>서핑마스터</td>
        <td>500</td>
        <td>2025-03-22</td>
      </tr>
      </tbody>
    </table>
  </div>
</div>

<script>
  // DOM이 완전히 로드된 후에 실행
  document.addEventListener('DOMContentLoaded', function() {
    // 초기 설정
    initializeMenuToggle();
    initializeCheckboxes();
    initializeViewToggle();
    initializeModalHandlers();
    initializeButtonHandlers();
    highlightUrgentEvents();
  });

  // 드롭다운 메뉴 기능 구현
  function initializeMenuToggle() {
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

    // 활성화된 메뉴 자동 펼침
    const activeMenuButton = document.querySelector('.menu-button.active');
    if (activeMenuButton) {
      const submenu = activeMenuButton.nextElementSibling;
      submenu.style.maxHeight = submenu.scrollHeight + 'px';
    }
  }

  // 체크박스 전체 선택 기능 구현
  function initializeCheckboxes() {
    const selectAllCheckbox = document.getElementById('selectAll');
    if (!selectAllCheckbox) return; // 요소가 없으면 함수 종료

    const checkboxes = document.querySelectorAll('.event-table input[type="checkbox"]:not(#selectAll)');

    selectAllCheckbox.addEventListener('change', function() {
      checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
      });
    });

    checkboxes.forEach(checkbox => {
      checkbox.addEventListener('change', function() {
        const allChecked = Array.from(checkboxes).every(cb => cb.checked);
        selectAllCheckbox.checked = allChecked;
      });
    });
  }

  // 뷰 모드 전환 기능
  function initializeViewToggle() {
    const listViewBtn = document.getElementById('listViewBtn');
    const albumViewBtn = document.getElementById('albumViewBtn');
    const listView = document.getElementById('listView');
    const albumView = document.getElementById('albumView');

    if (!listViewBtn || !albumViewBtn || !listView || !albumView) return; // 요소가 없으면 함수 종료

    // 초기 뷰 설정
    listView.style.display = 'block';
    albumView.style.display = 'none';

    listViewBtn.addEventListener('click', function() {
      listView.style.display = 'block';
      albumView.style.display = 'none';
      listViewBtn.classList.add('active');
      albumViewBtn.classList.remove('active');
    });

    albumViewBtn.addEventListener('click', function() {
      listView.style.display = 'none';
      albumView.style.display = 'grid';
      albumViewBtn.classList.add('active');
      listViewBtn.classList.remove('active');
    });
  }

  // 모달 관련 기능 구현
  function initializeModalHandlers() {
    const modal = document.getElementById('participantModal');
    const closeBtn = document.querySelector('.modal-close');

    if (!modal || !closeBtn) return; // 요소가 없으면 함수 종료

    // 모달 닫기 버튼 이벤트
    closeBtn.addEventListener('click', function() {
      modal.style.display = 'none';
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
      if (event.target == modal) {
        modal.style.display = 'none';
      }
    });

    // 참가자 버튼 클릭 이벤트 위임 처리
    document.addEventListener('click', function(event) {
      if (event.target.classList.contains('js-participant-btn') ||
              event.target.parentElement.classList.contains('js-participant-btn')) {
        const button = event.target.classList.contains('js-participant-btn') ?
                event.target : event.target.parentElement;
        const eventId = button.getAttribute('data-event-id');
        openParticipantModal(eventId);
      }
    });
  }

  // 버튼 이벤트 처리 추가
  function initializeButtonHandlers() {
    // 이벤트 수정 버튼
    document.querySelectorAll('.js-edit-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const eventId = this.getAttribute('data-event-id');
        alert(`이벤트 수정 화면으로 이동합니다. (이벤트 ID: ${eventId})`);
      });
    });

    // 이벤트 종료 버튼
    document.querySelectorAll('.js-end-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const eventId = this.getAttribute('data-event-id');
        if (confirm(`[${eventId}] 이벤트를 종료하시겠습니까?`)) {
          alert(`이벤트가 종료되었습니다.`);
        }
      });
    });

    // 이벤트 취소 버튼
    document.querySelectorAll('.js-cancel-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const eventId = this.getAttribute('data-event-id');
        if (confirm(`[${eventId}] 이벤트를 취소하시겠습니까?`)) {
          alert(`이벤트가 취소되었습니다.`);
        }
      });
    });

    // 결과보기 버튼
    document.querySelectorAll('.js-results-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const eventId = this.getAttribute('data-event-id');
        alert(`이벤트 결과 화면으로 이동합니다. (이벤트 ID: ${eventId})`);
      });
    });

    // 액션 버튼 이벤트
    document.getElementById('createEventBtn').addEventListener('click', function() {
      alert('이벤트 등록 화면으로 이동합니다.');
    });

    document.getElementById('endSelectedEventsBtn').addEventListener('click', function() {
      const selectedCheckboxes = document.querySelectorAll('.event-table input[type="checkbox"]:checked:not(#selectAll)');
      if (selectedCheckboxes.length === 0) {
        alert('종료할 이벤트를 선택해주세요.');
        return;
      }

      if (confirm(`선택한 ${selectedCheckboxes.length}개의 이벤트를 종료하시겠습니까?`)) {
        alert('선택한 이벤트가 종료되었습니다.');
      }
    });

    document.getElementById('batchProcessBtn').addEventListener('click', function() {
      alert('일괄 처리 옵션을 선택해주세요.');
    });
  }

  // 참가자 모달 열기
  function openParticipantModal(eventId) {
    const modal = document.getElementById('participantModal');
    if (!modal) return; // 모달 요소가 없으면 함수 종료

    // 모달 표시
    modal.style.display = 'block';

    // 모달 제목 업데이트
    const modalTitle = document.querySelector('.modal-title');
    if (modalTitle) {
      modalTitle.textContent = `이벤트 참가자 목록 (${eventId})`;
    }

    // 여기서 실제로는 서버에서 참가자 데이터를 가져옵니다.
    // 현재는 예시 데이터만 표시
    loadParticipantData(eventId);
  }

  // 참가자 데이터 로드 함수 (실제로는 API 호출)
  function loadParticipantData(eventId) {
    // 예시 데이터
    const participantData = {
      'EV0001': [
        { code: 'USER1234', nickname: '산악인', points: 500, date: '2025-03-16' },
        { code: 'USER2345', nickname: '바다사랑', points: 500, date: '2025-03-17' },
        { code: 'USER3456', nickname: '캠핑왕', points: 500, date: '2025-03-18' },
        { code: 'USER4567', nickname: '등산꾼', points: 500, date: '2025-03-20' },
        { code: 'USER5678', nickname: '서핑마스터', points: 500, date: '2025-03-22' }
      ],
      'EV0002': [
        { code: 'USER1111', nickname: '신규회원1', points: 300, date: '2025-03-21' },
        { code: 'USER2222', nickname: '신규회원2', points: 300, date: '2025-03-22' },
        { code: 'USER3333', nickname: '신규회원3', points: 300, date: '2025-03-23' }
      ],
      'EV0003': [
        { code: 'USER5555', nickname: '사진작가', points: 200, date: '2025-03-26' },
        { code: 'USER6666', nickname: '여행러버', points: 200, date: '2025-03-27' }
      ],
      'EV0005': [
        { code: 'USER7777', nickname: '스키어', points: 300, date: '2025-01-15' },
        { code: 'USER8888', nickname: '보더', points: 300, date: '2025-01-20' },
        { code: 'USER9999', nickname: '겨울스포츠', points: 300, date: '2025-01-25' }
      ]
    };

    // 참가자 테이블 비우기
    const participantList = document.getElementById('participantList');
    participantList.innerHTML = '';

    // 해당 이벤트의 참가자 데이터가 있는 경우
    if (participantData[eventId]) {
      // 참가자 데이터 추가
      participantData[eventId].forEach(participant => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${participant.code}</td>
          <td>${participant.nickname}</td>
          <td>${participant.points}</td>
          <td>${participant.date}</td>
        `;
        participantList.appendChild(row);
      });
    } else {
      // 데이터가 없는 경우
      const row = document.createElement('tr');
      row.innerHTML = '<td colspan="4" style="text-align: center;">참가자가 없습니다.</td>';
      participantList.appendChild(row);
    }
  }

  // 이벤트 임박 강조 기능
  function highlightUrgentEvents() {
    try {
      const today = new Date();
      const rows = document.querySelectorAll('.event-table tr:not(:first-child)');

      rows.forEach(row => {
        // 테이블 셀이 존재하는지 확인
        const endDateCell = row.querySelector('td:nth-child(6)');
        if (!endDateCell) return; // 셀이 없으면 건너뛰기

        const endDateText = endDateCell.textContent;
        const endDate = new Date(endDateText);

        // 유효한 날짜인지 확인
        if (isNaN(endDate)) return; // 유효하지 않은 날짜면 건너뛰기

        const timeDiff = endDate - today;
        const daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

        if (daysDiff >= 0 && daysDiff <= 7) {
          // 종료일이 7일 이내인 경우 강조
          row.classList.add('urgent-row');
          const statusCell = row.querySelector('td:nth-child(9)');
          if (statusCell) {
            statusCell.innerHTML = '<span class="status-badge status-urgent">임박</span>';
          }
        }
      });
    } catch (error) {
      console.error('이벤트 강조 처리 중 오류 발생:', error);
    }
  }
</script>
</body>
</html>


