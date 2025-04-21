<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>커뮤니티 메인</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 게시판 관련 추가 스타일 */
        .board-wrapper {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-md) var(--spacing-lg);
            background-color: var(--color-gray-300);
            border-bottom: 1px solid var(--border-medium);
        }

        .board-header h3 {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            color: var(--text-primary);
            margin: 0;
        }

        .board-header .more-btn {
            font-size: var(--font-xl);
            color: var(--text-primary);
            text-decoration: none;
            line-height: 1;
        }

        .post-list {
            padding: var(--spacing-md) var(--spacing-lg);
        }

        .post-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-sm) 0;
            border-bottom: 1px solid var(--border-light);
        }

        .post-item:last-child {
            border-bottom: none;
        }

        .post-number {
            width: 30px;
            text-align: center;
            background-color: var(--color-beige);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            padding: 2px 0;
        }

        .post-rec {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-left: var(--spacing-md);
            color: var(--color-coral);
            font-size: var(--font-xs);
            min-width: 60px;
        }

        .post-rec i {
            color: var(--color-coral);
        }

        .post-title {
            flex: 1;
            margin-left: var(--spacing-sm);
            font-size: var(--font-sm);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .post-title .attachment-icon {
            margin-left: 5px;
            color: var(--text-secondary);
        }

        .created-date {
            width: 100px;
            text-align: center;
            color: var(--text-secondary);
            font-size: var(--font-xs);
        }

        .main-image {
            margin-bottom: var(--spacing-lg);
        }

        .main-image img {
            width: 100%;
            height: 300px;
            border-radius: var(--radius-md);
            object-fit: cover;
        }

        /* 카드 그리드 수정 */
        .posts-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-md);
            padding: var(--spacing-md) var(--spacing-lg);
        }

        /* 심플 카드 스타일 */
        .simple-card {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
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

        .simple-card-image i {
            font-size: 48px;
            color: var(--color-gray-400);
        }

        .simple-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
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

                    <!-- 동적으로 커뮤니티 게시판 목록 표시 -->
                    <c:forEach var="board" items="${communityBoards}">
                        <c:choose>
                            <c:when test="${board.boardName eq '자유 게시판'}">
                                <a href="boardfree.action" class="sidebar-link">
                                    <i class="fa-solid fa-comments"></i>
                                    <span>${board.boardName}</span>
                                </a>
                            </c:when>
                            <c:when test="${board.boardName eq '고독한 캠핑방'}">
                                <a href="boardimage.action" class="sidebar-link">
                                    <i class="fa-solid fa-person-hiking"></i>
                                    <span>${board.boardName}</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <!-- 다른 게시판의 경우 -->
                                <a href="board${board.boardName}.action" class="sidebar-link">
                                    <i class="fa-solid fa-folder"></i>
                                    <span>${board.boardName}</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <!-- 메인 이미지 -->
                <div class="main-image">
                    <img src="/resources/images/board-main.jpg" alt="캠핑 메인 이미지"/>
                </div>

                <!-- BEST 게시판 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="boardbest.action" class="text-primary">BEST</a>
                        </h3>
                        <a href="boardbest.action" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <c:forEach var="post" items="${bestPosts}" varStatus="status">
                            <div class="post-item">
                                <div class="post-number">${status.index + 1}</div>
                                <div class="post-rec"><i class="fa-solid fa-heart"></i>${post.recommendCount}</div>
                                <div class="post-title">
                                    <c:choose>
                                        <c:when test="${post.boardName eq '자유 게시판'}">
                                            <a href="boardfree-post.action?postId=${post.postId}">${post.postTitle}</a>
                                        </c:when>
                                        <c:when test="${post.boardName eq '고독한 캠핑방'}">
                                            <a href="boardimage-post.action?postId=${post.postId}">${post.postTitle}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="boardUrlName" value=""/>
                                            <c:choose>
                                                <c:when test="${not empty post.boardName}">
                                                    <c:set var="boardUrlName"
                                                           value="${fn:toLowerCase(fn:replace(post.boardName, ' ', ''))}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="boardUrlName" value="board"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${boardUrlName}-post.action?postId=${post.postId}">${post.postTitle}</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty post.attachments}">
                                        <span class="attachment-icon">
                                            <i class="fa-solid fa-image"></i>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="created-date">
                                        ${fn:substring(post.createdDate, 0, 10)}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 동적으로 각 게시판 출력 -->
                <c:forEach var="board" items="${communityBoards}">
                    <c:set var="boardId" value="${board.boardId}"/>
                    <c:set var="boardPosts" value="${boardHotPosts[boardId]}"/>

                    <!-- 해당 게시판에 게시글이 있는 경우에만 표시 -->
                    <c:if test="${not empty boardPosts}">
                        <div class="board-wrapper">
                            <div class="board-header">
                                <h3>
                                    <c:choose>
                                        <c:when test="${board.boardName eq '자유 게시판'}">
                                            <a href="boardfree.action" class="text-primary">${board.boardName}</a>
                                        </c:when>
                                        <c:when test="${board.boardName eq '고독한 캠핑방'}">
                                            <a href="boardimage.action" class="text-primary">${board.boardName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="boardUrlName"
                                                   value="${fn:toLowerCase(fn:replace(board.boardName, ' ', ''))}"/>
                                            <a href="board${boardUrlName}.action"
                                               class="text-primary">${board.boardName}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                                <c:choose>
                                    <c:when test="${board.boardName eq '자유 게시판'}">
                                        <a href="boardfree.action" class="more-btn">+</a>
                                    </c:when>
                                    <c:when test="${board.boardName eq '고독한 캠핑방'}">
                                        <a href="boardimage.action" class="more-btn">+</a>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="boardUrlName"
                                               value="${fn:toLowerCase(fn:replace(board.boardName, ' ', ''))}"/>
                                        <a href="board${boardUrlName}.action" class="more-btn">+</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- 고독한캠핑방은 카드 형식, 다른 게시판은 리스트 형식 -->
                            <c:choose>
                                <c:when test="${board.boardName eq '고독한 캠핑방'}">
                                    <div class="posts-grid">
                                        <c:forEach var="post" items="${boardPosts}">
                                            <!-- 수정된 부분: 명확한 링크 지정 -->
                                            <a href="boardimage-post.action?postId=${post.postId}" class="simple-card">
                                                <div class="simple-card-image">
                                                    <c:choose>
                                                        <c:when test="${not empty post.attachments}">
                                                            <img src="${post.attachments[0].attachmentPath}"
                                                                 alt="${post.postTitle}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa-solid fa-mountain-sun"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="simple-card-content">
                                                    <h3 class="simple-card-title">${post.postTitle}</h3>
                                                    <div class="simple-card-author">${post.nickName}</div>
                                                    <div class="simple-card-footer">
                                                        <div class="created-date">
                                                                ${fn:substring(post.createdDate, 0, 10)}
                                                        </div>
                                                        <div class="simple-card-stats">
                                                            <div class="simple-card-stat">
                                                                <i class="fa-solid fa-eye"></i>
                                                                <span>${post.viewCount}</span>
                                                            </div>
                                                            <div class="simple-card-stat">
                                                                <i class="fa-solid fa-heart"></i>
                                                                <span>${post.recommendCount}</span>
                                                            </div>
                                                            <div class="simple-card-stat">
                                                                <i class="fa-solid fa-comment"></i>
                                                                <span>${post.replyCount}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="post-list">
                                        <c:forEach var="post" items="${boardPosts}" varStatus="status">
                                            <div class="post-item">
                                                <div class="post-number">${status.index + 1}</div>
                                                <div class="post-rec">
                                                    <i class="fa-solid fa-heart"></i>${post.recommendCount}
                                                </div>
                                                <div class="post-title">
                                                    <!-- 수정된 부분: 명확하게 게시판 유형별 링크 설정 -->
                                                    <c:choose>
                                                        <c:when test="${board.boardName eq '자유 게시판'}">
                                                            <a href="boardfree-post.action?postId=${post.postId}">${post.postTitle}</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="board${fn:toLowerCase(fn:replace(board.boardName, ' ', ''))}-post.action?postId=${post.postId}">
                                                                    ${post.postTitle}
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${not empty post.attachments && fn:length(post.attachments) > 0}">
                                                        <span class="attachment-icon">
                                                            <i class="fa-solid fa-image"></i>
                                                        </span>
                                                    </c:if>
                                                </div>
                                                <div class="created-date">
                                                        ${fn:substring(post.createdDate, 0, 10)}
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>