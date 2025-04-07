<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>자유게시판 - 게시글 상세</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 게시글 상세 페이지 관련 스타일 */
        .post-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
            overflow: hidden;
        }

        .post-header {
            padding: var(--spacing-md) var(--spacing-lg);
            border-bottom: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .post-title {
            font-size: var(--font-xl);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-sm);
            color: var(--text-primary);
        }

        .post-info {
            font-size: var(--font-xs);
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
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
            object-fit: cover;
        }

        .post-body {
            padding: var(--spacing-lg);
            line-height: 1.6;
            min-height: 200px;
        }

        .post-body p {
            margin-bottom: var(--spacing-md);
        }

        .post-images {
            display: flex;
            gap: var(--spacing-sm);
            margin: var(--spacing-lg) 0;
            flex-wrap: wrap;
        }

        .post-image {
            width: 120px;
            height: 120px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            overflow: hidden;
            cursor: pointer;
        }

        .post-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .post-image:hover img {
            transform: scale(1.05);
        }

        .post-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .post-buttons {
            padding: var(--spacing-md) var(--spacing-lg);
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
        }

        .like-button {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .like-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--color-gray-100);
            border-radius: 50%;
            cursor: pointer;
            transition: all var(--transition-normal);
        }

        .like-icon:hover {
            background-color: #ffe6e6;
        }

        .like-icon i {
            color: var(--color-coral);
            font-size: var(--font-md);
        }

        .like-count {
            font-weight: var(--font-bold);
            color: var(--text-secondary);
        }

        .post-actions {
            display: flex;
            gap: var(--spacing-sm);
        }

        /* 댓글 영역 */
        .comments-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        .comment-list {
            border-bottom: 1px solid var(--border-light);
        }

        .comment-item {
            padding: var(--spacing-md) var(--spacing-lg);
            border-bottom: 1px solid var(--border-light);
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-sm);
        }

        .comment-author {
            font-weight: var(--font-bold);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .comment-author img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            object-fit: cover;
        }

        .comment-date {
            font-size: var(--font-xxs);
            color: var(--text-tertiary);
        }

        .comment-text {
            margin-bottom: var(--spacing-sm);
            line-height: 1.4;
        }

        .comment-actions {
            display: flex;
            justify-content: flex-start;
            gap: var(--spacing-sm);
        }

        .comment-btn {
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-medium);
            background-color: var(--bg-secondary);
            cursor: pointer;
            font-size: var(--font-xxs);
            transition: all var(--transition-normal);
        }

        .comment-btn:hover {
            background-color: var(--color-gray-200);
        }

        .report-btn {
            color: var(--text-secondary);
            border: none;
            background-color: transparent;
            padding: 0;
        }

        .comment-reply-area {
            background-color: transparent;
            padding: var(--spacing-md) 0;
            margin-top: var(--spacing-sm);
            margin-bottom: var(--spacing-sm);
            display: none;
        }

        .comment-reply-input {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            resize: none;
            font-family: inherit;
            font-size: var(--font-xs);
            background-color: var(--bg-primary);
        }

        .comment-reply-input:focus {
            outline: none;
            border-color: var(--color-maple);
        }

        .reply-comment {
            margin-left: 30px;
            border-left: 2px solid var(--border-light);
            padding-left: var(--spacing-md);
        }

        .write-comment {
            padding: var(--spacing-md) var(--spacing-lg);
        }

        .comment-input-area {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-sm);
        }

        .comment-input {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            resize: none;
            font-family: inherit;
            font-size: var(--font-xs);
        }

        .comment-input:focus {
            outline: none;
            border-color: var(--color-maple);
        }

        .comment-submit {
            align-self: flex-end;
            padding: var(--spacing-sm) var(--spacing-md);
            background-color: var(--color-maple);
            color: var(--color-white);
            border: none;
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: all var(--transition-normal);
        }

        .comment-submit:hover {
            background-color: var(--btn-primary-hover-bg);
        }

        /* 게시글 목록 테이블 */
        .board-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }

        .board-table th {
            background-color: var(--bg-secondary);
            padding: var(--spacing-sm);
            text-align: center;
            font-weight: var(--font-bold);
            border-bottom: 1px solid var(--border-medium);
        }

        .board-table td {
            padding: var(--spacing-sm);
            text-align: center;
            border-bottom: 1px solid var(--border-light);
        }

        .board-table tr:hover {
            background-color: var(--bg-secondary);
        }

        .board-table .title-cell {
            text-align: left;
        }

        .board-table .title-cell a:hover {
            color: var(--color-maple);
            text-decoration: underline;
        }

        /* 페이지네이션 */
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: var(--spacing-lg);
        }

        .page-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 28px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            color: var(--text-primary);
            margin: 0 3px;
            transition: all var(--transition-normal);
        }

        .page-link.active {
            background-color: var(--color-maple);
            color: var(--color-white);
            border-color: var(--color-maple);
        }

        .page-link:hover:not(.active) {
            background-color: var(--bg-secondary);
        }

        /* 쓰기 버튼 컨테이너 */
        .write-btn-container {
            display: flex;
            justify-content: flex-end;
            margin-top: var(--spacing-sm);
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

            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header mb-4">
                    <h1 class="page-title">자유게시판</h1>
                </div>
                <!-- 게시글 영역 -->
                <div class="post-container">
                    <div class="post-header">
                        <div>
                            <h1 class="post-title">주말 캠핑에서 찍은 몬당하키 사진</h1>
                            <div class="post-info">
                                <div class="post-author">
                                    <img src="/api/placeholder/24/24" alt="작성자 아이콘">
                                    불멍러버
                                </div>
                                <div class="post-date">2025.04.05 00:00</div>
                                <div class="post-views">조회수 856</div>
                                <div class="post-likes">추천 68</div>
                                <button class="report-btn">신고</button>
                            </div>
                        </div>
                    </div>
                    <div class="post-body">
                        <p>지난 주말 양평 근처 캠핑장에서 몬당하키한 사진을 공유합니다.</p>
                        <p>몬당하키는 캠핑 시 화로나 모닥불을 이용해 불을 피우고 쳐다보면서 사색에 잠기는 것을 말합니다.
                            특히 혼자 캠핑을 할 때 몬당하키의 매력을 더 느낄 수 있는데, 이번에는 가족들과 함께 갔지만
                            모두가 잠든 후 혼자만의 시간을 가질 수 있었습니다.</p>

                        <p>지난 달에 새로 구입한 소토(SOTO) 화로대를 사용했는데, 장작도 잘 타고 불꽃 모양도 예뻐서
                            몬당하키하기에 정말 좋았습니다. 화로대 위에 그릴을 올려 고기도 구워 먹을 수 있어서 일석이조였어요.</p>

                        <p>몬당하키를 하며 마시는 핫초코는 정말 최고의 조합이었습니다. 별 구경하면서 진행하는 몬당하키는
                            도시에서는 느낄 수 없는 힐링을 선사해줍니다.</p>

                        <div class="post-images">
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="몬당하키 이미지1">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="몬당하키 이미지2">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="몬당하키 이미지3">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="몬당하키 이미지4">
                            </div>
                        </div>

                        <p>여러분도 캠핑 가실 때 꼭 몬당하키 시간을 가져보세요. 머리가 맑아지고 생각이 정리되는 느낌이 들거에요.
                            다음에는 더 좋은 장소에서 더 멋진 몬당하키 사진을 찍어 올리겠습니다.</p>
                    </div>

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
                <div class="comments-container">
                    <div class="comment-list">
                        <!-- 첫 번째 댓글 -->
                        <div class="comment-item">
                            <div class="comment-header">
                                <div class="comment-author">
                                    <img src="/api/placeholder/24/24" alt="작성자 아이콘">
                                    <span>캠핑초보</span>
                                </div>
                                <div style="display: flex; gap: 15px; align-items: center;">
                                    <div class="comment-date">2025.04.05 00:00</div>
                                    <button class="report-btn">신고</button>
                                </div>
                            </div>
                            <div class="comment-text">
                                저도 몬당하키 정말 좋아합니다. 특히 캠핑 갔을 때 밤에 화로대 앞에서 맥주 한 캔 마시면서 불멍 하는 시간이 하루 중 최고의 순간인 것 같아요.
                            </div>
                            <div class="comment-actions">
                                <button class="comment-btn reply-toggle">답글</button>
                            </div>
                            <div class="comment-reply-area">
                                <div class="comment-input-area">
                                    <textarea class="comment-reply-input" rows="4" placeholder="댓글을 작성해주세요"></textarea>
                                    <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                                        <button class="btn btn-sm cancel-reply">취소</button>
                                        <button class="btn btn-primary btn-sm">등록</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 대댓글 -->
                        <div class="comment-item reply-comment">
                            <div class="comment-header">
                                <div class="comment-author">
                                    <img src="/api/placeholder/24/24" alt="작성자 아이콘">
                                    <span>불멍러버</span>
                                </div>
                                <div style="display: flex; gap: 15px; align-items: center;">
                                    <div class="comment-date">2025.04.05 00:00</div>
                                    <button class="report-btn">신고</button>
                                </div>
                            </div>
                            <div class="comment-text">
                                맞아요! 맥주와 함께하는 불멍도 정말 좋죠. 저도 종종 즐기는 조합입니다.
                            </div>
                            <div class="comment-actions">
                                <button class="comment-btn">삭제</button>
                                <button class="comment-btn reply-toggle">답글</button>
                            </div>
                            <div class="comment-reply-area">
                                <div class="comment-input-area">
                                    <textarea class="comment-reply-input" rows="4" placeholder="댓글을 작성해주세요"></textarea>
                                    <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                                        <button class="btn btn-sm cancel-reply">취소</button>
                                        <button class="btn btn-primary btn-sm">등록</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 두 번째 댓글 -->
                        <div class="comment-item">
                            <div class="comment-header">
                                <div class="comment-author">
                                    <img src="/api/placeholder/24/24" alt="작성자 아이콘">
                                    <span>장작캠퍼</span>
                                </div>
                                <div style="display: flex; gap: 15px; align-items: center;">
                                    <div class="comment-date">2025.04.05 00:00</div>
                                    <button class="report-btn">신고</button>
                                </div>
                            </div>
                            <div class="comment-text">
                                요즘은 휴대용 화로대도 많이 나와서 차박할 때도 간편하게 불멍을 즐길 수 있어서 좋더라구요. 사진 속 소토 화로대 저도 갖고 있는데 정말 좋아요!
                            </div>
                            <div class="comment-actions">
                                <button class="comment-btn reply-toggle">답글</button>
                            </div>
                            <div class="comment-reply-area">
                                <div class="comment-input-area">
                                    <textarea class="comment-reply-input" rows="4" placeholder="댓글을 작성해주세요"></textarea>
                                    <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                                        <button class="btn btn-sm cancel-reply">취소</button>
                                        <button class="btn btn-primary btn-sm">등록</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="write-comment">
                        <div class="comment-input-area">
                            <textarea class="comment-input" rows="4" placeholder="댓글을 작성해주세요"></textarea>
                            <button class="btn btn-primary">등록</button>
                        </div>
                    </div>
                </div>

                <!-- 게시글 목록 -->
                <table class="board-table" width="100%">
                    <colgroup>
                        <col width="10%">
                        <col width="10%">
                        <col width="*">
                        <col width="12%">
                        <col width="12%">
                        <col width="8%">
                        <col width="7%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>추천</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>13150</td>
                        <td>몬당하키</td>
                        <td class="title-cell"><a href="#">주말 캠핑에서 찍은 몬당하키 사진</a></td>
                        <td>불멍러버</td>
                        <td>2025.04.05</td>
                        <td>856</td>
                        <td>68</td>
                    </tr>
                    <tr>
                        <td>13149</td>
                        <td>후기</td>
                        <td class="title-cell"><a href="#">양평 숲속 캠핑장 다녀왔어요</a></td>
                        <td>숲사랑</td>
                        <td>2025.04.05</td>
                        <td>543</td>
                        <td>42</td>
                    </tr>
                    <tr>
                        <td>13148</td>
                        <td>질문</td>
                        <td class="title-cell"><a href="#">화로대 추천 부탁드립니다</a></td>
                        <td>캠핑초보</td>
                        <td>2025.04.04</td>
                        <td>762</td>
                        <td>35</td>
                    </tr>
                    </tbody>
                </table>

                <!-- 페이지네이션 -->
                <div class="pagination-container">
                    <a href="#" class="page-link">◀</a>
                    <a href="#" class="page-link active">1</a>
                    <a href="#" class="page-link">2</a>
                    <a href="#" class="page-link">3</a>
                    <a href="#" class="page-link">4</a>
                    <a href="#" class="page-link">5</a>
                    <a href="#" class="page-link">6</a>
                    <a href="#" class="page-link">7</a>
                    <a href="#" class="page-link">8</a>
                    <a href="#" class="page-link">9</a>
                    <a href="#" class="page-link">10</a>
                    <a href="#" class="page-link">▶</a>
                </div>

                <!-- 글쓰기 버튼 -->
                <div class="write-btn-container">
                    <button class="btn btn-primary">글쓰기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Footer.jsp"></jsp:include>

<script>
    // 모든 기능 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 모든 댓글 답글 영역 숨기기
        document.querySelectorAll('.comment-reply-area').forEach(area => {
            area.style.display = 'none';
        });

        // 답글 버튼 클릭 시 답글 영역 토글
        document.querySelectorAll('.reply-toggle').forEach(button => {
            button.addEventListener('click', function() {
                const commentItem = this.closest('.comment-item');
                const replyArea = commentItem.querySelector('.comment-reply-area');

                // 모든 답글 영역을 먼저 숨김
                document.querySelectorAll('.comment-reply-area').forEach(area => {
                    area.style.display = 'none';
                });

                // 클릭한 답글 영역만 보이게 함
                if(replyArea) {
                    replyArea.style.display = 'block';
                }
            });
        });

        // 취소 버튼 이벤트 리스너
        document.querySelectorAll('.cancel-reply').forEach(button => {
            button.addEventListener('click', function() {
                const replyArea = this.closest('.comment-reply-area');
                if(replyArea) {
                    replyArea.style.display = 'none';
                }
            });
        });

        // 신고 버튼 기능
        document.querySelectorAll('.report-btn').forEach(button => {
            button.addEventListener('click', function() {
                alert('신고가 접수되었습니다.');
            });
        });
    });
</script>
</body>
</html>