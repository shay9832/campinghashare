<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>글쓰기 - 고독한 캠핑방</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="../../resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 이미지 업로드 관련 스타일 */
        .image-preview-area {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .image-upload-btn {
            width: 120px;
            height: 120px;
            background-color: #e9f2ff;
            border: 2px dashed var(--color-maple-light);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 30px;
            color: var(--color-maple);
        }

        .image-preview {
            width: 120px;
            height: 120px;
            border-radius: var(--radius-sm);
            overflow: hidden;
            border: 1px solid var(--border-medium);
            position: relative;
        }

        .image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-preview .remove-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            width: 24px;
            height: 24px;
            background-color: rgba(0, 0, 0, 0.6);
            color: var(--color-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .image-preview .remove-btn:hover {
            background-color: rgba(255, 0, 0, 0.6);
        }

        #fileInput {
            display: none;
        }

        /* 글쓰기 폼 관련 스타일 */
        .title-input {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-md);
            margin-bottom: 20px;
        }

        .upload-instruction {
            background-color: var(--bg-secondary);
            padding: var(--spacing-md);
            border-radius: var(--radius-sm);
            margin-bottom: 15px;
        }

        .upload-instruction h3 {
            margin-top: 0;
            font-size: var(--font-md);
            color: var(--color-maple);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .upload-instruction p {
            margin-bottom: 0;
            font-size: var(--font-sm);
        }

        .charCounter {
            text-align: right;
            color: var(--text-secondary);
            font-size: var(--font-xs);
            margin-top: 5px;
        }

        /* 게시판 선택 드롭다운 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: var(--font-medium);
        }

        .form-select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: var(--font-sm);
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

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-pen"></i> ${isUpdate ? '글 수정' : '글쓰기'}</h1>
                </div>

                <div class="content-box p-5">
                    <form id="boardWriteForm" method="POST" enctype="multipart/form-data" action="${isUpdate ? 'api/post/update.action' : 'boardimage-write.action'}">
                        <!-- 수정 모드일 경우 postId 필드 추가 -->
                        <c:if test="${isUpdate}">
                            <input type="hidden" name="postId" value="${post.postId}"/>
                        </c:if>

                        <input type="hidden" name="boardId" value="10"> <!-- 10: 고독한캠핑방 -->

                        <div class="form-group mb-3">
                            <label class="form-label">말머리</label>
                            <select class="form-select" id="postLabelId" name="postLabelId">
                                <c:if test="${not empty postLabels}">
                                    <c:forEach var="label" items="${postLabels}">
                                        <option value="${label.postLabelId}" ${isUpdate && post.postLabelId == label.postLabelId ? 'selected' : ''}>${label.postLabelName}</option>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty postLabels}">
                                    <option value="5">캠핑 후기</option>
                                    <option value="6">장비 후기</option>
                                    <option value="7">캠핑 음식</option>
                                    <option value="8">기타</option>
                                </c:if>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <label class="form-label">제목</label>
                            <input type="text" class="form-control" name="postTitle" id="title"
                                   value="${isUpdate ? post.postTitle : ''}" placeholder="제목을 작성하세요." required/>
                            <div class="charCounter" id="titleCounter">0/100자</div>
                        </div>

                        <div class="upload-instruction">
                            <h3><i class="fa-solid fa-image"></i> 이미지 업로드</h3>
                            <p>이미지는 최소 1개 이상 필요합니다. (최대 10개까지 업로드 가능)</p>
                            <p>지원 형식: JPG, JPEG, PNG, GIF</p>
                        </div>

                        <div class="image-upload-container mb-4">
                            <div class="image-preview-area">
                                <label for="fileInput" class="image-upload-btn">
                                    <i class="fa-solid fa-plus"></i>
                                </label>
                                <!-- 업로드된 이미지 미리보기가 여기에 추가됩니다 -->
                                <c:if test="${isUpdate && not empty post.attachments}">
                                    <c:forEach var="attachment" items="${post.attachments}">
                                        <div class="image-preview">
                                            <img src="${pageContext.request.contextPath}${attachment.attachmentPath}" alt="${attachment.attachmentName}">
                                            <div class="remove-btn" data-id="${attachment.attachmentId}">
                                                <i class="fa-solid fa-times"></i>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <input type="file" id="fileInput" name="uploadFiles" accept="image/*" multiple>
                            <div id="fileCount" class="mt-2 text-secondary">선택된 파일 없음</div>
                        </div>

                        <!-- 내용은 숨겨진 필드로 처리 (이미지 게시판은 내용 없음) -->
                        <input type="hidden" name="postContent" value="이미지 게시글">

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="location.href='boardimage.action'">취소</button>
                            <button type="button" class="btn btn-primary" id="submitBtn">${isUpdate ? '수정하기' : '등록하기'}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 모달 컴포넌트 - body 태그 닫기 전에 추가 -->
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
    document.addEventListener('DOMContentLoaded', function () {
        console.log("DOM 로드됨");

        // 기본 요소 참조
        const fileInput = document.getElementById('fileInput');
        const imagePreviewArea = document.querySelector('.image-preview-area');
        const uploadBtn = document.querySelector('.image-upload-btn');
        const fileCount = document.getElementById('fileCount');
        const title = document.getElementById('title');
        const titleCounter = document.getElementById('titleCounter');
        const submitBtn = document.getElementById('submitBtn');
        const customModalOverlay = document.getElementById('custom-modal-overlay');
        const customModal = document.getElementById('custom-modal');
        const cancelBtn = document.getElementById('cancelBtn');
        const confirmBtn = document.getElementById('confirmBtn');

        console.log("요소 참조:", {
            submitBtn: submitBtn,
            customModalOverlay: customModalOverlay,
            customModal: customModal,
            cancelBtn: cancelBtn,
            confirmBtn: confirmBtn
        });

        // 제목 글자수 카운터 초기화 및 이벤트 등록
        updateCharCounter(title, titleCounter, 100);
        title.addEventListener('input', function() {
            updateCharCounter(title, titleCounter, 100);
        });

        // 이미지 업로드 처리
        fileInput.addEventListener('change', function () {
            const files = this.files;
            let fileCountText = files.length > 0 ? `선택된 파일: ${files.length}개` : '선택된 파일 없음';
            fileCount.textContent = fileCountText;

            // 이미지 갯수 체크 (기존 이미지 + 새 이미지 <= 10)
            const existingImages = document.querySelectorAll('.image-preview').length;
            if (existingImages + files.length > 10) {
                alert('이미지는 최대 10개까지만 업로드 가능합니다.');
                this.value = '';
                fileCount.textContent = '선택된 파일 없음';
                return;
            }

            // 파일 유효성 검사
            for (let i = 0; i < files.length; i++) {
                // 파일이 이미지인지 확인
                if (!files[i].type.match('image.*')) {
                    alert('이미지 파일만 업로드 가능합니다.');
                    this.value = '';
                    fileCount.textContent = '선택된 파일 없음';
                    return;
                }
            }

            // 기존 미리보기 초기화 (플러스 버튼 제외)
            const previews = document.querySelectorAll('.image-preview');
            previews.forEach(preview => {
                if (!preview.querySelector('.remove-btn[data-id]')) {
                    preview.remove();
                }
            });

            // 새로운 미리보기 생성
            for (let i = 0; i < files.length; i++) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    // 미리보기 엘리먼트 생성
                    const preview = document.createElement('div');
                    preview.className = 'image-preview';

                    // 이미지 엘리먼트 생성
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);

                    // 삭제 버튼 생성
                    const removeBtn = document.createElement('div');
                    removeBtn.className = 'remove-btn';
                    removeBtn.innerHTML = '<i class="fa-solid fa-times"></i>';
                    removeBtn.addEventListener('click', function () {
                        preview.remove();
                        // 파일 입력 초기화 (현재 미리보기에서 제거된 파일만 초기화는 불가능)
                        fileInput.value = '';
                        fileCount.textContent = '선택된 파일 없음';
                    });
                    preview.appendChild(removeBtn);

                    // 미리보기 영역에 추가 (항상 + 버튼 뒤에 추가)
                    imagePreviewArea.insertBefore(preview, uploadBtn.nextSibling);
                };

                reader.readAsDataURL(files[i]);
            }
        });

        // 등록 버튼 클릭 시 확인 모달 표시
        submitBtn.addEventListener('click', function () {
            console.log("등록 버튼 클릭됨");

            // 폼 유효성 검사
            const title = document.getElementById('title').value.trim();
            if (!title) {
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }

            // 이미지 최소 1개 이상 체크
            const existingImages = document.querySelectorAll('.image-preview').length - 1; // 플러스 버튼 제외
            const newImages = fileInput.files ? fileInput.files.length : 0;

            if (existingImages === 0 && newImages === 0) {
                alert('최소 한 개 이상의 이미지를 업로드해주세요.');
                return;
            }

            // 확인 모달 표시
            console.log("모달 표시 시도");
            customModalOverlay.style.display = 'block';
            customModal.style.display = 'block';
            console.log("모달 표시됨:", customModalOverlay.style.display, customModal.style.display);
        });

        // 취소 버튼 클릭 시 모달 닫기
        cancelBtn.addEventListener('click', function () {
            console.log("취소 버튼 클릭됨");
            closeModal();
        });

        // 모달 배경 클릭 시 모달 닫기
        customModalOverlay.addEventListener('click', function () {
            console.log("모달 배경 클릭됨");
            closeModal();
        });

        // 확인 버튼 클릭 시 폼 제출
        confirmBtn.addEventListener('click', function () {
            console.log("확인 버튼 클릭됨");
            document.getElementById('boardWriteForm').submit();
            closeModal();
        });

        // 기존 이미지 삭제 버튼 이벤트
        const existingRemoveBtns = document.querySelectorAll('.remove-btn[data-id]');
        existingRemoveBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const attachmentId = this.getAttribute('data-id');
                const preview = this.closest('.image-preview');

                // 숨겨진 필드 추가하여 삭제할 첨부파일 ID 전송
                const hiddenField = document.createElement('input');
                hiddenField.type = 'hidden';
                hiddenField.name = 'deleteAttachments';
                hiddenField.value = attachmentId;
                document.getElementById('boardWriteForm').appendChild(hiddenField);

                // 미리보기에서 제거
                preview.remove();
            });
        });

        // 모달 닫기 함수
        function closeModal() {
            console.log("모달 닫기 함수 호출됨");
            customModalOverlay.style.display = 'none';
            customModal.style.display = 'none';
        }

        function updateCharCounter(inputElement, counterElement, maxLength) {
            const currentLength = inputElement.value.length;
            counterElement.textContent = currentLength + '/' + maxLength + '자';

            // 최대 길이 초과 시 경고 스타일 적용
            if (currentLength > maxLength) {
                counterElement.style.color = 'var(--color-error)';
                // 초과된 텍스트 잘라내기
                inputElement.value = inputElement.value.substring(0, maxLength);
                counterElement.textContent = maxLength + '/' + maxLength + '자';
            } else {
                counterElement.style.color = 'var(--text-secondary)';
            }
        }
    });
</script>
</body>
</html>