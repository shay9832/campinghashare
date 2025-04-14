<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <select id="shipping-type-filter">
                <option value="all">전체</option>
                <option value="platform">플랫폼 배송</option>
                <option value="platform-return">플랫폼 배송 반환</option>
                <option value="user">거래자 택배</option>
                <option value="user-return">거래자 택배 반환</option>
                <option value="storage-return">보관 최종 반환</option>
                <option value="storen-return">스토렌 최종 반환</option>
            </select>

            <span>배송상태</span>
            <select id="shipping-status-filter">
                <option value="all">전체</option>
                <option value="preparing">배송 준비중</option>
                <option value="shipping">배송중</option>
                <option value="delivered">배송 완료</option>
                <option value="returning">반송중</option>
                <option value="returned">반송 완료</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date" id="start-date-filter">
                <span>~</span>
                <input type="date" id="end-date-filter">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" id="search-input" placeholder="검색어 입력 (ID, 고객명 등)">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" id="search-btn" value="검색하기">
            </div>
        </div>

        <!-- 배송 정보 요약 -->
        <div class="shipping-count">
            <div class="shipping-total">
                <span>총 배송 건수 : 3,254건</span>
            </div>
            <div class="shipping-ongoing">
                <span>진행중 배송 : 487건</span>
            </div>
            <div class="shipping-completed">
                <span>완료된 배송 : 2,767건</span>
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
                    <input type="checkbox" id="platform-select-all"> <label for="platform-return-select-all">전체 선택</label>
                </div>

                <div class="shipping-table">
                    <table>
                        <tr>
                            <th class="col-select"><input type="checkbox"></th>
                            <th class="col-shipping-id">배송 ID</th>
                            <th class="col-customer">고객명</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>RETN001</td>
                            <td>홍길동</td>
                            <td>카메라 장비 세트</td>
                            <td>2023-04-20</td>
                            <td>2023-04-22</td>
                            <td><span class="status-badge status-returned">반환 완료</span></td>
                            <td>대한통운</td>
                            <td>2345678901</td>
                            <td>2023-04-19</td>
                            <td>정상</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>RETN002</td>
                            <td>김영희</td>
                            <td>드론 SET</td>
                            <td>2023-04-23</td>
                            <td>-</td>
                            <td><span class="status-badge status-returning">반환중</span></td>
                            <td>한진택배</td>
                            <td>0987654321</td>
                            <td>2023-04-22</td>
                            <td>경미한 손상</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                            <th class="col-customer">고객명</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-inspection-date">검수 처리일</th>
                            <th class="col-inspection-type">검수 결과</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox" class="platform-return-row-checkbox"></td>
                            <td>RETN001</td>
                            <td>홍길동</td>
                            <td>카메라 장비 세트</td>
                            <td>2023-04-20</td>
                            <td>2023-04-22</td>
                            <td><span class="status-badge status-returned">반환 완료</span></td>
                            <td>대한통운</td>
                            <td>2345678901</td>
                            <td>2023-04-19</td>
                            <td>정상</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox" class="platform-return-row-checkbox"></td>
                            <td>RETN002</td>
                            <td>김영희</td>
                            <td>드론 SET</td>
                            <td>2023-04-23</td>
                            <td>-</td>
                            <td><span class="status-badge status-returning">반환중</span></td>
                            <td>한진택배</td>
                            <td>0987654321</td>
                            <td>2023-04-22</td>
                            <td>경미한 손상</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                            <th class="col-customer">발신자</th>
                            <th class="col-customer">수신자</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>USER001</td>
                            <td>이철수</td>
                            <td>박민지</td>
                            <td>소니 카메라</td>
                            <td>2023-04-18</td>
                            <td>2023-04-20</td>
                            <td><span class="status-badge status-delivered">배송 완료</span></td>
                            <td>로젠택배</td>
                            <td>3456789012</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>USER002</td>
                            <td>강다희</td>
                            <td>윤재석</td>
                            <td>캐논 렌즈</td>
                            <td>2023-04-19</td>
                            <td>-</td>
                            <td><span class="status-badge status-shipping">배송중</span></td>
                            <td>우체국택배</td>
                            <td>6543210987</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                            <th class="col-customer">발신자</th>
                            <th class="col-customer">수신자</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>URETN001</td>
                            <td>박민지</td>
                            <td>이철수</td>
                            <td>소니 카메라</td>
                            <td>2023-04-25</td>
                            <td>2023-04-27</td>
                            <td><span class="status-badge status-returned">반환 완료</span></td>
                            <td>로젠택배</td>
                            <td>4567890123</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>URETN002</td>
                            <td>윤재석</td>
                            <td>강다희</td>
                            <td>캐논 렌즈</td>
                            <td>2023-04-26</td>
                            <td>-</td>
                            <td><span class="status-badge status-returning">반환중</span></td>
                            <td>우체국택배</td>
                            <td>7654321098</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                            <th class="col-storage-id">보관 ID</th>
                            <th class="col-customer">고객명</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>STOR001</td>
                            <td>STG1001</td>
                            <td>최지혜</td>
                            <td>니콘 카메라 + 렌즈 3종</td>
                            <td>2023-04-28</td>
                            <td>2023-04-30</td>
                            <td><span class="status-badge status-delivered">배송 완료</span></td>
                            <td>대한통운</td>
                            <td>5678901234</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>STOR002</td>
                            <td>STG1002</td>
                            <td>장현우</td>
                            <td>DJI 드론 + 액세서리</td>
                            <td>2023-04-29</td>
                            <td>-</td>
                            <td><span class="status-badge status-shipping">배송중</span></td>
                            <td>한진택배</td>
                            <td>8765432109</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                            <th class="col-storen-id">스토렌 ID</th>
                            <th class="col-rental-id">렌탈 ID</th>
                            <th class="col-customer">고객명</th>
                            <th class="col-product">상품명</th>
                            <th class="col-start-date">배송 시작일</th>
                            <th class="col-end-date">배송 종료일</th>
                            <th class="col-status">배송 상태</th>
                            <th class="col-courier">택배사</th>
                            <th class="col-tracking">운송장번호</th>
                            <th class="col-actions">관리</th>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>STOREN001</td>
                            <td>STN1001</td>
                            <td>RTL1001</td>
                            <td>김도윤</td>
                            <td>소니 미러리스 세트</td>
                            <td>2023-05-01</td>
                            <td>2023-05-03</td>
                            <td><span class="status-badge status-delivered">배송 완료</span></td>
                            <td>대한통운</td>
                            <td>6789012345</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>

                        <tr>
                            <td class="col-select"><input type="checkbox"></td>
                            <td>STOREN002</td>
                            <td>STN1002</td>
                            <td>RTL1002</td>
                            <td>이수진</td>
                            <td>캐논 DSLR 세트</td>
                            <td>2023-05-02</td>
                            <td>-</td>
                            <td><span class="status-badge status-shipping">배송중</span></td>
                            <td>한진택배</td>
                            <td>9876543210</td>
                            <td><button class="btn btn-primary action-btn view-shipping-btn">상세</button></td>
                        </tr>
                    </table>
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
                    <form id="shipping-form">
                        <div class="form-group">
                            <label for="shipping-id">배송 ID</label>
                            <input type="text" id="shipping-id" class="form-control" disabled>
                        </div>

                        <div class="form-group">
                            <label for="shipping-type">배송 유형</label>
                            <input type="text" id="shipping-type" class="form-control" disabled>
                        </div>

                        <div id="id-fields" class="form-row" style="display: flex; gap: 10px;">
                            <!-- 동적으로 추가될 ID 필드들 (보관 ID, 렌탈 ID, 스토렌 ID 등) -->
                        </div>

                        <div class="form-group">
                            <label for="customer-name">고객명</label>
                            <input type="text" id="customer-name" class="form-control" disabled>
                        </div>

                        <div class="form-group">
                            <label for="product-name">상품명</label>
                            <input type="text" id="product-name" class="form-control" disabled>
                        </div>

                        <div class="form-group">
                            <label for="start-date">배송 시작일</label>
                            <input type="text" id="start-date" class="form-control" disabled>
                        </div>

                        <div class="form-group">
                            <label for="end-date">배송 종료일</label>
                            <input type="text" id="end-date" class="form-control" disabled>
                        </div>

                        <div class="form-group">
                            <label for="shipping-status">배송 상태</label>
                            <select id="shipping-status" class="form-control">
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
                            <select id="courier" class="form-control">
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
                            <input type="text" id="tracking" class="form-control">
                        </div>

                        <div id="inspection-fields">
                            <!-- 동적으로 추가될 검수 관련 필드들 -->
                        </div>

                        <div class="form-group">
                            <label for="shipping-memo">메모</label>
                            <textarea id="shipping-memo" class="form-control" rows="3"></textarea>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-info" id="track-btn">배송조회</button>
                            <button type="button" class="btn btn-primary" id="update-btn">정보 업데이트</button>
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

    // 모달 관련 변수
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

    // 배송 상세 버튼 클릭 시 모달 표시
    function setupShippingButtons() {
        const viewShippingButtons = document.querySelectorAll('.view-shipping-btn');
        viewShippingButtons.forEach(button => {
            button.addEventListener('click', function() {
                const row = this.closest('tr');
                const shippingId = row.cells[1].textContent;

                // 현재 활성화된 탭 확인
                const activeTab = document.querySelector('.tab-button.active').getAttribute('data-tab');

                // ID 필드 컨테이너 비우기
                const idFieldsContainer = document.getElementById('id-fields');
                idFieldsContainer.innerHTML = '';

                // 검수 필드 컨테이너 비우기
                const inspectionFieldsContainer = document.getElementById('inspection-fields');
                inspectionFieldsContainer.innerHTML = '';

                // 배송 유형에 따라 다른 필드 표시
                let shippingType = '';
                switch(activeTab) {
                    case 'platform-tab':
                        shippingType = '플랫폼 배송';
                        break;
                    case 'platform-return-tab':
                        shippingType = '플랫폼 배송 반환';

                        // 검수 필드 추가
                        inspectionFieldsContainer.innerHTML = `
            <div class="form-group">
              <label for="inspection-date">검수 처리일</label>
              <input type="text" id="inspection-date" class="form-control" value="${row.cells[9].textContent}" disabled>
            </div>
            <div class="form-group">
              <label for="inspection-type">검수 결과</label>
              <input type="text" id="inspection-type" class="form-control" value="${row.cells[10].textContent}" disabled>
            </div>
          `;
                        break;
                    case 'user-tab':
                        shippingType = '거래자 택배';
                        break;
                    case 'user-return-tab':
                        shippingType = '거래자 택배 반환';
                        break;
                    case 'storage-return-tab':
                        shippingType = '보관 최종 반환';

                        // 보관 ID 필드 추가
                        idFieldsContainer.innerHTML = `
            <div class="form-group" style="flex: 1;">
              <label for="storage-id">보관 ID</label>
              <input type="text" id="storage-id" class="form-control" value="${row.cells[2].textContent}" disabled>
            </div>
          `;
                        break;
                    case 'storen-return-tab':
                        shippingType = '스토렌 최종 반환';

                        // 스토렌 ID와 렌탈 ID 필드 추가
                        idFieldsContainer.innerHTML = `
            <div class="form-group" style="flex: 1;">
              <label for="storen-id">스토렌 ID</label>
              <input type="text" id="storen-id" class="form-control" value="${row.cells[2].textContent}" disabled>
            </div>
            <div class="form-group" style="flex: 1;">
              <label for="rental-id">렌탈 ID</label>
              <input type="text" id="rental-id" class="form-control" value="${row.cells[3].textContent}" disabled>
            </div>
          `;
                        break;
                }

                // 기본 모달 필드 설정
                document.getElementById('shipping-id').value = shippingId;
                document.getElementById('shipping-type').value = shippingType;

                // 고객명 설정 (거래자 택배인 경우 발신자로 설정)
                let customerIndex = 2;
                if (activeTab === 'user-tab' || activeTab === 'user-return-tab') {
                    customerIndex = 2; // 발신자 인덱스
                } else if (activeTab === 'storage-return-tab') {
                    customerIndex = 3; // 보관 ID 다음 인덱스
                } else if (activeTab === 'storen-return-tab') {
                    customerIndex = 4; // 스토렌 ID, 렌탈 ID 다음 인덱스
                }
                document.getElementById('customer-name').value = row.cells[customerIndex].textContent;

                // 상품명 설정
                let productIndex = 3;
                if (activeTab === 'user-tab' || activeTab === 'user-return-tab') {
                    productIndex = 4; // 수신자 다음 인덱스
                } else if (activeTab === 'storage-return-tab') {
                    productIndex = 4; // 고객명 다음 인덱스
                } else if (activeTab === 'storen-return-tab') {
                    productIndex = 5; // 고객명 다음 인덱스
                }
                document.getElementById('product-name').value = row.cells[productIndex].textContent;

                // 배송 일자 설정
                let dateStartIndex = productIndex + 1;
                let dateEndIndex = dateStartIndex + 1;
                document.getElementById('start-date').value = row.cells[dateStartIndex].textContent;
                document.getElementById('end-date').value = row.cells[dateEndIndex].textContent;

                // 배송 상태 설정
                let statusIndex = dateEndIndex + 1;
                const statusText = row.cells[statusIndex].querySelector('.status-badge').textContent.trim();
                const statusSelect = document.getElementById('shipping-status');

                switch(statusText) {
                    case '배송 준비중':
                        statusSelect.value = 'preparing';
                        break;
                    case '배송중':
                        statusSelect.value = 'shipping';
                        break;
                    case '배송 완료':
                        statusSelect.value = 'delivered';
                        break;
                    case '반송중':
                    case '반환중':
                        statusSelect.value = 'returning';
                        break;
                    case '반송 완료':
                    case '반환 완료':
                        statusSelect.value = 'returned';
                        break;
                    case '취소됨':
                        statusSelect.value = 'cancelled';
                        break;
                }

                // 택배사 및 운송장 번호 설정
                let courierIndex = statusIndex + 1;
                let trackingIndex = courierIndex + 1;

                document.getElementById('courier').value = row.cells[courierIndex].textContent;
                document.getElementById('tracking').value = row.cells[trackingIndex].textContent;

                // 모달 표시
                shippingModal.style.display = 'block';
            });
        });
    }

    // 배송조회 버튼 클릭 이벤트
    document.getElementById('track-btn').addEventListener('click', function() {
        const trackingNumber = document.getElementById('tracking').value;
        const courier = document.getElementById('courier').value;

        if (!trackingNumber) {
            alert('운송장 번호가 없습니다.');
            return;
        }

        // 실제 구현에서는 택배사별 배송조회 페이지로 연결하거나 API 호출
        alert(`${courier}의 운송장번호 ${trackingNumber}를 조회합니다.`);
    });

    // 정보 업데이트 버튼 클릭 이벤트
    document.getElementById('update-btn').addEventListener('click', function() {
        const shippingId = document.getElementById('shipping-id').value;
        const shippingStatus = document.getElementById('shipping-status').value;
        const courier = document.getElementById('courier').value;
        const tracking = document.getElementById('tracking').value;
        const memo = document.getElementById('shipping-memo').value;

        // 실제 구현에서는 서버에 업데이트 요청을 보내는 AJAX 처리
        console.log({
            action: '배송 정보 업데이트',
            shippingId,
            shippingStatus,
            courier,
            tracking,
            memo
        });

        // 성공 메시지 표시
        alert('배송 정보가 업데이트되었습니다.');

        // 모달 닫기
        shippingModal.style.display = 'none';
    });

    // 검색 기능
    document.getElementById('search-btn').addEventListener('click', function() {
        const shippingType = document.getElementById('shipping-type-filter').value;
        const shippingStatus = document.getElementById('shipping-status-filter').value;
        const startDate = document.getElementById('start-date-filter').value;
        const endDate = document.getElementById('end-date-filter').value;
        const searchText = document.getElementById('search-input').value;

        // 실제 구현에서는 서버에 검색 요청을 보내고 결과를 받아 처리
        console.log({
            action: '배송 정보 검색',
            shippingType,
            shippingStatus,
            startDate,
            endDate,
            searchText
        });

        // 검색 결과에 따라 UI 업데이트 (예시)
        alert('검색 조건에 맞는 배송 정보를 조회합니다.');
    });

    // 전체 선택 체크박스 기능 (각 탭마다)
    function setupCheckboxes() {
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
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 선택된 탭의 배송 흐름도 업데이트
        const activeTabId = document.querySelector('.tab-button.active').getAttribute('data-tab');
        updateShippingFlow(activeTabId);

        // 상세 버튼 이벤트 설정
        setupShippingButtons();

        // 체크박스 이벤트 설정
        setupCheckboxes();
    });
</script>
</body>
</html>
