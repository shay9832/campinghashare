<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampingHaShare - 포인트 내역</title>
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
  <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
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
          <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
          <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
          <li><a href="mypage-point.action" class="sidebar-link active">포인트</a></li>
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
          <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
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
      <h2 class="page-title">포인트 내역</h2>
    </div>

    <!-- 포인트 요약 정보 -->
    <div class="point-summary-container mb-4">
      <div class="row g-3">
        <div class="col-md-6">
          <div class="point-summary-card">
            <div class="point-summary-title">
              <i class="fas fa-star me-2"></i>현재 포인트
            </div>
            <div class="point-summary-value">
              <span class="point-value">${user.totalPoint}</span>
              <span class="point-unit">P</span>
            </div>
            <div class="point-description">
              포인트는 캠핑하쉐어 커뮤니티 활동을 통해 적립됩니다.
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="point-summary-card">
            <div class="point-summary-title">
              <i class="fas fa-medal me-2"></i>회원 등급
            </div>
            <div class="point-summary-rating">
              <span class="rating-badge">${user.userGrade}</span>
              <div class="rating-progress-container">
                <div class="rating-progress-bar" style="width: ${progressPercentage}%"></div>
              </div>
            </div>
            <div class="point-description">
              포인트 ${user.totalPoint}P + 신뢰도 ${user.totalTrust}% = 현재 등급 "${user.userGrade}"<br>
              (${user.nextUserGrade}까지 포인트 ${user.remainPoint}점 + 신뢰도 ${user.remainTrust}% 남음)
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 포인트 내역 필터 -->
    <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">

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
      </div>
    </div>

    <!-- 포인트 내역 테이블 -->
    <div class="point-history-table">
      <table class="table">
        <thead>
        <tr>
          <th style="width: 15%;">날짜</th>
          <th style="width: 55%;">내용</th>
          <th style="width: 15%;">포인트 변동</th>
          <th style="width: 15%;">누적 포인트</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${not empty pointList}">
            <c:forEach var="point" items="${pointList}">
              <tr class="point-earned-row">
                <td>${point.created_date}</td>
                <td class="point-description">${point.point_reason}</td>
                <c:choose>
                  <c:when test="${point.point_change < 0}">
                    <td class="point-amount used">${point.point_change}P</td>
                  </c:when>
                  <c:otherwise>
                    <td class="point-amount earned">${point.point_change}P</td>
                  </c:otherwise>
                </c:choose>
                <td>${point.total_point}P</td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr class="no-data-row">
              <td colspan="4" class="text-center py-5">
                <div class="no-data-message">
                  <i class="fas fa-info-circle fs-4 mb-3 text-secondary"></i>
                  <p class="mb-1">포인트 내역이 없습니다.</p>
                  <p class="small text-muted">게시글 작성, 이벤트 참여 등의 활동으로 포인트를 쌓아보세요!</p>
                </div>
              </td>
            </tr>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>
    </div>

    <!-- 포인트 안내 사항 -->
    <div class="point-info-container mt-4 mb-4">
      <div class="point-info-header">
        <i class="fas fa-info-circle me-2"></i> 포인트 안내
      </div>
      <div class="point-info-content">
        <div class="point-rule-section">
          <h5 class="point-rule-title">포인트 획득 방법</h5>
          <ul class="point-rule-list">
            <li><span class="badge bg-success">+1P</span> 게시글 작성</li>
            <li><span class="badge bg-success">+5P</span> 인기글 지정</li>
            <li><span class="badge bg-success">+?P</span> 이벤트 응모 (이벤트별 상이)</li>
          </ul>
        </div>
        <div class="point-rule-section">
          <h5 class="point-rule-title">포인트 차감 사유</h5>
          <ul class="point-rule-list">
            <li><span class="badge bg-danger">-5P</span> 신고 처벌</li>
            <li><span class="badge bg-danger">-5P</span> 허위 신고 처벌</li>
          </ul>
        </div>
        <div class="point-rule-section" style="flex:2;">
          <h5 class="point-rule-title">회원 등급 기준</h5>
          <ul class="point-rule-list grade-list">
            <li><span class="badge bg-secondary">도시인</span> 포인트+신뢰도 합산 0~99점 (신뢰도 0~59%)</li>
            <li><span class="badge bg-secondary" style="background-color: #A0A0A0 !important;">야외인</span> 포인트+신뢰도 합산 100~199점 (신뢰도 60~69%)</li>
            <li><span class="badge bg-secondary" style="background-color: #8B4513 !important; color: #fff !important;">방랑인</span> 포인트+신뢰도 합산 200~299점 (신뢰도 70~79%)</li>
            <li><span class="badge bg-secondary" style="background-color: #2E8B57 !important;">개척인</span> 포인트+신뢰도 합산 300~499점 (신뢰도 80~89%)</li>
            <li><span class="badge bg-secondary" style="background-color: #1E90FF !important;">자연인</span> 포인트+신뢰도 합산 500점 이상 (신뢰도 90% 이상)</li>
          </ul>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
  $(document).ready(function() {
    // 날짜 필터 변경 이벤트
    $('.date-filter select').change(function() {
      // 날짜 필터링 기능 구현 예정
      console.log('날짜 필터가 변경되었습니다: ' + $(this).val());
    });
  });
</script>

<style>
  /* 포인트 내역 페이지 전용 CSS */
  /* 포인트 요약 카드 스타일 */
  .point-summary-card {
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    height: 100%;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    transition: all 0.3s ease;
  }

  .point-summary-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }

  .point-summary-title {
    font-size: 16px;
    font-weight: 600;
    color: #495057;
    margin-bottom: 15px;
  }

  .point-summary-value {
    display: flex;
    align-items: baseline;
    margin-bottom: 10px;
  }

  .point-value {
    font-size: 32px;
    font-weight: 700;
    color: #2C5F2D;
  }

  .point-unit {
    font-size: 20px;
    font-weight: 600;
    color: #6c757d;
    margin-left: 5px;
  }

  .point-description {
    font-size: 14px;
    color: #6c757d;
    line-height: 1.5;
  }

  /* 회원 등급 관련 스타일 */
  .point-summary-rating {
    margin-bottom: 10px;
  }

  .rating-badge {
    display: inline-block;
    background-color: #C0C0C0;
    color: white;
    font-size: 16px;
    font-weight: 600;
    padding: 5px 12px;
    border-radius: 4px;
    margin-bottom: 10px;
  }

  .rating-progress-container {
    height: 8px;
    background-color: #e9ecef;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 10px;
  }

  .rating-progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #A0A0A0 0%, #8B4513 30%, #2E8B57 60%, #1E90FF 100%);
    border-radius: 4px;
  }

  /* 포인트 내역 테이블 스타일 */
  .point-history-table {
    margin-top: 20px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  }

  .point-history-table .table {
    margin-bottom: 0;
  }

  .point-history-table thead th {
    background-color: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
    font-weight: 600;
    padding: 12px 15px;
    vertical-align: middle;
  }

  .point-history-table tbody td {
    padding: 12px 15px;
    vertical-align: middle;
    border-bottom: 1px solid #e9ecef;
  }

  .point-description {
    font-weight: 500;
  }

  .point-amount {
    font-weight: 600;
  }

  .point-amount.earned {
    color: #28a745;
  }

  .point-amount.used {
    color: #dc3545;
  }

  /* 포인트 안내사항 스타일 */
  .point-info-container {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  }

  .point-info-header {
    font-size: 16px;
    font-weight: 600;
    color: #495057;
    margin-bottom: 15px;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 10px;
  }

  .point-info-content {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
  }

  .point-rule-section {
    flex: 1;
    min-width: 250px;
  }

  .point-rule-title {
    font-size: 14px;
    font-weight: 600;
    color: #495057;
    margin-bottom: 10px;
  }

  .point-rule-list {
    padding-left: 0;
    list-style: none;
    margin-bottom: 0;
  }

  .point-rule-list li {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
    font-size: 14px;
    color: #6c757d;
  }

  .point-rule-list li .badge {
    margin-right: 8px;
    min-width: 40px;
    text-align: center;
  }

  .grade-list li .badge {
    margin-right: 8px;
    min-width: 70px;
    text-align: center;
  }

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

  .tab-link.active {
    background-color: #2C5F2D;
    color: white;
  }
  /* 데이터 없음 메시지 스타일 */
  .no-data-row {
    background-color: #f9f9f9;
  }

  .no-data-message {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    color: #6c757d;
  }

  .no-data-message i {
    font-size: 3rem;
    margin-bottom: 15px;
    color: #adb5bd;
  }

  .no-data-message p {
    margin-bottom: 0;
  }

  .no-data-message .small {
    font-size: 0.875rem;
  }

  /* 반응형 조정 */
  @media (max-width: 768px) {
    .point-summary-container .row {
      gap: 15px;
    }

    .point-info-content {
      flex-direction: column;
    }
  }
</style>
</body>
</html>