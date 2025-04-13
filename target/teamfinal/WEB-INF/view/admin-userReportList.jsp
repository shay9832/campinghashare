<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템 - 신고처리내역</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-userReportList.css">
</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 -->
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
      <h2>신고처리내역</h2>
    </div>

    <!-- 검색 영역 - 처리내역 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>검색항목</span>
      <select>
        <option>신고접수 ID</option>
        <option>신고자</option>
        <option>피신고자</option>
        <option>관리자</option>
      </select>

      <span>분류</span>
      <select>
        <option>전체</option>
        <option>게시물</option>
        <option>댓글</option>
        <option>렌탈댓글</option>
      </select>

      <span>유형</span>
      <select>
        <option>전체</option>
        <option>스팸</option>
        <option>욕설/비방</option>
        <option>음란물</option>
        <option>기타</option>
      </select>

      <!-- 처리일 범위 선택 -->
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

    <!-- 처리내역 요약 - 주요 통계 -->
    <div class="report-summary">
      <div class="summary-box total-processed">
        <span>총 처리건수: 853건</span>
      </div>
      <div class="summary-box by-post">
        <span>게시물 처리: 325건</span>
      </div>
      <div class="summary-box by-comment">
        <span>댓글 처리: 418건</span>
      </div>
      <div class="summary-box by-rental">
        <span>렌탈댓글 처리: 110건</span>
      </div>
    </div>

    <!-- 처리내역 테이블 - 가로 스크롤 가능 -->
    <div class="report-table">
      <table>
        <tr>
          <!-- 테이블 헤더 - 각 열의 제목 -->
          <th class="col-report-id">신고ID</th>
          <th class="col-reporter">신고자</th>
          <th class="col-reported">피신고자</th>
          <th class="col-category">분류</th>
          <th class="col-report-type">신고유형</th>
          <th class="col-report-content">신고내용</th>
          <th class="col-report-date">신고일</th>
          <th class="col-admin-id">처리 관리자</th>
          <th class="col-process-detail">처리내용</th>
          <th class="col-process-date">처리일</th>
          <th class="col-penalty">제재내용</th>
        </tr>

        <!-- 처리내역 데이터 행 -->
        <tr>
          <td>10023</td>
          <td>나무빛</td>
          <td>파랑새</td>
          <td><span class="category-badge category-post">게시물</span></td>
          <td><span class="report-type-badge type-abuse">욕설/비방</span></td>
          <td><span class="report-content">상품 문의 게시글에 불필요한 욕설을 사용하여 불쾌감을 주었습니다.</span></td>
          <td>2025-04-05</td>
          <td>admin01</td>
          <td><span class="process-detail">해당 게시물의 욕설 부분 삭제 처리 및 작성자에게 경고 조치</span></td>
          <td>2025-04-05</td>
          <td><span class="penalty-badge penalty-permanent">영구정지</span></td>
        </tr>

        <tr>
          <td>10022</td>
          <td>별빛달</td>
          <td>구름꽃</td>
          <td><span class="category-badge category-comment">댓글</span></td>
          <td><span class="report-type-badge type-adult">음란물</span></td>
          <td><span class="report-content">부적절한 내용의 링크를 댓글에 게시하였습니다.</span></td>
          <td>2025-04-04</td>
          <td>admin02</td>
          <td><span class="process-detail">불법 음란물 관련 링크 확인 후 해당 댓글 삭제 및 계정 일시정지 7일 조치</span></td>
          <td>2025-04-05</td>
          <td><span class="penalty-badge penalty-temporary">일시정지</span></td>
        </tr>

        <tr>
          <td>10021</td>
          <td>바람길</td>
          <td>햇살봄</td>
          <td><span class="category-badge category-rental">렌탈댓글</span></td>
          <td><span class="report-type-badge type-spam">스팸</span></td>
          <td><span class="report-content">동일한 광고성 댓글을 다수의 렌탈 상품에 반복 게시하였습니다.</span></td>
          <td>2025-04-03</td>
          <td>admin01</td>
          <td><span class="process-detail">해당 계정의 스팸 댓글 패턴 확인 후 모든 관련 댓글 일괄 삭제 처리</span></td>
          <td>2025-04-04</td>
          <td><span class="penalty-badge penalty-none">제재없음</span></td>
        </tr>

        <tr>
          <td>10020</td>
          <td>푸른초원</td>
          <td>달빛별</td>
          <td><span class="category-badge category-post">게시물</span></td>
          <td><span class="report-type-badge type-etc">기타</span></td>
          <td><span class="report-content">해당 게시물 내용이 타인의 저작권을 침해한다고 생각됩니다.</span></td>
          <td>2025-04-03</td>
          <td>admin03</td>
          <td><span class="process-detail">저작권 침해 여부 확인을 위한 게시물 검토. 원저작자 확인 후 저작권 침해 사실 없음 확인.</span></td>
          <td>2025-04-04</td>
          <td><span class="penalty-badge penalty-none">제재없음</span></td>
        </tr>

        <tr>
          <td>10019</td>
          <td>구름나래</td>
          <td>하늘빛</td>
          <td><span class="category-badge category-comment">댓글</span></td>
          <td><span class="report-type-badge type-abuse">욕설/비방</span></td>
          <td><span class="report-content">상대방을 심하게 모욕하는 내용의 댓글을 계속해서 작성하고 있습니다.</span></td>
          <td>2025-04-02</td>
          <td>admin01</td>
          <td><span class="process-detail">해당 계정의 이전 신고 이력 확인 결과 3회 이상 동일 유형 위반으로 확인. 영구정지 조치.</span></td>
          <td>2025-04-03</td>
          <td><span class="penalty-badge penalty-permanent">영구정지</span></td>
        </tr>
      </table>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
      <button class="page-btn first-page">&laquo;</button>
      <button class="page-btn prev-page">&lt;</button>
      <div class="page-numbers">
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn">4</button>
        <button class="page-btn">5</button>
      </div>
      <button class="page-btn next-page">&gt;</button>
      <button class="page-btn last-page">&raquo;</button>
    </div>
  </div>
</div>

<!-- 자바스크립트 - 페이지 기능 구현 -->
<script>
  // 드롭다운 메뉴 기능 구현
  // 모든 메뉴 버튼 요소 선택
  const menuButtons = document.querySelectorAll('.menu-button');

  // 각 메뉴 버튼에 클릭 이벤트 리스너 추가
  menuButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 클릭된 버튼에 활성화 클래스 토글 (추가/제거)
      this.classList.toggle('active');

      // 버튼 다음 요소(하위메뉴) 가져오기
      const submenu = this.nextElementSibling;

      // 하위메뉴 표시 상태 체크 및 변경
      if (submenu.style.maxHeight) {
        // 열려있으면 닫기
        submenu.style.maxHeight = null;
      } else {
        // 닫혀있으면 열기 (콘텐츠 높이만큼)
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
      }
    });
  });

  // 페이지네이션 기능 구현
  document.addEventListener('DOMContentLoaded', function() {
    const pageButtons = document.querySelectorAll('.page-numbers .page-btn');
    const firstPageBtn = document.querySelector('.first-page');
    const prevPageBtn = document.querySelector('.prev-page');
    const nextPageBtn = document.querySelector('.next-page');
    const lastPageBtn = document.querySelector('.last-page');

    // 현재 페이지를 관리하는 상태 변수
    let currentPage = 1;
    const totalPages = 5; // 예시로 5페이지로 설정 (실제로는 데이터 기반으로 계산)

    // 페이지 버튼 클릭 이벤트
    pageButtons.forEach(button => {
      button.addEventListener('click', function() {
        // 현재 활성화된 버튼에서 active 클래스 제거
        document.querySelector('.page-btn.active').classList.remove('active');
        // 클릭한 버튼에 active 클래스 추가
        this.classList.add('active');
        // 현재 페이지 업데이트
        currentPage = parseInt(this.textContent);

        // 여기에 실제 데이터 로드 또는 페이지 변경 로직 추가
        console.log('페이지 변경:', currentPage);

        // 처음/이전/다음/마지막 버튼 상태 업데이트
        updateNavigationButtons();
      });
    });

    // 처음 페이지 버튼 클릭 이벤트
    firstPageBtn.addEventListener('click', function() {
      if (currentPage !== 1) {
        goToPage(1);
      }
    });

    // 이전 페이지 버튼 클릭 이벤트
    prevPageBtn.addEventListener('click', function() {
      if (currentPage > 1) {
        goToPage(currentPage - 1);
      }
    });

    // 다음 페이지 버튼 클릭 이벤트
    nextPageBtn.addEventListener('click', function() {
      if (currentPage < totalPages) {
        goToPage(currentPage + 1);
      }
    });

    // 마지막 페이지 버튼 클릭 이벤트
    lastPageBtn.addEventListener('click', function() {
      if (currentPage !== totalPages) {
        goToPage(totalPages);
      }
    });

    // 특정 페이지로 이동하는 함수
    function goToPage(pageNumber) {
      // 현재 활성화된 버튼에서 active 클래스 제거
      document.querySelector('.page-btn.active').classList.remove('active');
      // 새 페이지 버튼에 active 클래스 추가
      pageButtons[pageNumber - 1].classList.add('active');
      // 현재 페이지 업데이트
      currentPage = pageNumber;

      // 여기에 실제 데이터 로드 또는 페이지 변경 로직 추가
      console.log('페이지 변경:', currentPage);

      // 처음/이전/다음/마지막 버튼 상태 업데이트
      updateNavigationButtons();
    }

    // 네비게이션 버튼 상태 업데이트 함수
    function updateNavigationButtons() {
      // 첫 페이지일 경우 처음/이전 버튼 비활성화
      firstPageBtn.disabled = currentPage === 1;
      prevPageBtn.disabled = currentPage === 1;

      // 마지막 페이지일 경우 다음/마지막 버튼 비활성화
      nextPageBtn.disabled = currentPage === totalPages;
      lastPageBtn.disabled = currentPage === totalPages;
    }

    // 초기 상태 설정
    updateNavigationButtons();
  });
</script>
</body>