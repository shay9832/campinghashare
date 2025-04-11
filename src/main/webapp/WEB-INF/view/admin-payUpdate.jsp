<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 결제 정보 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-payUpdate.css">
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
        <div class="submenu" style="max-height: 200px;">
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
            <select id="search-type">
                <option>회원 닉네임</option>
                <option>결제방법</option>
                <option>결제금액</option>
            </select>

            <span>결제방법</span>
            <select id="payment-method">
                <option>전체</option>
                <option>무통장입금</option>
                <option>신용카드</option>
            </select>

            <span>결제상태</span>
            <select id="payment-status">
                <option>전체</option>
                <option>결제완료</option>
                <option>결제취소</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date" id="start-date">
                <span>~</span>
                <input type="date" id="end-date">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" placeholder="검색어 입력" id="search-keyword">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" value="검색하기" id="search-btn">
            </div>
        </div>

        <!-- 결제 정보 요약 -->
        <div class="payment-count">
            <div class="payment-all">
                <span>총 결제 : 1,254건 (₩128,456,789)</span>
            </div>
            <div class="payment-rental">
                <span>렌탈 결제 : 587건 (₩63,456,000)</span>
            </div>
            <div class="payment-storage">
                <span>보관 결제 : 342건 (₩34,200,000)</span>
            </div>
            <div class="payment-storen">
                <span>스토렌 결제 : 325건 (₩30,800,789)</span>
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
                    <th class="col-storage-id">보관 ID</th>
                    <th class="col-storen-id">스토렌 ID</th>
                    <th class="col-rental-id">렌탈 ID</th>
                    <th class="col-storen-rental-id">스토렌렌탈 ID</th>
                    <th class="col-payment-type">결제 유형</th>
                    <th class="col-status">상태</th>
                    <th class="col-actions">관리</th>
                </tr>

                <!-- 결제 데이터 행 (기본 데이터) -->
                <tr>
                    <td class="col-select"><input type="checkbox"></td>
                    <td>PAY001</td>
                    <td>카메라매니아</td>
                    <td>신용카드</td>
                    <td>₩150,000</td>
                    <td>2023-04-15 14:23:45</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>RENT123</td>
                    <td>-</td>
                    <td><span class="type-badge type-rental">렌탈</span></td>
                    <td><span class="status-badge status-complete">결제완료</span></td>
                    <td><button class="btn btn-primary action-btn detail-btn">상세</button></td>
                </tr>
            </table>
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
                            <label for="payment-status">결제 상태</label>
                            <select id="payment-status-detail" class="form-control">
                                <option>결제완료</option>
                                <option>결제취소</option>
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

    // 모달 관련 변수
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

    document.getElementById('cancel-confirm-btn').addEventListener('click', function() {
        cancelModal.style.display = 'none';
    });

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

    // 상세보기 버튼 클릭 시 모달 표시
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
            const storageId = row.cells[8].textContent;
            const storenId = row.cells[9].textContent;
            const rentalId = row.cells[10].textContent;
            const storenRentalId = row.cells[11].textContent;
            const paymentType = row.cells[12].querySelector('.type-badge').textContent;
            const status = row.cells[13].querySelector('.status-badge').textContent;

            // 모달 폼에 데이터 설정
            document.getElementById('payment-id').value = paymentId;
            document.getElementById('member-nickname').value = nickname;
            document.getElementById('payment-method-detail').value = method;
            document.getElementById('payment-amount').value = amount;
            document.getElementById('payment-date').value = date;
            document.getElementById('payment-type').value = paymentType;
            document.getElementById('payment-status-detail').value = status;

            // 관련 ID 표시 설정
            document.getElementById('storage-id-group').style.display = storageId !== '-' ? 'block' : 'none';
            document.getElementById('storage-id-value').textContent = storageId;

            document.getElementById('storen-id-group').style.display = storenId !== '-' ? 'block' : 'none';
            document.getElementById('storen-id-value').textContent = storenId;

            document.getElementById('rental-id-group').style.display = rentalId !== '-' ? 'block' : 'none';
            document.getElementById('rental-id-value').textContent = rentalId;

            document.getElementById('storen-rental-id-group').style.display = storenRentalId !== '-' ? 'block' : 'none';
            document.getElementById('storen-rental-id-value').textContent = storenRentalId;

            // 취소 관련 필드 설정
            const cancelDateGroup = document.getElementById('cancel-date-group');
            const cancelReasonGroup = document.getElementById('cancel-reason-group');

            if (status === '결제취소') {
                cancelDateGroup.style.display = 'block';
                cancelReasonGroup.style.display = 'block';

                // 취소 일자 설정 (형식 변환 필요)
                if (cancelDate !== '-') {
                    // 실제 구현 시 날짜 형식 변환 필요
                    document.getElementById('cancel-date').value = '2023-04-15T14:23:45';
                }

                document.getElementById('cancel-reason').value = cancelReason !== '-' ? cancelReason : '';
            } else {
                cancelDateGroup.style.display = 'none';
                cancelReasonGroup.style.display = 'none';
            }

            // 모달 표시
            paymentDetailModal.style.display = 'block';
        });
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

        if (!reason.trim()) {
            alert('취소 사유를 입력해주세요.');
            return;
        }

        // 여기에 결제 취소 처리 코드 작성
        // 실제 환경에서는 서버로 취소 요청을 보내는 AJAX 구현

        console.log({
            action: '결제 취소',
            reason: reason
        });

        // 모달 닫기
        cancelModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert('결제가 성공적으로 취소되었습니다.');

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 결제 폼 제출 처리
    document.getElementById('payment-form').addEventListener('submit', function(event) {
        event.preventDefault();

        // 여기에 결제 정보 수정 처리 코드 작성
        // 실제 환경에서는 서버로 데이터를 전송하는 AJAX 요청을 구현

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

        console.log({
            action: '결제 정보 수정',
            paymentId,
            status,
            cancelDate,
            cancelReason
        });

        // 모달 닫기
        paymentDetailModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert('결제 정보가 성공적으로 수정되었습니다.');

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 토글 버튼 이벤트 처리
    const toggleButtons = document.querySelectorAll('.toggle-button');
    toggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            toggleButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            const type = this.getAttribute('data-type');
            showFilteredPayments(type);
        });
    });

    // 결제 필터링 및 테이블 업데이트 함수
    function showFilteredPayments(type) {
        // 기존 테이블 행 제거 (헤더 제외)
        const tableRows = document.querySelectorAll('.payment-table table tr:not(:first-child)');
        tableRows.forEach(row => row.remove());

        // 테이블 참조
        const table = document.querySelector('.payment-table table');

        // 필터링에 따른 데이터
        let filteredData = [];

        switch(type) {
            case 'all':
                // 전체 결제 데이터
                filteredData = [
                    {
                        id: 'PAY001',
                        nickname: '카메라매니아',
                        method: '신용카드',
                        amount: '₩150,000',
                        date: '2023-04-15 14:23:45',
                        cancelDate: '-',
                        cancelReason: '-',
                        storageId: '-',
                        storenId: '-',
                        rentalId: 'RENT123',
                        storenRentalId: '-',
                        paymentType: '렌탈',
                        status: '결제완료'
                    }
                ];
                break;

            case 'rental':
                // 렌탈 결제 데이터
                filteredData = [
                    {
                        id: 'PAY002',
                        nickname: '촬영장인',
                        method: '신용카드',
                        amount: '₩250,000',
                        date: '2023-04-16 10:15:32',
                        cancelDate: '-',
                        cancelReason: '-',
                        storageId: '-',
                        storenId: '-',
                        rentalId: 'RENT456',
                        storenRentalId: '-',
                        paymentType: '렌탈',
                        status: '결제완료'
                    }
                ];
                break;

            case 'storage':
                // 보관 결제 데이터
                filteredData = [
                    {
                        id: 'PAY003',
                        nickname: '장비수집가',
                        method: '무통장입금',
                        amount: '₩100,000',
                        date: '2023-04-14 09:30:00',
                        cancelDate: '-',
                        cancelReason: '-',
                        storageId: 'STOR789',
                        storenId: '-',
                        rentalId: '-',
                        storenRentalId: '-',
                        paymentType: '보관',
                        status: '결제완료'
                    }
                ];
                break;

            case 'storen':
                // 스토렌 결제 데이터
                filteredData = [
                    {
                        id: 'PAY004',
                        nickname: '대여킹',
                        method: '무통장입금',
                        amount: '₩180,000',
                        date: '2023-04-13 16:45:20',
                        cancelDate: '-',
                        cancelReason: '-',
                        storageId: '-',
                        storenId: 'STN101',
                        rentalId: '-',
                        storenRentalId: 'STR202',
                        paymentType: '스토렌',
                        status: '결제완료'
                    }
                ];
                break;
        }

        // 필터링된 데이터로 테이블 행 생성
        filteredData.forEach(payment => {
            const row = table.insertRow();

            // 체크박스 셀
            const checkCell = row.insertCell();
            checkCell.className = 'col-select';
            checkCell.innerHTML = '<input type="checkbox">';

            // 결제 ID
            const idCell = row.insertCell();
            idCell.textContent = payment.id;

            // 회원 닉네임
            const nicknameCell = row.insertCell();
            nicknameCell.textContent = payment.nickname;

            // 결제 방법
            const methodCell = row.insertCell();
            methodCell.textContent = payment.method;

            // 결제 금액
            const amountCell = row.insertCell();
            amountCell.textContent = payment.amount;

            // 결제 일자
            const dateCell = row.insertCell();
            dateCell.textContent = payment.date;

            // 취소 일자
            const cancelDateCell = row.insertCell();
            cancelDateCell.textContent = payment.cancelDate;

            // 취소 사유
            const cancelReasonCell = row.insertCell();
            cancelReasonCell.textContent = payment.cancelReason;

            // 보관 ID
            const storageIdCell = row.insertCell();
            storageIdCell.textContent = payment.storageId;

            // 스토렌 ID
            const storenIdCell = row.insertCell();
            storenIdCell.textContent = payment.storenId;

            // 렌탈 ID
            const rentalIdCell = row.insertCell();
            rentalIdCell.textContent = payment.rentalId;

            // 스토렌렌탈 ID
            const storenRentalIdCell = row.insertCell();
            storenRentalIdCell.textContent = payment.storenRentalId;

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
            actionsCell.innerHTML = '<button class="btn btn-primary action-btn detail-btn">상세</button>';
        });

        // 상세보기 버튼에 이벤트 리스너 재설정
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
                const storageId = row.cells[8].textContent;
                const storenId = row.cells[9].textContent;
                const rentalId = row.cells[10].textContent;
                const storenRentalId = row.cells[11].textContent;
                const paymentType = row.cells[12].querySelector('.type-badge').textContent;
                const status = row.cells[13].querySelector('.status-badge').textContent;

                // 모달 폼에 데이터 설정
                document.getElementById('payment-id').value = paymentId;
                document.getElementById('member-nickname').value = nickname;
                document.getElementById('payment-method-detail').value = method;
                document.getElementById('payment-amount').value = amount;
                document.getElementById('payment-date').value = date;
                document.getElementById('payment-type').value = paymentType;
                document.getElementById('payment-status-detail').value = status;

                // 관련 ID 표시 설정
                document.getElementById('storage-id-group').style.display = storageId !== '-' ? 'block' : 'none';
                document.getElementById('storage-id-value').textContent = storageId;

                document.getElementById('storen-id-group').style.display = storenId !== '-' ? 'block' : 'none';
                document.getElementById('storen-id-value').textContent = storenId;

                document.getElementById('rental-id-group').style.display = rentalId !== '-' ? 'block' : 'none';
                document.getElementById('rental-id-value').textContent = rentalId;

                document.getElementById('storen-rental-id-group').style.display = storenRentalId !== '-' ? 'block' : 'none';
                document.getElementById('storen-rental-id-value').textContent = storenRentalId;

                // 취소 관련 필드 설정
                const cancelDateGroup = document.getElementById('cancel-date-group');
                const cancelReasonGroup = document.getElementById('cancel-reason-group');

                if (status === '결제취소') {
                    cancelDateGroup.style.display = 'block';
                    cancelReasonGroup.style.display = 'block';

                    // 취소 일자 설정 (형식 변환 필요)
                    if (cancelDate !== '-') {
                        // 실제 구현 시 날짜 형식 변환 필요
                        document.getElementById('cancel-date').value = '2023-04-15T14:23:45';
                    }

                    document.getElementById('cancel-reason').value = cancelReason !== '-' ? cancelReason : '';
                } else {
                    cancelDateGroup.style.display = 'none';
                    cancelReasonGroup.style.display = 'none';
                }

                // 모달 표시
                paymentDetailModal.style.display = 'block';
            });
        });

        // 통계 업데이트
        updateStats(type);
    }

    // 통계 정보 업데이트 함수
    function updateStats(type) {
        const allCountElement = document.querySelector('.payment-all span');
        const rentalCountElement = document.querySelector('.payment-rental span');
        const storageCountElement = document.querySelector('.payment-storage span');
        const storenCountElement = document.querySelector('.payment-storen span');

        switch(type) {
            case 'all':
                allCountElement.textContent = '총 결제 : 1,254건 (₩128,456,789)';
                rentalCountElement.textContent = '렌탈 결제 : 587건 (₩63,456,000)';
                storageCountElement.textContent = '보관 결제 : 342건 (₩34,200,000)';
                storenCountElement.textContent = '스토렌 결제 : 325건 (₩30,800,789)';
                break;

            case 'rental':
                allCountElement.textContent = '총 결제 : 1,254건 (₩128,456,789)';
                rentalCountElement.textContent = '렌탈 결제 : 587건 (₩63,456,000) - 현재 표시';
                storageCountElement.textContent = '보관 결제 : 342건 (₩34,200,000)';
                storenCountElement.textContent = '스토렌 결제 : 325건 (₩30,800,789)';
                break;

            case 'storage':
                allCountElement.textContent = '총 결제 : 1,254건 (₩128,456,789)';
                rentalCountElement.textContent = '렌탈 결제 : 587건 (₩63,456,000)';
                storageCountElement.textContent = '보관 결제 : 342건 (₩34,200,000) - 현재 표시';
                storenCountElement.textContent = '스토렌 결제 : 325건 (₩30,800,789)';
                break;

            case 'storen':
                allCountElement.textContent = '총 결제 : 1,254건 (₩128,456,789)';
                rentalCountElement.textContent = '렌탈 결제 : 587건 (₩63,456,000)';
                storageCountElement.textContent = '보관 결제 : 342건 (₩34,200,000)';
                storenCountElement.textContent = '스토렌 결제 : 325건 (₩30,800,789) - 현재 표시';
                break;
        }
    }

    // 전체 선택 체크박스 기능
    document.querySelector('th.col-select input[type="checkbox"]').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('td.col-select input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    // selectAll 체크박스 기능
    document.getElementById('selectAll').addEventListener('click', function() {
        const headerCheckbox = document.querySelector('th.col-select input[type="checkbox"]');
        headerCheckbox.checked = this.checked;

        const checkboxes = document.querySelectorAll('td.col-select input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    // 검색 버튼 클릭 이벤트
    document.getElementById('search-btn').addEventListener('click', function() {
        const searchType = document.getElementById('search-type').value;
        const paymentMethod = document.getElementById('payment-method').value;
        const paymentStatus = document.getElementById('payment-status').value;
        const startDate = document.getElementById('start-date').value;
        const endDate = document.getElementById('end-date').value;
        const keyword = document.getElementById('search-keyword').value;

        // 실제 구현 시 검색 API 호출 코드 추가
        console.log({
            action: '결제 검색',
            searchType,
            paymentMethod,
            paymentStatus,
            startDate,
            endDate,
            keyword
        });

        // 예시로 렌탈 결제 데이터 표시
        const rentalButton = document.querySelector('.toggle-button[data-type="rental"]');
        rentalButton.click();
    });

    // 페이지 로드 시 기본 데이터 표시 (전체 결제)
    document.addEventListener('DOMContentLoaded', function() {
        showFilteredPayments('all');
    });
</script>
</body>
</html>