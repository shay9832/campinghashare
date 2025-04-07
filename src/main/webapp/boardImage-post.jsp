<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>고독한 캠핑방 - 게시글 상세</title>
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- 메인 CSS 파일 링크 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="resources/css/main.css">
    <!-- 페이지 특정 스타일 -->
    <style>
        /* 게시글 영역 추가 스타일 */
        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: var(--spacing-md);
        }

        .post-meta {
            display: flex;
            gap: var(--spacing-sm);
            color: var(--text-secondary);
            font-size: var(--font-xs);
            margin-top: var(--spacing-xs);
        }

        .post-stats {
            display: flex;
            gap: var(--spacing-md);
            align-items: center;
        }

        .post-author {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        .post-author img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
        }

        .post-content {
            margin-bottom: var(--spacing-lg);
            text-align: center;
        }

        .post-content img {
            max-width: 100%;
            border-radius: var(--radius-md);
        }

        .post-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .like-area {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        .report-btn {
            color: var(--text-secondary);
            border: none;
            background-color: transparent;
            padding: 0;
            cursor: pointer;
        }

        /* 댓글 영역 스타일 */
        .comment-item {
            padding: var(--spacing-md);
            border-bottom: 1px solid var(--border-light);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-xs);
        }

        .comment-author {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-weight: var(--font-bold);
        }

        .comment-author img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
        }

        .comment-meta {
            display: flex;
            gap: var(--spacing-md);
            font-size: var(--font-xxs);
            color: var(--text-secondary);
        }

        .comment-body {
            margin-bottom: var(--spacing-xs);
            color: var(--text-primary);
            line-height: 1.5;
        }

        .comment-actions {
            display: flex;
            justify-content: flex-end;
            gap: var(--spacing-sm);
        }

        .reply-comment {
            padding-left: var(--spacing-xl);
            border-left: 3px solid var(--border-medium);
            margin-left: var(--spacing-lg);
        }

        .reply-form {
            padding: var(--spacing-md);
            background-color: var(--color-gray-100);
            border-radius: var(--radius-md);
            margin-top: var(--spacing-sm);
            display: none;
        }

        .comment-form {
            padding: var(--spacing-md);
        }

        /* 관련 게시글 영역 */
        .related-posts {
            margin-top: var(--spacing-xl);
            margin-bottom: var(--spacing-xl);
        }

        .posts-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-md);
        }

        /* 사이드바 커스텀 스타일 */
        .sidebar {
            width: 220px;
            flex-shrink: 0;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
        }

        .sidebar-menu-item {
            margin-bottom: 2px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            color: var(--text-primary);
            text-decoration: none;
            border-radius: var(--radius-sm);
            transition: all var(--transition-normal);
        }

        .sidebar-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .sidebar-link:hover {
            background-color: var(--color-gray-100);
        }

        .sidebar-link.active {
            background-color: var(--color-beige);
            color: var(--color-maple);
            font-weight: var(--font-bold);
        }

        @media (max-width: 992px) {
            .posts-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .two-column-layout {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                margin-bottom: var(--spacing-lg);
            }

            .sidebar-menu {
                display: flex;
                flex-wrap: wrap;
                gap: var(--spacing-xs);
            }

            .sidebar-menu-item {
                margin-bottom: 0;
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
<jsp:include page="Header.jsp"></jsp:include>

<div class="page-wrapper">
    <div class="container section" style="width: 100%; max-width: 1500px; padding: 0 15px; margin: 0 auto;">
        <div class="two-column-layout my-5">
            <!-- 사이드바 -->
            <aside class="sidebar mr-4">
                <div class="content-box p-4 mb-4">
                    <h2 class="font-bold mb-3">커뮤니티</h2>
                    <ul class="sidebar-menu">
                        <li class="sidebar-menu-item">
                            <a href="#" class="sidebar-link">
                                <i class="fa-solid fa-star"></i>
                                <span>BEST</span>
                            </a>
                        </li>
                        <li class="sidebar-menu-item">
                            <a href="boardFree.jsp" class="sidebar-link">
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
                </div>
            </aside>

            <!-- 메인 컨텐츠 -->
            <main class="main-column">
                <div class="page-header mb-4">
                    <h1 class="page-title">고독한 캠핑방</h1>
                </div>

                <!-- 게시글 영역 -->
                <div class="content-box mb-5">
                    <!-- 게시글 제목 및 정보 -->
                    <div class="p-4 border-bottom">
                        <div class="post-header">
                            <h2 class="font-bold mb-0">
                                가니주골한식
                                <i class="fa-solid fa-image text-secondary"></i>
                            </h2>
                        </div>
                        <div class="post-meta">
                            <div class="post-author">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지">
                                가니주골한식
                            </div>
                            <div class="post-date">2025.03.03</div>
                            <div class="post-stats">
                                <div class="post-views">조회수 1003</div>
                                <div class="post-likes">추천 77</div>
                                <button class="report-btn">신고</button>
                            </div>
                        </div>
                    </div>

                    <!-- 게시글 내용 -->
                    <div class="post-content p-4">
                        <img src="/api/placeholder/700/500" alt="캠핑 한식 사진" class="img-fluid">
                    </div>

                    <!-- 게시글 액션 -->
                    <div class="p-4 border-top">
                        <div class="post-actions">
                            <div class="like-area">
                                <button class="btn btn-icon" id="likeButton">
                                    <i class="fas fa-heart icon-heart"></i>
                                </button>
                                <span class="font-bold" id="likeCount">추천 77</span>
                            </div>
                            <div class="btn-group">
                                <button class="btn btn-sm">이전글</button>
                                <button class="btn btn-sm">목록</button>
                                <button class="btn btn-sm">다음글</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 댓글 영역 -->
                <div class="content-box mb-5">
                    <div class="p-3 border-bottom bg-gray-100">
                        <h3 class="font-bold">댓글 <span class="text-main">4</span></h3>
                    </div>

                    <!-- 댓글 아이템 -->
                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지">
                                <span>스키롱즈</span>
                            </div>
                            <div class="comment-meta">
                                <div class="comment-date">2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="comment-body">
                            캠핑장에서 고기 구워먹기 진짜 최고예요! 불 향이 제대로 배어서 집에서 구워먹는 거랑은 비교가 안 되죠. 다음에는 어떤 양념을 사용하셨는지 레시피도 좀 공유해주세요~
                        </div>
                        <div class="comment-actions">
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                        <div class="reply-form" id="reply-form-1">
                            <textarea class="form-control mb-2" rows="3" placeholder="답글을 작성해주세요"></textarea>
                            <div class="d-flex justify-content-end gap-2">
                                <button class="btn btn-sm btn-outline-primary cancel-reply">취소</button>
                                <button class="btn btn-sm btn-primary submit-reply">등록</button>
                            </div>
                        </div>
                    </div>

                    <!-- 대댓글 아이템 -->
                    <div class="comment-item reply-comment">
                        <div class="comment-header">
                            <div class="comment-author">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지">
                                <span>가니주골한식</span>
                            </div>
                            <div class="comment-meta">
                                <div class="comment-date">2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="comment-body">
                            네, 다음에는 양념 레시피도 함께 올려볼게요! 간장, 고추장, 다진 마늘을 기본으로 약간의 설탕과 참기름을 섞어서 만든 양념이 가장 인기 있었어요.
                        </div>
                        <div class="comment-actions">
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 아이템 -->
                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지">
                                <span>몽골카우</span>
                            </div>
                            <div class="comment-meta">
                                <div class="comment-date">2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="comment-body">
                            캠핑장에서 고기 구워먹기 진짜 최고예요! 불 향이 제대로 배어서 집에서 구워먹는 거랑은 비교가 안 되죠.
                        </div>
                        <div class="comment-actions">
                            <button class="btn-text delete-btn">삭제</button>
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 아이템 -->
                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지">
                                <span>맑은하늘</span>
                            </div>
                            <div class="comment-meta">
                                <div class="comment-date">2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="comment-body">
                            와~ 정말 맛있어 보여요! 다음 캠핑 때 꼭 도전해봐야겠습니다. 혹시 사용하신 화로대 제품이 뭔가요?
                        </div>
                        <div class="comment-actions">
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 입력 영역 -->
                    <div class="comment-form">
                        <textarea class="form-control mb-2" rows="3" placeholder="댓글을 작성해주세요"></textarea>
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-primary">등록</button>
                        </div>
                    </div>
                </div>

                <!-- 관련 게시글 영역 -->
                <h3 class="font-bold mb-3">관련 게시글</h3>
                <div class="posts-grid mb-5">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="/api/placeholder/300/200" alt="캠핑 이미지">
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">캠핑장에서의 즐거운 저녁식사</h3>
                            <p class="product-meta">자연 속에서 직접 요리한 특별한 맛</p>
                        </div>
                    </div>

                    <div class="product-card">
                        <div class="product-image">
                            <img src="/api/placeholder/300/200" alt="캠핑 이미지">
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">우리 가족 첫 캠핑 도전기</h3>
                            <p class="product-meta">아이들과 함께한 잊지 못할 경험</p>
                        </div>
                    </div>

                    <div class="product-card">
                        <div class="product-image">
                            <img src="/api/placeholder/300/200" alt="캠핑 이미지">
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">소나무 캠핑장 후기</h3>
                            <p class="product-meta">숲속에서 즐기는 힐링 시간</p>
                        </div>
                    </div>
                </div>

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
            </main>
        </div>
    </div>
</div>

<jsp:include page="Footer.jsp"></jsp:include>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 좋아요 버튼 기능
        const likeButton = document.getElementById('likeButton');
        const likeCount = document.getElementById('likeCount');

        likeButton.addEventListener('click', function() {
            this.classList.toggle('active');
            let count = parseInt(likeCount.textContent.split(' ')[1]);

            if (this.classList.contains('active')) {
                likeCount.textContent = `추천 ${count + 1}`;
            } else {
                likeCount.textContent = `추천 ${count - 1}`;
            }
        });

        // 답글 버튼 이벤트
        const replyButtons = document.querySelectorAll('.reply-toggle');

        replyButtons.forEach(button => {
            button.addEventListener('click', function() {
                const commentItem = this.closest('.comment-item');
                let replyForm = commentItem.querySelector('.reply-form');

                // 모든 답글 폼 닫기
                document.querySelectorAll('.reply-form').forEach(form => {
                    if (form !== replyForm) {
                        form.style.display = 'none';
                    }
                });

                // 답글 폼이 없으면 생성
                if (!replyForm) {
                    replyForm = document.createElement('div');
                    replyForm.className = 'reply-form';
                    replyForm.innerHTML = `
                        <textarea class="form-control mb-2" rows="3" placeholder="답글을 작성해주세요"></textarea>
                        <div class="d-flex justify-content-end gap-2">
                            <button class="btn btn-sm btn-outline-primary cancel-reply">취소</button>
                            <button class="btn btn-sm btn-primary submit-reply">등록</button>
                        </div>
                    `;
                    commentItem.appendChild(replyForm);

                    // 취소 버튼 이벤트
                    replyForm.querySelector('.cancel-reply').addEventListener('click', function() {
                        replyForm.style.display = 'none';
                    });

                    // 등록 버튼 이벤트
                    replyForm.querySelector('.submit-reply').addEventListener('click', function() {
                        const textarea = replyForm.querySelector('textarea');
                        if (textarea.value.trim() !== '') {
                            alert('답글이 등록되었습니다.');
                            textarea.value = '';
                            replyForm.style.display = 'none';
                        } else {
                            alert('답글 내용을 입력해주세요.');
                        }
                    });
                }

                // 답글 폼 토글
                replyForm.style.display = replyForm.style.display === 'block' ? 'none' : 'block';
            });
        });

        // 신고 버튼 이벤트
        document.querySelectorAll('.btn-text').forEach(button => {
            if (button.textContent.trim() === '신고') {
                button.addEventListener('click', function() {
                    alert('신고가 접수되었습니다.');
                });
            }
        });

        // 삭제 버튼 이벤트
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const commentItem = this.closest('.comment-item');
                const author = commentItem.querySelector('.comment-author span').textContent;
                const currentUser = '몽골카우'; // 예시: 실제로는 세션에서 가져와야 함

                if (author === currentUser) {
                    if (confirm('댓글을 삭제하시겠습니까?')) {
                        commentItem.remove();
                        alert('댓글이 삭제되었습니다.');
                    }
                } else {
                    alert('본인이 작성한 댓글만 삭제할 수 있습니다.');
                }
            });
        });

        // 댓글 등록 버튼 이벤트
        const commentForm = document.querySelector('.comment-form');
        const commentSubmit = commentForm.querySelector('.btn-primary');

        commentSubmit.addEventListener('click', function() {
            const textarea = commentForm.querySelector('textarea');
            if (textarea.value.trim() !== '') {
                alert('댓글이 등록되었습니다.');
                textarea.value = '';
            } else {
                alert('댓글 내용을 입력해주세요.');
            }
        });

        // 네비게이션 버튼 이벤트 (이전글, 목록, 다음글)
        const navButtons = document.querySelectorAll('.btn-group .btn');

        navButtons.forEach(button => {
            button.addEventListener('click', function() {
                if (this.textContent === '목록') {
                    window.location.href = 'BoardCamping.jsp';
                } else if (this.textContent === '이전글') {
                    window.location.href = 'BoardCampingPost.jsp?no=' + (Math.floor(Math.random() * 1000) + 1);
                } else if (this.textContent === '다음글') {
                    window.location.href = 'BoardCampingPost.jsp?no=' + (Math.floor(Math.random() * 1000) + 1);
                }
            });
        });

        // 관련 게시글 카드 클릭 이벤트
        document.querySelectorAll('.product-card').forEach(card => {
            card.addEventListener('click', function() {
                window.location.href = 'BoardCampingPost.jsp?no=' + Math.floor(Math.random() * 1000);
            });
        });
    });
</script>
</body>
</html>