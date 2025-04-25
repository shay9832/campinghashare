<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampingHaShare - 회원 정보 수정</title>
  <!-- 외부 라이브러리 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
  <!-- 마이페이지 전용 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
  <!-- 마이페이지 사이드바 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
  <!-- 제이쿼리 사용 CDN 방식 -->
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
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
          <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link active">회원 정보 수정</a></li>
          <li><a href="#" class="sidebar-link">회원 등급</a></li>
          <li><a href="#" class="sidebar-link">신뢰도</a></li>
          <li><a href="#" class="sidebar-link">포인트</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>이용 내역 조회</span>
        </a>
        <ul class="submenu">
          <li><a href="myPage-myEquip.jsp" class="sidebar-link">내 장비 목록</a></li>
          <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
          <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
        </ul>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
          <span>찜</span>
        </a>
      </li>
      <li class="sidebar-menu-item">
        <a href="#" class="sidebar-link title">
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
    <!-- 닉네임 변경 -->
    <div id="nickname-change-view" class="content-box">
      <h3 class="content-box-title mb-4">회원 정보 수정 - 닉네임 변경</h3>

      <div class="form-group">
        <label class="form-label">새 닉네임</label>
        <div class="input-container">
          <input type="text" class="form-control" id="nickname-input" placeholder="페레로로쉐" value="">
        </div>
        <div class="form-text text-muted">한글로만 2글자 이상~8글자 이하 / <span class=" text-danger">사용가능 / 사용불가</span></div>
      </div>

      <div class="button-container mt-5">
        <button class="btn btn-primary" id="complete-nickname-btn">수정</button>
      </div>
    </div>
  </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script>
  $(document).ready(function() {
    // 닉네임 수정 완료 버튼 클릭
    $("#complete-nickname-btn").click(function() {
      const nickname = $("#nickname-input").val();

      if (nickname.length < 2 || nickname.length > 8) {
        alert('닉네임은 2글자 이상 8글자 이하로 입력해주세요.');
        return;
      }

      alert('닉네임이 성공적으로 변경되었습니다.');
      window.location.href = 'myPage-infoEdit.jsp';
    });
  });
</script>
</body>
</html>