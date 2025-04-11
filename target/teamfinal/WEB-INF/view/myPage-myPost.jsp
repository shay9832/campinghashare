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
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
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
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="myPage-trust.jsp" class="sidebar-link">신뢰도</a></li>
                    <li><a href="myPage-point.jsp" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="myPage-inspecList.jsp" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="myPage-delivery.jsp" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link active">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="myPage-wishlist.jsp" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="" class="sidebar-link title">
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
            <div class="d-flex flex-wrap align-items-center">
                <div class="tab-nav">
                    <a class="tab-link active" href="#">게시물</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">댓글</a>
                </div>
                <button id="deleteSelectedBtn" class="btn btn-danger btn-sm ms-3" style="display: none;">
                    <i class="fas fa-trash-alt me-1"></i> 선택 삭제
                </button>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="sort-container">
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>댓글순</option>
                    <option>조회수</option>
                    <option>추천순</option>
                </select>
            </div>
        </div>

        <!-- 물품 관리 테이블 -->
        <div class="equipment-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 3%; vertical-align: middle;" >
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="checkAll">
                            <label class="form-check-label" for="checkAll"></label>
                        </div>
                    </th>
                    <th style="width: 8%;">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
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
                    <th style="width: 10%;">관리</th>
                </tr>
                </thead>
                <tbody>
                <!-- 첫 번째 행 -->
                <tr class="equipment-row">
                    <td style="vertical-align: middle;">
                        <div class="form-check">
                            <input class="form-check-input item-checkbox" type="checkbox">
                        </div>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="title-row">
                            <i class="fa-regular fa-image title-icon"></i>
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
                    <td style="vertical-align: middle;">
                        <div class="form-check">
                            <input class="form-check-input item-checkbox" type="checkbox">
                        </div>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="title-row">
                            <i class="fa-regular fa-image title-icon"></i>
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
                    <td style="vertical-align: middle;">
                        <div class="form-check">
                            <input class="form-check-input item-checkbox" type="checkbox">
                        </div>
                    </td>
                    <td>자유게시판</td>
                    <td>아무말대잔치</td>
                    <td class="title-cell">
                        <div class="title-row">
                            <i class="fa-regular fa-image title-icon"></i>
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
            <button class="btn-circle">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <!-- 페이징 처리 -->
        <div class="pagination-container d-flex justify-content-center">
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
            console.log('정렬 옵션이 변경되었습니다: ' + $(this).val());
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
            console.log('게시글 상세 페이지로 이동: ' + $(this).text());
        });

        // 탭 클릭 이벤트
        $('.tab-link').click(function(e) {
            e.preventDefault();
            $('.tab-link').removeClass('active');
            $(this).addClass('active');
            // 탭 변경 기능 구현 (실제 구현 시에는 여기에 탭 변경 로직 추가)
        });

        // 수정 버튼 클릭 이벤트
        $('.btn-edit').click(function() {
            const postTitle = $(this).closest('tr').find('.equipment-name').text();
            console.log('게시글 수정 모드 시작: ' + postTitle);
            // 수정 기능 구현 (실제 구현 시에는 여기에 수정 로직 추가)
        });

        // 삭제 버튼 클릭 이벤트
        $('.btn-delete').click(function() {
            const postTitle = $(this).closest('tr').find('.equipment-name').text();
            if(confirm('정말로 "' + postTitle + '" 게시글을 삭제하시겠습니까?')) {
                console.log('게시글 삭제 확인: ' + postTitle);
                // 삭제 기능 구현 (실제 구현 시에는 여기에 삭제 로직 추가)
            }
        });

        // 체크박스 전체 선택/해제
        $('#checkAll').change(function() {
            const isChecked = $(this).prop('checked');
            $('.item-checkbox').prop('checked', isChecked);

            // 체크박스 선택 여부에 따라 삭제 버튼 표시/숨김
            if ($('.item-checkbox:checked').length > 0) {
                $('#deleteSelectedBtn').show();
            } else {
                $('#deleteSelectedBtn').hide();
            }
        });

        // 개별 체크박스 변경 이벤트
        $(document).on('change', '.item-checkbox', function() {
            // 모든 체크박스가 선택되었는지 확인
            const allChecked = $('.item-checkbox').length === $('.item-checkbox:checked').length;
            $('#checkAll').prop('checked', allChecked);

            // 체크박스 선택 여부에 따라 삭제 버튼 표시/숨김
            if ($('.item-checkbox:checked').length > 0) {
                $('#deleteSelectedBtn').show();
            } else {
                $('#deleteSelectedBtn').hide();
            }
        });

        // 선택 삭제 버튼 클릭 이벤트
        $('#deleteSelectedBtn').click(function() {
            const selectedCount = $('.item-checkbox:checked').length;
            console.log('선택된 체크박스 개수:', selectedCount);
            if (selectedCount > 0) {
                if (confirm('선택한 ' + selectedCount + '개의 게시글을 삭제하시겠습니까?')) {
                    // 선택된 행을 삭제
                    $('.item-checkbox:checked').each(function() {
                        $(this).closest('tr').remove();
                    });

                    // 전체 선택 체크박스 해제
                    $('#checkAll').prop('checked', false);

                    // 삭제 버튼 숨김
                    $('#deleteSelectedBtn').hide();

                    // 알림 메시지
                    alert(selectedCount + '개의 게시글이 삭제되었습니다.');
                }
            }
        });
    });
</script>
</body>
</html>