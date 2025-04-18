<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>고독한 캠핑방 - 게시글 상세</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 심플 카드 그리드 스타일 - boardImage.jsp와 동일하게 적용 */
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

            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header mb-4">
                    <a href="boardimage.action"><h1 class="page-title"><i class="fa-solid fa-person-hiking"></i> 고독한캠핑방</h1></a>
                </div>
                <!-- 게시글 영역 -->
                <div class="content-box mb-5">
                    <div class="p-4 border-bottom">
                        <div>
                            <h1 class="h3 font-bold mb-2">가니주골한식 <i class="fa-solid fa-image text-secondary"></i></h1>
                            <div class="d-flex gap-4 text-secondary font-xs">
                                <div class="d-flex align-items-center gap-2">
                                    <img src="/api/placeholder/24/24" alt="작성자 아이콘" class="rounded-circle">
                                    가니주골한식
                                </div>
                                <div>2025.03.03</div>
                                <div>조회수 1003</div>
                                <div>추천 77</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                    </div>
                    <div class="p-4 text-center">
                        <img src="/api/placeholder/700/500" alt="캠핑 한식 사진" class="rounded-md mb-4 max-w-100">
                    </div>

                    <div class="p-4 border-top">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center gap-2">
                                <button class="btn-icon" id="likeButton">
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
                    <div class="p-3 border-bottom">
                        <div class="d-flex justify-content-between mb-2">
                            <div class="d-flex align-items-center gap-2 font-bold">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지" class="rounded-circle">
                                <span>스키롱즈</span>
                            </div>
                            <div class="d-flex gap-2 text-tertiary font-xxs">
                                <div>2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="mb-2">
                            캠핑장에서 고기 구워먹기 진짜 최고예요! 불 향이 제대로 배어서 집에서 구워먹는 거랑은 비교가 안 되죠. 다음에는 어떤 양념을 사용하셨는지 레시피도 좀 공유해주세요~
                        </div>
                        <div>
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                        <div class="reply-form" id="reply-form-1" style="display: none;">
                            <textarea class="form-control mb-2 mt-2" rows="3" placeholder="답글을 작성해주세요"></textarea>
                            <div class="d-flex justify-content-end gap-2">
                                <button class="btn btn-sm btn-outline-primary cancel-reply">취소</button>
                                <button class="btn btn-sm btn-primary submit-reply">등록</button>
                            </div>
                        </div>
                    </div>

                    <!-- 대댓글 아이템 -->
                    <div class="p-3 border-bottom" style="margin-left: 30px; border-left: 2px solid var(--border-light); padding-left: var(--spacing-md);">
                        <div class="d-flex justify-content-between mb-2">
                            <div class="d-flex align-items-center gap-2 font-bold">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지" class="rounded-circle">
                                <span>가니주골한식</span>
                            </div>
                            <div class="d-flex gap-2 text-tertiary font-xxs">
                                <div>2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="mb-2">
                            네, 다음에는 양념 레시피도 함께 올려볼게요! 간장, 고추장, 다진 마늘을 기본으로 약간의 설탕과 참기름을 섞어서 만든 양념이 가장 인기 있었어요.
                        </div>
                        <div>
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 아이템 -->
                    <div class="p-3 border-bottom">
                        <div class="d-flex justify-content-between mb-2">
                            <div class="d-flex align-items-center gap-2 font-bold">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지" class="rounded-circle">
                                <span>몽골카우</span>
                            </div>
                            <div class="d-flex gap-2 text-tertiary font-xxs">
                                <div>2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="mb-2">
                            캠핑장에서 고기 구워먹기 진짜 최고예요! 불 향이 제대로 배어서 집에서 구워먹는 거랑은 비교가 안 되죠.
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn-text delete-btn">삭제</button>
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 아이템 -->
                    <div class="p-3 border-bottom">
                        <div class="d-flex justify-content-between mb-2">
                            <div class="d-flex align-items-center gap-2 font-bold">
                                <img src="/api/placeholder/24/24" alt="프로필 이미지" class="rounded-circle">
                                <span>맑은하늘</span>
                            </div>
                            <div class="d-flex gap-2 text-tertiary font-xxs">
                                <div>2025.03.03</div>
                                <button class="btn-text text-secondary">신고</button>
                            </div>
                        </div>
                        <div class="mb-2">
                            와~ 정말 맛있어 보여요! 다음 캠핑 때 꼭 도전해봐야겠습니다. 혹시 사용하신 화로대 제품이 뭔가요?
                        </div>
                        <div>
                            <button class="btn-text reply-toggle">답글</button>
                        </div>
                    </div>

                    <!-- 댓글 입력 영역 -->
                    <div class="p-3">
                        <textarea class="form-control mb-2" rows="3" placeholder="댓글을 작성해주세요"></textarea>
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-primary">등록</button>
                        </div>
                    </div>
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
                            <h3 class="simple-card-title">혼자 가기 좋은 강원도 캠핑장 TOP 5</h3>
                            <div class="simple-card-author">산속여행자</div>
                            <div class="simple-card-footer">
                                <div class="simple-card-date">2025-03-30</div>
                                <div class="simple-card-stats">
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-eye"></i>
                                        <span>612</span>
                                    </div>
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-heart"></i>
                                        <span>93</span>
                                    </div>
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-comment"></i>
                                        <span>31</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <!-- 심플 카드 3 -->
                    <a href="boardimage-post.action?postId=3" class="simple-card">
                        <div class="simple-card-image">
                            <i class="fa-solid fa-campground"></i>
                        </div>
                        <div class="simple-card-content">
                            <h3 class="simple-card-title">혼캠 1주년 기념 장비 리뷰 (사진 많음)</h3>
                            <div class="simple-card-author">솔로캠퍼</div>
                            <div class="simple-card-footer">
                                <div class="simple-card-date">2025-03-29</div>
                                <div class="simple-card-stats">
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-eye"></i>
                                        <span>432</span>
                                    </div>
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-heart"></i>
                                        <span>76</span>
                                    </div>
                                    <div class="simple-card-stat">
                                        <i class="fa-solid fa-comment"></i>
                                        <span>23</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
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
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

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
                const commentItem = this.closest('.p-3');
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
                    replyForm.className = 'reply-form mt-2';
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
                const commentItem = this.closest('.p-3');
                const author = commentItem.querySelector('.font-bold span').textContent;
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
        const commentForm = document.querySelector('.content-box textarea').parentNode;
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
                    window.location.href = 'boardimage.action';
                } else if (this.textContent === '이전글') {
                    window.location.href = 'boardimage-post.action?postId=' + (Math.floor(Math.random() * 1000) + 1);
                } else if (this.textContent === '다음글') {
                    window.location.href = 'boardimage-post.action?postId=' + (Math.floor(Math.random() * 1000) + 1);
                }
            });
        });
    });
</script>
</body>
</html>