<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>커뮤니티 메인</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 게시판 관련 추가 스타일 */
        .board-wrapper {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-md) var(--spacing-lg);
            background-color: var(--color-gray-300);
            border-bottom: 1px solid var(--border-medium);
        }

        .board-header h3 {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            color: var(--text-primary);
            margin: 0;
        }

        .board-header .more-btn {
            font-size: var(--font-xl);
            color: var(--text-primary);
            text-decoration: none;
            line-height: 1;
        }

        .post-list {
            padding: var(--spacing-md) var(--spacing-lg);
        }

        .post-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-sm) 0;
            border-bottom: 1px solid var(--border-light);
        }

        .post-item:last-child {
            border-bottom: none;
        }

        .post-number {
            width: 30px;
            text-align: center;
            background-color: var(--color-beige);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            padding: 2px 0;
        }

        .post-rec {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-left: var(--spacing-md);
            color: var(--color-coral);
            font-size: var(--font-xs);
            min-width: 60px;
        }

        .post-rec i {
            color: var(--color-coral);
        }

        .post-title {
            flex: 1;
            margin-left: var(--spacing-sm);
            font-size: var(--font-sm);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .created-date {
            width: 100px;
            text-align: center;
            color: var(--text-secondary);
            font-size: var(--font-xs);
        }

        .main-image {
            margin-bottom: var(--spacing-lg);
        }

        .main-image img {
            width: 100%;
            height: 300px;
            border-radius: var(--radius-md);
            object-fit: cover;
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
                        <a href="#" class="sidebar-link">
                            <i class="fa-solid fa-person-hiking"></i>
                            <span>고독한캠핑방</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <!-- 메인 이미지 -->
                <div class="main-image">
                    <img src="resources/images/postmain.jpg" alt="캠핑 메인 이미지" />
                </div>

                <!-- BEST 게시판 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="#" class="text-primary">BEST</a>
                        </h3>
                        <a href="#" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <div class="post-item">
                            <div class="post-number">1</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>45</div>
                            <div class="post-title">첫 캠핑인데 뭐가 필요할까요?</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">2</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>55</div>
                            <div class="post-title">가성비 좋은 캠핑장비 추천해요!</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">3</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>75</div>
                            <div class="post-title">불멍할 때 듣기 좋은 음악 추천</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">4</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>30</div>
                            <div class="post-title">캠핑장에서 요리하는 꿀팁</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">5</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>63</div>
                            <div class="post-title">초간단 화로대 리뷰</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                    </div>
                </div>

                <!-- 자유게시판 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="#" class="text-primary">자유게시판</a>
                        </h3>
                        <a href="#" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <div class="post-item">
                            <div class="post-number">1</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>10</div>
                            <div class="post-title">이번 주말 캠핑 갈 사람?</div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">2</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>5</div>
                            <div class="post-title">캠핑장 추천해주세요~</div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">3</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>3</div>
                            <div class="post-title">텐트 안에서 자는게 불편해요!</div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">4</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>8</div>
                            <div class="post-title">중고 캠핑 장비 어디서 사나요?</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">5</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>15</div>
                            <div class="post-title">제주도 캠핑 후기(사진 많음)</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                    </div>
                </div>

                <!-- 고독한캠핑방 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="#" class="text-primary">고독한캠핑방</a>
                        </h3>
                        <a href="#" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <div class="post-item">
                            <div class="post-number">1</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>22</div>
                            <div class="post-title">혼캠 출사 사진 공유합니다</div>
                            <div class="created-date">2025-03-31</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">2</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>18</div>
                            <div class="post-title">혼자 캠핑가기 좋은 곳 추천</div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">3</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>15</div>
                            <div class="post-title">고독한 캠핑을 위한 음악 리스트</div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">4</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>12</div>
                            <div class="post-title">혼캠러를 위한 안전 수칙</div>
                            <div class="created-date">2025-03-28</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">5</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>8</div>
                            <div class="post-title">소형 텐트 추천 부탁드립니다</div>
                            <div class="created-date">2025-03-27</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>