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
                        <div class="item-label">검수 결과 확인</div>
                        <div class="item-count">3</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">매칭 승인 대기</div>
                        <div class="item-count">5</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">주가 비용 결제 대기</div>
                        <div class="item-count">2</div>
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
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 렌탈 -->
                    <div class="status-row">
                        <div class="status-type">렌탈</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
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
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
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
                <div class="tab active" data-tab="general" id="general-tab">일반 장비 <span class="badge-count">5</span></div>
                <div class="tab" data-tab="storen" id="storen-tab">스토렌 <span class="badge-count">3</span></div>
                <div class="tab" data-tab="rental" id="rental-tab">렌탈 <span class="badge-count">2</span></div>
                <div class="tab" data-tab="storage" id="storage-tab">보관 <span class="badge-count">1</span></div>
            </div>

            <!-- 일반 장비 탭 콘텐츠 -->
            <div class="tab-content active" id="general-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-general" class="form-check-input">
                        <label for="select-all-general">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-general">
                            <i class="fas fa-trash-alt me-1"></i> 선택 삭제
                        </button>
                    </div>
                </div>

                <div class="custom-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="checkbox-col">
                            </th>
                            <th>장비 이미지</th>
                            <th>일반 장비 정보</th>
                            <th>신청</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 일반 장비 탭의 테이블 행 샘플 -->
                        <c:forEach var="equip" items="${equipList}">
                                <tr class="table-row">
                                    <td class="checkbox-col">
                                        <input type="checkbox" class="form-check-input equip-checkbox">
                                    </td>
                                    <td>
                                        <div class="product-image">
                                            <img src="images/product-placeholder.jpg" alt="상품 이미지">
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
                                            <button class="btn-sm btn-storen">스토렌 신청</button>
                                            <button class="btn-sm btn-rental">렌탈 신청</button>
                                            <button class="btn-sm btn-storage">보관 신청</button>
                                        </div>
                                    </td>
                                </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 스토렌 탭 콘텐츠 -->
            <div class="tab-content" id="storen-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-storen" class="form-check-input">
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
                            <th class="checkbox-col">
                                <span>선택</span>
                            </th>
                            <th>장비 이미지</th>
                            <th>일반 장비 정보</th>
                            <th>스토렌 정보</th>
                            <th>처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="storen" items="${firstStorenList}">
                            <tr class="table-row matching-row rental-header" data-id="${storen.equip_code}" data-expanded="false">
                                <td class="checkbox-col">
                                    <input type="checkbox" class="form-check-input storen-checkbox">
                                </td>
                                <td>
                                    <div class="product-image">
                                        <img src="images/product-placeholder.jpg" alt="상품 이미지">
                                    </div>
                                </td>
                                <td>
                                    <div class="equipment-info-container">
                                        <div class="equipment-code">장비 코드 : ${storen.equip_code}</div>
                                        <a href="#" class="equipment-name">${storen.equipmentDTO.equip_name}</a>
                                        <div class="equipment-category">${storen.equipmentDTO.majorCategory} > ${storen.equipmentDTO.middleCategory}</div>
                                        <div class="equipment-brand">${storen.equipmentDTO.brand}</div>
                                        <div class="equipment-date">${storen.equipmentDTO.created_date}</div>
                                    </div>
                                </td>
                                <td>
                                    <div class="equipment-info-container">
                                        <input type="hidden" name="id" value="${storen.storen_id}">
                                        <div class="equipment-code">스토렌ID : ${storen.storen_id}</div>
                                        <a href="storenmatching-request.action?storen_id=${storen.storen_id}" class="equipment-name">${storen.storen_title}</a>
                                        <div class="equipment-category">${storen.store_month} 개월 보관</div>
                                        <div class="equipment-date">스토렌등록 : ${storen.created_date}</div>
                                        <div class="equipment-date">보관시작일 : 2023-04-15 (수정필요)</div>
                                        <div class="equipment-date">보관종료일 : 2023-07-15 (수정필요)</div>
                                    </div>
                                </td>
                                <td>
                                    <div class="button-group-vertical">
                                        <button class="btn-sm btn-inspection">검수 결과 확인</button>
                                        <button class="btn-sm btn-shipping">배송 내역 조회</button>
                                        <button class="btn-sm btn-pay">보관비   결제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr class="matching-details" data-parent="${storen.equip_code}" style="display: none;">
                                <td colspan="5">
                                    <div class="content-box-sm matching-details-container">
                                        <h6 class="content-box-title details-title">스토렌 상품글 목록</h6>
                                        <div class="details-info">
                                            <p>스토렌 상품글은 보관기한 내 자동으로 생성됩니다.</p>
                                        </div>
                                        <table class="details-table">
                                            <thead>
                                            <tr>
                                                <th>스토렌ID</th>
                                                <th>스토렌제목</th>
                                                <th>렌탈가능일</th>
                                                <th>일일렌탈가격</th>
                                                <th>생성일</th>
                                                <th>액션</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="sub" items="${storenMap[storen.equip_code]}">
                                            <tr>
                                                <td>
                                                    <input type="hidden" name="id" value="${storen.storen_id}">
                                                    <a href="storenmatching-request.action?storen_id=${sub.storen_id}" class="user-link">${sub.storen_id}</a>
                                                </td>
                                                <td class="text-left"><a href="storenmatching-request.action?storen_id=${sub.storen_id}" class="user-link">${sub.storen_title}</a></td>
                                                <td>2023-04-20 ~ 2023-05-20</td>
                                                <td><span class="trust-score high">${sub.daily_rent_price} 원</span></td>
                                                <td>${sub.created_date}</td>
                                                <td>
                                                    <button type="button" class="btn-sm btn-approve" data-rental="${storen.storen_id}">매칭신청확인</button>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 렌탈 탭 콘텐츠 -->
            <div class="tab-content" id="rental-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-rental" class="form-check-input">
                        <label for="select-all-rental">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-rental">
                            <i class="fas fa-trash-alt me-1"></i> 선택 삭제
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
                        <tr class="table-row">
                            <td class="checkbox-col">
                                <input type="checkbox" class="form-check-input rental-checkbox">
                            </td>
                            <td>
                                <div class="product-image">
                                    <img src="images/product-placeholder.jpg" alt="상품 이미지">
                                </div>
                            </td>
                            <td>
                                <div class="equipment-info-container">
                                    <div class="equipment-code">EQ1001</div>
                                    <a href="myPage-myEquip-info.jsp?equip_code=1" class="equipment-name">진정한 캠핑고수의 텐트</a>
                                    <div class="equipment-category">텐트/쉘터 > 거실형 텐트</div>
                                    <div class="equipment-brand">코베아</div>
                                    <div class="equipment-date">2023-04-15</div>
                                </div>
                            </td>
                            <td>
                                <select class="id-select-control">
                                    <option>RENTAL01</option>
                                    <option>RENTAL01</option>
                                </select>
                            </td>
                            <td>
                                <div class="button-group-vertical">
                                    <button class="btn-sm btn-rental">매칭 신청 승인</button>
                                    <button class="btn-sm btn-storage">배송 내역 조회</button>
                                </div>
                            </td>
                        </tr>

                        <tr class="table-row">
                            <td class="checkbox-col">
                                <input type="checkbox" class="form-check-input rental-checkbox">
                            </td>
                            <td>
                                <div class="product-image">
                                    <img src="images/product-placeholder.jpg" alt="상품 이미지">
                                </div>
                            </td>
                            <td>
                                <div class="equipment-info-container">
                                    <div class="equipment-code">EQ1001</div>
                                    <a href="myPage-myEquip-info.jsp?equip_code=1" class="equipment-name">진정한 캠핑고수의 텐트</a>
                                    <div class="equipment-category">텐트/쉘터 > 거실형 텐트</div>
                                    <div class="equipment-brand">코베아</div>
                                    <div class="equipment-date">2023-04-15</div>
                                </div>
                            </td>
                            <td>
                                <select class="id-select-control">
                                    <option>RENTAL01</option>
                                    <option>RENTAL01</option>
                                </select>
                            </td>
                            <td>
                                <div class="button-group-vertical">
                                    <button class="btn-sm btn-rental">매칭 신청 승인</button>
                                    <button class="btn-sm btn-storage">배송 내역 조회</button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 보관 탭 콘텐츠 -->
            <div class="tab-content" id="storage-content">
                <div class="table-actions">
                    <div class="select-all-container">
                        <input type="checkbox" id="select-all-storage" class="form-check-input">
                        <label for="select-all-storage">전체 선택</label>
                    </div>
                    <div class="bulk-actions">
                        <button class="btn btn-danger btn-sm ms-3" id="btn-delete-storage">
                            <i class="fas fa-trash-alt me-1"></i> 선택 삭제
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
                        <tr class="table-row">
                            <td class="checkbox-col">
                                <input type="checkbox" class="form-check-input storage-checkbox">
                            </td>
                            <td>
                                <div class="product-image">
                                    <img src="images/product-placeholder.jpg" alt="상품 이미지">
                                </div>
                            </td>
                            <td>
                                <div class="equipment-info-container">
                                    <div class="equipment-code">EQ1001</div>
                                    <a href="myPage-myEquip-info.jsp?equip_code=1" class="equipment-name">진정한 캠핑고수의 텐트</a>
                                    <div class="equipment-category">텐트/쉘터 > 거실형 텐트</div>
                                    <div class="equipment-brand">코베아</div>
                                    <div class="equipment-date">2023-04-15</div>
                                </div>
                            </td>
                            <td>
                                <select class="id-select-control">
                                    <option>STORAGE01</option>
                                    <option>STORAGE02</option>
                                </select>
                            </td>
                            <td>
                                <div class="button-group-vertical">
                                    <button class="btn-sm btn-inspection">검수 결과 조회</button>
                                    <button class="btn-sm btn-shipping">배송 내역 조회</button>
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
            <button class="btn-circle">
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

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // 탭 전환 이벤트 ========= ======================================================================================
        // 초기 설정 - 첫 번째 탭만 표시
        $('.tab-content').hide();
        $('#general-content').show();

        // 탭 전환 기능
        $('.tab').on('click', function() {
            const tabId = $(this).data('tab');

            // 탭 활성화
            $('.tab').removeClass('active');
            $(this).addClass('active');

            // 콘텐츠 활성화 - 모든 콘텐츠 숨기고 선택된 것만 표시
            $('.tab-content').hide();
            $('#' + tabId + '-content').show();

            // 열려있는 모든 세부 행 닫기
            $('.matching-details').hide();
            $('.rental-header').removeClass('active').attr('data-expanded', 'false');
        });

        // ================================================================================================ 탭 전환 이벤트

        // 확장 테이블 보이고 닫기==========================================================================================
        // 스토렌 행 클릭 이벤트 (세부 정보 토글)
        $(document).on('click', '.rental-header', function() {
            const rentalId = $(this).data('id');
            const isExpanded = $(this).attr('data-expanded') === 'true';

            // 현재 열려 있는 다른 세부 행 닫기
            $('.rental-header').not(this).removeClass('active').attr('data-expanded', 'false');
            $('.matching-details').not(`[data-parent="` + rentalId + `"]`).hide();

            // 현재 행 토글
            if (isExpanded) {
                $(this).removeClass('active').attr('data-expanded', 'false');
                $(`.matching-details[data-parent="` + rentalId + `"]`).hide();
            } else {
                $(this).addClass('active').attr('data-expanded', 'true');
                $(`.matching-details[data-parent="` + rentalId + `"]`).show();
            }
        });

        // ==========================================================================================확장 테이블 보이고 닫기

        // 전체 선택 체크박스 기능
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
            const allChecked = $('#general-content .equip-checkbox:checked').length === $('#general-content .equip-checkbox').length;
            $('#select-all-general').prop('checked', allChecked);
        });

        $('#storen-content').on('change', '.storen-checkbox', function() {
            const allChecked = $('#storen-content .storen-checkbox:checked').length === $('#storen-content .storen-checkbox').length;
            $('#select-all-storen').prop('checked', allChecked);
        });

        $('#rental-content').on('change', '.rental-checkbox', function() {
            const allChecked = $('#rental-content .rental-checkbox:checked').length === $('#rental-content .rental-checkbox').length;
            $('#select-all-rental').prop('checked', allChecked);
        });

        $('#storage-content').on('change', '.storage-checkbox', function() {
            const allChecked = $('#storage-content .storage-checkbox:checked').length === $('#storage-content .storage-checkbox').length;
            $('#select-all-storage').prop('checked', allChecked);
        });

        // 삭제 버튼 클릭 시 모달 표시
        $('.btn-delete').on('click', function() {
            const tabId = $(this).attr('id').split('-').pop();
            const selectedCount = $(`.${tabId}-checkbox:checked`).length;

            if (selectedCount === 0) {
                alert('삭제할 장비를 선택해주세요.');
                return;
            }

            // 선택된 항목이 있을 경우 모달 표시
            $('#deleteConfirmModal').modal('show');

            // 현재 탭 ID를 모달에 저장
            $('#deleteConfirmModal').data('tab-id', tabId);
        });

        // 삭제 확인 버튼 클릭 시
        $('#confirmDelete').on('click', function() {
            const tabId = $('#deleteConfirmModal').data('tab-id');

            // 여기서 실제 삭제 로직 구현 (AJAX 호출 등)
            console.log(`${tabId} 탭에서 선택된 항목 삭제`);

            // 예시: 체크된 행 삭제 (실제로는 서버 요청 후 성공 시 수행해야 함)
            $(`.${tabId}-checkbox:checked`).closest('tr').remove();

            // 전체 선택 체크박스 해제
            $(`#select-all-${tabId}`).prop('checked', false);

            // 모달 닫기
            $('#deleteConfirmModal').modal('hide');
        });


        // 각 탭에서 버튼 클릭 이벤트 ======================================================================================
        // 일반 장비 탭---------------------------------------------------------------------------------------------------
        // 스토렌 신청 버튼 클릭 이벤트
        $(".btn-storen").click(function(e) {
            e.preventDefault(); // 기본 동작 방지
            var equip_code = $(this).closest("tr").find("input[name='equip_code']").val();
            // 스토렌 신청 페이지로 이동
            window.location.href = "storenregister-storage-info.action?equip_code=" + equip_code;
        });

        // 렌탈 신청 버튼 클릭 이벤트
        $(".btn-rental").click(function(e) {
            e.preventDefault(); // 기본 동작 방지
            var equip_code = $(this).closest("tr").find("input[name='equip_code']").val();
            // 렌탈 신청 페이지로 이동
            window.location.href = "rentalRegister-info.jsp?equip_code=" + equip_code;
        });

        // 보관 신청 버튼 클릭 이벤트
        $(".btn-storage").click(function(e) {
            e.preventDefault(); // 기본 동작 방지
            var equip_code = $(this).closest("tr").find("input[name='equip_code']").val();
            // 보관 신청 페이지로 이동
            window.location.href = "storageRegister-storage-info.jsp?equip_code=" + equip_code;
        });

        // 스토렌 & 렌탈 & 보관--------------------------------------------------------------------------------------------
        // 검수 결과 확인 버튼 클릭 이벤트
        $('.btn-inspection').on('click', function(e) {
            e.preventDefault(); // 기본 동작 방지
            var id = $(this).closest("tr").find("input[name='id']").val();
            // 검수 조회/내역 페이지로 이동
            window.location.href = "mypage-inspecList.action?id=" + id;
        });

        // 배송 확인 버튼 클릭 이벤트
        $('.btn-shipping').on('click', function(e) {
            e.preventDefault(); // 기본 동작 방지
            var id = $(this).closest("tr").find("input[name='id']").val();
            // 배송 조회/내역 페이지로 이동
            window.location.href = "mypage-delivery.action?id=" + id;
        });
        
        // 결제 버튼 클릭 이벤트
        $('.btn-pay').on('click', function (e) {
            e.preventDefault(); // 기본 동작 방지
            var id = $(this).closest("tr").find("input[name='id']").val();
            // 결제 페이지로 이동
            window.location.href = "storenregister-storage-pay.action?id=" + id;
        });

        // 스토렌 확장 테이블----------------------------------------------------------------------------------------------
        $('.btn-approve').on('click', function(e) {
            e.preventDefault(); // 기본 동작 방지
            var id = $(this).closest("tr").find("input[name='id']").val();
            // 매칭 조회/내역 페이지로 이동
            window.location.href = "mypage-matchinglist.action?id=" + id;
        });

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

        // 장비명 클릭 이벤트
        $('.equipment-name').click(function(e) {
            // 여기에 페이지 이동 로직 추가 (기본 동작은 유지)
            console.log('장비 상세 페이지로 이동: ' + $(this).text());
        });
    });
</script>
</body>
</html>