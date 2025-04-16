<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="checkLogin.jsp" %>
<html>
<head>
  <title>공지사항 - 게시글 상세</title>
  <!-- CSS 파일 로드 -->
  <link rel="stylesheet" href="../../resources/css/main.css">
  <!-- Font Awesome CDN 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
      justify-content: space-between; /* 양쪽 끝으로 정렬 */
      align-items: center;
      width: 100%;
    }

    .like-area {
      display: flex;
      align-items: center;
      gap: var(--spacing-sm);
    }

    .nav-buttons {
      display: flex;
      gap: 8px; /* 버튼 사이 간격 */
      margin-top: 0 !important;
    }

    .like-icon i {
      color: var(--color-coral);
      font-size: var(--font-md);
    }

    .comment-author img {
      width: 24px;
      height: 24px;
      border-radius: 50%;
      object-fit: cover;
    }

   .delete-btn, .update-btn, .report-btn {
      background: transparent;
      border: none;
      color: var(--text-secondary);
      cursor: pointer;
      padding: 5px 5px;
      font-size: var(--font-xs);
      transition: all 0.2s ease;
    }

    .delete-btn:hover, .update-btn:hover, .report-btn:hover {
      color: var(--color-maple);
    }

    .post-header {
      padding: var(--spacing-md) var(--spacing-lg);
      border-bottom: 1px solid var(--border-light);
      display: flex;
      justify-content: space-between;
      align-items: flex-start; /* 위에 정렬 */
    }

    .post-actions-right {
      display: flex;
      gap: 10px;
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

    .icon-heart {
      color: var(--color-error);
    }

    .table-icon {
      margin-right: 5px;
    }

  </style>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- 디버깅용 정보 (테스트 후 제거) -->
<%--<c:if test="${not empty sessionScope.user_code}">--%>
<%--    <div style="background-color: #f8f9fa; padding: 10px; margin: 10px 0; border: 1px solid #ddd;">--%>
<%--        게시글 작성자: ${post.userCode}, 로그인 사용자: ${sessionScope.user_code},--%>
<%--        일치 여부: ${post.userCode == sessionScope.user_code}--%>
<%--    </div>--%>
<%--</c:if>--%>


<div class="page-wrapper">
  <div class="container" style="max-width: 1500px; padding: 0 15px;">
    <div class="main-content d-flex gap-4 my-5">
      <div class="main-column" style="flex: 1; padding-left: 5px;">
        <div class="page-header mb-4">
          <h1 class="page-title"><i class="fa-solid fa-bullhorn"></i> 공지사항</h1>
        </div>
        <!-- 게시글 영역 -->
        <div class="post-container">
          <div class="post-header">
            <div>
              <h1 class="post-title">${post.postTitle}</h1>
              <div class="post-info">
                <div class="post-author">
                  <i class="fa-solid fa-user-shield table-icon"></i>관리자
                </div>
                <div class="post-date">${post.createdDate.substring(0, 10)}</div>
                <div class="post-views">조회수 ${post.viewCount}</div>
                <div class="post-likes">추천 ${post.recommendCount}</div>
              </div>
            </div>
            <div class="post-actions-right">
              <c:if test="${post.userCode eq sessionScope.user_code}">
                <button class="update-btn"
                        onclick="location.href='boardfree-update.action?postId=${post.postId}'">수정
                </button>
                <button class="delete-btn" onclick="confirmDelete(${post.postId})">삭제</button>
              </c:if>
            </div>
          </div>
          <div class="post-body">
            ${post.postContent}

            <!-- 첨부 이미지가 있는 경우 표시 -->
            <c:if test="${not empty post.attachments and fn:length(post.attachments) > 0}">
              <div class="post-images">
                <c:forEach var="attachment" items="${post.attachments}">
                  <c:if test="${not empty attachment.attachmentPath}">
                    <div class="post-image">
                      <img src="${attachment.attachmentPath}" alt="${attachment.attachmentName}">
                    </div>
                  </c:if>
                </c:forEach>
              </div>
            </c:if>
          </div>

          <div class="p-4 border-top">
            <div class="post-actions">
              <!-- 추천 버튼을 왼쪽으로 배치 -->
              <div class="like-area">
                <button class="btn btn-icon" id="likeButton" data-post-id="${post.postId}">
                  <i class="fas fa-heart icon-heart"></i>
                </button>
                <span class="font-bold" id="likeCount">추천 ${post.recommendCount}</span>
              </div>

              <!-- 이전글, 목록, 다음글 버튼을 오른쪽으로 배치 -->
              <div class="nav-buttons" style="display: flex; gap: 8px;">
                <button class="btn btn-sm"
                        onclick="location.href='noticepost.action?postId=${prevPostId}'">이전글
                </button>
                <button class="btn btn-sm" onclick="location.href='notice.action'">목록</button>
                <button class="btn btn-sm"
                        onclick="location.href='noticepost.action?postId=${nextPostId}'">다음글
                </button>
              </div>
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
          <c:forEach var="noticeList" items="${noticeList}" varStatus="status">
            <tr class="board-row border-bottom">
              <td class="p-3 text-center">${pagenation.totalPost - ((pagenation.pageNum - 1) * pagenation.pageSize) - status.index}</td>
              <td class="p-3 text-center"><span class="board-category-tag
                                          ${noticeList.postLabelName == '중요' ? 'important' :
                                            noticeList.postLabelName == '공지' ? 'notice' :
                                            noticeList.postLabelName == '업데이트' ? 'update' : ''}">${noticeList.postLabelName}</span>
              </td>
              <td class="p-3 title-cell"><a
                      href="noticepost.action?postId=${noticeList.postId}">${noticeList.postTitle}</a>
              </td>
              <td class="p-3 text-center"><i class="fa-solid fa-user-shield table-icon"></i>관리자</td>
              <td class="p-3 text-center">${noticeList.createdDate.substring(0, 10)}</td>
              <td class="p-3 text-center">${noticeList.viewCount}</td>
              <td class="p-3 text-center"><i
                      class="fa-solid fa-heart table-icon icon-heart"></i>${noticeList.recommendCount}
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty noticeList}">
            <tr class="board-row border-bottom">
              <td colspan="7" class="p-3 text-center">게시글이 없습니다.</td>
            </tr>
          </c:if>
          </tbody>
        </table>

        <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
          <!-- 검색 영역 - 왼쪽 -->
          <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
            <form action="notice.action" method="get">
              <div class="d-flex border rounded">
                <select name="searchType" class="form-control-sm border-0"
                        style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                  <option value="titlecontent" ${searchType == 'titlecontent' ? 'selected' : ''}>
                    제목+내용
                  </option>
                  <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                  <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                  <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                </select>
                <input type="text" name="searchKeyword" value="${searchKeyword}"
                       class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요"
                       style="padding: 8px 10px; font-size: 13px;">
                <button type="submit" class="btn border-0"
                        style="background-color: #f8f9fa; padding: 8px 10px;">
                  <i class="fa-solid fa-magnifying-glass"></i>
                </button>
              </div>
            </form>
          </div>

          <!-- 페이지네이션 - 중앙에 가깝게 -->
          <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
            <div class="d-flex gap-1 pagination">
              <!-- 첫 페이지로 -->
              <c:if test="${pagenation.pageNum > 1}">
                <a href="notice.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                   class="btn btn-sm">
                  <i class="fa-solid fa-angles-left"></i>
                </a>
              </c:if>

              <!-- 이전 블록으로 -->
              <c:if test="${pagenation.startPage > pagenation.blockSize}">
                <a href="notice.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                   class="btn btn-sm">
                  <i class="fa-solid fa-chevron-left"></i>
                </a>
              </c:if>

              <!-- 페이지 번호 -->
              <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                <a href="notice.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
              </c:forEach>

              <!-- 다음 블록으로 -->
              <c:if test="${pagenation.endPage < pagenation.totalPage}">
                <a href="notice.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                   class="btn btn-sm">
                  <i class="fa-solid fa-chevron-right"></i>
                </a>
              </c:if>

              <!-- 마지막 페이지로 -->
              <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                <a href="notice.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                   class="btn btn-sm">
                  <i class="fa-solid fa-angles-right"></i>
                </a>
              </c:if>
            </div>
          </div>

          <!-- 글쓰기 버튼 - 오른쪽 -->
          <div style="flex: 1; display: flex; justify-content: flex-end;">

            <button class="btn btn-primary" onclick="goToWrite()">
              <i class="fa-solid fa-pen"></i> 글쓰기
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
