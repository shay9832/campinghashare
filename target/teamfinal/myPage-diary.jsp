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
        /* 날씨 아이콘 스타일 */
        .weather-cell {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
        }

        .weather-cell i {
            margin-right: 5px;
        }

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
        .diary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .diary-table .table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .diary-row {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }

        .diary-row:hover {
            background-color: #f9f9f9;
        }

        .diary-row td,
        .diary-table th {
            padding: 12px 8px;
            vertical-align: middle;
            text-align: center;
        }

        .diary-table th {
            font-weight: 500;
            color: #555;
            border-bottom: 2px solid #2C5F2D;
            background-color: #f5f8f5;
            white-space: nowrap;
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

        /* 일지명 스타일 */
        .diary-name {
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

        .diary-name:hover {
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
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
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
                <a href="#" class="sidebar-link title active">
                    <span>캠핑일지</span>
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
            <h2 class="page-title">나의 캠핑일지</h2>
        </div>

        <!-- 검색 섹션 -->
        <div class="search-container mb-4">
            <input type="text" class="form-control" placeholder="어떤 일지를 찾으시나요?">
            <button class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <!-- 정렬 옵션 (오른쪽) -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div id="actionButtonsContainer" style="display: none;">
                <button class="btn btn-danger btn-sm me-2" id="deleteSelectedBtn">
                    <i class="fas fa-trash-alt me-1"></i> 선택 삭제
                </button>
                <button class="btn btn-danger btn-sm" id="deleteAllBtn">
                    <i class="fas fa-trash-alt me-1"></i> 전체 삭제
                </button>
            </div>
            <div class="sort-container ms-auto">
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>오래된순</option>
                    <option>제목순</option>
                </select>
            </div>
        </div>

        <!-- 캠핑일지 관리 테이블 -->
        <div class="diary-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 5%;">
                        <i class="fa-regular fa-square-check" style="color: #435d3a; cursor: pointer;" title="전체 선택"></i>
                    </th>
                    <th style="width: 55%;">제목</th>
                    <th style="width: 15%;">작성일</th>
                    <th style="width: 15%;">날씨</th>
                    <th style="width: 15%;">관리</th>
                </tr>
                </thead>
                <tbody>
                <!-- 첫 번째 행 -->
                <tr class="diary-row">
                    <td>
                        <label>
                            <input type="checkbox" class="diary-checkbox">
                        </label>
                    </td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="diary-detail.html" class="diary-name">4월의 따뜻한 봄, 가평 캠핑 여행기</a>
                        </div>
                    </td>
                    <td>2025/04/07</td>
                    <td class="text-center">
                        <div class="d-flex align-items-center justify-content-center">
                            <i class="fa-solid fa-sun" style="color: #FF9500; font-size: 18px; margin-right: 5px;"></i>
                            <span>맑음</span>
                        </div>
                    </td>
                    <td>
                        <div class="button-group-horizontal">
                            <button class="btn-sm btn-edit">수정</button>
                            <button class="btn-sm btn-delete">삭제</button>
                        </div>
                    </td>
                </tr>

                <!-- 두 번째 행 -->
                <tr class="diary-row">
                    <td>
                        <label>
                            <input type="checkbox" class="diary-checkbox">
                        </label>
                    </td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="diary-detail.html" class="diary-name">첫 겨울 캠핑, 눈 내리는 양평에서의 하루</a>
                            <i class="fa-regular fa-image ms-2" style="color: var(--color-maple)" title="첨부파일"></i>
                        </div>
                    </td>
                    <td>2025/01/15</td>
                    <td class="text-center">
                        <div class="d-flex align-items-center justify-content-center">
                            <i class="fa-regular fa-snowflake" style="color: #89CFF0; font-size: 18px; margin-right: 5px;"></i>
                            <span>눈</span>
                        </div>
                    </td>
                    <td>
                        <div class="button-group-horizontal">
                            <button class="btn-sm btn-edit">수정</button>
                            <button class="btn-sm btn-delete">삭제</button>
                        </div>
                    </td>
                </tr>

                <!-- 세 번째 행 -->
                <tr class="diary-row">
                    <td>
                        <label>
                            <input type="checkbox" class="diary-checkbox">
                        </label>
                    </td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="diary-detail.html" class="diary-name">가족과 함께한 추석 연휴 캠핑</a>
                            <i class="fa-regular fa-image ms-2" style="color: var(--color-maple)" title="첨부파일"></i>
                        </div>
                    </td>
                    <td>2024/09/18</td>
                    <td class="text-center">
                        <div class="d-flex align-items-center justify-content-center">
                            <i class="fa-solid fa-cloud-sun" style="color: #87CEEB; font-size: 18px; margin-right: 5px;"></i>
                            <span>구름조금</span>
                        </div>
                    </td>
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
        <div class="text-end mb-5">
            <a href="myPage-diary-write.jsp" class="btn-circle">
                <i class="fas fa-plus"></i>
            </a>
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

<script>
    $(document).ready(function() {
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

        // 캠핑일지 제목 클릭 이벤트
        $('.diary-name').click(function(e) {
            // 여기에 페이지 이동 로직 추가 (기본 동작은 유지)
            console.log('캠핑일지 상세 페이지로 이동: ' + $(this).text());
        });

        // 수정 버튼 클릭 이벤트
        $('.btn-edit').click(function() {
            // 캠핑일지 수정 페이지로 이동
            location.href = 'myPage-diary-write.jsp';
        });

        // 삭제 버튼 클릭 이벤트
        $('.btn-delete').click(function() {
            if(confirm('정말 이 캠핑일지를 삭제하시겠습니까?')) {
                // 삭제 처리 로직
                alert('캠핑일지가 삭제되었습니다.');
            }
        });

        // 체크박스 변경 이벤트
        $('.diary-checkbox').change(function() {
            updateActionButtons();
        });

        // 전체 체크박스 (헤더) 클릭 이벤트
        $('th .fa-square-check').click(function() {
            const isChecked = $(this).hasClass('fa-solid');

            if (isChecked) {
                // 체크 해제
                $(this).removeClass('fa-solid').addClass('fa-regular');
                $('.diary-checkbox').prop('checked', false);
            } else {
                // 체크
                $(this).removeClass('fa-regular').addClass('fa-solid');
                $('.diary-checkbox').prop('checked', true);
            }

            updateActionButtons();
        });

        // 선택 삭제 버튼 클릭 이벤트
        $('#deleteSelectedBtn').click(function() {
            const checkedCount = $('.diary-checkbox:checked').length;

            if (checkedCount > 0 && confirm(`선택한 ${checkedCount}개의 캠핑일지를 삭제하시겠습니까?`)) {
                // 삭제 처리 로직
                alert('선택한 캠핑일지가 삭제되었습니다.');
                // 체크박스 초기화 및 버튼 숨김
                $('.diary-checkbox').prop('checked', false);
                $('th .fa-square-check').removeClass('fa-solid').addClass('fa-regular');
                updateActionButtons();
            }
        });

        // 전체 삭제 버튼 클릭 이벤트
        $('#deleteAllBtn').click(function() {
            const totalCount = $('.diary-checkbox').length;

            if (confirm(`모든 캠핑일지(${totalCount}개)를 삭제하시겠습니까?`)) {
                // 삭제 처리 로직
                alert('모든 캠핑일지가 삭제되었습니다.');
                // 체크박스 초기화 및 버튼 숨김
                $('.diary-checkbox').prop('checked', false);
                $('th .fa-square-check').removeClass('fa-solid').addClass('fa-regular');
                updateActionButtons();
            }
        });

        // 액션 버튼들 표시 여부 업데이트 함수
        function updateActionButtons() {
            const checkedCount = $('.diary-checkbox:checked').length;

            if (checkedCount > 0) {
                $('#actionButtonsContainer').show();
            } else {
                $('#actionButtonsContainer').hide();
            }
        }
    });
</script>
</body>
</html>