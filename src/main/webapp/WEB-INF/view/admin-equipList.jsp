<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
    <title>관리자페이지 - 장비리스트</title> <!-- 브라우저 탭에 표시될 제목 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-equipList.css">
</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 -->
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
            <form action="${pageContext.request.contextPath}/admin-payUpdate.action" method="get">
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
            <form action="${pageContext.request.contextPath}/admin-communityStatistics.action" method="get">
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
            <form action="${pageContext.request.contextPath}/admin-userReportList.action" method="get">
                <button type="submit" class="submenu-btn">신고 처리 내역</button>
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

    <!-- 콘텐츠 영역 - 실제 데이터와 컨트롤이 표시되는 부분 -->
    <div id="content">
        <!-- 콘텐츠 헤더 - 페이지 제목 -->
        <div class="content-header">
            <h2>장비 목록 조회</h2>
        </div>

        <!-- 렌탈 타입 탭 메뉴 -->
        <div class="rental-type-tabs">
            <div class="rental-tab active" data-tab="all-equipment">전체 장비</div>
            <div class="rental-tab" data-tab="store-rentals">스토렌</div>
            <div class="rental-tab" data-tab="regular-rentals">일반렌탈</div>
        </div>

        <!-- 검색 영역 - 장비 검색 필터링 옵션 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select name="searchType">
                <option value="equipCode">장비코드</option>
                <option value="equipName">장비명</option>
                <option value="ownerName">소유자명</option>
            </select>

            <!-- 대분류 선택 -->
            <span>대분류</span>
            <select name="mainCategory" id="mainCategory">
                <option value="">전체</option>
                <c:forEach var="category" items="${mainCategories}">
                    <option value="${category.categoryCode}">${category.categoryName}</option>
                </c:forEach>
                <!-- 테스트용 주석 예시 데이터
                <option value="TENT">텐트/타프</option>
                <option value="SLEEP">침낭/매트</option>
                <option value="FURN">캠핑 가구</option>
                <option value="COOK">조리도구</option>
                <option value="LIGHT">랜턴/조명</option>
                <option value="ETC">기타</option>
                -->
            </select>

            <!-- 중분류 선택 -->
            <span>중분류</span>
            <select name="subCategory" id="subCategory">
                <option value="">전체</option>
                <!-- 대분류 선택 시 Ajax로 로드됨 -->
                <!-- 테스트용 주석 예시 데이터
                <option value="TENT01">텐트</option>
                <option value="TENT02">타프</option>
                <option value="TENT03">그라운드시트</option>
                -->
            </select>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" name="searchKeyword" placeholder="검색어 입력">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" id="searchBtn" value="검색하기">
            </div>
        </div>

        <!-- 전체 장비 영역 -->
        <div id="all-equipment" class="content-area active">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 장비 : <c:out value="${stats.totalCount}"/>대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : <c:out value="${stats.availableCount}"/>대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 : <c:out value="${stats.rentedCount}"/>대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : <c:out value="${stats.maintenanceCount}"/>대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table class="main-menu">
                    <thead>
                    <tr>
                        <!-- 간소화된 테이블 헤더 -->
                        <th class="col-select">선택</th>
                        <th class="col-code">장비코드 / 소유자</th>
                        <th class="col-name">장비명</th>
                        <th class="col-main-category">대분류</th>
                        <th class="col-sub-category">중분류</th>
                        <th class="col-avg-price">평균가격</th>
                        <th class="col-reg-date">장비등록일</th>
                        <th class="col-actions">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 일반렌탈 장비 데이터 행 - JSTL로 조회된 데이터 표시 -->

                    <!-- 장비 데이터 행 - JSTL로 조회된 데이터 표시 -->
<%--                    <c:forEach var="equip" items="${equipList}">--%>
<%--                        <tr>--%>
<%--                            <td class="checkbox-column"><input type="checkbox" value="${equip.equipId}"></td>--%>
<%--                            <td>${equip.equipCode}</td>--%>
<%--                            <td>--%>
<%--                                <span class="rental-type-badge ${equip.rentalType eq 'STORE' ? 'type-store' : 'type-regular'}">--%>
<%--                                        ${equip.rentalType eq 'STORE' ? '스토렌' : '일반렌탈'}--%>
<%--                                </span>--%>
<%--                            </td>--%>
<%--                            <td>${equip.equipName}</td>--%>
<%--                            <td>${equip.mainCategoryName}</td>--%>
<%--                            <td>${equip.subCategoryName}</td>--%>
<%--                            <td><span class="grade-badge grade-${equip.grade.toLowerCase()}">${equip.grade}</span></td>--%>
<%--                            <td><fmt:formatNumber value="${equip.avgPrice}" pattern="#,###"/>원</td>--%>
<%--                            <td>--%>
<%--                                <span class="status-badge--%>
<%--                                    ${equip.status eq 'AVAILABLE' ? 'status-available' :--%>
<%--                                    equip.status eq 'RENTED' ? 'status-rented' : 'status-maintenance'}">--%>
<%--                                        ${equip.status eq 'AVAILABLE' ? '대여가능' :--%>
<%--                                                equip.status eq 'RENTED' ? '대여중' : '정비중'}--%>
<%--                                </span>--%>
<%--                            </td>--%>
<%--                            <td>${equip.rentalCount}</td>--%>
<%--                            <td><fmt:formatDate value="${equip.regDate}" pattern="yyyy-MM-dd"/></td>--%>
<%--                            <td>${equip.ownerName}</td>--%>
<%--                            <td>--%>
<%--                                <button class="action-btn info-btn" data-equip-id="2">정보</button>--%>
<%--                                <button class="action-btn inspect-btn" data-equip-id="2">검수</button>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
                    </tbody>
                </table>
            </div>


            <!-- 페이지네이션 -->
            <div class="pagination" id="pagination">
                <button class="page-btn first-page">&laquo;</button>
                <button class="page-btn prev-page">&lt;</button>
                <div class="page-numbers">
<%--                    <c:choose>--%>
<%--                        <c:when test="${not empty regularPaging and regularPaging.totalPage > 0}">--%>
<%--                            <c:forEach var="i" begin="${regularPaging.startPage}" end="${regularPaging.endPage}">--%>
<%--                                <button class="page-btn ${i eq regularPaging.currentPage ? 'active' : ''}"--%>
<%--                                        data-page="${i}">${i}</button>--%>
<%--                            </c:forEach>--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            <!-- 데이터가 없거나 페이징 정보가 없을 경우 기본 페이지 번호 표시 -->--%>
<%--                            <button class="page-btn active" data-page="1">1</button>--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
                </div>
                <button class="page-btn next-page">&gt;</button>
                <button class="page-btn last-page">&raquo;</button>
            </div>
        </div>

        <!-- 스토렌 장비 영역 -->
        <div id="store-rentals" class="content-area">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 스토렌 장비 : 대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : 대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 :대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : 대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAllStore"> <label for="selectAllStore">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table class="main-menu">
                    <thead>
                    <tr>
                        <!-- 간소화된 테이블 헤더 -->
                        <th class="col-select">선택</th>
                        <th class="col-storen-id">선택</th>
                        <th class="col-code">장비코드 / 소유자</th>
                        <th class="col-user-code">유저코드</th>
                        <th class="col-size-id">사이즈ID</th>
                        <th class="col-size-name">사이즈이름</th>
                        <th class="col-required">창고공간</th>
                        <th class="col-storage-price">하루보관가격</th>
                        <th class="col-storen-month">보관개월수</th>
                        <th class="col-title">게시물제목</th>
                        <th class="col-content">게시물내용</th>
                        <th class="col-rental-price">하루렌탈가격</th>
                        <th class="col-reg-date">장비등록일</th>
                        <th class="col-actions">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 스토렌 장비 데이터 행 - JSTL로 조회된 데이터 표시 -->
                    <c:forEach var="equip" items="${getLists}">
                        <tr>
                            <td class="checkbox-column"><input type="checkbox"></td>
                            <td>${equip.STOREN_ID}</td>
                            <td>${equip.EQUIP_CODE}</td>
                            <td>${equip.USER_CODE}</td>
                            <td>${equip.SIZE_ID}</td>
                            <td>${equip.EQUIP_SIZE_NAME}</td>
                            <td>${equip.REQUIRED_SPACE}</td>
                            <td>${equip.DAILY_STORAGE_FEE}</td>
                            <td>${equip.STORE_MONTH}</td>
                            <td>${equip.STOREN_TITLE}</td>
                            <td>${equip.STOREN_CONTENT}</td>
                            <td>${equip.DAILY_RENT_PRICE}</td>
                            <td>${equip.CREATED_DATE}</td>
                            <td><button class="action-btn">수정하기</button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination" id="storePagination">
                <button class="page-btn first-page">&laquo;</button>
                <button class="page-btn prev-page">&lt;</button>
                <div class="page-numbers">
<%--                    <c:choose>--%>
<%--                        <c:when test="${not empty storePaging and storePaging.totalPage > 0}">--%>
<%--                            <c:forEach var="i" begin="${storePaging.startPage}" end="${storePaging.endPage}">--%>
<%--                                <button class="page-btn ${i eq storePaging.currentPage ? 'active' : ''}"--%>
<%--                                        data-page="${i}">${i}</button>--%>
<%--                            </c:forEach>--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            <!-- 데이터가 없거나 페이징 정보가 없을 경우 기본 페이지 번호 표시 -->--%>
<%--                            <button class="page-btn active" data-page="1">1</button>--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
                </div>
                <button class="page-btn next-page">&gt;</button>
                <button class="page-btn last-page">&raquo;</button>
            </div>
        </div>

        <!-- 일반렌탈 장비 영역 -->
        <div id="regular-rentals" class="content-area">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 일반렌탈 장비 : 대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : 대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 : 대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : s대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAllRegular"> <label for="selectAllRegular">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table class="main-menu">
                <thead>
                <tr>
                    <!-- 간소화된 테이블 헤더 -->
                    <th class="col-select">선택</th>
                    <th class="col-code">장비코드 / 소유자</th>
                    <th class="col-name">장비명</th>
                    <th class="col-main-category">대분류</th>
                    <th class="col-sub-category">중분류</th>
                    <th class="col-avg-price">평균가격</th>
                    <th class="col-reg-date">장비등록일</th>
                    <th class="col-actions">관리</th>
                </tr>
                </thead>
                <tbody>
                    <!-- 일반렌탈 장비 데이터 행 - JSTL로 조회된 데이터 표시 -->
                    <c:forEach var="equip" items="${getList}">
                        <tr>
                            <td class="checkbox-column"><input type="checkbox"></td>
                            <td>${equip.EQUIP_CODE}</td>
                            <td>${equip.EQUIP_NAME}</td>
                            <td>${equip.MAJOR_CATEGORY_NAME}</td>
                            <td>${equip.MIDDLE_CATEGORY_NAME}</td>
                            <td>${equip.ORIGINAL_PRICE}원</td>
                            <td>${equip.CREATED_DATE}</td>
                            <td><button class="action-btn">수정하기</button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination" id="regularPagination">
                <button class="page-btn first-page">&laquo;</button>
                <button class="page-btn prev-page">&lt;</button>
                <div class="page-numbers">
<%--                    <c:choose>--%>
<%--                        <c:when test="${not empty regularPaging and regularPaging.totalPage > 0}">--%>
<%--                            <c:forEach var="i" begin="${regularPaging.startPage}" end="${regularPaging.endPage}">--%>
<%--                                <button class="page-btn ${i eq regularPaging.currentPage ? 'active' : ''}"--%>
<%--                                        data-page="${i}">${i}</button>--%>
<%--                            </c:forEach>--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            <!-- 데이터가 없거나 페이징 정보가 없을 경우 기본 페이지 번호 표시 -->--%>
<%--                            <button class="page-btn active" data-page="1">1</button>--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
                </div>
                <button class="page-btn next-page">&gt;</button>
                <button class="page-btn last-page">&raquo;</button>
            </div>
        </div>
    </div>
</div>

<script>
    // 메뉴 드롭다운 토글 기능
    const menuButtons = document.querySelectorAll('.menu-button');
    menuButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('active');
            const submenu = this.nextElementSibling;

            if (submenu.style.maxHeight) {
                submenu.style.maxHeight = null;
            } else {
                submenu.style.maxHeight = submenu.scrollHeight + "px";
            }
        });
    });

    // 페이지 로드 시 실행할 초기화 코드
    document.addEventListener('DOMContentLoaded', function() {
        // 장비 관리 메뉴 초기 상태 설정 - 페이지에 맞게 열어두기
        const equipmentMenu = document.querySelectorAll('.menu-button')[0];
        equipmentMenu.classList.add('active');
        const submenu = equipmentMenu.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + "px";

        // 렌탈 타입 탭 기능 구현
        const tabs = document.querySelectorAll('.rental-tab');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // 모든 탭에서 active 클래스 제거
                tabs.forEach(t => t.classList.remove('active'));

                // 클릭된 탭에 active 클래스 추가
                this.classList.add('active');

                // 모든 콘텐츠 영역 숨기기
                const contentAreas = document.querySelectorAll('.content-area');
                contentAreas.forEach(area => area.classList.remove('active'));

                // 클릭된 탭에 해당하는 콘텐츠 영역 표시
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });

        // 전체 선택 체크박스 이벤트 처리 - 전체 장비
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelector('#all-equipment').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 전체 선택 체크박스 이벤트 처리 - 스토렌 장비
        document.getElementById('selectAllStore').addEventListener('change', function() {
            const checkboxes = document.querySelector('#store-rentals').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 전체 선택 체크박스, 이벤트 처리 - 일반렌탈 장비
        document.getElementById('selectAllRegular').addEventListener('change', function() {
            const checkboxes = document.querySelector('#regular-rentals').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 대분류 선택 시 중분류 로드
        document.getElementById('mainCategory').addEventListener('change', function() {
            const mainCategoryCode = this.value;
            if (!mainCategoryCode) {
                // 전체 선택 시 중분류 초기화
                const subCategorySelect = document.getElementById('subCategory');
                subCategorySelect.innerHTML = '<option value="">전체</option>';
                return;
            }

            // Ajax를 사용하여 중분류 데이터 로드
            const contextPath = '${pageContext.request.contextPath}';
            fetch(contextPath + '/getSubCategories.action?mainCategoryCode=' + mainCategoryCode)
                .then(response => response.json())
                .then(data => {
                    const subCategorySelect = document.getElementById('subCategory');
                    subCategorySelect.innerHTML = '<option value="">전체</option>';

                    data.forEach(category => {
                        const option = document.createElement('option');
                        option.value = category.categoryCode;
                        option.textContent = category.categoryName;
                        subCategorySelect.appendChild(option);
                    });
                })
                .catch(error => console.error('중분류 로드 중 오류 발생:', error));
        });

        // 검색 버튼 클릭 이벤트
        document.getElementById('searchBtn').addEventListener('click', function() {
            const searchType = document.querySelector('select[name="searchType"]').value;
            const mainCategory = document.getElementById('mainCategory').value;
            const subCategory = document.getElementById('subCategory').value;
            const searchKeyword = document.querySelector('input[name="searchKeyword"]').value;

            // 현재 활성화된 탭 확인
            const activeTab = document.querySelector('.rental-tab.active').getAttribute('data-tab');
            let rentalType = '';

            if (activeTab === 'store-rentals') {
                rentalType = 'STORE';
            } else if (activeTab === 'regular-rentals') {
                rentalType = 'REGULAR';
            }

            // 검색 파라미터 구성
            const params = new URLSearchParams();
            params.append('searchType', searchType);
            if (mainCategory) params.append('mainCategory', mainCategory);
            if (subCategory) params.append('subCategory', subCategory);
            if (searchKeyword) params.append('searchKeyword', searchKeyword);
            if (rentalType) params.append('rentalType', rentalType);

            // 검색 요청
            const contextPath = '${pageContext.request.contextPath}';
            window.location.href = contextPath + '/admin-equipList.action?' + params.toString();
        });

        // 각 페이지네이션 설정 및 페이지 이동 처리
        function setupPagination(paginationId, rentalType) {
            const pagination = document.getElementById(paginationId);
            if (!pagination) return;

            const pageButtons = pagination.querySelectorAll('.page-numbers .page-btn');
            const firstPageBtn = pagination.querySelector('.first-page');
            const prevPageBtn = pagination.querySelector('.prev-page');
            const nextPageBtn = pagination.querySelector('.next-page');
            const lastPageBtn = pagination.querySelector('.last-page');

            // 현재 활성화된 버튼에서 페이지 번호 가져오기
            const activeButton = pagination.querySelector('.page-btn.active');
            let currentPage = activeButton ? parseInt(activeButton.getAttribute('data-page')) : 1;

            // 마지막 페이지 번호 가져오기
            const lastPageNumber = pageButtons.length > 0
                ? parseInt(pageButtons[pageButtons.length - 1].getAttribute('data-page'))
                : 1;

            // 페이지 이동 함수
            function navigateToPage(pageNumber) {
                // 현재 URL에서 쿼리 파라미터 가져오기
                const urlParams = new URLSearchParams(window.location.search);

                // 페이지 번호 설정
                urlParams.set('page', pageNumber);

                // 렌탈 타입이 있으면 설정
                if (rentalType) {
                    urlParams.set('rentalType', rentalType);
                }

                // 페이지 이동
                const contextPath = '${pageContext.request.contextPath}';
                window.location.href = contextPath + '/admin-equipList.action?' + urlParams.toString();
            }

            // 페이지 버튼 클릭 이벤트
            pageButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const pageNumber = parseInt(this.getAttribute('data-page'));
                    navigateToPage(pageNumber);
                });
            });

            // 처음 페이지 버튼 클릭 이벤트
            if (firstPageBtn) {
                firstPageBtn.addEventListener('click', function() {
                    if (currentPage !== 1) {
                        navigateToPage(1);
                    }
                });
            }

            // 이전 페이지 버튼 클릭 이벤트
            if (prevPageBtn) {
                prevPageBtn.addEventListener('click', function() {
                    if (currentPage > 1) {
                        navigateToPage(currentPage - 1);
                    }
                });
            }

            // 다음 페이지 버튼 클릭 이벤트
            if (nextPageBtn) {
                nextPageBtn.addEventListener('click', function() {
                    if (currentPage < lastPageNumber) {
                        navigateToPage(currentPage + 1);
                    }
                });
            }

            // 마지막 페이지 버튼 클릭 이벤트
            if (lastPageBtn) {
                lastPageBtn.addEventListener('click', function() {
                    if (currentPage !== lastPageNumber) {
                        navigateToPage(lastPageNumber);
                    }
                });
            }

            // 버튼 상태 업데이트
            if (firstPageBtn) firstPageBtn.disabled = currentPage === 1;
            if (prevPageBtn) prevPageBtn.disabled = currentPage === 1;
            if (nextPageBtn) nextPageBtn.disabled = currentPage === lastPageNumber;
            if (lastPageBtn) lastPageBtn.disabled = currentPage === lastPageNumber;
        }

        // 각 탭별 페이지네이션 설정
        setupPagination('pagination', null);
        setupPagination('storePagination', 'STORE');
        setupPagination('regularPagination', 'REGULAR');

        // 장비 정보 버튼 클릭 이벤트
        document.querySelectorAll('.info-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const equipId = this.getAttribute('data-equip-id');
                const contextPath = '${pageContext.request.contextPath}';
                window.location.href = contextPath + '/admin-equipDetail.action?equipId=' + equipId;
            });
        });

        // 장비 검수 버튼 클릭 이벤트
        document.querySelectorAll('.inspect-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const equipId = this.getAttribute('data-equip-id');
                const contextPath = '${pageContext.request.contextPath}';
                window.location.href = contextPath + '/admin-equipInspect.action?equipId=' + equipId;
            });
        });
    });
</script>
</body>