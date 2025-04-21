<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                    <c:forEach var="board" items="${Board}">
                        <tr>
                            <td>${board.boardId}</td>
                            <td>${board.categoryName}</td>
                            <td>
                                <span class="admin-level-badge admin-level-${board.adminGrade}">
                                    <c:choose>
                                        <c:when test="${board.adminGrade == '관리자+회원'}">일반관리자</c:when>
                                        <c:when test="${board.adminGrade == '관리자'}">중간관리자</c:when>
                                        <c:when test="${board.adminGrade == '관리자'}">최고관리자</c:when>
                                    </c:choose>
                                </span>
                            </td>
                            <td>${board.boardName}</td>
                            <td>
                                <button class="btn btn-primary action-btn edit-board-btn" data-id="${board.boardId}">수정</button>
                                <button class="btn btn-danger action-btn delete-board-btn" data-id="${board.boardId}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty Board}">
                        <tr>
                            <td colspan="5" class="no-data">등록된 게시판이 없습니다.</td>
                        </tr>
                    </c:if>
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
                    <c:forEach var="label" items="${Label}">
                        <tr>
                            <td>${label.labelId}</td>
                            <td>${label.boardId}</td>
                            <td>${label.boardName}</td>
                            <td>${label.labelName}</td>
                            <td>
                                <button class="btn btn-primary action-btn edit-header-btn" data-id="${label.labelId}">수정</button>
                                <button class="btn btn-danger action-btn delete-header-btn" data-id="${label.labelId}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty Label}">
                        <tr>
                            <td colspan="5" class="no-data">등록된 말머리가 없습니다.</td>
                        </tr>
                    </c:if>
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
                    <form id="board-form" action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="post">
                        <input type="hidden" id="board-action" name="action" value="add">
                        <div class="form-group">
                            <label for="board-id">게시판 ID</label>
                            <input type="text" id="board-id" name="boardId" class="form-control" placeholder="자동 생성" readonly>
                        </div>
                        <div class="form-group">
                            <label for="board-category">카테고리명</label>
                            <input type="text" id="board-category" name="categoryName" class="form-control" placeholder="카테고리 입력" required>
                        </div>
                        <div class="form-group">
                            <label for="board-admin-level">관리등급</label>
                            <select id="board-admin-level" name="adminLevel" class="form-control" required>
                                <option value="1">일반관리자</option>
                                <option value="2">중간관리자</option>
                                <option value="3">최고관리자</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="board-name">게시판명</label>
                            <input type="text" id="board-name" name="boardName" class="form-control" placeholder="게시판명 입력" required>
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
                    <form id="header-form" action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="post">
                        <input type="hidden" id="header-action" name="action" value="add">
                        <div class="form-group">
                            <label for="header-id">말머리 ID</label>
                            <input type="text" id="header-id" name="labelId" class="form-control" placeholder="자동 생성" readonly>
                        </div>
                        <div class="form-group">
                            <label for="header-board-id">게시판 선택</label>
                            <select id="header-board-id" name="boardId" class="form-control" required>
                                <option value="">게시판 선택</option>
                                <c:forEach var="board" items="${boardList}">
                                    <option value="${board.boardId}">${board.boardName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="header-name">말머리명</label>
                            <input type="text" id="header-name" name="labelName" class="form-control" placeholder="말머리명 입력" required>
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
                    <form id="delete-form" method="post">
                        <input type="hidden" id="delete-id" name="id">
                        <input type="hidden" id="delete-type" name="type">
                        <div class="form-actions">
                            <button type="button" class="btn btn-primary" id="cancel-delete-btn">취소</button>
                            <button type="submit" class="btn btn-danger" id="confirm-delete-btn">삭제</button>
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

    // 게시판 추가 버튼 클릭 시 모달 표시
    document.getElementById('add-board-btn').addEventListener('click', function() {
        document.getElementById('board-modal-title').textContent = '게시판 추가';
        document.getElementById('board-action').value = 'add';
        document.getElementById('board-form').reset();
        document.getElementById('board-id').readOnly = true;
        boardModal.style.display = 'block';
    });

    // 말머리 추가 버튼 클릭 시 모달 표시
    document.getElementById('add-header-btn').addEventListener('click', function() {
        document.getElementById('header-modal-title').textContent = '말머리 추가';
        document.getElementById('header-action').value = 'add';
        document.getElementById('header-form').reset();
        document.getElementById('header-id').readOnly = true;
        headerModal.style.display = 'block';
    });

    // 삭제 버튼 이벤트 처리
    function setupDeleteButtons() {
        // 게시판 삭제 버튼
        document.querySelectorAll('.delete-board-btn').forEach(button => {
            button.addEventListener('click', function() {
                const boardId = this.getAttribute('data-id');
                const boardName = this.closest('tr').querySelector('td:nth-child(4)').textContent;

                document.getElementById('delete-modal-title').textContent = '게시판 삭제';
                document.getElementById('delete-message').textContent =
                    `"${boardName}" 게시판을 정말로 삭제하시겠습니까? 해당 게시판의 모든 게시글과 말머리도 함께 삭제됩니다.`;
                document.getElementById('delete-type').value = 'board';
                document.getElementById('delete-id').value = boardId;
                document.getElementById('delete-form').action = '${pageContext.request.contextPath}/admin-deleteBoard.action';
                deleteModal.style.display = 'block';
            });
        });

        // 말머리 삭제 버튼
        document.querySelectorAll('.delete-header-btn').forEach(button => {
            button.addEventListener('click', function() {
                const headerId = this.getAttribute('data-id');
                const headerName = this.closest('tr').querySelector('td:nth-child(4)').textContent;

                document.getElementById('delete-modal-title').textContent = '말머리 삭제';
                document.getElementById('delete-message').textContent =
                    `"${headerName}" 말머리를 정말로 삭제하시겠습니까? 해당 말머리가 적용된 모든 게시글의 말머리가 제거됩니다.`;
                document.getElementById('delete-type').value = 'header';
                document.getElementById('delete-id').value = headerId;
                document.getElementById('delete-form').action = '${pageContext.request.contextPath}/admin-deleteHeader.action';
                deleteModal.style.display = 'block';
            });
        });
    }

    // 수정 버튼 이벤트 처리
    function setupEditButtons() {
        // 게시판 수정 버튼
        document.querySelectorAll('.edit-board-btn').forEach(button => {
            button.addEventListener('click', function() {
                const boardId = this.getAttribute('data-id');
                const row = this.closest('tr');
                const category = row.querySelector('td:nth-child(2)').textContent;
                const adminLevel = row.querySelector('.admin-level-badge').classList[1].split('-')[2];
                const boardName = row.querySelector('td:nth-child(4)').textContent;

                document.getElementById('board-modal-title').textContent = '게시판 수정';
                document.getElementById('board-action').value = 'edit';
                document.getElementById('board-id').value = boardId;
                document.getElementById('board-category').value = category;
                document.getElementById('board-admin-level').value = adminLevel;
                document.getElementById('board-name').value = boardName;
                boardModal.style.display = 'block';
            });
        });

        // 말머리 수정 버튼
        document.querySelectorAll('.edit-header-btn').forEach(button => {
            button.addEventListener('click', function() {
                const labelId = this.getAttribute('data-id');
                const row = this.closest('tr');
                const boardId = row.querySelector('td:nth-child(2)').textContent;
                const labelName = row.querySelector('td:nth-child(4)').textContent;

                document.getElementById('header-modal-title').textContent = '말머리 수정';
                document.getElementById('header-action').value = 'edit';
                document.getElementById('header-id').value = labelId;
                document.getElementById('header-board-id').value = boardId;
                document.getElementById('header-name').value = labelName;
                headerModal.style.display = 'block';
            });
        });
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
        document.querySelectorAll('.menu-button.active').forEach(button => {
            const submenu = button.nextElementSibling;
            submenu.style.maxHeight = submenu.scrollHeight + 'px';
        });

        // 수정, 삭제 버튼 이벤트 설정
        setupEditButtons();
        setupDeleteButtons();
    });
</script>
</body>
</html>