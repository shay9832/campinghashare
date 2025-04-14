<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 결제 정보 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-payment.css">
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

    <!-- 콘텐츠 영역 -->
    <div id="content">
        <!-- 콘텐츠 헤더 -->
        <div class="content-header">
            <h2>결제 정보 조회</h2>
        </div>

        <!-- 검색 영역 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select id="search-type" name="searchType">
                <option value="nickname">회원 닉네임</option>
                <option value="method">결제방법</option>
                <option value="amount">결제금액</option>
            </select>

            <span>결제방법</span>
            <select id="payment-method" name="paymentMethod">
                <option value="all">전체</option>
                <option value="bank">무통장입금</option>
                <option value="card">신용카드</option>
                <option value="mobile">휴대폰결제</option>
                <option value="kakao">카카오페이</option>
                <option value="naver">네이버페이</option>
            </select>

            <span>결제상태</span>
            <select id="payment-status" name="paymentStatus">
                <option value="all">전체</option>
                <option value="complete">결제완료</option>
                <option value="cancel">결제취소</option>
                <option value="pending">결제대기</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date" id="start-date" name="startDate">
                <span>~</span>
                <input type="date" id="end-date" name="endDate">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" placeholder="검색어 입력" id="search-keyword" name="keyword">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" value="검색하기" id="search-btn">
            </div>
        </div>

        <!-- 결제 정보 요약 -->
        <div class="payment-count">
            <div class="payment-all">
                <span>총 결제 : <c:out value="${totalPayments}"/>건 (₩<c:out value="${totalAmount}"/>)</span>
            </div>
            <div class="payment-rental">
                <span>렌탈 결제 : <c:out value="${rentalPayments}"/>건 (₩<c:out value="${rentalAmount}"/>)</span>
            </div>
            <div class="payment-storage">
                <span>보관 결제 : <c:out value="${storagePayments}"/>건 (₩<c:out value="${storageAmount}"/>)</span>
            </div>
            <div class="payment-storen">
                <span>스토렌 결제 : <c:out value="${storenPayments}"/>건 (₩<c:out value="${storenAmount}"/>)</span>
            </div>
        </div>

        <!-- 결제유형 토글 스위치 -->
        <div class="toggle-container">
            <div class="toggle-button-group">
                <button type="button" class="toggle-button active" data-type="all">전체 결제</button>
                <button type="button" class="toggle-button" data-type="rental">렌탈 결제</button>
                <button type="button" class="toggle-button" data-type="storage">보관 결제</button>
                <button type="button" class="toggle-button" data-type="storen">스토렌 결제</button>
            </div>
        </div>

        <!-- 전체 선택 체크박스 -->
        <div class="select-all-checkbox">
            <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
        </div>

        <!-- 결제 목록 테이블 -->
        <div class="payment-table">
            <table>
                <tr>
                    <!-- 테이블 헤더 -->
                    <th class="col-select"><input type="checkbox"></th>
                    <th class="col-payment-id">결제 ID</th>
                    <th class="col-nickname">회원 닉네임</th>
                    <th class="col-method">결제 방법</th>
                    <th class="col-amount">결제 금액</th>
                    <th class="col-date">결제 일자</th>
                    <th class="col-cancel-date">취소 일자</th>
                    <th class="col-cancel-reason">취소 사유</th>
                    <th class="col-payment-type">결제 유형</th>
                    <th class="col-status">상태</th>
                    <th class="col-actions">관리</th>
                </tr>

                <!-- 결제 데이터 행 - c:forEach로 데이터베이스에서 가져온 데이터 출력 -->
                <c:forEach var="payment" items="${paymentList}">
                    <tr>
                        <td class="col-select"><input type="checkbox" value="${payment.paymentId}"></td>
                        <td>${payment.paymentId}</td>
                        <td>${payment.memberNickname}</td>
                        <td>${payment.paymentMethod}</td>
                        <td>₩${payment.formattedAmount}</td>
                        <td>${payment.paymentDate}</td>
                        <td>${payment.cancelDate != null ? payment.cancelDate : '-'}</td>
                        <td>${payment.cancelReason != null ? payment.cancelReason : '-'}</td>
                        <td>
                            <span class="type-badge ${payment.paymentType == '렌탈' ? 'type-rental' : payment.paymentType == '보관' ? 'type-storage' : 'type-storen'}">
                                    ${payment.paymentType}
                            </span>
                        </td>
                        <td>
                            <span class="status-badge ${payment.status == '결제완료' ? 'status-complete' : payment.status == '결제취소' ? 'status-cancel' : 'status-pending'}">
                                    ${payment.status}
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-primary action-btn detail-btn"
                                    data-id="${payment.paymentId}"
                                    data-rental-id="${payment.rentalId}"
                                    data-storage-id="${payment.storageId}"
                                    data-storen-id="${payment.storenId}"
                                    data-storen-rental-id="${payment.storenRentalId}">상세</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <button class="page-btn first-page" onclick="goToPage(1)">&laquo;</button>
                <button class="page-btn prev-page" onclick="goToPage(${currentPage - 1})">&lt;</button>
            </c:if>

            <div class="page-numbers">
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <button class="page-btn ${i == currentPage ? 'active' : ''}" onclick="goToPage(${i})">${i}</button>
                </c:forEach>
            </div>

            <c:if test="${currentPage < totalPages}">
                <button class="page-btn next-page" onclick="goToPage(${currentPage + 1})">&gt;</button>
                <button class="page-btn last-page" onclick="goToPage(${totalPages})">&raquo;</button>
            </c:if>
        </div>

        <!-- 결제 상세 정보 모달 -->
        <div id="payment-detail-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>결제 상세 정보</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="payment-form">
                        <div class="form-group">
                            <label for="payment-id">결제 ID</label>
                            <input type="text" id="payment-id" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="member-nickname">회원 닉네임</label>
                            <input type="text" id="member-nickname" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="payment-method">결제 방법</label>
                            <input type="text" id="payment-method-detail" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="payment-amount">결제 금액</label>
                            <input type="text" id="payment-amount" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="payment-date">결제 일자</label>
                            <input type="text" id="payment-date" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="payment-type">결제 유형</label>
                            <input type="text" id="payment-type" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="payment-status-detail">결제 상태</label>
                            <select id="payment-status-detail" class="form-control">
                                <option value="결제완료">결제완료</option>
                                <option value="결제취소">결제취소</option>
                                <option value="결제대기">결제대기</option>
                            </select>
                        </div>
                        <div class="form-group" id="cancel-date-group" style="display: none;">
                            <label for="cancel-date">취소 일자</label>
                            <input type="datetime-local" id="cancel-date" class="form-control">
                        </div>
                        <div class="form-group" id="cancel-reason-group" style="display: none;">
                            <label for="cancel-reason">취소 사유</label>
                            <textarea id="cancel-reason" class="form-control" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="related-id">관련 ID</label>
                            <div id="related-id" style="padding: 10px; background-color: #f9f9f9; border-radius: 4px;">
                                <div id="storage-id-group" style="display: none; margin-bottom: 10px;">
                                    <strong>보관 ID:</strong> <span id="storage-id-value">-</span>
                                </div>
                                <div id="storen-id-group" style="display: none; margin-bottom: 10px;">
                                    <strong>스토렌 ID:</strong> <span id="storen-id-value">-</span>
                                </div>
                                <div id="rental-id-group" style="display: none; margin-bottom: 10px;">
                                    <strong>렌탈 ID:</strong> <span id="rental-id-value">-</span>
                                </div>
                                <div id="storen-rental-id-group" style="display: none;">
                                    <strong>스토렌렌탈 ID:</strong> <span id="storen-rental-id-value">-</span>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-danger" id="cancel-payment-btn">결제취소</button>
                            <button type="button" class="btn btn-danger" id="close-modal-btn">닫기</button>
                            <button type="submit" class="btn btn-primary" id="save-payment-btn">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 결제취소 확인 모달 -->
        <div id="cancel-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>결제 취소 확인</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <p id="cancel-message" style="margin-bottom: 25px; line-height: 1.5; color: #555;">선택한 결제를 정말로 취소하시겠습니까? 이 작업은 되돌릴 수 없습니다.</p>
                    <div class="form-group">
                        <label for="confirm-cancel-reason">취소 사유</label>
                        <textarea id="confirm-cancel-reason" class="form-control" rows="3" placeholder="취소 사유를 입력해주세요"></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-primary" id="cancel-confirm-btn">취소</button>
                        <button type="button" class="btn btn-danger" id="confirm-cancel-btn">결제취소 확정</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- JSP 부분은 생략 --%>

<script>
    // 컨텍스트 경로 변수 설정 - AJAX 요청에 사용
    const contextPath = '${pageContext.request.contextPath}';

    // 문서 로드 완료 시 실행
    document.addEventListener('DOMContentLoaded', function() {
        // 좌측 메뉴 기능 초기화
        initLeftMenu();

        // 모달 관련 기능 초기화
        initModals();

        // 상세보기 버튼 이벤트 리스너 설정
        setupDetailButtonListeners();

        // 결제 상태 변경 핸들러 설정
        initPaymentStatusHandler();

        // 토글 버튼 이벤트 초기화
        initToggleButtons();

        // 체크박스 전체 선택 기능 초기화
        initCheckboxes();

        // 검색 기능 초기화
        initSearchFeature();
    });

    /**
     * 좌측 메뉴 기능 초기화
     */
    function initLeftMenu() {
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
            if (submenu) {
                submenu.style.maxHeight = submenu.scrollHeight + 'px';
            }
        });

        // 서브메뉴 버튼 클릭 처리
        document.querySelectorAll('.submenu-btn').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault(); // 기본 동작 중지
                const form = this.closest('form');
                if (form) {
                    try {
                        form.submit();
                    } catch (error) {
                        console.error('폼 제출 중 오류 발생:', error);
                    }
                }
            });
        });
    }

    /**
     * 모달 관련 기능 초기화
     */
    function initModals() {
        const paymentDetailModal = document.getElementById('payment-detail-modal');
        const cancelModal = document.getElementById('cancel-modal');
        const closeModalButtons = document.querySelectorAll('.close-modal');

        // 모달 닫기 버튼
        closeModalButtons.forEach(button => {
            button.addEventListener('click', function() {
                paymentDetailModal.style.display = 'none';
                cancelModal.style.display = 'none';
            });
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', function(event) {
            if (event.target === paymentDetailModal) {
                paymentDetailModal.style.display = 'none';
            }
            if (event.target === cancelModal) {
                cancelModal.style.display = 'none';
            }
        });

        // 닫기 버튼 클릭 시 모달 닫기
        document.getElementById('close-modal-btn').addEventListener('click', function() {
            paymentDetailModal.style.display = 'none';
        });

        // 결제 취소 버튼 클릭 시 확인 모달 표시
        document.getElementById('cancel-payment-btn').addEventListener('click', function() {
            const paymentId = document.getElementById('payment-id').value;
            const amount = document.getElementById('payment-amount').value;
            const nickname = document.getElementById('member-nickname').value;

            document.getElementById('cancel-message').textContent =
                `${nickname} 회원님의 ${amount} 결제(ID: ${paymentId})를 취소하시겠습니까? 이 작업은 되돌릴 수 없습니다.`;

            paymentDetailModal.style.display = 'none';
            cancelModal.style.display = 'block';
        });

        // 결제 취소 확정 버튼 클릭 시 처리
        document.getElementById('confirm-cancel-btn').addEventListener('click', function() {
            const reason = document.getElementById('confirm-cancel-reason').value;
            const paymentId = document.getElementById('payment-id').value;

            if (!reason.trim()) {
                alert('취소 사유를 입력해주세요.');
                return;
            }

            // AJAX 요청으로 결제 취소 처리
            fetch(contextPath + '/admin-cancelPayUpdate.action', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `paymentId=${paymentId}&cancelReason=${encodeURIComponent(reason)}`
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('결제가 성공적으로 취소되었습니다.');
                        location.reload();
                    } else {
                        alert('결제 취소에 실패했습니다: ' + data.message);
                    }
                    cancelModal.style.display = 'none';
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('결제 취소 중 오류가 발생했습니다.');
                    cancelModal.style.display = 'none';
                });
        });

        // 취소 모달 닫기 버튼
        document.getElementById('cancel-confirm-btn').addEventListener('click', function() {
            cancelModal.style.display = 'none';
        });
    }

    /**
     * 상세보기 버튼 이벤트 리스너 설정
     */
    function setupDetailButtonListeners() {
        const detailButtons = document.querySelectorAll('.detail-btn');
        detailButtons.forEach(button => {
            button.addEventListener('click', function() {
                const row = this.closest('tr');
                const paymentId = row.cells[1].textContent;
                const nickname = row.cells[2].textContent;
                const method = row.cells[3].textContent;
                const amount = row.cells[4].textContent;
                const date = row.cells[5].textContent;
                const cancelDate = row.cells[6].textContent;
                const cancelReason = row.cells[7].textContent;
                const paymentType = row.cells[8].querySelector('.type-badge').textContent;
                const status = row.cells[9].querySelector('.status-badge').textContent;

                // 관련 ID 가져오기
                const rentalId = this.getAttribute('data-rental-id');
                const storageId = this.getAttribute('data-storage-id');
                const storenId = this.getAttribute('data-storen-id');
                const storenRentalId = this.getAttribute('data-storen-rental-id');

                // 모달 폼에 데이터 설정
                document.getElementById('payment-id').value = paymentId;
                document.getElementById('member-nickname').value = nickname;
                document.getElementById('payment-method-detail').value = method;
                document.getElementById('payment-amount').value = amount;
                document.getElementById('payment-date').value = date;
                document.getElementById('payment-type').value = paymentType;
                document.getElementById('payment-status-detail').value = status;

                // 관련 ID 표시 설정
                document.getElementById('storage-id-group').style.display = storageId && storageId !== '' ? 'block' : 'none';
                document.getElementById('storage-id-value').textContent = storageId && storageId !== '' ? storageId : '-';

                document.getElementById('storen-id-group').style.display = storenId && storenId !== '' ? 'block' : 'none';
                document.getElementById('storen-id-value').textContent = storenId && storenId !== '' ? storenId : '-';

                document.getElementById('rental-id-group').style.display = rentalId && rentalId !== '' ? 'block' : 'none';
                document.getElementById('rental-id-value').textContent = rentalId && rentalId !== '' ? rentalId : '-';

                document.getElementById('storen-rental-id-group').style.display = storenRentalId && storenRentalId !== '' ? 'block' : 'none';
                document.getElementById('storen-rental-id-value').textContent = storenRentalId && storenRentalId !== '' ? storenRentalId : '-';

                // 취소 관련 필드 설정
                const cancelDateGroup = document.getElementById('cancel-date-group');
                const cancelReasonGroup = document.getElementById('cancel-reason-group');

                if (status === '결제취소') {
                    cancelDateGroup.style.display = 'block';
                    cancelReasonGroup.style.display = 'block';

                    // 취소 일자 설정
                    if (cancelDate !== '-') {
                        const cancelDateObj = new Date(cancelDate);
                        const formattedDate = cancelDateObj.toISOString().slice(0, 16);
                        document.getElementById('cancel-date').value = formattedDate;
                    }

                    document.getElementById('cancel-reason').value = cancelReason !== '-' ? cancelReason : '';
                } else {
                    cancelDateGroup.style.display = 'none';
                    cancelReasonGroup.style.display = 'none';
                }

                // 모달 표시
                document.getElementById('payment-detail-modal').style.display = 'block';
            });
        });
    }

    /**
     * 결제 상태 변경 핸들러 초기화
     */
    function initPaymentStatusHandler() {
        // 결제 상태 변경 시 취소 관련 필드 표시/숨김
        document.getElementById('payment-status-detail').addEventListener('change', function() {
            const cancelDateGroup = document.getElementById('cancel-date-group');
            const cancelReasonGroup = document.getElementById('cancel-reason-group');

            if (this.value === '결제취소') {
                cancelDateGroup.style.display = 'block';
                cancelReasonGroup.style.display = 'block';
            } else {
                cancelDateGroup.style.display = 'none';
                cancelReasonGroup.style.display = 'none';
            }
        });

        // 결제 폼 제출 처리
        document.getElementById('payment-form').addEventListener('submit', function(event) {
            event.preventDefault();

            const paymentId = document.getElementById('payment-id').value;
            const status = document.getElementById('payment-status-detail').value;
            let cancelDate = null;
            let cancelReason = null;

            if (status === '결제취소') {
                cancelDate = document.getElementById('cancel-date').value;
                cancelReason = document.getElementById('cancel-reason').value;

                if (!cancelReason.trim()) {
                    alert('취소 사유를 입력해주세요.');
                    return;
                }
            }

            /// 결제 정보 수정 처리
            document.getElementById('payment-form').addEventListener('submit', function(event) {
                event.preventDefault();

                // 폼 데이터 가져오기
                const paymentId = document.getElementById('payment-id').value;
                const status = document.getElementById('payment-status-detail').value;
                const cancelDate = document.getElementById('cancel-date').value;
                const cancelReason = document.getElementById('cancel-reason').value;

                // FormData 객체 생성
                const formData = new FormData();
                formData.append('paymentId', paymentId);
                formData.append('status', status);

                // 취소 상태인 경우 추가 정보 포함
                if (status === '결제취소') {
                    if (!cancelReason.trim()) {
                        alert('취소 사유를 입력해주세요.');
                        return;
                    }
                    formData.append('cancelReason', cancelReason);
                    if (cancelDate) {
                        formData.append('cancelDate', cancelDate);
                    }
                }

                // AJAX 요청 설정
                const xhr = new XMLHttpRequest();
                xhr.open('POST', contextPath + '/admin-updatePayment.action', true);

                // 응답 처리
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            alert('결제 정보가 성공적으로 수정되었습니다.');
                            location.reload();
                        } else {
                            alert('결제 정보 수정에 실패했습니다: ' + response.message);
                        }
                        document.getElementById('payment-detail-modal').style.display = 'none';
                    } else {
                        alert('서버 오류가 발생했습니다.');
                        console.error('Server Error:', xhr.status);
                    }
                };

                // 오류 처리
                xhr.onerror = function() {
                    alert('결제 정보 수정 중 오류가 발생했습니다.');
                    console.error('Request Error');
                    document.getElementById('payment-detail-modal').style.display = 'none';
                };

                // 요청 전송
                xhr.send(new URLSearchParams(formData));
            });
        });
    }

    /**
     * 토글 버튼 이벤트 초기화
     */
    function initToggleButtons() {
        const toggleButtons = document.querySelectorAll('.toggle-button');
        toggleButtons.forEach(button => {
            button.addEventListener('click', function() {
                toggleButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');

                const type = this.getAttribute('data-type');

                // AJAX로 해당 유형의 결제 데이터 불러오기
                fetch(`${contextPath}/admin-getPaymentsByType.action?type=${type}`)
                    .then(response => response.json())
                    .then(data => {
                        updatePaymentTable(data);
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('결제 데이터를 불러오는 중 오류가 발생했습니다.');
                    });
            });
        });
    }

    /**
     * 결제 테이블 업데이트 함수
     */
    function updatePaymentTable(data) {
        // 기존 테이블 행 제거 (헤더 제외)
        const tableRows = document.querySelectorAll('.payment-table table tr:not(:first-child)');
        tableRows.forEach(row => row.remove());

        // 테이블 참조
        const table = document.querySelector('.payment-table table');

        // 데이터로 테이블 행 생성
        data.payments.forEach(payment => {
            const row = table.insertRow();

            // 체크박스 셀
            const checkCell = row.insertCell();
            checkCell.className = 'col-select';
            checkCell.innerHTML = `<input type="checkbox" value="${payment.paymentId}">`;

            // 결제 ID
            const idCell = row.insertCell();
            idCell.textContent = payment.paymentId;

            // 회원 닉네임
            const nicknameCell = row.insertCell();
            nicknameCell.textContent = payment.memberNickname;

            // 결제 방법
            const methodCell = row.insertCell();
            methodCell.textContent = payment.paymentMethod;

            // 결제 금액
            const amountCell = row.insertCell();
            amountCell.textContent = `₩${payment.formattedAmount}`;

            // 결제 일자
            const dateCell = row.insertCell();
            dateCell.textContent = payment.paymentDate;

            // 취소 일자
            const cancelDateCell = row.insertCell();
            cancelDateCell.textContent = payment.cancelDate || '-';

            // 취소 사유
            const cancelReasonCell = row.insertCell();
            cancelReasonCell.textContent = payment.cancelReason || '-';

            // 결제 유형
            const paymentTypeCell = row.insertCell();
            let typeClass = '';
            switch(payment.paymentType) {
                case '렌탈':
                    typeClass = 'type-rental';
                    break;
                case '보관':
                    typeClass = 'type-storage';
                    break;
                case '스토렌':
                    typeClass = 'type-storen';
                    break;
            }
            paymentTypeCell.innerHTML = `<span class="type-badge ${typeClass}">${payment.paymentType}</span>`;

            // 결제 상태
            const statusCell = row.insertCell();
            let statusClass = '';
            switch(payment.status) {
                case '결제완료':
                    statusClass = 'status-complete';
                    break;
                case '결제취소':
                    statusClass = 'status-cancel';
                    break;
                case '결제대기':
                    statusClass = 'status-pending';
                    break;
            }
            statusCell.innerHTML = `<span class="status-badge ${statusClass}">${payment.status}</span>`;

            // 관리 버튼
            const actionsCell = row.insertCell();
            actionsCell.innerHTML = `<button class="btn btn-primary action-btn detail-btn"
                data-id="${payment.paymentId}"
                data-rental-id="${payment.rentalId || ''}"
                data-storage-id="${payment.storageId || ''}"
                data-storen-id="${payment.storenId || ''}"
                data-storen-rental-id="${payment.storenRentalId || ''}">상세</button>`;
        });

        // 상세보기 버튼에 이벤트 리스너 재설정
        setupDetailButtonListeners();

        // 통계 업데이트
        updateStats(data.stats);
    }

    /**
     * 통계 정보 업데이트 함수
     */
    function updateStats(stats) {
        document.querySelector('.payment-all span').textContent = `총 결제 : ${stats.totalCount}건 (₩${stats.totalAmount})`;
        document.querySelector('.payment-rental span').textContent = `렌탈 결제 : ${stats.rentalCount}건 (₩${stats.rentalAmount})`;
        document.querySelector('.payment-storage span').textContent = `보관 결제 : ${stats.storageCount}건 (₩${stats.storageAmount})`;
        document.querySelector('.payment-storen span').textContent = `스토렌 결제 : ${stats.storenCount}건 (₩${stats.storenAmount})`;
    }

    /**
     * 체크박스 전체 선택 기능 초기화
     */
    function initCheckboxes() {
        // 테이블 헤더의 체크박스
        document.querySelector('th.col-select input[type="checkbox"]').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('td.col-select input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            document.getElementById('selectAll').checked = this.checked;
        });

        // 상단 전체 선택 체크박스
        document.getElementById('selectAll').addEventListener('click', function() {
            const headerCheckbox = document.querySelector('th.col-select input[type="checkbox"]');
            headerCheckbox.checked = this.checked;

            const checkboxes = document.querySelectorAll('td.col-select input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
    }

    /**
     * 검색 기능 초기화
     */
    function initSearchFeature() {
        document.getElementById('search-btn').addEventListener('click', function() {
            const searchType = document.getElementById('search-type').value;
            const paymentMethod = document.getElementById('payment-method').value;
            const paymentStatus = document.getElementById('payment-status').value;
            const startDate = document.getElementById('start-date').value;
            const endDate = document.getElementById('end-date').value;
            const keyword = document.getElementById('search-keyword').value;

            // 검색 매개변수 구성
            const params = new URLSearchParams();
            params.append('searchType', searchType);
            params.append('paymentMethod', paymentMethod);
            params.append('paymentStatus', paymentStatus);

            if (startDate) params.append('startDate', startDate);
            if (endDate) params.append('endDate', endDate);
            if (keyword) params.append('keyword', keyword);

            // AJAX 검색 요청
            fetch(`${contextPath}/admin-searchPayments.action?${params.toString()}`)
                .then(response => response.json())
                .then(data => {
                    updatePaymentTable(data);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('결제 데이터를 검색하는 중 오류가 발생했습니다.');
                });
        });
    }

    /**
     * 페이지 이동 함수
     */
    function goToPage(page) {
        try {
            const currentUrl = new URL(window.location);
            currentUrl.searchParams.set('page', page);
            window.location.href = currentUrl.toString();
        } catch (error) {
            console.error('페이지 이동 중 오류 발생:', error);
            // 폴백 방식 사용
            window.location.href = `${contextPath}/admin-payment.action?page=${page}`;
        }
    }
</script>