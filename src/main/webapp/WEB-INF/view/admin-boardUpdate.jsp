<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 게시판 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-boardUpdate.css">
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
            <h2>게시판 관리</h2>
        </div>

        <!-- 탭 메뉴 -->
        <div class="tabs">
            <button class="tab-btn active" data-tab="board-tab">게시판 관리</button>
            <button class="tab-btn" data-tab="header-tab">말머리 관리</button>
        </div>

        <!-- 게시판 관리 탭 콘텐츠 -->
        <div class="tab-content active" id="board-tab">
            <div style="margin-bottom: 15px; text-align: right;">
                <button class="btn btn-primary" id="add-board-btn">+ 게시판 추가</button>
            </div>

            <div class="board-table">
                <table>
                    <tr>
                        <th class="col-board-id">게시판 ID</th>
                        <th class="col-category">카테고리명</th>
                        <th class="col-admin-level">관리등급</th>
                        <th class="col-board-name">게시판명</th>
                        <th class="col-actions">관리</th>
                    </tr>
                    <tr>
                        <td>1001</td>
                        <td>공지사항</td>
                        <td><span class="admin-level-badge admin-level-3">최고관리자</span></td>
                        <td>공지사항</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-board-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-board-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>자유게시판</td>
                        <td><span class="admin-level-badge admin-level-1">일반관리자</span></td>
                        <td>자유롭게 대화하는 공간</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-board-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-board-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1003</td>
                        <td>질문과답변</td>
                        <td><span class="admin-level-badge admin-level-2">중간관리자</span></td>
                        <td>궁금한 내용을 질문하는 곳</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-board-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-board-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1004</td>
                        <td>장비리뷰</td>
                        <td><span class="admin-level-badge admin-level-1">일반관리자</span></td>
                        <td>장비 사용 후기</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-board-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-board-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1005</td>
                        <td>거래게시판</td>
                        <td><span class="admin-level-badge admin-level-2">중간관리자</span></td>
                        <td>장비 거래 게시판</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-board-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-board-btn">삭제</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- 말머리 관리 탭 콘텐츠 -->
        <div class="tab-content" id="header-tab">
            <div style="margin-bottom: 15px; text-align: right;">
                <button class="btn btn-primary" id="add-header-btn">+ 말머리 추가</button>
            </div>

            <div class="board-table">
                <table>
                    <tr>
                        <th class="col-header-id">말머리 ID</th>
                        <th class="col-board-id">게시판 ID</th>
                        <th class="col-board-name">게시판명</th>
                        <th class="col-header-name">말머리명</th>
                        <th class="col-actions">관리</th>
                    </tr>
                    <tr>
                        <td>201</td>
                        <td>1002</td>
                        <td>자유게시판</td>
                        <td>일상</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>202</td>
                        <td>1002</td>
                        <td>자유게시판</td>
                        <td>유머</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>203</td>
                        <td>1003</td>
                        <td>질문과답변</td>
                        <td>장비문의</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>204</td>
                        <td>1003</td>
                        <td>질문과답변</td>
                        <td>사용방법</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>205</td>
                        <td>1004</td>
                        <td>장비리뷰</td>
                        <td>카메라</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>206</td>
                        <td>1004</td>
                        <td>장비리뷰</td>
                        <td>렌즈</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>207</td>
                        <td>1004</td>
                        <td>장비리뷰</td>
                        <td>조명</td>
                        <td>
                            <button class="btn btn-primary action-btn edit-header-btn">수정</button>
                            <button class="btn btn-danger action-btn delete-header-btn">삭제</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- 게시판 추가/수정 모달 -->
        <div id="board-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="board-modal-title">게시판 추가</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="board-form">
                        <div class="form-group">
                            <label for="board-id">게시판 ID</label>
                            <input type="text" id="board-id" class="form-control" placeholder="자동 생성" disabled>
                        </div>
                        <div class="form-group">
                            <label for="board-category">카테고리명</label>
                            <input type="text" id="board-category" class="form-control" placeholder="카테고리 입력" required>
                        </div>
                        <div class="form-group">
                            <label for="board-admin-level">관리등급</label>
                            <select id="board-admin-level" class="form-control" required>
                                <option value="1">일반관리자</option>
                                <option value="2">중간관리자</option>
                                <option value="3">최고관리자</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="board-name">게시판명</label>
                            <input type="text" id="board-name" class="form-control" placeholder="게시판명 입력" required>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-danger" id="cancel-board-btn">취소</button>
                            <button type="submit" class="btn btn-primary" id="save-board-btn">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 말머리 추가/수정 모달 -->
        <div id="header-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="header-modal-title">말머리 추가</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="header-form">
                        <div class="form-group">
                            <label for="header-id">말머리 ID</label>
                            <input type="text" id="header-id" class="form-control" placeholder="자동 생성" disabled>
                        </div>
                        <div class="form-group">
                            <label for="header-board-id">게시판 선택</label>
                            <select id="header-board-id" class="form-control" required>
                                <option value="">게시판 선택</option>
                                <option value="1002">자유게시판</option>
                                <option value="1003">질문과답변</option>
                                <option value="1004">장비리뷰</option>
                                <option value="1005">거래게시판</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="header-name">말머리명</label>
                            <input type="text" id="header-name" class="form-control" placeholder="말머리명 입력" required>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-danger" id="cancel-header-btn">취소</button>
                            <button type="submit" class="btn btn-primary" id="save-header-btn">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 삭제 확인 모달 -->
        <div id="delete-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="delete-modal-title">삭제 확인</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <p id="delete-message" style="margin-bottom: 25px; line-height: 1.5; color: #555;">정말로 삭제하시겠습니까?</p>
                    <div class="form-actions">
                        <button type="button" class="btn btn-primary" id="cancel-delete-btn">취소</button>
                        <button type="button" class="btn btn-danger" id="confirm-delete-btn">삭제</button>
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

    // 탭 전환 기능
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 모든 탭 버튼에서 active 클래스 제거
            tabButtons.forEach(btn => btn.classList.remove('active'));
            // 현재 클릭한 버튼에 active 클래스 추가
            this.classList.add('active');

            // 모든 탭 콘텐츠 숨기기
            tabContents.forEach(content => content.classList.remove('active'));
            // 클릭한 탭에 해당하는 콘텐츠 표시
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // 모달 관련 기능
    const boardModal = document.getElementById('board-modal');
    const headerModal = document.getElementById('header-modal');
    const deleteModal = document.getElementById('delete-modal');
    const closeModalButtons = document.querySelectorAll('.close-modal');

    // 모달 닫기 버튼
    closeModalButtons.forEach(button => {
        button.addEventListener('click', function() {
            boardModal.style.display = 'none';
            headerModal.style.display = 'none';
            deleteModal.style.display = 'none';
        });
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        if (event.target === boardModal) {
            boardModal.style.display = 'none';
        }
        if (event.target === headerModal) {
            headerModal.style.display = 'none';
        }
        if (event.target === deleteModal) {
            deleteModal.style.display = 'none';
        }
    });

    // 취소 버튼 클릭 시 모달 닫기
    document.getElementById('cancel-board-btn').addEventListener('click', function() {
        boardModal.style.display = 'none';
    });

    document.getElementById('cancel-header-btn').addEventListener('click', function() {
        headerModal.style.display = 'none';
    });

    document.getElementById('cancel-delete-btn').addEventListener('click', function() {
        deleteModal.style.display = 'none';
    });

    // 게시판 폼 제출 처리
    document.getElementById('board-form').addEventListener('submit', function(event) {
        event.preventDefault();

        // 여기에 게시판 추가/수정 처리 코드 작성
        // 실제 환경에서는 서버로 데이터를 전송하는 AJAX 요청을 구현

        // 예시: 콘솔에 데이터 출력
        const boardId = document.getElementById('board-id').value;
        const category = document.getElementById('board-category').value;
        const adminLevel = document.getElementById('board-admin-level').value;
        const boardName = document.getElementById('board-name').value;

        console.log({
            action: boardId ? '게시판 수정' : '게시판 추가',
            boardId,
            category,
            adminLevel,
            boardName
        });

        // 모달 닫기
        boardModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert(boardId ? '게시판이 성공적으로 수정되었습니다.' : '게시판이 성공적으로 추가되었습니다.');

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 말머리 폼 제출 처리
    document.getElementById('header-form').addEventListener('submit', function(event) {
        event.preventDefault();

        // 여기에 말머리 추가/수정 처리 코드 작성
        // 실제 환경에서는 서버로 데이터를 전송하는 AJAX 요청을 구현

        // 예시: 콘솔에 데이터 출력
        const headerId = document.getElementById('header-id').value;
        const boardId = document.getElementById('header-board-id').value;
        const headerName = document.getElementById('header-name').value;

        console.log({
            action: headerId ? '말머리 수정' : '말머리 추가',
            headerId,
            boardId,
            headerName
        });

        // 모달 닫기
        headerModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert(headerId ? '말머리가 성공적으로 수정되었습니다.' : '말머리가 성공적으로 추가되었습니다.');

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 삭제 확인 버튼 클릭 시 처리
    document.getElementById('confirm-delete-btn').addEventListener('click', function() {
        const type = this.getAttribute('data-type');
        const id = this.getAttribute('data-id');

        // 여기에 삭제 처리 코드 작성
        // 실제 환경에서는 서버로 삭제 요청을 보내는 AJAX 구현

        console.log({
            action: `${type} 삭제`,
            id
        });

        // 모달 닫기
        deleteModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert(`${type == 'board' ? '게시판' : '말머리'}이(가) 성공적으로 삭제되었습니다.`);

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
    document.querySelectorAll('.menu-button.active').forEach(button => {
        const submenu = button.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
    });

    // 게시판 추가 버튼 클릭 시 모달 표시
    document.getElementById('add-board-btn').addEventListener('click', function() {
        document.getElementById('board-modal-title').textContent = '게시판 추가';
        document.getElementById('board-form').reset();
        boardModal.style.display = 'block';
    });

    // 말머리 추가 버튼 클릭 시 모달 표시
    document.getElementById('add-header-btn').addEventListener('click', function() {
        document.getElementById('header-modal-title').textContent = '말머리 추가';
        document.getElementById('header-form').reset();
        headerModal.style.display = 'block';
    });

    // 게시판 수정 버튼 클릭 시 모달 표시
    const editBoardButtons = document.querySelectorAll('.edit-board-btn');
    editBoardButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const boardId = row.cells[0].textContent;
            const category = row.cells[1].textContent;
            const adminLevel = row.querySelector('.admin-level-badge').classList.contains('admin-level-1') ? '1' :
                row.querySelector('.admin-level-badge').classList.contains('admin-level-2') ? '2' : '3';
            const boardName = row.cells[3].textContent;

            document.getElementById('board-modal-title').textContent = '게시판 수정';
            document.getElementById('board-id').value = boardId;
            document.getElementById('board-category').value = category;
            document.getElementById('board-admin-level').value = adminLevel;
            document.getElementById('board-name').value = boardName;
            boardModal.style.display = 'block';
        });
    });

    // 말머리 수정 버튼 클릭 시 모달 표시
    const editHeaderButtons = document.querySelectorAll('.edit-header-btn');
    editHeaderButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const headerId = row.cells[0].textContent;
            const boardId = row.cells[1].textContent;
            const headerName = row.cells[3].textContent;

            document.getElementById('header-modal-title').textContent = '말머리 수정';
            document.getElementById('header-id').value = headerId;
            document.getElementById('header-board-id').value = boardId;
            document.getElementById('header-name').value = headerName;
            headerModal.style.display = 'block';
        });
    });

    // 게시판 삭제 버튼 클릭 시 확인 모달 표시
    const deleteBoardButtons = document.querySelectorAll('.delete-board-btn');
    deleteBoardButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const boardId = row.cells[0].textContent;
            const boardName = row.cells[3].textContent;

            document.getElementById('delete-modal-title').textContent = '게시판 삭제';
            document.getElementById('delete-message').textContent = `"${boardName}" 게시판을 정말로 삭제하시겠습니까? 해당 게시판의 모든 게시글과 말머리도 함께 삭제됩니다.`;
            document.getElementById('confirm-delete-btn').setAttribute('data-type', 'board');
            document.getElementById('confirm-delete-btn').setAttribute('data-id', boardId);
            deleteModal.style.display = 'block';
        });
    });

    // 말머리 삭제 버튼 클릭 시 확인 모달 표시
    const deleteHeaderButtons = document.querySelectorAll('.delete-header-btn');
    deleteHeaderButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const headerId = row.cells[0].textContent;
            const headerName = row.cells[3].textContent;

            document.getElementById('delete-modal-title').textContent = '말머리 삭제';
            document.getElementById('delete-message').textContent = `"${headerName}" 말머리를 정말로 삭제하시겠습니까? 해당 말머리가 적용된 모든 게시글의 말머리가 제거됩니다.`;
            document.getElementById('confirm-delete-btn').setAttribute('data-type', 'header');
            document.getElementById('confirm-delete-btn').setAttribute('data-id', headerId);
            deleteModal.style.display = 'block';
        });
    });
</script>
</body>
</html>