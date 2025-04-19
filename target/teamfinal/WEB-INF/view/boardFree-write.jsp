<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="checkLogin.jsp" %>
<html>
<head>
    <title>글쓰기 - 자유게시판</title>
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

        /* 모달 스타일 완전히 새로 작성 */
        #custom-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 9999;
        }

        #custom-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            z-index: 10000;
            min-width: 300px;
            text-align: center;
            display: none;
        }

        #custom-modal-header {
            margin-bottom: 20px;
        }

        #custom-modal-footer {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
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
                        <a href="boardfree.action" class="sidebar-link active">
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
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-pen"></i> ${isUpdate ? '글 수정' : '글쓰기'}</h1>
                </div>

                <div class="content-box p-5">
                    <form id="postForm" method="POST" enctype="multipart/form-data"
                          action="${isUpdate ? 'api/post/update.action' : 'boardfree-write.action'}">
                        <!-- 수정 모드일 경우 postId 필드 추가 -->
                        <c:if test="${isUpdate}">
                            <input type="hidden" name="postId" value="${post.postId}"/>
                        </c:if>

                        <div class="form-group mb-3">
                            <label class="form-label">게시판</label>
                            <select class="form-select" id="boardId" name="boardId" ${isUpdate ? 'disabled' : ''}>
                                <c:forEach var="board" items="${communityBoards}">
                                    <option value="${board.boardId}" ${(isUpdate && post.boardId == board.boardId) || (!isUpdate && board.boardId == 7) ? 'selected' : ''}>${board.boardName}</option>
                                </c:forEach>
                            </select>
                            <!-- 수정 모드에서 disabled된 필드의 값을 전송하기 위한 hidden 필드 -->
                            <c:if test="${isUpdate}">
                                <input type="hidden" name="boardId" value="${post.boardId}"/>
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

                                <textarea class="form-control" id="contentArea" name="postContent" rows="10" placeholder="내용을 작성하세요."
                                          required>${isUpdate ? post.postContent : ''}</textarea>
                            </div>
                            <div class="charCounter text-right mt-1 text-secondary">
                                0/5000byte
                            </div>
                        </div>



                        <div class="d-flex justify-content-between gap-2 mt-4">
                            <div class="form-group" style="margin-bottom: 0; flex-grow: 1;">
                                <div class="d-flex gap-2 align-items-center">
                                    <input type="file" class="form-control" id="fileInput" name="uploadFiles" multiple style="display:none;">
                                    <button type="button" class="btn btn-outline-primary" id="fileUploadBtn">
                                        <i class="fa-solid fa-paperclip"></i> 파일 선택
                                    </button>
                                    <span id="fileCount">선택된 파일 없음</span>
                                </div>
                                <!-- 파일 목록이 여기에 추가되지만, 버튼 위치에 영향을 주지 않도록 설정 -->
                                <div id="fileList" class="mt-2" style="max-height: 300px; overflow-y: auto;"></div>
                            </div>

                            <!-- 버튼 영역은 그대로 유지하되, 파일 영역과 분리 -->
                            <div class="d-flex gap-2 align-self-start">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                                <button type="button" id="submitBtn" class="btn btn-primary">${isUpdate ? '수정하기' : '등록하기'}</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 완전히 새로 만든 모달 구조 -->
<div id="custom-modal-overlay"></div>
<div id="custom-modal">
    <div id="custom-modal-header">
        <h5>${isUpdate ? '게시글을 수정 하시겠습니까?' : '게시글을 등록 하시겠습니까?'}</h5>
    </div>
    <div id="custom-modal-footer">
        <button class="btn btn-secondary" id="cancelBtn">취소</button>
        <button class="btn btn-primary" id="confirmBtn">확인</button>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script>
    // 순수 자바스크립트로 구현
    document.addEventListener('DOMContentLoaded', function () {
        console.log("DOM이 로드되었습니다.");

        // 바이트 카운터 적용
        initializeByteCounters();

        // 요소 참조
        const submitBtn = document.getElementById('submitBtn');
        const postForm = document.getElementById('postForm');
        const modalOverlay = document.getElementById('custom-modal-overlay');
        const modal = document.getElementById('custom-modal');
        const cancelBtn = document.getElementById('cancelBtn');
        const confirmBtn = document.getElementById('confirmBtn');

        // 등록하기 버튼 클릭 시 처리
        if (submitBtn) {
            submitBtn.addEventListener('click', function () {
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
            cancelBtn.addEventListener('click', function () {
                modalOverlay.style.display = 'none';
                modal.style.display = 'none';
            });
        }

        // 확인 버튼 클릭 시 폼 제출
        if (confirmBtn && postForm) {
            confirmBtn.addEventListener('click', function () {
                // 수정 모드 확인
                const isUpdateMode = document.querySelector('input[name="postId"]') !== null;

                if (isUpdateMode) {
                    // 수정 모드 AJAX 처리
                    const formData = new FormData(postForm);
                    const jsonData = {};

                    for (const [key, value] of formData.entries()) {
                        jsonData[key] = value;
                    }

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
                                location.href = 'boardfree-post.action?postId=' + data.postId;
                            } else {
                                alert('게시글 수정에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('게시글 수정 중 오류가 발생했습니다.');
                        });
                } else {
                    // 등록 모드 - 일반 폼 제출
                    postForm.submit();
                }

                // 모달 닫기
                modalOverlay.style.display = 'none';
                modal.style.display = 'none';
            });
        }

        // 게시판 변경 시 말머리 목록 가져오기
        const boardSelect = document.getElementById('boardId');
        if (boardSelect) {
            boardSelect.addEventListener('change', function () {
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
    });


    // 파일 업로드 버튼 클릭 시 파일 선택 창 열기
    const fileUploadBtn = document.getElementById('fileUploadBtn');
    const fileInput = document.getElementById('fileInput');
    const fileList = document.getElementById('fileList');
    const fileCount = document.getElementById('fileCount');

    fileUploadBtn.addEventListener('click', function() {
        fileInput.click();
    });

    // 파일 선택 시 목록 표시
    fileInput.addEventListener('change', function() {
        fileList.innerHTML = '';

        if (this.files.length > 0) {
            fileCount.textContent = '선택된 파일: ' + this.files.length + '개';

            for (let i = 0; i < this.files.length; i++) {
                const file = this.files[i];
                const fileSize = (file.size / 1024).toFixed(2) + ' KB';

                const fileItem = document.createElement('div');
                fileItem.className = 'd-flex justify-content-between align-items-center border-bottom py-2';
                fileItem.innerHTML =
                    '<div>' +
                    '<i class="fa-solid fa-file me-2"></i>' +
                    '<span>' + file.name + '</span>' +
                    '<small class="text-muted ms-2">(' + fileSize + ')</small>' +
                    '</div>';

                fileList.appendChild(fileItem);
            }
        } else {
            fileCount.textContent = '선택된 파일 없음';
        }
    });

    // 바이트 카운터 초기화 및 적용
    function initializeByteCounters() {
        console.log("바이트 카운터 초기화");
        // 메인 댓글 입력창에 바이트 카운터 적용
        const mainContentArea = document.getElementById("contentArea");
        if (mainContentArea) {
            console.log("콘텐츠 영역 발견:", mainContentArea);
            applyByteCounter(mainContentArea);
        } else {
            console.error("contentArea 요소를 찾을 수 없습니다.");
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

            // 1000 byte 초과 시 자르기
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