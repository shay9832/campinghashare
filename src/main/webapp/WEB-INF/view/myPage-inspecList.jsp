<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                <div class="tab ${activeTab == 'storen' ? 'active' : ''}" data-tab="storen" id="storen-tab">스토렌</div>
                <div class="tab ${activeTab == 'storage' ? 'active' : ''}" data-tab="storage" id="storage-tab">보관</div>
            </div>

            <!-- 거래 ID 검색 -->
            <div class="search-container">
                <input type="text" id="search-service-id" placeholder="거래 ID를 입력하세요">
                <button type="button" class="search-button" id="btn-search">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'storen' ? 'active' : ''}" id="storen-content">
                <!-- 소유자/사용자 필터 -->
                <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
                    <!-- 탭 필터 -->
                    <div class="d-flex flex-wrap align-items-center">
                        <div class="tab-nav">
                            <a class="tab-link ${storenTabType == 'store' ? 'active' : ''}" data-storen-tab="store" id="storen-store">입고</a>
                        </div>
                        <div class="tab-nav">
                            <a class="tab-link ${storenTabType == 'return' ? 'active' : ''}" data-storen-tab="return" id="storen-return">반납</a>
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
                                <tr class="table-row" data-id="${inspec.service_id}">
                                    <td>${inspec.service_id}</td>
                                    <td>${inspec.delivery_id}</td>
                                    <td>${inspec.equip_code}</td>
                                    <td>${inspec.inspec_type.split('_')[1]}</td>
                                    <td class="title-cell delivery-name">${inspec.equip_name}</td>
                                    <td>${inspec.majorCategory} > ${inspec.middleCategory}</td>
                                    <td>${inspec.inspec_status}</td>
                                    <td>
                                <span class="grade-badge
                                    grade-${inspec.equip_grade}
                                ">
                                        ${inspec.equip_grade}
                                </span>
                                    </td>
                                    <td>${inspec.inspec_result_action_type}</td>
                                    <td>${inspec.completed_date}</td>
                                    <td>
                                        <button type="button" class="btn-sm btn-track-external"
                                                data-id="${inspec.service_id}">자세히..</button>
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
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    $(document).ready(function (){
        // 데이터 로드 상태 추적
        let loadedData = {
            'storage': false,
            'storen-return': false,
            'storen-store': true, // 초기 페이지 로드 시 이미 로드됨
        };

        // 현재 활성화된 스토렌 서브탭
        let currentStorenSubTab = '${storenTabType}'; // 초기값은 서버에서 받아옴

        // 메인 탭 전환 기능
        $('.tab').on('click', function() {
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
            if ($('#search-trade-id').val().trim() !== '') {
                performSearch();
            }
        });

        // 스토렌 서브탭 전환 기능
        $('#storen-content .tab-link').on('click', function () {
            // 서브탭 타입 가져오기
            currentStorenSubTab = $(this).data('storen-tab');
            console.log("서브탭 변경: " + currentStorenSubTab);

            // 서브탭 활성화
            $('#storen-content .tab-link').removeClass('active');
            $(this).addClass('active');

            // 강제로 데이터 로드 (캐시 무시)
            const dataKey = 'storen-' + currentStorenSubTab;
            loadedData[dataKey] = false; // 캐시 상태 재설정

            // 데이터 로드
            loadStorenData(currentStorenSubTab);
        });

        // 스토렌 데이터 로드 함수
        function loadStorenData(subTabType) {
            // 기본값 설정으로 오류 방지
            subTabType = subTabType || 'store';

            const dataKey = 'storen-' + subTabType;

            console.log("dataKey = " + dataKey); // 디버깅용
            console.log("loadedData[dataKey] = " + loadedData[dataKey]); // 디버깅용

            // 이미 로드된 데이터라면 다시 요청하지 않음
            if (loadedData[dataKey]) {
                return;
            }

            // 로딩 표시
            $('#storen-content .table-container tbody').html('<tr><td colspan="11" class="text-center">로딩 중...</td></tr>');

            // API 엔드포인트 결정
            const apiUrl = '${pageContext.request.contextPath}/api/inspec/storen/' + subTabType;

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // 데이터 로드 상태 업데이트
                    loadedData[dataKey] = true;

                    // 테이블 내용 업데이트
                    updateTableContent('#storen-content', data);

                    // 검색 필터 다시 적용
                    if ($('#search-service-id').val().trim() !== '') {
                        performSearch();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패: ' + error);
                    $('#storen-content .table-container tbody').html('<tr><td colspan="11" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
                }
            });
        }

        // 보관 데이터 로드 함수
        function loadStorageData() {

            const dataKey = 'storage';

            // 이미 로드된 데이터라면 다시 요청하지 않음
            if (loadedData[dataKey]) {
                return;
            }

            // 로딩 표시
            $('#storage-content .table-container tbody').html('<tr><td colspan="11" class="text-center">로딩 중...</td></tr>');

            // API 엔드포인트 결정
            const apiUrl = '${pageContext.request.contextPath}/api/inspec/storage';

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // 데이터 로드 상태 업데이트
                    loadedData[dataKey] = true;

                    // 테이블 내용 업데이트
                    updateTableContent('#storage-content', data);

                    // 검색 필터 다시 적용
                    if ($('#search-service-id').val().trim() !== '') {
                        performSearch();
                    }
                },
                error: function(xhr, status, error) {
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
            inspeclist.forEach(function(inspec, index) {
                console.log(`행 ${index} 처리 중:`, inspec);

                // 데이터의 유효성 검사 추가
                if (!inspec || !inspec.service_id) {
                    console.warn(`행 ${index}에 유효하지 않은 데이터:`, inspec);
                    return;
                }

                // 검수 타입 문자열 '_' 구분자로 잘라내기 - 안전하게 처리
                let InspecType = inspec.inspec_type || '';
                if (InspecType && InspecType.includes('_')) {
                    InspecType = InspecType.split('_')[1];
                }

                // 값이 없는 경우 기본값 사용
                const equip_grade = inspec.equip_grade || 'N/A';
                const majorCategory = inspec.majorCategory || '';
                const middleCategory = inspec.middleCategory || '';

                // 행 HTML 생성
                const row = `
            <tr class="table-row" data-id="${inspec.service_id}">
                <td>${inspec.service_id || ''}</td>
                <td>${inspec.delivery_id || ''}</td>
                <td>${inspec.equip_code || ''}</td>
                <td>${InspecType || ''}</td>
                <td class="title-cell delivery-name">${inspec.equip_name || ''}</td>
                <td>${majorCategory}${middleCategory ? ' > ' + middleCategory : ''}</td>
                <td>${inspec.inspec_status || ''}</td>
                <td>
                    <span class="grade-badge grade-${equip_grade}">
                        ${equip_grade}
                    </span>
                </td>
                <td>${inspec.inspec_result_action_type || ''}</td>
                <td>${inspec.completed_date || ''}</td>
                <td>
                    <button type="button" class="btn-sm btn-track-external"
                            data-id="${inspec.service_id}">자세히..</button>
                </td>
            </tr>
        `;

                tbody.append(row);
            });
        }

        // 검색 기능
        $('#btn-search').on('click', function() {
            performSearch();
        });

        // 엔터 키 검색
        $('#search-service-id').on('keypress', function(e) {
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
        const searchValue = $('#search-service-id').val().trim().toLowerCase();

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