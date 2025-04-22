<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 9999;
        }

        .modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            min-width: 400px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 10000;
            display: none;
        }

        .modal-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }

        .modal-footer {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        /* 비활성화된 인풋 스타일 */
        .form-control:disabled, .form-select:disabled {
            background-color: #f8f9fa;
            opacity: 0.65;
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
                    <h1 class="page-title"><i class="fa-solid fa-pen"></i> ${isUpdate ? '공지사항 수정' : '공지사항 등록'}</h1>
                </div>

                <div class="content-box p-5">
                    <form id="postForm" method="POST" enctype="multipart/form-data"
                          action="${isUpdate ? 'api/notice/update.action' : 'notice-write.action'}">
                        <!-- 수정 모드일 경우 postId 필드 추가 -->
                        <c:if test="${isUpdate}">
                            <input type="hidden" name="postId" value="${post.postId}"/>
                        </c:if>

                        <div class="form-group mb-3">
                            <label class="form-label">게시판</label>
                            <!-- 게시판을 공지사항으로 고정하고 읽기 전용으로 설정 -->
                            <select class="form-select" id="boardId" name="boardId" disabled>
                                <option value="1" selected>공지사항</option>
                            </select>
                            <!-- 선택한 게시판 ID를 숨겨진 필드로 전송 -->
                            <input type="hidden" name="boardId" value="1"/>
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
                            <input type="text" class="form-control" id="title" name="postTitle"
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

                                <textarea class="form-control" id="postContent" name="postContent" rows="10"
                                          placeholder="내용을 작성하세요."
                                          required>${isUpdate ? post.postContent : ''}</textarea>
                            </div>
                            <div class="charCounter text-right mt-1 text-secondary">
                                0/5000byte
                            </div>
                        </div>

                        <div class="mt-4">
                            <!-- 기존 첨부파일 영역 (수정 모드일 때만 표시) -->
                            <c:if test="${isUpdate && not empty post.attachments}">
                                <div class="form-group mb-3">
                                    <label class="form-label">기존 첨부파일</label>
                                    <div class="existing-files">
                                        <c:forEach var="attachment" items="${post.attachments}">
                                            <div class="d-flex justify-content-between align-items-center border-bottom py-2"
                                                 id="attachment-${attachment.attachmentPostId}">
                                                <div>
                                                    <i class="fa-solid fa-file me-2"></i>
                                                    <span>${attachment.attachmentName}</span>
                                                    <small class="text-muted ms-2">(${attachment.attachmentSize / 1024}
                                                        KB)</small>
                                                </div>
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-danger delete-attachment"
                                                        data-attachment-id="${attachment.attachmentPostId}"
                                                        onclick="deleteAttachment(${attachment.attachmentPostId})">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <!-- 삭제된 첨부파일 ID를 저장할 hidden 필드 -->
                                    <input type="hidden" name="deletedAttachmentIds" id="deletedAttachmentIds" value="">
                                </div>
                            </c:if>

                            <!-- 새로운 첨부파일 영역 -->
                            <div class="form-group mb-3">
                                <label class="form-label">새 첨부파일</label>
                                <div class="d-flex gap-2 align-items-center">
                                    <input type="file" class="form-control" id="fileInput" name="uploadFiles" multiple
                                           style="display:none;">
                                    <button type="button" class="btn btn-outline-primary" id="fileUploadBtn">
                                        <i class="fa-solid fa-paperclip"></i> 파일 선택
                                    </button>
                                    <span id="fileCount">선택된 파일 없음</span>
                                </div>
                                <!-- 파일 목록이 여기에 추가됨 -->
                                <div id="fileList" class="mt-2" style="max-height: 300px; overflow-y: auto;"></div>
                            </div>

                            <!-- 버튼 영역은 아래에 별도로 배치 -->
                            <div class="d-flex justify-content-end gap-2 mt-3">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                                <button type="button" id="submitBtn"
                                        class="btn btn-primary">${isUpdate ? '수정하기' : '등록하기'}</button>
                            </div>

<%--                            <c:if test="${isUpdate}">--%>
<%--                                <div style="color:red">--%>
<%--                                    수정 모드: ${isUpdate}<br>--%>
<%--                                    첨부파일 있음: ${not empty post.attachments}<br>--%>
<%--                                    첨부파일 개수: ${post.attachments.size()}<br>--%>
<%--                                </div>--%>
<%--                            </c:if>--%>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 완전히 새로 만든 모달 구조 - 공지사항 페이지용 -->
<div id="custom-modal-overlay"
     style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); display: none; z-index: 9999;"></div>

<div id="custom-modal"
     style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); z-index: 10000; min-width: 300px; text-align: center; display: none;">
    <div id="custom-modal-header">
        <h5>${isUpdate ? '공지사항을 수정 하시겠습니까?' : '공지사항을 등록 하시겠습니까?'}</h5>
    </div>
    <div id="custom-modal-footer" style="margin-top: 20px; display: flex; justify-content: center; gap: 10px;">
        <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
        <button type="button" class="btn btn-primary" id="confirmBtn">확인</button>
    </div>
</div>

<div id="custom-success-modal"
     style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); z-index: 10000; min-width: 300px; text-align: center; display: none;">
    <div id="custom-success-header">
        <h5>${isUpdate ? '공지사항이 수정 되었습니다.' : '공지사항이 등록 되었습니다.'}</h5>
    </div>
    <div id="custom-success-footer" style="margin-top: 20px; display: flex; justify-content: center; gap: 10px;">
        <button type="button" class="btn btn-primary" id="okBtn">확인</button>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script>
    // 전역 파일 배열 선언 - 선택된 파일들을 저장할 배열
    let selectedFiles = [];

    document.addEventListener('DOMContentLoaded', function() {
        console.log("DOM이 로드되었습니다.");

        // 바이트 카운터 적용
        initializeByteCounters();

        // 요소 참조
        const submitBtn = document.getElementById('submitBtn');
        const postForm = document.getElementById('postForm');
        const modalOverlay = document.getElementById('custom-modal-overlay');
        const successModal = document.getElementById('custom-success-modal');
        const modal = document.getElementById('custom-modal');
        const cancelBtn = document.getElementById('cancelBtn');
        const okBtn = document.getElementById('okBtn');
        const confirmBtn = document.getElementById('confirmBtn');

        // 파일 선택 관련 요소 참조
        const fileUploadBtn = document.getElementById('fileUploadBtn');
        const fileInput = document.getElementById('fileInput');
        const fileList = document.getElementById('fileList');
        const fileCount = document.getElementById('fileCount');

        // 파일 업로드 버튼 클릭 시 파일 선택 창 열기
        if (fileUploadBtn) {
            fileUploadBtn.addEventListener('click', function() {
                fileInput.click();
            });
        }

        // 파일 선택 시 처리
        if (fileInput) {
            fileInput.addEventListener('change', function() {
                // 새로 선택된 파일들을 기존 배열에 추가
                if (this.files.length > 0) {
                    // FileList 객체를 배열로 변환하여 추가
                    for (let i = 0; i < this.files.length; i++) {
                        // 중복 파일 체크 (이름과 크기로 간단하게 비교)
                        const isDuplicate = selectedFiles.some(file =>
                            file.name === this.files[i].name && file.size === this.files[i].size
                        );

                        if (!isDuplicate) {
                            selectedFiles.push(this.files[i]);
                        }
                    }

                    // 파일 목록 UI 업데이트
                    updateFileListUI();
                }

                // input 값 초기화 (같은 파일을 다시 선택할 수 있도록)
                this.value = '';
            });
        }

        // 파일 목록 UI 업데이트 함수
        function updateFileListUI() {
            if (!fileList || !fileCount) return;

            // 파일 목록 초기화
            fileList.innerHTML = '';

            if (selectedFiles.length > 0) {
                fileCount.textContent = '선택된 파일: ' + selectedFiles.length + '개';

                // 각 파일에 대한 UI 요소 추가
                selectedFiles.forEach((file, index) => {
                    const fileSize = (file.size / 1024).toFixed(2) + ' KB';

                    const fileItem = document.createElement('div');
                    fileItem.className = 'd-flex justify-content-between align-items-center border-bottom py-2';
                    fileItem.innerHTML =
                        '<div>' +
                        '<i class="fa-solid fa-file me-2"></i>' +
                        '<span>' + file.name + '</span>' +
                        '<small class="text-muted ms-2">(' + fileSize + ')</small>' +
                        '</div>' +
                        '<button type="button" class="btn btn-sm btn-outline-danger remove-file" data-index="' + index + '">' +
                        '<i class="fa-solid fa-trash"></i>' +
                        '</button>';

                    fileList.appendChild(fileItem);
                });

                // 파일 삭제 버튼에 이벤트 리스너 추가
                const removeButtons = document.querySelectorAll('.remove-file');
                removeButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        const index = parseInt(this.getAttribute('data-index'));
                        // 해당 인덱스의 파일 제거
                        selectedFiles.splice(index, 1);
                        // UI 업데이트
                        updateFileListUI();
                    });
                });
            } else {
                fileCount.textContent = '선택된 파일 없음';
            }
        }

        // 등록하기 버튼 클릭 시 처리
        if (submitBtn) {
            submitBtn.addEventListener('click', function() {
                console.log("등록하기 버튼이 클릭되었습니다.");

                // 폼 검증
                const titleInput = document.querySelector('input[name="postTitle"]');
                const contentInput = document.querySelector('textarea[name="postContent"]');

                if (!titleInput.value || titleInput.value.trim() === '') {
                    alert('제목을 입력해주세요.');
                    titleInput.focus();
                    return;
                }

                if (!contentInput.value || contentInput.value.trim() === '') {
                    alert('내용을 입력해주세요.');
                    contentInput.focus();
                    return;
                }

                // 모달 표시
                modalOverlay.style.display = 'block';
                modal.style.display = 'block';
            });
        }

        // 취소 버튼 클릭 시 모달 닫기
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function() {
                modalOverlay.style.display = 'none';
                modal.style.display = 'none';
            });
        }

        // 확인 버튼 클릭 시 폼 제출 부분
        if (confirmBtn && postForm) {
            confirmBtn.addEventListener('click', function() {
                // 수정 모드 확인
                const isUpdateMode = document.querySelector('input[name="postId"]') !== null;
                console.log("확인 버튼 클릭됨, 수정 모드:", isUpdateMode);

                // 모달 닫기
                modalOverlay.style.display = 'none';
                modal.style.display = 'none';

                // FormData 객체 생성
                const formData = new FormData(postForm);

                // 기존 파일 입력 필드의 값을 제거 (초기화)
                formData.delete('uploadFiles');

                // 선택된 파일들을 폼데이터에 추가
                console.log("선택된 파일 수:", selectedFiles.length);
                selectedFiles.forEach((file, index) => {
                    console.log(`파일 ${index + 1} 추가:`, file.name);
                    formData.append('uploadFiles', file);
                });

                if (isUpdateMode) {
                    // 수정 모드 - AJAX로 전송

                    // API 경로 결정
                    let apiPath = 'api/post/update.action';
                    if (window.location.pathname.includes('notice')) {
                        apiPath = 'api/notice/update.action';
                    } else if (window.location.pathname.includes('image')) {
                        apiPath = 'api/image/update.action';
                    }

                    console.log("API 경로:", apiPath);

                    fetch(apiPath, {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // 성공 모달 표시
                                modalOverlay.style.display = 'block';
                                successModal.style.display = 'block';
                            } else {
                                alert('게시글 수정에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('게시글 수정 중 오류가 발생했습니다.');
                        });
                } else {
                    // 등록 모드 - 글쓰기

                    // 모든 경우에 AJAX로 처리하도록 변경
                    const formAction = postForm.getAttribute('action');
                    console.log("폼 액션:", formAction);

                    // AJAX 요청 보내기
                    fetch(formAction, {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => {
                            console.log("응답 상태:", response.status);
                            // 일반 폼 제출은 JSON이 아닐 수 있으므로 조건부 처리
                            const contentType = response.headers.get('content-type');
                            if (contentType && contentType.includes('application/json')) {
                                return response.json();
                            } else {
                                // JSON이 아닌 응답 (예: 리다이렉트)
                                if (response.ok) {
                                    // 성공 - 목록 페이지로 리다이렉트
                                    let redirectUrl = 'boardfree.action';
                                    if (window.location.pathname.includes('notice')) {
                                        redirectUrl = 'notice.action';
                                    } else if (window.location.pathname.includes('image')) {
                                        redirectUrl = 'boardimage.action';
                                    }
                                    window.location.href = redirectUrl;
                                    return { success: true };
                                } else {
                                    return { success: false, message: '서버 응답 오류' };
                                }
                            }
                        })
                        .then(data => {
                            if (data.success) {
                                if (data.postId) {
                                    // API 응답에 postId가 있는 경우 (상세 페이지로 이동)
                                    window.location.href = `boardfree-post.action?postId=${data.postId}`;
                                } else {
                                    // 이미 리다이렉트 처리되었을 수 있음
                                    console.log("게시글 등록 성공");
                                }
                            } else {
                                alert('게시글 등록에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('게시글 등록 중 오류가 발생했습니다.');
                        });
                }
            });
        }

        // 성공 모달의 확인 버튼 클릭 시 자유게시판 목록으로 이동
        if (okBtn) {
            okBtn.addEventListener('click', function() {
                console.log("확인 버튼(성공 모달) 클릭됨"); // 디버깅용
                if (modalOverlay) modalOverlay.style.display = 'none';
                if (successModal) successModal.style.display = 'none';

                // 이동할 페이지 결정
                let redirectUrl = 'boardfree.action';
                if (window.location.pathname.includes('notice')) {
                    redirectUrl = 'notice.action';
                } else if (window.location.pathname.includes('image')) {
                    redirectUrl = 'boardimage.action';
                }

                window.location.href = redirectUrl;
            });
        }

        // 게시판 변경 시 말머리 목록 가져오기
        const boardSelect = document.getElementById('boardId');
        if (boardSelect) {
            boardSelect.addEventListener('change', function() {
                const selectedBoardId = this.value;
                if (selectedBoardId) {
                    loadHeaderTags(selectedBoardId);
                }
            });
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
                    const headerTagSelect = document.getElementById('postLabelId');
                    if (headerTagSelect) {
                        headerTagSelect.innerHTML = '';

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
                    const headerTagSelect = document.getElementById('postLabelId');
                    if (headerTagSelect) {
                        headerTagSelect.innerHTML = '<option value="">말머리를 선택하세요</option>';
                    }
                });
        }

        // 초기 파일 목록 복원 (수정 모드인 경우)
        const existingFiles = document.querySelectorAll('.existing-files .d-flex');
        if (existingFiles.length > 0) {
            // 이미 선택된 파일이 있는 경우 (수정 모드), UI만 표시
            if (fileCount) {
                fileCount.textContent = '기존 첨부파일: ' + existingFiles.length + '개 + 새 첨부파일: ' + selectedFiles.length + '개';
            }
        }
    });

    // 전역 함수로 정의 (이벤트 핸들러 밖으로 이동)
    function deleteAttachment(attachmentPostId) {
        console.log("삭제 버튼 클릭됨 - 첨부파일 ID:", attachmentPostId);

        // 첨부파일 요소 찾기
        const attachmentElement = document.getElementById('attachment-' + attachmentPostId);

        if (attachmentElement) {
            // display:none 대신 요소를 DOM에서 완전히 제거
            attachmentElement.remove(); // 또는 IE 호환을 위해: attachmentElement.parentNode.removeChild(attachmentElement);

            // 삭제된 ID 목록 업데이트
            const deletedIdsInput = document.getElementById('deletedAttachmentIds');
            const deletedIds = deletedIdsInput.value ? deletedIdsInput.value.split(',') : [];

            if (!deletedIds.includes(attachmentPostId.toString())) {
                deletedIds.push(attachmentPostId.toString());
                deletedIdsInput.value = deletedIds.join(',');
            }

            console.log('첨부파일 ID ' + attachmentPostId + ' 삭제됨');
            console.log('현재 삭제된 첨부파일 목록:', deletedIdsInput.value);
        } else {
            console.error('첨부파일 요소를 찾을 수 없음:', 'attachment-' + attachmentPostId);

            // 혹시 ID가 아닌 data 속성으로 요소를 찾아볼 수 있음
            const alternativeElement = document.querySelector(`[data-attachment-id="${attachmentPostId}"]`);
            if (alternativeElement) {
                console.log('data-attachment-id로 요소 찾음');
                alternativeElement.remove();

                // 삭제된 ID 업데이트 (위와 동일)
                const deletedIdsInput = document.getElementById('deletedAttachmentIds');
                const deletedIds = deletedIdsInput.value ? deletedIdsInput.value.split(',') : [];

                if (!deletedIds.includes(attachmentPostId.toString())) {
                    deletedIds.push(attachmentPostId.toString());
                    deletedIdsInput.value = deletedIds.join(',');
                }

                console.log('첨부파일 ID ' + attachmentPostId + ' 삭제됨');
            }
        }
    }

    // 바이트 카운터 초기화 및 적용
    function initializeByteCounters() {
        console.log("바이트 카운터 초기화");
        // 메인 댓글 입력창에 바이트 카운터 적용
        const mainContentArea = document.getElementById("contentArea") || document.getElementById("postContent");
        if (mainContentArea) {
            console.log("콘텐츠 영역 발견:", mainContentArea);
            applyByteCounter(mainContentArea);
        } else {
            console.error("contentArea 또는 postContent 요소를 찾을 수 없습니다.");
        }
    }

    // 바이트 수 계산 함수 - 기존 코드 유지
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

    // 디바운스 함수 정의 - 연속 이벤트 처리 최적화 - 기존 코드 유지
    function debounce(func, wait) {
        let timeout;
        return function (...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // 바이트 카운터 적용 함수 - 수정
    function applyByteCounter(textarea) {
        if (!textarea) return;

        // 해당 텍스트영역 다음에 있는 .charCounter 요소 찾기
        // 수정: 부모 요소에서 .charCounter 클래스를 가진 요소 찾기
        const counterEl = textarea.closest('.editor-container').nextElementSibling;

        console.log("카운터 요소 검색 결과:", counterEl);

        if (!counterEl || !counterEl.classList.contains('charCounter')) {
            console.error("charCounter 요소를 찾을 수 없습니다.");
            return;
        }

        // 바이트 업데이트 함수
        function updateByteCount() {
            console.log("바이트 카운트 업데이트 중");
            const text = textarea.value;
            let currentBytes = calculateBytes(text);

            // 5000 byte 초과 시 자르기
            if (currentBytes > 5000) {
                // 바이너리 검색 최적화
                let start = 0;
                let end = text.length;
                let mid;
                let cutText = text;

                while (start < end) {
                    mid = Math.floor((start + end) / 2);
                    cutText = text.substring(0, mid);

                    if (calculateBytes(cutText) <= 5000) {
                        start = mid + 1;
                    } else {
                        end = mid;
                    }
                }

                // 최종 적합한 지점 찾기
                while (calculateBytes(cutText) > 5000) {
                    cutText = cutText.slice(0, -1);
                }

                // 잘린 텍스트로 업데이트
                textarea.value = cutText;
                currentBytes = calculateBytes(cutText);
            }

            // 카운터 업데이트
            counterEl.textContent = currentBytes + '/5000byte';
            console.log("카운터 업데이트:", currentBytes + '/5000byte');
        }

        // 디바운싱 적용
        const debouncedUpdate = debounce(updateByteCount, 100);

        // 이미 리스너가 있을 수 있으므로 한 번 제거했다가 다시 추가
        textarea.removeEventListener('input', debouncedUpdate);
        textarea.addEventListener('input', debouncedUpdate);

        // 초기 카운트 표시
        updateByteCount();
    }


</script>
</body>
</html>