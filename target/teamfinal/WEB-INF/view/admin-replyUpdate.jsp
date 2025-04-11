<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 댓글 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-replyUpdate.css">
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
            <h2>댓글 관리</h2>
        </div>

        <!-- 검색 영역 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select>
                <option>댓글 내용</option>
                <option>회원 닉네임</option>
                <option>게시물 제목</option>
            </select>

            <span>신고여부</span>
            <select>
                <option>전체</option>
                <option>신고됨</option>
                <option>신고안됨</option>
            </select>

            <span>첨부파일</span>
            <select>
                <option>전체</option>
                <option>있음</option>
                <option>없음</option>
            </select>

            <!-- 날짜 범위 선택 -->
            <div class="content-search-date">
                <input type="date">
                <span>~</span>
                <input type="date">
            </div>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" placeholder="검색어 입력">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" value="검색하기">
            </div>
        </div>

        <!-- 댓글 정보 요약 -->
        <div class="comment-count">
            <div class="comment-all">
                <span>총 댓글 수 : 2,546개</span>
            </div>
            <div class="comment-with-attachment">
                <span>첨부파일 포함 댓글 : 142개</span>
            </div>
            <div class="comment-reported">
                <span>신고 댓글 : 45개</span>
            </div>
        </div>

        <!-- 댓글 유형 토글 스위치 -->
        <div class="toggle-container">
            <div class="toggle-button-group">
                <button type="button" class="toggle-button active" data-type="all">전체 댓글</button>
                <button type="button" class="toggle-button" data-type="attachment">첨부파일 포함 댓글</button>
                <button type="button" class="toggle-button" data-type="reported">신고된 댓글</button>
            </div>
        </div>

        <!-- 전체 선택 체크박스 -->
        <div class="select-all-checkbox">
            <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
        </div>

        <!-- 댓글 목록 테이블 -->
        <div class="comment-table">
            <table>
                <tr>
                    <!-- 테이블 헤더 -->
                    <th class="col-select"><input type="checkbox"></th>
                    <th class="col-comment-id">댓글 ID</th>
                    <th class="col-nickname">회원 닉네임</th>
                    <th class="col-content">댓글 내용</th>
                    <th class="col-date">생성일</th>
                    <th class="col-post-title">게시글 제목</th>
                    <th class="col-attachment">첨부파일</th>
                    <th class="col-reported">신고</th>
                    <th class="col-report-type">신고유형</th>
                    <th class="col-actions">관리</th>
                </tr>

                <!-- 댓글 데이터 행 -->
                <tr>
                    <td class="col-select"><input type="checkbox"></td>
                    <td>COMM001</td>
                    <td>행복한하루</td>
                    <td>정말 좋은 정보 감사합니다! 많은 도움이 되었어요.</td>
                    <td>2023-04-15</td>
                    <td>카메라 장비 추천 - 초보자를 위한 가이드</td>
                    <td><span class="status-badge status-no">없음</span></td>
                    <td><span class="status-badge status-no">없음</span></td>
                    <td>-</td>
                    <td><button class="btn btn-primary action-btn edit-comment-btn">관리</button></td>
                </tr>

                <tr>
                    <td class="col-select"><input type="checkbox"></td>
                    <td>COMM002</td>
                    <td>카메라사랑</td>
                    <td>사진 첨부합니다. 이런 현상이 발생하는데 혹시 해결 방법 아시나요?</td>
                    <td>2023-04-16</td>
                    <td>카메라 렌즈 문제 해결 방법 공유</td>
                    <td><span class="status-badge status-yes">있음</span></td>
                    <td><span class="status-badge status-no">없음</span></td>
                    <td>-</td>
                    <td><button class="btn btn-primary action-btn edit-comment-btn">관리</button></td>
                </tr>

                <tr>
                    <td class="col-select"><input type="checkbox"></td>
                    <td>COMM003</td>
                    <td>신고대상자</td>
                    <td>부적절한 내용의 댓글 입니다. 광고 및 비방 내용을 포함하고 있습니다.</td>
                    <td>2023-04-18</td>
                    <td>자유게시판 질문입니다</td>
                    <td><span class="status-badge status-no">없음</span></td>
                    <td><span class="status-badge status-reported">신고됨</span></td>
                    <td>광고/스팸</td>
                    <td><button class="btn btn-primary action-btn edit-comment-btn">관리</button></td>
                </tr>
            </table>
        </div>

        <!-- 댓글 관리 모달 -->
        <div id="comment-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>댓글 상세 관리</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="comment-form">
                        <div class="form-group">
                            <label for="comment-id">댓글 ID</label>
                            <input type="text" id="comment-id" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="member-nickname">회원 닉네임</label>
                            <input type="text" id="member-nickname" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="comment-content">댓글 내용</label>
                            <textarea id="comment-content" class="form-control" rows="5"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="created-date">생성일</label>
                            <input type="text" id="created-date" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="post-title">게시글 제목</label>
                            <input type="text" id="post-title" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label for="has-attachment">첨부파일</label>
                            <select id="has-attachment" class="form-control" disabled>
                                <option>있음</option>
                                <option>없음</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="is-reported">신고 여부</label>
                            <select id="is-reported" class="form-control" disabled>
                                <option>신고됨</option>
                                <option>신고안됨</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="report-type">신고 처리 유형</label>
                            <select id="report-type" class="form-control">
                                <option>선택안함</option>
                                <option>욕설/비방</option>
                                <option>광고/스팸</option>
                                <option>음란물</option>
                                <option>개인정보유출</option>
                                <option>저작권침해</option>
                                <option>기타</option>
                            </select>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-danger" id="delete-comment-btn">삭제</button>
                            <button type="button" class="btn btn-danger" id="cancel-btn">취소</button>
                            <button type="submit" class="btn btn-primary" id="save-comment-btn">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 삭제 확인 모달 -->
        <div id="delete-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>댓글 삭제 확인</h3>
                    <span class="close-modal">&times;</span>
                </div>
                <div class="modal-body">
                    <p id="delete-message" style="margin-bottom: 25px; line-height: 1.5; color: #555;">선택한 댓글을 정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.</p>
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

    // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
    document.querySelectorAll('.menu-button.active').forEach(button => {
        const submenu = button.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
    });

    // 페이지 로드 시 기본 데이터 표시 (전체 댓글)
    document.addEventListener('DOMContentLoaded', function() {
        showFilteredComments('all');
    });

    // 모달 관련 변수
    const commentModal = document.getElementById('comment-modal');
    const deleteModal = document.getElementById('delete-modal');
    const closeModalButtons = document.querySelectorAll('.close-modal');

    // 모달 닫기 버튼
    closeModalButtons.forEach(button => {
        button.addEventListener('click', function() {
            commentModal.style.display = 'none';
            deleteModal.style.display = 'none';
        });
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        if (event.target === commentModal) {
            commentModal.style.display = 'none';
        }
        if (event.target === deleteModal) {
            deleteModal.style.display = 'none';
        }
    });

    // 취소 버튼 클릭 시 모달 닫기
    document.getElementById('cancel-btn').addEventListener('click', function() {
        commentModal.style.display = 'none';
    });

    document.getElementById('cancel-delete-btn').addEventListener('click', function() {
        deleteModal.style.display = 'none';
    });

    // 댓글 관리 버튼 클릭 시 모달 표시
    const editCommentButtons = document.querySelectorAll('.edit-comment-btn');
    editCommentButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const commentId = row.cells[1].textContent;
            const memberNickname = row.cells[2].textContent;
            const commentContent = row.cells[3].textContent;
            const createdDate = row.cells[4].textContent;
            const postTitle = row.cells[5].textContent;

            // 첨부파일 상태 추출
            const attachmentStatus = row.cells[6].querySelector('.status-badge').textContent;

            // 신고 상태 추출
            const reportedStatus = row.cells[7].querySelector('.status-badge').textContent;

            // 신고 처리 유형
            const reportType = row.cells[8].textContent;

            // 모달 폼에 데이터 설정
            document.getElementById('comment-id').value = commentId;
            document.getElementById('member-nickname').value = memberNickname;
            document.getElementById('comment-content').value = commentContent;
            document.getElementById('created-date').value = createdDate;
            document.getElementById('post-title').value = postTitle;
            document.getElementById('has-attachment').value = attachmentStatus;
            document.getElementById('is-reported').value = reportedStatus;
            document.getElementById('report-type').value = reportType !== "-" ? reportType : "선택안함";

            // 모달 표시
            commentModal.style.display = 'block';
        });
    });

    // 댓글 삭제 버튼 클릭 시 확인 모달 표시
    document.getElementById('delete-comment-btn').addEventListener('click', function() {
        const commentId = document.getElementById('comment-id').value;
        const commentContent = document.getElementById('comment-content').value;

        // 내용이 긴 경우 간략히 표시
        const shortContent = commentContent.length > 50 ? commentContent.substring(0, 50) + '...' : commentContent;

        document.getElementById('delete-message').textContent = `"${shortContent}" 댓글을 정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.`;
        document.getElementById('confirm-delete-btn').setAttribute('data-id', commentId);

        commentModal.style.display = 'none';
        deleteModal.style.display = 'block';
    });

    // 댓글 삭제 확인 버튼 클릭 시 처리
    document.getElementById('confirm-delete-btn').addEventListener('click', function() {
        const commentId = this.getAttribute('data-id');

        // 여기에 삭제 처리 코드 작성
        // 실제 환경에서는 서버로 삭제 요청을 보내는 AJAX 구현

        console.log({
            action: '댓글 삭제',
            commentId
        });

        // 모달 닫기
        deleteModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert('댓글이 성공적으로 삭제되었습니다.');

        // 페이지 새로고침 (실제 구현 시 필요한 경우)
        // location.reload();
    });

    // 댓글 폼 제출 처리
    document.getElementById('comment-form').addEventListener('submit', function(event) {
        event.preventDefault();

        // 여기에 댓글 수정 처리 코드 작성
        // 실제 환경에서는 서버로 데이터를 전송하는 AJAX 요청을 구현

        // 예시: 콘솔에 데이터 출력
        const commentId = document.getElementById('comment-id').value;
        const commentContent = document.getElementById('comment-content').value;
        const reportType = document.getElementById('report-type').value;

        console.log({
            action: '댓글 수정',
            commentId,
            commentContent,
            reportType
        });

        // 모달 닫기
        commentModal.style.display = 'none';

        // 성공 메시지 표시 (실제 구현 시 AJAX 요청 성공 후 표시)
        alert('댓글이 성공적으로 수정되었습니다.');

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
            showFilteredComments(type);
        });
    });

    // 댓글 필터링 및 테이블 업데이트 함수
    function showFilteredComments(type) {
        // 기존 테이블 행 제거 (헤더 제외)
        const tableRows = document.querySelectorAll('.comment-table table tr:not(:first-child)');
        tableRows.forEach(row => row.remove());

        // 테이블 참조
        const table = document.querySelector('.comment-table table');

        // 필터링에 따른 데이터
        let filteredData = [];

        switch(type) {
            case 'all':
                // 전체 댓글 데이터
                filteredData = [
                    {
                        id: 'COMM001',
                        nickname: '행복한하루',
                        content: '정말 좋은 정보 감사합니다! 많은 도움이 되었어요.',
                        date: '2023-04-15',
                        postTitle: '카메라 장비 추천 - 초보자를 위한 가이드',
                        attachment: false,
                        reported: false,
                        reportType: '-'
                    },
                    {
                        id: 'COMM002',
                        nickname: '카메라사랑',
                        content: '사진 첨부합니다. 이런 현상이 발생하는데 혹시 해결 방법 아시나요?',
                        date: '2023-04-16',
                        postTitle: '카메라 렌즈 문제 해결 방법 공유',
                        attachment: true,
                        reported: false,
                        reportType: '-'
                    },
                    {
                        id: 'COMM003',
                        nickname: '신고대상자',
                        content: '부적절한 내용의 댓글 입니다. 광고 및 비방 내용을 포함하고 있습니다.',
                        date: '2023-04-18',
                        postTitle: '자유게시판 질문입니다',
                        attachment: false,
                        reported: true,
                        reportType: '광고/스팸'
                    }
                ];
                break;

            case 'attachment':
                // 첨부파일 포함 댓글 데이터
                filteredData = [
                    {
                        id: 'COMM002',
                        nickname: '카메라사랑',
                        content: '사진 첨부합니다. 이런 현상이 발생하는데 혹시 해결 방법 아시나요?',
                        date: '2023-04-16',
                        postTitle: '카메라 렌즈 문제 해결 방법 공유',
                        attachment: true,
                        reported: false,
                        reportType: '-'
                    },
                    {
                        id: 'COMM004',
                        nickname: '포토그래퍼',
                        content: '제 촬영 사진입니다. 피드백 부탁드려요!',
                        date: '2023-04-17',
                        postTitle: '사진 작가 모임',
                        attachment: true,
                        reported: false,
                        reportType: '-'
                    }
                ];
                break;

            case 'reported':
                // 신고된 댓글 데이터
                filteredData = [
                    {
                        id: 'COMM003',
                        nickname: '신고대상자',
                        content: '부적절한 내용의 댓글 입니다. 광고 및 비방 내용을 포함하고 있습니다.',
                        date: '2023-04-18',
                        postTitle: '자유게시판 질문입니다',
                        attachment: false,
                        reported: true,
                        reportType: '광고/스팸'
                    },
                    {
                        id: 'COMM005',
                        nickname: '블랙리스트',
                        content: '개인정보 유출 댓글입니다.',
                        date: '2023-04-19',
                        postTitle: '회원 소개 게시판',
                        attachment: false,
                        reported: true,
                        reportType: '개인정보유출'
                    }
                ];
                break;
        }

        // 필터링된 데이터로 테이블 행 생성
        filteredData.forEach(comment => {
            const row = table.insertRow();

            // 체크박스 셀
            const checkCell = row.insertCell();
            checkCell.className = 'col-select';
            checkCell.innerHTML = '<input type="checkbox">';

            // 댓글 ID
            const idCell = row.insertCell();
            idCell.textContent = comment.id;

            // 닉네임
            const nicknameCell = row.insertCell();
            nicknameCell.textContent = comment.nickname;

            // 댓글 내용
            const contentCell = row.insertCell();
            contentCell.textContent = comment.content;

            // 생성일
            const dateCell = row.insertCell();
            dateCell.textContent = comment.date;

            // 게시글 제목
            const postTitleCell = row.insertCell();
            postTitleCell.textContent = comment.postTitle;

            // 첨부파일
            const attachmentCell = row.insertCell();
            const attachmentStatus = comment.attachment ? 'status-yes' : 'status-no';
            const attachmentText = comment.attachment ? '있음' : '없음';
            attachmentCell.innerHTML = `<span class="status-badge ${attachmentStatus}">${attachmentText}</span>`;

            // 신고여부
            const reportedCell = row.insertCell();
            const reportedStatus = comment.reported ? 'status-reported' : 'status-no';
            const reportedText = comment.reported ? '신고됨' : '없음';
            reportedCell.innerHTML = `<span class="status-badge ${reportedStatus}">${reportedText}</span>`;

            // 신고유형
            const reportTypeCell = row.insertCell();
            reportTypeCell.textContent = comment.reportType;

            // 관리 버튼
            const actionsCell = row.insertCell();
            actionsCell.innerHTML = '<button class="btn btn-primary action-btn edit-comment-btn">관리</button>';
        });

        // 댓글 관리 버튼에 이벤트 리스너 재설정
        const editCommentButtons = document.querySelectorAll('.edit-comment-btn');
        editCommentButtons.forEach(button => {
            button.addEventListener('click', function() {
                const row = this.closest('tr');
                const commentId = row.cells[1].textContent;
                const memberNickname = row.cells[2].textContent;
                const commentContent = row.cells[3].textContent;
                const createdDate = row.cells[4].textContent;
                const postTitle = row.cells[5].textContent;

                // 첨부파일 상태 추출
                const attachmentStatus = row.cells[6].querySelector('.status-badge').textContent;

                // 신고 상태 추출
                const reportedStatus = row.cells[7].querySelector('.status-badge').textContent;

                // 신고 처리 유형
                const reportType = row.cells[8].textContent;

                // 모달 폼에 데이터 설정
                document.getElementById('comment-id').value = commentId;
                document.getElementById('member-nickname').value = memberNickname;
                document.getElementById('comment-content').value = commentContent;
                document.getElementById('created-date').value = createdDate;
                document.getElementById('post-title').value = postTitle;
                document.getElementById('has-attachment').value = attachmentStatus;
                document.getElementById('is-reported').value = reportedStatus;
                document.getElementById('report-type').value = reportType !== "-" ? reportType : "선택안함";

                // 모달 표시
                commentModal.style.display = 'block';
            });
        });

        // 통계 업데이트
        updateStats(type);
    }

    // 통계 정보 업데이트 함수
    function updateStats(type) {
        const allCountElement = document.querySelector('.comment-all span');
        const attachmentCountElement = document.querySelector('.comment-with-attachment span');
        const reportedCountElement = document.querySelector('.comment-reported span');

        switch(type) {
            case 'all':
                allCountElement.textContent = '총 댓글 수 : 2,546개';
                attachmentCountElement.textContent = '첨부파일 포함 댓글 : 142개';
                reportedCountElement.textContent = '신고 댓글 : 45개';
                break;

            case 'attachment':
                allCountElement.textContent = '총 댓글 수 : 2,546개';
                attachmentCountElement.textContent = '첨부파일 포함 댓글 : 142개 (현재 표시)';
                reportedCountElement.textContent = '신고 댓글 : 45개';
                break;

            case 'reported':
                allCountElement.textContent = '총 댓글 수 : 2,546개';
                attachmentCountElement.textContent = '첨부파일 포함 댓글 : 142개';
                reportedCountElement.textContent = '신고 댓글 : 45개 (현재 표시)';
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
    document.getElementById('selectAll').addEventListener('change', function() {
        const headerCheckbox = document.querySelector('th.col-select input[type="checkbox"]');
        headerCheckbox.checked = this.checked;

        const checkboxes = document.querySelectorAll('td.col-select input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });
</script>
</body>
</html>