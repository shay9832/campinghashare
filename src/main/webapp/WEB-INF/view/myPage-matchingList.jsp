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
  <!-- 제이쿼리 사용 CDN 방식 -->
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

  <style>
    /* 테이블 스타일 */
    .matching-table-container {
      margin-top: 20px;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .matching-table {
      width: 100%;
      border-collapse: collapse;
    }

    .matching-table .table {
      margin-bottom: 0;
    }

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
          <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
          <li><a href="myPage-trust.jsp" class="sidebar-link">신뢰도</a></li>
          <li><a href="myPage-point.jsp" class="sidebar-link">포인트</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>이용 내역 조회</span>
        </a>
        <ul class="submenu">
          <li><a href="myPage-myEquip.jsp" class="sidebar-link">내가 소유한 장비</a></li>
          <li><a href="myPage-inspecList.jsp" class="sidebar-link">검수 결과 조회</a></li>
          <li><a href="myPage-delivery.jsp" class="sidebar-link">배송 조회/내역</a></li>
          <li><a href="myPage-matchingList.jsp" class="sidebar-link active">매칭 조회/내역</a></li>
          <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
          <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="myPage-wishlist.jsp" class="sidebar-link title">
          <span>찜</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="" class="sidebar-link title">
          <span>나의 캠핑일지</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>북마크</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>쿠폰 내역</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>1:1 문의 내역</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
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
        <div class="tab active" data-tab="owner">소유자</div>
        <div class="tab" data-tab="user">사용자</div>
      </div>

      <!-- 렌탈ID 또는 장비명 검색 -->
      <div class="search-container">
        <input type="text" id="search-matching" placeholder="렌탈ID 또는 장비명 검색">
        <button type="button" class="search-button" id="btn-search">
          <i class="fas fa-search"></i>
        </button>
      </div>

      <!-- 소유자 탭 콘텐츠 (내가 소유한 장비에 대한 매칭 신청) -->
      <div class="tab-content active" id="owner-content">
        <div class="table-container matching-table-container">
          <table class="custom-table matching-table table">
            <thead>
            <tr>
              <th>렌탈ID</th>
              <th>렌탈제목</th>
              <th>장비코드</th>
              <th>장비명</th>
              <th>렌탈_시작일</th>
              <th>렌탈_종료일</th>
              <th>매칭수</th>
              <th>상태</th>
            </tr>
            </thead>
            <tbody>
            <tr class="table-row matching-row rental-header" data-id="RT12345" data-expanded="false">
              <td>RT12345</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT12345" class="rental-link">주말 캠핑용 텐트 대여합니다</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ12345" class="equipment-link">EQ12345</a>
              </td>
              <td>캠핑 텐트 세트</td>
              <td>2023-04-28</td>
              <td>2023-04-30</td>
              <td><span class="match-count">3</span> <i class="fas fa-user-friends"></i></td>
              <td>
                <span class="status-badge status-pending">선택대기</span>
              </td>
            </tr>
            <tr class="matching-details" data-parent="RT12345" style="display: none;">
              <td colspan="8">
                <div class="content-box-sm matching-details-container">
                  <h6 class="content-box-title details-title">매칭 신청자 목록</h6>
                  <div class="details-info">
                    <p>아래 신청자 중 한 명을 선택하면 나머지 신청은 자동으로 취소됩니다.</p>
                  </div>
                  <table class="details-table">
                    <thead>
                    <tr>
                      <th>신청자</th>
                      <th>신청 메시지</th>
                      <th>신청일</th>
                      <th>신뢰도</th>
                      <th>대여 이력</th>
                      <th>액션</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td>
                        <a href="user-profile.jsp?id=user123" class="user-link">캠핑러버</a>
                      </td>
                      <td class="text-left">4월 마지막 주말에 가족캠핑을 계획하고 있습니다. 깨끗하게 사용하겠습니다.</td>
                      <td>2023-04-20</td>
                      <td><span class="trust-score high">92%</span></td>
                      <td>12회</td>
                      <td>
                        <button type="button" class="btn-sm btn-approve" data-rental="RT12345" data-user="user123">선택</button>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="user-profile.jsp?id=user234" class="user-link">등산마니아</a>
                      </td>
                      <td class="text-left">텐트 대여 경험이 많습니다. 깔끔하게 사용 후 반납하겠습니다.</td>
                      <td>2023-04-21</td>
                      <td><span class="trust-score medium">85%</span></td>
                      <td>5회</td>
                      <td>
                        <button type="button" class="btn-sm btn-approve" data-rental="RT12345" data-user="user234">선택</button>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="user-profile.jsp?id=user345" class="user-link">주말여행자</a>
                      </td>
                      <td class="text-left">친구들과 처음으로 캠핑을 가려고 합니다. 조심히 사용하겠습니다.</td>
                      <td>2023-04-22</td>
                      <td><span class="trust-score low">78%</span></td>
                      <td>1회</td>
                      <td>
                        <button type="button" class="btn-sm btn-approve" data-rental="RT12345" data-user="user345">선택</button>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </td>
            </tr>

            <tr class="table-row matching-row rental-header" data-id="RT23456" data-expanded="false">
              <td>RT23456</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT23456" class="rental-link">1박2일 접이식 테이블/의자</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ23456" class="equipment-link">EQ23456</a>
              </td>
              <td>접이식 테이블 체어</td>
              <td>2023-05-05</td>
              <td>2023-05-07</td>
              <td><span class="match-count">1</span> <i class="fas fa-user"></i></td>
              <td>
                <span class="status-badge status-completed">매칭완료</span>
              </td>
            </tr>
            <tr class="matching-details" data-parent="RT23456" style="display: none;">
              <td colspan="8">
                <div class="content-box-sm matching-details-container">
                  <h6 class="content-box-title details-title">매칭 완료 정보</h6>
                  <div class="details-info matched">
                    <p><i class="fas fa-check-circle"></i> 이 렌탈은 <a href="user-profile.jsp?id=user456" class="user-link">산책남</a> 님과 매칭되었습니다. (승인일: 2023-04-26)</p>
                  </div>
                </div>
              </td>
            </tr>

            <tr class="table-row matching-row rental-header" data-id="RT34567" data-expanded="false">
              <td>RT34567</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT34567" class="rental-link">동계 캠핑용 침낭 대여</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ34567" class="equipment-link">EQ34567</a>
              </td>
              <td>캠핑 침낭</td>
              <td>2023-05-15</td>
              <td>2023-05-20</td>
              <td><span class="match-count">2</span> <i class="fas fa-user-friends"></i></td>
              <td>
                <span class="status-badge status-pending">선택대기</span>
              </td>
            </tr>
            <tr class="matching-details" data-parent="RT34567" style="display: none;">
              <td colspan="8">
                <div class="content-box-sm matching-details-container">
                  <h6 class="content-box-title details-title">매칭 신청자 목록</h6>
                  <div class="details-info">
                    <p>아래 신청자 중 한 명을 선택하면 나머지 신청은 자동으로 취소됩니다.</p>
                  </div>
                  <table class="details-table">
                    <thead>
                    <tr>
                      <th>신청자</th>
                      <th>신청 메시지</th>
                      <th>신청일</th>
                      <th>신뢰도</th>
                      <th>대여 이력</th>
                      <th>액션</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td>
                        <a href="user-profile.jsp?id=user789" class="user-link">백패커</a>
                      </td>
                      <td class="text-left">동계 캠핑용 침낭이 필요합니다. 깨끗하게 사용하겠습니다.</td>
                      <td>2023-05-01</td>
                      <td><span class="trust-score high">95%</span></td>
                      <td>18회</td>
                      <td>
                        <button type="button" class="btn-sm btn-approve" data-rental="RT34567" data-user="user789">선택</button>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="user-profile.jsp?id=user567" class="user-link">겨울캠퍼</a>
                      </td>
                      <td class="text-left">5월 중순 캠핑을 계획 중입니다. 좋은 침낭이 필요합니다.</td>
                      <td>2023-05-02</td>
                      <td><span class="trust-score medium">87%</span></td>
                      <td>7회</td>
                      <td>
                        <button type="button" class="btn-sm btn-approve" data-rental="RT34567" data-user="user567">선택</button>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </td>
            </tr>

            <tr class="table-row matching-row rental-header" data-id="RT45678" data-expanded="false">
              <td>RT45678</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT45678" class="rental-link">코펠 세트 단기 대여</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ45678" class="equipment-link">EQ45678</a>
              </td>
              <td>코펠 세트</td>
              <td>2023-04-10</td>
              <td>2023-04-12</td>
              <td><span class="match-count">1</span> <i class="fas fa-user"></i></td>
              <td>
                <span class="status-badge status-completed">매칭완료</span>
              </td>
            </tr>
            <tr class="matching-details" data-parent="RT45678" style="display: none;">
              <td colspan="8">
                <div class="content-box-sm matching-details-container">
                  <h6 class="content-box-title details-title">매칭 완료 정보</h6>
                  <div class="details-info matched">
                    <p><i class="fas fa-check-circle"></i> 이 렌탈은 <a href="user-profile.jsp?id=user012" class="user-link">요리캠퍼</a> 님과 매칭되었습니다. (승인일: 2023-04-06)</p>
                  </div>
                </div>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 사용자 탭 콘텐츠 (내가 신청한 매칭) -->
      <div class="tab-content" id="user-content">
        <div class="table-container">
          <table class="custom-table matching-table table">
            <thead>
            <tr>
              <th>렌탈ID</th>
              <th>렌탈제목</th>
              <th>장비코드</th>
              <th>장비명</th>
              <th>소유자</th>
              <th>렌탈_시작일</th>
              <th>렌탈_종료일</th>
              <th>신청일</th>
              <th>상태</th>
            </tr>
            </thead>
            <tbody>
            <tr class="table-row matching-row" data-id="2001">
              <td>RT56789</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT56789" class="rental-link">등산용 배낭 주말 대여</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ56789" class="equipment-link">EQ56789</a>
              </td>
              <td>등산용 배낭</td>
              <td>
                <a href="user-profile.jsp?id=owner123" class="user-link">산악인</a>
              </td>
              <td>2023-05-12</td>
              <td>2023-05-14</td>
              <td>2023-05-05</td>
              <td>
                <span class="status-badge status-pending">승인대기</span>
              </td>
            </tr>
            <tr class="table-row matching-row" data-id="2002">
              <td>RT67890</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT67890" class="rental-link">편안한 릴렉스 체어 렌탈</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ67890" class="equipment-link">EQ67890</a>
              </td>
              <td>캠핑용 의자</td>
              <td>
                <a href="user-profile.jsp?id=owner456" class="user-link">캠핑장인</a>
              </td>
              <td>2023-04-20</td>
              <td>2023-04-22</td>
              <td>2023-04-15</td>
              <td>
                <span class="status-badge status-completed">승인완료</span>
              </td>
            </tr>
            <tr class="table-row matching-row" data-id="2003">
              <td>RT78901</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT78901" class="rental-link">캠핑 조명 랜턴 대여합니다</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ78901" class="equipment-link">EQ78901</a>
              </td>
              <td>야외용 랜턴</td>
              <td>
                <a href="user-profile.jsp?id=owner789" class="user-link">밤낚시꾼</a>
              </td>
              <td>2023-05-25</td>
              <td>2023-05-27</td>
              <td>2023-05-10</td>
              <td>
                <span class="status-badge status-pending">승인대기</span>
              </td>
            </tr>
            <tr class="table-row matching-row" data-id="2004">
              <td>RT89012</td>
              <td class="title-cell rental-title">
                <a href="rental-detail.jsp?id=RT89012" class="rental-link">고성능 가스버너 단기 대여</a>
              </td>
              <td>
                <a href="equipment-detail.jsp?id=EQ89012" class="equipment-link">EQ89012</a>
              </td>
              <td>휴대용 가스버너</td>
              <td>
                <a href="user-profile.jsp?id=owner012" class="user-link">캠핑쉐프</a>
              </td>
              <td>2023-04-05</td>
              <td>2023-04-07</td>
              <td>2023-03-28</td>
              <td>
                <span class="status-badge status-completed">승인완료</span>
              </td>
            </tbody>
          </table>
        </div>
      </div>
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
    // 매칭 탭 전환 기능
    $('.tab').on('click', function() {
      const tabId = $(this).data('tab');

      // 탭 활성화
      $('.tab').removeClass('active');
      $(this).addClass('active');

      // 콘텐츠 활성화
      $('.tab-content').removeClass('active');
      $(`#` + tabId + `-content`).addClass('active');

      // 열려있는 모든 세부 행 닫기
      $('.matching-details').hide();
      $('.rental-header').removeClass('active').attr('data-expanded', 'false');
    });

    // 소유자 탭의 렌탈 행 클릭 이벤트 (세부 정보 토글)
    $(document).on('click', '.rental-header', function() {
      const rentalId = $(this).data('id');
      const isExpanded = $(this).attr('data-expanded') === 'true';

      // 현재 열려 있는 다른 세부 행 닫기
      $('.rental-header').not(this).removeClass('active').attr('data-expanded', 'false');
      $('.matching-details').not(`[data-parent="` + rentalId + `"]`).hide();

      // 현재 행 토글
      if (isExpanded) {
        $(this).removeClass('active').attr('data-expanded', 'false');
        $(`.matching-details[data-parent="` + rentalId + `"]`).hide();
      } else {
        $(this).addClass('active').attr('data-expanded', 'true');
        $(`.matching-details[data-parent="` + rentalId + `"]`).show();
      }
    });

    // 신청자 선택 버튼 클릭 이벤트
    $(document).on('click', '.btn-approve', function() {
      const rentalId = $(this).data('rental');
      const userId = $(this).data('user');
      approveMatching(rentalId, userId);
    });

    // 검색 기능
    $('#btn-search').on('click', function() {
      performSearch();
    });

    // 엔터 키 검색
    $('#search-matching').on('keypress', function(e) {
      if(e.which === 13) {
        performSearch();
      }
    });
  });

  // 매칭 승인 함수
  function approveMatching(rentalId, userId) {
    if(confirm(`${userId} 님의 매칭 신청을 승인하시겠습니까?\n다른 신청자들은 자동으로 거부 처리됩니다.`)) {
      // 실제 구현 시에는 AJAX 요청으로 서버에 승인 요청
      // 여기서는 화면에서만 처리

      const today = new Date();
      const formattedDate = today.getFullYear() + '-' +
              String(today.getMonth() + 1).padStart(2, '0') + '-' +
              String(today.getDate()).padStart(2, '0');

      // 렌탈 행의 상태 업데이트
      const row = $(`.rental-header[data-id="${rentalId}"]`);
      row.find('.status-badge')
              .removeClass('status-pending')
              .addClass('status-completed')
              .text('매칭완료');

      // 세부 정보 컨테이너 업데이트
      const detailsContainer = $(`.matching-details[data-parent="${rentalId}"] .content-box-sm`);
      detailsContainer.html(`
                <h6 class="content-box-title">매칭 완료 정보</h6>
                <div class="details-info matched">
                    <p><i class="fas fa-check-circle"></i> 이 렌탈은 <a href="user-profile.jsp?id=${userId}" class="user-link">${userId}</a> 님과 매칭되었습니다. (승인일: ${formattedDate})</p>
                </div>
            `);

      alert(`${userId} 님의 매칭 신청이 승인되었습니다. 다른 신청자들은 자동으로 거부되었습니다.`);
    }
  }

  // 검색 실행 함수
  function performSearch() {
    const searchValue = $('#search-matching').val().trim().toLowerCase();

    if(searchValue === '') {
      // 검색어가 없으면 모든 행 표시
      $('.rental-header, .table-row').show();
      // 열려있는 세부 행 유지
      $('.rental-header[data-expanded="true"]').each(function() {
        const rentalId = $(this).data('id');
        $(`.matching-details[data-parent="${rentalId}"]`).show();
      });
      // empty-state 제거
      $('.empty-state').remove();
      return;
    }

    // 모든 활성 탭의 행을 검색
    const activeTab = $('.tab.active').data('tab');

    if (activeTab === 'owner') {
      // 소유자 탭의 경우 렌탈 헤더 행을 검색
      const rows = $('#owner-content .rental-header');
      let foundMatch = false;

      rows.each(function() {
        const rowData = $(this).text().toLowerCase();
        const rentalId = $(this).find('td:eq(0)').text().toLowerCase();
        const rentalTitle = $(this).find('.rental-title').text().toLowerCase();
        const equipmentCode = $(this).find('td:eq(2)').text().toLowerCase();
        const equipmentName = $(this).find('td:eq(3)').text().toLowerCase();

        // 검색 조건 확인
        if(rentalId.includes(searchValue) ||
                rentalTitle.includes(searchValue) ||
                equipmentCode.includes(searchValue) ||
                equipmentName.includes(searchValue) ||
                rowData.includes(searchValue)) {
          $(this).show();
          const rentalId = $(this).data('id');
          // 이미 확장된 행만 표시
          if($(this).attr('data-expanded') === 'true') {
            $(`.matching-details[data-parent="${rentalId}"]`).show();
          }
          foundMatch = true;
        } else {
          $(this).hide();
          const rentalId = $(this).data('id');
          $(`.matching-details[data-parent="${rentalId}"]`).hide();
        }
      });

      // 검색 결과가 없는 경우 처리
      handleEmptySearchResults(foundMatch, activeTab);

    } else {
      // 사용자 탭의 경우 일반 행을 검색
      const rows = $('#user-content .table-row');
      let foundMatch = false;

      rows.each(function() {
        const rowData = $(this).text().toLowerCase();
        const rentalId = $(this).find('td:eq(0)').text().toLowerCase();
        const rentalTitle = $(this).find('.rental-title').text().toLowerCase();
        const equipmentCode = $(this).find('td:eq(2)').text().toLowerCase();
        const equipmentName = $(this).find('td:eq(3)').text().toLowerCase();

        // 검색 조건 확인
        if(rentalId.includes(searchValue) ||
                rentalTitle.includes(searchValue) ||
                equipmentCode.includes(searchValue) ||
                equipmentName.includes(searchValue) ||
                rowData.includes(searchValue)) {
          $(this).show();
          foundMatch = true;
        } else {
          $(this).hide();
        }
      });

      // 검색 결과가 없는 경우 처리
      handleEmptySearchResults(foundMatch, activeTab);
    }
  }

  // 검색 결과가 없는 경우 처리 함수
  function handleEmptySearchResults(foundMatch, activeTab) {
    if(!foundMatch) {
      // 이미 empty-state가 있는지 확인
      if($(`#${activeTab}-content .empty-state`).length === 0) {
        $(`#${activeTab}-content .table-container`).after(`
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <p>검색 결과가 없습니다</p>
                        <div class="hint">다른 검색어로 다시 시도해보세요.</div>
                    </div>
                `);
      }
    } else {
      // 검색 결과가 있으면 empty-state 제거
      $(`#${activeTab}-content .empty-state`).remove();
    }
  }
</script>
</body>
</html>