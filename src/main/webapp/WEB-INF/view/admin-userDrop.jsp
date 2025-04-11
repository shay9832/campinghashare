<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템 - 활동정지회원 조회</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-userDrop.css">
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

  <!-- 콘텐츠 영역 - 실제 데이터와 컨트롤이 표시되는 부분 -->
  <div id="content">
    <!-- 콘텐츠 헤더 - 페이지 제목 -->
    <div class="content-header">
      <h2>활동정지회원 조회</h2>
    </div>

    <!-- 검색 영역 - 회원 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>검색유형</span>
      <select>
        <option>회원코드</option>
        <option>회원이름</option>
        <option>관리자ID</option>
        <option>정지사유</option>
      </select>

      <!-- 정지상태 선택 -->
      <span>정지상태</span>
      <select>
        <option>전체</option>
        <option>정지 중</option>
        <option>정지해제</option>
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

    <!-- 정지 회원 정보 요약 - 주요 통계 -->
    <div class="user-count">
      <div class="user-suspended">
        <span>정지 중 회원 : 87명</span>
      </div>
      <div class="user-released">
        <span>정지 해제 회원 : 125명</span>
      </div>
      <div class="user-today">
        <span>오늘 정지된 회원 : 5명</span>
      </div>
    </div>

    <!-- 전체 선택 체크박스 -->
    <div class="select-all-checkbox">
      <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
    </div>

    <!-- 회원 목록 테이블 - 가로 스크롤 가능 -->
    <div class="user-index">
      <table>
        <tr>
          <!-- 테이블 헤더 - 각 열의 제목 -->
          <th class="col-select">선택</th>
          <th class="col-admin-code">관리자 회원코드</th>
          <th class="col-admin-id">관리자ID</th>
          <th class="col-user-code">정지회원 회원코드</th>
          <th class="col-user-name">회원이름</th>
          <th class="col-suspend-date">정지시작일자</th>
          <th class="col-release-date">정지해제일자</th>
          <th class="col-reason">정지사유</th>
          <th class="col-status">정지상태</th>
        </tr>

        <!-- 활동정지 회원 데이터 행 -->
        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>ADMIN001</td>
          <td>admin_park</td>
          <td>USER1234</td>
          <td>김철수</td>
          <td>2025-04-01</td>
          <td>2025-04-15</td>
          <td>커뮤니티 규정 위반(욕설/비방)</td>
          <td><span class="status-badge status-suspended">정지 중</span></td>
        </tr>

        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>ADMIN002</td>
          <td>admin_kim</td>
          <td>USER2345</td>
          <td>이영희</td>
          <td>2025-03-20</td>
          <td>2025-04-03</td>
          <td>불법 거래 시도</td>
          <td><span class="status-badge status-suspended">정지 중</span></td>
        </tr>

        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>ADMIN001</td>
          <td>admin_park</td>
          <td>USER3456</td>
          <td>박민수</td>
          <td>2025-03-15</td>
          <td>2025-03-25</td>
          <td>허위 정보 등록</td>
          <td><span class="status-badge status-released">정지중</span></td>
        </tr>

        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>ADMIN003</td>
          <td>admin_lee</td>
          <td>USER4567</td>
          <td>정지원</td>
          <td>2025-04-05</td>
          <td>2025-04-12</td>
          <td>사기 거래 행위</td>
          <td><span class="status-badge status-suspended">정지 중</span></td>
        </tr>

        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>ADMIN002</td>
          <td>admin_kim</td>
          <td>USER5678</td>
          <td>최하은</td>
          <td>2025-03-10</td>
          <td>2025-03-20</td>
          <td>개인정보 불법 수집</td>
          <td><span class="status-badge status-released">정지중</span></td>
        </tr>
      </table>
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

  // 전체 선택 체크박스 기능 구현
  const selectAllCheckbox = document.getElementById('selectAll');
  const checkboxes = document.querySelectorAll('.user-index input[type="checkbox"]');

  // 전체 선택 체크박스 이벤트 리스너
  selectAllCheckbox.addEventListener('change', function() {
    // 모든 체크박스를 전체 선택 체크박스와 같은 상태로 설정
    checkboxes.forEach(checkbox => {
      checkbox.checked = this.checked;
    });
  });

  // 개별 체크박스 상태 변화에 따른 전체 선택 체크박스 상태 업데이트
  checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      // 모든 체크박스가 선택되었는지 확인
      const allChecked = Array.from(checkboxes).every(cb => cb.checked);
      // 전체 선택 체크박스 상태 업데이트
      selectAllCheckbox.checked = allChecked;
    });
  });

  // 정지해제 버튼 기능
  const releaseButtons = document.querySelectorAll('.release-btn');

  releaseButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 확인 대화상자 표시
      if (confirm('해당 회원의 활동정지를 해제하시겠습니까?')) {
        // 버튼이 속한 행 찾기
        const row = this.closest('tr');

        // 상태 셀의 배지 요소 찾기
        const statusBadge = row.querySelector('.status-badge');

        // 상태를 '정지해제'로 변경
        statusBadge.className = 'status-badge status-released';
        statusBadge.textContent = '정지해제';

        // 버튼을 '상세보기'로 변경
        this.textContent = '상세보기';
        this.classList.remove('release-btn');

        // 현재 날짜를 정지해제일자 열에 설정
        const today = new Date();
        const formattedDate = today.getFullYear() + '-' +
                String(today.getMonth() + 1).padStart(2, '0') + '-' +
                String(today.getDate()).padStart(2, '0');

        // 정지해제일자 열 업데이트
        row.cells[5].textContent = formattedDate;
      }
    });
  });
</script>
</body>
</html>