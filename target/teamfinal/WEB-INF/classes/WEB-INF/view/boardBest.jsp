<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>BEST 게시판</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 테이블에만 적용되는 스타일 */
        #boardfree-table th,
        #boardfree-table td {
            width: auto !important;
            min-width: auto !important;
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

        .board-category-tag.solocamping {
            background-color: #ffebee;
            color: #d32f2f;
        }

        .notice-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: var(--color-error);
            color: var(--color-white);
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

        .board-row.notice {
            background-color: #fff8e1;
        }

        .board-row.hot-post {
            background-color: #ffebee;
        }

        .icon-heart {
            color: var(--color-error);
        }

        .icon-eye {
            color: var(--text-secondary);
        }

        .icon-comment {
            color: var(--color-info);
        }

        .table-icon {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-wrapper">
    <div class="container section" style="max-width: 1500px; padding: 0 15px;">
        <div class="main-content d-flex gap-4 my-5">
            <!-- 사이드바 -->
            <aside class="sidebar" style="width: 220px; margin-right: 20px;">
                <div class="sidebar-header">
                    <a href="boardmain.action"><h2 class="sidebar-title">커뮤니티</h2></a>
                </div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="boardbest.action" class="sidebar-link active">
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
                        <a href="boardimage.action" class="sidebar-link">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-trophy"></i> BEST</h1>
                </div>

                <!-- 정렬 옵션 -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <select class="form-control form-control-sm mr-2">
                            <option>정렬</option>
                            <option>최신순</option>
                            <option>조회순</option>
                            <option>추천순</option>
                        </select>
                    </div>
                </div>

                <!-- 게시글 테이블 -->
                <div class="content-box mb-5">
                    <table class="w-100" id="boardbest-table">
                        <thead>
                        <tr class="border-bottom">
                            <th width="6%" class="p-3 text-center">번호</th>
                            <th width="10%" class="p-3 text-center">분류</th>
                            <th width="47%" class="p-3 text-center">제목</th>
                            <th width="10%" class="p-3 text-center">작성자</th>
                            <th width="10%" class="p-3 text-center">작성일</th>
                            <th width="8%" class="p-3 text-center">조회수</th>
                            <th width="9%" class="p-3 text-center">추천</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 공지사항 -->
                        <c:forEach var="notice" items="${notice}">
                            <tr class="board-row notice border-bottom">
                                <td class="p-3 text-center"><a href="notice.action"><span
                                        class="notice-tag">공지</span></a></td>
                                <td class="p-3 text-center"><a href="notice.action"><span
                                        class="board-category-tag notice">공지</span></a></td>
                                <td class="p-3 title-cell"><a
                                        href="noticepost.action?postId=${notice.postId}">${notice.postTitle}</a></td>
                                <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                                <td class="p-3 text-center">${notice.createdDate.substring(0, 10)}</td>
                                <td class="p-3 text-center">${notice.viewCount}</td>
                                <td class="p-3 text-center"><i
                                        class="fa-solid fa-heart table-icon icon-heart"></i>${notice.recommendCount}
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- 일반 게시글 -->
                        <c:forEach var="totalHotPost" items="${totalHotPost}" varStatus="status">
                            <tr class="board-row border-bottom">
                                <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
                                <td class="p-3 text-center">
                                    <a href="${totalHotPost.boardName == '자유 게시판' ? 'boardfree.action' :
                                               totalHotPost.boardName == '고독한 캐핑방' ? 'boardimage.action' : 'boardmain.action'}">
                                        <span class="board-category-tag ${totalHotPost.boardName == '자유 게시판' ? 'freeboard' :
                                                                          totalHotPost.boardName == '고독한 캐핑방' ? 'camping' : ''}">${totalHotPost.boardName}
                                        </span>
                                    </a>
                                </td>
                                <td class="p-3 title-cell"><a
                                        href="${totalHotPost.boardName == '자유 게시판' ? 'boardfree-post.action' :
                                                totalHotPost.boardName == '고독한 캐핑방' ? 'boardimage-post.action' : 'boardmain.action'}?postId=${totalHotPost.postId}">${totalHotPost.postTitle}
                                        <%-- <i class="fa-solid fa-comment table-icon icon-comment"></i> 15</a>--%>
                                </td>
                                <td class="p-3 text-center">${totalHotPost.nickName}</td>
                                <td class="p-3 text-center">${totalHotPost.createdDate.substring(0, 10)}</td>
                                <td class="p-3 text-center">${totalHotPost.viewCount}</td>
                                <td class="p-3 text-center"><i
                                        class="fa-solid fa-heart table-icon icon-heart"></i>${totalHotPost.recommendCount}
                                </td>
                            </tr>
                        </c:forEach>


                        <c:if test="${empty totalHotPost && empty notice}">
                            <tr class="board-row border-bottom">
                                <td colspan="7" class="p-3 text-center">게시글이 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="boardbest.action" method="get">
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
                    <div style="margin: 0; flex: 3; display: flex; justify-content: center;">
                        <div class="d-flex gap-1">
                            <!-- 첫 페이지로 -->
                            <c:if test="${pagenation.pageNum > 1}">
                                <a href="boardbest.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="boardbest.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="boardbest.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="boardbest.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="boardbest.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>