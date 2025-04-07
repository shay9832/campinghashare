<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지로 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩을 UTF-8로 설정하여 한글 등 다양한 문자 지원 -->
  <title>Admin Title</title> <!-- 브라우저 탭에 표시될 페이지 제목 -->
</head>
<style>
  /* 기본 페이지 설정 - 여백 제거 및 기본 글꼴 설정 */
  body {
    margin: 0; /* 바깥쪽 여백 제거 */
    padding: 0; /* 안쪽 여백 제거 */
    font-family: sans-serif; /* 고딕체 글꼴 사용 */
  }

  /* 상단 헤더 영역 스타일링 */
  #header {
    height: 60px; /* 헤더 높이 설정 */
    background-color: #3f861d; /* 헤더 배경색 (어두운 회색) */
    color: white; /* 헤더 내 텍스트 색상 */
    width: 100%; /* 헤더가 화면 가로 전체를 차지하도록 설정 */
    padding: 10px; /* 헤더 내부 여백 */
    box-sizing: border-box; /* 패딩을 포함한 크기 계산 방식 */
    display: flex; /* 자식 요소 배치를 위한 플렉스 박스 사용 */
    align-items: center; /* 자식 요소를 세로 중앙에 배치 */
  }

  /* 헤더 내 제목 스타일링 */
  #header h1 {
    margin: 0; /* 제목의 기본 여백 제거 */
    font-size: 24px; /* 제목 글자 크기 설정 */
  }

  /* 메인 컨테이너 영역 스타일링 - 메뉴와 콘텐츠를 포함 */
  #container {
    display: flex; /* 메뉴와 콘텐츠를 수평으로 배치 */
    min-height: calc(100vh - 60px); /* 헤더를 제외한 화면 전체 높이를 차지하도록 설정 */
  }

  /* 왼쪽 메뉴 영역 스타일링 */
  #leftMenu {
    padding: 20px; /* 내부 여백 */
    border-right: 1px solid #ccc; /* 오른쪽에 경계선 추가 */
    width: 200px; /* 메뉴 영역 너비 고정 */
    background: #f5f5f5; /* 메뉴 배경색 (연한 회색) */
    box-shadow: 5px 0 5px rgba(0,0,0,0.1); /* 오른쪽에 그림자 효과 - 괄호 오류 있음 */
  }

  /* 메뉴 버튼의 기본 스타일 - 하위 메뉴를 가진 버튼 */
  .menu-button {
    display: block; /* 블록 레벨 요소로 설정 (가로 전체 차지) */
    width: 100%; /* 부모 컨테이너의 너비 100% 차지 */
    padding: 12px 15px; /* 내부 여백 (위아래 12px, 좌우 15px) */
    margin-bottom: 15px; /* 하단 여백 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    background-color: white; /* 버튼 배경색 */
    border: 1px solid #ddd; /* 테두리 설정 */
    border-radius: 4px; /* 둥근 모서리 설정 */
    cursor: pointer; /* 마우스 오버 시 손가락 커서 표시 */
    transition: all 0.3s ease; /* 모든 변화에 0.3초 애니메이션 적용 */
    position: relative; /* 상대적 위치 설정 (화살표 배치를 위함) */
  }

  /* 메뉴 버튼에 마우스를 올렸을 때의 스타일 */
  .menu-button:hover {
    background: #e9e9e9; /* 호버 시 배경색 변경 */
    border-left: 4px solid #4285f4; /* 왼쪽에 파란색 강조선 추가 */
  }

  /* 메뉴 버튼의 화살표 아이콘 생성 */
  .menu-button::after {
    content: "▼"; /* 화살표 모양의 문자 추가 */
    position: absolute; /* 절대 위치 설정 */
    right: 15px; /* 오른쪽에서 15px 위치 */
    top: 50%; /* 세로 중앙에 배치 */
    transform: translateY(-50%); /* 정확한 세로 중앙 정렬을 위한 변환 */
    font-size: 12px; /* 화살표 크기 */
    transition: transform 0.3s ease; /* 회전 애니메이션 설정 */
  }

  /* 하위 메뉴가 열렸을 때 화살표 회전 */
  .menu-button.active::after {
    transform: translateY(-50%) rotate(180deg); /* 화살표를 180도 회전하여 위쪽을 가리키게 함 */
  }

  /* 하위 메뉴 컨테이너 스타일링 */
  .submenu {
    max-height: 0; /* 처음에는 보이지 않도록 높이를 0으로 설정 */
    overflow: hidden; /* 내용이 넘치면 숨김 처리 */
    transition: max-height 0.3s ease; /* 높이 변화에 애니메이션 적용 */
    margin-bottom: 15px; /* 하단 여백 */
    margin-top: -10px; /* 상단 여백 (버튼과 가깝게 배치) */
  }

  /* 하위 메뉴 항목(링크) 스타일링 */
  .submenu a {
    display: block; /* 블록 레벨로 설정하여 각 항목이 한 줄을 차지 */
    padding: 10px 10px 10px 25px; /* 내부 여백 (왼쪽에 더 큰 여백) */
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #333; /* 텍스트 색상 */
    border-left: 1px solid #ddd; /* 왼쪽 테두리 추가 */
    margin-left: 10px; /* 왼쪽 여백 */
    transition: all 0.2s ease; /* 변화에 애니메이션 적용 */
  }

  /* 하위 메뉴 항목에 마우스를 올렸을 때의 스타일 */
  .submenu a:hover {
    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
    color: #4285f4; /* 호버 시 텍스트 색상 변경 (파란색) */
  }

  /* 콘텐츠 영역 스타일링 */
  #content {
    flex-grow: 1; /* 남은 공간을 모두 차지하도록 설정 */
    padding: 20px; /* 내부 여백 */
    background-color: #f5f5f5;
    overflow: auto;
  }

  /* 대시보드 그리드 레이아웃 */
  .dashboard-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);  /* 4개의 동일한 열 생성*/
    grid-template-rows: auto auto auto; /* 높이는 내용에 따라 자동 조정 */
    gap: 20px; /*위젯 사이의 간격*/
    margin-bottom: 20px;
  }

  /*위젯 기본 스타일*/
  .widget {
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }

  /* 위젯 헤더 스타일 */
  .widget-header {
    padding: 15px;
    border-bottom: 1px solid #eee;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  /* 위젯 내용 스타일 */
  .widget-content {
    padding: 15px;
  }

  /* 각 위젯의 그리드 위치 지정 */
  .widget-large {
    grid-column: 1/4; /* 1번 열부터 4번 열까지 차지 (전체 폭의 3/4) */
    grid-row: 1; /* 첫 번째 행 */
  }

  .widget-profile {
    grid-column: 4 / 5; /* 4번 열 */
    grid-row: 1; /* 첫 번째 행 */
  }

  .widget-medium:nth-of-type(1) {
    grid-column: 1/3; /* 1번 열부터 3번 열까지 차지 (전체 폭의 절반) */
    grid-row: 2; /* 두 번째 행 */
  }

  .widget-medium:nth-of-type(2) {
    grid-column: 3/5;
    grid-row: 2;
  }

  .widget-small:nth-of-type(1) {
    grid-column: 1/3;
    grid-row: 3;
  }

  .widget-small:nth-of-type(2) {
    grid-column: 3/5;
    grid-row: 3;
  }

  .widget-chat {
    grid-column: 4/5;
    grid-row: 2 / 4;
  }

  /* 뱃지 스타일 (게시물 숫자 표시) */
  .badge {
    background-color: #4285f4;
    color: white;
    border-radius: 50%;
    padding: 2px 6px;
    font-size: 12px;
  }

  /* 차트 컨테이너 스타일 */
  .chart-container {
    height: 300px;
    position: relative;
  }

  /* 중간 크기 화면에 대한 조정 */
  @media (max-width: 1200px) {
    .dashboard-grid {
      grid-template-columns: repeat(2, 1fr); /* 2개의 열로 변경 */
    }

    .widget-large {
      grid-column: 1 / 3; /* 전체 폭 차지 */
    }

    .widget-profile {
      grid-column: 1 / 3; /* 전체 폭 차지 */
      grid-row: 2;
    }

    .widget-medium:nth-of-type(1) {
      grid-column: 1 / 3; /* 전체 폭 차지 */
      grid-row: 3;
    }

    .widget-medium:nth-of-type(2) {
      grid-column: 1 / 3; /* 전체 폭 차지 */
      grid-row: 4;
    }

    .widget-small:nth-of-type(1),
    .widget-small:nth-of-type(2),
    .widget-chat {
      grid-column: 1 / 3; /* 전체 폭 차지 */
      grid-row: auto; /* 자동으로 다음 행으로 배치 */
    }
  }

  /* 작은 화면에 대한 조정 */
  @media (max-width: 768px) {
    .dashboard-grid {
      grid-template-columns: 1fr; /* 단일 열로 변경 */
      gap: 15px; /* 간격 축소 */
    }

    /* 모든 위젯이 전체 폭을 차지하도록 설정 */
    .widget {
      grid-column: 1 / 2;
      grid-row: auto;
    }
  }

</style>


<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 표시 -->
<div id="header">
  <h1>관리자 시스템</h1>
</div>

<!-- 컨테이너 - 메뉴와 콘텐츠를 포함하는 메인 영역 -->
<div id="container">
  <!-- 좌측 메뉴 영역 - 드롭다운 메뉴 구성 -->
  <div id="leftMenu">
    <!-- 회원 관리 메뉴와 하위 메뉴 -->
    <button class="menu-button">회원 관리</button>
    <div class="submenu">
      <a href="#">회원 목록</a>
      <a href="#">회원 등급 조회</a>
      <a href="#">제재내역</a>
    </div>
    <!-- 신고 관리 메뉴와 하위 메뉴 -->
    <button class="menu-button">신고 관리</button>
    <div class="submenu">
      <a href="#">신고 목록</a>
      <a href="#">처리 내역</a>
    </div>
    <!-- 쿠폰 관리 메뉴와 하위 메뉴 -->
    <button class="menu-button">쿠폰 관리</button>
    <div class="submenu">
      <a href="#">쿠폰 발급</a>
      <a href="#">쿠폰 조회</a>
      <a href="#">만료 쿠폰</a>
    </div>
    <!-- 상품 카테고리 관리 메뉴와 하위 메뉴 -->
    <button class="menu-button">상품 카테고리 관리</button>
    <div class="submenu">
      <a href="#">카테고리 등록</a>
      <a href="#">카테고리 수정</a>
    </div>
    <!-- 창고 관리 메뉴와 하위 메뉴 -->
    <button class="menu-button">창고 관리</button>
    <div class="submenu">
      <a href="#">재고 현황</a>
      <a href="#">입출고 내역</a>
    </div>
    <!-- 통계 메뉴와 하위 메뉴 -->
    <button class="menu-button">통계</button>
    <div class="submenu">
      <a href="#">일간 통계</a>
      <a href="#">월간 통계</a>
      <a href="#">연간 통계</a>
    </div>
  </div>

  <!-- 콘텐츠 영역 - 선택된 메뉴에 따라 내용이 표시될 영역 -->
  <div id="content">
    <h2>회원 목록 조회</h2>
  </div>

</div>


<!-- 자바스크립트 - 드롭다운 메뉴 기능 구현 -->
<script>
  // 모든 메뉴 버튼 요소를 선택하여 menuButtons 변수에 저장
  const menuButtons = document.querySelectorAll('.menu-button');

  // 각 메뉴 버튼에 클릭 이벤트 리스너 추가
  menuButtons.forEach(button => {
    button.addEventListener('click', function() {
      // 클릭된 버튼에 'active' 클래스를 토글(있으면 제거, 없으면 추가)
      this.classList.toggle('active');

      // 버튼 다음에 오는 요소(하위메뉴)를 가져옴
      const submenu = this.nextElementSibling;

      // 하위메뉴가 열려있는지 확인 (maxHeight 스타일 속성이 설정되어 있는지)
      if (submenu.style.maxHeight) {
        // 열려있으면 닫기 (maxHeight를 null로 설정)
        submenu.style.maxHeight = null;
      } else {
        // 닫혀있으면 열기 (maxHeight를 내용 높이만큼 설정)
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
      }
    });
  });
</script>
</body>
</html>