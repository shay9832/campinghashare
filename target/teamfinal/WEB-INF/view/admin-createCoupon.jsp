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
      <h2>쿠폰 발급</h2>
    </div>

    <!-- 쿠폰 생성 폼 -->
    <div class="coupon-form">
      <!-- 쿠폰 생성 타이틀 -->
      <div class="title-box">
        쿠폰생성
      </div>

      <!-- 쿠폰 이름 -->
      <div class="form-row">
        <div class="label">쿠폰이름</div>
        <div class="input-field">
          <input type="text" placeholder="쿠폰 이름을 입력하세요">
        </div>
      </div>

      <!-- 사용기간 -->
      <div class="form-row">
        <div class="label">사용기간</div>
        <div class="input-field">
          <div class="date-group">
            <input type="date">
            <span>~</span>
            <input type="date">
          </div>
        </div>
      </div>

      <!-- 쿠폰갯수 -->
      <div class="form-row">
        <div class="label">쿠폰갯수</div>
        <div class="input-field">
          <input type="number" min="1">
        </div>
      </div>

      <!-- 사용조건 -->
      <div class="form-row">
        <div class="label">사용조건</div>
        <div class="input-field">
          <div class="option-group">
            <button type="button" class="option-button active">최소 사용금액</button>
            <button type="button" class="option-button">적용가능상품</button>
            <button type="button" class="option-button">회원 기준</button>
          </div>
        </div>
      </div>

      <!-- 최소 사용금액 입력 필드 (조건별로 다른 필드가 표시됨) -->
      <div class="form-row" id="conditionDetailField">
        <div class="input-field">
          <input type="number" placeholder="최소 사용금액">
        </div>
      </div>

      <!-- 사용제한 -->
      <div class="form-row">
        <div class="label">사용제한</div>
        <div class="input-field">
          <div class="option-group">
            <button type="button" class="option-button active">1인당 갯수</button>
            <button type="button" class="option-button">중복제한여부</button>
          </div>
        </div>
      </div>

      <!-- 1인당 갯수 입력 필드 -->
      <div class="form-row" id="limitDetailField">
        <div class="input-field">
          <input type="number" min="1" placeholder="1인당 최대 사용 가능 개수">
        </div>
      </div>

      <!-- 혜택치 -->
      <div class="form-row">
        <div class="label">혜택치</div>
        <div class="input-field">
          <input type="text" placeholder="Ex) 첫구매 등..">
        </div>
      </div>

      <!-- 법적고지사항 -->
      <div class="legal-notice">
        법적고지사항
      </div>

      <!-- 쿠폰 내용 -->
      <div class="coupon-content">
        쿠폰 상세 내용<br>
        각종 주의사항 등을 고지<br>
        쿠폰을 받은 회원은 이 내용을 확인할수있음!
      </div>

      <!-- 버튼 그룹 -->
      <div class="button-group">
        <button type="button" class="button">취소</button>
        <button type="button" class="button create">생성</button>
      </div>
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

  // 사용조건 버튼 토글
  const conditionButtons = document.querySelectorAll('.form-row:nth-of-type(5) .option-button');
  const conditionDetailField = document.getElementById('conditionDetailField');

  conditionButtons.forEach(button => {
    button.addEventListener('click', () => {
      // 현재 활성화된 버튼에서 active 클래스 제거
      document.querySelector('.form-row:nth-of-type(5) .option-button.active').classList.remove('active');
      // 클릭한 버튼에 active 클래스 추가
      button.classList.add('active');

      // 버튼에 따라 다른 입력 필드 표시
      if (button.textContent === '최소 사용금액') {
        conditionDetailField.style.display = 'flex';
        conditionDetailField.querySelector('input').type = 'number';
        conditionDetailField.querySelector('input').placeholder = '최소 사용금액';
      } else if (button.textContent === '적용가능상품') {
        conditionDetailField.style.display = 'flex';
        conditionDetailField.querySelector('input').type = 'text';
        conditionDetailField.querySelector('input').placeholder = '상품 코드 입력';
      } else if (button.textContent === '회원 기준') {
        conditionDetailField.style.display = 'flex';
        conditionDetailField.querySelector('input').type = 'text';
        conditionDetailField.querySelector('input').placeholder = '회원 등급 선택';
      }
    });
  });

  // 사용제한 버튼 토글
  const limitButtons = document.querySelectorAll('.form-row:nth-of-type(7) .option-button');
  const limitDetailField = document.getElementById('limitDetailField');

  limitButtons.forEach(button => {
    button.addEventListener('click', () => {
      // 현재 활성화된 버튼에서 active 클래스 제거
      document.querySelector('.form-row:nth-of-type(7) .option-button.active').classList.remove('active');
      // 클릭한 버튼에 active 클래스 추가
      button.classList.add('active');

      // 버튼에 따라 다른 입력 필드 표시
      if (button.textContent === '1인당 갯수') {
        limitDetailField.style.display = 'flex';
        limitDetailField.querySelector('input').type = 'number';
        limitDetailField.querySelector('input').placeholder = '1인당 최대 사용 가능 개수';
      } else if (button.textContent === '중복제한여부') {
        limitDetailField.style.display = 'flex';
        // 체크박스로 입력 필드 변경을 대신 표현 (실제로는 select 등 다른 컨트롤을 사용할 수 있음)
        const input = limitDetailField.querySelector('input');
        input.type = 'checkbox';
        input.placeholder = '';
      }
    });
  });
</script>
</body>
</html>
