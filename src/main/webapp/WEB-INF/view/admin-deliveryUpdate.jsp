<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 배송 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-deliveryUpdate.css">
</head>

<body>
<!-- 헤더 영역 -->
<div id="header">
    <h1>관리자 시스템</h1>
</div>

<!-- 메인 컨테이너 -->
<div id="container">
    <!-- 좌측 메뉴 영역 -->
    <div id="leftMenu">
        <!-- 장비 관리 메뉴 -->
        <button class="menu-button">장비 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-equipList.action" method="get">
                <button type="submit" class="submenu-btn">장비 목록</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-equipStatistics.action" method="get">
                <button type="submit" class="submenu-btn">장비 통계</button>
            </form>
        </div>

        <!-- 검수 관리 메뉴 -->
        <button class="menu-button">검수 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-inspectList.action" method="get">
                <button type="submit" class="submenu-btn">검수 관리</button>
            </form>
        </div>

        <!-- 매칭 관리 메뉴 -->
        <button class="menu-button">매칭 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-matchingList.action" method="get">
                <button type="submit" class="submenu-btn">매칭 관리</button>
            </form>
        </div>

        <!-- 결제 관리 메뉴 -->
        <button class="menu-button">결제 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-payment.action" method="get">
                <button type="submit" class="submenu-btn">결제 관리</button>
            </form>
        </div>

        <!-- 배송 관리 메뉴 -->
        <button class="menu-button">배송 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-deliveryUpdate.action" method="get">
                <button type="submit" class="submenu-btn">배송 관리</button>
            </form>
        </div>

        <!-- 게시판 관리 메뉴 -->
        <button class="menu-button">게시판 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="get">
                <button type="submit" class="submenu-btn">게시물 관리</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-replyUpdate.action" method="get">
                <button type="submit" class="submenu-btn">댓글 관리</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="get">
                <button type="submit" class="submenu-btn">커뮤니티 통계</button>
            </form>
        </div>

        <!-- 회원 관리 메뉴 -->
        <button class="menu-button">회원 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-userList.action" method="get">
                <button type="submit" class="submenu-btn">회원 목록</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-userDrop.action" method="get">
                <button type="submit" class="submenu-btn">회원 제재 관리</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
                <button type="submit" class="submenu-btn">포인트 관리</button>
            </form>
        </div>

        <!-- 신고 관리 메뉴 -->
        <button class="menu-button">신고 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-userReport.action" method="get">
                <button type="submit" class="submenu-btn">신고 목록</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-communityStatistics.action" method="get">
                <button type="submit" class="submenu-btn">커뮤니티 통계</button>
            </form>
        </div>

        <!-- 포인트 관리 메뉴 -->
        <button class="menu-button">포인트 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
                <button type="submit" class="submenu-btn">포인트 관리</button>
            </form>
        </div>

        <!-- 쿠폰 관리 메뉴 -->
        <button class="menu-button">쿠폰 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-couponList.action" method="get">
                <button type="submit" class="submenu-btn">쿠폰 목록</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-createCoupon.action" method="get">
                <button type="submit" class="submenu-btn">쿠폰 생성</button>
            </form>
        </div>

        <!-- 이벤트 관리 메뉴 -->
        <button class="menu-button">이벤트 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-eventUpdate.action" method="get">
                <button type="submit" class="submenu-btn">이벤트 관리</button>
            </form>
        </div>
    </div>

    <!-- 콘텐츠 영역 -->
    <div id="content">
        <!-- 콘텐츠 헤더 -->
        <div class="content-header">
            <h2>배송 관리</h2>
        </div>

        <!-- 검색 영역 -->
        <div class="content-search-info">
            <span>배송유형</span>
            <select id="shipping-type-filter" name="shippingType">
                <option value="all">전체</option>
                <option value="platform">플랫폼 배송</option>
                <option value="platform-return">플랫폼 배송 반환</option>
                <option value="user">거래자 택배</option>
                <option value="user-return">거래자 택배 반환</option>
                <option value="storage-return">보관 최종 반환</option>
                <option value="storen-return">스토렌 최종 반환</option>
            </select>

            <span>배송상태</span>
            <select id="shipping-status-filter" name="shippingStatus">
                <option value="all">전체</option>
                <option value="preparing">배송 준비중</option>
                <option value="shipping">배송중</option>
                <option value="delivered">배송 완료</option>
                <option value="returning">반송중</option>
                <option value="returned">반송 완료</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date" id="start-date-filter" name="startDate">
                <span>~</span>
                <input type="date" id="end-date-filter" name="endDate">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" id="search-input" name="searchKeyword" placeholder="검색어 입력 (ID, 고객명 등)">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" id="search-btn" value="검색하기">
            </div>
        </div>

        <!-- 배송 정보 요약 -->
        <div class="shipping-count">
            <div class="shipping-total">
                <span>총 배송 건수 : <c:out value="${shippingSummary.totalCount}"/>건</span>
            </div>
            <div class="shipping-ongoing">
                <span>진행중 배송 : <c:out value="${shippingSummary.ongoingCount}"/>건</span>
            </div>
            <div class="shipping-completed">
                <span>완료된 배송 : <c:out value="${shippingSummary.completedCount}"/>건</span>
            </div>
        </div>

        <!-- 배송 흐름도 -->
        <div class="shipping-flow">
            <div class="flow-title">배송 흐름도</div>
            <div class="shipping-route">
                <span class="route-point">제품 출고</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송완료</span>
                <span class="route-arrow">→</span>
                <span class="route-point">검수완료</span>
                <span class="route-arrow">→</span>
                <span class="route-point">반환배송</span>
            </div>
        </div>

        <!-- 탭 컨테이너 -->
        <div class="tab-container">
            <div class="tab-button-group">
                <button type="button" class="tab-button active" data-tab="platform-tab">플랫폼 배송</button>
                <button type="button" class="tab-button" data-tab="platform-return-tab">플랫폼 배송 반환</button>
                <button type="button" class="tab-button" data-tab="user-tab">거래자 택배</button>
                <button type="button" class="tab-button" data-tab="user-return-tab">거래자 택배 반환</button>
                <button type="button" class="tab-button" data-tab="storage-return-tab">보관 최종 반환</button>
                <button type="button" class="tab-button" data-tab="storen-return-tab">스토렌 최종 반환</button>
            </div>

            <!-- 플랫폼 배송 탭 -->
            <div id="platform-tab" class="tab-content active">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="platform-select-all"> <label for="platform-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-storen-id">스토렌ID</th>
                            <th class="col-storage-id">보관ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${platformShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.storenId}</td>
                                <td>${shipping.storageId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.carrierName}</td>
                                <td>${shipping.waybillNumber}</td>
                                <td>${shipping.inspectionCompletedDate}</td>
                                <td>${shipping.inspectionResultType}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>

            </div>

            <!-- 플랫폼 배송 반환 탭 -->
            <div id="platform-return-tab" class="tab-content">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="platform-return-select-all"> <label for="platform-return-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox" id="platform-return-header-checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-storen-id">스토렌ID</th>
                            <th class="col-storage-id">보관ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${platformReturnShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.storenId}</td>
                                <td>${shipping.storageId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.carrierName}</td>
                                <td>${shipping.waybillNumber}</td>
                                <td>${shipping.inspectionCompletedDate}</td>
                                <td>${shipping.inspectionResultType}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>

            <!-- 거래자 택배 탭 -->
            <div id="user-tab" class="tab-content">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="user-select-all"> <label for="user-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-rental-id">렌탈ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${userShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.rentalId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.carrierName}</td>
                                <td>${shipping.waybillNumber}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>

            <!-- 거래자 택배 반환 탭 -->
            <div id="user-return-tab" class="tab-content">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="user-return-select-all"> <label for="user-return-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-rental-id">렌탈ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${userReturnShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.rentalId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.carrierName}</td>
                                <td>${shipping.waybillNumber}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>

            <!-- 보관 최종 반환 탭 -->
            <div id="storage-return-tab" class="tab-content">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="storage-return-select-all"> <label for="storage-return-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-storage-id">보관ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${storageReturnShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.storageId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.inspectionCompletedDate}</td>
                                <td>${shipping.inspectionResultType}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>

            <!-- 스토렌 최종 반환 탭 -->
            <div id="storen-return-tab" class="tab-content">
                <!-- 전체 선택 체크박스 -->
                <div class="select-all-checkbox">
                    <input type="checkbox" id="storen-return-select-all"> <label for="storen-return-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">발송인</th>
                            <th class="col-customer">수취인</th>
                            <th class="col-storen-id">스토렌ID</th>
                            <th class="col-product">장비명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>
                        <c:forEach items="${storenReturnShippingList}" var="shipping">
                            <tr>
                                <td class="col-select"><input type="checkbox" value="${shipping.deliveryId}"></td>
                                <td>${shipping.deliveryId}</td>
                                <td>${shipping.senderId}</td>
                                <td>${shipping.receiverId}</td>
                                <td>${shipping.storenId}</td>
                                <td>${shipping.equipmentName}</td>
                                <td>${shipping.deliveryStartDate}</td>
                                <td>${shipping.deliveryEndDate}</td>
                                <td>${shipping.inspectionCompletedDate}</td>
                                <td>${shipping.inspectionResultType}</td>
                                <td><button class="btn btn-primary action-btn view-shipping-btn" data-id="${shipping.deliveryId}">상세</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>
        </div>

        <!-- 배송 상세 모달 -->
        <div id="shipping-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>배송 상세 정보</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="shipping-form" method="post" action="${pageContext.request.contextPath}/admin-deliveryUpdate.action">
                        <input type="hidden" id="shipping-type-hidden" name="deliveryType">

                        <div class="form-group">
                            <label for="shipping-id">배송 ID</label>
                            <input type="text" id="shipping-id" name="deliveryId" class="form-control" readonly>
                        </div>

                        <div class="form-group">
                            <label for="shipping-type">배송 유형</label>
                            <input type="text" id="shipping-type" name="deliveryTypeDisplay" class="form-control" readonly>
                        </div>

                        <div id="id-fields" class="form-row" style="display: flex; gap: 10px;">
                            <!-- 동적으로 추가될 ID 필드들 (보관 ID, 렌탈 ID, 스토렌 ID 등) -->
                            <div class="form-group" style="flex: 1;">
                                <label for="storen-id">스토렌 ID</label>
                                <input type="text" id="storen-id" name="storenId" class="form-control" readonly>
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label for="storage-id">보관 ID</label>
                                <input type="text" id="storage-id" name="storageId" class="form-control" readonly>
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label for="rental-id">렌탈 ID</label>
                                <input type="text" id="rental-id" name="rentalId" class="form-control" readonly>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="sender-id">발송인 ID</label>
                            <input type="text" id="sender-id" name="senderId" class="form-control" readonly>
                        </div>

                        <div class="form-group">
                            <label for="receiver-id">수취인 ID</label>
                            <input type="text" id="receiver-id" name="receiverId" class="form-control" readonly>
                        </div>

                        <div class="form-group">
                            <label for="product-name">장비명</label>
                            <input type="text" id="product-name" name="equipmentName" class="form-control" readonly>
                        </div>

                        <div class="form-group">
                            <label for="start-date">배송 시작일</label>
                            <input type="text" id="start-date" name="deliveryStartDate" class="form-control" readonly>
                        </div>

                        <!-- 새 배송 시작일 필드 추가 -->
                        <div class="form-group">
                            <label for="new-start-date">새 배송 시작일</label>
                            <input type="date" id="new-start-date" name="newDeliveryStartDate" class="form-control">
                        </div>

                        <div class="form-group">
                            <label for="end-date">배송 종료일</label>
                            <input type="text" id="end-date" name="deliveryEndDate" class="form-control" readonly>
                        </div>

                        <div class="form-group">
                            <label for="shipping-status">배송 상태</label>
                            <select id="shipping-status" name="status" class="form-control">
                                <option value="preparing">배송 준비중</option>
                                <option value="shipping">배송중</option>
                                <option value="delivered">배송 완료</option>
                                <option value="returning">반송중</option>
                                <option value="returned">반송 완료</option>
                                <option value="cancelled">취소됨</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="courier">택배사</label>
                            <select id="courier" name="carrierName" class="form-control">
                                <option value="대한통운">CJ대한통운</option>
                                <option value="한진택배">한진택배</option>
                                <option value="우체국택배">우체국택배</option>
                                <option value="로젠택배">로젠택배</option>
                                <option value="롯데택배">롯데택배</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="tracking">운송장번호</label>
                            <input type="text" id="tracking" name="waybillNumber" class="form-control">
                        </div>

                        <div id="inspection-fields">
                            <!-- 검수 관련 필드들 -->
                            <div class="form-group">
                                <label for="inspection-date">검수 처리일</label>
                                <input type="text" id="inspection-date" name="inspectionCompletedDate" class="form-control" readonly>
                            </div>
                            <div class="form-group">
                                <label for="inspection-type">검수 결과</label>
                                <input type="text" id="inspection-type" name="inspectionResultType" class="form-control" readonly>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="shipping-memo">메모</label>
                            <textarea id="shipping-memo" name="memo" class="form-control" rows="3"></textarea>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-info" id="track-btn">배송조회</button>
                            <button type="submit" class="btn btn-primary" id="update-btn">정보 업데이트</button>
                            <button type="button" class="btn btn-danger" id="cancel-btn">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 드롭다운 메뉴 기능 구현
    const menuButtons = document.querySelectorAll('.menu-button');

    menuButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('active');
            const submenu = this.nextElementSibling;

            if (submenu.style.maxHeight) {
                submenu.style.maxHeight = null;
            } else {
                submenu.style.maxHeight = submenu.scrollHeight + 'px';
            }
        });
    });

    // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
    document.querySelectorAll('.menu-button.active').forEach(button => {
        const submenu = button.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
    });

    // 탭 전환 기능
    const tabButtons = document.querySelectorAll('.tab-button');
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 모든 탭 버튼 비활성화
            tabButtons.forEach(btn => btn.classList.remove('active'));

            // 현재 버튼 활성화
            this.classList.add('active');

            // 모든 탭 콘텐츠 숨기기
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(content => content.classList.remove('active'));

            // 선택한 탭 콘텐츠 표시
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');

            // 배송 흐름도 업데이트
            updateShippingFlow(tabId);
        });
    });

    // 배송 흐름도 업데이트 함수
    function updateShippingFlow(tabId) {
        const flowTitle = document.querySelector('.flow-title');
        const shippingRoute = document.querySelector('.shipping-route');

        switch(tabId) {
            case 'platform-tab':
                flowTitle.textContent = '플랫폼 배송 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">회사 출고</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">고객 수령</span>
            `;
                break;
            case 'platform-return-tab':
                flowTitle.textContent = '플랫폼 배송 반환 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">고객 반환</span>
                <span class="route-arrow">→</span>
                <span class="route-point">반환중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">회사 수령</span>
                <span class="route-arrow">→</span>
                <span class="route-point">검수완료</span>
            `;
                break;
            case 'user-tab':
                flowTitle.textContent = '거래자 택배 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">발신자 발송</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">수신자 수령</span>
            `;
                break;
            case 'user-return-tab':
                flowTitle.textContent = '거래자 택배 반환 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">발신자 반환</span>
                <span class="route-arrow">→</span>
                <span class="route-point">반환중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">수신자 수령</span>
            `;
                break;
            case 'storage-return-tab':
                flowTitle.textContent = '보관 최종 반환 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">보관 종료</span>
                <span class="route-arrow">→</span>
                <span class="route-point">회사 출고</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">고객 수령</span>
            `;
                break;
            case 'storen-return-tab':
                flowTitle.textContent = '스토렌 최종 반환 흐름도';
                shippingRoute.innerHTML = `
                <span class="route-point">렌탈 종료</span>
                <span class="route-arrow">→</span>
                <span class="route-point">회사 출고</span>
                <span class="route-arrow">→</span>
                <span class="route-point">배송중</span>
                <span class="route-arrow">→</span>
                <span class="route-point">고객 수령</span>
            `;
                break;
        }
    }

    // 모달 관련 기능
    const shippingModal = document.getElementById('shipping-modal');
    const closeModalButtons = document.querySelectorAll('.close-modal');

    // 모달 닫기 버튼
    closeModalButtons.forEach(button => {
        button.addEventListener('click', function() {
            shippingModal.style.display = 'none';
        });
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        if (event.target === shippingModal) {
            shippingModal.style.display = 'none';
        }
    });

    // 취소 버튼 클릭 시 모달 닫기
    document.getElementById('cancel-btn').addEventListener('click', function() {
        shippingModal.style.display = 'none';
    });

    // 배송 상세 버튼 클릭 이벤트
    const viewShippingButtons = document.querySelectorAll('.view-shipping-btn');
    viewShippingButtons.forEach(button => {
        button.addEventListener('click', function() {
            const shippingId = this.getAttribute('data-id');

            // 폼을 통해 서버에 요청 보내기
            // 대신 여기서는 간단히 데이터 속성을 가져와서 모달에 표시
            const row = this.closest('tr');

            // 배송 ID
            document.getElementById('shipping-id').value = shippingId;

            // 현재 탭에 따라 배송 유형 결정
            const activeTab = document.querySelector('.tab-button.active').getAttribute('data-tab');
            let shippingType = '';
            switch(activeTab) {
                case 'platform-tab':
                    shippingType = 'platform';
                    document.getElementById('shipping-type').value = '플랫폼 배송';
                    break;
                case 'platform-return-tab':
                    shippingType = 'platform-return';
                    document.getElementById('shipping-type').value = '플랫폼 배송 반환';
                    break;
                case 'user-tab':
                    shippingType = 'user';
                    document.getElementById('shipping-type').value = '거래자 택배';
                    break;
                case 'user-return-tab':
                    shippingType = 'user-return';
                    document.getElementById('shipping-type').value = '거래자 택배 반환';
                    break;
                case 'storage-return-tab':
                    shippingType = 'storage-return';
                    document.getElementById('shipping-type').value = '보관 최종 반환';
                    break;
                case 'storen-return-tab':
                    shippingType = 'storen-return';
                    document.getElementById('shipping-type').value = '스토렌 최종 반환';
                    break;
            }
            document.getElementById('shipping-type-hidden').value = shippingType;

            // 행에서 데이터 가져오기
            const cells = row.querySelectorAll('td');

            // 각 셀의 텍스트 가져오기 (인덱스는 테이블 열 구조에 따라 조정 필요)
            const senderId = cells[2] ? cells[2].textContent : '';
            const receiverId = cells[3] ? cells[3].textContent : '';
            const storenId = cells[4] ? cells[4].textContent : '';
            const storageId = cells[5] ? cells[5].textContent : '';
            const rentalId = activeTab.includes('user') ? cells[4] ? cells[4].textContent : '' : '';
            const equipmentName = cells[6] ? cells[6].textContent : '';
            const deliveryStartDate = cells[7] ? cells[7].textContent : '';
            const deliveryEndDate = cells[8] ? cells[8].textContent : '';
            const carrierName = cells[9] ? cells[9].textContent : '대한통운';
            const waybillNumber = cells[10] ? cells[10].textContent : '';
            const inspectionDate = activeTab.includes('platform') || activeTab.includes('storage') || activeTab.includes('storen') ?
                cells[11] ? cells[11].textContent : '' : '';
            const inspectionResult = activeTab.includes('platform') || activeTab.includes('storage') || activeTab.includes('storen') ?
                cells[12] ? cells[12].textContent : '' : '';

            // 모달 필드에 값 설정
            document.getElementById('sender-id').value = senderId;
            document.getElementById('receiver-id').value = receiverId;
            document.getElementById('storen-id').value = storenId;
            document.getElementById('storage-id').value = storageId;
            document.getElementById('rental-id').value = rentalId;
            document.getElementById('product-name').value = equipmentName;
            document.getElementById('start-date').value = deliveryStartDate;
            document.getElementById('end-date').value = deliveryEndDate;
            document.getElementById('tracking').value = waybillNumber;

            // 셀렉트 박스 값 설정
            const courierSelect = document.getElementById('courier');
            for (let i = 0; i < courierSelect.options.length; i++) {
                if (courierSelect.options[i].value === carrierName ||
                    courierSelect.options[i].textContent === carrierName) {
                    courierSelect.selectedIndex = i;
                    break;
                }
            }

            // 검수 관련 필드가 있는 경우에만 설정
            if (document.getElementById('inspection-date')) {
                document.getElementById('inspection-date').value = inspectionDate;
            }
            if (document.getElementById('inspection-type')) {
                document.getElementById('inspection-type').value = inspectionResult;
            }

            // 배송 상태 결정 (날짜 기반)
            const shippingStatus = document.getElementById('shipping-status');
            if (deliveryEndDate && deliveryEndDate.trim() !== '') {
                shippingStatus.value = 'delivered'; // 배송 완료
            } else if (deliveryStartDate && deliveryStartDate.trim() !== '') {
                shippingStatus.value = 'shipping'; // 배송 중
            } else {
                shippingStatus.value = 'preparing'; // 배송 준비 중
            }


            // 원래 배송 시작일 값 가져오기
            const originalStartDate = cells[7] ? cells[7].textContent.trim() : '';

            // 기존 필드에 값 설정 (이미 readonly로 설정됨)
            document.getElementById('start-date').value = originalStartDate;

            // 새 배송 시작일 필드 초기화
            const newStartDateInput = document.getElementById('new-start-date');
            newStartDateInput.value = originalStartDate; // 기본값으로 기존 날짜 설정

            // 날짜 형식이 YYYY-MM-DD가 아닐 경우를 대비한 처리
            try {
                // 기존 날짜가 유효한 경우에만 최소 선택 가능 날짜 설정
                if (originalStartDate && !isNaN(new Date(originalStartDate).getTime())) {
                    newStartDateInput.min = originalStartDate; // 최소 선택 가능 날짜 설정
                }
            } catch (e) {
                console.warn('날짜 형식 변환 오류:', e);
            }


            // 모달 표시
            shippingModal.style.display = 'block';
        });
    });

    // 배송조회 버튼 클릭 이벤트
    document.getElementById('track-btn').addEventListener('click', function() {
        const trackingNumber = document.getElementById('tracking').value;
        const courier = document.getElementById('courier').value;

        if (!trackingNumber) {
            alert('운송장 번호가 없습니다.');
            return;
        }

        // 택배사별 배송조회 URL
        let trackingUrl = '';
        switch(courier) {
            case '대한통운':
                trackingUrl = `https://www.cjlogistics.com/ko/tool/parcel/tracking?gnbInvcNo=${trackingNumber}`;
                break;
            case '한진택배':
                trackingUrl = `https://www.hanjin.co.kr/kor/CMS/DeliveryMgr/WaybillResult.do?mCode=MN038&schLang=KR&wblnumText=${trackingNumber}`;
                break;
            case '우체국택배':
                trackingUrl = `https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${trackingNumber}`;
                break;
            case '로젠택배':
                trackingUrl = `https://www.ilogen.com/web/personal/trace/${trackingNumber}`;
                break;
            case '롯데택배':
                trackingUrl = `https://www.lotteglogis.com/home/reservation/tracking/index?InvNo=${trackingNumber}`;
                break;
            default:
                alert('지원하지 않는 택배사입니다.');
                return;
        }

        // 새 창에서 배송 조회 페이지 열기
        window.open(trackingUrl, '_blank');
    });

    // 검색 기능
    document.getElementById('search-btn').addEventListener('click', function() {
        const shippingType = document.getElementById('shipping-type-filter').value;
        const shippingStatus = document.getElementById('shipping-status-filter').value;
        const startDate = document.getElementById('start-date-filter').value;
        const endDate = document.getElementById('end-date-filter').value;
        const searchText = document.getElementById('search-input').value;

        // 폼 생성 및 제출
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = document.querySelector('form').action.replace(/\/[^\/]*$/, '/admin-deliverySearch.action');

        // 파라미터 추가
        const params = {
            shippingType,
            shippingStatus,
            startDate,
            endDate,
            searchKeyword: searchText
        };

        for (const key in params) {
            if (params[key]) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = params[key];
                form.appendChild(input);
            }
        }

        document.body.appendChild(form);
        form.submit();
    });

    // 전체 선택 체크박스 기능 (각 탭마다)
    const selectAllCheckboxes = document.querySelectorAll('.select-all-checkbox input[type="checkbox"]');
    selectAllCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // 현재 활성화된 탭 내의 체크박스만 선택
            const activeTab = document.querySelector('.tab-content.active');
            const tableCheckboxes = activeTab.querySelectorAll('td.col-select input[type="checkbox"]');

            tableCheckboxes.forEach(tableCheckbox => {
                tableCheckbox.checked = this.checked;
            });
        });
    });

    // 테이블 헤더 체크박스 기능 (각 탭마다)
    const headerCheckboxes = document.querySelectorAll('th.col-select input[type="checkbox"]');
    headerCheckboxes.forEach(headerCheckbox => {
        headerCheckbox.addEventListener('change', function() {
            // 현재 테이블 내의 체크박스만 선택
            const table = this.closest('table');
            const tableCheckboxes = table.querySelectorAll('td.col-select input[type="checkbox"]');

            tableCheckboxes.forEach(tableCheckbox => {
                tableCheckbox.checked = this.checked;
            });

            // selectAll 체크박스도 동기화
            const activeTab = document.querySelector('.tab-content.active');
            const selectAllCheckbox = activeTab.querySelector('.select-all-checkbox input[type="checkbox"]');
            selectAllCheckbox.checked = this.checked;
        });
    });

    // 일괄 작업을 위한 선택된 항목 처리 함수
    function getSelectedShippingIds() {
        const activeTab = document.querySelector('.tab-content.active');
        const selectedCheckboxes = activeTab.querySelectorAll('td.col-select input[type="checkbox"]:checked');

        return Array.from(selectedCheckboxes).map(checkbox => checkbox.value);
    }

    // 현재 날짜 설정
    function setDefaultDates() {
        const today = new Date();
        const oneMonthAgo = new Date(today);
        oneMonthAgo.setMonth(today.getMonth() - 1);

        const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        };

        document.getElementById('start-date-filter').value = formatDate(oneMonthAgo);
        document.getElementById('end-date-filter').value = formatDate(today);
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 선택된 탭의 배송 흐름도 업데이트
        const activeTabId = document.querySelector('.tab-button.active').getAttribute('data-tab');
        updateShippingFlow(activeTabId);

        // 기본 날짜 설정
        setDefaultDates();
    });

    //페이지네이션 버튼 클릭 이벤트
    const paginationButtons = document.querySelectorAll('.pagination-btn');
    paginationButtons.forEach(button => {
        button.addEventListener('click',function () {
            //페이지 버튼이 아닌 경우 (이전/다음 페이지)
            if (this.textContent === '«' || this.textContent === '»') {
                // 이전/다음 페이지 로직 처리
                return;
            }

            // 현재 활성화된 페이지 버튼 비활성화
            document.querySelector('.pagination-btn.active').classList.remove('active');

            // 클릭한 페이지 버튼 활성화
            this.classList.add('active');

            // 실제 구현에서는 서버에 해당 페이지 데이터 요청
            const page = this.textContent;
            console.log({
                action:'페이지 이동',
                page
            });
        });
    });

    // 폼 제출 이벤트 리스너 추가
    document.getElementById('shipping-form').addEventListener('submit', function(event) {

        // 새 배송 시작일 유효성 검사
        const originalStartDate = document.getElementById('start-date').value;
        const newStartDate = document.getElementById('new-start-date').value;

        if (!newStartDate) {
            event.preventDefault();
            alert('새 배송 시작일을 입력해주세요.');
            return;
        }

        // 새 날짜가 기존 날짜보다 이전인지 확인
        const originalDate = new Date(originalStartDate);
        const newDate = new Date(newStartDate);

        if (!isNaN(originalDate.getTime()) && !isNaN(newDate.getTime()) && newDate < originalDate) {
            event.preventDefault();
            alert('새 배송 시작일은 기존 배송 시작일(' + originalStartDate + ')보다 이전일 수 없습니다.');
            return;
        }

        // 변경 확인
        if (originalStartDate !== newStartDate) {
            if (!confirm('배송 시작일을 ' + originalStartDate + '에서 ' + newStartDate + '로 변경하시겠습니까?')) {
                event.preventDefault();
                return;
            }
        } else {
            if (!confirm('배송 정보를 업데이트하시겠습니까?')) {
                event.preventDefault();
                return;
            }
        }

        // 정상 제출 시 사용자에게 알림
        alert('배송 정보가 업데이트되었습니다. 페이지가 새로고침됩니다.');
    });

    // 새 배송 시작일 변경 이벤트 리스너
    document.getElementById('new-start-date').addEventListener('change', function() {
        const originalStartDate = document.getElementById('start-date').value;
        const newStartDate = this.value;

        if (originalStartDate && newStartDate) {
            const originalDate = new Date(originalStartDate);
            const newDate = new Date(newStartDate);

            // 새 날짜가 기존 날짜보다 이전인 경우 경고
            if (!isNaN(originalDate.getTime()) && !isNaN(newDate.getTime()) && newDate < originalDate) {
                alert('새 배송 시작일은 기존 배송 시작일(' + originalStartDate + ')보다 이전일 수 없습니다.');
                this.value = originalStartDate; // 값 원래대로 되돌리기
            }
        }
    });
</script>
</body>
</html>