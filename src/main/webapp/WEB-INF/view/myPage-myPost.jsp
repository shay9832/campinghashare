<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 마이페이지</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
    <style>
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

        .hot-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: #ff6b6b;
            color: white;
        }

        .icon-heart {
            color: var(--color-error);
        }

        .icon-comment {
            color: var(--color-info);
        }

        .icon-eye {
            color: var(--text-secondary);
        }

        .table-icon {
            margin-right: 5px;
        }

        .attachment-icon {
            margin-left: 5px;
            color: var(--text-secondary);
        }

        .filter-btn {
            padding: 6px 16px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-medium);
            background-color: var(--bg-secondary);
            cursor: pointer;
            transition: all var(--transition-normal);
            font-size: var(--font-xs);
        }

        .filter-btn:hover {
            background-color: var(--color-gray-200);
        }

        .filter-btn.active {
            background-color: var(--color-beige-light);
            border-color: var(--color-maple);
            color: var(--color-maple);
            font-weight: var(--font-semibold);
        }

        #mypost-table th,
        #mypost-table td {
            width: auto !important;
            min-width: auto !important;
        }
    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container container-wide mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link active">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">내가 작성한 글</h2>
        </div>

        <!-- 검색 섹션 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="d-flex align-items-center">
                <select name="sortType" class="form-control-sm">
                    <option value="recent">최신순</option>
                    <option value="views">조회순</option>
                    <option value="recommends">추천순</option>
                </select>

                <div style="display: flex; margin-left: 20px;">
                    <a href="#" id="postsBtn" class="filter-btn active" style="border-radius: 4px; margin-right: 10px; min-width: 80px; text-align: center;">게시글</a>
                    <a href="#" id="repliesBtn" class="filter-btn" style="border-radius: 4px; min-width: 80px; text-align: center;">댓글</a>
                </div>
            </div>

            <div class="search-container">
                <form action="mypage-mypost.action" method="get">
                    <div class="d-flex border rounded">
                        <select name="searchType" class="form-control-sm border-0" style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                            <option value="titlecontent" ${searchType == 'titlecontent' ? 'selected' : ''}>제목+내용</option>
                            <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                            <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                        </select>
                        <input type="text" name="searchKeyword" value="${searchKeyword}" class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요" style="padding: 8px 10px; font-size: 13px;">
                        <button type="submit" class="btn border-0" style="background-color: #f8f9fa; padding: 8px 10px;">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 게시글 목록 테이블 -->
        <div class="content-box mb-5">
            <table class="w-100" id="mypost-table">
                <thead>
                <tr class="border-bottom">
                    <th width="7%" class="p-3 text-center">번호</th>
                    <th width="10%" class="p-3 text-center">게시판</th>
                    <th width="10%" class="p-3 text-center">분류</th>
                    <th width="38%" class="p-3 text-center">제목</th>
                    <th width="10%" class="p-3 text-center">작성일</th>
                    <th width="8%" class="p-3 text-center">조회수</th>
                    <th width="8%" class="p-3 text-center">추천수</th>
                    <th width="9%" class="p-3 text-center">관리</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty postList}">
                    <tr class="board-row border-bottom">
                        <td colspan="8" class="p-3 text-center">작성한 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="post" items="${postList}" varStatus="status">
                    <tr class="board-row border-bottom">
                        <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
                        <td class="p-3 text-center">${post.boardName}</td>
                        <td class="p-3 text-center">
                            <span class="board-category-tag ${post.postLabelName == '묻고답하기' ? 'question' :
                                                              post.postLabelName == '아무말대잔치' ? 'chat' :
                                                              post.postLabelName == '고독한캠핑방' ? 'solocamping' : 'freeboard'}">
                                    ${post.postLabelName}
                            </span>
                        </td>
                        <td class="p-3 title-cell">
                            <a href="${post.boardName == '자유게시판' ? 'boardfree-post.action' :
                                      post.boardName == '고독한캠핑방' ? 'boardimage-post.action' :
                                      'boardfree-post.action'}?postId=${post.postId}">${post.postTitle}</a>
                            <c:if test="${not empty post.attachments}">
                                <span class="attachment-icon">
                                    <i class="fa-solid fa-image"></i>
                                </span>
                            </c:if>
                        </td>
                        <td class="p-3 text-center">${post.createdDate.substring(0, 10)}</td>
                        <td class="p-3 text-center">${post.viewCount}</td>
                        <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>${post.recommendCount}</td>
                        <td class="p-3 text-center">
                            <div class="button-group-horizontal">
                                <button class="btn-sm btn-edit" onclick="editPost(${post.postId}, '${post.boardName}')">수정</button>
                                <button class="btn-sm btn-delete" onclick="deletePost(${post.postId}, '${post.postTitle}')">삭제</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="d-flex justify-content-center">
            <div class="d-flex gap-1 pagination">
                <!-- 첫 페이지로 -->
                <c:if test="${pagenation.pageNum > 1}">
                    <a href="mypage-mypost.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}" class="btn btn-sm">
                        <i class="fa-solid fa-angles-left"></i>
                    </a>
                </c:if>

                <!-- 이전 블록으로 -->
                <c:if test="${pagenation.startPage > pagenation.blockSize}">
                    <a href="mypage-mypost.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}" class="btn btn-sm">
                        <i class="fa-solid fa-chevron-left"></i>
                    </a>
                </c:if>

                <!-- 페이지 번호 -->
                <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                    <a href="mypage-mypost.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}" class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                </c:forEach>

                <!-- 다음 블록으로 -->
                <c:if test="${pagenation.endPage < pagenation.totalPage}">
                    <a href="mypage-mypost.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}" class="btn btn-sm">
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                </c:if>

                <!-- 마지막 페이지로 -->
                <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                    <a href="mypage-mypost.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}" class="btn btn-sm">
                        <i class="fa-solid fa-angles-right"></i>
                    </a>
                </c:if>
            </div>
        </div>

        <!-- 글쓰기 버튼 -->
        <div class="text-end mt-3">
            <a href="boardfree-write.action" class="btn btn-primary">
                <i class="fa-solid fa-pen"></i> 글쓰기
            </a>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // 전역 변수로 현재 모드 설정
        var isPostMode = true;

        // 게시글/댓글 탭 클릭 이벤트
        $('#postsBtn').click(function(e) {
            e.preventDefault();
            if (!isPostMode) {
                $(this).addClass('active');
                $('#repliesBtn').removeClass('active');
                isPostMode = true;
                loadContent(1, true);
            }
        });

        $('#repliesBtn').click(function(e) {
            e.preventDefault();
            if (isPostMode) {
                $(this).addClass('active');
                $('#postsBtn').removeClass('active');
                isPostMode = false;
                loadContent(1, false);
            }
        });

        // 정렬 옵션 변경 이벤트
        $('select[name="sortType"]').change(function() {
            loadContent(1, isPostMode);
        });

        // 콘텐츠 로드 함수
        function loadContent(page, isPostMode) {
            var searchType = $('select[name="searchType"]').val();
            var searchKeyword = $('input[name="searchKeyword"]').val();
            var sortType = $('select[name="sortType"]').val();

            $.ajax({
                url: 'api/mypage-mypost.action',
                type: 'GET',
                data: {
                    page: page,
                    size: 10,
                    searchType: searchType,
                    searchKeyword: searchKeyword,
                    isPostMode: isPostMode,
                    sortType: sortType
                },
                dataType: 'json',
                success: function(response) {
                    if (isPostMode) {
                        updatePostTable(response);
                    } else {
                        updateReplyTable(response);
                    }
                    updatePagination(response.pagenation, isPostMode);
                },
                error: function(xhr, status, error) {
                    console.error('Error loading content:', error);
                    alert('컨텐츠를 불러오는 중 오류가 발생했습니다.');
                }
            });
        }

        // 게시글 테이블 업데이트 함수
        function updatePostTable(data) {
            var html = '';
            var postList = data.postList;

            if (postList && postList.length > 0) {
                $.each(postList, function(index, post) {
                    var categoryClass = '';
                    if (post.postLabelName === '묻고답하기') categoryClass = 'question';
                    else if (post.postLabelName === '아무말대잔치') categoryClass = 'chat';
                    else if (post.postLabelName === '고독한캠핑방') categoryClass = 'solocamping';
                    else categoryClass = 'freeboard';

                    var attachmentIcon = '';
                    if (post.attachments && post.attachments.length > 0) {
                        attachmentIcon = '<span class="attachment-icon"><i class="fa-solid fa-image"></i></span>';
                    }

                    var postUrl = '';
                    if (post.boardName === '자유게시판') postUrl = 'boardfree-post.action';
                    else if (post.boardName === '고독한캠핑방') postUrl = 'boardimage-post.action';
                    else postUrl = 'boardfree-post.action';

                    html += '<tr class="board-row border-bottom">' +
                        '<td class="p-3 text-center">' + (data.pagenation.totalPost - ((data.pagenation.pageNum - 1) * data.pagenation.pageSize) - index) + '</td>' +
                        '<td class="p-3 text-center">' + post.boardName + '</td>' +
                        '<td class="p-3 text-center"><span class="board-category-tag ' + categoryClass + '">' + post.postLabelName + '</span></td>' +
                        '<td class="p-3 title-cell"><a href="' + postUrl + '?postId=' + post.postId + '">' + post.postTitle + '</a>' + attachmentIcon + '</td>' +
                        '<td class="p-3 text-center">' + post.createdDate.substring(0, 10) + '</td>' +
                        '<td class="p-3 text-center">' + post.viewCount + '</td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>' + post.recommendCount + '</td>' +
                        '<td class="p-3 text-center">' +
                        '<div class="button-group-horizontal">' +
                        '<button class="btn-sm btn-edit" onclick="editPost(' + post.postId + ', \'' + post.boardName + '\')">수정</button>' +
                        '<button class="btn-sm btn-delete" onclick="deletePost(' + post.postId + ', \'' + post.postTitle + '\')">삭제</button>' +
                        '</div>' +
                        '</td>' +
                        '</tr>';
                });
            } else {
                html = '<tr class="board-row border-bottom"><td colspan="8" class="p-3 text-center">작성한 게시글이 없습니다.</td></tr>';
            }

            $('tbody').html(html);

            // 테이블 헤더도 변경
            var headerHtml = '<tr class="border-bottom">' +
                '<th width="7%" class="p-3 text-center">번호</th>' +
                '<th width="10%" class="p-3 text-center">게시판</th>' +
                '<th width="10%" class="p-3 text-center">분류</th>' +
                '<th width="38%" class="p-3 text-center">제목</th>' +
                '<th width="10%" class="p-3 text-center">작성일</th>' +
                '<th width="8%" class="p-3 text-center">조회수</th>' +
                '<th width="8%" class="p-3 text-center">추천수</th>' +
                '<th width="9%" class="p-3 text-center">관리</th>' +
                '</tr>';

            $('#mypost-table thead').html(headerHtml);
        }

        // 댓글 테이블 업데이트 함수
        function updateReplyTable(data) {
            var html = '';
            var replyList = data.replyList;

            if (replyList && replyList.length > 0) {
                $.each(replyList, function(index, reply) {
                    var postUrl = '';
                    if (reply.boardName === '자유게시판') postUrl = 'boardfree-post.action';
                    else if (reply.boardName === '고독한캠핑방') postUrl = 'boardimage-post.action';
                    else postUrl = 'boardfree-post.action';

                    html += '<tr class="board-row border-bottom">' +
                        '<td class="p-3 text-center">' + (data.pagenation.totalPost - ((data.pagenation.pageNum - 1) * data.pagenation.pageSize) - index) + '</td>' +
                        '<td class="p-3 text-center">' + reply.boardName + '</td>' +
                        '<td class="p-3 title-cell" colspan="2"><a href="' + postUrl + '?postId=' + reply.postId + '">' + reply.replyContent + '</a></td>' +
                        '<td class="p-3 text-center">' + reply.createdDate.substring(0, 10) + '</td>' +
                        '<td class="p-3 text-center" colspan="2"><a href="' + postUrl + '?postId=' + reply.postId + '">' + reply.postTitle + '</a></td>' +
                        '<td class="p-3 text-center">' +
                        '<div class="button-group-horizontal">' +
                        '<button class="btn-sm btn-delete" onclick="deleteReply(' + reply.replyId + ')">삭제</button>' +
                        '</div>' +
                        '</td>' +
                        '</tr>';
                });
            } else {
                html = '<tr class="board-row border-bottom"><td colspan="8" class="p-3 text-center">작성한 댓글이 없습니다.</td></tr>';
            }

            $('tbody').html(html);

            // 테이블 헤더도 변경
            var headerHtml = '<tr class="border-bottom">' +
                '<th width="7%" class="p-3 text-center">번호</th>' +
                '<th width="10%" class="p-3 text-center">게시판</th>' +
                '<th width="48%" class="p-3 text-center" colspan="2">댓글 내용</th>' +
                '<th width="10%" class="p-3 text-center">작성일</th>' +
                '<th width="16%" class="p-3 text-center" colspan="2">원글 제목</th>' +
                '<th width="9%" class="p-3 text-center">관리</th>' +
                '</tr>';

            $('#mypost-table thead').html(headerHtml);
        }

        // 페이지네이션 업데이트 함수
        function updatePagination(pagenation, isPostMode) {
            var html = '';
            var contentMode = isPostMode ? 'posts' : 'replies';

            // 첫 페이지로
            if (pagenation.pageNum > 1) {
                html += '<a href="#" class="btn btn-sm page-link" data-page="1" data-mode="' + contentMode + '">' +
                    '<i class="fa-solid fa-angles-left"></i></a>';
            }

            // 이전 블록으로
            if (pagenation.startPage > pagenation.blockSize) {
                html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.prevPage + '" data-mode="' + contentMode + '">' +
                    '<i class="fa-solid fa-chevron-left"></i></a>';
            }

            // 페이지 번호
            for (var i = pagenation.startPage; i <= pagenation.endPage; i++) {
                html += '<a href="#" class="btn ' + (pagenation.pageNum == i ? 'btn-primary' : '') +
                    ' btn-sm page-link" data-page="' + i + '" data-mode="' + contentMode + '">' + i + '</a>';
            }

            // 다음 블록으로
            if (pagenation.endPage < pagenation.totalPage) {
                html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.nextPage + '" data-mode="' + contentMode + '">' +
                    '<i class="fa-solid fa-chevron-right"></i></a>';
            }

            // 마지막 페이지로
            if (pagenation.pageNum < pagenation.totalPage) {
                html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.totalPage + '" data-mode="' + contentMode + '">' +
                    '<i class="fa-solid fa-angles-right"></i></a>';
            }

            $('.pagination').html(html);

            // 페이지 링크에 이벤트 연결
            $('.page-link').click(function(e) {
                e.preventDefault();
                var page = $(this).data('page');
                var mode = $(this).data('mode');
                loadContent(page, mode === 'posts');
            });
        }

        // 검색 폼 제출 처리
        $('form').submit(function(e) {
            e.preventDefault();
            loadContent(1, isPostMode);
        });
    });

    // 게시글 수정 함수
    function editPost(postId, boardName) {
        let editUrl = '';
        if (boardName === '자유게시판') {
            editUrl = 'boardfree-update.action?postId=' + postId;
        } else if (boardName === '고독한캠핑방') {
            editUrl = 'boardimage-update.action?postId=' + postId;
        } else {
            editUrl = 'boardfree-update.action?postId=' + postId;
        }
        window.location.href = editUrl;
    }

    // 게시글 삭제 함수
    function deletePost(postId, postTitle) {
        if (confirm('정말로 "' + postTitle + '" 게시글을 삭제하시겠습니까?')) {
            $.ajax({
                url: '/api/post/delete.action',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ postId: postId }),
                success: function(response) {
                    if (response.success) {
                        alert('게시글이 삭제되었습니다.');
                        window.location.reload();
                    } else {
                        alert(response.message || '게시글 삭제에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다.');
                }
            });
        }
    }

    // 댓글 삭제 함수
    function deleteReply(replyId) {
        if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
            $.ajax({
                url: '/api/reply/delete.action',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ replyId: replyId }),
                success: function(response) {
                    if (response.success) {
                        alert('댓글이 삭제되었습니다.');
                        window.location.reload();
                    } else {
                        alert(response.message || '댓글 삭제에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다.');
                }
            });
        }
    }
</script>
</body>
</html>