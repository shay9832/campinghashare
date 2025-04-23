<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <style>
        /* 탭 네비게이션 스타일 */
        .tab-nav {
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .tab-link {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            color: #495057;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .tab-link:hover {
            background-color: #e9ecef;
        }

        .tab-nav .tab-link.active {
            color: var(--color-white);
            background-color: var(--color-maple);
        }
        /* 테이블 너무 긴 장비명 줄이기 */
        .custom-table .title-cell {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /* 테이블 행에서 마우스 커서 디폴트 (클릭 불가) */
        .table-container tr.table-row {
            cursor: default;
        }
        /* 테이블 장비명 열만 왼쪽 정렬 */
        .custom-table tbody td:nth-child(5) {
            text-align: left; !important;
        }
        /* 테이블 열 너비 조정 */
        .custom-table {
            width: 100%;
            table-layout: fixed; /* 고정 레이아웃 사용 */
        }

        /* 거래ID */
        .custom-table th:nth-child(1),
        .custom-table td:nth-child(1) {
            width: 7%;
        }

        /* 배송ID */
        .custom-table th:nth-child(2),
        .custom-table td:nth-child(2) {
            width: 7%;
        }

        /* 장비코드 */
        .custom-table th:nth-child(3),
        .custom-table td:nth-child(3) {
            width: 7%;
        }

        /* 검수유형 */
        .custom-table th:nth-child(4),
        .custom-table td:nth-child(4) {
            width: 7%;
        }

        /* 장비명 - 가장 넓게 */
        .custom-table th:nth-child(5),
        .custom-table td:nth-child(5) {
            width: 15%;
        }

        /* 카테고리 */
        .custom-table th:nth-child(6),
        .custom-table td:nth-child(6) {
            width: 12%;
        }

        /* 검수상태 */
        .custom-table th:nth-child(7),
        .custom-table td:nth-child(7) {
            width: 8%;
        }

        /* 장비등급 */
        .custom-table th:nth-child(8),
        .custom-table td:nth-child(8) {
            width: 8%;
        }

        /* 검수처리유형 */
        .custom-table th:nth-child(9),
        .custom-table td:nth-child(9) {
            width: 10%;
        }

        /* 검수일 */
        .custom-table th:nth-child(10),
        .custom-table td:nth-child(10) {
            width: 10%;
        }

        /* 조회 버튼 열 */
        .custom-table th:nth-child(11),
        .custom-table td:nth-child(11) {
            width: 9%;
        }

        /* 테이블 셀 내용 처리 */
        .custom-table td,
        .custom-table th {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 8px;
        }

        /* 등급 배지 */
        .grade-badge.grade-A {
            background-color: var(--grade-a) !important;
        }

        .grade-badge.grade-B {
            background-color: var(--grade-b);
        !important;
        }

        .grade-badge.grade-C {
            background-color: var(--grade-c);
        !important;
        }

        .grade-badge.grade-D {
            background-color: var(--grade-d);
        !important;
            color: var(--text-primary);
        !important;
        }

        .grade-badge.grade-E {
            background-color: var(--grade-e);
        !important;
            color: var(--text-primary);
        !important;
        }

        .grade-badge.grade-F {
            background-color: var(--grade-f);
        !important;
        }

        .grade-badge.grade-NA {
            background-color: #adb5bd;
        !important;
            color: white;
        !important;
        }

    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp"/>

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
                <div class="tab ${activeTab == 'storen' ? 'active' : ''}" data-tab="storen" id="storen-tab">스토렌</div>
                <div class="tab ${activeTab == 'storage' ? 'active' : ''}" data-tab="storage" id="storage-tab">보관</div>
            </div>

            <!-- 거래 ID 검색 -->
            <div class="search-container">
                <input type="text" id="search-service-id" placeholder="거래 ID를 입력하세요" value="${not empty storenId ? storenId : ''}">
                <button type="button" class="search-button" id="btn-search">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'storen' ? 'active' : ''}" id="storen-content">
                <!-- 입고/반납 필터 -->
                <div class="table-actions align-items-center flex-wrap mb-3">
                    <!-- 탭 필터 -->
                    <div class="d-flex flex-wrap align-items-center">
                        <div class="tab-nav">
                            <a class="tab-link ${storenTabType == 'store' ? 'active' : ''}" data-storen-tab="store"
                               id="storen-store">입고검수</a>
                        </div>
                        <div class="tab-nav">
                            <a class="tab-link ${storenTabType == 'return' ? 'active' : ''}" data-storen-tab="return"
                               id="storen-return">반납검수</a>
                        </div>
                    </div>

                    <!-- 정렬 옵션 (오른쪽) -->
                    <div class="d-flex align-items-center">
                        <!-- 날짜 필터 -->
                        <div class="date-filter me-2">
                            <select class="form-control">
                                <option>전체 기간</option>
                                <option>최근 1개월</option>
                                <option>최근 3개월</option>
                                <option>최근 6개월</option>
                            </select>
                        </div>

                        <!-- 정렬 옵션 -->
                        <div class="sort-container">
                            <select class="form-control sort-select">
                                <option>최신순</option>
                                <option>높은 점수순</option>
                                <option>낮은 점수순</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>거래ID</th>
                            <th>배송ID</th>
                            <th>장비코드</th>
                            <th>검수유형</th>
                            <th>장비명</th>
                            <th>카테고리</th>
                            <th>검수상태</th>
                            <th>장비등급</th>
                            <th>검수처리유형</th>
                            <th>검수일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 초기에 로드된 스토렌 입고 검수 데이터 -->
                        <c:if test="${activeTab == 'storen' && storenTabType == 'store'}">
                            <c:forEach var="inspec" items="${inspecList}">
                                <!-- 검수 완료 여부 체크 -->
                                <c:set var="isCompleted"
                                       value="${inspec.inspec_status != '검수대기중' && inspec.equip_grade != 'N/A'}"/>

                                <!-- 등급 클래스 처리 - N/A를 NA로 변환 -->
                                <c:set var="gradeClass"
                                       value="${inspec.equip_grade == 'N/A' ? 'NA' : inspec.equip_grade}"/>

                                <tr class="table-row" data-id="${inspec.service_id}">
                                    <td>${inspec.service_id}</td>
                                    <td>${inspec.delivery_id}</td>
                                    <td>${inspec.equip_code}</td>
                                    <td>${inspec.inspec_type.split('_')[1]}</td>
                                    <td class="title-cell delivery-name"
                                        title="${inspec.equip_name}">${inspec.equip_name}</td>
                                    <td>${inspec.majorCategory} > ${inspec.middleCategory}</td>
                                    <td>${inspec.inspec_status}</td>
                                    <td>
                                        <span class="grade-badge grade-${gradeClass}">
                                                ${inspec.equip_grade}
                                        </span>
                                    </td>
                                    <td>${inspec.inspec_result_action_type}</td>
                                    <td>${inspec.completed_date}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${isCompleted}">
                                                <!-- 검수 완료 시 inspec-result.action으로 이동 -->
                                                <a href="inspec-result.action?storen_id=${inspec.service_id}" class="btn-sm btn-detail" data-id="${inspec.service_id}">자세히</a>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- 미완료 시 버튼 비활성화 -->
                                                <button type="button" class="btn-sm btn-secondary" disabled>자세히</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 보관 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'storage' ? 'active' : ''}" id="storage-content">
                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>거래ID</th>
                            <th>배송ID</th>
                            <th>장비코드</th>
                            <th>검수유형</th>
                            <th>장비명</th>
                            <th>카테고리</th>
                            <th>검수상태</th>
                            <th>장비등급</th>
                            <th>검수처리유형</th>
                            <th>검수일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- AJAX로 로드될 데이터 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp"/>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    $(document).ready(function () {
        // 페이지 로드 시 URL 매개변수에 따른 초기화
        const activeTabId = '${activeTab}';  // 서버에서 받은 activeTab 값
        const storenTabType = '${storenTabType}';  // 서버에서 받은 storenTabType 값

        // URL 매개변수에 따른 적절한 탭 활성화
        if (activeTabId === 'storage') {
            // 보관 탭이 활성화된 경우
            $('#storage-tab').addClass('active');
            $('#storen-tab').removeClass('active');
            $('#storage-content').addClass('active');
            $('#storen-content').removeClass('active');

            // 보관 데이터 로드
            loadStorageData();
        } else if (activeTabId === 'storen' && storenTabType === 'return') {
            // 스토렌 탭의 반납검수 서브탭이 활성화된 경우
            $('#storen-store').removeClass('active');
            $('#storen-return').addClass('active');

            // 반납검수 데이터 로드
            loadStorenData('return');
        }

        // 페이지 로딩 시 검색창에 값이 있으면 자동 검색 실행
        const initialSearchValue = $('#search-service-id').val().trim();
        console.log('초기 검색값:', initialSearchValue);
        if(initialSearchValue !== '') {
            // 약간의 지연 후 검색 실행 (DOM이 완전히 로드된 후)
            setTimeout(function() {
                performSearch();
            }, 300);
        }

        // 현재 활성화된 스토렌 서브탭
        let currentStorenSubTab = storenTabType; // 초기값은 서버에서 받아옴

        // 메인 탭 전환 기능
        $('.tab').on('click', function () {
            const tabId = $(this).data('tab');

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 콘텐츠 활성화
            $('.tab-content').removeClass('active');
            $('#' + tabId + '-content').addClass('active');

            // 스토렌 탭이면 기본적으로 서브탭 store가 활성화, 필요한 데이터 로드
            if (tabId === 'storen') {
                $('#storen-content .tab-link').removeClass('active');
                $('#storen-store').addClass('active');
                currentStorenSubTab = 'store';
                loadStorenData(currentStorenSubTab);
            } else if (tabId === 'storage') {
                loadStorageData();
            }

            // 콘텐츠가 바뀌면 검색 결과 재설정
            const inputValue = $('#search-service-id').val();
            if (typeof inputValue === 'string' && inputValue.trim() !== '') {
                performSearch();
            }
        });

        // 스토렌 서브탭 전환 기능
        $('#storen-content .tab-link').on('click', function () {
            // 필터 상태 제거
            $('.filter-notice').remove();

            // 서브탭 타입 가져오기
            currentStorenSubTab = $(this).data('storen-tab');
            console.log("서브탭 변경: " + currentStorenSubTab);

            // 서브탭 활성화
            $('#storen-content .tab-link').removeClass('active');
            $(this).addClass('active');

            // 데이터 로드
            loadStorenData(currentStorenSubTab);
        });

        // 검색 기능 활성화
        $('#btn-search').on('click', function () {
            performSearch();
        });

        // 엔터 키 검색 활성화
        $('#search-service-id').on('keypress', function (e) {
            if (e.which === 13) {
                performSearch();
            }
        });

        // 필터 해제 버튼 클릭 이벤트
        $(document).on('click', '.btn-clear-filter', function() {
            clearFilters();
        });

        // 상세 버튼 클릭 이벤트
        $(document).on('click', '.btn-detail', function(e) {
            // 기본 클릭 이벤트 동작 중지 (페이지 이동 막기)
            e.preventDefault();

            // data-id 속성에서 검수 ID 가져오기
            const inspectionId = $(this).data('id');

            // 알림창 표시 후 페이지 이동
            alert('검수 ID ' + inspectionId + '의 상세 정보를 조회합니다.');

            // 원래 링크로 이동
            window.location.href = $(this).attr('href');
        });
    });

    //필터 초기화 함수
    function clearFilters() {
        // 필터 상태 제거
        $('.filter-notice').remove();

        // 원래 데이터 다시 로드
        loadStorenData('store');
    }

    // 스토렌 데이터 로드 함수
    function loadStorenData(subTabType) {
        // 기본값 설정으로 오류 방지
        subTabType = subTabType || 'store';

        // 로딩 표시
        $('#storen-content .table-container tbody').html('<tr><td colspan="11" class="text-center">로딩 중...</td></tr>');

        // API 엔드포인트 결정
        const apiUrl = '${pageContext.request.contextPath}/api/inspec/storen/' + subTabType;

        // AJAX 요청
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                // 테이블 내용 업데이트
                updateTableContent('#storen-content', data);

                // 검색 필터 다시 적용
                if ($('#search-service-id').val().trim() !== '') {
                    performSearch();
                }
            },
            error: function (xhr, status, error) {
                console.error('데이터 로드 실패: ' + error);
                $('#storen-content .table-container tbody').html('<tr><td colspan="11" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
            }
        });
    }

    // 보관 데이터 로드 함수
    function loadStorageData() {
        // 로딩 표시
        $('#storage-content .table-container tbody').html('<tr><td colspan="11" class="text-center">로딩 중...</td></tr>');

        // API 엔드포인트 결정
        const apiUrl = '${pageContext.request.contextPath}/api/inspec/storage';

        // AJAX 요청
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                // 테이블 내용 업데이트
                updateTableContent('#storage-content', data);

                // 검색 필터 다시 적용
                if ($('#search-service-id').val().trim() !== '') {
                    performSearch();
                }
            },
            error: function (xhr, status, error) {
                console.error('데이터 로드 실패: ' + error);
                $('#storage-content .table-container tbody').html('<tr><td colspan="11" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
            }
        });
    }

    // 테이블 내용 업데이트 함수
    function updateTableContent(contentSelector, inspeclist) {
        console.log("updateTableContent 호출됨, 선택자:", contentSelector, "데이터:", inspeclist);
        const tbody = $(contentSelector + ' .table-container tbody');
        tbody.empty();

        if (!inspeclist || inspeclist.length === 0) {
            tbody.html('<tr><td colspan="11" class="text-center">데이터가 없습니다.</td></tr>');
            return;
        }

        // 데이터 행 추가
        inspeclist.forEach(function (inspec) {
            // 검수 타입 문자열 '_' 구분자로 잘라내기 - 안전하게 처리
            let InspecType = inspec.inspec_type || '';
            if (InspecType && InspecType.includes('_')) {
                InspecType = InspecType.split('_')[1];
            }

            // 값이 없는 경우 기본값 사용
            const equip_grade = inspec.equip_grade || 'N/A';
            // 등급 클래스 설정 (N/A를 NA로 변환)
            let equip_grade_class = equip_grade === "N/A" ? "NA" : equip_grade;

            // 검수 완료 여부 확인 (서비스 계층에서 확인한 방식과 동일하게)
            const inspecStatus = inspec.inspec_status || '';
            const isInspectionCompleted = !(inspecStatus.includes('대기') || equip_grade === 'N/A');
            console.log(isInspectionCompleted);

            // 서비스 계층의 처리를 무시하지 않으면서 프론트엔드에서 추가 보호
            const resultActionType = (inspec.inspec_result_action_type && inspec.inspec_result_action_type !== 'null')
                ? inspec.inspec_result_action_type
                : '검수 대기중';

            const completedDate = (inspec.completed_date && inspec.completed_date !== 'null')
                ? inspec.completed_date
                : '검수 전';

            // 버튼 상태
            const buttonDisabled = !isInspectionCompleted ? 'disabled' : '';
            console.log(buttonDisabled);

            // 행 HTML 생성
            const row =
                '<tr class="table-row" data-id="' + inspec.service_id + '">' +
                '<td>' + inspec.service_id + '</td>' +
                '<td>' + (inspec.delivery_id || '-') + '</td>' +
                '<td>' + inspec.equip_code + '</td>' +
                '<td>' + InspecType + '</td>' +
                '<td class="title-cell delivery-name" title="' + inspec.equip_name + '">' + inspec.equip_name + '</td>' +
                '<td>' + inspec.majorCategory + ' > ' + inspec.middleCategory + '</td>' +
                '<td>' + inspec.inspec_status + '</td>' +
                '<td>' +
                '<span class="grade-badge grade-' + equip_grade_class + '">' +
                equip_grade +
                '</span>' +
                '</td>' +
                '<td>' + resultActionType + '</td>' +
                '<td>' + completedDate + '</td>' +
                '<td>' +
                (isInspectionCompleted
                    ? '<a href="inspec-result.action?storen_id=' + inspec.service_id + '" class="btn-sm btn-detail" data-id="' + inspec.service_id + '">자세히</a>'
                    : '<button type="button" class="btn-sm btn-secondary" disabled>자세히</button>') +
                '</td>' +
                '</tr>';

            tbody.append(row);
        });
    }

    // 검색 실행 함수
    function performSearch() {
        const searchValue = $('#search-service-id').val().trim();

        // 검색어가 숫자(ID)인 경우 API 호출, 그 외에는 기존 클라이언트 검색 수행
        if(searchValue !== '' && !isNaN(searchValue)) {
            // ID로 검색하는 경우
            const storenId = parseInt(searchValue);

            // 로딩 표시
            const activeTab = $('.tab.active').data('tab');
            $('#' + activeTab + '-content .table-container tbody').html(
                '<tr><td colspan="11" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 검색 중...</td></tr>'
            );

            // API 호출
            $.ajax({
                url: '/api/inspec/search',
                type: 'GET',
                data: {
                    id: storenId
                },
                dataType: 'json',
                success: function(data) {

                    // 필터 알림 추가
                    if ($('.filter-notice').length > 0) {
                        $('.filter-notice').remove();
                    }

                    $('#storen-content .table-actions').after(
                        '<div class="filter-notice">' +
                        '<span>"스토렌 ID : ' + storenId + '" 검색 결과 (' + data.length + '개)</span>' +
                        '<button class="btn-sm btn-clear-filter">모든 검수 결과 보기</button>' +
                        '</div>'
                    );

                    if(data.length === 0) {
                        // 검색 결과가 없는 경우
                        $('#' + activeTab + '-content .table-container tbody').html(
                            '<tr><td colspan="11" class="text-center py-4">검색 결과가 없습니다.</td></tr>'
                        );
                    } else {
                        // 결과 표시 - 직접 테이블 업데이트 호출
                        updateTableContent('#' + activeTab + '-content', data);
                    }

                    // 검색 완료 후 검색창 비우기
                    $('#search-service-id').val('');
                },
                error: function(xhr, status, error) {
                    console.error('검색 실패: ' + error);
                    $('#' + activeTab + '-content .table-container tbody').html(
                        '<tr><td colspan="11" class="text-center text-danger">검색 중 오류가 발생했습니다.</td></tr>'
                    );
                }
            });
        } else {
            // 기존 클라이언트 사이드 검색 수행 (텍스트 검색)
            const activeTab = $('.tab.active').data('tab');
            const rows = $('#' + activeTab + '-content .table-row');
            let foundMatch = false;

            if(searchValue === '') {
                // 검색어가 없으면 모든 행 표시
                rows.show();
                // empty-state 제거
                $('.empty-state').remove();
                return;
            }

            rows.each(function() {
                const rowData = $(this).text().toLowerCase();

                // 검색 조건 확인 (텍스트 포함 여부)
                if(rowData.includes(searchValue.toLowerCase())) {
                    $(this).show();
                    foundMatch = true;
                } else {
                    $(this).hide();
                }
            });

            // 검색 결과가 없는 경우 메시지 표시
            if(!foundMatch) {
                if($('#' + activeTab + '-content .empty-state').length === 0) {
                    $('#' + activeTab + '-content .table-container').after(
                        '<div class="empty-state">' +
                        '<i class="fas fa-search"></i>' +
                        '<p>검색 결과가 없습니다</p>' +
                        '<div class="hint">다른 검색어로 다시 시도해보세요.</div>' +
                        '</div>'
                    );
                }
            } else {
                $('#' + activeTab + '-content .empty-state').remove();
            }
        }
    }
</script>
</body>
</html>