<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>공지사항</title>

    <!-- jQuery 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <style>
        /* 공지사항 테이블에만 적용되는 스타일 */
        #notice-table th,
        #notice-table td {
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

        .board-category-tag.notice {
            background-color: #fff9c4;
            color: #ffa000;
        }

        .board-category-tag.important {
            background-color: #ffebee;
            color: #d32f2f;
        }

        .board-category-tag.update {
            background-color: #e3f2fd;
            color: #0066cc;
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

    <script>
        $(document).ready(function() {
            // 전역 변수로 현재 페이지 설정
            var currentPage = ${not empty pagenation.pageNum ? pagenation.pageNum : 1};

            // 원본 게시글 번호를 저장할 객체
            var originalPostNumbers = {};

            // 초기 페이지 로드 시 원본 게시글 번호 저장
            $('.board-row').each(function() {
                var postId = $(this).find('a[href^="noticepost.action"]').attr('href');
                if (postId) {
                    postId = postId.split('postId=')[1];
                    var rowNum = $(this).find('td:first').text().trim();
                    if (rowNum !== '공지' && rowNum !== '중요') {
                        // 숫자인 경우에만 저장
                        if (!isNaN(rowNum) && rowNum !== '') {
                            originalPostNumbers[postId] = rowNum;
                        }
                    }
                }
            });

            // 정렬 셀렉트 박스의 변경 이벤트 처리
            $('select[name="sortType"]').on('change', function() {
                loadPosts(1);
            });

            // 페이지 로드 함수 업데이트
            function loadPosts(page) {
                var searchType = $('select[name="searchType"]').val();
                var searchKeyword = $('input[name="searchKeyword"]').val();
                var sortType = $('select[name="sortType"]').val();

                console.log("로딩 페이지: " + page + ", 정렬: " + sortType + ", 검색: " + searchType + ":" + searchKeyword);

                $.ajax({
                    url: 'api/notice.action',
                    type: 'GET',
                    data: {
                        page: page,
                        size: 10,
                        sortType: sortType,
                        searchType: searchType,
                        searchKeyword: searchKeyword,
                        originalPostNumbers: JSON.stringify(originalPostNumbers)
                    },
                    dataType: 'json',
                    success: function(response) {
                        console.log("응답 성공:", response);
                        updateTable(response);
                        updatePagination(response.pagenation);
                        currentPage = page;

                        // URL 파라미터 업데이트 (브라우저 히스토리에 상태 저장)
                        var newUrl = 'notice.action?page=' + page;
                        if (searchKeyword) {
                            newUrl += '&searchType=' + searchType + '&searchKeyword=' + encodeURIComponent(searchKeyword);
                        }
                        if (sortType && sortType !== 'recent') {
                            newUrl += '&sortType=' + sortType;
                        }
                        history.pushState({page: page, sortType: sortType, searchType: searchType, searchKeyword: searchKeyword}, '', newUrl);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error loading notices:', error);
                        alert('공지사항을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            // 뒤로가기 버튼 처리
            window.addEventListener('popstate', function(e) {
                if (e.state) {
                    var page = e.state.page || 1;
                    var sortType = e.state.sortType || 'recent';

                    // 정렬 셀렉트 박스 업데이트
                    $('select[name="sortType"]').val(sortType);

                    // 데이터 로드
                    loadPosts(page);
                }
            });

            // 업데이트 테이블 함수 수정
            function updateTable(data) {
                var html = '';

                // 디버깅 출력 추가
                console.log("받은 데이터:", data);

                // 공지사항 표시
                if (data.noticeList && data.noticeList.length > 0) {
                    $.each(data.noticeList, function(index, notice) {
                        var categoryClass = '';
                        if (notice.postLabelName === '중요') {
                            categoryClass = 'important';
                        } else if (notice.postLabelName === '공지') {
                            categoryClass = 'notice';
                        } else if (notice.postLabelName === '업데이트') {
                            categoryClass = 'update';
                        }

                        // 번호 계산 방식 수정
                        var displayNumber = '';
                        if (originalPostNumbers[notice.postId]) {
                            displayNumber = originalPostNumbers[notice.postId];
                        } else {
                            displayNumber = data.pagenation.totalPost - ((data.pagenation.pageNum - 1) * data.pagenation.pageSize) - index;
                            // 새로운 게시글이면 원본 번호로 저장
                            if (displayNumber) {
                                originalPostNumbers[notice.postId] = displayNumber;
                            }
                        }

                        html += '<tr class="board-row notice border-bottom">' +
                            '<td class="p-3 text-center">' + displayNumber + '</td>' +
                            '<td class="p-3 text-center"><span class="board-category-tag ' + categoryClass + '">' +
                            (notice.postLabelName || '') + '</span></td>' +
                            '<td class="p-3 title-cell"><a href="noticepost.action?postId=' + notice.postId + '">' +
                            notice.postTitle + '</a></td>' +
                            '<td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>' +
                            '<td class="p-3 text-center">' +
                            (notice.createdDate ? notice.createdDate.substring(0, 10) : 'N/A') + '</td>' +
                            '<td class="p-3 text-center">' + (notice.viewCount || 0) + '</td>' +
                            '<td class="p-3 text-center">' + (notice.recommendCount || 0) + '</td>' +
                            '</tr>';
                    });
                } else {
                    html += '<tr><td colspan="7" class="text-center p-3">검색 결과가 없습니다.</td></tr>';
                }

                $('#notice-table tbody').html(html);
            }

            // 페이지네이션 업데이트 함수
            function updatePagination(pagenation) {
                var html = '';
                var searchType = $('select[name="searchType"]').val();
                var searchKeyword = $('input[name="searchKeyword"]').val();
                var sortType = $('select[name="sortType"]').val();

                // 검색 파라미터 문자열 생성
                var searchParams = '';
                if (searchKeyword) {
                    searchParams += '&searchType=' + searchType + '&searchKeyword=' + encodeURIComponent(searchKeyword);
                }

                // 정렬 파라미터 문자열 생성
                var sortParams = '';
                if (sortType && sortType !== 'recent') {
                    sortParams += '&sortType=' + sortType;
                }

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
                    var activeClass = (pagenation.pageNum == i) ? 'btn-primary' : '';
                    html += '<a href="#" class="btn ' + activeClass + ' btn-sm page-link" data-page="' + i + '">' + i + '</a>';
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

                // 페이지네이션 링크 이벤트 처리
                $('.page-link').on('click', function(e) {
                    e.preventDefault();
                    var page = $(this).data('page');
                    loadPosts(page);
                });
            }

            // 검색 폼 제출 처리
            $('form').submit(function(e) {
                e.preventDefault();
                loadPosts(1);
            });
        });

        // 글쓰기 페이지로
        function goToWrite() {
            window.location.href = "notice-write.action";
        }
    </script>

</head>
<body>
<jsp:include page="header.jsp"/>

<div class="page-wrapper">
    <div class="container section" style="width: 100%; max-width: 1500px; padding: 0 15px; margin: 0 auto;">
        <div class="main-content my-5">
            <!-- 메인 콘텐츠 -->
            <div class="w-100">
                <div class="page-header">
                    <a href="notice.action"><h1 class="page-title"><i class="fa-solid fa-bullhorn"></i> 공지사항</h1></a>
                </div>

                <!-- 정렬 옵션 -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <select name="sortType" class="form-control-sm">
                            <option value="recent" ${param.sortType == 'recent' || empty param.sortType ? 'selected' : ''}>최신순</option>
                            <option value="views" ${param.sortType == 'views' ? 'selected' : ''}>조회순</option>
                            <option value="recommends" ${param.sortType == 'recommends' ? 'selected' : ''}>추천순</option>
                        </select>
                    </div>
                </div>

                <!-- 게시글 테이블 -->
                <div class="content-box mb-5">
                    <table class="w-100" id="notice-table">
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
                        <c:forEach var="noticeList" items="${noticeList}" varStatus="status">
                            <tr class="board-row notice border-bottom">
                                <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
                                <td class="p-3 text-center"><span class="board-category-tag
                                                             ${noticeList.postLabelName == '중요' ? 'important' :
                                                               noticeList.postLabelName == '공지' ? 'notice' :
                                                               noticeList.postLabelName == '업데이트' ? 'update' : ''}">${noticeList.postLabelName}</span></td>
                                <td class="p-3 title-cell"><a href="noticepost.action?postId=${noticeList.postId}">${noticeList.postTitle}</a></td>
                                <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                                <td class="p-3 text-center">${noticeList.createdDate.substring(0, 10)}</td>
                                <td class="p-3 text-center">${noticeList.viewCount}</td>
                                <td class="p-3 text-center">${noticeList.recommendCount}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="notice.action" method="get" onsubmit="return false;">
                            <input type="hidden" name="sortType" value="${param.sortType}">
                            <div class="d-flex border rounded">
                                <select name="searchType" class="form-control-sm border-0"
                                        style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                    <option value="titlecontent" ${searchType == 'titlecontent' ? 'selected' : ''}>
                                        제목+내용
                                    </option>
                                    <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                                    <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
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
                                <a href="notice.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}${not empty param.sortType ? '&sortType='.concat(param.sortType) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="notice.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}${not empty param.sortType ? '&sortType='.concat(param.sortType) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="notice.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}${not empty param.sortType ? '&sortType='.concat(param.sortType) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="notice.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}${not empty param.sortType ? '&sortType='.concat(param.sortType) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="notice.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}${not empty param.sortType ? '&sortType='.concat(param.sortType) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>

                    <!-- 글쓰기 버튼 - 오른쪽 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;">
                        <c:if test="${not empty adminId}">
                            <button class="btn btn-primary" onclick="goToWrite()">
                                <i class="fa-solid fa-pen"></i> 글쓰기
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>

</html>