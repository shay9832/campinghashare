<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>BEST 게시판</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <h2 class="sidebar-title">커뮤니티</h2>
                </div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="boardbest.action" class="sidebar-link active">
                            <i class="fa-solid fa-star"></i>
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
                    <table class="w-100">
                        <thead>
                        <tr class="border-bottom">
                            <th width="5%" class="p-3 text-center">번호</th>
                            <th width="10%" class="p-3 text-center">분류</th>
                            <th width="48%" class="p-3 text-center">제목</th>
                            <th width="10%" class="p-3 text-center">작성자</th>
                            <th width="10%" class="p-3 text-center">작성일</th>
                            <th width="8%" class="p-3 text-center">조회수</th>
                            <th width="9%" class="p-3 text-center">추천</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 공지사항 -->
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center"><a href="notice.action"><span class="notice-tag">공지</span></a></td>
                            <td class="p-3 text-center"><a href="notice.action"><span class="board-category-tag notice">공지</span></a></td>
                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 커뮤니티 이용 규칙 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">1,245</td>
                            <td class="p-3 text-center">32</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center"><a href="notice.action"><span class="notice-tag">공지</span></a></td>
                            <td class="p-3 text-center"><a href="notice.action"><span class="board-category-tag notice">공지</span></a></td>
                            <td class="p-3 title-cell"><a href="#">포인트 제도 안내 및 게시글 작성 가이드</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">987</td>
                            <td class="p-3 text-center">45</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center"><a href="notice.action"><span class="notice-tag">공지</span></a></td>
                            <td class="p-3 text-center"><a href="notice.action"><span class="board-category-tag notice">공지</span></a></td>
                            <td class="p-3 title-cell"><a href="#">캠핑 관련 허위정보 및 스팸 게시글 신고 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">876</td>
                            <td class="p-3 text-center">28</td>
                        </tr>

                        <!-- 일반 게시글 -->
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13134</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=1">첫 캠핑인데 필수 장비 추천해주세요! <i class="fa-solid fa-comment table-icon icon-comment"></i> 15</a></td>
                            <td class="p-3 text-center">캠핑초보</td>
                            <td class="p-3 text-center">2025-04-04</td>
                            <td class="p-3 text-center">578</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>89</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13133</td>
                            <td class="p-3 text-center"><a href="boardimage.action"><span class="board-category-tag solocamping">고독한캠핑방</span></a></td>
                            <td class="p-3 title-cell"><a href="boardimage-post.action?postId=1">혼캠 1주년 기념 장비 리뷰 (사진 많음) <i class="fa-solid fa-image table-icon"></i> <i class="fa-solid fa-comment table-icon icon-comment"></i> 23</a></td>
                            <td class="p-3 text-center">솔로캠퍼</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">432</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>76</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13129</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=2">캠핑용 화로대 추천 (가성비 좋은 것) <i class="fa-solid fa-comment table-icon icon-comment"></i> 18</a></td>
                            <td class="p-3 text-center">불멍러버</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">398</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>65</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13125</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=3">캠핑장에서 먹기 좋은 간단 요리 레시피 공유 <i class="fa-solid fa-comment table-icon icon-comment"></i> 42</a></td>
                            <td class="p-3 text-center">캠핑셰프</td>
                            <td class="p-3 text-center">2025-04-02</td>
                            <td class="p-3 text-center">725</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>128</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13120</td>
                            <td class="p-3 text-center"><a href="boardimage.action"><span class="board-category-tag solocamping">고독한캠핑방</span></a></td>
                            <td class="p-3 title-cell"><a href="boardimage-post.action?postId=2">혼자 가기 좋은 강원도 캠핑장 추천 TOP 5 <i class="fa-solid fa-comment table-icon icon-comment"></i> 31</a></td>
                            <td class="p-3 text-center">산속여행자</td>
                            <td class="p-3 text-center">2025-04-01</td>
                            <td class="p-3 text-center">612</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>93</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13115</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=4">캠핑카 구매 전 꼭 확인해야 할 사항들 <i class="fa-solid fa-comment table-icon icon-comment"></i> 27</a></td>
                            <td class="p-3 text-center">캠핑카마스터</td>
                            <td class="p-3 text-center">2025-03-31</td>
                            <td class="p-3 text-center">542</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>87</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13110</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=5">겨울 캠핑 극복하는 방법 (따뜻하게!) <i class="fa-solid fa-comment table-icon icon-comment"></i> 19</a></td>
                            <td class="p-3 text-center">사계절캠퍼</td>
                            <td class="p-3 text-center">2025-03-30</td>
                            <td class="p-3 text-center">487</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>76</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13105</td>
                            <td class="p-3 text-center"><a href="boardimage.action"><span class="board-category-tag solocamping">고독한캠핑방</span></a></td>
                            <td class="p-3 title-cell"><a href="boardimage-post.action?postId=3">혼캠 시 안전을 위한 체크리스트 <i class="fa-solid fa-comment table-icon icon-comment"></i> 24</a></td>
                            <td class="p-3 text-center">안전제일</td>
                            <td class="p-3 text-center">2025-03-29</td>
                            <td class="p-3 text-center">523</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>91</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13100</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=6">캠핑 중 찍은 별사진 모음 (천체사진) <i class="fa-solid fa-image table-icon"></i> <i class="fa-solid fa-comment table-icon icon-comment"></i> 37</a></td>
                            <td class="p-3 text-center">별빛사냥꾼</td>
                            <td class="p-3 text-center">2025-03-28</td>
                            <td class="p-3 text-center">689</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>145</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13095</td>
                            <td class="p-3 text-center"><a href="boardfree.action"><span class="board-category-tag freeboard">자유게시판</span></a></td>
                            <td class="p-3 title-cell"><a href="boardfree-post.action?postId=7">텐트 관리법 및 수명 연장 팁 <i class="fa-solid fa-comment table-icon icon-comment"></i> 16</a></td>
                            <td class="p-3 text-center">텐트지키미</td>
                            <td class="p-3 text-center">2025-03-27</td>
                            <td class="p-3 text-center">412</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>67</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <div class="d-flex border rounded">
                            <select class="form-control-sm border-0" style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                <option>제목+내용</option>
                                <option>제목</option>
                                <option>내용</option>
                                <option>작성자</option>
                            </select>
                            <input type="text" class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요" style="padding: 8px 10px; font-size: 13px;">
                            <button class="btn border-0" style="background-color: #f8f9fa; padding: 8px 10px;">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>

                    <!-- 페이지네이션 - 중앙에 가깝게 -->
                    <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
                        <div class="d-flex gap-1">
                            <a href="#" class="btn btn-sm"><i class="fa-solid fa-chevron-left"></i></a>
                            <a href="#" class="btn btn-primary btn-sm">1</a>
                            <a href="#" class="btn btn-sm">2</a>
                            <a href="#" class="btn btn-sm">3</a>
                            <a href="#" class="btn btn-sm">4</a>
                            <a href="#" class="btn btn-sm">5</a>
                            <a href="#" class="btn btn-sm">6</a>
                            <a href="#" class="btn btn-sm">7</a>
                            <a href="#" class="btn btn-sm">8</a>
                            <a href="#" class="btn btn-sm">9</a>
                            <a href="#" class="btn btn-sm">10</a>
                            <a href="#" class="btn btn-sm"><i class="fa-solid fa-chevron-right"></i></a>
                        </div>
                    </div>

                    <!-- 오른쪽 여백 - 균형을 맞추기 위한 빈 공간 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>