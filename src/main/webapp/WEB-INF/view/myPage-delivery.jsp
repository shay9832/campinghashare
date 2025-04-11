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
                    <li><a href="myPage-delivery.jsp" class="sidebar-link active">배송 조회/내역</a></li>
                    <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
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
            <h2 class="page-title">배송 조회/내역</h2>
            <p class="page-description">대여, 반납, 보관과 관련된 배송 정보를 조회할 수 있습니다.</p>
        </div>

        <!-- 배송 조회 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tabs">
                <div class="tab active" data-tab="storage">보관</div>
                <div class="tab" data-tab="storen">스토렌</div>
                <div class="tab" data-tab="rental">렌탈</div>
            </div>

            <!-- 거래 ID 검색 -->
            <div class="search-container">
                <input type="text" id="search-trade-id" placeholder="거래 ID를 입력하세요">
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
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
                            <th>보관 ID</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row" data-id="1001">
                            <td>플랫폼_배송</td>
                            <td class="title-cell delivery-name">캠핑 텐트 세트</td>
                            <td>
                                <span class="status-badge status-progress">배송중</span>
                            </td>
                            <td>2023-04-28</td>
                            <td>2023-04-30</td>
                            <td>ST12345</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="CJ대한통운" data-tracking="123456789012">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1002">
                            <td>거래자_택배</td>
                            <td class="title-cell delivery-name">접이식 테이블 체어</td>
                            <td>
                                <span class="status-badge status-completed">배송완료</span>
                            </td>
                            <td>2023-04-20</td>
                            <td>2023-04-24</td>
                            <td>ST23456</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="롯데택배" data-tracking="987654321098">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1003">
                            <td>플랫폼_배송_반환</td>
                            <td class="title-cell delivery-name">캠핑 침낭</td>
                            <td>
                                <span class="status-badge status-pending">배송준비중</span>
                            </td>
                            <td>2023-05-01</td>
                            <td>2023-05-03</td>
                            <td>ST34567</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="우체국택배" data-tracking="567890123456">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="1004">
                            <td>보관_최종_반환</td>
                            <td class="title-cell delivery-name">코펠 세트</td>
                            <td>
                                <span class="status-badge status-completed">배송완료</span>
                            </td>
                            <td>2023-03-15</td>
                            <td>2023-03-18</td>
                            <td>ST45678</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="한진택배" data-tracking="456789012345">조회</button>
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
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
                            <th>스토렌 ID</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row" data-id="2001">
                            <td>플랫폼_배송</td>
                            <td class="title-cell delivery-name">등산용 배낭</td>
                            <td>
                                <span class="status-badge status-progress">배송중</span>
                            </td>
                            <td>2023-04-25</td>
                            <td>2023-04-27</td>
                            <td>SR12345</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="CJ대한통운" data-tracking="234567890123">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="2002">
                            <td>거래자_택배</td>
                            <td class="title-cell delivery-name">캠핑용 의자</td>
                            <td>
                                <span class="status-badge status-completed">배송완료</span>
                            </td>
                            <td>2023-04-18</td>
                            <td>2023-04-21</td>
                            <td>SR23456</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="롯데택배" data-tracking="345678901234">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="2003">
                            <td>스토렌_최종_반환_ID</td>
                            <td class="title-cell delivery-name">야외용 랜턴</td>
                            <td>
                                <span class="status-badge status-pending">배송준비중</span>
                            </td>
                            <td>2023-05-05</td>
                            <td>2023-05-08</td>
                            <td>SR34567</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="우체국택배" data-tracking="456789012345">조회</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 렌탈 탭 콘텐츠 -->
            <div class="tab-content" id="rental-content">
                <div class="table-container">
                    <table class="custom-table table">
                        <thead>
                        <tr>
                            <th>배송 유형</th>
                            <th>물품명</th>
                            <th>배송 상태</th>
                            <th>배송 시작일</th>
                            <th>배송 종료일</th>
                            <th>렌탈 ID</th>
                            <th>조회</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row" data-id="3001">
                            <td>플랫폼_배송</td>
                            <td class="title-cell delivery-name">바베큐 그릴</td>
                            <td>
                                <span class="status-badge status-progress">배송중</span>
                            </td>
                            <td>2023-04-22</td>
                            <td>2023-04-24</td>
                            <td>RT12345</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="CJ대한통운" data-tracking="567890123456">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="3002">
                            <td>거래자_택배_반환</td>
                            <td class="title-cell delivery-name">휴대용 가스버너</td>
                            <td>
                                <span class="status-badge status-completed">배송완료</span>
                            </td>
                            <td>2023-04-15</td>
                            <td>2023-04-17</td>
                            <td>RT23456</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="롯데택배" data-tracking="678901234567">조회</button>
                            </td>
                        </tr>
                        <tr class="table-row" data-id="3003">
                            <td>플랫폼_배송_반환</td>
                            <td class="title-cell delivery-name">감성 랜턴</td>
                            <td>
                                <span class="status-badge status-pending">배송준비중</span>
                            </td>
                            <td>2023-05-10</td>
                            <td>2023-05-12</td>
                            <td>RT34567</td>
                            <td>
                                <button type="button" class="btn-sm btn-track-external" data-company="우체국택배" data-tracking="789012345678">조회</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 배송 상세 조회 모달 -->
<div class="modal fade" id="deliveryDetailModal" tabindex="-1" aria-labelledby="deliveryDetailModalLabel" inert>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deliveryDetailModalLabel">배송 상세 조회</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-container mb-3">
                            <div class="info-row">
                                <div class="info-label">배송 유형</div>
                                <div class="info-value" id="modal-delivery-type">플랫폼_배송</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">물품명</div>
                                <div class="info-value" id="modal-item-name">캠핑 텐트 세트</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">주문 번호</div>
                                <div class="info-value" id="modal-order-id">ORD-2023-042815</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">배송 업체</div>
                                <div class="info-value" id="modal-shipping-company">CJ대한통운</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">운송장 번호</div>
                                <div class="info-value" id="modal-tracking-number">123456789012</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-container">
                            <div class="info-row">
                                <div class="info-label">현재 상태</div>
                                <div class="info-value">
                                    <span id="modal-shipping-status">배송중</span>
                                    <span class="status-badge status-progress" id="modal-status-badge">진행중</span>
                                </div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">배송 시작일</div>
                                <div class="info-value" id="modal-shipping-start">2023-04-28</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">배송 종료일</div>
                                <div class="info-value" id="modal-shipping-end">2023-04-30</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">관련 ID</div>
                                <div class="info-value" id="modal-related-id">보관_ID: ST12345</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">검수 결과</div>
                                <div class="info-value" id="modal-inspection-result">정상</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 타임라인 컨테이너 -->
                <div class="modal-timeline-container mt-4">
                    <div class="modal-timeline-title">배송 진행 상황</div>
                    <div id="shipping-timeline">
                        <!-- 타임라인 아이템은 자바스크립트로 동적 생성됩니다 -->
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="modal-external-track-btn">배송업체 사이트에서 조회</button>
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
        // 배송 탭 전환 기능
        $('.tab').on('click', function() {
            const tabId = $(this).data('tab');

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 콘텐츠 활성화
            $('.tab-content').removeClass('active');
            $(`#` + tabId + `-content`).addClass('active');
        });

        // 배송업체 사이트 버튼 이벤트
        $(document).on('click', '.btn-track-external, #modal-external-track-btn', function(e) {
            e.stopPropagation(); // 이벤트 버블링 방지
            const company = $(this).data('company') || $('#modal-shipping-company').text();
            const trackingNumber = $(this).data('tracking') || $('#modal-tracking-number').text();
            openExternalTrackingPage(company, trackingNumber);
        });

        // 배송 행 클릭 이벤트 (상세 모달 열기)
        $(document).on('click', '.table-row', function() {
            alert("안녕하세요 배송행이 클릭되었습니다.");
            const deliveryId = $(this).data('id');
            openDeliveryDetailModal(deliveryId);
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

    // 배송 상세 조회 모달 열기
    function openDeliveryDetailModal(deliveryId) {
        // 실제 구현 시에는 AJAX 요청으로 상세 데이터 로드
        // 여기서는 임시 데이터 사용

        // ID에 기반하여 탭 유형 판단
        let tabType = "storage";
        let relatedId = "보관_ID";

        if(deliveryId.toString().startsWith("2")) {
            tabType = "storen";
            relatedId = "스토렌_ID";
        } else if(deliveryId.toString().startsWith("3")) {
            tabType = "rental";
            relatedId = "렌탈_ID";
        }

        // 관련 행 찾기
        const row = $(`.table-row[data-id="${deliveryId}"]`);
        const deliveryType = row.find('td:eq(0)').text();
        const itemName = row.find('td:eq(1)').text();
        const status = row.find('td:eq(2) .status-badge').text();
        const startDate = row.find('td:eq(3)').text();
        const endDate = row.find('td:eq(4)').text();
        const relatedIdValue = row.find('td:eq(5)').text();
        const inspectionResult = row.find('td:eq(6)').text();
        const trackButton = row.find('.btn-track-external');
        const company = trackButton.data('company');
        const trackingNumber = trackButton.data('tracking');

        // 모달에 데이터 표시
        $('#modal-delivery-type').text(deliveryType);
        $('#modal-item-name').text(itemName);
        $('#modal-order-id').text(`ORD-${deliveryId}`);
        $('#modal-shipping-company').text(company);
        $('#modal-tracking-number').text(trackingNumber);
        $('#modal-shipping-status').text(status);
        $('#modal-shipping-start').text(startDate);
        $('#modal-shipping-end').text(endDate);
        $('#modal-related-id').text(`${relatedId}: ${relatedIdValue}`);
        $('#modal-inspection-result').text(inspectionResult);

        // 상태 배지 업데이트
        let statusBadgeClass = 'status-pending';
        let statusText = '예정';

        if (status === '배송중') {
            statusBadgeClass = 'status-progress';
            statusText = '진행중';
        } else if (status === '배송완료') {
            statusBadgeClass = 'status-completed';
            statusText = '완료';
        }

        $('#modal-status-badge').removeClass().addClass(`status-badge ${statusBadgeClass}`).text(statusText);

        // 임시 타임라인 데이터
        const mockTimeline = [
            {
                step: '배송 준비중',
                date: startDate + ' 09:15:00',
                description: '판매자가 배송을 준비하고 있습니다.',
                status: 'completed'
            },
            {
                step: '배송 시작',
                date: startDate + ' 14:30:00',
                description: '물품이 배송업체에 전달되었습니다.',
                status: 'completed'
            }
        ];

        // 상태에 따라 추가 타임라인 항목 설정
        if(status === '배송중' || status === '배송완료') {
            mockTimeline.push({
                step: '배송중',
                date: startDate.replace(/\d{2}$/, parseInt(startDate.slice(-2)) + 1) + ' 10:45:00',
                description: '물품이 배송 중입니다.',
                status: status === '배송중' ? 'active' : 'completed'
            });
        }

        if(status === '배송완료') {
            mockTimeline.push({
                step: '배송 완료',
                date: endDate + ' 15:20:00',
                description: '배송이 완료되었습니다.',
                status: 'completed'
            });
        } else {
            mockTimeline.push({
                step: '배송 완료',
                date: '예정: ' + endDate,
                description: '배송이 완료될 예정입니다.',
                status: 'pending'
            });
        }

        // 타임라인 렌더링
        const timelineContainer = $('#shipping-timeline');
        timelineContainer.empty();

        mockTimeline.forEach(item => {
            const timelineItemHtml = `
                <div class="modal-timeline-item ${item.status}">
                    <div class="modal-timeline-dot"></div>
                    <div class="modal-timeline-content">
                        <div class="modal-timeline-step">${item.step}</div>
                        <div class="modal-timeline-date">${item.date}</div>
                        <div class="modal-timeline-desc">${item.description}</div>
                    </div>
                </div>
            `;

            timelineContainer.append(timelineItemHtml);
        });

        // 모달 표시
        const deliveryDetailModal = new bootstrap.Modal(document.getElementById('deliveryDetailModal'));
        deliveryDetailModal.show();
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