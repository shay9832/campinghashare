<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>자유게시판</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

        .hot-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: #ff6b6b;
            color: white;
        }

        .hot-number {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: #ff9800;
            color: white;
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
    </style>

    <script>
        $(document).ready(function () {
            // 전역 변수로 현재 모드와 페이지 설정
            var isHotMode = ${not empty hotOnly ? 'true' : 'false'};
            var currentPage = ${not empty pagenation.pageNum ? pagenation.pageNum : 1};

            // 원본 게시글 번호를 저장할 객체
            var originalPostNumbers = {};

            // 초기 페이지 로드 시 원본 게시글 번호 저장
            $('.board-row').each(function () {
                var postId = $(this).find('a[href^="boardfree-post.action"]').attr('href');
                if (postId) {
                    postId = postId.split('postId=')[1];
                    var rowNum = $(this).find('td:first').text().trim();
                    if (rowNum !== '공지' && rowNum !== '인기') {
                        // 숫자인 경우에만 저장
                        if (!isNaN(rowNum) && rowNum !== '') {
                            originalPostNumbers[postId] = rowNum;
                        }
                    }
                }
            });

            // 인기글 버튼 클릭 이벤트
            $('#hotPostsBtn').click(function (e) {
                e.preventDefault();
                if (!isHotMode) {
                    $(this).addClass('active');
                    $('#allPostsBtn').removeClass('active');
                    isHotMode = true;
                    loadPosts(1, true); // 항상 1페이지부터 시작하도록 설정
                }
            });

            // 전체 버튼 클릭 이벤트
            $('#allPostsBtn').click(function (e) {
                e.preventDefault();
                if (isHotMode) {
                    $(this).addClass('active');
                    $('#hotPostsBtn').removeClass('active');
                    isHotMode = false;
                    loadPosts(1, false); // 항상 1페이지부터 시작하도록 설정
                }
            });

            $('select[name="sortType"]').change(function () {
                loadPosts(1, isHotMode);
            });

            // 페이지 로드 함수 업데이트
            function loadPosts(page, hotOnly) {
                var searchType = $('select[name="searchType"]').val();
                var searchKeyword = $('input[name="searchKeyword"]').val();
                var sortType = $('select[name="sortType"]').val();

                $.ajax({
                    url: '/api/boardfree.action',
                    type: 'GET',
                    data: {
                        page: page,
                        size: 10,
                        searchType: searchType,
                        searchKeyword: searchKeyword,
                        hotOnly: hotOnly,
                        sortType: sortType,
                        originalPostNumbers: JSON.stringify(originalPostNumbers)
                    },
                    dataType: 'json',
                    success: function (response) {
                        updateTable(response);
                        updatePagination(response.pagenation, hotOnly);
                        currentPage = page;

                        // URL 파라미터 업데이트 (브라우저 히스토리에 상태 저장)
                        var newUrl = 'boardfree.action?page=' + page;
                        if (hotOnly) {
                            newUrl += '&hotOnly=true';
                        }
                        if (searchKeyword) {
                            newUrl += '&searchType=' + searchType + '&searchKeyword=' + encodeURIComponent(searchKeyword);
                        }
                        history.pushState({page: page, hotOnly: hotOnly}, '', newUrl);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error loading posts:', error);
                        alert('게시글을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            // 뒤로가기 버튼 처리
            window.addEventListener('popstate', function (e) {
                if (e.state) {
                    var hotOnly = e.state.hotOnly;
                    var page = e.state.page || 1;

                    // 버튼 상태 업데이트
                    if (hotOnly) {
                        $('#hotPostsBtn').addClass('active');
                        $('#allPostsBtn').removeClass('active');
                        isHotMode = true;
                    } else {
                        $('#allPostsBtn').addClass('active');
                        $('#hotPostsBtn').removeClass('active');
                        isHotMode = false;
                    }

                    // 데이터 로드
                    loadPosts(page, hotOnly);
                }
            });

            // 테이블 업데이트 함수
            function updateTable(data) {
                var html = '';

                // 공지사항 표시
                $.each(data.notice, function (index, notice) {
                    html += '<tr class="board-row notice border-bottom">' +
                        '<td class="p-3 text-center"><a href="notice.action"><span class="notice-tag">공지</span></a></td>' +
                        '<td class="p-3 text-center"><a href="notice.action"><span class="board-category-tag notice">공지</span></a></td>' +
                        '<td class="p-3 title-cell"><a href="notice.action">' + notice.postTitle + '</a></td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>' +
                        '<td class="p-3 text-center">' + notice.createdDate.substring(0, 10) + '</td>' +
                        '<td class="p-3 text-center">' + notice.viewCount + '</td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>' + notice.recommendCount + '</td>' +
                        '</tr>';
                });

                // 상단 인기글 표시 (항상 최신 3개) - 배경색 적용
                $.each(data.topHotPosts, function (index, post) {
                    html += '<tr class="board-row hot-post border-bottom">' +
                        '<td class="p-3 text-center"><span class="hot-number">인기</span></td>' +
                        '<td class="p-3 text-center"><span class="board-category-tag ' +
                        getCategoryClass(post.postLabelName) + '">' + post.postLabelName + '</span></td>' +
                        '<td class="p-3 title-cell"><a href="boardfree-post.action?postId=' + post.postId + '">' + post.postTitle + '</a></td>' +
                        '<td class="p-3 text-center">' + post.nickName + '</td>' +
                        '<td class="p-3 text-center">' + post.createdDate.substring(0, 10) + '</td>' +
                        '<td class="p-3 text-center">' + post.viewCount + '</td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>' + post.recommendCount + '</td>' +
                        '</tr>';
                });

                // 게시글 목록 표시 (인기글 모드면 인기글만, 일반 모드면 일반 게시글)
                if (data.postList && data.postList.length > 0) {
                    $.each(data.postList, function (index, post) {
                        // 원본 번호가 있으면 사용, 없으면 서버에서 받은 rowNum 사용
                        var displayNumber = '';
                        if (originalPostNumbers[post.postId]) {
                            displayNumber = originalPostNumbers[post.postId];
                        } else {
                            displayNumber = post.rowNum || '';
                            // 새로운 게시글이라면 원본 번호로 저장
                            if (displayNumber !== '') {
                                originalPostNumbers[post.postId] = displayNumber;
                            }
                        }

                        // 첨부파일 아이콘 추가
                        var attachmentIcon = '';
                        if (post.attachments && post.attachments.length > 0) {
                            attachmentIcon = '<span class="attachment-icon"><i class="fa-solid fa-image"></i></span>';
                        }

                        html += '<tr class="board-row border-bottom">' +
                            '<td class="p-3 text-center">' + displayNumber + '</td>' +
                            '<td class="p-3 text-center"><span class="board-category-tag ' +
                            getCategoryClass(post.postLabelName) + '">' + post.postLabelName + '</span></td>' +
                            '<td class="p-3 title-cell"><a href="boardfree-post.action?postId=' + post.postId + '">' + post.postTitle + '</a>' +
                            attachmentIcon + '</td>' +
                            '<td class="p-3 text-center">' + post.nickName + '</td>' +
                            '<td class="p-3 text-center">' + post.createdDate.substring(0, 10) + '</td>' +
                            '<td class="p-3 text-center">' + post.viewCount + '</td>' +
                            '<td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>' + post.recommendCount + '</td>' +
                            '</tr>';
                    });
                }

                // 게시글이 없을 경우
                if (data.notice.length === 0 && data.topHotPosts.length === 0 && (!data.postList || data.postList.length === 0)) {
                    html += '<tr class="board-row border-bottom"><td colspan="7" class="p-3 text-center">게시글이 없습니다.</td></tr>';
                }

                $('tbody').html(html);
            }

            // 카테고리 클래스 반환 함수
            function getCategoryClass(labelName) {
                if (labelName === '묻고답하기') return 'question';
                if (labelName === '아무말대잔치') return 'chat';
                return '';
            }

            // 페이지네이션 업데이트 함수
            function updatePagination(pagenation, hotOnly) {
                var html = '';

                // 첫 페이지로
                if (pagenation.pageNum > 1) {
                    html += '<a href="#" class="btn btn-sm page-link" data-page="1">' +
                        '<i class="fa-solid fa-angles-left"></i></a>';
                }

                // 이전 블록으로
                if (pagenation.startPage > pagenation.blockSize) {
                    html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.prevPage + '">' +
                        '<i class="fa-solid fa-chevron-left"></i></a>';
                }

                // 페이지 번호
                for (var i = pagenation.startPage; i <= pagenation.endPage; i++) {
                    html += '<a href="#" class="btn ' + (pagenation.pageNum == i ? 'btn-primary' : '') +
                        ' btn-sm page-link" data-page="' + i + '">' + i + '</a>';
                }

                // 다음 블록으로
                if (pagenation.endPage < pagenation.totalPage) {
                    html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.nextPage + '">' +
                        '<i class="fa-solid fa-chevron-right"></i></a>';
                }

                // 마지막 페이지로
                if (pagenation.pageNum < pagenation.totalPage) {
                    html += '<a href="#" class="btn btn-sm page-link" data-page="' + pagenation.totalPage + '">' +
                        '<i class="fa-solid fa-angles-right"></i></a>';
                }

                $('.pagination').html(html);

                // 페이지 링크에 이벤트 연결
                $('.page-link').click(function (e) {
                    e.preventDefault();
                    var page = $(this).data('page');
                    loadPosts(page, hotOnly);
                });
            }

            // 검색 폼 제출 처리
            $('form').submit(function (e) {
                e.preventDefault();
                loadPosts(1, isHotMode);
            });
        });

        // 글쓰기 페이지로
        function goToWrite() {
            window.location.href = "boardfree-write.action";
        }
    </script>
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

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <a href="boardfree.action"><h1 class="page-title"><i class="fa-solid fa-comments"></i> 자유게시판</h1>
                    </a>
                </div>

                <!-- 정렬 및 필터 옵션 -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <select name="sortType" class="form-control-sm">
                            <option value="recent">최신순</option>
                            <option value="views">조회순</option>
                            <option value="recommends">추천순</option>
                        </select>

                        <div style="display: flex; margin-left: 20px;">
                            <a href="#" id="allPostsBtn" class="filter-btn ${empty hotOnly ? 'active' : ''}"
                               style="border-radius: 4px; margin-right: 10px; min-width: 80px; text-align: center;">전체</a>
                            <a href="#" id="hotPostsBtn" class="filter-btn ${not empty hotOnly ? 'active' : ''}"
                               style="border-radius: 4px; min-width: 80px; text-align: center;">인기글</a>
                        </div>
                    </div>
                </div>

                <!-- 게시글 테이블 -->
                <div class="content-box mb-5">
                    <table class="w-100" id="boardfree-table">
                        <thead>
                        <tr class="border-bottom">
                            <th width="6%" class="p-3 text-center">번호</th>
                            <th width="8%" class="p-3 text-center">분류</th>
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

                        <!-- 인기글 -->
                        <c:forEach var="boardHotPosts" items="${boardHotPosts}">
                            <tr class="board-row hot-post border-bottom">
                                <td class="p-3 text-center"><span class="hot-number">인기</span></td>
                                <td class="p-3 text-center"><span class="board-category-tag
                                                            ${boardHotPosts.postLabelName == '묻고답하기' ? 'question' :
                                                            boardHotPosts.postLabelName == '후기' ? 'review' :
                                                            boardHotPosts.postLabelName == '잡담' ? 'chat' :
                                                            boardHotPosts.postLabelName == '아무말대잔치' ? 'freeboard' : ''}">${boardHotPosts.postLabelName}</span>
                                </td>
                                <td class="p-3 title-cell"><a
                                        href="boardfree-post.action?postId=${boardHotPosts.postId}">${boardHotPosts.postTitle}</a>
                                </td>
                                <td class="p-3 text-center">${boardHotPosts.nickName}</td>
                                <td class="p-3 text-center">${boardHotPosts.createdDate.substring(0, 10)}</td>
                                <td class="p-3 text-center">${boardHotPosts.viewCount}</td>
                                <td class="p-3 text-center"><i
                                        class="fa-solid fa-heart table-icon icon-heart"></i>${boardHotPosts.recommendCount}
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- 일반 게시글 -->
                        <c:forEach var="postList" items="${postList}" varStatus="status">
                            <tr class="board-row border-bottom">
                                <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
                                <td class="p-3 text-center"><span class="board-category-tag
                                                            ${postList.postLabelName == '묻고답하기' ? 'question' :
                                                              postList.postLabelName == '아무말대잔치' ? 'chat' : 'freeboard'}">${postList.postLabelName}</span>
                                </td>
                                <td class="p-3 title-cell"><a
                                        href="boardfree-post.action?postId=${postList.postId}">${postList.postTitle}</a>
                                    <c:if test="${not empty postList.attachments}">
                                        <span class="attachment-icon">
                                            <i class="fa-solid fa-image"></i>
                                        </span>
                                    </c:if>
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
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
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

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>