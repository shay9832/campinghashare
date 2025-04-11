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
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .inquiry-table .table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .inquiry-row {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }

        .inquiry-row:hover {
            background-color: #f9f9f9;
        }

        .inquiry-row td,
        .inquiry-table th {
            padding: 12px 8px;
            vertical-align: middle;
            text-align: center;
        }

        .inquiry-table th {
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

        /* 문의글 제목 스타일 */
        .inquiry-name {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px;
            margin-left: 10px;
        }

        .inquiry-name:hover {
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

        /* 답변 상태 배지 */
        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-waiting {
            background-color: #f2f2f2;
            color: #666;
        }

        .status-completed {
            background-color: #e8f5e9;
            color: #2C5F2D;
        }

        /* 액션 버튼 컨테이너 */
        #actionButtonsContainer {
            display: none;
        }
    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="WEB-INF/view/header.jsp" />

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
                <a href="#" class="sidebar-link title active">
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
            <h2 class="page-title"><i class="fa-solid fa-headset"></i> 1:1 문의 내역</h2>
        </div>

        <!-- 검색 섹션 -->
        <div class="search-container mb-4">
            <input type="text" class="form-control" placeholder="어떤 문의를 찾으시나요?">
            <button class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <!-- 정렬 옵션 (오른쪽) -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex">
                <div class="tab-nav">
                    <a class="tab-link active" href="#">전체</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">답변대기</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">답변완료</a>
                </div>
            </div>

            <div id="actionButtonsContainer">
                <button class="btn btn-danger btn-sm me-2" id="deleteSelectedBtn">
                    <i class="fas fa-trash-alt me-1"></i> 선택 삭제
                </button>
            </div>

            <div class="sort-container">
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>오래된순</option>
                    <option>제목순</option>
                </select>
            </div>
        </div>

        <!-- 문의내역 관리 테이블 -->
        <div class="inquiry-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 5%;">
                        <i class="fa-regular fa-square-check" style="color: #435d3a; cursor: pointer;" title="전체 선택"></i>
                    </th>
                    <th style="width: 10%;">유형</th>
                    <th style="width: 45%;">제목</th>
                    <th style="width: 15%;">작성일</th>
                    <th style="width: 15%;">답변상태</th>
                </tr>
                </thead>
                <tbody>
                <!-- 첫 번째 행 -->
                <tr class="inquiry-row">
                    <td>
                        <label>
                            <input type="checkbox" class="inquiry-checkbox">
                        </label>
                    </td>
                    <td>커뮤니티</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="myPage-inquiry-post.jsp" class="inquiry-name">게시글 신고 관련 문의드립니다</a>
                        </div>
                    </td>
                    <td>2025/04/07</td>
                    <td>
                        <span class="status-badge status-waiting">답변대기</span>
                    </td>
                </tr>

                <!-- 두 번째 행 -->
                <tr class="inquiry-row">
                    <td>
                        <label>
                            <input type="checkbox" class="inquiry-checkbox">
                        </label>
                    </td>
                    <td>거래</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="myPage-inquiry-post.jsp" class="inquiry-name">대여 완료 후 반납 과정에서 문제가 있었습니다</a>
                            <i class="fa-regular fa-image ms-2" style="color: var(--color-maple)" title="첨부파일"></i>
                        </div>
                    </td>
                    <td>2025/04/01</td>
                    <td>
                        <span class="status-badge status-completed">답변완료</span>
                    </td>
                </tr>

                <!-- 세 번째 행 -->
                <tr class="inquiry-row">
                    <td>
                        <label>
                            <input type="checkbox" class="inquiry-checkbox">
                        </label>
                    </td>
                    <td>회원정보</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="myPage-inquiry-post.jsp" class="inquiry-name">회원 등급 업그레이드는 어떻게 하나요?</a>
                        </div>
                    </td>
                    <td>2025/03/20</td>
                    <td>
                        <span class="status-badge status-completed">답변완료</span>
                    </td>
                </tr>

                <!-- 네 번째 행 -->
                <tr class="inquiry-row">
                    <td>
                        <label>
                            <input type="checkbox" class="inquiry-checkbox">
                        </label>
                    </td>
                    <td>신규 등록 요청</td>
                    <td class="title-cell">
                        <div class="d-flex flex-row align-items-center">
                            <a href="myPage-inquiry-post.jsp" class="inquiry-name">새로운 장비 카테고리를 추가해주세요</a>
                            <i class="fa-regular fa-image ms-2" style="color: var(--color-maple)" title="첨부파일"></i>
                        </div>
                    </td>
                    <td>2025/03/10</td>
                    <td>
                        <span class="status-badge status-waiting">답변대기</span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 추가 버튼 -->
        <div class="text-end mb-5">
            <a href="myPage-inquiry-write.jsp" class="btn-circle">
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
<jsp:include page="WEB-INF/view/footer.jsp" />

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

        // 문의글 제목 클릭 이벤트
        $('.inquiry-name').click(function(e) {
            // 여기에 페이지 이동 로직 추가 (기본 동작은 유지)
            console.log('문의 상세 페이지로 이동: ' + $(this).text());
        });

        // 개별 문의글에 대한 이벤트 처리가 필요하면 여기에 추가

        // 체크박스 변경 이벤트
        $('.inquiry-checkbox').change(function() {
            updateActionButtons();
        });

        // 전체 체크박스 (헤더) 클릭 이벤트
        $('th .fa-square-check').click(function() {
            const isChecked = $(this).hasClass('fa-solid');

            if (isChecked) {
                // 체크 해제
                $(this).removeClass('fa-solid').addClass('fa-regular');
                $('.inquiry-checkbox').prop('checked', false);
            } else {
                // 체크
                $(this).removeClass('fa-regular').addClass('fa-solid');
                $('.inquiry-checkbox').prop('checked', true);
            }

            updateActionButtons();
        });

        // 선택 삭제 버튼 클릭 이벤트
        $('#deleteSelectedBtn').click(function() {
            const checkedCount = $('.inquiry-checkbox:checked').length;

            if (checkedCount > 0 && confirm(`선택한 ${checkedCount}개의 문의글을 삭제하시겠습니까?`)) {
                // 삭제 처리 로직
                alert('선택한 문의글이 삭제되었습니다.');
                // 체크박스 초기화 및 버튼 숨김
                $('.inquiry-checkbox').prop('checked', false);
                $('th .fa-square-check').removeClass('fa-solid').addClass('fa-regular');
                updateActionButtons();
            }
        });

        // 탭 링크 클릭 이벤트
        $('.tab-link').click(function(e) {
            e.preventDefault();
            $('.tab-link').removeClass('active');
            $(this).addClass('active');
            // 여기에 필터링 로직 추가
        });

        // 액션 버튼들 표시 여부 업데이트 함수
        function updateActionButtons() {
            const checkedCount = $('.inquiry-checkbox:checked').length;

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