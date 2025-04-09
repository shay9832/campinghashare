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
          <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
          <li><a href="myPage-trust.jsp" class="sidebar-link">신뢰도</a></li>
          <li><a href="myPage-point.jsp" class="sidebar-link active">포인트</a></li>
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
          <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
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
              <span class="point-value">84</span>
              <span class="point-unit">P</span>
            </div>
            <div class="point-description">
              웹사이트 활동을 통해 적립됩니다.
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="point-summary-card">
            <div class="point-summary-title">
              <i class="fas fa-medal me-2"></i>회원 등급
            </div>
            <div class="point-summary-rating">
              <span class="rating-badge">실버</span>
              <div class="rating-progress-container">
                <div class="rating-progress-bar" style="width: 70%"></div>
              </div>
            </div>
            <div class="point-description">
              포인트 84P + 신뢰도 72점 = 156점 (골드까지 44점 남음)
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 포인트 내역 필터 -->
    <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
      <!-- 탭 필터 -->
      <div class="d-flex flex-wrap align-items-center">
        <div class="tab-nav">
          <a class="tab-link active" href="#">전체 내역</a>
        </div>
        <div class="tab-nav">
          <a class="tab-link" href="#">획득 내역</a>
        </div>
        <div class="tab-nav">
          <a class="tab-link" href="#">차감 내역</a>
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
        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/04/06</td>
          <td class="point-description">인기글 지정 [캠핑장비 렌탈 후기: 텐트 체험기]</td>
          <td class="point-amount earned">+5P</td>
          <td>84P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/04/06</td>
          <td class="point-description">게시글 작성 [캠핑장비 렌탈 후기: 텐트 체험기]</td>
          <td class="point-amount earned">+1P</td>
          <td>79P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/04/05</td>
          <td class="point-description">게시글 작성 [텐트 추천 부탁드립니다]</td>
          <td class="point-amount earned">+1P</td>
          <td>78P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/04/03</td>
          <td class="point-description">인기글 지정 [제 첫 캠핑 후기입니다]</td>
          <td class="point-amount earned">+5P</td>
          <td>77P</td>
        </tr>

        <!-- 포인트 차감 내역 -->
        <tr class="point-used-row">
          <td>2025/04/01</td>
          <td class="point-description">허위 신고 처벌 [부적절한 콘텐츠 신고]</td>
          <td class="point-amount used">-5P</td>
          <td>72P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/03/30</td>
          <td class="point-description">게시글 작성 [제 첫 캠핑 후기입니다]</td>
          <td class="point-amount earned">+1P</td>
          <td>77P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/03/28</td>
          <td class="point-description">이벤트 참여 보너스 [봄맞이 캠핑 이벤트]</td>
          <td class="point-amount earned">+10P</td>
          <td>76P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/03/25</td>
          <td class="point-description">인기글 지정 [캠핑장 추천해주세요]</td>
          <td class="point-amount earned">+5P</td>
          <td>66P</td>
        </tr>

        <!-- 포인트 획득 내역 -->
        <tr class="point-earned-row">
          <td>2025/03/25</td>
          <td class="point-description">게시글 작성 [캠핑장 추천해주세요]</td>
          <td class="point-amount earned">+1P</td>
          <td>61P</td>
        </tr>

        <!-- 포인트 차감 내역 -->
        <tr class="point-used-row">
          <td>2025/03/20</td>
          <td class="point-description">신고 처벌 [커뮤니티 가이드라인 위반]</td>
          <td class="point-amount used">-5P</td>
          <td>60P</td>
        </tr>
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
            <li><span class="badge bg-success">+?P</span> 이벤트 참여 (이벤트별 상이)</li>
          </ul>
        </div>
        <div class="point-rule-section">
          <h5 class="point-rule-title">포인트 차감 사유</h5>
          <ul class="point-rule-list">
            <li><span class="badge bg-danger">-5P</span> 신고 처벌</li>
            <li><span class="badge bg-danger">-5P</span> 허위 신고 처벌</li>
          </ul>
        </div>
        <div class="point-rule-section">
          <h5 class="point-rule-title">회원 등급 기준</h5>
          <ul class="point-rule-list grade-list">
            <li><span class="badge bg-secondary">브론즈</span> 포인트+신뢰도 합산 100점 미만</li>
            <li><span class="badge bg-secondary" style="background-color: #C0C0C0 !important;">실버</span> 포인트+신뢰도 합산 100~199점</li>
            <li><span class="badge bg-secondary" style="background-color: #FFD700 !important; color: #000 !important;">골드</span> 포인트+신뢰도 합산 200~299점</li>
            <li><span class="badge bg-secondary" style="background-color: #50C8FF !important;">다이아몬드</span> 포인트+신뢰도 합산 300점 이상</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- 페이징 처리 -->
    <div class="pagination-container d-flex justify-content-center">
      <ul class="pagination">
        <li class="page-item disabled">
          <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
            <i class="fas fa-angle-double-left"></i>
          </a>
        </li>
        <li class="page-item disabled">
          <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
            <i class="fas fa-angle-left"></i>
          </a>
        </li>
        <li class="page-item active"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
          <a class="page-link" href="#">
            <i class="fas fa-angle-right"></i>
          </a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">
            <i class="fas fa-angle-double-right"></i>
          </a>
        </li>
      </ul>
    </div>

  </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
  $(document).ready(function() {
    // 탭 클릭 이벤트
    $('.tab-link').click(function(e) {
      e.preventDefault();
      $('.tab-link').removeClass('active');
      $(this).addClass('active');

      // 여기에 탭 필터링 로직 추가
      const tabType = $(this).text().trim();

      if (tabType === '전체 내역') {
        $('.point-earned-row, .point-used-row').show();
      } else if (tabType === '획득 내역') {
        $('.point-earned-row').show();
        $('.point-used-row').hide();
      } else if (tabType === '차감 내역') {
        $('.point-earned-row').hide();
        $('.point-used-row').show();
      }
    });

    // 날짜 필터 변경 이벤트
    $('.date-filter select').change(function() {
      // 날짜 필터링 기능 구현 (실제 구현 시에는 여기에 필터링 로직 추가)
      console.log('날짜 필터가 변경되었습니다: ' + $(this).val());
    });

    // 페이지네이션 클릭 이벤트
    $('.page-link').click(function(e) {
      if (!$(this).parent().hasClass('disabled') && !$(this).parent().hasClass('active')) {
        e.preventDefault();
        $('.page-item').removeClass('active');
        $(this).parent().addClass('active');
        // 페이지 이동 기능 구현 (실제 구현 시에는 여기에 페이지 이동 로직 추가)
      }
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
    background: linear-gradient(90deg, #C0C0C0 0%, #FFD700 100%);
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