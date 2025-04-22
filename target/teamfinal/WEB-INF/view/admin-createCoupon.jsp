<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템 - 쿠폰 생성</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-createCoupon.css">
  <style>
    /* 만료일 표시 스타일 추가 */
    .validity-info {
      display: block;
      margin-top: 8px;
      font-size: 14px;
      color: #555;
    }
    #expiryDate {
      font-weight: bold;
      color: #333;
    }
  </style>
</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 -->
<div id="header">
  <h1>관리자 시스템</h1>
  <!-- 관리자 정보 표시 영역 추가 -->
  <div id="admin-info">
    <span>관리자: ${sessionScope.adminName}</span> <!-- 세션에서 관리자 이름 표시 -->
  </div>
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
      <h2>쿠폰 발급</h2>
    </div>

    <!-- 쿠폰 생성 폼 - GET 방식으로 변경 -->
    <form id="couponForm" action="${pageContext.request.contextPath}/admin-createCoupon.action" method="get">
      <div class="coupon-form">
        <!-- 쿠폰 생성 타이틀 -->
        <div class="title-box">
          쿠폰생성
        </div>

        <!-- 관리자 ID -->
        <div class="form-row">
          <div class="label">관리자 ID</div>
          <div class="input-field">
            <input type="text" name="adminId" value="${sessionScope.adminId}" readonly>
          </div>
        </div>

        <!-- 쿠폰 이름 -->
        <div class="form-row">
          <div class="label">쿠폰이름</div>
          <div class="input-field">
            <input type="text" name="couponName" placeholder="쿠폰 이름을 입력하세요" required>
          </div>
        </div>

        <!-- 쿠폰 할인율 추가 -->
        <div class="form-row">
          <div class="label">쿠폰할인율</div>
          <div class="input-field">
            <input type="number" name="discountRate" min="1" max="100" placeholder="할인율을 입력하세요(%)" required>
          </div>
        </div>

        <!-- 유효개월수로 변경 -->
        <div class="form-row">
          <div class="label">유효개월수</div>
          <div class="input-field">
            <input type="number" name="validMonths" id="validMonths" min="1" max="36" placeholder="유효 개월 수" required>
            <div class="validity-info">만료일: <span id="expiryDate">-</span></div>
            <!-- 계산된 만료일을 서버로 전송하기 위한 hidden 필드 -->
            <input type="hidden" name="expiryDate" id="expiryDateHidden">
          </div>
        </div>

        <!-- 법적고지사항 -->
        <div class="legal-notice">
          법적고지사항
        </div>

        <!-- 쿠폰 내용 -->
        <div class="coupon-content">
          <textarea name="couponContent" rows="4" cols="50" placeholder="쿠폰 상세 내용 및 주의사항을 입력하세요"></textarea>
        </div>

        <!-- 버튼 그룹 -->
        <div class="button-group">
          <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/admin-main.action'">취소</button>
          <button type="submit" class="button create">생성</button>
        </div>
      </div>
    </form>
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

  // DOM이 완전히 로드된 후 실행
  document.addEventListener('DOMContentLoaded', function() {
    // 유효개월수 입력 필드와 만료일 표시 요소 가져오기
    const validMonthsInput = document.getElementById('validMonths');
    const expiryDateElement = document.getElementById('expiryDate');
    const expiryDateHidden = document.getElementById('expiryDateHidden');
    const couponForm = document.getElementById('couponForm');

    // 세션 정보가 없을 경우를 대비한 관리자 ID 처리
    const adminIdField = document.querySelector('input[name="adminId"]');
    if (adminIdField && !adminIdField.value) {
      console.warn('세션에서 관리자 ID를 가져오지 못했습니다.');
      // 필요에 따라 기본값 설정 또는 경고 처리
    }

    if (!validMonthsInput || !expiryDateElement || !expiryDateHidden || !couponForm) {
      console.error('필요한 DOM 요소를 찾을 수 없습니다.');
      return;
    }

    // 유효개월수 입력 시 만료일 계산 및 표시 함수
    function calculateExpiryDate() {
      const months = parseInt(validMonthsInput.value);

      if (months && months > 0) {
        // 현재 날짜 기준으로 만료일 계산
        const today = new Date();
        const expiryDate = new Date(today);
        expiryDate.setMonth(today.getMonth() + months);

        // YYYY-MM-DD 형식으로 만료일 포맷팅
        const year = expiryDate.getFullYear();
        const month = String(expiryDate.getMonth() + 1).padStart(2, '0');
        const day = String(expiryDate.getDate()).padStart(2, '0');

        const formattedDate = `${year}-${month}-${day}`;
        expiryDateElement.textContent = formattedDate;
        // hidden 필드에도 값 설정
        expiryDateHidden.value = formattedDate;

        console.log('만료일 계산됨:', formattedDate);
      } else {
        expiryDateElement.textContent = '-';
        expiryDateHidden.value = '';
      }
    }

    // 입력 이벤트 리스너 등록
    validMonthsInput.addEventListener('input', calculateExpiryDate);
    validMonthsInput.addEventListener('change', calculateExpiryDate);

    // 페이지 로드 시 초기값이 있으면 만료일 계산
    if (validMonthsInput.value) {
      calculateExpiryDate();
    }

    // 폼 제출 전 만료일이 설정되었는지 확인
    couponForm.addEventListener('submit', function(event) {
      if (!expiryDateHidden.value && validMonthsInput.value) {
        // 만료일이 설정되지 않았으면 다시 계산
        calculateExpiryDate();
      }

      // 폼 유효성 검사
      if (!validMonthsInput.value) {
        alert('유효 개월 수를 입력해주세요.');
        event.preventDefault();
        return false;
      }
    });

    console.log('만료일 계산 스크립트가 초기화되었습니다.');
  });
</script>
</body>
</html>