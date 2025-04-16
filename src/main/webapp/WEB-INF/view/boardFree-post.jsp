<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="checkLogin.jsp" %>
<html>
<head>
    <title>자유게시판 - 게시글 상세</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        th {
            width: auto !important;
        }


        /* 게시글 상세 페이지 관련 스타일 */
        .post-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
            overflow: hidden;
        }

        .post-header {
            padding: var(--spacing-md) var(--spacing-lg);
            border-bottom: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .post-title {
            font-size: var(--font-xl);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-sm);
            color: var(--text-primary);
        }

        .post-info {
            font-size: var(--font-xs);
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }

        .post-author {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        .post-author img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            object-fit: cover;
        }

        .post-body {
            padding: var(--spacing-lg);
            line-height: 1.6;
            min-height: 200px;
        }

        .post-body p {
            margin-bottom: var(--spacing-md);
        }

        .post-images {
            display: flex;
            gap: var(--spacing-sm);
            margin: var(--spacing-lg) 0;
            flex-wrap: wrap;
        }

        .post-image {
            width: 120px;
            height: 120px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            overflow: hidden;
            cursor: pointer;
        }

        .post-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .post-image:hover img {
            transform: scale(1.05);
        }


        .post-actions {
            display: flex;
            justify-content: space-between; /* 양쪽 끝으로 정렬 */
            align-items: center;
            width: 100%;
        }

        .like-area {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .nav-buttons {
            display: flex;
            gap: 8px; /* 버튼 사이 간격 */
            margin-top: 0 !important;
        }

        .post-buttons {
            padding: var(--spacing-md) var(--spacing-lg);
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
        }

        .like-button {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .like-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--color-gray-100);
            border-radius: 50%;
            cursor: pointer;
            transition: all var(--transition-normal);
        }

        .like-icon:hover {
            background-color: #ffe6e6;
        }

        .like-icon i {
            color: var(--color-coral);
            font-size: var(--font-md);
        }

        .like-count {
            font-weight: var(--font-bold);
            color: var(--text-secondary);
        }


        /* 댓글 영역 */
        .comments-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        .comment-list {
            border-bottom: 1px solid var(--border-light);
        }

        .comment-item {
            padding: var(--spacing-md) var(--spacing-lg);
            border-bottom: 1px solid var(--border-light);
            transition: background-color 0.2s ease;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-sm);
        }

        .comment-author {
            font-weight: var(--font-bold);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .comment-author img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            object-fit: cover;
        }

        .comment-date {
            font-size: var(--font-xxs);
            color: var(--text-tertiary);
        }

        .comment-text {
            margin-bottom: var(--spacing-sm);
            line-height: 1.4;
        }

        .comment-actions {
            display: flex;
            justify-content: flex-start;
            gap: var(--spacing-sm);
        }

        .comment-btn, .delete-btn, .update-btn, .report-btn {
            background: transparent;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 5px 5px;
            font-size: var(--font-xs);
            transition: all 0.2s ease;
        }

        .comment-btn:hover, .delete-btn:hover, .update-btn:hover, .report-btn:hover {
            color: var(--color-maple);
        }

        .post-header {
            padding: var(--spacing-md) var(--spacing-lg);
            border-bottom: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: flex-start; /* 위에 정렬 */
        }

        .post-actions-right {
            display: flex;
            gap: 10px;
        }

        .comment-reply-area {
            margin-top: var(--spacing-sm);
            padding: var(--spacing-sm);
            background-color: var(--bg-secondary);
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-light);
        }

        .comment-reply-input {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            resize: none;
            font-family: inherit;
            font-size: var(--font-xs);
            background-color: var(--bg-primary);
        }

        .comment-reply-input:focus {
            outline: none;
            border-color: var(--color-maple);
        }

        .reply-comment {
            margin-left: 30px;
            border-left: 2px solid var(--border-light);
            padding-left: var(--spacing-md);
            background-color: rgba(0, 0, 0, 0.01); /* 약간 어두운 배경으로 구분 */
        }

        .write-comment {
            padding: var(--spacing-md) var(--spacing-lg);
        }

        .comment-input-area {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-sm);
        }

        .comment-input {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            resize: none;
            font-family: inherit;
            font-size: var(--font-xs);
        }

        .comment-input:focus {
            outline: none;
            border-color: var(--color-maple);
        }

        .comment-submit {
            align-self: flex-end;
            padding: var(--spacing-sm) var(--spacing-md);
            background-color: var(--color-maple);
            color: var(--color-white);
            border: none;
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: all var(--transition-normal);
        }

        .comment-submit:hover {
            background-color: var(--btn-primary-hover-bg);
        }

        /* 게시글 목록 테이블 */
        .board-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }

        .board-table th {
            background-color: var(--bg-secondary);
            padding: var(--spacing-sm);
            text-align: center;
            font-weight: var(--font-bold);
            border-bottom: 1px solid var(--border-medium);
        }

        .board-table td {
            padding: var(--spacing-sm);
            text-align: center;
            border-bottom: 1px solid var(--border-light);
        }

        .board-table tr:hover {
            background-color: var(--bg-secondary);
        }

        .board-table .title-cell {
            text-align: left;
        }

        .board-table .title-cell a:hover {
            color: var(--color-maple);
            text-decoration: underline;
        }

        /* 페이지네이션 */
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: var(--spacing-lg);
        }

        .page-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 28px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            color: var(--text-primary);
            margin: 0 3px;
            transition: all var(--transition-normal);
        }

        .page-link.active {
            background-color: var(--color-maple);
            color: var(--color-white);
            border-color: var(--color-maple);
        }

        .page-link:hover:not(.active) {
            background-color: var(--bg-secondary);
        }

        /* 쓰기 버튼 컨테이너 */
        .write-btn-container {
            display: flex;
            justify-content: flex-end;
            margin-top: var(--spacing-sm);
        }


        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .report-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            width: 500px;
            max-width: 90%;
            border-radius: var(--radius-md);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            z-index: 1001;
        }

        .modal-content {
            width: 100%;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-light);
        }

        .modal-title {
            font-size: 18px;
            font-weight: var(--font-bold);
            margin: 0;
        }

        .close-btn {
            background: transparent;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: var(--text-tertiary);
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: var(--font-medium);
        }

        .form-select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: var(--font-xs);
        }

        /* 신고 경고사항 스타일 */
        .report-warning {
            margin-top: 20px;
            background-color: #fff8f8;
            border: 1px solid #ffebeb;
            border-radius: var(--radius-sm);
            padding: 12px 15px;
        }

        .warning-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            color: #e74c3c;
            font-weight: var(--font-bold);
            font-size: 14px;
        }

        .warning-list {
            margin: 0;
            padding-left: 20px;
            font-size: 13px;
            color: #555;
        }

        .warning-list li {
            margin-bottom: 5px;
            line-height: 1.4;
        }

        .warning-list li:last-child {
            margin-bottom: 0;
        }

        .warning-list strong {
            color: #333;
        }

        /* 모달 표시 애니메이션 */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .fade-in {
            animation: fadeIn 0.3s ease-in-out;
        }


        /* 게시판 특화 스타일 */
        .board-category-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-semibold);
            margin-right: 8px;
        }

        .board-category-tag.question {
            background-color: #e3f2fd;
            color: #0066cc;
        }

        .board-category-tag.review {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .board-category-tag.chat {
            background-color: #f3e5f5;
            color: #7b1fa2;
        }

        .board-category-tag.notice {
            background-color: #fff9c4;
            color: #ffa000;
        }

        .board-category-tag.freeboard {
            background-color: #e3f2fd;
            color: #0066cc;
        }

        .title-cell {
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-left: 10px;
        }

        .title-cell a:hover {
            text-decoration: underline;
            color: var(--color-maple);
        }

        .icon-heart {
            color: var(--color-error);
        }

        .table-icon {
            margin-right: 5px;
        }

    </style>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- 디버깅용 정보 (테스트 후 제거) -->
<%--<c:if test="${not empty sessionScope.user_code}">--%>
<%--    <div style="background-color: #f8f9fa; padding: 10px; margin: 10px 0; border: 1px solid #ddd;">--%>
<%--        게시글 작성자: ${post.userCode}, 로그인 사용자: ${sessionScope.user_code},--%>
<%--        일치 여부: ${post.userCode == sessionScope.user_code}--%>
<%--    </div>--%>
<%--</c:if>--%>


<div class="page-wrapper">
    <div class="container" style="max-width: 1500px; padding: 0 15px;">
        <div class="main-content d-flex gap-4 my-5">
            <!-- 사이드바 -->
            <aside class="sidebar" style="width: 220px; margin-right: 20px;">
                <div class="sidebar-header">
                    <h2 class="sidebar-title">커뮤니티</h2>
                </div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="boardbest.action" class="sidebar-link">
                            <i class="fa-solid fa-star"></i>
                            <span>BEST</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="boardfree.action" class="sidebar-link active">
                            <i class="fa-solid fa-comments"></i>
                            <span>자유게시판</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="boardimage.action" class="sidebar-link">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header mb-4">
                    <h1 class="page-title">자유게시판</h1>
                </div>
                <!-- 게시글 영역 -->
                <div class="post-container">
                    <div class="post-header">
                        <div>
                            <h1 class="post-title">${post.postTitle}</h1>
                            <div class="post-info">
                                <div class="post-author">
                                    <img src="/resources/images/rank-icon5.png" alt="작성자 아이콘">
                                    ${post.nickName}
                                </div>
                                <div class="post-date">${post.createdDate}</div>
                                <div class="post-views">조회수 ${post.viewCount}</div>
                                <div class="post-likes">추천 ${post.recommendCount}</div>
                                <button class="report-btn" data-id="${post.postId}">신고</button>
                            </div>
                        </div>
                        <div class="post-actions-right">
                            <c:if test="${post.userCode eq sessionScope.user_code}">
                                <button class="update-btn"
                                        onclick="location.href='boardfree-update.action?postId=${post.postId}'">수정
                                </button>
                                <button class="delete-btn" onclick="confirmDelete(${post.postId})">삭제</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="post-body">
                        ${post.postContent}

                        <!-- 첨부 이미지가 있는 경우 표시 -->
                        <c:if test="${not empty post.attachments and fn:length(post.attachments) > 0}">
                            <div class="post-images">
                                <c:forEach var="attachment" items="${post.attachments}">
                                    <c:if test="${not empty attachment.attachmentPath}">
                                        <div class="post-image">
                                            <img src="${attachment.attachmentPath}" alt="${attachment.attachmentName}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>

                    <div class="p-4 border-top">
                        <div class="post-actions">
                            <!-- 추천 버튼을 왼쪽으로 배치 -->
                            <div class="like-area">
                                <button class="btn btn-icon" id="likeButton" data-post-id="${post.postId}">
                                    <i class="fas fa-heart icon-heart"></i>
                                </button>
                                <span class="font-bold" id="likeCount">추천 ${post.recommendCount}</span>
                            </div>

                            <!-- 이전글, 목록, 다음글 버튼을 오른쪽으로 배치 -->
                            <div class="nav-buttons" style="display: flex; gap: 8px;">
                                <button class="btn btn-sm"
                                        onclick="location.href='boardfree-post.action?postId=${prevPostId}'">이전글
                                </button>
                                <button class="btn btn-sm" onclick="location.href='boardfree.action'">목록</button>
                                <button class="btn btn-sm"
                                        onclick="location.href='boardfree-post.action?postId=${nextPostId}'">다음글
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 댓글 영역 -->
                <div class="comments-container">
                    <div class="comment-list">
                        <c:choose>
                            <c:when test="${not empty replies}">
                                <c:forEach var="reply" items="${replies}">
                                    <!-- 댓글 표시 - 대댓글이 아닌 경우만 표시 -->
                                    <c:if test="${empty reply.rootReplyId}">
                                        <div class="comment-item" id="reply-${reply.replyId}">
                                            <div class="comment-header">
                                                <div class="comment-author">
                                                    <img src="/resources/images/rank-icon5.png" alt="작성자 아이콘">
                                                    <span>${reply.nickname}</span>
                                                </div>
                                                <div style="display: flex; gap: 15px; align-items: center;">
                                                    <div class="comment-date">${reply.createdDate}</div>
                                                    <button class="report-btn" data-id="${reply.replyId}">신고</button>
                                                </div>
                                            </div>
                                            <div style="display: flex; justify-content: space-between;">
                                                <div class="comment-text">
                                                        ${reply.replyContent}
                                                </div>
                                                <div class="comment-actions">
                                                    <button class="comment-btn">답글</button>
                                                    <!-- 자신의 댓글인 경우에만 삭제 버튼 표시 -->
                                                    <c:if test="${reply.userCode eq sessionScope.user_code}">
                                                        <button class="delete-btn" data-id="${reply.replyId}">
                                                            삭제
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="comment-reply-area">
                                                <div class="comment-input-area">
                                                    <textarea class="comment-reply-input" rows="4"
                                                              placeholder="댓글을 작성해주세요"></textarea>
                                                    <div class="charCounter text-right mt-1 text-secondary">0/1000byte
                                                    </div>
                                                    <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
                                                        <div>
                                                            <button class="btn btn-outline-primary btn-sm"><i
                                                                    class="fa-solid fa-paperclip"></i>첨부파일
                                                            </button>
                                                        </div>
                                                        <div>
                                                            <button class="btn btn-sm cancel-reply">취소</button>
                                                            <button class="btn btn-primary btn-sm reply-submit"
                                                                    data-parent-id="${reply.replyId}">등록
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 이 댓글에 달린 대댓글 표시 -->
                                            <c:forEach var="childReply" items="${replies}">
                                                <c:if test="${childReply.rootReplyId eq reply.replyId}">
                                                    <div class="comment-item reply-comment">
                                                        <div class="comment-header">
                                                            <div class="comment-author">
                                                                <img src="/resources/images/rank-icon5.png"
                                                                     alt="작성자 아이콘">
                                                                <span>${childReply.nickname}</span>
                                                            </div>
                                                            <div style="display: flex; gap: 15px; align-items: center;">
                                                                <div class="comment-date">${childReply.createdDate}</div>
                                                                <button class="report-btn"
                                                                        data-id="${childReply.replyId}">신고
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <div style="display: flex; justify-content: space-between;">
                                                            <div class="comment-text">
                                                                    ${childReply.replyContent}
                                                            </div>
                                                            <div class="comment-actions">
                                                                <button class="comment-btn">답글</button>
                                                                <!-- 자신의 댓글인 경우에만 삭제 버튼 표시 -->
                                                                <c:if test="${childReply.userCode eq sessionScope.user_code}">
                                                                    <button class="delete-btn"
                                                                            data-id="${childReply.replyId}">삭제
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="comment-reply-area">
                                                            <div class="comment-input-area">
                                                                <textarea class="comment-reply-input" rows="4"
                                                                          placeholder="댓글을 작성해주세요"></textarea>
                                                                <div class="charCounter text-right mt-1 text-secondary">
                                                                    0/1000byte
                                                                </div>
                                                                <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                                                                    <button class="btn btn-sm cancel-reply">취소</button>
                                                                    <button class="btn btn-primary btn-sm reply-submit"
                                                                            data-parent-id="${reply.replyId}">등록
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="comment-item">
                                    <div class="comment-text">
                                        아직 댓글이 없습니다. 첫 댓글을 작성해보세요!
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 댓글 작성 영역 -->
                    <div class="p-3">
                        <textarea id="contentArea" class="form-control mb-2" rows="3"
                                  placeholder="댓글을 작성해주세요"></textarea>
                        <div class="charCounter text-right mt-1 text-secondary">0/1000byte</div>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-outline-primary"><i class="fa-solid fa-paperclip"></i>첨부파일</button>
                            <button class="btn btn-primary" id="commentSubmit" data-post-id="${post.postId}">등록</button>
                        </div>
                    </div>
                </div>

                <!-- 게시글 목록 -->
                <table class="board-table" width="100%">
                    <colgroup>
                        <col width="10%">
                        <col width="10%">
                        <col width="*">
                        <col width="12%">
                        <col width="12%">
                        <col width="8%">
                        <col width="7%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>추천</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="postList" items="${postList}" varStatus="status">
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
                            <td class="p-3 text-center"><span class="board-category-tag
                                                            ${postList.postLabelName == '묻고답하기' ? 'question' :
                                                              postList.postLabelName == '아무말대잔치' ? 'chat' : 'freeboard'}">${postList.postLabelName}</span>
                            </td>
                            <td class="p-3 title-cell"><a
                                    href="boardfree-post.action?postId=${postList.postId}">${postList.postTitle}</a>
                            </td>
                            <td class="p-3 text-center">${postList.nickName}</td>
                            <td class="p-3 text-center">${postList.createdDate.substring(0, 10)}</td>
                            <td class="p-3 text-center">${postList.viewCount}</td>
                            <td class="p-3 text-center"><i
                                    class="fa-solid fa-heart table-icon icon-heart"></i>${postList.recommendCount}
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty postList && empty boardHotPosts && empty notice}">
                        <tr class="board-row border-bottom">
                            <td colspan="7" class="p-3 text-center">게시글이 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>

                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="boardfree.action" method="get">
                            <div class="d-flex border rounded">
                                <select name="searchType" class="form-control-sm border-0"
                                        style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                    <option value="titlecontent" ${searchType == 'titlecontent' ? 'selected' : ''}>
                                        제목+내용
                                    </option>
                                    <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                                    <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                                    <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                                </select>
                                <input type="text" name="searchKeyword" value="${searchKeyword}"
                                       class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요"
                                       style="padding: 8px 10px; font-size: 13px;">
                                <button type="submit" class="btn border-0"
                                        style="background-color: #f8f9fa; padding: 8px 10px;">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- 페이지네이션 - 중앙에 가깝게 -->
                    <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
                        <div class="d-flex gap-1 pagination">
                            <!-- 첫 페이지로 -->
                            <c:if test="${pagenation.pageNum > 1}">
                                <a href="boardfree.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="boardfree.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="boardfree.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="boardfree.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="boardfree.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>

                    <!-- 글쓰기 버튼 - 오른쪽 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;">

                        <button class="btn btn-primary" onclick="goToWrite()">
                            <i class="fa-solid fa-pen"></i> 글쓰기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 모달 컴포넌트 - body 태그 닫기 전에 추가 -->
<div class="modal-backdrop" id="modalBackdrop" style="display: none;"></div>

<div class="report-modal" id="reportModal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">신고하기</h5>
            <button type="button" class="close-btn" id="closeModalBtn">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <form id="reportForm">
                <div class="form-group mb-3">
                    <label class="form-label">신고 사유</label>
                    <select class="form-select" id="reportReason" required>
                        <option value="" selected disabled>신고 사유를 선택해주세요</option>
                        <option value="spam">스팸/홍보 게시글</option>
                        <option value="abuse">욕설/비방/차별/혐오</option>
                        <option value="adult">음란물/성적 콘텐츠</option>
                        <option value="illegal">불법 정보</option>
                        <option value="privacy">개인정보 노출</option>
                        <option value="other">기타</option>
                    </select>
                </div>
                <div class="form-group mb-3">
                    <label class="form-label">상세 내용</label>
                    <textarea class="form-control" id="reportDetail" rows="4" placeholder="상세 내용을 입력해주세요"></textarea>
                </div>
                <div class="report-warning">
                    <div class="warning-header">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <span>신고 전 주의사항</span>
                    </div>
                    <ul class="warning-list">
                        <li>허위 신고는 <strong>서비스 이용 제한</strong>의 사유가 될 수 있습니다.</li>
                        <li>신고 내용은 <strong>관리자만 확인</strong>할 수 있으며, 신고자의 정보는 보호됩니다.</li>
                        <li>신고 처리 결과는 별도로 <strong>통보되지 않습니다</strong>.</li>
                        <li>명확한 증거가 있는 경우 <strong>상세 내용에 기재</strong>해 주시기 바랍니다.</li>
                    </ul>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="cancelReportBtn">취소</button>
            <button type="button" class="btn btn-danger" id="submitReportBtn">신고하기</button>
        </div>
    </div>
</div>

<!-- 신고 완료 모달 -->
<div class="popup-alert" id="completionModal" style="display: none;">
    <div class="popup-alert-icon text-success">
        <i class="fa-solid fa-check-circle"></i>
    </div>
    <div class="popup-alert-title">신고가 접수되었습니다</div>
    <div class="popup-alert-content">검토 후 조치하겠습니다.</div>

    <!-- 확인 버튼 -->
    <div class="popup-alert-buttons">
        <button class="btn btn-primary" id="confirmReportBtn">확인</button>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script>
    // 모든 기능 초기화
    document.addEventListener("DOMContentLoaded", function () {
        // 모든 답글 버튼에 이벤트 추가
        document.querySelectorAll('.comment-btn').forEach(button => {
            button.addEventListener("click", function () {
                const commentItem = this.closest('.comment-item');
                const replyArea = commentItem.querySelector('.comment-reply-area');

                // 이미 열려있으면 닫고, 닫혀있으면 열기
                if (replyArea.style.display === "block") {
                    replyArea.style.display = "none";
                } else {
                    // 다른 모든 답글 영역을 닫음
                    document.querySelectorAll('.comment-reply-area').forEach(area => {
                        area.style.display = "none";
                    });

                    // 클릭한 답글 영역만 열기
                    replyArea.style.display = "block";

                    // 열린 답글 입력창에 바이트 카운터 적용
                    const textarea = replyArea.querySelector('.comment-reply-input');
                    if (textarea) {
                        applyByteCounter(textarea);
                    }
                }
            });
        });

        // 취소 버튼 이벤트
        document.querySelectorAll('.cancel-reply').forEach(button => {
            button.addEventListener("click", function () {
                const replyArea = this.closest('.comment-reply-area');
                replyArea.style.display = "none";
            });
        });

        // 댓글 삭제 버튼 이벤트 연결
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener("click", function () {
                if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) {
                    return;
                }

                const replyId = this.getAttribute("data-id");

                // AJAX를 사용하여 댓글 삭제 요청
                fetch("api/reply/delete.action", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        replyId: replyId
                    })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // 성공적으로 삭제된 경우 페이지 새로고침
                            location.reload();
                        } else {
                            alert("댓글 삭제에 실패했습니다: " + data.message);
                        }
                    })
                    .catch(error => {
                        console.error("Error", error);
                        alert("댓글 삭제 중 오류가 발생했습니다: ");
                    });
            });
        });

        // 메인 댓글 입력창에 바이트 카운터 적용
        const mainCommentArea = document.getElementById("contentArea");
        if (mainCommentArea) {
            applyByteCounter(mainCommentArea);
        }

        // 페이지 로드 시 모든 댓글 답글 영역 초기 상태로 숨기기
        document.querySelectorAll('.comment-reply-area').forEach(area => {
            area.style.display = "none";
        });
    });


    // 2. 모든 텍스트 입력창(메인 댓글 + 대댓글)에 바이트 카운터 기능 적용
    // 바이트 수 계산 함수
    function calculateBytes(str) {
        let byteCount = 0;
        for (let i = 0; i < str.length; i++) {
            const charCode = str.codePointAt(i);

            // '서로게이트 페어(Surrogate Pair)' 처리 - 이모지 등 특수 문자
            if (charCode > 0xFFFF) {
                byteCount += 4;
                i++;
            } else if (charCode > 0x7FF) {
                byteCount += 3;
            } else if (charCode > 0x7F) {
                byteCount += 2;
            } else {
                byteCount += 1;
            }
        }
        return byteCount;
    }

    // 디바운스 함수 정의 - 연속 이벤트 처리 최적화
    function debounce(func, wait) {
        let timeout;
        return function (...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // 모든 댓글 및 대댓글 텍스트 영역에 바이트 체크 적용
    function applyByteCounter(textarea) {
        if (!textarea) return;

        // 해당 텍스트영역의 카운터 찾기 (형제 요소)
        const counterEl = textarea.parentNode.querySelector('.charCounter');
        if (!counterEl) return;

        // 바이트 업데이트 함수
        function updateByteCount() {
            const text = textarea.value;
            let currentBytes = calculateBytes(text);

            // 1000 byte 초과 시 자르기
            if (currentBytes > 1000) {
                // 바이너리 검색 최적화
                let start = 0;
                let end = text.length;
                let mid;
                let cutText = text;

                while (start < end) {
                    mid = Math.floor((start + end) / 2);
                    cutText = text.substring(0, mid);

                    if (calculateBytes(cutText) <= 1000) {
                        start = mid + 1;
                    } else {
                        end = mid;
                    }
                }

                // 최종 적합한 지점 찾기
                while (calculateBytes(cutText) > 1000) {
                    cutText = cutText.slice(0, -1);
                }

                // 잘린 텍스트로 업데이트
                textarea.value = cutText;
                currentBytes = calculateBytes(cutText);
            }

            // 카운터 업데이트
            counterEl.textContent = currentBytes + '/1000byte';
        }

        // 디바운싱 적용
        const debouncedUpdate = debounce(updateByteCount, 100);

        // 이미 리스너가 있을 수 있으므로 한 번 제거했다가 다시 추가
        textarea.removeEventListener('input', debouncedUpdate);
        textarea.addEventListener('input', debouncedUpdate);

        // 초기 카운트 표시
        updateByteCount();
    }

    // 메인 댓글창에 적용
    const mainCommentArea = document.getElementById('contentArea');
    if (mainCommentArea) {
        applyByteCounter(mainCommentArea);
    }

    // 답글 표시 버튼 클릭 시 대댓글 입력창에도 바이트 카운터 적용
    document.querySelectorAll('.reply-toggle').forEach(button => {
        button.addEventListener('click', function () {
            // 해당 댓글 항목 찾기
            const commentItem = this.closest('.comment-item');
            if (!commentItem) return;

            // 대댓글 입력창 찾기
            const replyArea = commentItem.querySelector('.comment-reply-area');
            if (!replyArea) return;

            // 대댓글 텍스트 영역 찾기
            const replyTextarea = replyArea.querySelector('textarea');
            if (replyTextarea) {
                // 약간 지연을 두고 적용 (표시 애니메이션 이후)
                setTimeout(() => {
                    applyByteCounter(replyTextarea);
                }, 50);
            }
        });
    });

    // 댓글 등록 이벤트 처리
    document.getElementById('commentSubmit').addEventListener('click', function () {
        const postId = this.getAttribute('data-post-id');
        const content = document.getElementById('contentArea').value;
        console.log("postId:", postId); // 디버깅용 - 실제 값 확인

        if (content.trim() === '') {
            alert('댓글 내용을 입력해주세요.');
            return;
        }

        // AJAX를 사용하여 댓글 등록 요청
        fetch('api/reply/add.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                postId: postId,
                replyContent: content
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 성공적으로 등록된 경우 페이지 새로고침
                    location.reload();
                } else {
                    alert('댓글 등록에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('댓글 등록 중 오류가 발생했습니다.');
            });
    });

    // 답글 등록 이벤트 처리
    document.querySelectorAll('.reply-submit').forEach(button => {
        button.addEventListener('click', function () {
            const parentId = this.getAttribute('data-parent-id');
            const replyArea = this.closest('.comment-reply-area');
            const content = replyArea.querySelector('.comment-reply-input').value;

            if (content.trim() === '') {
                alert('답글 내용을 입력해주세요.');
                return;
            }

            // AJAX를 사용하여 답글 등록 요청
            fetch('api/reply/add.action', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    postId: '${post.postId}', // JSP EL 표현식 사용
                    rootReplyId: parentId,
                    replyContent: content
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 성공적으로 등록된 경우 페이지 새로고침
                        location.reload();
                    } else {
                        alert('답글 등록에 실패했습니다: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('답글 등록 중 오류가 발생했습니다.');
                });
        });
    });

    // 댓글 삭제 이벤트 처리
    document.querySelectorAll('.delete-reply').forEach(button => {
        button.addEventListener('click', function () {
            if (!confirm('정말 이 댓글을 삭제하시겠습니까?')) {
                return;
            }

            const replyId = this.getAttribute('data-id');

            // AJAX를 사용하여 댓글 삭제 요청
            fetch('api/reply/delete.action', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    replyId: replyId
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 성공적으로 삭제된 경우 페이지 새로고침
                        location.reload();
                    } else {
                        alert('댓글 삭제에 실패했습니다: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('댓글 삭제 중 오류가 발생했습니다.');
                });
        });
    });

    //-------------------------------------------------------------------------------
    document.addEventListener('DOMContentLoaded', function () {
        const modalBackdrop = document.getElementById('modalBackdrop');
        const reportModal = document.getElementById('reportModal');
        const completionModal = document.getElementById('completionModal');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelReportBtn = document.getElementById('cancelReportBtn');
        const submitReportBtn = document.getElementById('submitReportBtn');

        // 신고 대상 정보를 저장할 변수
        let reportTargetType = ''; // 'post' 또는 'comment'
        let reportTargetId = '';   // 게시글 ID 또는 댓글 ID

        // 모든 신고 버튼에 직접 onclick 핸들러 할당 (이벤트 위임 방식으로 변경)
        document.addEventListener('click', function (e) {
            // 클릭된 요소가 report-btn 클래스를 가지고 있는지 확인
            if (e.target.classList.contains('report-btn') ||
                e.target.closest('.report-btn')) {
                e.preventDefault();

                // 실제 클릭된 버튼을 찾음
                const reportBtn = e.target.classList.contains('report-btn') ?
                    e.target : e.target.closest('.report-btn');

                // 신고 대상 정보 설정
                const commentItem = reportBtn.closest('.comment-item');

                if (commentItem) {
                    // 댓글 신고
                    reportTargetType = 'comment';
                    // data-id 속성이 있으면 사용, 없으면 기본값 사용
                    reportTargetId = reportBtn.dataset.id || '1';
                } else {
                    // 게시글 신고
                    reportTargetType = 'post';
                    reportTargetId = reportBtn.dataset.id || '13150';
                }

                // 모달 표시
                showModal();
            }
        });

        // 모달 닫기 함수
        function closeModal() {
            modalBackdrop.style.display = 'none';
            reportModal.style.display = 'none';

            // 모달 닫을 때 애니메이션 클래스 제거
            reportModal.classList.remove('fade-in');

            // 폼 초기화
            document.getElementById('reportForm').reset();
        }

        // 모달 표시 함수
        function showModal() {
            modalBackdrop.style.display = 'block';
            reportModal.style.display = 'block';
            reportModal.classList.add('show', 'fade-in');
            modalBackdrop.classList.add('show');
        }

        // 닫기 버튼 클릭 시 모달 닫기
        closeModalBtn.addEventListener('click', closeModal);
        cancelReportBtn.addEventListener('click', closeModal);

        // 배경 클릭 시 모달 닫기
        modalBackdrop.addEventListener('click', closeModal);

        // 모달 내부 클릭 시 이벤트 버블링 방지
        reportModal.addEventListener('click', function (e) {
            e.stopPropagation();
        });

        // 신고 제출 버튼 클릭 시
        submitReportBtn.addEventListener('click', function () {
            const reportReason = document.getElementById('reportReason').value;
            const reportDetail = document.getElementById('reportDetail').value;

            // 필수 항목 검증
            if (!reportReason) {
                alert('신고 사유를 선택해주세요.');
                return;
            }

            // 여기에 신고 데이터 처리 AJAX 요청을 추가할 수 있음
            // 예: fetch('/api/report', { method: 'POST', body: JSON.stringify({...}) })

            // 신고 모달 닫기
            reportModal.style.display = 'none';

            // 완료 모달 표시
            completionModal.style.display = 'block';
            completionModal.classList.add('zoom-in');
        });

        // 완료 모달의 확인 버튼 클릭 시 목록 페이지로 이동
        document.getElementById('confirmReportBtn').addEventListener('click', function () {
            // 모달 닫기
            modalBackdrop.style.display = 'none';
            completionModal.style.display = 'none';

            // 목록 페이지로 이동
            window.location.href = 'boardfree.action'; // 실제 구현 시 적절한 URL로 변경 필요
        });
    });




    // 추천(좋아요) 버튼 이벤트 처리
    document.getElementById('likeButton').addEventListener('click', function () {
        const postId = this.getAttribute('data-post-id');

        // AJAX를 사용하여 추천 토글 요청
        fetch('api/post/recommend.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                postId: postId
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 추천 수 업데이트
                    document.getElementById('likeCount').textContent = '추천 ' + data.recommendCount;

                    // 추천 버튼 상태 업데이트 (활성화/비활성화)
                    if (data.recommended) {
                        this.classList.add('active');
                    } else {
                        this.classList.remove('active');
                    }
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('추천 처리 중 오류가 발생했습니다.');
            });
    });

    // 게시글 삭제 함수
    function confirmDelete(postId) {
        if (confirm('정말 이 게시글을 삭제하시겠습니까?')) {
            // 삭제 요청 보내기
            fetch('api/post/delete.action', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    postId: postId
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('게시글이 삭제되었습니다.');
                        // 게시글 목록 페이지로 이동
                        location.href = 'boardfree.action';
                    } else {
                        alert('게시글 삭제에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('게시글 삭제 중 오류가 발생했습니다.');
                });
        }
    }

</script>
</body>
</html>
