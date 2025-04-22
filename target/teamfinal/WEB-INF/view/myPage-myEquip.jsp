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
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
    <style>
        /* 확장 행을 위한 스타일 */
        .matching-row.rental-header {
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .matching-row.rental-header:hover {
            background-color: #f5f8f5;
        }

        .matching-row.rental-header.active {
            background-color: #f5f8f5;
            border-bottom: none;
        }

        .matching-row.rental-header .match-count {
            font-weight: 600;
            color: #3f861d;
        }

        .matching-details-container {
            padding: 15px 20px;
            background-color: #f9f9f9;
            border-radius: 0 0 8px 8px;
        }

        .details-title {
            color: #2C5F2D;
            margin-bottom: 15px;
            font-weight: 600;
            font-size: 15px;
        }

        .details-info {
            margin-bottom: 15px;
            font-size: 14px;
            color: #555;
            background-color: #f0f4f0;
            padding: 10px 15px;
            border-radius: 4px;
            border-left: 3px solid #2C5F2D;
        }

        .details-info.matched {
            background-color: #e8f5e8;
            border-left: 3px solid #4caf50;
        }

        .details-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .details-table th {
            background-color: #f0f4f0;
            color: #555;
            padding: 10px;
            text-align: center;
            font-weight: 500;
        }

        .details-table td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
            text-align: center;
        }

        .details-table tr:last-child td {
            border-bottom: none;
        }

        .text-left {
            text-align: left !important;
        }

        .my-form-check-input {
            position: relative;         !important;
            left: auto;                 !important;
            top: auto;                  !important;
            width: 18px;                !important;
            height: 18px;               !important;
            cursor: pointer;            !important;
            accent-color: #2C5F2D;      !important;
            border: 1px solid #adb5bd;  !important;
            border-radius: 3px;         !important;
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
                    <li><a href="mypage-myequip.action" class="sidebar-link active">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
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
            <h2 class="page-title">내가 소유한 장비</h2>
            <p class="page-description">등록한 캠핑 장비를 관리하고 스토렌, 렌탈, 보관 서비스를 신청할 수 있습니다.</p>
        </div>

        <!-- 이용 내역 섹션 -->
        <div class="section-header">이용 내역</div>
        <div class="two-column-layout">
            <!-- 즉시 확인 필요 박스 (왼쪽) -->
            <div class="urgent-box">
                <div class="urgent-header">즉시 확인 필요</div>
                <div class="urgent-content">
                    <a href="#" class="urgent-item">
                        <div class="item-label">보관비 결제 대기</div>
                        <div class="item-count">${emergencyMap["보관비 결제 대기"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">검수 결과 확인(입고/반환)</div>
                        <div class="item-count">${emergencyMap["검수 결과 확인"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">매칭 승인 대기</div>
                        <div class="item-count">${emergencyMap["매칭 승인 대기"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">문제 상황 발생</div>
                        <div class="item-count">${emergencyMap["문제 상황 발생"]}</div>
                    </a>
                </div>
            </div>

            <!-- 거래 현황 박스 (오른쪽) -->
            <div class="transaction-status-box">
                <div class="status-header">거래 현황</div>
                <div class="status-content">
                    <!-- 스토렌 -->
                    <div class="status-row">
                        <div class="status-type">스토렌</div>
                        <div class="chevron-arrows">
                            <c:if test="${!empty storenStatusMap}">
                                <c:forEach var="status" items="${storenStatusMap}">
                                    <c:set var="cssClass" value=""/>
                                    <c:if test="${status.value > 0}">
                                        <c:set var="cssClass" value="active"/>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${status.key eq '보관비 결제 대기' || status.key eq '상태 불명' || status.key eq '강제 반환'}">
                                            <%-- 아무것도 하지 않음(continue처럼) --%>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" class="arrow-step ${cssClass}" data-status="${status.key}">
                                                <span class="arrow-badge">${status.value}</span>
                                                <span class="arrow-label">${status.key}</span>
                                                <div class="arrow-chevron"></div>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>

                    <!-- 렌탈 -->
                    <div class="status-row">
                        <div class="status-type">렌탈</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 보관 -->
                    <div class="status-row">
                        <div class="status-type">보관</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 검색과 정렬 -->
        <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
            <!-- 검색 섹션 -->
            <div class="d-flex flex-wrap align-items-center">
                <div class="search-container mb-4">
                    <input type="text" id="search-equip" class="form-control" placeholder="장비명, 브랜드명, 카테고리로 검색">
                    <button class="search-button" id="btn-search-equip">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="d-flex align-items-center">
                <!-- 날짜 필터 -->
                <div class="date-filter me-2">
                    <select class="sort-select">
                        <option>정렬</option>
                        <option>최신순</option>
                        <option>이름순</option>
                        <option>등급순</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- 장비 관리 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tabs">
                <div class="tab active" data-tab="general" id="general-tab">일반 장비 <span class="badge-count">${equipList.size()}</span></div>
                <div class="tab" data-tab="storen" id="storen-tab">스토렌 <span class="badge-count">${count["storen"]}</span></div>
                <div class="tab" data-tab="rental" id="rental-tab">렌탈 <span class="badge-count">0</span></div>
                <div class="tab" data-tab="storage" id="storage-tab">보관 <span class="badge-count">0</span></div>
            </div>

            <!-- 일반 장비 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'general' ? 'active' : ''}" id="general-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-general" class="my-form-check-input">
                        <label for="select-all-general">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-general">
                            <i class="fas fa-trash-alt me-1"></i> 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col" style="min-width:0;"></th>
                            <th style="width:30%; !important">장비 이미지</th>
                            <th style="width:40%; !important">일반 장비 정보</th>
                            <th style="width:20%; !important">신청</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <%-- 소유한 일반 장비가 하나도 없다면 --%>
                            <c:when test="${empty equipList || equipList.size() == 0}">
                                <tr>
                                    <td colspan="4" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-box-open mb-3" style="font-size: 2rem; color: #ccc;"></i>
                                            <p class="mb-1">소유한 일반 장비가 없습니다.</p>
                                            <p class="small text-muted">캠핑 장비를 등록하고 스토렌, 렌탈, 보관 서비스를 이용해보세요.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="equip" items="${equipList}">
                                        <tr class="table-row">
                                            <td class="checkbox-col">
                                                <input type="checkbox" class="my-form-check-input equip-checkbox">
                                            </td>
                                            <td>
                                                <div class="product-image">
                                                    <img src="${equip.attachments.get(0).attachmentPath}" alt="상품 이미지">
                                                </div>
                                            </td>
                                            <td>
                                                <div class="equipment-info-container">
                                                    <input type="hidden" name="equip_code" value="${equip.equip_code}">
                                                    <div class="equipment-code">장비코드 : ${equip.equip_code}</div>
                                                    <a href="#" class="equipment-name">${equip.equip_name}</a>
                                                    <div class="equipment-category">${equip.majorCategory} > ${equip.middleCategory}</div>
                                                    <div class="equipment-brand">${equip.brand}</div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="button-group-vertical">
                                                    <button class="btn-sm btn-storen" onclick="location.href='storenRegister-storage-info.action?equip_code=${equip.equip_code}'">스토렌 신청</button>
                                                    <button class="btn-sm btn-rental">렌탈 신청</button>
                                                    <button class="btn-sm btn-storage">보관 신청</button>
                                                </div>
                                            </td>
                                        </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'storen' ? 'active' : ''}" id="storen-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-storen" class="my-form-check-input">
                        <label for="select-all-storen">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-storen">
                            <i class="fas fa-trash-alt me-1"></i> 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col" style="min-width:0px;"></th>
                            <th style="width:15%; !important">장비 이미지</th>
                            <th style="width:30%; !important">일반 장비 정보</th>
                            <th style="width:30%; !important">스토렌 정보</th>
                            <th style="width:25%; !important">처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 렌탈 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'rental' ? 'active' : ''}" id="rental-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-rental" class="my-form-check-input">
                        <label for="select-all-rental">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-rental">
                            <i class="fas fa-trash-alt me-1"></i> 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col"></th>
                            <th>장비 이미지</th>
                            <th>장비 정보</th>
                            <th>렌탈ID</th>
                            <th>처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="5" class="text-center py-5">
                                <div class="empty-state">
                                    <i class="fas fa-exchange-alt mb-3" style="font-size: 2rem; color: #ccc;"></i>
                                    <p class="mb-1">렌탈로 등록된 장비가 없습니다.</p>
                                    <p class="small text-muted">장비를 렌탈로 등록하면 직접 다른 사용자에게 대여할 수 있습니다.</p>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 보관 탭 콘텐츠 -->
            <div class="tab-content ${activeTab == 'storage' ? 'active' : ''}" id="storage-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-storage" class="my-form-check-input">
                        <label for="select-all-storage">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-storage">
                            <i class="fas fa-trash-alt me-1"></i> 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col"></th>
                            <th>장비 이미지</th>
                            <th>장비 정보</th>
                            <th>보관ID</th>
                            <th>처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="5" class="text-center py-5">
                                <div class="empty-state">
                                    <i class="fas fa-warehouse mb-3" style="font-size: 2rem; color: #ccc;"></i>
                                    <p class="mb-1">보관 중인 장비가 없습니다.</p>
                                    <p class="small text-muted">캠핑 시즌이 아닐 때는 장비를 안전하게 보관해보세요.</p>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 추가 버튼 -->
        <div class="text-right mb-5">
            <button class="btn-circle" onclick="window.location.href='equipregister-majorcategory.action'">
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

<!-- 삭제 확인 모달 -->
<div class="modal fade confirmation-modal" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmModalLabel">장비 삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>선택한 장비를 정말 삭제하시겠습니까?</p>
                <p class="text-danger">이 작업은 되돌릴 수 없습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-confirm" id="confirmDelete">삭제</button>
            </div>
        </div>
    </div>
</div>

<!-- 로딩 오버레이 -->
<div class="loading-overlay" style="display: none;">
    <div class="spinner">
        <i class="fas fa-circle-notch fa-spin"></i>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(function() {
        // 전역 변수 및 초기화=============================================================================================
        // URL에서 탭 정보 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        let activeMainTab = urlParams.get('tab') || "general"; // URL 파라미터 또는 기본값

        // 초기화 즉시 실행
        initializePage();

        // 페이지 초기화 및 이벤트 바인딩 함수===============================================================================
        //페이지 초기화 함수 - 초기 이벤트 바인딩 및 설정
        function initializePage() {
            // 이벤트 바인딩
            bindTabEvents();
            bindCheckboxEvents();
            bindButtonEvents();
            bindSearchEvents();

            // 현재 탭의 데이터 로드
            loadEquipmentData(activeMainTab);
        }

        //탭 전환 이벤트 바인딩
        function bindTabEvents() {
            // 탭 클릭 이벤트
            $('.tab').on('click', function() {
                handleTabChange($(this).data('tab'));
            });

            // 화살표 상태 필터 버튼 클릭 이벤트
            $(document).on('click', '.arrow-step', function(e) {
                e.preventDefault();
                handleStatusFilter($(this));
            });

            // 필터 해제 버튼 클릭 이벤트
            $(document).on('click', '.btn-clear-filter', function() {
                clearFilters();
            });
        }

        //체크박스 관련 이벤트 바인딩
        function bindCheckboxEvents() {
            // 전체 선택 체크박스 이벤트
            $('#select-all-general').on('change', function() {
                $('#general-content .equip-checkbox').prop('checked', $(this).prop('checked'));
            });

            $('#select-all-storen').on('change', function() {
                $('#storen-content .storen-checkbox').prop('checked', $(this).prop('checked'));
            });

            $('#select-all-rental').on('change', function() {
                $('#rental-content .rental-checkbox').prop('checked', $(this).prop('checked'));
            });

            $('#select-all-storage').on('change', function() {
                $('#storage-content .storage-checkbox').prop('checked', $(this).prop('checked'));
            });

            // 개별 체크박스 변경 시 전체 선택 체크박스 업데이트
            $('#general-content').on('change', '.equip-checkbox', function() {
                updateSelectAllCheckbox('general');
            });

            $('#storen-content').on('change', '.storen-checkbox', function() {
                updateSelectAllCheckbox('storen');
            });

            $('#rental-content').on('change', '.rental-checkbox', function() {
                updateSelectAllCheckbox('rental');
            });

            $('#storage-content').on('change', '.storage-checkbox', function() {
                updateSelectAllCheckbox('storage');
            });
        }

        //버튼 이벤트 바인딩
        function bindButtonEvents() {
            // 일반 장비 탭 버튼(스토렌 신청/렌탈 신청/보관 신청)
            $(document).on('click', '.btn-storen', function(e) {
                e.preventDefault();
                const equipCode = $(this).closest("tr").find("input[name='equip_code']").val();
                window.location.href = "storenRegister-storage-info.action?equip_code=" + equipCode;
            });

            $(document).on('click', '.btn-rental', function(e) {
                e.preventDefault();
                const equipCode = $(this).closest("tr").find("input[name='equip_code']").val();
                window.location.href = "rentalRegister-info.jsp?equip_code=" + equipCode;
            });

            $(document).on('click', '.btn-storage', function(e) {
                e.preventDefault();
                const equipCode = $(this).closest("tr").find("input[name='equip_code']").val();
                window.location.href = "storageRegister-storage-info.jsp?equip_code=" + equipCode;
            });

            // 스토렌 탭 버튼(보관비 결제 필요/배송 내역 조회/검수 결과 확인)
            $(document).on('click', '.btn-inspection, .btn-shipping, .btn-pay', function(e) {
                e.preventDefault();
                e.stopPropagation();
                const id = $(this).closest("tr").find("input[name='id']").val();

                if($(this).hasClass('btn-inspection')) {
                    window.location.href = "mypage-inspecList.action?id=" + id + "&activeTab=storen&storenTabType=store";
                } else if($(this).hasClass('btn-shipping')) {
                    window.location.href = "mypage-delivery.action?id=" +  + "&activeTab=storen&storenTabType=owner";
                } else if($(this).hasClass('btn-pay')) {
                    window.location.href = "storenregister-storage-pay.action?id=" + id;
                }
            });

            // 스토렌 확장 테이블 버튼(매칭신청확인)
            $(document).on('click', '.btn-approve', function(e) {
                e.preventDefault();
                e.stopPropagation();
                const id = $(this).closest("tr").find("input[name='id']").val();
                window.location.href = "mypage-matchinglist.action?id=" + id + "&activeTab=storen&storenTabType=owner";
            });

            // 삭제 버튼 클릭 시 모달 표시
            $('.btn-delete').on('click', function() {
                const tabId = $(this).attr('id').split('-').pop();
                const selectedCount = $('.' + tabId + '-checkbox:checked').length;

                if (selectedCount === 0) {
                    alert('삭제할 장비를 선택해주세요.');
                    return;
                }

                $('#deleteConfirmModal').modal('show');
                $('#deleteConfirmModal').data('tab-id', tabId);
            });

            // 삭제 확인 버튼 클릭
            $('#confirmDelete').on('click', function() {
                const tabId = $('#deleteConfirmModal').data('tab-id');

                // 실제 삭제 로직 구현 (AJAX 호출 등)
                console.log(tabId + ' 탭에서 선택된 항목 삭제');

                // 체크된 행 삭제 (서버 요청 후 성공 시 수행해야 함)
                $('.' + tabId + '-checkbox:checked').closest('tr').remove();

                // 전체 선택 체크박스 해제
                $('#select-all-' + tabId).prop('checked', false);

                // 모달 닫기
                $('#deleteConfirmModal').modal('hide');
            });
        }

        //검색 이벤트 바인딩
        function bindSearchEvents() {
            $('#btn-search-equip').on('click', function() {
                performSearch();
            });

            $('#search-equip').on('keypress', function(e) {
                if(e.which === 13) {
                    performSearch();
                }
            });
        }

        // 탭 관리 및 데이터 로드 함수======================================================================================
        //탭 변경 처리 함수
        function handleTabChange(tabId) {
            // 현재 활성화된 탭이면 아무것도 하지 않음
            if(activeMainTab === tabId) return;

            // 이전 데이터 정리
            clearPreviousData();

            // 탭 활성화
            $('.tab').removeClass('active');
            $('.tab[data-tab="' + tabId + '"]').addClass('active');

            // 콘텐츠 활성화
            $('.tab-content').hide();
            $('#' + tabId + '-content').show();

            // 메인 탭 상태 저장
            activeMainTab = tabId;

            // 데이터 로드
            loadEquipmentData(activeMainTab);
        }

        //이전 탭 데이터 정리 함수
        function clearPreviousData() {
            // 모든 확장된 행 닫기
            $('.rental-header').removeClass('active').attr('data-expanded', 'false');
            // 모든 상세 행 제거
            $('.matching-details').remove();
        }

        //장비 데이터 로드 함수
        //@param {string} mainTab - 로드할 데이터의 탭 ID
        function loadEquipmentData(mainTab) {
            // 로딩 표시 활성화
            showLoading();

            let apiUrl = '';
            let colSpan = '5';

            // targetTable 초기화
            let targetTable;

            // 메인 탭에 따라 API URL 결정
            if (mainTab === 'general') {
                apiUrl = '/api/myequipment/general';
                colSpan = '4';
                targetTable = $('#general-content tbody');
            } else if (mainTab === 'storen') {
                apiUrl = '/api/myequipment/storen';
                targetTable = $('#storen-content tbody');
            } else if (mainTab === 'rental') {
                apiUrl = '/api/myequipment/rental';
                targetTable = $('#rental-content tbody');
            } else { // 보관 탭
                apiUrl = '/api/myequipment/storage';
                targetTable = $('#storage-content tbody');
            }

            console.log("데이터 로드 중:", apiUrl, "메인탭:", mainTab);

            // 로딩 인디케이터 표시
            targetTable.html('<tr><td colspan="' + colSpan + '" class="text-center py-4"><i class="fas fa-spinner fa-spin me-2"></i> 장비 데이터를 불러오는 중...</td></tr>');

            // AJAX 요청
            $.ajax({
                url: apiUrl,
                type: 'GET',
                dataType: 'json',
                cache: false,
                success: function (data) {
                    console.log("데이터 로드 성공:", data.length, "건");
                    if (data.length > 0) {
                        console.log("데이터 구조:", JSON.stringify(data[0]));

                        // equipmentDTO가 없는 데이터 확인
                        const missingEquipDTOs = data.filter(item => !item.equipmentDTO);
                        console.log("equipmentDTO가 없는 항목:", missingEquipDTOs.length, "건");
                        if (missingEquipDTOs.length > 0) {
                            console.log("첫 번째 문제 항목:", missingEquipDTOs[0]);
                        }
                    }

                    hideLoading();

                    if (data.length === 0) {
                        showEmptyState(mainTab, targetTable);
                        return;
                    }

                    // 메인 탭의 정보 렌더링
                    renderData(data, targetTable);
                },
                error: function (xhr, status, error) {
                    console.error("데이터 로드 실패:", error);
                    hideLoading();

                    showErrorState(targetTable, colSpan);
                }
            });
        }

        //비어있는 상태 표시 함수
        //@param {string} mainTab - 현재 탭
        //@param {jQuery} targetTable - 대상 테이블
        function showEmptyState(mainTab, targetTable) {
            let type = '';
            let icon = '';
            let text = '';

            if (mainTab === 'general') {
                type = '일반';
                icon = 'fas fa-box-open mb-3';
                text = '캠핑 장비를 등록하고 스토렌, 렌탈, 보관 서비스를 이용해보세요.';
            } else if (mainTab === 'storen') {
                type = '스토렌';
                icon = 'fas fa-store-alt mb-3';
                text = '장비를 스토렌으로 등록하면 간편하게 장비를 맡기고 수익창출을 할 수 있습니다.';
            } else if (mainTab === 'rental') {
                type = '렌탈';
                icon = 'fas fa-exchange-alt mb-3';
                text = '장비를 렌탈로 등록하면 직접 다른 사용자에게 대여할 수 있습니다.';
            } else {
                type = '보관';
                icon = 'fas fa-warehouse mb-3';
                text = '캠핑 시즌이 아닐 때는 장비를 안전하게 보관해보세요.';
            }

            const emptyHTML = '<tr>' +
                '<td colspan="5" class="text-center py-5">' +
                '<div class="empty-state">' +
                '<i class="' + icon + '" style="font-size: 2rem; color: #ccc;"></i>' +
                '<p class="mb-1">소유한 ' + type + ' 장비가 없습니다.</p>' +
                '<p class="small text-muted">' + text + '</p>' +
                '</div>' +
                '</td>' +
                '</tr>';

            targetTable.html(emptyHTML);
        }

        //에러 상태 표시 함수
        //@param {jQuery} targetTable - 대상 테이블
        //@param {string} colSpan - 병합할 칼럼 수
        function showErrorState(targetTable, colSpan) {
            targetTable.html('<tr>' +
                '<td colspan="' + colSpan + '" class="text-center py-4">' +
                '<div class="alert alert-danger" role="alert">' +
                '<i class="fas fa-exclamation-circle me-2"></i> 데이터를 불러오는 중 오류가 발생했습니다.' +
                '</div>' +
                '</td>' +
                '</tr>');
        }


        // 데이터 렌더링 및 필터링 함수======================================================================================
        //테이블 데이터 렌더링 함수
        //@param {Array} data - 렌더링할 데이터
        //@param {jQuery} targetTable - 대상 테이블
        function renderData(data, targetTable) {
            let html = '';
            const activeTab = $('.tab.active').data('tab');
            const formatter = new Intl.NumberFormat('ko-KR');   //금액 천 단위로 표시할 숫자 포맷터

            data.forEach(function(item) {
                if (activeTab === 'general') {
                    html += renderGeneralRow(item, formatter);
                } else if (activeTab === 'storen') {
                    html += renderStorenRow(item, formatter);
                }
                // 다른 탭 렌더링 추가 예정
            });

            targetTable.html(html);

            // 이벤트 핸들러 다시 바인딩
            if(activeTab === 'storen') {
                bindStorenButtonEvents();
            }
        }

        //일반 장비 행 렌더링 함수
        //@param {Object} item - 장비 데이터
        //@param {Intl.NumberFormat} formatter - 숫자 포맷터
        //@returns {string} HTML 문자열
        function renderGeneralRow(item, formatter) {
            var imgSrc = (item.attachments && item.attachments.length > 0) ?
                item.attachments[0].attachmentPath : 'images/product-placeholder.jpg';

            return '<tr class="table-row">' +
                '<td class="checkbox-col">' +
                '<input type="checkbox" class="my-form-check-input equip-checkbox">' +
                '</td>' +
                '<td>' +
                '<div class="product-image">' +
                '<img src="' + imgSrc + '" alt="상품 이미지">' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="equipment-info-container">' +
                '<input type="hidden" name="equip_code" value="' + item.equip_code + '">' +
                '<div class="equipment-info-text">장비코드 : ' + item.equip_code + '</div>' +
                '<a href="#" class="equipment-name">' + item.equip_name + '</a>' +
                '<div class="equipment-info-text">' + item.majorCategory + ' > ' + item.middleCategory + '</div>' +
                '<div class="equipment-info-text">' + item.brand + '</div>' +
                '<div class="equipment-info-text"> 신품가 : ' + formatter.format(parseInt(item.original_price)) + '원</div>' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="button-group-vertical">' +
                '<button class="btn-sm btn-storen">스토렌 신청</button>' +
                '<button class="btn-sm btn-rental">렌탈 신청</button>' +
                '<button class="btn-sm btn-storage">보관 신청</button>' +
                '</div>' +
                '</td>' +
                '</tr>';
        }

        //스토렌 장비 행 렌더링 함수
        //@param {Object} item - 장비 데이터
        //@param {Intl.NumberFormat} formatter - 숫자 포맷터
        //@returns {string} HTML 문자열
        function renderStorenRow(item, formatter) {
            // 버튼 리스트 생성
            var buttonList = generateButtonList(item.status);

            // 장비 정보 추출
            var equipInfo = extractEquipmentInfo(item, formatter);

            // 상태 클래스 가져오기
            var statusClass = getStatusBadgeClass(item.status);

            return '<tr class="table-row matching-row rental-header" data-id="' + item.equip_code + '" data-expanded="false">' +
                '<td class="checkbox-col">' +
                '<input type="checkbox" class="my-form-check-input storen-checkbox">' +
                '</td>' +
                '<td>' +
                '<div class="product-image">' +
                '<img src="' + equipInfo.imgSrc + '" alt="상품 이미지">' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="equipment-info-container">' +
                '<div class="equipment-info-text">장비 코드 : ' + item.equip_code + '</div>' +
                '<a href="#" class="equipment-name">' + equipInfo.name + '</a>' +
                '<div class="equipment-info-text">' + equipInfo.category + '</div>' +
                '<div class="equipment-info-text">' + equipInfo.brand + '</div>' +
                '<div class="equipment-info-text">' + equipInfo.createdDate + '</div>' +
                '<div class="equipment-info-text">신품가 : ' + equipInfo.price + '원</div>' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="equipment-info-container">' +
                '<input type="hidden" name="id" value="' + item.storen_id + '">' +
                '<div class="equipment-info-text">스토렌ID : ' + item.storen_id + '</div>' +
                '<a href="storenmatching-request.action?storen_id=' + item.storen_id + '" class="equipment-name">' + (item.storen_title || '제목 없음') + '</a>' +
                '<div class="equipment-info-text">' + (item.store_month || '0') + '개월 보관</div>' +
                '<div class="status-badge ' + statusClass + '">' + (item.status || '정보 없음') + '</div>' +
                '<div class="equipment-info-text">보관시작일 : ' + (item.inspec_completed_date || '검수 중') + '</div>' +
                '<div class="equipment-info-text">보관종료일 : ' + (item.final_return_date || '정보 없음') + '</div>' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="button-group-vertical">' + buttonList + '</div>' +
                '</td>' +
                '</tr>';
        }

        //장비 정보 추출 함수
        //@param {Object} item - 장비 데이터
        //@param {Intl.NumberFormat} formatter - 숫자 포맷터
        //@returns {Object} 추출된 장비 정보
        function extractEquipmentInfo(item, formatter) {
            var name = '이름 없음';
            var category = '';
            var brand = '';
            var createdDate = '';
            var price = '0';
            var imgSrc = 'images/product-placeholder.jpg';

            // equipmentDTO가 존재하는 경우에만 값을 읽음
            if (item.equipmentDTO) {
                name = item.equipmentDTO.equip_name || '이름 없음';

                var majorCategory = item.equipmentDTO.majorCategory || '';
                var middleCategory = item.equipmentDTO.middleCategory || '';
                category = majorCategory + (middleCategory ? ' > ' + middleCategory : '');

                brand = item.equipmentDTO.brand || '';
                createdDate = item.equipmentDTO.created_date || '';
                price = formatter.format(parseInt(item.equipmentDTO.original_price || 0));

                // 이미지 경로 가져오기 시도
                if (item.equipmentDTO.attachments && item.equipmentDTO.attachments.length > 0) {
                    imgSrc = item.equipmentDTO.attachments[0].attachmentPath;
                }
            }

            return {
                name: name,
                category: category,
                brand: brand,
                createdDate: createdDate,
                price: price,
                imgSrc: imgSrc
            };
        }

        //상태에 따른 버튼 리스트 생성 함수
        //@param {string} status - 장비 상태
        //@returns {string} 버튼 HTML 문자열
        function generateButtonList(status) {
            if (status === '보관비 결제 대기') {
                return '<button class="btn-sm btn-pay">보관비 결제필요</button>' +
                    '<button class="btn-sm btn-shipping" disabled="disabled">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection" disabled="disabled">검수 결과 확인</button>';
            } else if (status === '배송대기' || status === '배송 중') {
                return '<button class="btn-sm btn-pay" disabled="disabled">보관비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection" disabled="disabled">검수 결과 확인</button>';
            } else {
                return '<button class="btn-sm btn-pay" disabled="disabled">보관비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection">검수 결과 확인</button>';
            }
        }

        //스토렌 탭 버튼 이벤트 바인딩 함수
        function bindStorenButtonEvents() {
            $('#storen-content .btn-inspection, #storen-content .btn-shipping, #storen-content .btn-pay').on('click', function(e) {
                e.preventDefault();
                e.stopPropagation();

                var id = $(this).closest("tr").find("input[name='id']").val();

                if($(this).hasClass('btn-inspection')) {
                    window.location.href = "mypage-inspecList.action?id=" + id;
                } else if($(this).hasClass('btn-shipping')) {
                    window.location.href = "mypage-delivery.action?id=" + id;
                } else if($(this).hasClass('btn-pay')) {
                    window.location.href = "storenregister-storage-pay.action?id=" + id;
                }
            });
        }

        //화살표 상태별 필터링 처리 함수
        //@param {jQuery} filterButton - 필터 버튼 요소
        function handleStatusFilter(filterButton) {
            var statusFilter = filterButton.data('status');

            // UI 표시 업데이트
            $('.arrow-step').removeClass('filtering');
            filterButton.addClass('filtering');

            // 스토렌 탭으로 전환
            $('.tab[data-tab="storen"]').click();

            // AJAX 요청으로 필터링된 데이터 가져오기
            $.ajax({
                url: '/api/myequipment/storen/filter',
                type: 'GET',
                data: {
                    status: statusFilter
                },
                dataType: 'json',
                beforeSend: function() {
                    showLoading();
                },
                success: function(data) {
                    handleFilteredData(data, statusFilter);
                },
                error: function(xhr, status, error) {
                    console.error("필터링 데이터 로드 실패:", error);
                    showFilterError();
                },
                complete: function() {
                    hideLoading();
                }
            });
        }

        //필터링된 데이터 처리 함수
        //@param {Array} data - 필터링된 데이터
        //@param {string} statusFilter - 적용된 필터
        function handleFilteredData(data, statusFilter) {
            var targetTable = $('#storen-content tbody');

            // 필터 알림 추가
            if ($('.filter-notice').length > 0) {
                $('.filter-notice').remove();
            }

            $('#storen-content .table-actions').after(
                '<div class="filter-notice">' +
                '<span>"' + statusFilter + '" 상태인 스토렌만 표시 중 (' + data.length + '개)</span>' +
                '<button class="btn-sm btn-clear-filter">모든 스토렌 보기</button>' +
                '</div>'
            );

            if (data.length === 0) {
                targetTable.html(
                    '<tr>' +
                    '<td colspan="5" class="text-center py-5">' +
                    '<div class="empty-state">' +
                    '<i class="fas fa-filter mb-3" style="font-size: 2rem; color: #ccc;"></i>' +
                    '<p class="mb-1">"' + statusFilter + '" 상태인 스토렌이 없습니다.</p>' +
                    '<button class="btn-sm btn-clear-filter mt-2">모든 스토렌 보기</button>' +
                    '</div>' +
                    '</td>' +
                    '</tr>'
                );
            } else {
                // 필터링된 데이터 렌더링
                renderFilteredData(data, targetTable);
            }
        }

        //필터링된 데이터 렌더링 함수
        //@param {Array} data - 필터링된 데이터
        //@param {jQuery} targetTable - 대상 테이블
        function renderFilteredData(data, targetTable) {
            var html = '';
            var formatter = new Intl.NumberFormat('ko-KR');

            data.forEach(function(item) {
                // 버튼 리스트 생성
                var buttonList = generateButtonList(item.status);

                // 장비 정보 추출
                var equipInfo = extractEquipmentInfo(item, formatter);

                // 상태 클래스 가져오기
                var statusClass = getStatusBadgeClass(item.status);

                // HTML 행 생성
                html += '<tr class="table-row matching-row rental-header" data-id="' + item.equip_code + '" data-expanded="false">' +
                    '<td class="checkbox-col">' +
                    '<input type="checkbox" class="my-form-check-input storen-checkbox">' +
                    '</td>' +
                    '<td>' +
                    '<div class="product-image">' +
                    '<img src="' + equipInfo.imgSrc + '" alt="상품 이미지">' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<div class="equipment-info-container">' +
                    '<div class="equipment-info-text">장비 코드 : ' + item.equip_code + '</div>' +
                    '<a href="#" class="equipment-name">' + equipInfo.name + '</a>' +
                    '<div class="equipment-info-text">' + equipInfo.category + '</div>' +
                    '<div class="equipment-info-text">' + equipInfo.brand + '</div>' +
                    '<div class="equipment-info-text">' + equipInfo.createdDate + '</div>' +
                    '<div class="equipment-info-text">신품가 : ' + equipInfo.price + '원</div>' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<div class="equipment-info-container">' +
                    '<input type="hidden" name="id" value="' + item.storen_id + '">' +
                    '<div class="equipment-info-text">스토렌ID : ' + item.storen_id + '</div>' +
                    '<a href="storenmatching-request.action?storen_id=' + item.storen_id + '" class="equipment-name">' + (item.storen_title || '제목 없음') + '</a>' +
                    '<div class="equipment-info-text">' + (item.store_month || '0') + '개월 보관</div>' +
                    '<div class="status-badge ' + statusClass + '">' + (item.status || '정보 없음') + '</div>' +
                    '<div class="equipment-info-text">보관시작일 : ' + (item.inspec_completed_date || '검수 중') + '</div>' +
                    '<div class="equipment-info-text">보관종료일 : ' + (item.final_return_date || '정보 없음') + '</div>' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<div class="button-group-vertical">' + buttonList + '</div>' +
                    '</td>' +
                    '</tr>';
            });

            targetTable.html(html);

            // 이벤트 핸들러 재바인딩
            bindStorenButtonEvents();
        }

        //필터 오류 표시 함수
        function showFilterError() {
            var targetTable = $('#storen-content tbody');
            targetTable.html(
                '<tr>' +
                '<td colspan="5" class="text-center py-4">' +
                '<div class="alert alert-danger" role="alert">' +
                '<i class="fas fa-exclamation-circle me-2"></i> 데이터를 불러오는 중 오류가 발생했습니다.' +
                '</div>' +
                '</td>' +
                '</tr>'
            );
        }

        //필터 초기화 함수
        function clearFilters() {
            // 필터 상태 제거
            $('.arrow-step').removeClass('filtering');
            $('.filter-notice').remove();

            // 원래 데이터 다시 로드
            loadEquipmentData('storen');
        }

        // 확장 테이블 관련 함수============================================================================================

        //확장 테이블 클릭 이벤트 핸들러 설정
        $(document).on('click', '.rental-header', function() {
            toggleExpansionRow($(this));
        });

        //테이블 행 확장/축소 토글 함수
        //@param {jQuery} row - 대상 행
        function toggleExpansionRow(row) {
            var rentalId = row.data('id');
            var isExpanded = row.attr('data-expanded') === 'true';

            // 현재 열려 있는 다른 세부 행 닫기
            $('.rental-header').not(row).removeClass('active').attr('data-expanded', 'false');
            $('.matching-details').not('[data-parent="' + rentalId + '"]').hide();

            // 현재 행 토글
            if (isExpanded) {
                row.removeClass('active').attr('data-expanded', 'false');
                $('.matching-details[data-parent="' + rentalId + '"]').hide();
            } else {
                row.addClass('active').attr('data-expanded', 'true');

                // 상세 정보가 이미 로드되어 있는지 확인
                if ($('.matching-details[data-parent="' + rentalId + '"]').length === 0) {
                    loadUserMatchingDetails(rentalId);
                } else {
                    $('.matching-details[data-parent="' + rentalId + '"]').show();
                }
            }
        }

        //스토렌 상세 정보 로드 함수
        //@param {number} equipCode - 장비 코드
        function loadUserMatchingDetails(equipCode) {
            // 로딩 표시 추가
            var loadingRow = '<tr class="matching-details" data-parent="' + equipCode + '">' +
                '<td colspan="5">' +
                '<div class="text-center py-4">' +
                '<i class="fas fa-spinner fa-spin me-2"></i> 상세 정보를 불러오는 중...' +
                '</div>' +
                '</td>' +
                '</tr>';

            // 로딩 표시를 클릭한 행 바로 아래에 추가
            $('.rental-header[data-id="' + equipCode + '"]').after(loadingRow);

            // AJAX 요청으로 상세 정보 가져오기
            $.ajax({
                url: '/api/myequipment/storen/details',
                type: 'GET',
                data: {
                    equipCode: equipCode
                },
                dataType: 'json',
                success: function(data) {
                    renderMatchingDetails(equipCode, data);
                },
                error: function(xhr, status, error) {
                    showMatchingDetailsError(equipCode, error);
                }
            });
        }

        //스토렌 상세 정보 렌더링 함수
        //@param {number} equipCode - 장비 코드
        //@param {Array} data - 상세 정보 데이터
        function renderMatchingDetails(equipCode, data) {
            // 로딩 행 제거
            $('.matching-details[data-parent="' + equipCode + '"]').remove();

            // 상세 정보 행 만들기
            var detailsHtml = '<tr class="matching-details" data-parent="' + equipCode + '" style="display: table-row;">' +
                '<td colspan="5">' +
                '<div class="content-box-sm matching-details-container">' +
                '<h6 class="content-box-title details-title">스토렌 상품글 목록</h6>' +
                '<div class="details-info">' +
                '<p>스토렌 상품글은 보관기한 내 자동으로 생성됩니다.</p>' +
                '</div>' +
                '<table class="details-table">' +
                '<thead>' +
                '<tr>' +
                '<th>스토렌ID</th>' +
                '<th>스토렌제목</th>' +
                '<th>렌탈가능일</th>' +
                '<th>일일렌탈가격</th>' +
                '<th>생성일</th>' +
                '<th>액션</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';

            // 데이터가 있는 경우에만 행 추가
            if (data && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    detailsHtml += '<tr>' +
                        '<td>' +
                        '<input type="hidden" name="id" value="' + item.storen_id + '">' +
                        '<a href="storenmatching-request.action?storen_id=' + item.storen_id + '" class="user-link">' + item.storen_id + '</a>' +
                        '</td>' +
                        '<td class="text-left"><a href="storenmatching-request.action?storen_id=' + item.storen_id + '" class="user-link">' + item.storen_title + '</a></td>' +
                        '<td>' + item.rental_start_date + ' ~ ' + item.rental_end_date + '</td>' +
                        '<td><span class="trust-score high">' + item.daily_rent_price + ' 원</span></td>' +
                        '<td>' + item.created_date + '</td>' +
                        '<td>' +
                        '<button type="button" class="btn-sm btn-approve" data-rental="' + item.storen_id + '">매칭신청확인</button>' +
                        '</td>' +
                        '</tr>';
                }
            } else {
                // 데이터가 없는 경우 메시지 표시
                detailsHtml += '<tr><td colspan="6" class="text-center py-3">등록된 스토렌 상품글이 없습니다.</td></tr>';
            }

            detailsHtml += '</tbody>' +
                '</table>' +
                '</div>' +
                '</td>' +
                '</tr>';

            // 생성한 행을 클릭한 행 바로 아래에 추가
            $('.rental-header[data-id="' + equipCode + '"]').after(detailsHtml);

            // 이벤트 바인딩
            $('.btn-approve').on('click', function(e) {
                e.preventDefault();
                var id = $(this).closest("tr").find("input[name='id']").val();
                window.location.href = "mypage-matchinglist.action?id=" + id;
            });
        }

        //매칭 상세 정보 오류 표시 함수
        //@param {number} equipCode - 장비 코드
        //@param {string} error - 오류 메시지
        function showMatchingDetailsError(equipCode, error) {
            $('.matching-details[data-parent="' + equipCode + '"]').html(
                '<td colspan="5">' +
                '<div class="alert alert-danger m-3" role="alert">' +
                '<i class="fas fa-exclamation-circle me-2"></i> 데이터를 불러오는 중 오류가 발생했습니다.' +
                '</div>' +
                '</td>'
            );
            console.error("상세 정보 로드 실패:", error);
        }

        // 유틸리티 함수===================================================================================================
        //장비 상태에 따른 CSS 클래스 반환 함수
        //@param {string} status - 장비 상태
        //@returns {string} CSS 클래스
        function getStatusBadgeClass(status) {
            console.log("현재 상태:", status);
            switch(status) {
                case '보관비 결제 대기':
                    return 'status-payment-waiting';
                case '배송 대기':
                    return 'status-shipping-waiting';
                case '배송 중':
                    return 'status-shipping';
                case '검수 중':
                    return 'status-inspection';
                case '보관 중':
                    return 'status-storage';
                case '강제 반환':
                    return 'status-forced-return';
                case '승인 대기':
                    return 'status-approval-waiting';
                case '결제 대기':
                    return 'status-waiting-payment';
                case '렌탈 중':
                    return 'status-rental';
                case '반납 중':
                    return 'status-returning';
                case '거래 완료':
                    return 'status-completed';
                case '최종 반환':
                    return 'status-final-return';
                case '상태 불명':
                default:
                    console.log("매칭되는 상태 클래스 없음:", status);
                    return 'status-unknown';
            }
        }

        //전체 선택 체크박스 상태 업데이트 함수
        //@param {string} tabId - 탭 ID
        function updateSelectAllCheckbox(tabId) {
            var allChecked = $('#' + tabId + '-content .' + tabId + '-checkbox:checked').length ===
                $('#' + tabId + '-content .' + tabId + '-checkbox').length;
            $('#select-all-' + tabId).prop('checked', allChecked);
        }

        //검색 실행 함수
        function performSearch() {
            var searchValue = $('#search-equip').val().trim().toLowerCase();

            if(searchValue === '') {
                // 검색어가 없으면 모든 행 표시
                $('.table-row').show();
                return;
            }

            // 현재 활성화된 탭의 행만 검색
            var activeTab = $('.tab.active').data('tab');
            var rows = $('#' + activeTab + '-content .table-row');

            rows.each(function() {
                var rowData = $(this).text().toLowerCase();

                // 텍스트에 검색어가 포함된 행만 표시
                if(rowData.includes(searchValue)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });

            // 검색 결과가 없는 경우 처리
            handleEmptySearchResult(activeTab);
        }

        //빈 검색 결과 처리 함수
        //@param {string} activeTab - 활성 탭 ID
        function handleEmptySearchResult(activeTab) {
            var visibleRows = $('#' + activeTab + '-content .table-row:visible');
            if(visibleRows.length === 0) {
                // 이미 empty-state가 있는지 확인
                if($('#' + activeTab + '-content .empty-state').length === 0) {
                    $('#' + activeTab + '-content .custom-table').after(
                        '<div class="empty-state">' +
                        '<i class="fas fa-search"></i>' +
                        '<p>검색 결과가 없습니다</p>' +
                        '<div class="hint">다른 검색어로 다시 시도해보세요.</div>' +
                        '</div>'
                    );
                }
            } else {
                // 검색 결과가 있으면 empty-state 제거
                $('#' + activeTab + '-content .empty-state').remove();
            }
        }

        //로딩 표시 함수
        function showLoading() {
            $('.loading-overlay').show();
        }

        //로딩 숨김 함수
        function hideLoading() {
            $('.loading-overlay').hide();
        }

        // 즉시 확인 필요(Urgent) 기능=====================================================================================
        //즉시 확인 필요 버튼 클릭 이벤트 핸들러
        $(document).on('click', '.urgent-item', function(e) {
            e.preventDefault();
            handleUrgentFilter($(this));
        });

        //즉시 확인 필요 필터 처리 함수
        //@param {jQuery} button - 클릭된 버튼
        function handleUrgentFilter(button) {
            var itemLabel = button.find('.item-label').text().trim();
            var statusFilters = [];

            // 각 버튼별 상태 매핑
            switch (true) {
                case itemLabel.includes('보관비 결제 대기'):
                    statusFilters.push('보관비 결제 대기');
                    break;
                case itemLabel.includes('검수 결과 확인'):
                    statusFilters.push('보관 중');
                    statusFilters.push('강제 반환');
                    break;
                case itemLabel.includes('매칭 승인 대기'):
                    statusFilters.push('승인 대기');
                    break;
                case itemLabel.includes('문제 상황 발생'):
                    statusFilters.push('상태 불명');
                    break;
                default:
                    console.log('알 수 없는 버튼:', itemLabel);
                    return;
            }

            // UI 표시 업데이트
            $('.arrow-step, .urgent-item').removeClass('filtering');
            button.addClass('filtering');

            // 스토렌 탭으로 전환
            $('.tab[data-tab="storen"]').click();

            // AJAX 요청으로 필터링된 데이터 가져오기
            $.ajax({
                url: '/api/myequipment/emergency-filter',
                type: 'GET',
                data: {
                    keyword: statusFilters,
                    statuses: statusFilters.join(',') // 쉼표로 구분된 상태 목록
                },
                dataType: 'json',
                beforeSend: function() {
                    showLoading();
                },
                success: function(data) {
                    // 필터링된 데이터 렌더링
                    handleFilteredData(data, itemLabel);
                },
                error: function(xhr, status, error) {
                    console.error("필터링 데이터 로드 실패:", error);
                    showFilterError();
                },
                complete: function() {
                    hideLoading();
                }
            });
        }
    });
</script>
</body>
</html>