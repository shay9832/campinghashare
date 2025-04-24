<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-userReport.css">
</head>
<body>
<jsp:include page="/WEB-INF/view/admin-header.jsp" />

<!-- 메인 컨테이너 -->
<div id="container">
  <!-- 좌측 메뉴 영역 -->
  <div id="leftMenu">
    <!-- (왼쪽 메뉴 부분은 변경 없음) -->
    <!-- 장비 관리 메뉴 -->
    <button class="menu-button">장비 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-equipList.action" method="get">
        <button type="submit" class="submenu-btn">장비 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-equipStatistics.action" method="get">
        <button type="submit" class="submenu-btn">장비 통계</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get">
        <button type="submit" class="submenu-btn">브랜드 및 장비생성</button>
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
      <h2>신고목록</h2>
    </div>

    <!-- 검색 영역 - 회원 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>유형</span>
      <select>
        <option>회원번호</option>
        <option>이름</option>
        <option>닉네임</option>
      </select>

      <!-- 날짜 범위 선택 -->
      <div class="content-search-date">
        <input type="date">
        <span>~</span>
        <input type="date">
      </div>

      <!-- 검색어 입력 -->
      <div class="content-search-bar">
        <input type="search" name="searchKeyword" placeholder="검색어 입력">
      </div>

      <!-- 검색 버튼 -->
      <div class="content-search-btn">
        <input type="button" value="검색하기">
      </div>
    </div>

    <!-- 신고 정보 요약 - 주요 통계 -->
    <div class="user-count">
      <div class="user-all">
        <span>총 신고건수 : ${totalReportCount}건</span>
      </div>
      <div class="user-drop">
        <span>총 게시글 신고 건수 : ${totalPostReportCount}건</span>
      </div>
      <div class="user-new">
        <span>총 댓글 신고 건수 : ${totalCommentReportCount}건</span>
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
          <th class="col-report-id">신고ID</th>
          <th class="col-reporter">신고자</th>
          <th class="col-reported">피신고자</th>
          <th class="col-category">분류</th>
          <th class="col-report-type">신고유형</th>
          <th class="col-report-content">신고내용</th>
          <th class="col-report-date">신고일</th>
          <th class="col-admin-id">관리자</th>
          <th class="col-reporter-type">신고자/피신고자</th>
          <th class="col-status">처리상태</th>
          <th class="col-process-date">처리일</th>
        </tr>

        <%-- 신고 데이터 행 반복 시작 --%>
        <c:forEach var="report" items="${getList}">
          <tr>
            <td class="checkbox-column"><input type="checkbox"></td>
            <td>${report.post_report_id}</td>
            <td>${report.nickname1}</td>
            <td>${report.nickname2}</td> <%-- 피신고자 닉네임도 같은 속성 사용 (매퍼에서 중복됨) --%>
            <td><span class="category-badge category-${report.post_id}">${report.post_id}</span></td>
            <td><span class="report-type-badge type-${report.report_content}">${report.report_type_name}</span></td>
            <td><span class="report-content">${report.report_content}</span></td>
            <td>${report.report_date}</td>
            <td>${report.admin_id}</td>
            <td>
              <select class="reporter-type-select" data-reporter="${report.nickname1}" data-reported="${report.nickname2}">
                <option class="user-option" value="reporter">${report.nickname1}</option>
                <option class="admin-option" value="reported">${report.nickname2}</option>
              </select>
            </td>
            <td>
              <div class="toggle-label">
                <label class="toggle-switch">
                  <input type="checkbox" ${report.process_status eq '처리완료' ? 'checked' : ''}
                         onchange="confirmStatusChange(this, ${report.post_report_id}, '${report.post_id}', '${report.report_type_name}', '${report.report_content}')">
                  <span class="slider"></span>
                </label>
              </div>
            </td>
            <td>${report.completed_date}</td>
          </tr>
        </c:forEach>
        <%-- 신고 데이터 행 반복 끝 --%>
      </table>
    </div>

    <!--페이지네이션-->
    <div class="pagination">
      <button class="page-btn first-page">&laquo;</button>
      <button class="page-btn prev-page">&lt;</button>
      <div class="page-numbers">
        <%-- 페이지 번호 동적 생성 --%>
        <c:forEach begin="1" end="${totalPages}" var="pageNum">
          <button class="page-btn ${pageNum == currentPage ? 'active' : ''}">${pageNum}</button>
        </c:forEach>
      </div>
      <button class="page-btn next-page">&gt;</button>
      <button class="page-btn last-page">&raquo;</button>
    </div>
  </div>
</div>

<!-- 모달 요소를 테이블 바깥으로 이동 -->
<div id="confirmModal" class="modal">
  <div class="modal-content">
    <h3>처리 상태 변경 확인</h3>
    <p id="modalMessage">정말로 이 신고의 처리 상태를 변경하시겠습니까?</p>
    <div class="modal-details">
      <p><strong>신고 ID:</strong> <span id="modalReportId"></span></p>
      <p><strong>분류:</strong> <span id="modalCategory"></span></p>
      <p><strong>신고 유형:</strong> <span id="modalReportType"></span></p>
      <p><strong>신고 내용:</strong> <span id="modalReportContent"></span></p>
      <p><strong>선택된 사용자:</strong> <span id="modalSelectedPerson"></span></p>
    </div>
    <div class="modal-buttons">
      <button onclick="confirmStatus()">확인</button>
      <button onclick="cancelStatusChange()">취소</button>
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
  const rowCheckboxes = document.querySelectorAll('.user-index td.checkbox-column input[type="checkbox"]');

  // 전체 선택 체크박스 이벤트 리스너
  selectAllCheckbox.addEventListener('change', function() {
    // 모든 체크박스를 전체 선택 체크박스와 같은 상태로 설정
    rowCheckboxes.forEach(checkbox => {
      checkbox.checked = this.checked;
    });
  });

  // 개별 체크박스 상태 변화에 따른 전체 선택 체크박스 상태 업데이트
  rowCheckboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      // 모든 체크박스가 선택되었는지 확인
      const allChecked = Array.from(rowCheckboxes).every(cb => cb.checked);
      // 전체 선택 체크박스 상태 업데이트
      selectAllCheckbox.checked = allChecked;
    });
  });

  // 모달 관련 변수
  let currentToggle = null;
  let currentReportId = null;

  // 상태 변경 확인 모달 표시 함수
  function confirmStatusChange(checkbox, reportId, category, reportType, reportContent) {
    // 토글 상태 변경 전에 이전 상태 저장
    currentToggle = checkbox;
    currentReportId = reportId;

    // 체크 상태를 원래대로 되돌리기 (모달로 확인 후 변경하기 위해)
    checkbox.checked = !checkbox.checked;

    // 선택된 신고자/피신고자 가져오기
    const row = checkbox.closest('tr');
    const selectElement = row.querySelector('.reporter-type-select');
    const selectedOption = selectElement.options[selectElement.selectedIndex];
    const selectedType = selectedOption.value;
    const selectedText = selectedOption.text;

    // 모달 내용 설정
    document.getElementById('modalReportId').textContent = reportId;
    document.getElementById('modalCategory').textContent = category;
    document.getElementById('modalReportType').textContent = reportType;
    document.getElementById('modalReportContent').textContent = reportContent;
    document.getElementById('modalSelectedPerson').textContent = selectedText;

    // 메시지 설정 (처리중 -> 처리완료 or 처리완료 -> 처리중)
    const newStatus = !checkbox.checked ? '처리완료' : '처리중';
    document.getElementById('modalMessage').textContent =
            `정말로 이 신고의 처리 상태를 '${newStatus}'(으)로 변경하시겠습니까?`;

    // 모달 표시
    document.getElementById('confirmModal').style.display = 'flex';
  }

  // 모달 닫기
  function closeModal() {
    document.getElementById('confirmModal').style.display = 'none';
  }

  // 상태 변경 취소
  function cancelStatusChange() {
    closeModal();
    // 상태는 변경하지 않음
  }

  // 상태 변경 확인
  function confirmStatus() {
    if (currentToggle) {
      // 토글 상태 변경
      currentToggle.checked = !currentToggle.checked;

      // 실제 상태 업데이트 수행
      updateStatus(currentToggle);

      // 모달 닫기
      closeModal();
    }
  }

  // 토글 상태 업데이트 함수
  function updateStatus(checkbox) {
    // 토글 스위치의 부모 요소 찾기
    const toggleLabel = checkbox.closest('.toggle-label');

    // 상태 텍스트 요소 찾기 또는 생성
    let statusText = toggleLabel.querySelector('.toggle-status');
    if (!statusText) {
      statusText = document.createElement('span');
      statusText.className = 'toggle-status';
      toggleLabel.appendChild(statusText);
    }

    // 체크 상태에 따라 텍스트와 클래스 업데이트
    if (checkbox.checked) {
      statusText.textContent = '처리완료';
      statusText.className = 'toggle-status resolved';

      // 처리일 업데이트 (현재 행의 처리일 열)
      const row = toggleLabel.closest('tr');
      const processDateCell = row.querySelector('td:last-child');

      // 아직 처리되지 않았던 경우(날짜가 "-"인 경우)에만 현재 날짜로 업데이트
      if (processDateCell.textContent === '-') {
        const today = new Date();
        const formattedDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
        processDateCell.textContent = formattedDate;
      }
    } else {
      statusText.textContent = '처리중';
      statusText.className = 'toggle-status pending';

      // 처리중으로 변경 시 처리일 초기화
      const row = toggleLabel.closest('tr');
      const processDateCell = row.querySelector('td:last-child');
      processDateCell.textContent = '-';
    }

    // 여기에 서버로 상태 변경을 전송하는 코드 추가 가능
    // 예: Ajax 요청으로 서버에 상태 변경 정보 전송
    console.log('상태 변경:', checkbox.checked ? '처리완료' : '처리중', '신고 ID:', currentReportId);

    // 서버에 상태 변경을 전송하는 예시 코드 (실제 구현 필요)
    /*
    fetch('${pageContext.request.contextPath}/updateReportStatus.action', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        reportId: currentReportId,
        status: checkbox.checked ? '처리완료' : '처리중',
        completedDate: checkbox.checked ? new Date().toISOString().split('T')[0] : null
      })
    })
    .then(response => response.json())
    .then(data => {
      console.log('상태 변경 성공:', data);
    })
    .catch(error => {
      console.error('상태 변경 실패:', error);
      // 실패 시 UI 원래대로 복구
      checkbox.checked = !checkbox.checked;
      updateStatus(checkbox);
    });
    */
  }

  // 페이지 로드 시 모든 토글 스위치 초기화
  document.addEventListener('DOMContentLoaded', function() {
    const toggles = document.querySelectorAll('.toggle-switch input');
    toggles.forEach(toggle => {
      // 토글 상태에 따라 상태 텍스트 요소 추가
      const toggleLabel = toggle.closest('.toggle-label');
      if (!toggleLabel.querySelector('.toggle-status')) {
        const statusText = document.createElement('span');
        statusText.className = 'toggle-status';
        statusText.textContent = toggle.checked ? '처리완료' : '처리중';
        statusText.classList.add(toggle.checked ? 'resolved' : 'pending');
        toggleLabel.appendChild(statusText);
      }
    });

    // 메뉴 상태 초기화 - 활성화된 메뉴는 열린 상태로 시작
    menuButtons.forEach(button => {
      if (button.classList.contains('active')) {
        const submenu = button.nextElementSibling;
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
    let currentPage = ${currentPage}; // 서버에서 전달받은 현재 페이지 번호
    const totalPages = ${totalPages}; // 서버에서 전달받은 총 페이지 수

    // 페이지 버튼 클릭 이벤트
    pageButtons.forEach(button => {
      button.addEventListener('click', function() {
        // 현재 활성화된 버튼에서 active 클래스 제거
        document.querySelector('.page-btn.active').classList.remove('active');
        // 클릭한 버튼에 active 클래스 추가
        this.classList.add('active');
        // 현재 페이지 업데이트
        currentPage = parseInt(this.textContent);

        // 페이지 변경 URL로 이동
        window.location.href = "${pageContext.request.contextPath}/admin-userReport.action?page=" + currentPage;

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
      // 페이지 변경 URL로 이동
      window.location.href = "${pageContext.request.contextPath}/admin-userReport.action?page=" + pageNumber;
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
</html>