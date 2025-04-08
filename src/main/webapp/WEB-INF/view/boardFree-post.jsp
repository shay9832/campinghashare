<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>자유게시판 - 게시글 상세</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
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


        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .report-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            width: 500px;
            max-width: 90%;
            border-radius: var(--radius-md);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            z-index: 1001;
        }

        .modal-content {
            width: 100%;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-light);
        }

        .modal-title {
            font-size: 18px;
            font-weight: var(--font-bold);
            margin: 0;
        }

        .close-btn {
            background: transparent;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: var(--text-tertiary);
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: var(--font-medium);
        }

        .form-select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: var(--font-xs);
        }

        /* 신고 경고사항 스타일 */
        .report-warning {
            margin-top: 20px;
            background-color: #fff8f8;
            border: 1px solid #ffebeb;
            border-radius: var(--radius-sm);
            padding: 12px 15px;
        }

        .warning-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            color: #e74c3c;
            font-weight: var(--font-bold);
            font-size: 14px;
        }

        .warning-list {
            margin: 0;
            padding-left: 20px;
            font-size: 13px;
            color: #555;
        }

        .warning-list li {
            margin-bottom: 5px;
            line-height: 1.4;
        }

        .warning-list li:last-child {
            margin-bottom: 0;
        }

        .warning-list strong {
            color: #333;
        }

        /* 모달 표시 애니메이션 */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .fade-in {
            animation: fadeIn 0.3s ease-in-out;
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
                            <h1 class="post-title">주말 캠핑에서 찍은 사진</h1>
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
                        <p>지난 주말 양평 근처 캠핑장에서 찍은 사진을 공유합니다.</p>

                        <p>지난 달에 새로 구입한 소토(SOTO) 화로대를 사용했는데, 장작도 잘 타고 불꽃 모양도 예뻐서
                            정말 좋았습니다. 화로대 위에 그릴을 올려 고기도 구워 먹을 수 있어서 일석이조였어요.</p>

                        <p>핫초코는 정말 최고의 조합이었습니다. 별 구경은 도시에서는 느낄 수 없는 힐링을 선사해줍니다.</p>

                        <div class="post-images">
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="이미지1">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="이미지2">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="이미지3">
                            </div>
                            <div class="post-image">
                                <img src="/api/placeholder/120/120" alt="이미지4">
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
                                    <div class="charCounter text-right mt-1 text-secondary">0/1000byte</div>
                                    <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
                                        <div>
                                            <button class="btn btn-outline-primary btn-sm"><i
                                                    class="fa-solid fa-paperclip"></i>첨부파일
                                            </button>
                                        </div>
                                        <div>
                                            <button class="btn btn-sm cancel-reply">취소</button>
                                            <button class="btn btn-primary btn-sm">등록</button>
                                        </div>
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
                                    <div class="charCounter text-right mt-1 text-secondary">0/1000byte</div>
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
                                    <div class="charCounter text-right mt-1 text-secondary">0/1000byte</div>
                                    <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                                        <button class="btn btn-sm cancel-reply">취소</button>
                                        <button class="btn btn-primary btn-sm">등록</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="p-3">
                        <textarea id="contentArea" class="form-control mb-2" rows="3" placeholder="댓글을 작성해주세요"></textarea>
                        <div class="charCounter text-right mt-1 text-secondary">0/1000byte</div>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-outline-primary"><i class="fa-solid fa-paperclip"></i>첨부파일</button>
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
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <div class="d-flex border rounded">
                            <select class="form-control-sm border-0"
                                    style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                <option>제목+내용</option>
                                <option>제목</option>
                                <option>내용</option>
                                <option>작성자</option>
                            </select>
                            <input type="text" class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요"
                                   style="padding: 8px 10px; font-size: 13px;">
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

<!-- 모달 컴포넌트 - body 태그 닫기 전에 추가 -->
<div class="modal-backdrop" id="modalBackdrop" style="display: none;"></div>

<div class="report-modal" id="reportModal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">신고하기</h5>
            <button type="button" class="close-btn" id="closeModalBtn">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <form id="reportForm">
                <div class="form-group mb-3">
                    <label class="form-label">신고 사유</label>
                    <select class="form-select" id="reportReason" required>
                        <option value="" selected disabled>신고 사유를 선택해주세요</option>
                        <option value="spam">스팸/홍보 게시글</option>
                        <option value="abuse">욕설/비방/차별/혐오</option>
                        <option value="adult">음란물/성적 콘텐츠</option>
                        <option value="illegal">불법 정보</option>
                        <option value="privacy">개인정보 노출</option>
                        <option value="other">기타</option>
                    </select>
                </div>
                <div class="form-group mb-3">
                    <label class="form-label">상세 내용</label>
                    <textarea class="form-control" id="reportDetail" rows="4" placeholder="상세 내용을 입력해주세요"></textarea>
                </div>
                <div class="report-warning">
                    <div class="warning-header">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <span>신고 전 주의사항</span>
                    </div>
                    <ul class="warning-list">
                        <li>허위 신고는 <strong>서비스 이용 제한</strong>의 사유가 될 수 있습니다.</li>
                        <li>신고 내용은 <strong>관리자만 확인</strong>할 수 있으며, 신고자의 정보는 보호됩니다.</li>
                        <li>신고 처리 결과는 별도로 <strong>통보되지 않습니다</strong>.</li>
                        <li>명확한 증거가 있는 경우 <strong>상세 내용에 기재</strong>해 주시기 바랍니다.</li>
                    </ul>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="cancelReportBtn">취소</button>
            <button type="button" class="btn btn-danger" id="submitReportBtn">신고하기</button>
        </div>
    </div>
</div>

<!-- 신고 완료 모달 -->
<div class="popup-alert" id="completionModal" style="display: none;">
    <div class="popup-alert-icon text-success">
        <i class="fa-solid fa-check-circle"></i>
    </div>
    <div class="popup-alert-title">신고가 접수되었습니다</div>
    <div class="popup-alert-content">검토 후 조치하겠습니다.</div>

    <!-- 확인 버튼 -->
    <div class="popup-alert-buttons">
        <button class="btn btn-primary" id="confirmReportBtn">확인</button>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script>
    // 모든 기능 초기화
    document.addEventListener('DOMContentLoaded', function () {
        // 모든 댓글 답글 영역 숨기기
        document.querySelectorAll('.comment-reply-area').forEach(area => {
            area.style.display = 'none';
        });

        // 답글 버튼 클릭 시 답글 영역 토글
        document.querySelectorAll('.reply-toggle').forEach(button => {
            button.addEventListener('click', function () {
                const commentItem = this.closest('.comment-item');
                const replyArea = commentItem.querySelector('.comment-reply-area');

                // 모든 답글 영역을 먼저 숨김
                document.querySelectorAll('.comment-reply-area').forEach(area => {
                    area.style.display = 'none';
                });

                // 클릭한 답글 영역만 보이게 함
                if (replyArea) {
                    replyArea.style.display = 'block';
                }
            });
        });

        // 취소 버튼 이벤트 리스너
        document.querySelectorAll('.cancel-reply').forEach(button => {
            button.addEventListener('click', function () {
                const replyArea = this.closest('.comment-reply-area');
                if (replyArea) {
                    replyArea.style.display = 'none';
                }
            });
        });
    });



    // 2. 모든 텍스트 입력창(메인 댓글 + 대댓글)에 바이트 카운터 기능 적용
    // 바이트 수 계산 함수
    function calculateBytes(str) {
        let byteCount = 0;
        for (let i = 0; i < str.length; i++) {
            const charCode = str.codePointAt(i);

            // '서로게이트 페어(Surrogate Pair)' 처리 - 이모지 등 특수 문자
            if (charCode > 0xFFFF) {
                byteCount += 4;
                i++;
            } else if (charCode > 0x7FF) {
                byteCount += 3;
            } else if (charCode > 0x7F) {
                byteCount += 2;
            } else {
                byteCount += 1;
            }
        }
        return byteCount;
    }

    // 디바운스 함수 정의 - 연속 이벤트 처리 최적화
    function debounce(func, wait) {
        let timeout;
        return function(...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // 모든 댓글 및 대댓글 텍스트 영역에 바이트 체크 적용
    function applyByteCounter(textarea) {
        if (!textarea) return;

        // 해당 텍스트영역의 카운터 찾기 (형제 요소)
        const counterEl = textarea.parentNode.querySelector('.charCounter');
        if (!counterEl) return;

        // 바이트 업데이트 함수
        function updateByteCount() {
            const text = textarea.value;
            let currentBytes = calculateBytes(text);

            // 1000 byte 초과 시 자르기
            if (currentBytes > 1000) {
                // 바이너리 검색 최적화
                let start = 0;
                let end = text.length;
                let mid;
                let cutText = text;

                while (start < end) {
                    mid = Math.floor((start + end) / 2);
                    cutText = text.substring(0, mid);

                    if (calculateBytes(cutText) <= 1000) {
                        start = mid + 1;
                    } else {
                        end = mid;
                    }
                }

                // 최종 적합한 지점 찾기
                while (calculateBytes(cutText) > 1000) {
                    cutText = cutText.slice(0, -1);
                }

                // 잘린 텍스트로 업데이트
                textarea.value = cutText;
                currentBytes = calculateBytes(cutText);
            }

            // 카운터 업데이트
            counterEl.textContent = currentBytes + '/1000byte';
        }

        // 디바운싱 적용
        const debouncedUpdate = debounce(updateByteCount, 100);

        // 이미 리스너가 있을 수 있으므로 한 번 제거했다가 다시 추가
        textarea.removeEventListener('input', debouncedUpdate);
        textarea.addEventListener('input', debouncedUpdate);

        // 초기 카운트 표시
        updateByteCount();
    }

    // 메인 댓글창에 적용
    const mainCommentArea = document.getElementById('contentArea');
    if (mainCommentArea) {
        applyByteCounter(mainCommentArea);
    }

    // 답글 표시 버튼 클릭 시 대댓글 입력창에도 바이트 카운터 적용
    document.querySelectorAll('.reply-toggle').forEach(button => {
        button.addEventListener('click', function() {
            // 해당 댓글 항목 찾기
            const commentItem = this.closest('.comment-item');
            if (!commentItem) return;

            // 대댓글 입력창 찾기
            const replyArea = commentItem.querySelector('.comment-reply-area');
            if (!replyArea) return;

            // 대댓글 텍스트 영역 찾기
            const replyTextarea = replyArea.querySelector('textarea');
            if (replyTextarea) {
                // 약간 지연을 두고 적용 (표시 애니메이션 이후)
                setTimeout(() => {
                    applyByteCounter(replyTextarea);
                }, 50);
            }
        });
    });




    //-------------------------------------------------------------------------------
    document.addEventListener('DOMContentLoaded', function() {
        const modalBackdrop = document.getElementById('modalBackdrop');
        const reportModal = document.getElementById('reportModal');
        const completionModal = document.getElementById('completionModal');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelReportBtn = document.getElementById('cancelReportBtn');
        const submitReportBtn = document.getElementById('submitReportBtn');

        // 신고 대상 정보를 저장할 변수
        let reportTargetType = ''; // 'post' 또는 'comment'
        let reportTargetId = '';   // 게시글 ID 또는 댓글 ID

        // 모든 신고 버튼에 직접 onclick 핸들러 할당 (이벤트 위임 방식으로 변경)
        document.addEventListener('click', function(e) {
            // 클릭된 요소가 report-btn 클래스를 가지고 있는지 확인
            if (e.target.classList.contains('report-btn') ||
                e.target.closest('.report-btn')) {
                e.preventDefault();

                // 실제 클릭된 버튼을 찾음
                const reportBtn = e.target.classList.contains('report-btn') ?
                    e.target : e.target.closest('.report-btn');

                // 신고 대상 정보 설정
                const commentItem = reportBtn.closest('.comment-item');

                if (commentItem) {
                    // 댓글 신고
                    reportTargetType = 'comment';
                    // data-id 속성이 있으면 사용, 없으면 기본값 사용
                    reportTargetId = reportBtn.dataset.id || '1';
                } else {
                    // 게시글 신고
                    reportTargetType = 'post';
                    reportTargetId = reportBtn.dataset.id || '13150';
                }

                // 모달 표시
                showModal();
            }
        });

        // 모달 닫기 함수
        function closeModal() {
            modalBackdrop.style.display = 'none';
            reportModal.style.display = 'none';

            // 모달 닫을 때 애니메이션 클래스 제거
            reportModal.classList.remove('fade-in');

            // 폼 초기화
            document.getElementById('reportForm').reset();
        }

        // 모달 표시 함수
        function showModal() {
            modalBackdrop.style.display = 'block';
            reportModal.style.display = 'block';
            reportModal.classList.add('show', 'fade-in');
            modalBackdrop.classList.add('show');
        }

        // 닫기 버튼 클릭 시 모달 닫기
        closeModalBtn.addEventListener('click', closeModal);
        cancelReportBtn.addEventListener('click', closeModal);

        // 배경 클릭 시 모달 닫기
        modalBackdrop.addEventListener('click', closeModal);

        // 모달 내부 클릭 시 이벤트 버블링 방지
        reportModal.addEventListener('click', function(e) {
            e.stopPropagation();
        });

        // 신고 제출 버튼 클릭 시
        submitReportBtn.addEventListener('click', function() {
            const reportReason = document.getElementById('reportReason').value;
            const reportDetail = document.getElementById('reportDetail').value;

            // 필수 항목 검증
            if (!reportReason) {
                alert('신고 사유를 선택해주세요.');
                return;
            }

            // 여기에 신고 데이터 처리 AJAX 요청을 추가할 수 있음
            // 예: fetch('/api/report', { method: 'POST', body: JSON.stringify({...}) })

            // 신고 모달 닫기
            reportModal.style.display = 'none';

            // 완료 모달 표시
            completionModal.style.display = 'block';
            completionModal.classList.add('zoom-in');
        });

        // 완료 모달의 확인 버튼 클릭 시 목록 페이지로 이동
        document.getElementById('confirmReportBtn').addEventListener('click', function() {
            // 모달 닫기
            modalBackdrop.style.display = 'none';
            completionModal.style.display = 'none';

            // 목록 페이지로 이동
            window.location.href = 'boardfree.action'; // 실제 구현 시 적절한 URL로 변경 필요
        });
    });

</script>
</body>
</html>


<%--.progress-bar-container {--%>
<%--width: 80%;--%>
<%--margin: 20px auto 0;--%>
<%--background-color: var(--color-gray-200);--%>
<%--border-radius: 10px;--%>
<%--height: 6px;--%>
<%--overflow: hidden;--%>
<%--}--%>

<%--.progress-bar {--%>
<%--height: 100%;--%>
<%--width: 0;--%>
<%--background-color: var(--color-maple);--%>
<%--transition: width 3s linear;--%>
<%--}--%>





<%--<!-- 신고 완료 모달 -->--%>
<%--<div class="popup-alert" id="completionModal" style="display: none;">--%>
<%--    <div class="popup-alert-icon text-success">--%>
<%--        <i class="fa-solid fa-check-circle"></i>--%>
<%--    </div>--%>
<%--    <div class="popup-alert-title">신고가 접수되었습니다</div>--%>
<%--    <div class="popup-alert-content">검토 후 조치하겠습니다. 잠시 후 목록 페이지로 이동합니다.</div>--%>

<%--    <!-- 진행 상태 표시줄 -->--%>
<%--    <div class="progress-bar-container">--%>
<%--        <div class="progress-bar" id="completionProgressBar"></div>--%>
<%--    </div>--%>
<%--</div>--%>





<%--document.addEventListener('DOMContentLoaded', function() {--%>
<%--const modalBackdrop = document.getElementById('modalBackdrop');--%>
<%--const reportModal = document.getElementById('reportModal');--%>
<%--const completionModal = document.getElementById('completionModal');--%>
<%--const closeModalBtn = document.getElementById('closeModalBtn');--%>
<%--const cancelReportBtn = document.getElementById('cancelReportBtn');--%>
<%--const submitReportBtn = document.getElementById('submitReportBtn');--%>

<%--// 신고 대상 정보를 저장할 변수--%>
<%--let reportTargetType = ''; // 'post' 또는 'comment'--%>
<%--let reportTargetId = '';   // 게시글 ID 또는 댓글 ID--%>

<%--// 모든 신고 버튼에 직접 onclick 핸들러 할당 (이벤트 위임 방식으로 변경)--%>
<%--document.addEventListener('click', function(e) {--%>
<%--// 클릭된 요소가 report-btn 클래스를 가지고 있는지 확인--%>
<%--if (e.target.classList.contains('report-btn') ||--%>
<%--e.target.closest('.report-btn')) {--%>
<%--e.preventDefault();--%>

<%--// 실제 클릭된 버튼을 찾음--%>
<%--const reportBtn = e.target.classList.contains('report-btn') ?--%>
<%--e.target : e.target.closest('.report-btn');--%>

<%--// 신고 대상 정보 설정--%>
<%--const commentItem = reportBtn.closest('.comment-item');--%>

<%--if (commentItem) {--%>
<%--// 댓글 신고--%>
<%--reportTargetType = 'comment';--%>
<%--// data-id 속성이 있으면 사용, 없으면 기본값 사용--%>
<%--reportTargetId = reportBtn.dataset.id || '1';--%>
<%--} else {--%>
<%--// 게시글 신고--%>
<%--reportTargetType = 'post';--%>
<%--reportTargetId = reportBtn.dataset.id || '13150';--%>
<%--}--%>

<%--// 모달 표시--%>
<%--showModal();--%>
<%--}--%>
<%--});--%>

<%--// 모달 닫기 함수--%>
<%--function closeModal() {--%>
<%--modalBackdrop.style.display = 'none';--%>
<%--reportModal.style.display = 'none';--%>

<%--// 모달 닫을 때 애니메이션 클래스 제거--%>
<%--reportModal.classList.remove('fade-in');--%>

<%--// 폼 초기화--%>
<%--document.getElementById('reportForm').reset();--%>
<%--}--%>

<%--// 모달 표시 함수--%>
<%--function showModal() {--%>
<%--modalBackdrop.style.display = 'block';--%>
<%--reportModal.style.display = 'block';--%>
<%--reportModal.classList.add('show', 'fade-in');--%>
<%--modalBackdrop.classList.add('show');--%>
<%--}--%>

<%--// 닫기 버튼 클릭 시 모달 닫기--%>
<%--closeModalBtn.addEventListener('click', closeModal);--%>
<%--cancelReportBtn.addEventListener('click', closeModal);--%>

<%--// 배경 클릭 시 모달 닫기--%>
<%--modalBackdrop.addEventListener('click', closeModal);--%>

<%--// 모달 내부 클릭 시 이벤트 버블링 방지--%>
<%--reportModal.addEventListener('click', function(e) {--%>
<%--e.stopPropagation();--%>
<%--});--%>

<%--// 신고 제출 버튼 클릭 시--%>
<%--submitReportBtn.addEventListener('click', function() {--%>
<%--const reportReason = document.getElementById('reportReason').value;--%>
<%--const reportDetail = document.getElementById('reportDetail').value;--%>

<%--// 필수 항목 검증--%>
<%--if (!reportReason) {--%>
<%--alert('신고 사유를 선택해주세요.');--%>
<%--return;--%>
<%--}--%>

<%--// 여기에 신고 데이터 처리 AJAX 요청을 추가할 수 있음--%>
<%--// 예: fetch('/api/report', { method: 'POST', body: JSON.stringify({...}) })--%>

<%--// 신고 모달 닫기--%>
<%--modalBackdrop.style.display = 'block';--%>
<%--reportModal.style.display = 'none';--%>

<%--// 완료 모달 표시--%>
<%--completionModal.style.display = 'block';--%>
<%--completionModal.classList.add('zoom-in');--%>

<%--// 진행 상태 표시 (프로그레스 바 애니메이션)--%>
<%--const progressBar = document.getElementById('completionProgressBar');--%>
<%--if (progressBar) {--%>
<%--progressBar.style.width = '100%';--%>
<%--}--%>

<%--// 3초 후에 목록 페이지로 이동--%>
<%--setTimeout(function() {--%>
<%--window.location.href = 'boardfree.action'; // 실제 구현 시 적절한 URL로 변경 필요--%>
<%--}, 3000);--%>
<%--});--%>