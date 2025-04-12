<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 검수 결과 조회</title>
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
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link active">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">검수 결과 조회</h2>
            <p class="page-description">보관 및 스토렌 서비스 이용 중인 장비의 검수 결과를 확인할 수 있습니다.</p>
        </div>

        <!-- 검수 조회 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tabs">
                <div class="tab active" data-tab="storage" id="storage-tab">보관</div>
                <div class="tab" data-tab="storen" id="storen-tab">스토렌</div>
            </div>

            <!-- 장비 ID 검색 -->
            <div class="search-container">
                <input type="text" id="search-equipment-id" placeholder="장비코드 또는 장비명 검색">
                <button type="button" class="search-button" id="btn-search">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <!-- 보관 탭 콘텐츠 -->
            <div class="tab-content active" id="storage-content">
                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>장비코드</th>
                            <th>거래ID</th>
                            <th>배송ID</th>
                            <th>검수유형</th>
                            <th>장비명</th>
                            <th>카테고리</th>
                            <th>검수상태</th>
                            <th>검수결과등급</th>
                            <th>검수일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row" data-id="1001">
                            <td>EQ12345</td>
                            <td>TR56789</td>
                            <td>DL98765</td>
                            <td>입고검수</td>
                            <td>캠핑 텐트 세트</td>
                            <td>텐트/타프 > 돔텐트</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-A">A</span>
                            </td>
                            <td>2023-04-28</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="1001">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1002">
                            <td>EQ23456</td>
                            <td>TR67890</td>
                            <td>DL87654</td>
                            <td>출고검수</td>
                            <td>접이식 테이블 체어</td>
                            <td>테이블/체어 > 폴딩체어</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-B">B</span>
                            </td>
                            <td>2023-04-20</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="1002">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1003">
                            <td>EQ34567</td>
                            <td>TR78901</td>
                            <td>DL76543</td>
                            <td>중간검수</td>
                            <td>캠핑 침낭</td>
                            <td>침낭/매트 > 동계침낭</td>
                            <td>
                                <span class="status-badge status-pending">미완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-C">C</span>
                            </td>
                            <td>2023-05-01</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="1003">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1004">
                            <td>EQ45678</td>
                            <td>TR89012</td>
                            <td>DL65432</td>
                            <td>입고검수</td>
                            <td>코펠 세트</td>
                            <td>취사용품 > 코펠</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-A">A</span>
                            </td>
                            <td>2023-03-15</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="1004">조회</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content" id="storen-content">
                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>장비코드</th>
                            <th>거래ID</th>
                            <th>배송ID</th>
                            <th>검수유형</th>
                            <th>장비명</th>
                            <th>카테고리</th>
                            <th>검수상태</th>
                            <th>검수결과등급</th>
                            <th>검수일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row" data-id="2001">
                            <td>EQ56789</td>
                            <td>TR90123</td>
                            <td>DL54321</td>
                            <td>입고검수</td>
                            <td>등산용 배낭</td>
                            <td>가방 > 배낭</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-A">A</span>
                            </td>
                            <td>2023-04-25</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="2001">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="2002">
                            <td>EQ67890</td>
                            <td>TR01234</td>
                            <td>DL43210</td>
                            <td>출고검수</td>
                            <td>캠핑용 의자</td>
                            <td>테이블/체어 > 릴렉스체어</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-B">B</span>
                            </td>
                            <td>2023-04-18</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="2002">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="2003">
                            <td>EQ78901</td>
                            <td>TR12345</td>
                            <td>DL32109</td>
                            <td>중간검수</td>
                            <td>야외용 랜턴</td>
                            <td>캠핑조명 > LED랜턴</td>
                            <td>
                                <span class="status-badge status-pending">미완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-D">D</span>
                            </td>
                            <td>2023-05-05</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="2003">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="2004">
                            <td>EQ89012</td>
                            <td>TR23456</td>
                            <td>DL21098</td>
                            <td>입고검수</td>
                            <td>휴대용 가스버너</td>
                            <td>버너/히터 > 가스버너</td>
                            <td>
                                <span class="status-badge status-completed">검수완료</span>
                            </td>
                            <td>
                                <span class="grade-badge grade-C">C</span>
                            </td>
                            <td>2023-03-20</td>
                            <td>
                                <button type="button" class="btn-sm btn-detail" data-id="2004">조회</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    $(document).ready(function (){
        // 탭 전환 기능
        $('.tab').on('click', function() {
            const tabId = $(this).data('tab');

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 콘텐츠 활성화
            $('.tab-content').removeClass('active');
            $('#' + tabId + '-content').addClass('active');
        });

        // 검색 기능
        $('#btn-search').on('click', function() {
            performSearch();
        });

        // 엔터 키 검색
        $('#search-equipment-id').on('keypress', function(e) {
            if(e.which === 13) {
                performSearch();
            }
        });

        // 상세 버튼 클릭 이벤트
        $('.btn-detail').on('click', function() {
            const inspectionId = $(this).data('id');
            // 여기에 상세 정보 조회 로직 추가
            alert('검수 ID ' + inspectionId + '의 상세 정보를 조회합니다.');
        });
    });

    // 검색 실행 함수
    function performSearch() {
        const searchValue = $('#search-equipment-id').val().trim().toLowerCase();

        if(searchValue === '') {
            // 검색어가 없으면 모든 행 표시
            $('.table-row').show();
            // empty-state 제거
            $('.empty-state').remove();
            return;
        }

        // 모든 활성 탭의 행을 검색
        const activeTab = $('.tab.active').data('tab');
        const rows = $('#' + activeTab + '-content .table-row');
        let foundMatch = false;

        rows.each(function() {
            const rowData = $(this).text().toLowerCase();
            const equipmentCode = $(this).find('td:eq(0)').text().toLowerCase();
            const equipmentName = $(this).find('td:eq(4)').text().toLowerCase();

            // 검색 조건 확인
            if(equipmentCode.includes(searchValue) || equipmentName.includes(searchValue) || rowData.includes(searchValue)) {
                $(this).show();
                foundMatch = true;
            } else {
                $(this).hide();
            }
        });

        // 검색 결과가 없는 경우 처리
        if(!foundMatch) {
            // 이미 empty-state가 있는지 확인
            if($('#' + activeTab + '-content .empty-state').length === 0) {
                $('#' + activeTab + '-content .table-container').after(`
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <p>검색 결과가 없습니다</p>
                        <div class="hint">다른 검색어로 다시 시도해보세요.</div>
                    </div>
                `);
            }
        } else {
            // 검색 결과가 있으면 empty-state 제거
            $('#' + activeTab + '-content .empty-state').remove();
        }
    }
</script>
</body>
</html>