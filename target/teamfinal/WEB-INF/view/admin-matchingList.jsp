<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템 - 매칭현황</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-matchingList.css">
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
      <h2>매칭현황</h2>
    </div>

    <!-- 렌탈 타입 탭 메뉴 -->
    <div class="rental-type-tabs">
      <div class="rental-tab active" data-tab="store-rentals">스토렌</div>
      <div class="rental-tab" data-tab="regular-rentals">일반렌탈</div>
    </div>

    <!-- 검색 영역 - 매칭현황 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>검색항목</span>
      <select>
        <option>소유자이름</option>
        <option>게시글이름</option>
      </select>

      <span>상태</span>
      <select>
        <option>전체</option>
        <option>승인대기</option>
        <option>승인완료</option>
      </select>

      <span>렌탈타입</span>
      <select>
        <option>스토렌</option>
        <option>일반렌탈</option>
      </select>

      <!-- 렌탈기간 범위 선택 -->
      <div class="content-search-date">
        <span>렌탈기간</span>
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

    <!-- 스토렌 영역 -->
    <div id="store-rentals" class="content-area">
      <!-- 매칭현황 요약 - 주요 통계 -->
      <div class="matching-summary">
        <div class="summary-box total-matches">
          <span>스토렌 매칭 건수: 152건</span>
        </div>
        <div class="summary-box pending-matches">
          <span>승인대기: 18건</span>
        </div>
        <div class="summary-box approved-matches">
          <span>승인완료: 134건</span>
        </div>
        <div class="summary-box current-rentals">
          <span>현재 렌탈중: 29건</span>
        </div>
      </div>

      <!-- 매칭현황 테이블 - 가로 스크롤 가능 -->
      <div class="matching-table">
        <table>
          <tr>
            <!-- 테이블 헤더 - 각 열의 제목 -->
            <th class="col-rental-id">스토렌ID</th>
            <th class="col-equip-code">장비코드</th>
            <th class="col-rental-title">스토렌제목</th>
            <th class="col-rental-required-code">매칭신청자코드</th>
            <th class="col-rental-start">렌탈시작일</th>
            <th class="col-rental-end">렌탈종료일</th>
            <th class="col-matching-start">매칭신청일</th>
            <th class="col-approve-status">승인여부</th>
            <th class="col-approve-start">승인일자</th>
          </tr>
          <!-- 스토렌현황 데이터 행 -->

          <!--스토렌ID, "장비_코드", "스토렌_제목", "스토렌매칭신청자코드", "렌탈_시작일", "렌탈_종료일", "매칭신청일", "승인여부", "승인_일자"-->
          <c:forEach var="rental" items="${getList}">
            <tr>
             <td>${rental.rentalId}</td>
             <td>${rental.equipCode}</td>
             <td>${rental.rentalTitle}</td>
             <td>${rental.rentalMatchingReq}</td>
             <td>${rental.rentalStart}</td>
             <td>${rental.rentalEnd}</td>
             <td>${rental.matchingStart}</td>
             <td>${rental.approveStatus}</td>
             <td>${rental.approveDate}</td>
            </tr>
          </c:forEach>
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

    <!-- 일반렌탈 영역 -->
    <div id="regular-rentals" class="content-area">
      <!-- 매칭현황 요약 - 주요 통계 -->
      <div class="matching-summary">
        <div class="summary-box total-matches">
          <span>일반렌탈 매칭 건수: 204건</span>
        </div>
        <div class="summary-box pending-matches">
          <span>승인대기: 24건</span>
        </div>
        <div class="summary-box approved-matches">
          <span>승인완료: 180건</span>
        </div>
        <div class="summary-box current-rentals">
          <span>현재 렌탈중: 39건</span>
        </div>
      </div>

      <!-- 매칭현황 테이블 - 가로 스크롤 가능 -->
      <div class="matching-table">
        <table>
          <tr>
            <!-- 테이블 헤더 - 각 열의 제목 -->
            <th class="col-rental-id">렌탈ID</th>
            <th class="col-equip-code">장비코드</th>
            <th class="col-rental-title">렌탈제목</th>
            <th class="col-rental-required-code">렌탈신청자코드</th>
            <th class="col-rental-start">렌탈시작일</th>
            <th class="col-rental-end">렌탈종료일</th>
            <th class="col-matching-start">매칭신청일</th>
            <th class="col-approve-status">승인여부</th>
            <th class="col-approve-start">승인일자</th>
          </tr>

          <!-- 매칭현황 데이터 행 - 일반렌탈만 표시 -->
          <c:forEach var="rental" items="${getLists}">
          <tr>
            <td>${rental.rentalId}</td>
            <td>${rental.equipCode}</td>
            <td>${rental.rentalTitle}</td>
            <td>${rental.rentalMatchingReq}</td>
            <td>${rental.rentalStart}</td>
            <td>${rental.rentalEnd}</td>
            <td>${rental.matchingStart}</td>
            <td>${rental.approveStatus}</td>
            <td>${rental.approveDate}</td>
          </tr>
          </c:forEach>
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

      // 렌탈 타입 탭 기능 구현
      document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.rental-tab');

        // 페이지 로드 시 첫 번째 탭(스토렌)을 기본으로 활성화
        const defaultTab = document.querySelector('[data-tab="store-rentals"]');
        defaultTab.classList.add('active');
        document.getElementById('store-rentals').classList.add('active');

        tabs.forEach(tab => {
          tab.addEventListener('click', function() {
            // 모든 탭에서 active 클래스 제거
            tabs.forEach(t => t.classList.remove('active'));

            // 클릭된 탭에 active 클래스 추가
            this.classList.add('active');

            // 모든 콘텐츠 영역 숨기기
            const contentAreas = document.querySelectorAll('.content-area');
            contentAreas.forEach(area => area.classList.remove('active'));

            // 클릭된 탭에 해당하는 콘텐츠 영역 표시
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
          });
        });
      });

      // 페이지네이션 기능 구현
      document.addEventListener('DOMContentLoaded', function() {
        // 모든 페이지네이션 영역에 대해 기능 적용
        const paginationAreas = document.querySelectorAll('.pagination');

        paginationAreas.forEach(pagination => {
          const pageButtons = pagination.querySelectorAll('.page-numbers .page-btn');
          const firstPageBtn = pagination.querySelector('.first-page');
          const prevPageBtn = pagination.querySelector('.prev-page');
          const nextPageBtn = pagination.querySelector('.next-page');
          const lastPageBtn = pagination.querySelector('.last-page');

          // 현재 페이지를 관리하는 상태 변수
          let currentPage = 1;
          const totalPages = 5; // 예시로 5페이지로 설정 (실제로는 데이터 기반으로 계산)

          // 페이지 버튼 클릭 이벤트
          pageButtons.forEach(button => {
            button.addEventListener('click', function() {
              // 현재 활성화된 버튼에서 active 클래스 제거
              pagination.querySelector('.page-btn.active').classList.remove('active');
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
            pagination.querySelector('.page-btn.active').classList.remove('active');
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
      });
    </script>
  </div>
</div>
</body>
