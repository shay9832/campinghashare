<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            width: 80px;
            height: 80px;
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
            width: 80px;
            height: 80px;
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
            top: 2px;
            right: 2px;
            width: 20px;
            height: 20px;
            background-color: rgba(0, 0, 0, 0.5);
            color: var(--color-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            cursor: pointer;
        }

        #fileInput {
            display: none;
        }

        /* 모달 스타일 */
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
            z-index: 1000;
        }

        .modal {
            background-color: var(--bg-primary);
            padding: 20px;
            border-radius: var(--radius-md);
            min-width: 400px;
            text-align: center;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-lg);
        }

        .modal-footer {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
            margin-top: var(--spacing-lg);
        }

        .title-input {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-sm);
            margin-bottom: var(--spacing-lg);
            background-color: #f0f7ff;
        }

        .image-upload-container {
            margin-bottom: var(--spacing-lg);
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
                        <a href="BoardFree.jsp" class="sidebar-link">
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
            </aside>

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-pen"></i> 글쓰기</h1>
                </div>

                <div class="content-box p-5">
                    <form id="boardWriteForm">
                        <input type="text" class="title-input" id="title" name="title" placeholder="제목">

                        <div class="image-upload-container">
                            <div class="image-preview-area">
                                <label for="fileInput" class="image-upload-btn">
                                    <i class="fa-solid fa-plus"></i>
                                </label>
                                <!-- 업로드된 이미지 미리보기가 여기에 추가됩니다 -->
                            </div>
                            <input type="file" id="fileInput" accept="image/*" multiple>
                        </div>

                        <div class="d-flex justify-content-between mt-5">
                            <button type="button" class="btn btn-secondary">취소</button>
                            <button type="button" class="btn btn-primary" id="submitBtn">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 확인 모달 -->
<div class="modal-overlay" id="confirmModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div class="modal" style="background-color: white; padding: 20px; border-radius: 8px; min-width: 400px; text-align: center; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <div class="modal-header" style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">게시글을 등록 하시겠습니까?</div>
        <div class="modal-footer" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button class="btn btn-secondary" id="cancelBtn">취소</button>
            <button class="btn btn-primary" id="confirmBtn">확인</button>
        </div>
    </div>
</div>

<!-- 성공 모달 -->
<div class="modal-overlay" id="successModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div class="modal" style="background-color: white; padding: 20px; border-radius: 8px; min-width: 400px; text-align: center; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <div class="modal-header" style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">게시글이 등록 되었습니다.</div>
        <div class="modal-footer" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button class="btn btn-primary" id="okBtn">확인</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const fileInput = document.getElementById('fileInput');
        const imagePreviewArea = document.querySelector('.image-preview-area');
        const uploadBtn = document.querySelector('.image-upload-btn');
        const submitBtn = document.getElementById('submitBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const confirmBtn = document.getElementById('confirmBtn');
        const okBtn = document.getElementById('okBtn');
        const confirmModal = document.getElementById('confirmModal');
        const successModal = document.getElementById('successModal');

        console.log("DOM 요소 확인:", {
            submitBtn: submitBtn,
            cancelBtn: cancelBtn,
            confirmBtn: confirmBtn,
            okBtn: okBtn,
            confirmModal: confirmModal,
            successModal: successModal
        });

        // 이미지 업로드 처리
        fileInput.addEventListener('change', function() {
            const files = this.files;

            for (let i = 0; i < files.length; i++) {
                // 파일이 이미지인지 확인
                if (!files[i].type.match('image.*')) {
                    alert('이미지 파일만 업로드 가능합니다.');
                    continue;
                }

                const reader = new FileReader();

                reader.onload = function(e) {
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
                    removeBtn.addEventListener('click', function() {
                        preview.remove();
                    });
                    preview.appendChild(removeBtn);

                    // 미리보기 영역에 추가
                    imagePreviewArea.insertBefore(preview, uploadBtn.nextSibling);
                };

                reader.readAsDataURL(files[i]);
            }
        });

        // 등록 버튼 클릭 시 확인 모달 표시
        submitBtn.addEventListener('click', function() {
            console.log("등록 버튼 클릭됨");
            const title = document.getElementById('title').value.trim();
            if (!title) {
                alert('제목을 입력해주세요.');
                return;
            }

            const previews = document.querySelectorAll('.image-preview');
            if (previews.length === 0) {
                alert('최소 한 개 이상의 이미지를 업로드해주세요.');
                return;
            }

            // 모달 표시
            if (confirmModal) {
                confirmModal.style.display = 'flex';
                console.log("확인 모달 표시됨");
            } else {
                console.error("확인 모달 요소를 찾을 수 없음");
            }
        });

        // 취소 버튼 클릭 시 모달 닫기
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function() {
                console.log("취소 버튼 클릭됨");
                confirmModal.style.display = 'none';
            });
        } else {
            console.error("취소 버튼 요소를 찾을 수 없음");
        }

        // 확인 버튼 클릭 시 성공 모달로 전환
        if (confirmBtn) {
            confirmBtn.addEventListener('click', function() {
                console.log("확인 버튼 클릭됨");
                confirmModal.style.display = 'none';
                successModal.style.display = 'flex';
            });
        } else {
            console.error("확인 버튼 요소를 찾을 수 없음");
        }

        // 성공 모달의 확인 버튼 클릭 시 고독한 캠핑방으로 이동
        if (okBtn) {
            okBtn.addEventListener('click', function() {
                console.log("성공 모달 확인 버튼 클릭됨");
                window.location.href = 'boardimage.action';
            });
        } else {
            console.error("성공 모달 확인 버튼 요소를 찾을 수 없음");
        }

        // 취소 버튼 클릭 시 고독한 캠핑방으로 이동
        document.querySelector('.btn-secondary').addEventListener('click', function() {
            window.location.href = 'boardimage.action';
        });
    });
</script>
</body>
</html>