<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    // 줄바꿈
    pageContext.setAttribute("br", "<br/>");
    pageContext.setAttribute("cn", "\n");
%>

<html>
<head>
    <title>고독한 캠핑방 - 게시글 상세</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 심플 카드 그리드 스타일 - boardImage.jsp와 동일하게 적용 */
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
            align-items: flex-start; /* 위에 정렬 */
        }

        .post-actions-right {
            display: flex;
            gap: 10px;
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

        /* 게시글 이미지 갤러리 개선 스타일 */
        .post-images {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin: 30px 0;
            align-items: center;
        }

        .post-image {
            width: 90%;
            max-width: 800px;
            height: auto;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-md);
            overflow: hidden;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .post-image:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .post-image img {
            width: 100%;
            height: auto;
            object-fit: contain;
            display: block;
        }
        .posts-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-md);
            padding: var(--spacing-md) var(--spacing-lg);
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

        /* 심플 카드 스타일 */
        .simple-card {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: block;
            text-decoration: none;
            color: inherit;
        }

        .simple-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .simple-card-image {
            height: 180px;
            background-color: var(--color-gray-200);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .simple-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .simple-card-image i {
            font-size: 48px;
            color: var(--color-gray-400);
        }

        .simple-card-content {
            padding: var(--spacing-md);
        }

        .simple-card-title {
            font-size: var(--font-sm);
            font-weight: var(--font-medium);
            margin: 0 0 var(--spacing-xs);
            color: var(--text-primary);
        }

        .simple-card-author {
            font-size: var(--font-xxs);
            color: var(--text-secondary);
            margin-bottom: var(--spacing-sm);
        }

        .simple-card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: var(--spacing-xs);
            border-top: 1px solid var(--border-light);
            font-size: var(--font-xxs);
            color: var(--text-tertiary);
        }

        .simple-card-stats {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .simple-card-stat {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .simple-card-stat i.fa-heart {
            color: var(--color-coral);
        }

        .simple-card-stat i.fa-eye {
            color: var(--text-secondary);
        }

        .simple-card-stat i.fa-comment {
            color: var(--color-info);
        }

        /* 하트 아이콘 기본 상태: 회색 */
        .icon-heart {
            color: var(--color-gray-500);
            transition: color 0.3s ease;
        }

        /* 하트 아이콘 활성 상태: 빨간색 */
        .icon-heart.active {
            color: var(--color-error);
        }

        /* 북마크 아이콘 스타일 */
        .icon-bookmark {
            color: var(--color-gray-500);
            transition: color 0.3s ease;
        }

        .icon-bookmark.active {
            color: var(--color-maple);
        }

        /* 북마크 버튼 스타일 */
        .bookmark-icon {
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

        .bookmark-icon:hover {
            background-color: #e6f0ff;
        }

        .bookmark-icon i {
            color: var(--color-gray-600);
            font-size: var(--font-md);
        }

        .bookmark-icon.active i {
            color: var(--color-maple);
        }

        .ml-3 {
            margin-left: 12px;
        }

        /* 모달 스타일 */
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

        .comment-btn, .delete-btn, .update-btn, .report-btn, .delete-post-btn {
            background: transparent;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 5px 5px;
            font-size: var(--font-xs);
            transition: all 0.2s ease;
        }

        .comment-btn:hover, .delete-btn:hover, .update-btn:hover, .report-btn:hover, .delete-post-btn:hover {
            color: var(--color-maple);
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

        /* 캠핑 이미지 갤러리 스타일 */
        .camping-image-gallery {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .camping-main-image {
            max-width: 100%;
            max-height: 500px;
            border-radius: var(--radius-md);
            object-fit: contain;
        }

        @media (max-width: 992px) {
            .posts-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .posts-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<!-- 디버깅용 정보 (테스트 후 제거) -->
<c:if test="${not empty sessionScope.userCode}">
    <div style="background-color: #f8f9fa; padding: 10px; margin: 10px 0; border: 1px solid #ddd;">
        게시글 작성자: ${post.userCode}, 로그인 사용자: ${sessionScope.userCode},
        일치 여부: ${post.userCode == sessionScope.userCode}
    </div>
</c:if>

<div class="page-wrapper">
    <div class="container" style="max-width: 1500px; padding: 0 15px;">
        <div class="main-content d-flex gap-4 my-5">
            <!-- 사이드바 -->
            <aside class="sidebar" style="width: 220px; margin-right: 20px;">
                <div class="sidebar-header">
                    <a href="boardmain.action"><h2 class="sidebar-title">커뮤니티</h2></a>
                </div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="boardbest.action" class="sidebar-link">
                            <i class="fa-solid fa-trophy"></i>
                            <span>BEST</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="boardfree.action" class="sidebar-link">
                            <i class="fa-solid fa-comments"></i>
                            <span>자유게시판</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="boardimage.action" class="sidebar-link active">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header mb-4">
                    <a href="boardimage.action"><h1 class="page-title"><i class="fa-solid fa-person-hiking"></i> 고독한캠핑방</h1></a>
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
                            <c:if test="${isAuthor}">
                                <button class="update-btn"
                                        onclick="location.href='boardimage-update.action?postId=${post.postId}'">수정
                                </button>
                                <button class="delete-post-btn" onclick="confirmDelete(${post.postId})">삭제</button>
                            </c:if>
                        </div>
                    </div>

                    <div class="post-body">
                        <!-- 이미지 첨부파일 표시 -->
                        <div class="post-images">
                            <c:if test="${not empty post.attachments}">
                                <c:forEach var="attachment" items="${post.attachments}">
                                    <div class="post-image">
                                        <img src="${pageContext.request.contextPath}${attachment.attachmentPath}"
                                             alt="${attachment.attachmentName}">
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>

                    <div class="p-4 border-top">
                        <div class="post-actions">
                            <!-- 추천 버튼을 왼쪽으로 배치 -->
                            <div class="like-area">
                                <!-- 추천 버튼 -->
                                <button class="btn btn-icon" id="likeButton" data-post-id="${post.postId}">
                                    <i class="fas fa-heart icon-heart"></i>
                                </button>
                                <span class="font-bold" id="likeCount">추천 ${post.recommendCount}</span>

                                <!-- 북마크 버튼 -->
                                <button class="btn btn-icon ml-3" id="bookmarkButton" data-post-id="${post.postId}">
                                    <i class="fas fa-bookmark icon-bookmark"></i>
                                </button>
                                <span class="font-bold" id="bookmarkStatus">북마크</span>
                            </div>

                            <!-- 이전글, 목록, 다음글 버튼을 오른쪽으로 배치 -->
                            <div class="nav-buttons" style="display: flex; gap: 8px;">
                                <button class="btn btn-sm"
                                        onclick="location.href='boardimage-post.action?postId=${prevPostId}'">이전글
                                </button>
                                <button class="btn btn-sm" onclick="location.href='boardimage.action'">목록</button>
                                <button class="btn btn-sm"
                                        onclick="location.href='boardimage-post.action?postId=${nextPostId}'">다음글
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
                                                    <c:if test="${reply.userCode eq sessionScope.userCode}">
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
                                                                <c:if test="${childReply.userCode eq sessionScope.userCode}">
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
                <div class="posts-grid">
                    <c:forEach var="recentPost" items="${postList}">
                        <a href="boardimage-post.action?postId=${recentPost.postId}" class="simple-card">
                            <div class="simple-card-image">
                                <c:choose>
                                    <c:when test="${not empty recentPost.attachments}">
                                        <img src="${pageContext.request.contextPath}${recentPost.attachments[0].attachmentPath}"
                                             alt="${recentPost.attachments[0].attachmentName}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-person-hiking"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">${recentPost.postTitle}</h3>
                                <div class="simple-card-author">${recentPost.nickName}</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">${recentPost.createdDate.substring(0, 10)}</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>${recentPost.viewCount}</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>${recentPost.recommendCount}</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>${recentPost.replyCount}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>

                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="boardimage.action" method="get">
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
                                <a href="boardimage.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="boardimage.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="boardimage.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="boardimage.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="boardimage.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
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
    // 모든 기능을 하나의 DOMContentLoaded 이벤트로 통합
    document.addEventListener("DOMContentLoaded", function () {
        // 모달 관련 요소 초기화
        initializeModalElements();

        // 댓글 및 답글 관련 이벤트 설정
        initializeCommentEvents();

        // 바이트 카운터 적용
        initializeByteCounters();

        // 게시글 추천 기능 설정
        initializePostRecommendation();

        // 북마크 기능 초기화
        initializeBookmarkFeature();

        // 페이지 로드 시 추천 및 북마크 상태 확인
        checkRecommendStatus();
        checkBookmarkStatus();

        // 조회수 표시 업데이트 추가
        const viewCountElement = document.querySelector('.post-views');
        if (viewCountElement) {
            const currentText = viewCountElement.textContent;
            const currentCount = parseInt(currentText.replace(/[^0-9]/g, ''));
            if (!isNaN(currentCount)) {
                // 화면에 표시된 조회수를 즉시 업데이트
                viewCountElement.textContent = '조회수 ' + (currentCount + 1);
            }
        }
    });

    // 모달 관련 요소 및 이벤트 초기화 함수
    function initializeModalElements() {
        const modalBackdrop = document.getElementById('modalBackdrop');
        const reportModal = document.getElementById('reportModal');
        const completionModal = document.getElementById('completionModal');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelReportBtn = document.getElementById('cancelReportBtn');
        const submitReportBtn = document.getElementById('submitReportBtn');

        // 신고 대상 정보를 저장할 변수
        let reportTargetType = '';
        let reportTargetId = '';

        // 신고 버튼 클릭 이벤트 위임
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('report-btn') || e.target.closest('.report-btn')) {
                e.preventDefault();

                // 실제 클릭된 버튼을 찾음
                const reportBtn = e.target.classList.contains('report-btn') ?
                    e.target : e.target.closest('.report-btn');

                // 신고 대상 정보 설정
                const commentItem = reportBtn.closest('.comment-item');

                if (commentItem) {
                    // 댓글 신고
                    reportTargetType = 'comment';
                    reportTargetId = reportBtn.dataset.id || '1';
                } else {
                    // 게시글 신고
                    reportTargetType = 'post';
                    reportTargetId = reportBtn.dataset.id || '13150';
                }

                // 모달 표시
                showModal(reportModal);
            }
        });

        // 모달 닫기 버튼 이벤트
        if (closeModalBtn) closeModalBtn.addEventListener('click', () => closeModal(reportModal));
        if (cancelReportBtn) cancelReportBtn.addEventListener('click', () => closeModal(reportModal));

        // 배경 클릭 시 모달 닫기
        if (modalBackdrop) modalBackdrop.addEventListener('click', () => closeAllModals());

        // 모달 내부 클릭 시 이벤트 버블링 방지
        if (reportModal) reportModal.addEventListener('click', function (e) {
            e.stopPropagation();
        });

        // 신고 제출 버튼 클릭 시
        if (submitReportBtn) submitReportBtn.addEventListener('click', function () {
            const reportReason = document.getElementById('reportReason').value;
            const reportDetail = document.getElementById('reportDetail').value;

            // 필수 항목 검증
            if (!reportReason) {
                alert('신고 사유를 선택해주세요.');
                return;
            }

            // 여기에 신고 데이터 처리 AJAX 요청을 추가할 수 있음
            // 예: sendAjaxRequest('/api/report', 'POST', {신고 데이터...})

            // 신고 모달 닫기
            closeModal(reportModal);

            // 완료 모달 표시
            showModal(completionModal);
            completionModal.classList.add('zoom-in');
        });

        // 완료 모달의 확인 버튼 클릭 시 목록 페이지로 이동
        const confirmReportBtn = document.getElementById('confirmReportBtn');
        if (confirmReportBtn) confirmReportBtn.addEventListener('click', function () {
            // 모달 닫기
            closeAllModals();

            // 목록 페이지로 이동
            window.location.href = 'boardimage.action';
        });
    }

    // 모달 표시 함수
    function showModal(modal) {
        const modalBackdrop = document.getElementById('modalBackdrop');
        if (modalBackdrop) modalBackdrop.style.display = 'block';
        if (modal) {
            modal.style.display = 'block';
            modal.classList.add('show', 'fade-in');
        }
        if (modalBackdrop) modalBackdrop.classList.add('show');
    }

    // 모달 닫기 함수
    function closeModal(modal) {
        const modalBackdrop = document.getElementById('modalBackdrop');
        if (modalBackdrop) modalBackdrop.style.display = 'none';
        if (modal) {
            modal.style.display = 'none';
            modal.classList.remove('fade-in');
        }

        // 폼 초기화
        const reportForm = document.getElementById('reportForm');
        if (reportForm) reportForm.reset();
    }

    // 모든 모달 닫기
    function closeAllModals() {
        const modalBackdrop = document.getElementById('modalBackdrop');
        const reportModal = document.getElementById('reportModal');
        const completionModal = document.getElementById('completionModal');

        if (modalBackdrop) modalBackdrop.style.display = 'none';
        if (reportModal) reportModal.style.display = 'none';
        if (completionModal) completionModal.style.display = 'none';
    }

    // 댓글 및 답글 관련 이벤트 초기화
    function initializeCommentEvents() {
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

        // 페이지 로드 시 모든 댓글 답글 영역 초기 상태로 숨기기
        document.querySelectorAll('.comment-reply-area').forEach(area => {
            area.style.display = "none";
        });

        // 댓글 등록 이벤트 처리
        const commentSubmit = document.getElementById('commentSubmit');
        if (commentSubmit) {
            commentSubmit.addEventListener('click', function () {
                const postId = this.getAttribute('data-post-id');
                const content = document.getElementById('contentArea').value;

                if (content.trim() === '') {
                    alert('댓글 내용을 입력해주세요.');
                    return;
                }

                // AJAX 요청 통합 함수 사용
                sendAjaxRequest('api/reply/add.action', 'POST', {
                    postId: postId,
                    replyContent: content
                }, function (data) {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('댓글 등록에 실패했습니다: ' + data.message);
                    }
                });
            });
        }

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

                // AJAX 요청 통합 함수 사용
                sendAjaxRequest('api/reply/add.action', 'POST', {
                    postId: '${post.postId}', // JSP EL 표현식 사용
                    rootReplyId: parentId,
                    replyContent: content
                }, function (data) {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('답글 등록에 실패했습니다: ' + data.message);
                    }
                });
            });
        });
    }

    // 댓글 삭제 이벤트 처리
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            if (!confirm('정말 이 댓글을 삭제하시겠습니까?')) {
                return;
            }

            const replyId = this.getAttribute('data-id');

            // AJAX 요청 통합 함수 사용
            sendAjaxRequest('api/reply/delete.action', 'POST', {
                replyId: replyId
            }, function (data) {
                if (data.success) {
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패했습니다: ' + data.message);
                }
            });
        });
    });

    // 바이트 카운터 초기화 및 적용
    function initializeByteCounters() {
        // 메인 댓글 입력창에 바이트 카운터 적용
        const mainCommentArea = document.getElementById("contentArea");
        if (mainCommentArea) {
            applyByteCounter(mainCommentArea);
        }
    }

    // 게시글 추천 기능 초기화
    function initializePostRecommendation() {
        const likeButton = document.getElementById('likeButton');
        if (likeButton) {
            likeButton.addEventListener('click', function () {
                const postId = this.getAttribute('data-post-id');
                const likeIcon = this.querySelector('i');

                // AJAX 요청 통합 함수 사용
                sendAjaxRequest('/api/post/recommend.action', 'POST', {
                    postId: postId
                }, function (response) {
                    // 추천 수 업데이트 (성공/실패 상관없이)
                    if (response.recommendCount !== undefined) {
                        document.getElementById('likeCount').textContent = "추천 " + response.recommendCount;
                    }

                    // 성공 시 추천 아이콘 변경 - 활성화
                    if (response.success) {
                        likeIcon.classList.add('active');
                    }
                });
            });

            // 페이지 로드 시 추천 상태 확인
            checkRecommendStatus();
        }
    }

    // 추천 상태 확인 함수
    function checkRecommendStatus() {
        const likeButton = document.getElementById('likeButton');

        if (likeButton) {
            const postId = likeButton.getAttribute('data-post-id');

            // AJAX 요청으로 추천 상태 확인
            sendAjaxRequest('/api/post/checkRecommend.action', 'POST', {
                postId: postId
            }, function(response) {
                console.log("추천 상태 확인 응답:", response); // 디버깅용

                if (response.success) {
                    const likeIcon = likeButton.querySelector('i');

                    // 추천 상태에 따라 UI 업데이트
                    if (response.isRecommended) {
                        likeIcon.classList.add('active');
                    } else {
                        likeIcon.classList.remove('active');
                    }
                }
            });
        }
    }

    // AJAX 요청 통합 함수
    function sendAjaxRequest(url, method, data, successCallback) {
        fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (successCallback) successCallback(data);
            })
            .catch(error => {
                console.error('Error:', error);
                alert('요청 처리 중 오류가 발생했습니다.');
            });
    }

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

    // 바이트 카운터 적용 함수
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

    // 게시글 삭제 함수
    function confirmDelete(postId) {
        // 모달 내용 설정
        document.querySelector('#reportModal .modal-title').textContent = '게시글 삭제';
        document.querySelector('#reportModal .modal-body').innerHTML = `
        <p>정말 이 게시글을 삭제하시겠습니까?</p>
        <p>삭제된 게시글은 복구할 수 없습니다.</p>
    `;

        // 취소 버튼 텍스트 변경
        document.getElementById('cancelReportBtn').textContent = '취소';

        // 신고하기 버튼 텍스트와 색상 변경
        const submitBtn = document.getElementById('submitReportBtn');
        submitBtn.textContent = '삭제하기';
        submitBtn.className = 'btn btn-danger';

        // 모달 표시
        showModal(document.getElementById('reportModal'));

        // 기존 이벤트 리스너 제거하고 새로운 리스너 설정
        const newSubmitBtn = submitBtn.cloneNode(true);
        submitBtn.parentNode.replaceChild(newSubmitBtn, submitBtn);

        // 삭제 확인 버튼 이벤트
        newSubmitBtn.addEventListener('click', function () {
            // 모달 닫기
            closeModal(document.getElementById('reportModal'));

            // 삭제 요청 보내기
            sendAjaxRequest('api/post/delete.action', 'POST', {
                postId: postId
            }, function (data) {
                // 모달 내용 설정
                const iconElement = document.querySelector('#completionModal .popup-alert-icon i');
                const iconContainer = document.querySelector('#completionModal .popup-alert-icon');
                const titleElement = document.querySelector('#completionModal .popup-alert-title');
                const contentElement = document.querySelector('#completionModal .popup-alert-content');

                if (data.success) {
                    // 성공 모달 설정
                    iconElement.className = 'fa-solid fa-check-circle';
                    iconContainer.className = 'popup-alert-icon text-success';
                    titleElement.textContent = '삭제 완료';
                    contentElement.textContent = '게시글이 성공적으로 삭제되었습니다.';

                    // 확인 버튼 이벤트 처리
                    setupConfirmButton(true);
                } else {
                    // 실패 모달 설정
                    iconElement.className = 'fa-solid fa-exclamation-circle';
                    iconContainer.className = 'popup-alert-icon text-danger';
                    titleElement.textContent = '삭제 실패';
                    contentElement.textContent = data.message || '알 수 없는 오류가 발생했습니다.';

                    // 확인 버튼 이벤트 처리
                    setupConfirmButton(false);
                }

                // 완료 모달 표시
                showModal(document.getElementById('completionModal'));
            });
        });

        // 취소 및 닫기 버튼 이벤트 리스너 재설정
        setupCancelButtons();
    }

    // 확인 버튼 설정 함수
    function setupConfirmButton(redirectToList) {
        const confirmBtn = document.getElementById('confirmReportBtn');
        const newConfirmBtn = confirmBtn.cloneNode(true);
        confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);

        newConfirmBtn.addEventListener('click', function () {
            // 모달 닫기
            closeAllModals();

            // 목록 페이지로 리다이렉트 (성공한 경우에만)
            if (redirectToList) {
                window.location.href = 'boardimage.action';
            }
        });
    }
    // 취소 및 닫기 버튼 설정 함수
    function setupCancelButtons() {
        // 취소 버튼 이벤트 리스너 교체
        const cancelBtn = document.getElementById('cancelReportBtn');
        if (cancelBtn) {
            const newCancelBtn = cancelBtn.cloneNode(true);
            cancelBtn.parentNode.replaceChild(newCancelBtn, cancelBtn);

            newCancelBtn.addEventListener('click', function () {
                closeAllModals();
            });
        }

        // 닫기 버튼 이벤트 리스너 교체
        const closeBtn = document.getElementById('closeModalBtn');
        if (closeBtn) {
            const newCloseBtn = closeBtn.cloneNode(true);
            closeBtn.parentNode.replaceChild(newCloseBtn, closeBtn);

            newCloseBtn.addEventListener('click', function () {
                closeAllModals();
            });
        }
    }


    // 북마크 기능 초기화
    function initializeBookmarkFeature() {
        const bookmarkButton = document.getElementById('bookmarkButton');

        if (bookmarkButton) {
            // 북마크 버튼 클릭 이벤트 추가
            bookmarkButton.addEventListener('click', function() {
                const postId = this.getAttribute('data-post-id');
                const bookmarkIcon = this.querySelector('i');
                const bookmarkStatus = document.getElementById('bookmarkStatus');

                // 현재 상태 확인 (클래스로 결정)
                const isCurrentlyBookmarked = bookmarkIcon.classList.contains('active');

                // 즉시 UI 업데이트 (서버 응답 전)
                if (isCurrentlyBookmarked) {
                    bookmarkIcon.classList.remove('active');
                    bookmarkStatus.textContent = "북마크";
                } else {
                    bookmarkIcon.classList.add('active');
                    bookmarkStatus.textContent = "북마크됨";
                }

                // AJAX 요청 통합 함수 사용
                sendAjaxRequest('/api/post/bookmark.action', 'POST', {
                    postId: postId
                }, function(response) {
                    // 서버 응답에 따라 UI를 조정
                    if (!response.success) {
                        // 실패 시 원래 상태로 되돌림
                        if (isCurrentlyBookmarked) {
                            bookmarkIcon.classList.add('active');
                            bookmarkStatus.textContent = "북마크됨";
                        } else {
                            bookmarkIcon.classList.remove('active');
                            bookmarkStatus.textContent = "북마크";
                        }
                        alert('북마크 처리 중 오류가 발생했습니다: ' + response.message);
                    }
                });
            });
        }
    }

    // 북마크 상태 확인 함수
    function checkBookmarkStatus() {
        const bookmarkButton = document.getElementById('bookmarkButton');
        const bookmarkStatus = document.getElementById('bookmarkStatus');

        if (bookmarkButton) {
            const postId = bookmarkButton.getAttribute('data-post-id');

            // AJAX 요청으로 북마크 상태 확인
            sendAjaxRequest('/api/post/checkbookmark.action', 'POST', {
                postId: postId
            }, function(response) {
                console.log("북마크 상태 확인 응답:", response); // 디버깅용

                if (response.success) {
                    const bookmarkIcon = bookmarkButton.querySelector('i');

                    // 북마크 상태에 따라 UI 업데이트
                    if (response.isBookmarked) {
                        bookmarkIcon.classList.add('active');
                        bookmarkStatus.textContent = "북마크됨";
                    } else {
                        bookmarkIcon.classList.remove('active');
                        bookmarkStatus.textContent = "북마크";
                    }
                }
            });
        }
    }

    // 글쓰기 페이지로
    function goToWrite() {
        window.location.href = "boardimage-write.action";
    }
</script>
</body>
</html>
