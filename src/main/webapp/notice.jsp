<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>공지사항</title>
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

        .view-option {
            cursor: pointer;
            padding: 8px;
            border-radius: var(--radius-sm);
            transition: all var(--transition-normal);
        }

        .view-option:hover {
            background-color: var(--color-gray-200);
        }

        .view-option.active {
            background-color: var(--color-gray-200);
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<div class="page-wrapper">
    <div class="container section" style="width: 100%; max-width: 1500px; padding: 0 15px; margin: 0 auto;">
        <div class="main-content my-5">
            <!-- 메인 콘텐츠 -->
            <div class="w-100">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-bullhorn"></i> 공지사항</h1>
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
                    <div class="d-flex gap-2">
                        <div class="view-option active">
                            <i class="fa-solid fa-list"></i>
                        </div>
                        <div class="view-option">
                            <i class="fa-solid fa-table-cells"></i>
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
                        <!-- 공지사항 목록 -->
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">15</td>
                            <td class="p-3 text-center"><span class="board-category-tag update">업데이트</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 2024년 업데이트 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-04-01</td>
                            <td class="p-3 text-center">1,567</td>
                            <td class="p-3 text-center">124</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">14</td>
                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑 관련 허위정보 및 스팸 게시글 신고 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">876</td>
                            <td class="p-3 text-center">28</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">13</td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">커뮤니티 게시글 작성 가이드</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-25</td>
                            <td class="p-3 text-center">987</td>
                            <td class="p-3 text-center">45</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">12</td>
                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>
                            <td class="p-3 title-cell"><a href="#">혼캠족을 위한 안전 가이드라인 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-03-10</td>
                            <td class="p-3 text-center">1,245</td>
                            <td class="p-3 text-center">32</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">11</td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 포인트 적립 시스템 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-02-28</td>
                            <td class="p-3 text-center">954</td>
                            <td class="p-3 text-center">67</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">10</td>
                            <td class="p-3 text-center"><span class="board-category-tag update">업데이트</span></td>
                            <td class="p-3 title-cell"><a href="#">모바일 앱 베타 버전 출시 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-02-20</td>
                            <td class="p-3 text-center">1,678</td>
                            <td class="p-3 text-center">189</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">9</td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">캠핑하쉐어 커뮤니티 이용 규칙 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-02-15</td>
                            <td class="p-3 text-center">2,345</td>
                            <td class="p-3 text-center">89</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">8</td>
                            <td class="p-3 text-center"><span class="board-category-tag important">중요</span></td>
                            <td class="p-3 title-cell"><a href="#">겨울 캠핑 안전 수칙 안내</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-01-10</td>
                            <td class="p-3 text-center">1,456</td>
                            <td class="p-3 text-center">178</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">7</td>
                            <td class="p-3 text-center"><span class="board-category-tag update">업데이트</span></td>
                            <td class="p-3 title-cell"><a href="#">사이트 리뉴얼 안내 및 피드백 요청</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2025-01-05</td>
                            <td class="p-3 text-center">1,789</td>
                            <td class="p-3 text-center">156</td>
                        </tr>
                        <tr class="board-row notice border-bottom">
                            <td class="p-3 text-center">6</td>
                            <td class="p-3 text-center"><span class="board-category-tag notice">공지</span></td>
                            <td class="p-3 title-cell"><a href="#">2024년 커뮤니티 운영 결산</a></td>
                            <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
                            <td class="p-3 text-center">2024-12-31</td>
                            <td class="p-3 text-center">1,543</td>
                            <td class="p-3 text-center">134</td>
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
                            <a href="#" class="btn btn-sm"><i class="fa-solid fa-chevron-right"></i></a>
                        </div>
                    </div>

                    <!-- 관리자만 보이는 글쓰기 버튼 - 오른쪽 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;">
                        <button class="btn btn-primary">
                            <i class="fa-solid fa-pen mr-1"></i> 글쓰기
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