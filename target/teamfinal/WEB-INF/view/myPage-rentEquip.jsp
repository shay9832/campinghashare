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
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link active">내가 대여한 장비</a></li>
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
            <h2 class="page-title">내가 대여한 장비</h2>
            <p class="page-description">매칭 승인된 캠핑 장비의 대여 현황을 확인하고 반납 및 분실 신고를 할 수 있습니다.</p>
        </div>

        <!-- 이용 내역 섹션 -->
        <div class="section-header">이용 내역</div>
        <div class="two-column-layout">
            <!-- 즉시 확인 필요 박스 (왼쪽) -->
            <div class="urgent-box">
                <div class="urgent-header">즉시 확인 필요</div>
                <div class="urgent-content">
                    <a href="#" class="urgent-item">
                        <div class="item-label">렌탈비 결제 필요</div>
                        <div class="item-count">${emergencyMap["렌탈비 결제 필요"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">추가 비용 결제 필요</div>
                        <div class="item-count">${emergencyMap["추가 비용 결제 필요"]}</div>
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
                                        <c:when test="${status.key eq '매칭중' || status.key eq '매칭승인대기'
                                        || status.key eq '추가비용결제필요' || status.key eq '상태불명'}">
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
                                <span class="arrow-label">렌탈비 결제 전</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">렌탈비 결제완료</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">대여 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반납일 임박</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반납 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">거래 완료</span>
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
                <div class="tab" data-tab="storen" id="storen-tab">스토렌
                    <span class="badge-count">
                    <c:choose>
                        <c:when test="${not empty rentEquipInfo.rentalItems}">
                            ${rentEquipInfo.rentalItems.size()}
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose></span></div>
                <div class="tab" data-tab="rental" id="rental-tab">렌탈 <span class="badge-count">0</span></div>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content active" id="storen-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-storen" class="my-form-check-input">
                        <label for="select-all-storen">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-storen">
                            <i class="fas fa-trash-alt me-1"></i> 선택 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col" style="width:1%; !important"></th>
                            <th style="width:20%; !important">장비 이미지</th>
                            <th style="width:35%; !important">일반 장비 정보</th>
                            <th style="width:35%; !important">스토렌 정보</th>
                            <th style="width:35%; !important">처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <%-- 소유한 스토렌이 하나도 없다면 --%>
                            <c:when test="${empty rentEquipInfo.rentalItems}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-store-alt mb-3" style="font-size: 2rem; color: #ccc;"></i>
                                            <p class="mb-1">대여한 스토렌 장비가 없습니다.</p>
                                            <p class="small text-muted">스토렌 장비는 캠핑하쉐어가 검수 및 배송을 책임지므로 믿고 대여할 수 있습니다.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${rentEquipInfo.rentalItems}">
                                    <tr class="table-row matching-row rental-header" data-id="${item.storen.equipmentDTO.equip_code}" data-expanded="false">
                                        <td class="checkbox-col">
                                            <input type="checkbox" class="my-form-check-input storen-checkbox">
                                        </td>
                                        <td>
                                            <div class="product-image">
                                                <c:choose>
                                                    <c:when test="${!empty item.storen.equipmentDTO.attachments && item.storen.equipmentDTO.attachments.size() > 0}">
                                                        <img src="${item.storen.equipmentDTO.attachments.get(0).attachmentPath}" alt="상품 이미지">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-placeholder"></div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="equipment-info-container">
                                                <div class="equipment-info-text">스토렌ID : ${item.storen.storen_id}</div>
                                                <a href="storenmatching-request.action?storenId=${item.storen.storen_id}" class="equipment-name">${item.storen.storen_title}</a>
                                                <div class="equipment-info-text">${item.storen.equipmentDTO.majorCategory} > ${item.storen.equipmentDTO.middleCategory}</div>
                                                <div class="equipment-info-text">${item.storen.equipmentDTO.brand}</div>
                                                <div class="equipment-info-text">${item.storen.created_date}</div>
                                                <div class="equipment-info-text">원가 : ${item.storen.equipmentDTO.original_price}원</div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="equipment-info-container">
                                                <input type="hidden" name="id" value="${item.storen.storen_id}">
                                                <div class="equipment-info-text">매칭완료ID : ${item.matching.matching_done_id}</div>
                                                <div class="equipment-info-text">렌탈시작일 : ${item.matching.rental_start_date}</div>
                                                <div class="equipment-info-text">렌탈종료일 : ${item.matching.rental_end_date}</div>
                                                <div class="equipment-info-text">결제금액 : ${item.payment.payAmount}</div>
                                                <div class="status-badge">${item.storen.matching_status_detail}</div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="button-group-vertical">
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

            <!-- 렌탈 탭 콘텐츠 -->
            <div class="tab-content" id="rental-content">
                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col"></th>
                            <th>장비 이미지</th>
                            <th>렌탈 정보</th>
                            <th>매칭 정보</th>
                            <th>처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="5" class="text-center py-5">
                                <div class="empty-state">
                                    <i class="fas fa-exchange-alt mb-3" style="font-size: 2rem; color: #ccc;"></i>
                                    <p class="mb-1">대여한 렌탈 장비가 없습니다.</p>
                                    <p class="small text-muted">렌탈 장비를 대여하면 소유자에게서 직접 대여할 수 있습니다.</p>
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
            <button class="btn-circle" onclick="window.location.href='rentalsearch-main.action'">
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

<script>
    $(document).ready(function() {
        // 탭 전환 이벤트 ========= ======================================================================================
        // 초기 설정 - 첫 번째 탭만 표시
        $('.tab').removeClass('active');
        $('#storen-tab').addClass('active');
        $('.tab-content').hide();
        $('#storen-content').show();

        const userCode = ${userCode};

        // 탭 전환 기능
        $('.tab').on('click', function() {
            const tabId = $(this).data('tab');

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 콘텐츠 활성화 - 모든 콘텐츠 숨기고 선택된 것만 표시
            $('.tab-content').hide();
            $('#' + tabId + '-content').show();
        });

        // 상품 상태에 따라 상태 클래스와 버튼 활성화 다르게 동적 생성 ==========================================================
        // 모든 상태 배지를 순회하며 클래스 적용
        $('.status-badge').each(function() {
            const status = $(this).text().trim();
            const statusClass = getStatusBadgeClass(status);
            $(this).addClass(statusClass);
        });

        // 모든 버튼 그룹을 순회하며 상태에 따라 다른 버튼 세트 적용
        $('.matching-row').each(function() {
            const status = $(this).find('.status-badge').text().trim();
            const buttonContainer = $(this).find('.button-group-vertical');
            const buttonList = generateButtonList(status);
            buttonContainer.html(buttonList);
        });

        // 버튼 이벤트 다시 바인딩
        bindStorenButtonEvents();

        // 상태에 따른 CSS 클래스 반환 함수
        function getStatusBadgeClass(status) {
            switch(status) {
                case '렌탈비결제전':
                    return 'status-rental-payment-waiting';
                case '렌탈비결제완료':
                    return 'status-rental-payment-completed';
                case '배송중':
                    return 'status-shipping-in-progress';
                case '대여중':
                    return 'status-renting';
                case '반납일임박':
                    return 'status-return-approaching';
                case '반납중':
                    return 'status-returning-in-progress';
                case '검수중':
                    return 'status-inspecting';
                case '거래완료':
                    return 'status-transaction-completed';
                case '추가비용결제필요':
                    return 'status-additional-payment-required';
                default:
                    return 'status-unknown';
            }
        }

        // 상태에 따른 버튼 리스트 생성 함수
        function generateButtonList(status) {
            if (status === '렌탈비결제전') {
                return '<button class="btn-sm btn-pay">렌탈비 결제하기</button>' +
                    '<button class="btn-sm btn-shipping" disabled="disabled">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection" disabled="disabled">검수 결과 확인</button>';
            } else if (status === '렌탈비결제완료' || status === '배송중') {
                return '<button class="btn-sm btn-pay" disabled="disabled">렌탈비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection" disabled="disabled">검수 결과 확인</button>';
            } else if (status === '대여중' || status === '반납일임박') {
                return '<button class="btn-sm btn-pay" disabled="disabled">렌탈비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-danger">분실 신고</button>';
            } else if (status === '반납중' || status === '검수중') {
                return '<button class="btn-sm btn-pay" disabled="disabled">렌탈비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection">검수 결과 확인</button>';
            } else if (status === '추가비용결제필요') {
                return '<button class="btn-sm btn-repay">추가 비용 결제</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection">검수 결과 확인</button>';
            } else {
                return '<button class="btn-sm btn-pay" disabled="disabled">렌탈비 결제완료</button>' +
                    '<button class="btn-sm btn-shipping">배송 내역 조회</button>' +
                    '<button class="btn-sm btn-inspection">검수 결과 확인</button>';
            }
        }

        function bindStorenButtonEvents() {
            // 검수 결과 확인 버튼 클릭 이벤트
            $('.btn-inspection').off('click').on('click', function(e) {
                e.preventDefault(); // 기본 동작 방지
                var id = $(this).closest("tr").find("input[name='id']").val();
                // 검수 조회/내역 페이지로 이동
                window.location.href = "mypage-inspecList.action?id=" + id + "&activeTab=storen&storenTabType=return";
            });

            // 배송 확인 버튼 클릭 이벤트
            $('.btn-shipping').off('click').on('click', function(e) {
                e.preventDefault(); // 기본 동작 방지
                var id = $(this).closest("tr").find("input[name='id']").val();
                // 배송 조회/내역 페이지로 이동
                window.location.href = "mypage-delivery.action?id=" + id + "&activeTab=storen&storenTabType=user";
            });

            // 결제 버튼 클릭 이벤트
            $('.btn-pay').off('click').on('click', function (e) {
                e.preventDefault(); // 기본 동작 방지
                var id = $(this).closest("tr").find("input[name='id']").val()
                // 결제 페이지로 이동
                window.location.href = "storenmatching-rental-pay.action?rentalId=" + id + "&userCode=" + userCode + "&type=storen";
            });

            // 분실 신고 이벤트
            $('.btn-danger').off('click').on('click', function (e) {
                e.preventDefault(); // 기본 동작 방지
                var id = $(this).closest("tr").find("input[name='id']").val();
                // 1:1 문의 페이지로 이동
                window.location.href = "mypage-inquiry-write.action";
            });
        }

        // ================================================================================================ 탭 전환 이벤트

        // 각 탭에서 버튼 클릭 이벤트 ======================================================================================
        // 스토렌 -------------------------------------------------------------------------------------------------------
        // 검수 결과 확인 버튼 클릭 이벤트
        // $('.btn-inspection').on('click', function(e) {
        //     e.preventDefault(); // 기본 동작 방지
        //     var id = $(this).closest("tr").find("input[name='id']").val();
        //     // 검수 조회/내역 페이지로 이동
        //     window.location.href = "mypage-inspecList.action?id=" + id;
        // });
        //
        // // 배송 확인 버튼 클릭 이벤트
        // $('.btn-shipping').on('click', function(e) {
        //     e.preventDefault(); // 기본 동작 방지
        //     var id = $(this).closest("tr").find("input[name='id']").val();
        //     // 배송 조회/내역 페이지로 이동
        //     window.location.href = "mypage-delivery.action?id=" + id;
        // });
        //
        // // 결제 버튼 클릭 이벤트
        // $('.btn-pay').on('click', function (e) {
        //     e.preventDefault(); // 기본 동작 방지
        //     var id = $(this).closest("tr").find("input[name='id']").val();
        //     // 결제 페이지로 이동
        //     window.location.href = "rentalmatching-rental-pay.action?id=" + id;
        // });
        //
        // // 분실 신고 이벤트
        // $('.btn-danger').on('click', function (e) {
        //     e.preventDefault(); // 기본 동작 방지
        //     var id = $(this).closest("tr").find("input[name='id']").val();
        //     // 1:1 문의 페이지로 이동
        //     window.location.href = "mypage-inquiry-write.action";
        // });

        // 검색 기능
        $('#btn-search-equip').on('click', function() {
            performSearch();
        });

        $('#search-equip').on('keypress', function(e) {
            if(e.which === 13) {
                performSearch();
            }
        });

        //======================================================================================= 각 탭에서 버튼 클릭 이벤트

        // 검색 실행 함수
        function performSearch() {
            const searchValue = $('#search-equip').val().trim().toLowerCase();

            if(searchValue === '') {
                // 검색어가 없으면 모든 행 표시
                $('.table-row').show();
                return;
            }

            // 현재 활성화된 탭의 행만 검색
            const activeTab = $('.tab.active').data('tab');
            const rows = $(`#${activeTab}-content .table-row`);

            rows.each(function() {
                const rowData = $(this).text().toLowerCase();

                // 텍스트에 검색어가 포함된 행만 표시
                if(rowData.includes(searchValue)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });

            // 검색 결과가 없는 경우 처리
            const visibleRows = $(`#${activeTab}-content .table-row:visible`);
            if(visibleRows.length === 0) {
                // 이미 empty-state가 있는지 확인
                if($(`#${activeTab}-content .empty-state`).length === 0) {
                    $(`#${activeTab}-content .custom-table`).after(`
                        <div class="empty-state">
                            <i class="fas fa-search"></i>
                            <p>검색 결과가 없습니다</p>
                            <div class="hint">다른 검색어로 다시 시도해보세요.</div>
                        </div>
                    `);
                }
            } else {
                // 검색 결과가 있으면 empty-state 제거
                $(`#${activeTab}-content .empty-state`).remove();
            }
        }
    });

</script>
</body>
</html>