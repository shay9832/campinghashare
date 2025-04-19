<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // 테스트를 위한 임시 관리자 정보 설정
    session.setAttribute("user_code", 1);  // 관리자 계정 코드
    session.setAttribute("user_grade", 1); // 관리자 등급 (1: 관리자)
%>

<html>
<head>
    <title>공지사항</title>

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
        $(document).ready(function (){

        });

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
                        <!-- 공지사항 목록 -->
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">14</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">캠핑 관련 허위정보 및 스팸 게시글 신고 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-03-25</td>--%>
<%--                            <td class="p-3 text-center">876</td>--%>
<%--                            <td class="p-3 text-center">28</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">13</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">커뮤니티 게시글 작성 가이드</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-03-25</td>--%>
<%--                            <td class="p-3 text-center">987</td>--%>
<%--                            <td class="p-3 text-center">45</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">12</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">혼캠족을 위한 안전 가이드라인 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-03-10</td>--%>
<%--                            <td class="p-3 text-center">1,245</td>--%>
<%--                            <td class="p-3 text-center">32</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">11</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 포인트 적립 시스템 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-02-28</td>--%>
<%--                            <td class="p-3 text-center">954</td>--%>
<%--                            <td class="p-3 text-center">67</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">10</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag update">업데이트</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">모바일 앱 베타 버전 출시 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-02-20</td>--%>
<%--                            <td class="p-3 text-center">1,678</td>--%>
<%--                            <td class="p-3 text-center">189</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">9</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 커뮤니티 이용 규칙 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-02-15</td>--%>
<%--                            <td class="p-3 text-center">2,345</td>--%>
<%--                            <td class="p-3 text-center">89</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">8</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">겨울 캠핑 안전 수칙 안내</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-01-10</td>--%>
<%--                            <td class="p-3 text-center">1,456</td>--%>
<%--                            <td class="p-3 text-center">178</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">7</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag update">업데이트</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">사이트 리뉴얼 안내 및 피드백 요청</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2025-01-05</td>--%>
<%--                            <td class="p-3 text-center">1,789</td>--%>
<%--                            <td class="p-3 text-center">156</td>--%>
<%--                        </tr>--%>
<%--                        <tr class="board-row notice border-bottom">--%>
<%--                            <td class="p-3 text-center">6</td>--%>
<%--                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>--%>
<%--                            <td class="p-3 title-cell"><a href="#">2024년 커뮤니티 운영 결산</a></td>--%>
<%--                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>--%>
<%--                            <td class="p-3 text-center">2024-12-31</td>--%>
<%--                            <td class="p-3 text-center">1,543</td>--%>
<%--                            <td class="p-3 text-center">134</td>--%>
<%--                        </tr>--%>
                        </tbody>
                    </table>
                </div>

                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="notice.action" method="get">
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
                                <a href="notice.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="notice.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="notice.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="notice.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="notice.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>

<%--                    <!-- 글쓰기 버튼 - 오른쪽 -->--%>
<%--                    <div style="flex: 1; display: flex; justify-content: flex-end;">--%>
<%--                        <c:if test="${sessionScope.user_grade eq 1}">--%>
<%--                            <button class="btn btn-primary" onclick="goToWrite()">--%>
<%--                                <i class="fa-solid fa-pen"></i> 글쓰기--%>
<%--                            </button>--%>
<%--                        </c:if>--%>
<%--                    </div>--%>

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