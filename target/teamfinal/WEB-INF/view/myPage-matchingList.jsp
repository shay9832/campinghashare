<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampingHaShare - 매칭 조회/내역</title>
  <!-- 외부 라이브러리 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
  <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
  <!-- 마이페이지 전용 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
  <!-- 마이페이지 사이드바 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
  <!-- 매칭 css 로드 (모달 스타일 위해) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/matching.css">
  <!-- 제이쿼리 사용 CDN 방식 -->
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

  <style>
    /* 탭 네비게이션 스타일 */
    .tab-nav {
      margin-right: 10px;
      margin-bottom: 10px;
    }

    .tab-link {
      display: inline-block;
      padding: 8px 16px;
      border-radius: 20px;
      text-decoration: none;
      color: #495057;
      background-color: #f8f9fa;
      transition: all 0.3s ease;
    }

    .tab-link:hover {
      background-color: #e9ecef;
    }

    .tab-nav .tab-link.active {
      color: var(--color-white);
      background-color: var(--color-maple);
    }

    /* 테이블 너무 긴 장비명 줄이기 */
    .custom-table .title-cell {
      max-width: 200px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: left;
    }
    /* 테이블 스타일 */
    .matching-table-container {
      width: 100%;
      margin-top: 20px;
      border-radius: 8px;
      overflow: auto;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .matching-table {
      width: 100%;
      border-collapse: collapse;
    }

    .matching-table .table {
      margin-bottom: 0;
    }

    /* 테이블 열 너비 조정 */
    .matching-table thead th:nth-child(1) { width: 7%; }  /* 스토렌/렌탈 ID */
    .matching-table thead th:nth-child(2) { width: 23%; } /* 제목 */
    .matching-table thead th:nth-child(3) { width: 8%; }  /* 장비코드 */
    .matching-table thead th:nth-child(4) { width: 18%; } /* 장비명 */
    .matching-table thead th:nth-child(5) { width: 12%; } /* 시작일 */
    .matching-table thead th:nth-child(6) { width: 12%; } /* 종료일 */
    .matching-table thead th:nth-child(7) { width: 8%; }  /* 매칭수 */
    .matching-table thead th:nth-child(8) { width: 12%; } /* 상태 */

    .matching-table thead th {
      background-color: #f5f8f5;
      border-bottom: 2px solid #2C5F2D;
      font-weight: 500;
      color: #555;
      padding: 12px 8px;
      vertical-align: middle;
      text-align: center;
      white-space: nowrap;
    }

    .matching-table tbody td {
      padding: 12px 8px;
      vertical-align: middle;
      text-align: center;
      border-bottom: 1px solid #e0e0e0;
    }

    .matching-row {
      transition: background-color 0.2s ease;
    }

    .matching-row:hover {
      background-color: #f9f9f9;
    }

    .matching-table .title-cell {
      text-align: left;
      padding-left: 15px;
    }

    .btn-sm {
      padding: 4px 10px;
      font-size: 13px;
      border-radius: 4px;
      border: 1px solid #ddd;
      background-color: white;
      color: #555;
      cursor: pointer;
      transition: all 0.2s ease;
      text-align: center;
    }

    .btn-sm:hover {
      background-color: #2C5F2D;
      color: white;
      border-color: #2C5F2D;
    }

    .btn-approve {
      background-color: #e8f5e8;
      color: #4caf50;
      border-color: #c8e6c9;
    }

    .btn-approve:hover {
      background-color: #4caf50;
      color: white;
      border-color: #4caf50;
    }

    .rental-title {
      color: #333;
      font-weight: 500;
    }

    .rental-link, .equipment-link, .user-link {
      color: #2C5F2D;
      text-decoration: none;
      transition: all 0.2s ease;
    }

    .rental-link:hover, .equipment-link:hover, .user-link:hover {
      color: #3f861d;
      text-decoration: underline;
    }

    .empty-state {
      text-align: center;
      padding: 40px 20px;
      background-color: #f9f9f9;
      border-radius: 8px;
      margin: 20px 0;
      color: #666;
    }

    .empty-state i {
      font-size: 48px;
      color: #ccc;
      margin-bottom: 15px;
    }

    .empty-state p {
      font-size: 16px;
      margin-bottom: 5px;
    }

    .empty-state .hint {
      font-size: 14px;
      color: #888;
    }

    /* 확장 행을 위한 스타일 */
    .content-box-sm {
      margin-bottom: 0;
    }
    .matching-row.rental-header {
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .matching-row.rental-header:hover {
      background-color: #f5f8f5;
    }

    .matching-row.rental-header.active {
      background-color: #f5f8f5;
      border-bottom: none;
    }

    .matching-row.rental-header .match-count {
      font-weight: 600;
      color: #3f861d;
    }

    .matching-details-container {
      padding: 15px 20px;
      background-color: #f9f9f9;
      border-radius: 0 0 8px 8px;
    }

    .details-title {
      color: #2C5F2D;
      margin-bottom: 15px;
      font-weight: 600;
      font-size: 15px;
    }

    .details-info {
      margin-bottom: 15px;
      font-size: 14px;
      color: #555;
      background-color: #f0f4f0;
      padding: 10px 15px;
      border-radius: 4px;
      border-left: 3px solid #2C5F2D;
    }

    .details-info.matched {
      background-color: #e8f5e8;
      border-left: 3px solid #4caf50;
    }

    .details-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    .details-table th {
      background-color: #f0f4f0;
      color: #555;
      padding: 10px;
      text-align: center;
      font-weight: 500;
    }

    .details-table td {
      padding: 10px;
      border-bottom: 1px solid #e0e0e0;
      vertical-align: middle;
      text-align: center;
    }

    .details-table tr:last-child td {
      border-bottom: none;
    }

    .text-left {
      text-align: left !important;
    }

  </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<!-- [A] 매칭 신청 확인 모달 1 - 매칭 신청 여부 확인 -->
<div id="matching-confirm-modal" class="matching-confirm-modal">
  <div class="matching-confirm-content">
    <p>선택한 사용자의 매칭 신청을 승인하시겠습니까?</p>
    <p>다른 신청자들은 자동으로 거부 처리됩니다.</p>
    <div class="modal-buttons">
      <button id="confirm" class="confirm-btn">확인</button>
      <button id="cancel" class="cancel-btn">취소</button>
    </div>
  </div>
</div>

<div class="container container-wide mypage-container section">

  <!-- 마이페이지 사이드바 -->
  <div class="sidebar">
    <div class="sidebar-title">마이 페이지</div>
    <ul class="sidebar-menu">
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>회원 관리</span>
        </a>
        <ul class="submenu">
          <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
          <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
          <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>이용 내역 조회</span>
        </a>
        <ul class="submenu">
          <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
          <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
          <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
          <li><a href="mypage-matchinglist.action" class="sidebar-link active">매칭 조회/내역</a></li>
          <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
          <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-wishlist.action" class="sidebar-link title">
          <span>찜</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-diary.action" class="sidebar-link title">
          <span>나의 캠핑일지</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-bookmark.action" class="sidebar-link title">
          <span>북마크</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-coupon.action" class="sidebar-link title">
          <span>쿠폰 내역</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-inquiry.action" class="sidebar-link title">
          <span>1:1 문의 내역</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="mypage-leave.action" class="sidebar-link title">
          <span>회원 탈퇴</span>
        </a>
      </li>
    </ul>
  </div>

  <!-- 마이페이지 메인 콘텐츠 -->
  <div class="mypage-main-content">
    <div class="page-header">
      <h2 class="page-title">매칭 조회/내역</h2>
      <p class="page-description">장비 대여와 관련된 매칭 신청 내역을 확인할 수 있습니다.</p>
    </div>

    <!-- 매칭 신청 탭 컨테이너 -->
    <div class="tab-container">
      <div class="tabs">
        <div class="tab ${activeTab == 'storen' ? 'active' : ''}" data-tab="storen" id="storen-tab">스토렌</div>
        <div class="tab ${activeTab == 'rental' ? 'active' : ''}" data-tab="rental" id="rental-tab">렌탈</div>
      </div>

      <!-- 거래ID 또는 장비명 검색 -->
      <div class="search-container">
        <input type="text" id="search-matching" placeholder="거래ID 또는 장비명 검색" value="${not empty storenId ? storenId : ''}">
        <button type="button" class="search-button" id="btn-search">
          <i class="fas fa-search"></i>
        </button>
      </div>

      <!-- 스토렌 탭 컨텐츠 -->
      <div class="tab-content ${activeTab == 'storen' ? 'active' : ''}" id="storen-content">
        <!-- 소유자/사용자 필터 -->
        <div class="table-actions align-items-center flex-wrap mb-3">
          <!-- 탭 필터 -->
          <div class="d-flex flex-wrap align-items-center">
            <div class="tab-nav">
              <a class="tab-link ${storenTabType == 'owner' ? 'active' : ''}" data-storen-tab="owner"
                 id="storen-owner">소유자</a>
            </div>
            <div class="tab-nav">
              <a class="tab-link ${storenTabType == 'user' ? 'active' : ''}" data-storen-tab="user"
                 id="storen-user">사용자</a>
            </div>
          </div>

          <!-- 정렬 옵션 (오른쪽) -->
          <div class="d-flex align-items-center">
            <!-- 날짜 필터 -->
            <div class="date-filter me-2">
              <select class="form-control">
                <option>전체 기간</option>
                <option>최근 1개월</option>
                <option>최근 3개월</option>
                <option>최근 6개월</option>
              </select>
            </div>

            <!-- 정렬 옵션 -->
            <div class="sort-container">
              <select class="form-control sort-select">
                <option>최신순</option>
                <option>높은 점수순</option>
                <option>낮은 점수순</option>
              </select>
            </div>
          </div>
        </div>

        <div class="table-container matching-table-container">
          <table class="custom-table matching-table table">
            <thead>
            <tr>
              <th>스토렌ID</th>
              <th>스토렌제목</th>
              <th>장비코드</th>
              <th>장비명</th>
              <th>렌탈시작일</th>
              <th>렌탈종료일</th>
              <th>매칭수</th>
              <th>상태</th>
            </tr>
            </thead>
            <tbody>
            <!-- 데이터가 없는 경우 -->
            <c:if test="${empty MatchingList}">
              <tr>
                <td colspan="8" class="text-center py-4">
                  <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <p>매칭 내역이 없습니다</p>
                    <div class="hint">다른 탭을 선택하거나 매칭을 신청해보세요.</div>
                  </div>
                </td>
              </tr>
            </c:if>
            <!-- 초기에 로드된 스토렌 소유자 매칭 데이터 -->
            <c:if test="${activeTab == 'storen' && storenTabType == 'owner' && not empty MatchingList}">
              <c:forEach var="storen" items="${MatchingList}">
                <tr class="table-row matching-row rental-header" data-id="${storen.storen_id}" data-expanded="false">
                  <td>${storen.storen_id}</td>
                  <td class="title-cell rental-title">
                    <a href="storenmatching-request.action?storenId=${storen.storen_id}" class="rental-link">${storen.storen_title}</a>
                  </td>
                  <td>
                    <a href="#" class="equipment-link">${storen.equip_code}</a>
                  </td>
                  <td class="title-cell">${storen.equipmentDTO.equip_name}</td>
                  <td>${storen.rental_start_date}</td>
                  <td>${storen.rental_end_date}</td>
                  <td><span class="match-count">${storen.matching_request_count}</span>
                    <i class="${storen.matching_request_count > 1 ? 'fas fa-user-friends' : 'fas fa-user'}"></i>
                  </td>
                  <td>
                    <c:set var="statusClass" value="${storen.matching_status == '매칭완료' ? 'status-completed' : 'status-pending'}"/>
                    <span class="status-badge ${statusClass}">${storen.matching_status}</span>
                  </td>
                </tr>
              </c:forEach>
            </c:if>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 렌탈 탭 콘텐츠 -->
      <div class="tab-content ${activeTab == 'rental' ? 'active' : ''}" id="rental-content">
        <!-- 소유자/사용자 필터 -->
        <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
          <!-- 탭 필터 -->
          <div class="d-flex flex-wrap align-items-center">
            <div class="tab-nav">
              <a class="tab-link ${storenTabType == 'owner' ? 'active' : ''}" data-storen-tab="owner"
                 id="rental-owner">소유자</a>
            </div>
            <div class="tab-nav">
              <a class="tab-link ${storenTabType == 'user' ? 'active' : ''}" data-storen-tab="user"
                 id="rental-user">사용자</a>
            </div>
          </div>

          <!-- 정렬 옵션 (오른쪽) -->
          <div class="d-flex align-items-center">
            <!-- 날짜 필터 -->
            <div class="date-filter me-2">
              <select class="form-control">
                <option>전체 기간</option>
                <option>최근 1개월</option>
                <option>최근 3개월</option>
                <option>최근 6개월</option>
              </select>
            </div>

            <!-- 정렬 옵션 -->
            <div class="sort-container">
              <select class="form-control sort-select">
                <option>최신순</option>
                <option>높은 점수순</option>
                <option>낮은 점수순</option>
              </select>
            </div>
          </div>
        </div>

        <div class="table-container matching-table-container">
          <table class="custom-table matching-table table">
            <thead>
            <tr>
              <th>렌탈ID</th>
              <th>렌탈제목</th>
              <th>장비코드</th>
              <th>장비명</th>
              <th>렌탈시작일</th>
              <th>렌탈종료일</th>
              <th>매칭수</th>
              <th>상태</th>
            </tr>
            </thead>
            <tbody>
            <!-- 데이터 로딩 전 표시할 메시지 -->
            <tr>
              <td colspan="8" class="text-center py-4">
                <i class="fas fa-spinner fa-spin me-2"></i> 매칭 데이터를 불러오는 중...
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- 로딩 오버레이 -->
  <div class="loading-overlay" style="display: none;">
    <div class="spinner">
      <i class="fas fa-circle-notch fa-spin"></i>
    </div>
  </div>

</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script type="text/javascript">
  // 페이지 로딩 시 실행
  $(document).ready(function() {

    // URL에서 탭 정보 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    let activeMainTab = urlParams.get('activeTab') || "${activeTab}" || "storen"; // URL 매개변수 또는 서버 값 또는 기본값
    let activeSubTab = urlParams.get('storenTabType') || "${storenTabType}" || "owner"; // URL 매개변수 또는 서버 값 또는 기본값

    console.log("초기 탭 설정 - 메인탭:", activeMainTab, "서브탭:", activeSubTab);

    // URL 매개변수에 따른 명시적 탭 활성화 처리
    if (activeMainTab && activeSubTab) {
      // 메인 탭 활성화
      $('.tab').removeClass('active');
      $('.tab[data-tab="' + activeMainTab + '"]').addClass('active');

      // 콘텐츠 활성화
      $('.tab-content').removeClass('active');
      $('#' + activeMainTab + '-content').addClass('active');

      // 서브 탭 활성화 (스토렌 탭인 경우)
      if (activeMainTab === 'storen') {
        $('#storen-content .tab-link').removeClass('active');
        $('#storen-' + activeSubTab).addClass('active');

        // 사용자 탭이면 데이터 다시 로드
        if (activeSubTab === 'user' && !$('#storen-content .custom-table tbody tr.rental-header').length) {
          loadMatchingData('storen', 'user');
        }
      }
      // 렌탈 탭인 경우 데이터 로드
      else if (activeMainTab === 'rental') {
        $('#rental-content .tab-link').removeClass('active');
        $('#rental-' + activeSubTab).addClass('active');

        // 렌탈 탭 데이터 로드
        loadMatchingData('rental', activeSubTab);
      }
    }

    // 페이지 로딩 시 검색창에 값이 있으면 자동 검색 실행
    const initialSearchValue = $('#search-matching').val().trim();
    if(initialSearchValue !== '') {
      // 약간의 지연 후 검색 실행 (DOM이 완전히 로드된 후)
      setTimeout(function() {
        performSearch();
      }, 300);
    }

    // 탭 전환 시 이전 데이터 정리 함수
    function clearPreviousData() {
      // 모든 확장된 행 닫기
      $('.rental-header').removeClass('active').attr('data-expanded', 'false');
      // 모든 상세 행 제거
      $('.matching-details').remove();

      // 테이블 초기화 (로딩 인디케이터 표시)
      if (activeMainTab === 'storen') {
        $('#storen-content .matching-table tbody').html(
                '<tr><td colspan="8" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 매칭 데이터를 불러오는 중...</td></tr>'
        );
      } else {
        $('#rental-content .matching-table tbody').html(
                '<tr><td colspan="8" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 매칭 데이터를 불러오는 중...</td></tr>'
        );
      }
    }

    // 매칭 탭 전환 기능
    $('.tab').on('click', function() {
      const tabId = $(this).data('tab');

      // 현재 활성화된 탭이면 아무것도 하지 않음
      if(activeMainTab === tabId) return;

      // 이전 데이터 정리
      clearPreviousData();

      // 탭 활성화
      $('.tab').removeClass('active');
      $(this).addClass('active');

      // 콘텐츠 활성화
      $('.tab-content').removeClass('active');
      $('#' + tabId + '-content').addClass('active');

      // 메인 탭 상태 저장
      activeMainTab = tabId;

      // 서브 탭 초기화 (소유자/사용자)
      if (tabId === 'storen') {
        // 스토렌 탭 내에서 소유자/사용자 서브탭 처리
        activeSubTab = $('#storen-owner').hasClass('active') ? 'owner' : 'user';
      } else { // 렌탈 탭
        // 렌탈 탭 내에서 소유자/사용자 서브탭 처리
        activeSubTab = $('#rental-owner').hasClass('active') ? 'owner' : 'user';
      }
      // 탭 전환 시 데이터 다시 로드
      loadMatchingData(activeMainTab, activeSubTab);
    });

    // 서브 탭 전환 이벤트 (소유자/사용자)
    $('.tab-link').on('click', function() {
      const subTabId = $(this).data('storen-tab') || $(this).data('rental-tab');

      // 현재 서브탭과 동일하면 아무것도 하지 않음
      if(activeSubTab === subTabId) return;

      // 이전 데이터 정리
      clearPreviousData();

      // 현재 메인 탭 내에서만 서브탭 활성화
      $(this).closest('.tab-content').find('.tab-link').removeClass('active');
      $(this).addClass('active');

      // 서브 탭 상태 저장
      activeSubTab = subTabId;

      // 서브 탭 전환 시 데이터 다시 로드
      loadMatchingData(activeMainTab, activeSubTab);
    });

    // 검색 기능 활성화
    $('#btn-search').on('click', function() {
      performSearch();
    });

    // 엔터 키 검색 활성화
    $('#search-matching').on('keypress', function(e) {
      if(e.which === 13) {
        performSearch();
      }
    });

    // 필터 해제 버튼 클릭 이벤트
    $(document).on('click', '.btn-clear-filter', function() {
      clearFilters();
    });

    // 소유자/사용자 탭의 렌탈 행 클릭 이벤트 (세부 정보 토글)
    $(document).on('click', '.rental-header', function() {
      const rentalId = $(this).data('id');
      const isExpanded = $(this).attr('data-expanded') === 'true';

      // 현재 열려 있는 다른 세부 행 닫기
      $('.rental-header').not(this).removeClass('active').attr('data-expanded', 'false');
      $('.matching-details').not('[data-parent="' + rentalId + '"]').hide();

      // 현재 행 토글
      if (isExpanded) {
        $(this).removeClass('active').attr('data-expanded', 'false');
        $('.matching-details[data-parent="' + rentalId + '"]').hide();
      } else {
        $(this).addClass('active').attr('data-expanded', 'true');

        // 상세 정보가 이미 로드되어 있는지 확인
        if ($('.matching-details[data-parent="' + rentalId + '"]').length === 0) {
          // 상세 정보 로드 (AJAX)
          if (activeSubTab === 'owner') {
            loadMatchingDetails(rentalId);  // 소유자용 상세 정보
          }
          else {
            loadUserMatchingDetails(rentalId);  // 사용자용 상세 정보
          }
        } else {
          $('.matching-details[data-parent="' + rentalId + '"]').show();
        }
      }
    });

    // 매칭 승인에 대한 처리
    // 전역 변수로 선택된 데이터 저장
    let selectedRentalId = null;
    let selectedRequestId = null;

    // 신청자 선택 버튼 클릭 이벤트 수정
    $(document).on('click', '.btn-approve', function(e) {
      e.stopPropagation(); // 상위 요소로 이벤트 전파 방지

      // 선택한 버튼의 데이터 저장
      selectedRentalId = $(this).data('rental');
      selectedRequestId = $(this).data('request');

      // 모달 표시
      $("#matching-confirm-modal").css("display", "flex");
      $("body").css("overflow", "hidden");
    });

    // 모달 취소 버튼 이벤트
    $("#cancel").on("click", function() {
      $("#matching-confirm-modal").hide();
      $("body").css("overflow", "auto");

      // 선택 데이터 초기화
      selectedRentalId = null;
      selectedRequestId = null;
    });

    // 모달 확인 버튼 이벤트
    $("#confirm").on("click", function() {
      if(selectedRentalId && selectedRequestId) {
        // 모달 닫기
        $("#matching-confirm-modal").hide();
        $("body").css("overflow", "auto");

        // 기존 함수 호출하되 새로고침 기능 추가
        approveMatchingWithRefresh(selectedRentalId, selectedRequestId);
      }
    });

    // 결제 버튼 클릭 이벤트
    $(document).on('click', '.pay-now-btn', function(e) {
      e.stopPropagation(); // 상위 요소로 이벤트 전파 방지

      const rentalId = $(this).data('rental');
      const userCode = $(this).data('user');
      const rentalType = $(this).data('type');
      // 결제 페이지로 이동
      window.location.href = 'storenmatching-rental-pay.action?rentalId=' + rentalId + '&userCode=' + userCode + '&type=' + rentalType;
    });

    // 매칭 신청 취소 버튼 클릭 이벤트
    $(document).on('click', '.cancel-request-btn', function(e) {
      e.stopPropagation(); // 상위 요소로 이벤트 전파 방지

      const rentalId = $(this).data('rental');
      const requestId = $(this).data('request');

      if (confirm('정말로 매칭 신청을 취소하시겠습니까?')) {
        // 매칭 신청 취소 AJAX 요청
        $.ajax({
          url: '/api/matching/cancel',
          type: 'POST',
          data: {
            transactionId: rentalId,
            requestId: requestId
          },
          dataType: 'json',
          success: function(response) {
            if (response.success) {
              alert('매칭 신청이 취소되었습니다.');
              // 현재 페이지 새로고침
              window.location.reload();
            } else {
              alert('매칭 신청 취소 중 오류가 발생했습니다: ' + (response.message || '알 수 없는 오류'));
            }
          },
          error: function(xhr, status, error) {
            console.error("매칭 신청 취소 실패:", error);
            alert('매칭 신청 취소 중 오류가 발생했습니다.');
          }
        });
      }
    });
  });

  //필터 초기화 함수
  function clearFilters() {
    // 필터 상태 제거
    $('.filter-notice').remove();

    // 원래 데이터 다시 로드
    loadMatchingData('storen', 'owner');
  }

  // 매칭 데이터 로드 함수
  function loadMatchingData(mainTab, subTab) {
    // 로딩 표시 활성화
    showLoading();

    let apiUrl = '';

    // 메인 탭과 서브 탭에 따라 API URL 결정
    if (mainTab === 'storen') {
      if (subTab === 'owner') {
        apiUrl = '/api/matching/storen/owner';
      } else { // 사용자 탭
        apiUrl = '/api/matching/storen/user';
      }
    } else { // 렌탈 탭
      if (subTab === 'owner') {
        apiUrl = '/api/matching/rental/owner';
      } else { // 사용자 탭
        apiUrl = '/api/matching/rental/user';
      }
    }

    console.log("데이터 로드 중:", apiUrl, "메인탭:", mainTab, "서브탭:", subTab);

    // 빈 테이블 초기화
    let targetTable;
    if (mainTab === 'storen') {
      targetTable = $('#storen-content .matching-table tbody');
    } else {
      targetTable = $('#rental-content .matching-table tbody');
    }

    // 로딩 인디케이터 표시
    targetTable.html('<tr><td colspan="8" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 매칭 데이터를 불러오는 중...</td></tr>');

    // AJAX 요청
    $.ajax({
      url: apiUrl,
      type: 'GET',
      dataType: 'json',
      cache: false, // 캐시 사용 안 함
      success: function(data) {
        console.log("데이터 로드 성공:", data.length, "건");
        // 로딩 표시 비활성화
        hideLoading();

        if (data.length === 0) {
          // 데이터가 없는 경우
          let colSpan = '8';
          targetTable.html(
                  '<tr>' +
                  '<td colspan="' + colSpan + '" class="text-center py-5">' +
                  '<div class="empty-state">' +
                  '<i class="fas fa-search"></i>' +
                  '<p>매칭 내역이 없습니다</p>' +
                  '<div class="hint">다른 탭을 선택하거나 매칭 신청을 기다려주세요.</div>' +
                  '</div>' +
                  '</td>' +
                  '</tr>');
          return;
        }

        // 데이터 렌더링
        renderData(data, targetTable);
      },
      error: function(xhr, status, error) {
        console.error("데이터 로드 실패:", error);
        hideLoading();

        // 에러 메시지 표시
        let colSpan = '8';
        targetTable.html(
                '<tr>' +
                '<td colspan="' + colSpan + '" class="text-center py-4">' +
                '<div class="alert alert-danger" role="alert">' +
                '<i class="fas fa-exclamation-circle me-2"></i> 데이터를 불러오는 중 오류가 발생했습니다.' +
                '</div>' +
                '</td>' +
                '</tr>');
      }
    });
  }

  // 메인 탭의 테이블 데이터 렌더링 함수
  function renderData(data, targetTable) {
    let html = '';

    data.forEach(function(item) {
      // 상태 클래스 결정
      let statusClass = '';
      if (item.matching_status === '매칭완료') {
        statusClass = 'status-completed';
      } else if (item.matching_status === '선택대기') {
        statusClass = 'status-pending';
      }

      // 아이콘 클래스 결정
      let matchingCountClass = '';
      if (item.matching_request_count > 1) {
        matchingCountClass = 'fas fa-user-friends';
      } else {
        matchingCountClass = 'fas fa-user';
      }

      html +=
              '<tr class="table-row matching-row rental-header" data-id="' + item.storen_id + '" data-expanded="false">' +
              '<td>' + item.storen_id + '</td>' +
              '<td class="title-cell rental-title">' +
              '<a href="storen-detail.action?id=' + item.storen_id + '" class="rental-link">' + item.storen_title + '</a>' +
              '</td>' +
              '<td>' +
              '<a href="equipment-detail.action?id=' + item.equip_code + '" class="equipment-link">' + item.equip_code + '</a>' +
              '</td>' +
              '<td class="title-cell">' + item.equipmentDTO.equip_name + '</td>' +
              '<td>' + item.rental_start_date + '</td>' +
              '<td>' + item.rental_end_date + '</td>' +
              '<td><span class="match-count">' + item.matching_request_count + '</span> <i class="' + matchingCountClass + '"></i></td>' +
              '<td>' +
              '<span class="status-badge ' + statusClass + '">' + item.matching_status + '</span>' +
              '</td>' +
              '</tr>';
    });
    targetTable.html(html);
  }

  // 매칭 상세 정보 로드 함수(소유자용)
  function loadMatchingDetails(rentalId) {
    console.log("상세 정보 로드: ", rentalId);

    // 로딩 인디케이터 표시
    const row = $('.rental-header[data-id="' + rentalId + '"]');
    const newDetailRow = $(
            '<tr class="matching-details" data-parent="' + rentalId + '">' +
            '<td colspan="8">' +
            '<div class="content-box-sm matching-details-container">' +
            '<h6 class="content-box-title details-title">매칭 신청자 목록</h6>' +
            '<div class="details-info">' +
            '<p><i class="fas fa-spinner fa-spin me-2"></i> 신청자 정보를 불러오는 중...</p>' +
            '</div>' +
            '</div>' +
            '</td>' +
            '</tr>'
    );

    // 새로운 상세 행 추가
    row.after(newDetailRow);

    // AJAX 요청으로 매칭 상세 정보 가져오기
    $.ajax({
      url: '/api/matching/storen/details/' + rentalId,
      type: 'GET',
      dataType: 'json',
      cache: false, // 캐시 사용 안 함
      success: function(data) {
        console.log("상세 정보 로드 성공:", data);

        // 매칭 상태에 따라 다른 UI 표시
        const matchingStatus = row.find('.status-badge').text().trim();

        if (matchingStatus === '매칭완료') {
          // 매칭 완료인 경우
          renderCompletedMatchingDetails(rentalId, data);
        } else {
          // 선택 대기 중인 경우
          renderPendingMatchingDetails(rentalId, data);
        }
      },
      error: function(xhr, status, error) {
        console.error("상세 정보 로드 실패:", error);

        // 에러 메시지 표시
        const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
        detailContainer.html(
                '<h6 class="content-box-title details-title">오류 발생</h6>' +
                '<div class="details-info">' +
                '<p><i class="fas fa-exclamation-circle me-2"></i> 상세 정보를 불러오는 중 오류가 발생했습니다.</p>' +
                '</div>'
        );
      }
    });
  }

  // 매칭 완료된 상세 정보 렌더링 함수(소유자용)
  function renderCompletedMatchingDetails(rentalId, data) {
    if (data.length === 0) {
      const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 완료 정보</h6>' +
              '<div class="details-info matched">' +
              '<p><i class="fas fa-info-circle"></i> 매칭 정보를 찾을 수 없습니다.</p>' +
              '</div>'
      );
      return;
    }

    // 매칭된 사용자 정보 찾기 (첫 번째 항목 사용)
    const matchedUser = data[0];

    // 컨테이너 업데이트
    const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
    let payment_date = '결제대기중';
    if (matchedUser.payment_date !== null && matchedUser.payment_date !== ""){
      payment_date = matchedUser.payment_date;
    }
    detailContainer.html(
            '<h6 class="content-box-title details-title">매칭 완료 정보</h6>' +
            '<div class="details-info matched">' +
            '<p><i class="fas fa-check-circle"></i> 이 렌탈은 <a href="user-profile.action?id=' + matchedUser.user_code + '" class="user-link">' + matchedUser.user_nickname + '</a> 님과 매칭되었습니다. (결제일: ' + payment_date + ')</p>' +
            '</div>'
    );
  }

  // 선택 대기 중인 상세 정보 렌더링 함수
  function renderPendingMatchingDetails(rentalId, data) {
    if (data.length === 0) {
      const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 신청자 목록</h6>' +
              '<div class="details-info">' +
              '<p><i class="fas fa-info-circle"></i> 아직 매칭 신청이 없습니다.</p>' +
              '</div>'
      );
      return;
    }

    // 컨테이너 시작 HTML
    let detailHtml =
            '<h6 class="content-box-title details-title">매칭 신청자 목록</h6>' +
            '<div class="details-info">' +
            '<p>아래 신청자 중 한 명을 선택하면 나머지 신청은 자동으로 취소됩니다.</p>' +
            '</div>' +
            '<table class="details-table">' +
            '<thead>' +
            '<tr>' +
            '<th>신청자</th>' +
            '<th>신청일</th>' +
            '<th>신뢰도</th>' +
            '<th>대여 이력</th>' +
            '<th>액션</th>' +
            '</tr>' +
            '</thead>' +
            '<tbody>';

    // 각 신청자에 대한 행 추가
    data.forEach(function(applicant) {
      // 신뢰도 클래스 결정
      let trustClass = 'low';
      if (applicant.trust >= 90) {
        trustClass = 'high';
      } else if (applicant.trust >= 80) {
        trustClass = 'medium';
      }

      detailHtml +=
              '<tr>' +
              '<td>' +
              '<a href="user-profile.action?id=' + applicant.user_code + '" class="user-link">' + applicant.user_nickname + '</a>' +
              '</td>' +
              '<!--<td class="text-left">신청 메시지가 여기에 표시됩니다.</td>-->' +
              '<td>' + applicant.requested_date + '</td>' +
              '<td><span class="trust-score ' + trustClass + '">' + applicant.trust + '%</span></td>' +
              '<td>' + applicant.rental_history + '회</td>' +
              '<td>' +
              '<button type="button" class="btn-sm btn-approve" data-rental="' + rentalId + '" data-request="' + applicant.matching_req_id + '">선택</button>' +
              '</td>' +
              '</tr>';
    });

    // 테이블 종료
    detailHtml += '</tbody></table>';

    // 컨테이너 업데이트
    const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
    detailContainer.html(detailHtml);
  }

  // 매칭 승인 함수 + 새로고침(소유자용)
  function approveMatchingWithRefresh(rentalId, requestId) {
    // 로딩 표시
    showLoading();

    // AJAX 요청으로 매칭 승인 처리
    $.ajax({
      url: '/api/matching/approve',
      type: 'POST',
      data: {
        transactionId: rentalId,
        requestId: requestId
      },
      dataType: 'json',
      success: function(response) {
        hideLoading();

        if (response.success) {
          // 성공 메시지 표시
          alert(response.message || '매칭이 성공적으로 승인되었습니다.');

          // 현재 활성 탭 정보를 URL 파라미터로 포함하여 새로고침
          const url = new URL(window.location.href);
          url.searchParams.set('tab', activeMainTab);
          url.searchParams.set('subTab', activeSubTab);

          // 페이지 새로고침
          window.location.href = url.toString();
        } else {
          alert('매칭 승인 처리 중 오류가 발생했습니다: ' + (response.message || '알 수 없는 오류'));
        }
      },
      error: function(xhr, status, error) {
        hideLoading();
        console.error("매칭 승인 실패:", error);
        alert('매칭 승인 처리 중 오류가 발생했습니다.');
      }
    });
  }

  // 매칭 상세 정보 로드 함수(사용자용)
  function loadUserMatchingDetails(rentalId) {
    console.log("사용자 상세 정보 로드: ", rentalId);

    // 로딩 인디케이터 표시
    const row = $('.rental-header[data-id="' + rentalId + '"]');
    const newDetailRow = $(
            '<tr class="matching-details" data-parent="' + rentalId + '">' +
            '<td colspan="8">' +
            '<div class="content-box-sm matching-details-container">' +
            '<h6 class="content-box-title details-title">매칭 정보</h6>' +
            '<div class="details-info">' +
            '<p><i class="fas fa-spinner fa-spin me-2"></i> 매칭 정보를 불러오는 중...</p>' +
            '</div>' +
            '</div>' +
            '</td>' +
            '</tr>'
    );

    // 새로운 상세 행 추가
    row.after(newDetailRow);

    // AJAX 요청으로 매칭 상세 정보 가져오기
    $.ajax({
      url: '/api/matching/storen/details/' + rentalId,
      type: 'GET',
      dataType: 'json',
      cache: false,
      success: function(data) {
        console.log("사용자 상세 정보 로드 성공:", data);

        // 매칭 상태에 따라 다른 UI 표시
        const matchingStatus = row.find('.status-badge').text().trim();

        if (matchingStatus === '매칭완료') {
          renderUserCompletedMatchingDetails(rentalId, data);
        } else {
          // 매칭승인대기 상태
          renderUserPendingMatchingDetails(rentalId, data);
        }
      },
      error: function(xhr, status, error) {
        console.error("상세 정보 로드 실패:", error);

        // 에러 메시지 표시
        const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
        detailContainer.html(
                '<h6 class="content-box-title details-title">오류 발생</h6>' +
                '<div class="details-info">' +
                '<p><i class="fas fa-exclamation-circle me-2"></i> 상세 정보를 불러오는 중 오류가 발생했습니다.</p>' +
                '</div>'
        );
      }
    });
  }

  // 매칭 완료된 상세 정보 렌더링 함수(사용자용)
  function renderUserCompletedMatchingDetails(rentalId, data) {
    if (data.length === 0) {
      const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 완료 정보</h6>' +
              '<div class="details-info matched">' +
              '<p><i class="fas fa-info-circle"></i> 매칭 정보를 찾을 수 없습니다.</p>' +
              '</div>'
      );
      return;
    }

    // 매칭된 사용자 정보 찾기 (첫 번째 항목 사용)
    const matchedUser = data[0];
    const myUserCode = ${userCode}; // JSP에서 세션의 user_code 가져오기
    const isMyMatch = matchedUser.user_code === myUserCode;

    // 컨테이너 업데이트
    const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');

    if (isMyMatch) {
      // 내가 매칭된 경우 (결제 버튼 표시)
      let paymentStatus = '';
      if (matchedUser.payment_status !== "결제대기") {
        // 이미 결제된 경우
        paymentStatus =
                '<div class="alert alert-success mt-3" role="alert">' +
                '<i class="fas fa-check-circle me-2"></i> 결제가 완료되었습니다. (결제일: ' + matchedUser.payment_date + ')' +
                '</div>';
      } else {
        // 아직 결제가 필요한 경우
        paymentStatus =
                '<div class="alert alert-warning mt-3" role="alert">' +
                '<i class="fas fa-exclamation-triangle me-2"></i> 아직 결제가 완료되지 않았습니다.' +
                '</div>' +
                '<button type="button" class="btn btn-success mt-2 pay-now-btn" data-rental="' + rentalId + '" data-user="' + matchedUser.user_code + '" data-type="storen">' +
                '<i class="fas fa-credit-card me-1"></i> 지금 결제하기' +
                '</button>';
      }

      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 완료 정보</h6>' +
              '<div class="details-info matched">' +
              '<p><i class="fas fa-check-circle me-2"></i> 축하합니다! 당신의 매칭 신청이 승인되었습니다.</p>' +
              '<div class="text-left">' +
              '<p><strong>렌탈 기간:</strong> ' + matchedUser.rental_start_date + ' ~ ' + matchedUser.rental_end_date + '</p>' +
              '<p><strong>렌탈 금액:</strong> ' + matchedUser.rental_pay.toLocaleString() + '원 (' + matchedUser.rental_duration + '일)</p>' +
              '</div>' +
              '</div>' +
              paymentStatus
      );
    } else {
      // 다른 사용자가 매칭된 경우
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 정보</h6>' +
              '<div class="details-info">' +
              '<p><i class="fas fa-exclamation-circle me-2"></i> 죄송합니다. 당신의 매칭 신청이 승인되지 않았습니다.</p>' +
              '<p>이 장비는 다른 사용자와 매칭이 완료되었습니다.</p>' +
              '</div>' +
              '<div class="text-center mt-3">' +
              '<a href="storen-list.action" class="btn btn-outline-secondary">' +
              '<i class="fas fa-search me-1"></i> 다른 장비 찾아보기' +
              '</a>' +
              '</div>'
      );
    }
  }

  // 선택 대기 중인 상세 정보 렌더링 함수(사용자용)
  function renderUserPendingMatchingDetails(rentalId, data) {
    if (data.length === 0) {
      const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 신청 정보</h6>' +
              '<div class="details-info">' +
              '<p><i class="fas fa-info-circle"></i> 매칭 신청 정보를 찾을 수 없습니다.</p>' +
              '</div>'
      );
      return;
    }

    // 현재 로그인한 사용자의 코드 (서버에서 가져온 값)
    const myUserCode = ${userCode}; // JSP에서 세션의 user_code 가져오기

    // 내 신청 정보 찾기
    let myRequestInfo = null;
    for (let i = 0; i < data.length; i++) {
      if (data[i].user_code === myUserCode) {
        myRequestInfo = data[i];
        break;
      }
    }

    // 내 신청 정보가 없는 경우
    if (!myRequestInfo) {
      const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
      detailContainer.html(
              '<h6 class="content-box-title details-title">매칭 신청 정보</h6>' +
              '<div class="details-info">' +
              '<p><i class="fas fa-exclamation-circle"></i> 현재 로그인한 계정으로 신청한 내역을 찾을 수 없습니다.</p>' +
              '</div>'
      );
      return;
    }

    // 컨테이너 업데이트
    const detailContainer = $('.matching-details[data-parent="' + rentalId + '"] .content-box-sm');
    detailContainer.html(
            '<h6 class="content-box-title details-title">매칭 신청 정보</h6>' +
            '<div class="details-info">' +
            '<p><i class="fas fa-clock me-2"></i> 소유자의 매칭 승인을 기다리고 있습니다.</p>' +
            '<div class="text-left">' +
            '<p><strong>신청일:</strong> ' + myRequestInfo.requested_date + '</p>' +
            '<p><strong>렌탈 기간:</strong> ' + myRequestInfo.rental_start_date + ' ~ ' + myRequestInfo.rental_end_date + ' (' + myRequestInfo.rental_duration + '일)</p>' +
            '<p><strong>예상 렌탈 금액:</strong> ' + myRequestInfo.rental_pay.toLocaleString() + '원</p>' +
            '</div>' +
            '</div>' +
            '<div class="alert alert-info mt-3" role="alert">' +
            '<i class="fas fa-info-circle me-2"></i> 소유자가 당신의 신청을 승인하면 알림을 보내드립니다.' +
            '</div>' +
            '<button type="button" class="btn btn-outline-danger mt-2 cancel-request-btn" data-rental="' + rentalId + '" data-request="' + myRequestInfo.matching_req_id + '">' +
            '<i class="fas fa-times me-1"></i> 매칭 신청 취소하기' +
            '</button>'
    );
  }

  // 로딩 표시 함수
  function showLoading() {
    $('.loading-overlay').show();
  }

  // 로딩 숨김 함수
  function hideLoading() {
    $('.loading-overlay').hide();
  }

  // 검색 실행 함수
  function performSearch() {
    const searchValue = $('#search-matching').val().trim();

    // 검색어가 숫자(ID)인 경우 API 호출, 그 외에는 기존 클라이언트 검색 수행
    if(searchValue !== '' && !isNaN(searchValue)) {
      // ID로 검색하는 경우
      const storenId = parseInt(searchValue);

      // 로딩 표시
      showLoading();

      const activeMainTab = $('.tab.active').data('tab');

      // 현재 활성화된 탭 확인
      const targetTable = activeMainTab === 'storen' ?
              $('#storen-content .matching-table tbody') :
              $('#rental-content .matching-table tbody');

      targetTable.html('<tr><td colspan="8" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 검색 중...</td></tr>');

      // API 호출
      $.ajax({
        url: '/api/matching/search',
        type: 'GET',
        data: {
          id: storenId
        },
        dataType: 'json',
        success: function(data) {
          hideLoading();

          // 필터 알림 추가
          if ($('.filter-notice').length > 0) {
            $('.filter-notice').remove();
          }

          $('#storen-content .table-actions').after(
                  '<div class="filter-notice">' +
                  '<span>"스토렌 ID : ' + storenId + '" 검색 결과 (' + data.length + '개)</span>' +
                  '<button class="btn-sm btn-clear-filter">모든 매칭 내역 보기</button>' +
                  '</div>'
          );

          if(data.length === 0) {
            // 검색 결과가 없는 경우
            targetTable.html(
                    '<tr><td colspan="8" class="text-center py-4">검색 결과가 없습니다.</td></tr>'
            );
          } else {
            // 중요: data가 배열이 아닌 경우 배열로 변환
            const dataArray = Array.isArray(data) ? data : [data];
            // 결과 표시 - renderData 함수 직접 호출
            renderData(dataArray, targetTable);
          }

          // 검색 완료 후 검색창 비우기
          $('#search-matching').val('');
        },
        error: function(xhr, status, error) {
          console.error('검색 실패: ' + error);
          hideLoading();

          targetTable.html(
                  '<tr><td colspan="8" class="text-center text-danger">검색 중 오류가 발생했습니다.</td></tr>'
          );
        }
      });
    } else {
      // 기존 클라이언트 사이드 검색 수행 (텍스트 검색)
      if(searchValue === '') {
        // 검색어가 없으면 모든 행 표시
        $('.rental-header, .table-row').show();
        // 열려있는 세부 행 유지
        $('.rental-header[data-expanded="true"]').each(function() {
          const rentalId = $(this).data('id');
          $('.matching-details[data-parent="' + rentalId + '"]').show();
        });
        // empty-state 제거
        $('.empty-state').remove();
        return;
      }

      // 모든 활성 탭의 행을 검색
      const rows = activeMainTab === 'storen' ?
              $('#storen-content .matching-row') :
              $('#rental-content .matching-row');
      let foundMatch = false;

      rows.each(function() {
        const rowData = $(this).text().toLowerCase();

        // 검색 조건 확인 (텍스트 포함 여부)
        if(rowData.includes(searchValue.toLowerCase())) {
          $(this).show();

          // 이미 확장된 행이면 상세 정보도 표시
          if($(this).hasClass('rental-header') && $(this).attr('data-expanded') === 'true') {
            const rentalId = $(this).data('id');
            $('.matching-details[data-parent="' + rentalId + '"]').show();
          }

          foundMatch = true;
        } else {
          $(this).hide();

          // 상세 정보 행도 숨김
          if($(this).hasClass('rental-header')) {
            const rentalId = $(this).data('id');
            $('.matching-details[data-parent="' + rentalId + '"]').hide();
          }
        }
      });

      // 검색 결과가 없는 경우 메시지 표시
      if(!foundMatch) {
        const targetContent = activeMainTab === 'storen' ?
                '#storen-content' :
                '#rental-content';

        if($(targetContent + ' .empty-state').length === 0) {
          $(targetContent + ' .matching-table-container').after(
                  '<div class="empty-state">' +
                  '<i class="fas fa-search"></i>' +
                  '<p>검색 결과가 없습니다</p>' +
                  '<div class="hint">다른 검색어로 다시 시도해보세요.</div>' +
                  '</div>'
          );
        }
      } else {
        $('.empty-state').remove();
      }
    }
  }
</script>
</body>
</html>