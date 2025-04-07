<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>자유게시판</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="resources/css/main.css">
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
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

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
                        <a href="#" class="sidebar-link">
                            <i class="fa-solid fa-star"></i>
                            <span>BEST</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="#" class="sidebar-link active">
                            <i class="fa-solid fa-comments"></i>
                            <span>자유게시판</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="#" class="sidebar-link">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-comments"></i> 자유게시판</h1>
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
                            <a href="#" class="filter-btn active" style="border-radius: 4px; margin-right: 10px;  min-width: 80px; text-align: center;">전체</a>
                            <a href="#" class="filter-btn" style="border-radius: 4px; min-width: 80px; text-align: center;">인기글</a>
                        </div>
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
                            <td class="p-3 text-center"><span class="notice-tag">공지</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">자유게시판 이용 규칙 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">1,245</td>
                            <td class="p-3 text-center">32</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center"><span class="notice-tag">공지</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑 관련 허위정보 및 스팸 게시글 신고 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">876</td>
                            <td class="p-3 text-center">28</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center"><span class="notice-tag">공지</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">커뮤니티 게시글 작성 가이드</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">987</td>
                            <td class="p-3 text-center">45</td>
                        </tr>

                        <!-- 인기글 -->
                        <tr class="board-row hot-post border-bottom">
                            <td class="p-3 text-center"><span class="hot-number">인기</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">좋은 캠핑장 추천 부탁드려요!</a></td>
                            <td class="p-3 text-center">물멍러버</td>
                            <td class="p-3 text-center">2025-04-04</td>
                            <td class="p-3 text-center">428</td>
                            <td class="p-3 text-center">78</td>
                        </tr>
                        <tr class="board-row hot-post border-bottom">
                            <td class="p-3 text-center"><span class="hot-number">인기</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag review">후기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑 요리 장비 추천 (사진 많음)</a></td>
                            <td class="p-3 text-center">캠핑셰프</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">392</td>
                            <td class="p-3 text-center">65</td>
                        </tr>
                        <tr class="board-row hot-post border-bottom">
                            <td class="p-3 text-center"><span class="hot-number">인기</span></td>
                            <td class="p-3 text-center"><span class="board-category-tag chat">잡담</span></td>
                            <td class="p-3 title-cell"><a href="#">아무말 대잔치 (웃긴 캠핑 에피소드)</a></td>
                            <td class="p-3 text-center">웃음사냥꾼</td>
                            <td class="p-3 text-center">2025-04-02</td>
                            <td class="p-3 text-center">512</td>
                            <td class="p-3 text-center">98</td>
                        </tr>

                        <!-- 일반 게시글 -->
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13134</td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">텐트 추천 부탁드려요 (4인용)</a></td>
                            <td class="p-3 text-center">텐트초보</td>
                            <td class="p-3 text-center">2025-04-04</td>
                            <td class="p-3 text-center">87</td>
                            <td class="p-3 text-center">12</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13133</td>
                            <td class="p-3 text-center"><span class="board-category-tag review">후기</span></td>
                            <td class="p-3 title-cell"><a href="#">충청도 바다뷰 캠핑장 다녀왔어요!</a></td>
                            <td class="p-3 text-center">바다사랑</td>
                            <td class="p-3 text-center">2025-04-04</td>
                            <td class="p-3 text-center">124</td>
                            <td class="p-3 text-center">23</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13132</td>
                            <td class="p-3 text-center"><span class="board-category-tag chat">잡담</span></td>
                            <td class="p-3 title-cell"><a href="#">아무말 대잔치 (웃긴 캠핑 에피소드)</a></td>
                            <td class="p-3 text-center">웃음사냥꾼</td>
                            <td class="p-3 text-center">2025-04-04</td>
                            <td class="p-3 text-center">215</td>
                            <td class="p-3 text-center">42</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13131</td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑카 대여 어디가 좋나요?</a></td>
                            <td class="p-3 text-center">제주여행자</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">156</td>
                            <td class="p-3 text-center">18</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13130</td>
                            <td class="p-3 text-center"><span class="board-category-tag review">후기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑용 화로대 추천 (가성비 좋은 것)</a></td>
                            <td class="p-3 text-center">불멍러버</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">198</td>
                            <td class="p-3 text-center">35</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13129</td>
                            <td class="p-3 text-center"><span class="board-category-tag chat">잡담</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑 중 만난 야생동물 이야기</a></td>
                            <td class="p-3 text-center">자연사랑</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">227</td>
                            <td class="p-3 text-center">44</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13128</td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">가족 캠핑 초보인데 팁 부탁드려요</a></td>
                            <td class="p-3 text-center">행복한아빠</td>
                            <td class="p-3 text-center">2025-04-02</td>
                            <td class="p-3 text-center">183</td>
                            <td class="p-3 text-center">29</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13127</td>
                            <td class="p-3 text-center"><span class="board-category-tag review">후기</span></td>
                            <td class="p-3 title-cell"><a href="#">새로 산 침낭 추천합니다 (겨울용)</a></td>
                            <td class="p-3 text-center">따뜻하게</td>
                            <td class="p-3 text-center">2025-04-02</td>
                            <td class="p-3 text-center">135</td>
                            <td class="p-3 text-center">22</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13126</td>
                            <td class="p-3 text-center"><span class="board-category-tag chat">잡담</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑장에서 마주친 웃긴 상황</a></td>
                            <td class="p-3 text-center">유머왕</td>
                            <td class="p-3 text-center">2025-04-01</td>
                            <td class="p-3 text-center">246</td>
                            <td class="p-3 text-center">56</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13125</td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑용 테이블 추천 부탁드립니다</a></td>
                            <td class="p-3 text-center">테이블고수</td>
                            <td class="p-3 text-center">2025-04-01</td>
                            <td class="p-3 text-center">167</td>
                            <td class="p-3 text-center">24</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13131</td>
                            <td class="p-3 text-center"><span class="board-category-tag question">묻고답하기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑카 대여 어디가 좋나요? <i class="fa-solid fa-comment table-icon icon-comment"></i> 12</a></td>
                            <td class="p-3 text-center">제주여행자</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">156</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>18</td>
                        </tr>
                        <tr class="board-row border-bottom">
                            <td class="p-3 text-center">13130</td>
                            <td class="p-3 text-center"><span class="board-category-tag review">후기</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑용 화로대 추천 (가성비 좋은 것) <i class="fa-solid fa-image table-icon"></i> <i class="fa-solid fa-comment table-icon icon-comment"></i> 21</a></td>
                            <td class="p-3 text-center">불멍러버</td>
                            <td class="p-3 text-center">2025-04-03</td>
                            <td class="p-3 text-center">198</td>
                            <td class="p-3 text-center"><i class="fa-solid fa-heart table-icon icon-heart"></i>35</td>
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

                    <!-- 글쓰기 버튼 - 오른쪽 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;">
                        <button class="btn btn-primary">
                            <i class="fa-solid fa-pen"></i> 글쓰기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>