<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- JSTL 태그 라이브러리 추가 --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 시스템 - 활동정지회원 조회</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-userDrop.css">
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
      <h2>활동정지회원 조회</h2>
    </div>

    <!-- 검색 영역 - 회원 검색 필터링 옵션 -->
    <div class="content-search-info">
      <form id="searchForm" action="${pageContext.request.contextPath}/admin-userDrop.action" method="get">
        <span>검색유형</span>
        <select name="searchType">
          <option value="userCode">회원코드</option>
          <option value="userName">회원이름</option>
          <option value="adminId">관리자ID</option>
          <option value="reason">정지사유</option>
        </select>

        <!-- 정지상태 선택 -->
        <span>정지상태</span>
        <select name="status">
          <option value="all">전체</option>
          <option value="suspended">정지 중</option>
          <option value="released">정지해제</option>
        </select>

        <!-- 날짜 범위 선택 -->
        <div class="content-search-date">
          <input type="date" name="startDate">
          <span>~</span>
          <input type="date" name="endDate">
        </div>

        <!-- 검색어 입력 -->
        <div class="content-search-bar">
          <input type="search" name="keyword" placeholder="검색어 입력">
        </div>

        <!-- 검색 버튼 -->
        <div class="content-search-btn">
          <input type="submit" value="검색하기">
        </div>
      </form>
    </div>

    <!-- 정지 회원 정보 요약 - 주요 통계 -->
    <div class="user-count">
      <div class="user-suspended">
        <span>정지 중 회원 : <%-- ${suspendedCount} --%>명</span>
      </div>
      <div class="user-released">
        <span>정지 해제 회원 : <%-- ${releasedCount} --%>명</span>
      </div>
      <div class="user-today">
        <span>오늘 정지된 회원 : <%-- ${todaySuspendedCount} --%>명</span>
      </div>
    </div>

    <!-- 관리 버튼 영역 -->
    <div class="management-buttons">
      <button id="releaseSelectedBtn">선택 회원 정지해제</button>
      <button id="detailViewBtn">상세 정보 보기</button>
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

        <%-- 활동정지 회원 데이터 행 (JSTL 루프로 대체) --%>
        <%-- <c:forEach var="user" items="${suspendedUsers}">
        <tr>
          <td class="checkbox-column"><input type="checkbox" name="selectedUsers" value="${user.userCode}"></td>
          <td>${user.adminCode}</td>
          <td>${user.adminId}</td>
          <td>${user.userCode}</td>
          <td>${user.userName}</td>
          <td><fmt:formatDate value="${user.suspendDate}" pattern="yyyy-MM-dd" /></td>
          <td><fmt:formatDate value="${user.releaseDate}" pattern="yyyy-MM-dd" /></td>
          <td>${user.suspendReason}</td>
          <td>
            <span class="status-badge ${user.status eq 'suspended' ? 'status-suspended' : 'status-released'}">
              ${user.status eq 'suspended' ? '정지 중' : '정지해제'}
            </span>
          </td>
        </tr>
        </c:forEach> --%>

        <%-- 데이터가 없을 경우 표시 --%>
        <%-- <c:if test="${empty suspendedUsers}">
        <tr>
          <td colspan="9" class="no-data">검색 결과가 없습니다.</td>
        </tr>
        </c:if> --%>
      </table>
    </div>

    <!-- 페이지네이션 영역 -->
    <div class="pagination">
      <%-- 페이지네이션 컨트롤 JSTL 구현 --%>
      <%-- <c:if test="${totalPages > 1}">
        <ul>
          <li><a href="?page=1&${searchParams}" class="${currentPage == 1 ? 'disabled' : ''}">처음</a></li>
          <li><a href="?page=${currentPage - 1}&${searchParams}" class="${currentPage == 1 ? 'disabled' : ''}">이전</a></li>

          <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
            <li><a href="?page=${pageNum}&${searchParams}" class="${pageNum == currentPage ? 'active' : ''}">${pageNum}</a></li>
          </c:forEach>

          <li><a href="?page=${currentPage + 1}&${searchParams}" class="${currentPage == totalPages ? 'disabled' : ''}">다음</a></li>
          <li><a href="?page=${totalPages}&${searchParams}" class="${currentPage == totalPages ? 'disabled' : ''}">마지막</a></li>
        </ul>
      </c:if> --%>
    </div>
  </div>
</div>

<!-- 자바스크립트 - 페이지 기능 구현 -->
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

  // 전체 선택 체크박스 기능 구현
  const selectAllCheckbox = document.getElementById('selectAll');
  const checkboxes = document.querySelectorAll('.user-index input[type="checkbox"]');

  selectAllCheckbox.addEventListener('change', function() {
    checkboxes.forEach(checkbox => {
      checkbox.checked = this.checked;
    });
  });

  // 개별 체크박스 이벤트 리스너
  checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      const allChecked = Array.from(checkboxes).every(cb => cb.checked);
      selectAllCheckbox.checked = allChecked;
    });
  });

  // 선택 회원 정지해제 버튼 이벤트 리스너
  document.getElementById('releaseSelectedBtn').addEventListener('click', function() {
    const selectedUsers = document.querySelectorAll('.user-index input[type="checkbox"]:checked');

    if (selectedUsers.length === 0) {
      alert('정지해제할 회원을 선택해주세요.');
      return;
    }

    if (confirm('선택한 회원의 활동정지를 해제하시겠습니까?')) {
      // 선택된 회원 코드 배열 생성
      const userCodes = Array.from(selectedUsers).map(checkbox => {
        return checkbox.value;
      });

      // AJAX 요청 또는 폼 제출 로직 구현
      // 예: 폼을 동적으로 생성하여 제출
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = '${pageContext.request.contextPath}/admin-releaseUsers.action';

      // 선택된 회원 코드를 hidden input으로 추가
      userCodes.forEach(code => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'userCodes';
        input.value = code;
        form.appendChild(input);
      });

      document.body.appendChild(form);
      form.submit();
    }
  });

  // 상세 정보 보기 버튼 이벤트 리스너
  document.getElementById('detailViewBtn').addEventListener('click', function() {
    const selectedUsers = document.querySelectorAll('.user-index input[type="checkbox"]:checked');

    if (selectedUsers.length !== 1) {
      alert('상세 정보를 볼 회원을 하나만 선택해주세요.');
      return;
    }

    const userCode = selectedUsers[0].value;
    // 상세 정보 페이지로 이동
    window.location.href = '${pageContext.request.contextPath}/admin-userDetail.action?userCode=' + userCode;
  });
</script>
</body>
</html>