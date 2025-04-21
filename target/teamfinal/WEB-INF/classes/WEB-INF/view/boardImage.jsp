<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>고독한캠핑방</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* 테이블에만 적용되는 스타일 */
        #boardimage-table th,
        #boardimage-table td {
            width: auto !important;
            min-width: auto !important;
        }

        /* 게시판 특화 스타일 - 기존 코드 유지 */
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

        .filter-btn {
            padding: 6px 16px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-medium);
            background-color: var(--bg-secondary);
            cursor: pointer;
            transition: all var(--transition-normal);
            font-size: var(--font-xs);
            min-width: 80px;
            text-align: center;
            margin-right: 10px;
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

        /* 카드 그리드 수정 - cards.css 활용 */
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

    <script>
        function goToWrite() {
            window.location.href = "boardimage-write.action";
        }

        $(document).ready(function () {
            // 전역 변수로 현재 모드와 페이지 설정
            var isHotMode = ${not empty hotOnly ? 'true' : 'false'};
            var currentPage = ${not empty pagenation.pageNum ? pagenation.pageNum : 1};

            // 원본 게시글 번호를 저장할 객체
            var originalPostNumbers = {};

            // 초기 페이지 로드 시 원본 게시글 번호 저장
            $('.board-row').each(function () {
                var postId = $(this).find('a[href^="boardimage-post.action"]').attr('href');
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

            // 카드 그리드에서도 원본 번호 저장
            $('.simple-card').each(function () {
                var href = $(this).attr('href');
                if (href) {
                    var postId = href.split('postId=')[1];
                    // 카드에는 표시되는 번호가 없으므로 originalPostNumbers에 저장되어 있는지만 확인
                    if (!originalPostNumbers[postId]) {
                        // API 통신 후 채워질 수 있도록 예약
                    }
                }
            });

            // 인기글 버튼 클릭 이벤트
            $('.filter-btn:contains("인기글")').click(function (e) {
                e.preventDefault();
                if (!isHotMode) {
                    $(this).addClass('active');
                    $('.filter-btn:contains("전체")').removeClass('active');
                    isHotMode = true;
                    loadPosts(1, true); // 항상 1페이지부터 시작하도록 설정
                }
            });

            // 전체 버튼 클릭 이벤트
            $('.filter-btn:contains("전체")').click(function (e) {
                e.preventDefault();
                if (isHotMode) {
                    $(this).addClass('active');
                    $('.filter-btn:contains("인기글")').removeClass('active');
                    isHotMode = false;
                    loadPosts(1, false); // 항상 1페이지부터 시작하도록 설정
                }
            });

            // 페이지 로드 함수 업데이트
            function loadPosts(page, hotOnly) {
                var searchType = $('select[name="searchType"]').val();
                var searchKeyword = $('input[name="searchKeyword"]').val();

                $.ajax({
                    url: '/api/boardimage.action',
                    type: 'GET',
                    data: {
                        page: page,
                        size: 10,
                        searchType: searchType,
                        searchKeyword: searchKeyword,
                        hotOnly: hotOnly,
                        originalPostNumbers: JSON.stringify(originalPostNumbers) // 원본 번호 전달
                    },
                    dataType: 'json',
                    success: function (response) {
                        updateContent(response);
                        updatePagination(response.pagenation, hotOnly);
                        currentPage = page;

                        // URL 파라미터 업데이트 (브라우저 히스토리에 상태 저장)
                        var newUrl = 'boardimage.action?page=' + page;
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
                        $('.filter-btn:contains("인기글")').addClass('active');
                        $('.filter-btn:contains("전체")').removeClass('active');
                        isHotMode = true;
                    } else {
                        $('.filter-btn:contains("전체")').addClass('active');
                        $('.filter-btn:contains("인기글")').removeClass('active');
                        isHotMode = false;
                    }

                    // 데이터 로드
                    loadPosts(page, hotOnly);
                }
            });

            // 테이블 및 카드 그리드 업데이트 함수
            function updateContent(data) {
                // 공지사항 테이블 업데이트
                var noticeHtml = '';

                // 공지사항 표시
                $.each(data.notice, function (index, notice) {
                    noticeHtml += '<tr class="board-row notice border-bottom">' +
                        '<td class="p-3 text-center"><a href="notice.action"><span class="notice-tag">공지</span></a></td>' +
                        '<td class="p-3 text-center"><a href="notice.action"><span class="board-category-tag notice">공지</span></a></td>' +
                        '<td class="p-3 title-cell"><a href="notice.action">' + notice.postTitle + '</a></td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>' +
                        '<td class="p-3 text-center">' + notice.createdDate.substring(0, 10) + '</td>' +
                        '<td class="p-3 text-center">' + notice.viewCount + '</td>' +
                        '<td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>' + notice.recommendCount + '</td>' +
                        '</tr>';
                });

                // 공지사항이 없을 때
                if (data.notice.length === 0) {
                    noticeHtml += '<tr class="board-row border-bottom"><td colspan="7" class="p-3 text-center">공지사항이 없습니다.</td></tr>';
                }

                $('table tbody').html(noticeHtml);

                // 게시글 카드 그리드 업데이트
                var postsHtml = '';
                if (data.postList && data.postList.length > 0) {
                    $.each(data.postList, function (index, post) {
                        // 원본 번호 저장 코드 (기존 코드 유지)

                        // 이미지 또는 아이콘 HTML 생성
                        var imageHtml = '';
                        if (post.attachments && post.attachments.length > 0) {
                            // 첨부파일이 있으면 첫번째 이미지 표시
                            imageHtml = '<img src="' + post.attachments[0].attachmentPath + '" alt="' + post.postTitle + '" style="width: 100%; height: 100%; object-fit: cover;">';
                        } else {
                            // 첨부파일이 없으면 기본 아이콘 표시
                            imageHtml = '<i class="fa-solid fa-' + getIconForLabel(post.postLabelName) + '"></i>';
                        }

                        postsHtml += '<a href="boardimage-post.action?postId=' + post.postId + '" class="simple-card">' +
                            '<div class="simple-card-image">' +
                            imageHtml +
                            '</div>' +
                            '<div class="simple-card-content">' +
                            '<h3 class="simple-card-title">' + post.postTitle + '</h3>' +
                            '<div class="simple-card-author">' + post.nickName + '</div>' +
                            '<div class="simple-card-footer">' +
                            '<div class="simple-card-date">' + post.createdDate.substring(0, 10) + '</div>' +
                            '<div class="simple-card-stats">' +
                            '<div class="simple-card-stat">' +
                            '<i class="fa-solid fa-eye"></i>' +
                            '<span>' + post.viewCount + '</span>' +
                            '</div>' +
                            '<div class="simple-card-stat">' +
                            '<i class="fa-solid fa-heart"></i>' +
                            '<span>' + post.recommendCount + '</span>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</a>';
                    });
                } else {
                    postsHtml = '<div class="text-center p-5">게시글이 없습니다.</div>';
                }

                $('.posts-grid').html(postsHtml);
            }

            // 말머리에 따른 아이콘 반환 함수
            function getIconForLabel(labelName) {
                if (labelName === '후기') return 'mountain-sun';
                if (labelName === '정보') return 'map-location-dot';
                if (labelName === '장비') return 'campground';
                if (labelName === '안전') return 'shield-halved';
                if (labelName === '여성') return 'venus';
                if (labelName === '사진') return 'camera';
                if (labelName === '초보') return 'hiking';
                if (labelName === '꿀팁') return 'lightbulb';
                if (labelName === '요리') return 'utensils';
                // 기본 아이콘
                return 'person-hiking';
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

                $('.d-flex.gap-1').html(html);

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

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <a href="boardimage.action"><h1 class="page-title"><i class="fa-solid fa-person-hiking"></i> 고독한캠핑방
                    </h1></a>
                </div>

                <!-- 정렬 및 필터 옵션 -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <select class="form-control-sm">
                            <option>정렬</option>
                            <option>최신순</option>
                            <option>조회순</option>
                            <option>추천순</option>
                        </select>

                        <div style="display: flex; margin-left: 20px;">
                            <a href="#" class="filter-btn active"
                               style="border-radius: 4px; margin-right: 10px;  min-width: 80px; text-align: center;">전체</a>
                            <a href="#" class="filter-btn"
                               style="border-radius: 4px; min-width: 80px; text-align: center;">인기글</a>
                        </div>
                    </div>
                </div>

                <!-- 공지사항 테이블 -->
                <div class="content-box mb-5">
                    <table class="w-100" id="boardimage-table">
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
                        </tbody>
                    </table>
                </div>


                <!-- 심플 카드 형식의 게시판 -->
                <div class="posts-grid">
                    <c:forEach var="postList" items="${postList}">
                        <a href="boardimage-post.action?postId=${postList.postId}" class="simple-card">
                            <div class="simple-card-image">
                                <c:choose>
                                    <c:when test="${not empty postList.attachments && postList.attachments.size() > 0}">
                                        <!-- 첨부파일이 있으면 첫번째 이미지 표시 -->
                                        <img src="${postList.attachments[0].attachmentPath}" alt="${postList.postTitle}" style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 첨부파일이 없으면 기본 아이콘 표시 -->
                                        <i class="fa-solid fa-mountain-sun"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">${postList.postTitle}</h3>
                                <div class="simple-card-author">${postList.nickName}</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">${postList.createdDate.substring(0, 10)}</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>${postList.viewCount}</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>${postList.recommendCount}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="boardfree.action" method="get">
                            <div class="d-flex border rounded">
                                <select name="searchType" class="form-control-sm border-0"
                                        style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                    <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
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
                        <div class="d-flex gap-1">
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

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>