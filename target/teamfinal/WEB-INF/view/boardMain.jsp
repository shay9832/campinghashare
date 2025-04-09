<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>커뮤니티 메인</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
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

        /* 카드 그리드 수정 */
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
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

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
                        <a href="boardbest.action" class="sidebar-link">
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
                <!-- 메인 이미지 -->
                <div class="main-image">
                    <img src="/resources/images/postmain.jpg" alt="캠핑 메인 이미지" />
                </div>

                <!-- BEST 게시판 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="boardbest.action" class="text-primary">BEST</a>
                        </h3>
                        <a href="boardbest.action" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <div class="post-item">
                            <div class="post-number">1</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>45</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=1">첫 캠핑인데 뭐가 필요할까요?</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">2</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>55</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=2">가성비 좋은 캠핑장비 추천해요!</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">3</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>75</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=3">불멍할 때 듣기 좋은 음악 추천</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">4</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>30</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=4">캠핑장에서 요리하는 꿀팁</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">5</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>63</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=5">초간단 화로대 리뷰</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                    </div>
                </div>

                <!-- 자유게시판 -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="boardfree.action" class="text-primary">자유게시판</a>
                        </h3>
                        <a href="boardfree.action" class="more-btn">+</a>
                    </div>
                    <div class="post-list">
                        <div class="post-item">
                            <div class="post-number">1</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>10</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=6">이번 주말 캠핑 갈 사람?</a>
                            </div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">2</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>5</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=7">캠핑장 추천해주세요~</a>
                            </div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">3</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>3</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=8">텐트 안에서 자는게 불편해요!</a>
                            </div>
                            <div class="created-date">2025-03-30</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">4</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>8</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=9">중고 캠핑 장비 어디서 사나요?</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                        <div class="post-item">
                            <div class="post-number">5</div>
                            <div class="post-rec"><i class="fa-solid fa-heart"></i>15</div>
                            <div class="post-title">
                                <a href="boardfree-post.action?postId=10">제주도 캠핑 후기(사진 많음)</a>
                            </div>
                            <div class="created-date">2025-03-29</div>
                        </div>
                    </div>
                </div>

                <!-- 고독한캠핑방 (심플 카드 형식) -->
                <div class="board-wrapper">
                    <div class="board-header">
                        <h3>
                            <a href="boardimage.action" class="text-primary">고독한캠핑방</a>
                        </h3>
                        <a href="boardimage.action" class="more-btn">+</a>
                    </div>
                    <div class="posts-grid">
                        <!-- 심플 카드 1 -->
                        <a href="boardimage-post.action?postId=1" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-mountain-sun"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">강원도 양양 혼캠 다녀왔습니다</h3>
                                <div class="simple-card-author">혼캠러버</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-31</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>254</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>42</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>15</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <!-- 심플 카드 2 -->
                        <a href="boardimage-post.action?postId=2" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-map-location-dot"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">혼자 캠핑가기 좋은 곳 추천</h3>
                                <div class="simple-card-author">산속여행자</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-30</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>189</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>18</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>8</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <!-- 심플 카드 3 -->
                        <a href="boardimage-post.action?postId=3" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-music"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">고독한 캠핑을 위한 음악 리스트</h3>
                                <div class="simple-card-author">음악캠퍼</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-29</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>145</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>15</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>5</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <!-- 심플 카드 4 -->
                        <a href="boardimage-post.action?postId=4" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-shield-halved"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">혼캠러를 위한 안전 수칙</h3>
                                <div class="simple-card-author">안전제일</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-28</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>178</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>12</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <!-- 심플 카드 5 -->
                        <a href="boardimage-post.action?postId=5" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-campground"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">소형 텐트 추천 부탁드립니다</h3>
                                <div class="simple-card-author">텐트마스터</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-27</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>152</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>8</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>11</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <!-- 심플 카드 6 -->
                        <a href="boardimage-post.action?postId=6" class="simple-card">
                            <div class="simple-card-image">
                                <i class="fa-solid fa-fire"></i>
                            </div>
                            <div class="simple-card-content">
                                <h3 class="simple-card-title">별빛 아래 혼자 즐기는 불멍</h3>
                                <div class="simple-card-author">불멍러버</div>
                                <div class="simple-card-footer">
                                    <div class="simple-card-date">2025-03-26</div>
                                    <div class="simple-card-stats">
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-eye"></i>
                                            <span>206</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-heart"></i>
                                            <span>24</span>
                                        </div>
                                        <div class="simple-card-stat">
                                            <i class="fa-solid fa-comment"></i>
                                            <span>7</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>