<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="checkLogin.jsp"%>
<html>
<head>
  <title>글쓰기 - 공지사항</title>
  <!-- CSS 파일 로드 -->
  <link rel="stylesheet" href="../../resources/css/main.css">
  <!-- Font Awesome CDN 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    /* 글쓰기 폼 관련 추가 스타일 */
    .input-label {
      display: block;
      margin-bottom: var(--spacing-xs);
      font-weight: var(--font-semibold);
      font-size: var(--font-xs);
      color: var(--text-primary);
    }

    .input-field {
      width: 100%;
      padding: var(--spacing-xs);
      border: 1px solid var(--border-medium);
      border-radius: var(--radius-sm);
      font-size: var(--font-xs);
      background-color: var(--bg-primary);
    }

    select.input-field {
      height: 40px;
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' viewBox='0 0 16 16'%3E%3Cpath d='M8 11.5l-5-5h10l-5 5z'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 12px center;
      background-size: 16px;
      padding-right: 36px;
    }

    .editor-container {
      border: 1px solid var(--border-medium);
      border-radius: var(--radius-sm);
      overflow: hidden;
    }

    .editor-toolbar {
      display: flex;
      flex-wrap: wrap;
      gap: var(--spacing-xs);
      padding: var(--spacing-sm);
      background-color: var(--bg-secondary);
      border-bottom: 1px solid var(--border-medium);
    }

    .toolbar-group {
      display: flex;
      gap: var(--spacing-xs);
      border-right: 1px solid var(--border-light);
      padding-right: var(--spacing-sm);
      margin-right: var(--spacing-sm);
    }

    .toolbar-group:last-child {
      border-right: none;
    }

    .toolbar-btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 30px;
      height: 30px;
      background-color: transparent;
      border: 1px solid transparent;
      border-radius: var(--radius-sm);
      cursor: pointer;
      color: var(--text-secondary);
    }

    .toolbar-btn:hover {
      background-color: var(--color-gray-200);
      border-color: var(--border-medium);
    }

    .toolbar-select {
      height: 30px;
      padding: 0 10px;
      background-color: transparent;
      border: 1px solid var(--border-medium);
      border-radius: var(--radius-sm);
      font-size: var(--font-xxs);
      color: var(--text-secondary);
    }

    .editor-content {
      min-height: 400px;
      padding: var(--spacing-md);
      font-size: var(--font-xs);
    }

    /* 모달 스타일 수정 */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .modal {
      background-color: white;
      padding: var(--spacing-lg, 20px);
      border-radius: var(--radius-md, 8px);
      min-width: 400px;
      text-align: center;
      box-shadow: var(--shadow-lg, 0 4px 8px rgba(0, 0, 0, 0.1));
    }

    .modal-header {
      font-size: var(--font-md, 18px);
      font-weight: var(--font-bold, bold);
      margin-bottom: var(--spacing-lg, 20px);
      color: var(--text-primary, #333);
    }

    .modal-footer {
      display: flex;
      justify-content: center;
      gap: var(--spacing-md, 10px);
      margin-top: var(--spacing-lg, 20px);
    }
  </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-wrapper">
  <div class="container" style="max-width: 1500px; padding: 0 15px;">
    <div class="main-content d-flex gap-4 my-5">
      <!-- 메인 콘텐츠 -->
      <div class="main-column" style="flex: 1; padding-left: 5px;">
        <div class="page-header">
          <h1 class="page-title"><i class="fa-solid fa-pen"></i> ${isUpdate ? '글 수정' : '글쓰기'}</h1>
        </div>

        <div class="content-box p-5">
          <form id="postForm" method="POST"
                action="${isUpdate ? 'api/notice/update.action' : 'notice-write.action'}">
            <!-- 수정 모드일 경우 postId 필드 추가 -->
            <c:if test="${isUpdate}">
              <input type="hidden" name="postId" value="${noticeList.postId}"/>
            </c:if>

            <div class="form-group mb-3">
              <label class="form-label">게시판</label>
              <select class="form-select" id="boardId" name="boardId" ${isUpdate ? 'disabled' : ''}>
                <c:forEach var="board" items="${communityBoards}">
                  <option value="${board.boardId}" ${(isUpdate && post.boardId == board.boardId) || (!isUpdate && board.boardId == 1) ? 'selected' : ''}>${board.boardName}</option>
                </c:forEach>
              </select>
              <!-- 수정 모드에서 disabled된 필드의 값을 전송하기 위한 hidden 필드 -->
              <c:if test="${isUpdate}">
                <input type="hidden" name="boardId" value="${noticeList.boardId}"/>
              </c:if>
            </div>

            <div class="form-group mb-3">
              <label class="form-label">말머리</label>
              <select class="form-select" id="postLabelId" name="postLabelId">
                <c:forEach var="label" items="${postLabels}">
                  <option value="${label.postLabelId}" ${isUpdate && post.postLabelId == label.postLabelId ? 'selected' : ''}>${label.postLabelName}</option>
                </c:forEach>
              </select>
            </div>

            <div class="form-group mb-3">
              <label class="form-label">제목</label>
              <input type="text" class="form-control" name="postTitle"
                     value="${isUpdate ? post.postTitle : ''}" placeholder="제목을 작성하세요." required/>
            </div>

            <div class="mb-4">
              <label class="form-label">내용</label>
              <div class="editor-container">
                <div class="editor-toolbar">
                  <div class="toolbar-group">
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-arrow-left"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-arrow-right"></i></button>
                  </div>
                  <div class="toolbar-group">
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-bold"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-italic"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-underline"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-strikethrough"></i></button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-xmark"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-subscript"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-superscript"></i></button>
                  </div>
                  <div class="toolbar-group">
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-align-left"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-align-center"></i></button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-align-right"></i></button>
                    <button type="button" class="toolbar-btn"><i
                            class="fa-solid fa-align-justify"></i></button>
                  </div>
                  <div class="toolbar-group">
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-list"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-list-ol"></i>
                    </button>
                  </div>
                  <div class="toolbar-group">
                    <select class="toolbar-select">
                      <option>스타일</option>
                    </select>
                    <select class="toolbar-select">
                      <option>본문</option>
                    </select>
                    <select class="toolbar-select">
                      <option>글꼴</option>
                    </select>
                    <select class="toolbar-select">
                      <option>크기</option>
                    </select>
                  </div>
                  <div class="toolbar-group">
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-link"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-image"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-table"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-face-smile"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-headphones"></i>
                    </button>
                    <button type="button" class="toolbar-btn"><i class="fa-solid fa-quote-left"></i>
                    </button>
                  </div>
                </div>

                <textarea class="form-control" name="postContent" rows="10" placeholder="내용을 작성하세요."
                          required>${isUpdate ? post.postContent : ''}</textarea>

              </div>
            </div>

            <div class="d-flex justify-content-between gap-2 mt-4">
              <div>
                <button type="button" class="btn btn-outline-primary"><i
                        class="fa-solid fa-paperclip"></i> 첨부파일
                </button>
              </div>
              <div class="d-flex gap-2">
                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-primary">${isUpdate ? '수정하기' : '등록하기'}</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 모달 배경 -->
<div class="modal-backdrop"></div>

<!-- 확인 모달 수정 -->
<div class="modal" id="confirmModal">
  <div class="modal-header">
    <h5 class="modal-title">${isUpdate ? '게시글을 수정 하시겠습니까?' : '게시글을 등록 하시겠습니까?'}</h5>
  </div>
  <div class="modal-footer">
    <button class="btn btn-secondary" id="cancelBtn">취소</button>
    <button class="btn btn-primary" id="confirmBtn">확인</button>
  </div>
</div>

<!-- 성공 모달 수정 -->
<div class="modal" id="successModal">
  <div class="modal-header">
    <h5 class="modal-title">${isUpdate ? '게시글이 수정 되었습니다.' : '게시글이 등록 되었습니다.'}</h5>
  </div>
  <div class="modal-footer">
    <button class="btn btn-primary" id="okBtn">확인</button>
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<!-- 수정 모드일 경우 폼 제출 처리 스크립트 -->
<c:if test="${isUpdate}">
  <script>
    document.getElementById('postForm').addEventListener('submit', function (e) {
      e.preventDefault();

      // 폼 데이터 수집
      const formData = new FormData(this);
      const jsonData = {};

      // FormData를 JSON으로 변환
      for (const [key, value] of formData.entries()) {
        jsonData[key] = value;
      }

      // AJAX 요청 보내기
      fetch('api/post/update.action', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(jsonData)
      })
              .then(response => response.json())
              .then(data => {
                if (data.success) {
                  alert('게시글이 수정되었습니다.');
                  // 수정된 게시글 상세 페이지로 이동
                  location.href = 'boardfree-post.action?postId=' + data.postId;
                } else {
                  alert('게시글 수정에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
              })
              .catch(error => {
                console.error('Error:', error);
                alert('게시글 수정 중 오류가 발생했습니다.');
              });
    });
  </script>
</c:if>

<script>
  // 문서가 완전히 로드된 후 실행
  document.addEventListener('DOMContentLoaded', function () {
    // 요소 참조
    const boardSelect = document.getElementById('boardId');
    const headerTagSelect = document.getElementById('postLabelId');
    const boardWriteForm = document.getElementById('boardWriteForm');
    const editorContent = document.querySelector('.editor-content');
    const postContentInput = document.getElementById('postContent');
    const submitBtn = document.getElementById('submitBtn');
    const confirmModal = document.getElementById('confirmModal');
    const successModal = document.getElementById('successModal');

    // 게시판 목록 가져오기
    loadBoardList();

    // 게시판 변경 시 말머리 목록 가져오기
    if (boardSelect) {
      boardSelect.addEventListener('change', function () {
        const selectedBoardId = this.value;
        if (selectedBoardId) {
          loadHeaderTags(selectedBoardId);
        }
      });
    }

    // 게시판 목록 로드 함수
    function loadBoardList() {
      // 커뮤니티 카테고리(4)의 게시판 목록 가져오기
      fetch('/api/boards/category/4')
              .then(response => {
                if (!response.ok) {
                  throw new Error('게시판 목록을 가져오는데 실패했습니다.');
                }
                return response.json();
              })
              .then(boards => {
                // 게시판 목록 초기화
                if (boardSelect) {
                  boardSelect.innerHTML = '';

                  // 각 게시판에 대한 옵션 추가
                  boards.forEach(board => {
                    const option = document.createElement('option');
                    option.value = board.boardId;
                    option.textContent = board.boardName;
                    boardSelect.appendChild(option);
                  });

                  // 기본적으로 첫 번째 게시판 선택 및 해당 말머리 로드
                  if (boards.length > 0) {
                    const defaultBoardId = boards[0].boardId;
                    loadHeaderTags(defaultBoardId);
                  }
                }
              })
              .catch(error => {
                console.error('게시판 목록 로드 오류:', error);
                alert('게시판 목록을 가져오는데 실패했습니다. 다시 시도해주세요.');
              })
    }

    // 말머리 목록 로드 함수
    function loadHeaderTags(boardId) {
      fetch("/api/post-labels/board/" + boardId)
              .then(response => {
                if (!response.ok) {
                  throw new Error('말머리 목록을 가져오는데 실패했습니다.');
                }
                return response.json();
              })
              .then(labels => {
                // 말머리 옵션 초기화
                if (headerTagSelect) {
                  headerTagSelect.innerHTML = '';

                  // 말머리 옵션 추가
                  labels.forEach(label => {
                    const option = document.createElement('option');
                    option.value = label.postLabelId;
                    option.textContent = label.postLabelName;
                    headerTagSelect.appendChild(option);
                  });
                }
              })
              .catch(error => {
                console.error('말머리 목록 로드 오류:', error);
                // 오류 시 기본 옵션 추가
                if (headerTagSelect) {
                  headerTagSelect.innerHTML = '<option value="">말머리를 선택하세요</option>';
                }
              })
    }

    // 에디터 내용 클릭 시 기본 텍스트 제거
    if (editorContent) {
      editorContent.addEventListener('focus', function () {
        if (this.textContent === '내용을 입력하세요.') {
          this.textContent = '';
        }
      });
    }

    // 등록 버튼 클릭 시 확인 모달 표시
    if (submitBtn && confirmModal) {
      submitBtn.addEventListener('click', function () {
        confirmModal.classList.add('show');
        document.querySelector('.modal-backdrop').classList.add('show');
      });
    }

    // 취소 버튼 클릭 시 모달 닫기
    const cancelBtn = document.getElementById('cancelBtn');
    if (cancelBtn && confirmModal) {
      cancelBtn.addEventListener('click', function () {
        confirmModal.classList.remove('show');
        document.querySelector('.modal-backdrop').classList.remove('show');
      });
    }

    // 확인 버튼 클릭 시 폼 제출 처리
    const confirmBtn = document.getElementById('confirmBtn');
    if (confirmBtn && confirmModal && boardWriteForm) {
      confirmBtn.addEventListener('click', function () {
        // 에디터 내용을 hidden input에 설정
        if (editorContent && postContentInput) {
          let content = editorContent.innerHTML;
          if (content === '내용을 입력하세요.') {
            content = '';
          }
          postContentInput.value = content;
        }

        // 제목과 내용 검증
        const title = document.getElementById('title').value;
        if (!title || title.trim() === '') {
          alert('제목을 입력해주세요.');
          confirmModal.classList.remove('show');
          document.querySelector('.modal-backdrop').classList.remove('show');
          return;
        }

        if (!postContentInput.value || postContentInput.value.trim() === '') {
          alert('내용을 입력해주세요.');
          confirmModal.classList.remove('show');
          document.querySelector('.modal-backdrop').classList.remove('show');
          return;
        }

        // 폼 제출
        boardWriteForm.submit();

        // 모달 닫기
        confirmModal.classList.remove('show');
        document.querySelector('.modal-backdrop').classList.remove('show');
      });
    }

    // 성공 모달의 확인 버튼 클릭 시 선택된 게시판으로 이동
    const okBtn = document.getElementById('okBtn');
    if (okBtn && boardSelect) {
      okBtn.addEventListener('click', function () {
        const selectedBoard = boardSelect.value;
        redirectToBoard(selectedBoard);
      });
    }

    // 취소 버튼 클릭 시 자유게시판으로 이동
    const cancelBoardBtn = document.querySelector('.btn-secondary');
    if (cancelBoardBtn) {
      cancelBoardBtn.addEventListener('click', function () {
        window.location.href = 'boardfree.action';
      });
    }

    // 게시판 ID에 따른 리다이렉트 함수
    function redirectToBoard(boardId) {
      switch (boardId) {
        case '7': // 자유게시판
          window.location.href = 'boardfree.action';
          break;
        case '8': // 장비 정보
          window.location.href = 'boardgear.action';
          break;
        case '9': // 캠핑장 정보
          window.location.href = 'boardmarket.action';
          break;
        case '10': // 고독한캠핑방
          window.location.href = 'boardimage.action';
          break;
        default:
          window.location.href = 'boardmain.action';
      }
    }
  });
</script>
</body>
</html>
