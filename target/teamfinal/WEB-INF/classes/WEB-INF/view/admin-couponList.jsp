<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 쿠폰 조회</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-couponList.css">
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
            <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get">
                <button type="submit" class="submenu-btn">브랜드 및 장비생성</button>
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

        <!-- 쿠폰 관리 메뉴 -->
        <button class="menu-button active">쿠폰 관리</button>
        <div class="submenu" style="max-height: 100px;">
            <form action="${pageContext.request.contextPath}/admin-couponList.action" method="get">
                <button type="submit" class="submenu-btn active">쿠폰 목록</button>
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
            <h2>쿠폰 조회</h2>
        </div>

        <!-- 검색 영역 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select name="searchType">
                <option value="memberCode">회원코드</option>
                <option value="nickname">닉네임</option>
                <option value="couponName">쿠폰이름</option>
            </select>

            <span>쿠폰 종류</span>
            <select name="couponType">
                <option value="all">전체</option>
                <c:forEach var="couponType" items="${couponTypes}">
                    <option value="${couponType.typeId}">${couponType.typeName}</option>
                </c:forEach>
            </select>

            <span>상태</span>
            <select name="status">
                <option value="all">전체</option>
                <option value="active">활성화</option>
                <option value="used">사용됨</option>
                <option value="expired">만료됨</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date" name="startDate">
                <span>~</span>
                <input type="date" name="endDate">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" name="keyword" placeholder="검색어 입력">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" value="검색하기" id="searchBtn">
            </div>
        </div>

        <!-- 쿠폰 정보 요약 -->
        <div class="coupon-count">
            <div class="coupon-all">
                <span>총 쿠폰 수 : ${couponStats.totalCount}장</span>
            </div>
            <div class="coupon-used">
                <span>사용된 쿠폰 : ${couponStats.usedCount}장</span>
            </div>
            <div class="coupon-active">
                <span>유효 쿠폰 : ${couponStats.activeCount}장</span>
            </div>
        </div>

        <!-- 전체 선택 체크박스 -->
        <div class="select-all-checkbox">
            <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
        </div>

        <!--삭제 버튼-->
        <div class="delete-btn">
            <input type="button" class="delete" value="삭제하기" id="deleteBtn">
        </div>

        <!-- 쿠폰 목록 테이블 -->
        <div class="coupon-index">
            <table>
                <tr>
                    <!-- 테이블 헤더 -->
                    <th class="col-select">선택</th>
                    <th class="col-coupon-id">보유쿠폰ID</th>
                    <th class="col-member-code">회원코드</th>
                    <th class="col-nickname">회원닉네임</th>
                    <th class="col-coupon-name">쿠폰이름</th>
                    <th class="col-coupon-type">쿠폰종류</th>
                    <th class="col-coupon-discount">쿠폰할인율</th>
                    <th class="col-coupon-validity">쿠폰유효개월수</th>
                    <th class="col-coupon-issue">쿠폰발행일</th>
                    <th class="col-coupon-expire">쿠폰만료일</th>
                    <th class="col-coupon-used">쿠폰사용완료일</th>
                </tr>

                <!-- JSTL을 사용한 쿠폰 데이터 출력 예시 -->
                <c:forEach var="coupon" items="${getList}">
                    <tr>
                        <td class="checkbox-column"><input type="checkbox" name="selectedCoupons" value="${coupon.ownedCouponId}"></td>
                        <td>${coupon.ownedCouponId}</td>
                        <td>${coupon.userCode}</td>
                        <td>${coupon.nickname}</td>
                        <td>${coupon.couponName}</td>
                        <td>
                            <c:forEach var="couponType" items="${getTypes}">
                                    ${couponType.couponTypeName}
                            </c:forEach>
                        </td>
                        <td>${coupon.couponDiscount}%</td>
                        <td>${coupon.couponMonth}개월</td>
                        <td><fmt:formatDate value="${coupon.issuedDate}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${coupon.expiryDate}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty coupon.completedDate}">
                                    <fmt:formatDate value="${coupon.completedDate}" pattern="yyyy-MM-dd"/>
                                    <span class="status-badge status-used">사용됨</span>
                                </c:when>
                                <c:when test="${coupon.expiryDate < now}">
                                    <span class="status-badge status-expired">만료됨</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-active">활성화</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <button class="page-btn first-page">&laquo;</button>
            <button class="page-btn prev-page">&lt;</button>
            <div class="page-numbers">
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNum">
                    <button class="page-btn ${paging.currentPage == pageNum ? 'active' : ''}">${pageNum}</button>
                </c:forEach>
            </div>
            <button class="page-btn next-page">&gt;</button>
            <button class="page-btn last-page">&raquo;</button>
        </div>
    </div>
</div>

<!-- 자바스크립트 - 페이지 기능 구현 -->
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

    // 전체 선택 체크박스 기능 구현
    const selectAllCheckbox = document.getElementById('selectAll');
    const rowCheckboxes = document.querySelectorAll('.coupon-index td.checkbox-column input[type="checkbox"]');

    selectAllCheckbox.addEventListener('change', function() {
        rowCheckboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allChecked = Array.from(rowCheckboxes).every(cb => cb.checked);
            selectAllCheckbox.checked = allChecked;
        });
    });

    // 검색 버튼 이벤트 리스너
    document.getElementById('searchBtn').addEventListener('click', function() {
        // 검색 기능 구현 코드
        const searchForm = document.createElement('form');
        searchForm.method = 'GET';
        searchForm.action = '${pageContext.request.contextPath}/admin-couponList.action';

        // 검색 파라미터 추가
        const searchType = document.querySelector('select[name="searchType"]').value;
        const couponType = document.querySelector('select[name="couponType"]').value;
        const status = document.querySelector('select[name="status"]').value;
        const startDate = document.querySelector('input[name="startDate"]').value;
        const endDate = document.querySelector('input[name="endDate"]').value;
        const keyword = document.querySelector('input[name="keyword"]').value;

        // 폼에 파라미터 추가하는 함수
        function addParam(name, value) {
            if (value) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = value;
                searchForm.appendChild(input);
            }
        }

        addParam('searchType', searchType);
        addParam('couponType', couponType);
        addParam('status', status);
        addParam('startDate', startDate);
        addParam('endDate', endDate);
        addParam('keyword', keyword);

        document.body.appendChild(searchForm);
        searchForm.submit();
    });

    // 삭제 버튼 이벤트 리스너
    document.getElementById('deleteBtn').addEventListener('click', function() {
        const selectedCoupons = document.querySelectorAll('input[name="selectedCoupons"]:checked');

        if (selectedCoupons.length === 0) {
            alert('삭제할 쿠폰을 선택해주세요.');
            return;
        }

        if (confirm('선택한 쿠폰을 삭제하시겠습니까?')) {
            const deleteForm = document.createElement('form');
            deleteForm.method = 'POST';
            deleteForm.action = '${pageContext.request.contextPath}/admin-deleteCoupons.action';

            selectedCoupons.forEach(checkbox => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'couponIds';
                input.value = checkbox.value;
                deleteForm.appendChild(input);
            });

            document.body.appendChild(deleteForm);
            deleteForm.submit();
        }
    });

    // 페이지네이션 기능 구현
    document.addEventListener('DOMContentLoaded', function() {
        const pageButtons = document.querySelectorAll('.page-numbers .page-btn');
        const firstPageBtn = document.querySelector('.first-page');
        const prevPageBtn = document.querySelector('.prev-page');
        const nextPageBtn = document.querySelector('.next-page');
        const lastPageBtn = document.querySelector('.last-page');

        // 페이지 버튼 클릭 이벤트
        pageButtons.forEach(button => {
            button.addEventListener('click', function() {
                location.href = '${pageContext.request.contextPath}/admin-couponList.action?page=' + this.textContent;
            });
        });

        // 처음 페이지 버튼 클릭 이벤트
        firstPageBtn.addEventListener('click', function() {
            location.href = '${pageContext.request.contextPath}/admin-couponList.action?page=1';
        });

        // 이전 페이지 버튼 클릭 이벤트
        prevPageBtn.addEventListener('click', function() {
            const prevPage = Math.max(1, ${paging.currentPage} - 1);
            location.href = '${pageContext.request.contextPath}/admin-couponList.action?page=' + prevPage;
        });

        // 다음 페이지 버튼 클릭 이벤트
        nextPageBtn.addEventListener('click', function() {
            const nextPage = Math.min(${paging.totalPages}, ${paging.currentPage} + 1);
            location.href = '${pageContext.request.contextPath}/admin-couponList.action?page=' + nextPage;
        });

        // 마지막 페이지 버튼 클릭 이벤트
        lastPageBtn.addEventListener('click', function() {
            location.href = '${pageContext.request.contextPath}/admin-couponList.action?page=${paging.totalPages}';
        });

        // 버튼 비활성화 처리
        firstPageBtn.disabled = ${paging.currentPage == 1};
        prevPageBtn.disabled = ${paging.currentPage == 1};
        nextPageBtn.disabled = ${paging.currentPage == paging.totalPages};
        lastPageBtn.disabled = ${paging.currentPage == paging.totalPages};
    });
</script>
</body>
</html>