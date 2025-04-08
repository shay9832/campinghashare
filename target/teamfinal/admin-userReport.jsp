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
  <title>관리자 시스템</title> <!-- 브라우저 탭에 표시될 제목 -->

</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 -->
<div id="header">
  <h1>관리자 시스템</h1>
</div>

<!-- 메인 컨테이너 - 메뉴와 콘텐츠 영역 포함 -->
<div id="container">
  <!-- 좌측 메뉴 영역 - 드롭다운 메뉴 -->
  <div id="leftMenu">
    <!-- 회원 관리 메뉴 -->
    <button class="menu-button">회원 관리</button>
    <div class="submenu">
      <a href="#">회원 목록</a>
      <a href="#">제재내역</a>
    </div>

    <!-- 장비 관리 메뉴 -->
    <button class="menu-button">장비 관리</button>
    <div class="submenu">
      <a href="#">장비 목록</a>
      <a href="#">검수 목록</a>
      <a href="#">장비 통계</a>
    </div>

    <!-- 게시판 관리 메뉴 -->
    <button class="menu-button active">게시판 관리</button>
    <div class="submenu">
      <a href="#">게시판 관리</a>
      <a href="#">게시글 관리</a>
      <a href="#">댓글 관리</a>
      <a href="#">커뮤니티 통계</a>
    </div>

    <!-- 신고 관리 메뉴 -->
    <button class="menu-button">신고 관리</button>
    <div class="submenu" style="max-height: 200px;">
      <a href="#" style="color: #3f861d; font-weight: bold; border-left: 2px solid #3f861d;">신고 목록</a>
      <a href="#">처리 내역</a>
    </div>

    <!-- 이벤트 관리 메뉴 -->
    <button class="menu-button">이벤트 관리</button>
    <div class="submenu">
      <a href="#">이벤트 목록</a>
    </div>

    <!-- 배송 관리 메뉴 -->
    <button class="menu-button">배송 관리</button>
    <div class="submenu">
      <a href="#">배송 현황</a>
    </div>

    <!-- 쿠폰 관리 메뉴 -->
    <button class="menu-button">쿠폰 관리</button>
    <div class="submenu">
      <a href="#">쿠폰 발급</a>
      <a href="#">쿠폰 조회</a>
    </div>

    <!-- 거래 카테고리 관리 메뉴 -->
    <button class="menu-button">거래 관리</button>
    <div class="submenu">
      <a href="#">매칭 관리</a>
    </div>

    <!-- 통계 메뉴 -->
    <button class="menu-button">통계</button>
    <div class="submenu">
      <a href="#">일간 통계</a>
      <a href="#">월간 통계</a>
      <a href="#">연간 통계</a>
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
        <input type="search" placeholder="검색어 입력">
      </div>

      <!-- 검색 버튼 -->
      <div class="content-search-btn">
        <input type="button" value="검색하기">
      </div>
    </div>

    <!-- 신고 정보 요약 - 주요 통계 -->
    <div class="user-count">
      <div class="user-all">
        <span>총 신고건수 : 1,234건</span>
      </div>
      <div class="user-drop">
        <span>총 게시글 신고 건수 : 45건</span>
      </div>
      <div class="user-new">
        <span>총 댓글 신고 건수 : 12건</span>
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

        <!-- 신고 데이터 행 샘플 1 -->
        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>10023</td>
          <td>나무빛</td>
          <td>파랑새</td>
          <td><span class="category-badge category-post">게시물</span></td>
          <td><span class="report-type-badge type-abuse">욕설/비방</span></td>
          <td><span class="report-content">상품 문의 게시글에 불필요한 욕설을 사용하여 불쾌감을 주었습니다.</span></td>
          <td>2025-04-05</td>
          <td>admin01</td>
          <td>
            <select class="reporter-type-select" data-reporter="나무빛" data-reported="파랑새">
              <option class="user-option" value="reporter">나무빛</option>
              <option class="admin-option" value="reported">파랑새</option>
            </select>
          </td>
          <td>
            <div class="toggle-label">
              <label class="toggle-switch">
                <input type="checkbox" onchange="confirmStatusChange(this, 10023, '게시물', '욕설/비방', '상품 문의 게시글에 불필요한 욕설을 사용하여 불쾌감을 주었습니다.')">
                <span class="slider"></span>
              </label>
            </div>
          </td>
          <td>-</td>
        </tr>

        <!-- 신고 데이터 행 샘플 2 -->
        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>10024</td>
          <td>꽃잎</td>
          <td>햇살</td>
          <td><span class="category-badge category-comment">댓글</span></td>
          <td><span class="report-type-badge type-spam">스팸</span></td>
          <td><span class="report-content">광고성 링크를 반복적으로 게시하고 있습니다.</span></td>
          <td>2025-04-05</td>
          <td>admin02</td>
          <td>
            <select class="reporter-type-select" data-reporter="꽃잎" data-reported="햇살">
              <option class="user-option" value="reporter">꽃잎</option>
              <option class="admin-option" value="reported">햇살</option>
            </select>
          </td>
          <td>
            <div class="toggle-label">
              <label class="toggle-switch">
                <input type="checkbox" checked onchange="confirmStatusChange(this, 10024, '댓글', '스팸', '광고성 링크를 반복적으로 게시하고 있습니다.')">
                <span class="slider"></span>
              </label>
            </div>
          </td>
          <td>2025-04-06</td>
        </tr>

        <!-- 신고 데이터 행 샘플 3 -->
        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>10025</td>
          <td>관리자</td>
          <td>구름이</td>
          <td><span class="category-badge category-rental">렌탈댓글</span></td>
          <td><span class="report-type-badge type-adult">음란물</span></td>
          <td><span class="report-content">렌탈 문의 댓글에 불필요한 성적인 내용을 포함하고 있습니다.</span></td>
          <td>2025-04-04</td>
          <td>admin01</td>
          <td>
            <select class="reporter-type-select" data-reporter="관리자" data-reported="구름이">
              <option class="user-option" value="reporter">관리자</option>
              <option class="admin-option" value="reported">구름이</option>
            </select>
          </td>
          <td>
            <div class="toggle-label">
              <label class="toggle-switch">
                <input type="checkbox" checked onchange="confirmStatusChange(this, 10025, '렌탈댓글', '음란물', '렌탈 문의 댓글에 불필요한 성적인 내용을 포함하고 있습니다.')">
                <span class="slider"></span>
              </label>
            </div>
          </td>
          <td>2025-04-04</td>
        </tr>

        <!-- 신고 데이터 행 샘플 4 -->
        <tr>
          <td class="checkbox-column"><input type="checkbox"></td>
          <td>10026</td>
          <td>바람결</td>
          <td>산들</td>
          <td><span class="category-badge category-post">게시물</span></td>
          <td><span class="report-type-badge type-etc">기타</span></td>
          <td><span class="report-content">가격을 속이는 허위 정보를 올리고 있습니다.</span></td>
          <td>2025-04-03</td>
          <td>-</td>
          <td>
            <select class="reporter-type-select" data-reporter="바람결" data-reported="산들">
              <option class="user-option" value="reporter">바람결</option>
              <option class="admin-option" value="reported">산들</option>
            </select>
          </td>
          <td>
            <div class="toggle-label">
              <label class="toggle-switch">
                <input type="checkbox" onchange="confirmStatusChange(this, 10026, '게시물', '기타', '가격을 속이는 허위 정보를 올리고 있습니다.')">
                <span class="slider"></span>
              </label>
            </div>
          </td>
          <td>-</td>
        </tr>
      </table>
    </div>

    <!--페이지네이션-->
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

  // 모달 열기
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

    // 상태 텍스트 요소 찾기
    let statusText = toggleLabel.querySelector('.toggle-status');

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
    console.log('상태 변경:', checkbox.checked ? '처리완료' : '처리중', '신고 ID:', currentReportId);
  }

  // 페이지 로드 시 모든 토글 스위치 초기화
  document.addEventListener('DOMContentLoaded', function() {
    const toggles = document.querySelectorAll('.toggle-switch input');
    toggles.forEach(toggle => {
      // 초기 상태 설정
      updateStatus(toggle);
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
<!-- 확인 모달 -->
<div id="confirmModal" class="modal-overlay">
  <div class="modal-container">
    <div class="modal-header">
      <h3>처리 상태 변경 확인</h3>
      <button class="modal-close" onclick="closeModal()">&times;</button>
    </div>
    <div class="modal-content">
      <p id="modalMessage">정말로 이 신고의 처리 상태를 변경하시겠습니까?</p>
      <p><strong>신고 ID:</strong> <span id="modalReportId"></span></p>
      <p><strong>분류:</strong> <span id="modalCategory"></span></p>
      <p><strong>신고유형:</strong> <span id="modalReportType"></span></p>
      <p><strong>신고내용:</strong> <span id="modalReportContent"></span></p>
      <p><strong>대상자:</strong> <span id="modalSelectedPerson"></span></p>
    </div>
    <div class="modal-actions">
      <button class="modal-btn modal-btn-cancel" onclick="cancelStatusChange()">취소</button>
      <button class="modal-btn modal-btn-confirm" onclick="confirmStatus()">확인</button>
    </div>
  </div>
</div>
</body>