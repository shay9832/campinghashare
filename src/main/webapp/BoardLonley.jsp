<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>고독한캠핑방</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 갤러리 레이아웃 관련 추가 스타일 */
        .gallery-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
        }

        .gallery-item {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .gallery-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .gallery-image {
            width: 100%;
            height: 200px;
            background-color: var(--color-gray-200);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .gallery-content {
            padding: var(--spacing-md);
        }

        .gallery-title {
            font-size: var(--font-sm);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-sm);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .gallery-info {
            display: flex;
            justify-content: space-between;
            color: var(--text-secondary);
            font-size: var(--font-xs);
        }

        .gallery-meta {
            display: flex;
            gap: var(--spacing-sm);
        }

        /* 아이콘 스타일 */
        .fa-heart {
            color: var(--color-coral);
        }

        .fa-eye {
            color: var(--text-secondary);
        }

        .fa-comment {
            color: var(--color-maple);
        }

        /* 이미지 없음 아이콘 */
        .no-image-icon {
            font-size: 48px;
            color: var(--color-gray-500);
        }

        /* 필터 버튼 */
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

        /* 보기 옵션 버튼 */
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

        /* 공지 테이블 */
        .notice-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }

        .notice-table th {
            background-color: var(--bg-secondary);
            padding: var(--spacing-sm);
            text-align: center;
            font-weight: var(--font-bold);
            border-bottom: 1px solid var(--border-medium);
        }

        .notice-table td {
            padding: var(--spacing-sm);
            text-align: center;
            border-bottom: 1px solid var(--border-light);
        }

        .notice-table .notice {
            background-color: #fff8e1;
        }

        .notice-table .title-cell {
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-left: var(--spacing-sm);
        }

        .notice-table .title-cell a:hover {
            text-decoration: underline;
            color: var(--color-maple);
        }

        /* 카테고리 태그 */
        .category-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            margin-right: var(--spacing-sm);
        }

        .category-tag.notice {
            background-color: #fff9c4;
            color: #ffa000;
        }

        .category-tag.solocamping {
            background-color: #ffebee;
            color: #d32f2f;
        }

        /* 공지 태그 */
        .notice-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: var(--color-coral);
            color: var(--color-white);
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
                        <a href="#" class="sidebar-link">
                            <i class="fa-solid fa-comments"></i>
                            <span>자유게시판</span>
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="#" class="sidebar-link active">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-person-hiking"></i> 고독한캠핑방</h1>
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
                    <div class="d-flex gap-2">
                        <div class="view-option">
                            <i class="fa-solid fa-list"></i>
                        </div>
                        <div class="view-option active">
                            <i class="fa-solid fa-table-cells"></i>
                        </div>
                    </div>
                </div>

                <!-- 공지사항 테이블 -->
                <table class="notice-table">
                    <thead>
                    <tr>
                        <th width="5%">번호</th>
                        <th width="10%">분류</th>
                        <th width="48%">제목</th>
                        <th width="10%">작성자</th>
                        <th width="10%">작성일</th>
                        <th width="8%">조회수</th>
                        <th width="9%">추천</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 공지사항 -->
                    <tr class="notice">
                        <td><span class="notice-tag">공지</span></td>
                        <td><span class="category-tag notice">공지</span></td>
                        <td class="title-cell"><a href="#">혼캠족을 위한 안전 가이드라인 안내</a></td>
                        <td>관리자</td>
                        <td>2025-03-25</td>
                        <td>1,245</td>
                        <td>32</td>
                    </tr>
                    <tr class="notice">
                        <td><span class="notice-tag">공지</span></td>
                        <td><span class="category-tag notice">공지</span></td>
                        <td class="title-cell"><a href="#">고독한캠핑방 이용 규칙 안내</a></td>
                        <td>관리자</td>
                        <td>2025-03-25</td>
                        <td>876</td>
                        <td>28</td>
                    </tr>
                    </tbody>
                </table>

                <!-- 갤러리 형태의 게시판 -->
                <div class="gallery-container">
                    <!-- 갤러리 아이템 1 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">강원도 양양 혼캠 다녀왔습니다</div>
                            <div class="gallery-info">
                                <span>혼캠러버</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 254</span>
                                    <span><i class="fa-solid fa-heart"></i> 42</span>
                                    <span><i class="fa-solid fa-comment"></i> 15</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 2 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼자 가기 좋은 강원도 캠핑장 TOP 5</div>
                            <div class="gallery-info">
                                <span>산속여행자</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 612</span>
                                    <span><i class="fa-solid fa-heart"></i> 93</span>
                                    <span><i class="fa-solid fa-comment"></i> 31</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 3 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼캠 1주년 기념 장비 리뷰 (사진 많음)</div>
                            <div class="gallery-info">
                                <span>솔로캠퍼</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 432</span>
                                    <span><i class="fa-solid fa-heart"></i> 76</span>
                                    <span><i class="fa-solid fa-comment"></i> 23</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 4 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼캠 시 안전을 위한 체크리스트</div>
                            <div class="gallery-info">
                                <span>안전제일</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 523</span>
                                    <span><i class="fa-solid fa-heart"></i> 91</span>
                                    <span><i class="fa-solid fa-comment"></i> 24</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 5 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">여자 혼캠러를 위한 안전 팁</div>
                            <div class="gallery-info">
                                <span>캠핑여왕</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 728</span>
                                    <span><i class="fa-solid fa-heart"></i> 135</span>
                                    <span><i class="fa-solid fa-comment"></i> 42</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 6 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼캠 중 찍은 밤하늘 사진</div>
                            <div class="gallery-info">
                                <span>별빛캠퍼</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 412</span>
                                    <span><i class="fa-solid fa-heart"></i> 87</span>
                                    <span><i class="fa-solid fa-comment"></i> 18</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 7 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">처음 혼캠 도전기</div>
                            <div class="gallery-info">
                                <span>혼캠초보</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 356</span>
                                    <span><i class="fa-solid fa-heart"></i> 65</span>
                                    <span><i class="fa-solid fa-comment"></i> 31</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 8 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼캠용 미니멀 장비 추천</div>
                            <div class="gallery-info">
                                <span>미니멀리스트</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 478</span>
                                    <span><i class="fa-solid fa-heart"></i> 93</span>
                                    <span><i class="fa-solid fa-comment"></i> 27</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 갤러리 아이템 9 -->
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <i class="fas fa-image no-image-icon"></i>
                        </div>
                        <div class="gallery-content">
                            <div class="gallery-title">혼자서도 맛있게 먹는 캠핑 요리</div>
                            <div class="gallery-info">
                                <span>혼캠셰프</span>
                                <div class="gallery-meta">
                                    <span><i class="fa-solid fa-eye"></i> 562</span>
                                    <span><i class="fa-solid fa-heart"></i> 112</span>
                                    <span><i class="fa-solid fa-comment"></i> 34</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <div class="d-flex border rounded">
                            <select class="form-control-sm border-0" style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px;">
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