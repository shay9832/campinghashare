<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    <!-- 마이페이지 전용 CSS - 통합된 버전 -->
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
        .custom-table tbody td:nth-child(3) {
            text-align: left; !important;
        }
    </style>
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
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link active">배송 조회/내역</a></li>
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
            <h2 class="page-title">배송 조회/내역</h2>
            <p class="page-description">대여, 반납, 보관과 관련된 배송 정보를 조회할 수 있습니다.</p>
        </div>

        <!-- 배송 조회 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tabs">
                <div class="tab ${activeTab == 'storen' ? 'active' : ''}" data-tab="storen">스토렌</div>
                <div class="tab ${activeTab == 'rental' ? 'active' : ''}" data-tab="rental">렌탈</div>
                <div class="tab ${activeTab == 'storage' ? 'active' : ''}" data-tab="storage">보관</div>
            </div>

            <!-- 거래 ID 검색 -->
            <div class="search-container">
                <input type="text" id="search-trade-id" placeholder="거래 ID를 입력하세요">
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
                            <a class="tab-link ${storenTabType == 'owner' ? 'active' : ''}" data-storen-tab="owner" id="storen-owner">소유자</a>
                        </div>
                        <div class="tab-nav">
                            <a class="tab-link ${storenTabType == 'user' ? 'active' : ''}" data-storen-tab="user" id="storen-user">사용자</a>
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
                            <th>스토렌 ID</th>
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>발송인</th>
                            <th>수취인</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 초기에 로드된 스토렌 소유자 배송 데이터 -->
                        <c:if test="${activeTab == 'storen' && storenTabType == 'owner'}">
                            <c:forEach var="delivery" items="${deliveryList}">
                                <tr class="table-row" data-id="${delivery.delivery_id}">
                                    <td>${delivery.storen_id}</td>
                                    <td>${delivery.delivery_type.split('_')[1]}</td>
                                    <td class="title-cell delivery-name">${delivery.equip_name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${delivery.sender == -1}">창고</c:when>
                                            <c:otherwise>${delivery.sender}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${delivery.receiver == -1}">창고</c:when>
                                            <c:otherwise>${delivery.receiver}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                <span class="status-badge
                                    ${delivery.statusClass}
                                ">
                                    ${delivery.status}
                                </span>
                                    </td>
                                    <td>${delivery.start_date}</td>
                                    <td>${delivery.end_date}</td>
                                    <td>
                                        <button type="button" class="btn-sm btn-track-external"
                                                data-company="${delivery.carrier_name}"
                                                data-tracking="${delivery.waybill_number}">조회</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 렌탈 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'rental' ? 'active' : ''}" id="rental-content">
                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>렌탈 ID</th>
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>발송인</th>
                            <th>수취인</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- AJAX로 로드될 데이터 -->
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
                            <th>보관 ID</th>
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>발송인</th>
                            <th>수취인</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
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

<script type="text/javascript">
    // 페이지 로딩 시 실행
    $(document).ready(function() {
        // // 데이터 로드 상태 추적
        // let loadedData = {
        //     'storage': false,
        //     'storen-owner': false,
        //     'storen-user': true, // 초기 페이지 로드 시 이미 로드됨
        //     'rental': false
        // };

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

            // 스토렌 탭이면 기본적으로 서브탭 owner가 활성화, 필요한 데이터 로드
            if (tabId === 'storen') {
                $('#storen-content .tab-link').removeClass('active');
                $('#storen-owner').addClass('active');
                currentStorenSubTab = 'owner';
                // 강제로 데이터 로드 (캐시 무시)
                //const dataKey = 'storen-' + currentStorenSubTab;
                //loadedData[dataKey] = false; // 캐시 상태 재설정
                loadStorenData(currentStorenSubTab);
            } else if (tabId === 'rental') {
                loadRentalData();
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
            //const dataKey = 'storen-' + currentStorenSubTab;
            //loadedData[dataKey] = false; // 캐시 상태 재설정

            // 데이터 로드
            loadStorenData(currentStorenSubTab);
        });

        // 스토렌 데이터 로드 함수
        function loadStorenData(subTabType) {
            // 기본값 설정으로 오류 방지
            subTabType = subTabType || 'owner';

            //const dataKey = 'storen-' + subTabType;

            //console.log("dataKey = " + dataKey); // 디버깅용
            //console.log("loadedData[dataKey] = " + loadedData[dataKey]); // 디버깅용

            // 이미 로드된 데이터라면 다시 요청하지 않음
            //if (loadedData[dataKey]) {
            //    return;
            //}

            // 로딩 표시
            $('#storen-content .table-container tbody').html('<tr><td colspan="9" class="text-center">로딩 중...</td></tr>');

            // API 엔드포인트 결정
            const apiUrl = '${pageContext.request.contextPath}/api/delivery/storen/' + subTabType;

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // 데이터 로드 상태 업데이트
                    //loadedData[dataKey] = true;

                    // 테이블 내용 업데이트
                    updateTableContent('#storen-content', data);

                    // 검색 필터 다시 적용
                    if ($('#search-trade-id').val().trim() !== '') {
                        performSearch();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패: ' + error);
                    $('#storen-content .table-container tbody').html('<tr><td colspan="9" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
                }
            });
        }

        // 렌탈 데이터 로드 함수
        function loadRentalData() {

            const dataKey = 'rental';

            // 이미 로드된 데이터라면 다시 요청하지 않음
            //if (loadedData[dataKey]) {
            //    return;
            //}

            // 로딩 표시
            $('#rental-content .table-container tbody').html('<tr><td colspan="9" class="text-center">로딩 중...</td></tr>');

            // API 엔드포인트 결정
            const apiUrl = '${pageContext.request.contextPath}/api/delivery/rental';

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // 데이터 로드 상태 업데이트
                    //loadedData[dataKey] = true;

                    // 테이블 내용 업데이트
                    updateTableContent('#rental-content', data);

                    // 검색 필터 다시 적용
                    if ($('#search-trade-id').val().trim() !== '') {
                        performSearch();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패: ' + error);
                    $('#rental-content .table-container tbody').html('<tr><td colspan="9" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
                }
            });
        }

        // 보관 데이터 로드 함수
        function loadStorageData() {

            const dataKey = 'storage';

            // 이미 로드된 데이터라면 다시 요청하지 않음
            //if (loadedData[dataKey]) {
            //    return;
            //}

            // 로딩 표시
            $('#storage-content .table-container tbody').html('<tr><td colspan="9" class="text-center">로딩 중...</td></tr>');

            // API 엔드포인트 결정
            const apiUrl = '${pageContext.request.contextPath}/api/delivery/storage';

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // 데이터 로드 상태 업데이트
                    //loadedData[dataKey] = true;

                    // 테이블 내용 업데이트
                    updateTableContent('#storage-content', data);

                    // 검색 필터 다시 적용
                    if ($('#search-trade-id').val().trim() !== '') {
                        performSearch();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패: ' + error);
                    $('#storage-content .table-container tbody').html('<tr><td colspan="9" class="text-center text-danger">데이터를 불러오는 데 실패했습니다.</td></tr>');
                }
            });
        }



        // 테이블 내용 업데이트 함수
        function updateTableContent(contentSelector, deliveries) {
            const tbody = $(contentSelector + ' .table-container tbody');
            tbody.empty();

            if (deliveries.length === 0) {
                tbody.html('<tr><td colspan="9" class="text-center">데이터가 없습니다.</td></tr>');
                return;
            }

            // 데이터 행 추가
            deliveries.forEach(function(delivery) {

                // 발송인/수취인 처리
                let senderText = delivery.sender === -1 ? '창고' : delivery.sender;
                let receiverText = delivery.receiver === -1 ? '창고' : delivery.receiver;

                // ID 값 결정 (스토렌/보관/렌탈)
                let idValue = '';
                if (contentSelector === '#storage-content') {
                    idValue = delivery.storage_id;
                } else if (contentSelector === '#storen-content') {
                    idValue = delivery.storen_id;
                } else if (contentSelector === '#rental-content') {
                    idValue = delivery.rental_id;
                }

                // 배송 타입 문자열 '_' 구분자로 잘라내기
                let deliveryType = delivery.delivery_type;
                if (deliveryType && deliveryType.includes('_')) {
                    deliveryType = deliveryType.split('_')[1];
                }

                // 행 HTML 생성
                const row =
                    '<tr class="table-row" data-id="' + delivery.delivery_id + '">' +
                    '<td>' + idValue + '</td>' +
                    '<td>' + deliveryType + '</td>' +
                    '<td class="title-cell delivery-name">' + delivery.equip_name + '</td>' +
                    '<td>' + senderText + '</td>' +
                    '<td>' + receiverText + '</td>' +
                    '<td>' +
                    '<span class="status-badge ' + delivery.statusClass + '">' + delivery.status + '</span>' +
                    '</td>' +
                    '<td>' + (delivery.start_date || '') + '</td>' +
                    '<td>' + (delivery.end_date || '') + '</td>' +
                    '<td>' +
                    '<button type="button" class="btn-sm btn-track-external" ' +
                    'data-company="' + delivery.carrier_name + '" ' +
                    'data-tracking="' + delivery.waybill_number + '">조회</button>' +
                    '</td>' +
                    '</tr>';

                tbody.append(row);
            });
        }

        // 배송업체 사이트 버튼 이벤트
        $(document).on('click', '.btn-track-external, #modal-external-track-btn', function(e) {
            e.stopPropagation(); // 이벤트 버블링 방지
            const company = $(this).data('company') || $('#modal-shipping-company').text();
            const trackingNumber = $(this).data('tracking') || $('#modal-tracking-number').text();
            openExternalTrackingPage(company, trackingNumber);
        });


        // 검색 기능
        $('#btn-search').on('click', function() {
            performSearch();
        });

        // 엔터 키 검색
        $('#search-trade-id').on('keypress', function(e) {
            if(e.which === 13) {
                performSearch();
            }
        });
    });

    // 검색 실행 함수
    function performSearch() {
        const searchValue = $('#search-trade-id').val().trim().toLowerCase();

        if(searchValue === '') {
            // 검색어가 없으면 모든 행 표시
            $('.table-row').show();
            return;
        }

        // 모든 활성 탭의 행을 검색
        const activeTab = $('.tab.active').data('tab');
        const rows = $(`#` + activeTab + `-content .table-row`);

        rows.each(function() {
            const rowData = $(this).text().toLowerCase();
            const rowId = $(this).data('id').toString();

            // ID를 포함하거나 텍스트에 검색어가 포함된 행만 표시
            if(rowId.includes(searchValue) || rowData.includes(searchValue)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        // 검색 결과가 없는 경우 처리
        const visibleRows = $(`#` + activeTab + `-content .table-row:visible`);
        if(visibleRows.length === 0) {
            // 이미 empty-state가 있는지 확인
            if($(`#` + activeTab + `-content .empty-state`).length === 0) {
                $(`#` + activeTab + `-content .table-container`).after(`
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <p>검색 결과가 없습니다</p>
                        <div class="hint">다른 검색어로 다시 시도해보세요.</div>
                    </div>
                `);
            }
        } else {
            // 검색 결과가 있으면 empty-state 제거
            $(`#` + activeTab + `-content .empty-state`).remove();
        }
    }

    // 외부 배송업체 사이트 열기
    function openExternalTrackingPage(company, trackingNumber) {
        let trackingUrl = '';

        switch(company) {
            case '우체국택배':trackingUrl = `https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${trackingNumber}`;
                break;
            case 'CJ대한통운':
                trackingUrl = `https://www.cjlogistics.com/ko/tool/parcel/tracking?gnbInvcNo=${trackingNumber}`;
                break;
            case '롯데택배':
                trackingUrl = `https://www.lotteglogis.com/home/reservation/tracking/index?InvNo=${trackingNumber}`;
                break;
            case '한진택배':
                trackingUrl = `https://www.hanjin.co.kr/kor/CMS/DeliveryMgr/WaybillResult.do?mCode=MN038&schLang=KR&wblnumText=${trackingNumber}`;
                break;
            case '로젠택배':
                trackingUrl = `https://www.ilogen.com/m/personal/trace/${trackingNumber}`;
                break;
            default:
                trackingUrl = `https://search.naver.com/search.naver?query=${trackingNumber}`;
        }

        window.open(trackingUrl, '_blank');
    }
</script>
</body>
</html>