<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 마이페이지</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

    <style>
        /* 정렬 옵션 스타일 */
        .sort-select {
            min-width: 120px;
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            font-size: 14px;
        }

        /* 테이블 스타일 */
        .equipment-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .equipment-table .table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .equipment-row {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }

        .equipment-row:hover {
            background-color: #f9f9f9;
        }

        .equipment-row td,
        .equipment-table th {
            padding: 12px 8px;
            vertical-align: middle;
            text-align: center;
        }

        .equipment-table th {
            font-weight: 500;
            color: #555;
            border-bottom: 2px solid #2C5F2D;
            background-color: #f5f8f5;
            white-space: nowrap;
        }

        /* 드롭다운 스타일 */
        .dropdown-toggle {
            text-decoration: none;
            color: #333;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .dropdown-toggle::after {
            display: inline-block;
            margin-left: 0.255em;
            vertical-align: 0.255em;
            content: "";
            border-top: 0.3em solid;
            border-right: 0.3em solid transparent;
            border-bottom: 0;
            border-left: 0.3em solid transparent;
        }

        .dropdown-menu {
            position: absolute;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 0.5rem 0;
            min-width: 160px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            display: none;
            z-index: 1000;
        }

        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            text-decoration: none;
            color: #333;
            transition: all 0.2s ease;
        }

        .dropdown-item:hover {
            background-color: #f1f8f1;
            color: #2C5F2D;
        }

        .dropdown.show .dropdown-menu {
            display: block;
        }

        /* 제목 행 스타일 */
        .title-cell {
            text-align: left;
            padding-left: 15px;
        }

        .title-row {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .title-icon {
            color: #2C5F2D;
            font-size: 16px;
            flex-shrink: 0;
        }

        /* 장비명 스타일 */
        .equipment-name {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px;
        }

        .equipment-name:hover {
            color: #2C5F2D;
            text-decoration: underline;
        }

        /* 버튼 그룹 수평 스타일 */
        .button-group-horizontal {
            display: flex;
            gap: 6px;
            justify-content: center;
        }

        .btn-sm {
            padding: 4px 10px;
            font-size: 13px;
            border-radius: 4px;
            border: 1px solid #ddd;
            background-color: white;
            color: #555;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-sm:hover {
            background-color: #2C5F2D;
            color: white;
            border-color: #2C5F2D;
        }

        .btn-edit {
            background-color: #f8f9fa;
        }

        .btn-delete {
            background-color: #f8f9fa;
        }

        /* 페이지네이션 스타일 */
        .pagination-container {
            margin-top: 30px;
        }

        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
            justify-content: center;
        }

        .page-item {
            margin: 0 3px;
        }

        .page-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #555;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .page-item.active .page-link {
            background-color: #2C5F2D;
            color: white;
            border-color: #2C5F2D;
        }

        .page-item.disabled .page-link {
            color: #aaa;
            pointer-events: none;
            background-color: #f5f5f5;
        }

        .page-link:hover:not(.disabled):not(.active) {
            background-color: #f1f8f1;
            color: #2C5F2D;
            border-color: #2C5F2D;
        }

        /* 검색 컨테이너 스타일 */
        .search-container {
            display: flex;
            position: relative;
            max-width: 500px;
            margin-bottom: 20px;
        }

        .search-container input {
            border-radius: 4px;
            border: 1px solid #ddd;
            padding: 8px 40px 8px 15px;
            font-size: 14px;
            width: 100%;
            transition: border 0.2s ease;
        }

        .search-container input:focus {
            border-color: #2C5F2D;
            outline: none;
            box-shadow: 0 0 0 3px rgba(44, 95, 45, 0.1);
        }

        .search-button {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #2C5F2D;
            cursor: pointer;
            padding: 8px;
        }

        /* 탭 네비게이션 스타일 */
        .tab-nav {
            margin-right: 20px;
        }

        .tab-link {
            padding: 8px 16px;
            color: #666;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 2px solid transparent;
            transition: all 0.2s ease;
        }

        .tab-link:hover,
        .tab-link.active {
            color: #2C5F2D;
            border-bottom-color: #2C5F2D;
        }

        /* 추가 버튼 스타일 */
        .btn-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #2C5F2D;
            color: white;
            border: none;
            box-shadow: 0 2px 10px rgba(44, 95, 45, 0.3);
            font-size: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-left: auto;
            margin-top: 20px;
        }

        .btn-circle:hover {
            background-color: #224d23;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(44, 95, 45, 0.4);
        }

        /* 체크박스 스타일링 */
        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: #2C5F2D;
        }
    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-password-check.jsp" class="sidebar-link">회원 정보 수정</a></li>
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
                    <li><a href="mypage-my-equip.jsp" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-my-post.jsp" class="sidebar-link active">내가 작성한 글</a></li>
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
        <div class="page-header">
            <h2 class="page-title">내가 작성한 글</h2>
        </div>

        <!-- 검색 섹션 -->
        <div class="search-container mb-4">
            <input type="text" class="form-control" placeholder="어떤 글을 찾으시나요?">
            <button class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <!-- 카테고리 필터와 정렬 옵션을 한 줄에 배치 -->
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex flex-wrap">
                <div class="tab-nav">
                    <a class="tab-link active" href="#">게시물</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">댓글</a>
                </div>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="sort-container">
                <div class=""></div>
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>댓글순</option>
                    <option>조회수</option>
                    <option>...</option>
                </select>
            </div>
        </div>

        <!-- 물품 관리 테이블 -->
        <div class="equipment-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 3%;">
                        <i class="fa-regular fa-square-check" style="color: #435d3a;"></i>
                    </th>
                    <th style="width: 8%;">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-secondary d-flex align-items-center" data-toggle="dropdown">
                                게시판
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">전체</a>
                                <a class="dropdown-item" href="#">자유게시판</a>
                                <a class="dropdown-item" href="#">장비정보</a>
                                <a class="dropdown-item" href="#">캠핑장정보</a>
                            </div>
                        </div>
                    </th>
                    <th style="width: 8%;">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-secondary d-flex align-items-center" data-toggle="dropdown">
                                말머리
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">전체</a>
                                <a class="dropdown-item" href="#">아무말대잔치</a>
                                <a class="dropdown-item" href="#">묻고답하기</a>
                            </div>
                        </div>
                    </th>
                    <th style="width: 42%;">제목</th>
                    <th style="width: 12%;">게시일</th>
                    <th style="width: 7%;">조회수</th>
                    <th style="width: 7%;">추천수</th>
                    <th style="width: 7%;">댓글수</th>
                    <th style="width: 10%;">수정/삭제</th>
                </tr>
                </thead>
                <tbody>
                <!-- 첫 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <label>
                            <input type="checkbox">
                        </label>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row">
                            <i class="fa-regular fa-image" style="color: var(--color-maple)"></i>
                            <a href="product-detail.html" class="equipment-name">산 정상에서 찰칵~ 행복한 하루되세요 ㅎㅎ</a>
                        </div>
                    </td>
                    <td>2025/04/07</td>
                    <td>999</td>
                    <td>10</td>
                    <td>5</td>
                    <td>
                        <div class="button-group-horizontal">
                            <button class="btn-sm btn-edit">수정</button>
                            <button class="btn-sm btn-delete">삭제</button>
                        </div>
                    </td>
                </tr>

                <!-- 두 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <label>
                            <input type="checkbox">
                        </label>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row">
                            <i class="fa-regular fa-image" style="color: var(--color-maple)"></i>
                            <a href="product-detail.html" class="equipment-name">산 정상에서 찰칵~ 행복한 하루되세요 ㅎㅎ</a>
                        </div>
                    </td>
                    <td>2025/04/07</td>
                    <td>999</td>
                    <td>10</td>
                    <td>5</td>
                    <td>
                        <div class="button-group-horizontal">
                            <button class="btn-sm btn-edit">수정</button>
                            <button class="btn-sm btn-delete">삭제</button>
                        </div>
                    </td>
                </tr>

                <!-- 세 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <label>
                            <input type="checkbox">
                        </label>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row">
                            <i class="fa-regular fa-image" style="color: var(--color-maple)"></i>
                            <a href="product-detail.html" class="equipment-name">산 정상에서 찰칵~ 행복한 하루되세요 ㅎㅎ</a>
                        </div>
                    </td>
                    <td>2025/04/07</td>
                    <td>999</td>
                    <td>10</td>
                    <td>5</td>
                    <td>
                        <div class="button-group-horizontal">
                            <button class="btn-sm btn-edit">수정</button>
                            <button class="btn-sm btn-delete">삭제</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 추가 버튼 -->
        <div class="text-right mb-5">
            <button class="btn-circle" style="width: 50px; height: 50px; border-radius: 50%; background-color: white; border: 1px solid #ddd; box-shadow: 0 2px 5px rgba(0,0,0,0.1); font-size: 20px;">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <!-- 페이징 처리 -->
        <div class="pagination-container d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </div>

    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

</body>

<script>
    $(document).ready(function() {
        // 드롭다운 토글 이벤트
        $('.dropdown-toggle').click(function(e) {
            e.preventDefault();
            $(this).parent().toggleClass('show');
        });

        // 외부 클릭 시 드롭다운 닫기
        $(document).click(function(e) {
            if (!$(e.target).closest('.dropdown').length) {
                $('.dropdown').removeClass('show');
            }
        });

        // 정렬 옵션 변경 이벤트
        $('.sort-select').change(function() {
            // 정렬 기능 구현 (실제 구현 시에는 여기에 정렬 로직 추가)
            alert('정렬 옵션이 변경되었습니다: ' + $(this).val());
        });

        // 페이지네이션 클릭 이벤트
        $('.page-link').click(function(e) {
            if (!$(this).parent().hasClass('disabled') && !$(this).parent().hasClass('active')) {
                e.preventDefault();
                $('.page-item').removeClass('active');
                $(this).parent().addClass('active');
                // 페이지 이동 기능 구현 (실제 구현 시에는 여기에 페이지 이동 로직 추가)
            }
        });

        // 장비명 클릭 이벤트
        $('.equipment-name').click(function(e) {
            // 여기에 페이지 이동 로직 추가 (기본 동작은 유지)
            console.log('장비 상세 페이지로 이동: ' + $(this).text());
        });
    });
</script>
</html>