<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script>
        // 문서가 완전히 로드된 후 실행
        document.addEventListener('DOMContentLoaded', function () {
            // 모든 요소를 찾되, 존재 여부를 확인하는 안전장치 추가
            const submitBtn = document.getElementById('submitBtn');
            const confirmModal = document.getElementById('confirmModal');
            const successModal = document.getElementById('successModal');
            const boardSelect = document.getElementById('board');
            const headerTagSelect = document.getElementById('headerTag');

            // 게시판 선택에 따라 말머리 옵션 변경
            const headerTagOptions = {
                free: [
                    {value: 'question', text: '묻고답하기'},
                    {value: 'review', text: '후기'},
                    {value: 'chat', text: '잡담'}
                ],
                camping: [
                    {value: 'location', text: '장소추천'},
                    {value: 'together', text: '같이가요'},
                    {value: 'story', text: '캠핑이야기'}
                ],
                gear: [
                    {value: 'tent', text: '텐트/타프'},
                    {value: 'sleep', text: '침낭/매트'},
                    {value: 'cook', text: '취사용품'}
                ],
                market: [
                    {value: 'sell', text: '팝니다'},
                    {value: 'buy', text: '삽니다'},
                    {value: 'exchange', text: '교환합니다'}
                ]
            };

            // 게시판 변경 시 말머리 옵션 업데이트 (존재 여부 확인)
            if (boardSelect && headerTagSelect) {
                boardSelect.addEventListener('change', function () {
                    const selectedBoard = this.value;
                    const options = headerTagOptions[selectedBoard] || headerTagOptions.free;

                    // 말머리 옵션 초기화
                    headerTagSelect.innerHTML = '';

                    // 새 옵션 추가
                    options.forEach(option => {
                        const optionElement = document.createElement('option');
                        optionElement.value = option.value;
                        optionElement.textContent = option.text;
                        headerTagSelect.appendChild(optionElement);
                    });
                });
            }

            // 에디터 내용 클릭 시 기본 텍스트 제거
            const editorContent = document.querySelector('.editor-content');
            if (editorContent) {
                editorContent.addEventListener('focus', function () {
                    if (this.textContent === '내용을 입력하세요.') {
                        this.textContent = '';
                    }
                });
            }

            // 등록 버튼 클릭 시 확인 모달 표시 수정
            if (submitBtn && confirmModal) {
                submitBtn.addEventListener('click', function () {
                    console.log('등록 버튼 클릭됨');
                    confirmModal.classList.add('show');
                    document.querySelector('.modal-backdrop').classList.add('show');
                });
            }

            // 취소 버튼 클릭 시 모달 닫기 수정
            const cancelBtn = document.getElementById('cancelBtn');
            if (cancelBtn && confirmModal) {
                cancelBtn.addEventListener('click', function () {
                    console.log('취소 버튼 클릭됨');
                    confirmModal.classList.remove('show');
                    document.querySelector('.modal-backdrop').classList.remove('show');
                });
            }

            // 확인 버튼 클릭 시 성공 모달로 전환 수정
            const confirmBtn = document.getElementById('confirmBtn');
            if (confirmBtn && confirmModal && successModal) {
                confirmBtn.addEventListener('click', function () {
                    console.log('확인 버튼 클릭됨');
                    confirmModal.classList.remove('show');
                    successModal.classList.add('show');
                });
            }

            // 성공 모달의 확인 버튼 클릭 시 선택된 게시판으로 이동
            const okBtn = document.getElementById('okBtn');
            if (okBtn && boardSelect) {
                okBtn.addEventListener('click', function () {
                    const selectedBoard = boardSelect.value;
                    if (selectedBoard === 'free') {
                        window.location.href = 'boardfree.action';
                    } else if (selectedBoard === 'camping') {
                        window.location.href = 'boardimage.action';
                    } else if (selectedBoard === 'gear') {
                        window.location.href = 'boardgear.action';
                    } else if (selectedBoard === 'market') {
                        window.location.href = 'boardmarket.action';
                    }
                });
            }

            // 취소 버튼 클릭 시 자유게시판으로 이동
            const cancelBoardBtn = document.querySelector('.btn-secondary');
            if (cancelBoardBtn) {
                cancelBoardBtn.addEventListener('click', function () {
                    window.location.href = 'boardfree.action';
                });
            }
        });

    </script>

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

            <!-- 메인 콘텐츠 -->
            <div class="main-column" style="flex: 1; padding-left: 5px;">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-pen"></i> 글쓰기</h1>
                </div>

                <div class="content-box p-5">
                    <form id="boardWriteForm">
                        <div class="d-flex gap-3 mb-4">
                            <div class="flex-1">
                                <label class="input-label" for="board">게시판 선택</label>
                                <select class="input-field" id="board" name="board">
                                    <option value="free" selected>자유게시판</option>
                                    <option value="camping">고독한캠핑방</option>
                                    <option value="gear">장비 리뷰</option>
                                    <option value="market">중고장터</option>
                                </select>
                            </div>
                            <div class="flex-1">
                                <label class="input-label" for="headerTag">말머리 선택</label>
                                <select class="input-field" id="headerTag" name="headerTag">
                                    <option value="question">묻고답하기</option>
                                    <option value="review">후기</option>
                                    <option value="chat">잡담</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="input-label" for="title">제목</label>
                            <input type="text" class="input-field" id="title" name="title" placeholder="제목을 입력하세요">
                        </div>

                        <div class="mb-4">
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
                                <div class="editor-content" contenteditable="true">내용을 입력하세요.</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-5">
                            <button type="button" class="btn btn-secondary">취소</button>
                            <button type="button" class="btn btn-primary" id="submitBtn">등록</button>
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
        <h5 class="modal-title">게시글을 등록 하시겠습니까?</h5>
    </div>
    <div class="modal-footer">
        <button class="btn btn-secondary" id="cancelBtn">취소</button>
        <button class="btn btn-primary" id="confirmBtn">확인</button>
    </div>
</div>

<!-- 성공 모달 수정 -->
<div class="modal" id="successModal">
    <div class="modal-header">
        <h5 class="modal-title">게시글이 등록 되었습니다.</h5>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary" id="okBtn">확인</button>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>