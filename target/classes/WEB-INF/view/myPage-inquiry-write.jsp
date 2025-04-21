<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 1:1 문의 작성</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

    <style>
        /* 1:1 문의 작성 페이지 스타일 */
        .inquiry-form-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            padding: var(--spacing-lg);
        }

        .input-label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: var(--font-semibold);
            font-size: var(--font-xs);
            color: var(--text-primary);
        }

        .input-field {
            width: 100%;
            padding: var(--spacing-sm);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            background-color: var(--bg-primary);
            margin-bottom: var(--spacing-md);
        }

        .input-field:focus {
            border-color: var(--color-maple);
            outline: none;
            box-shadow: 0 0 0 2px rgba(44, 95, 45, 0.2);
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

        /* 에디터 스타일 */
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

        /* 글자수 카운트 */
        .char-counter {
            text-align: right;
            font-size: var(--font-xxs);
            color: var(--text-tertiary);
            margin-top: var(--spacing-xxs);
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
            z-index: var(--z-modal);
        }

        .modal {
            background-color: var(--bg-primary);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            min-width: 400px;
            text-align: center;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-lg);
            color: var(--text-primary);
        }

        .modal-footer {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
            margin-top: var(--spacing-lg);
        }

        .btn-secondary:hover {
            color: #000 !important;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title active">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title"><i class="fa-solid fa-headset"></i> 1:1 문의 작성</h2>
        </div>

        <div class="content-box p-5">
            <form id="inquiryForm">
                <!-- 말머리 선택 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="inquiryType">문의 유형 <span style="color: var(--color-coral);">*</span></label>
                    <select class="input-field" id="inquiryType" name="inquiryType" required>
                        <option value="transaction">거래</option>
                        <option value="community">커뮤니티</option>
                        <option value="account">회원정보</option>
                        <option value="request">신규 등록 요청</option>
                    </select>
                </div>

                <!-- 제목 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="title">제목 <span style="color: var(--color-coral);">*</span></label>
                    <input type="text" class="input-field" id="title" name="title" placeholder="제목을 입력하세요" maxlength="90" required>
                    <div class="char-counter"><span id="titleCounter">0</span>/90byte</div>
                </div>

                <!-- 내용 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="content">내용 <span style="color: var(--color-coral);">*</span></label>
                    <div class="editor-container">
                        <div class="editor-toolbar">
                            <div class="toolbar-group">
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-arrow-left"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-arrow-right"></i></button>
                            </div>
                            <div class="toolbar-group">
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-bold"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-italic"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-underline"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-strikethrough"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-xmark"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-subscript"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-superscript"></i></button>
                            </div>
                            <div class="toolbar-group">
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-align-left"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-align-center"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-align-right"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-align-justify"></i></button>
                            </div>
                            <div class="toolbar-group">
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-list"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-list-ol"></i></button>
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
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-link"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-image"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-table"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-face-smile"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-headphones"></i></button>
                                <button type="button" class="toolbar-btn"><i class="fa-solid fa-quote-left"></i></button>
                            </div>
                        </div>
                        <div class="editor-content" id="content" contenteditable="true" data-placeholder="문의 내용을 입력해주세요"></div>
                    </div>
                    <div class="char-counter"><span id="contentCounter">0</span>/3000byte</div>
                </div>

                <!-- 파일 첨부 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="attachment">파일 첨부</label>
                    <input type="file" class="form-control" id="attachment" name="attachment" multiple>
                    <div class="form-text text-muted">최대 5개 파일, 파일당 5MB 이하</div>
                </div>

                <!-- 버튼 영역 -->
                <div class="d-flex justify-content-end gap-2 mt-5">
                    <button type="button" class="btn btn-secondary">취소</button>
                    <button type="button" class="btn btn-primary" id="submitBtn">등록</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 확인 모달 -->
<div class="modal-overlay" id="confirmModal">
    <div class="modal">
        <div class="modal-header">1:1 문의를 등록 하시겠습니까?</div>
        <div class="modal-footer">
            <button class="btn btn-secondary" id="cancelBtn">취소</button>
            <button class="btn btn-primary" id="confirmBtn">확인</button>
        </div>
    </div>
</div>

<!-- 성공 모달 -->
<div class="modal-overlay" id="successModal">
    <div class="modal">
        <div class="modal-header">1:1 문의가 등록 되었습니다.</div>
        <div class="modal-footer">
            <button class="btn btn-primary" id="okBtn">확인</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<!-- 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // CSS로 placeholder 스타일 적용
        document.head.insertAdjacentHTML('beforeend', `
            <style>
                [contenteditable=true]:empty:before {
                    content: attr(data-placeholder);
                    color: #aaa;
                    font-style: italic;
                }
            </style>
        `);

        // 바이트 수 계산 함수
        function calculateBytes(str) {
            if (!str) return 0;

            let byteCount = 0;
            for (let i = 0; i < str.length; i++) {
                const charCode = str.codePointAt(i);

                // '서로 게이트(Surrogate Pair, 특수문자 인코딩 UTF-16)' 쌍 처리
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

        // 디바운스 함수 정의 (성능 최적화 : 연속적 이벤트 처리 제한)
        function debounce(func, wait) {
            let timeout;
            return function(...args) {
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(this, args), wait);
            };
        }

        // 제목 바이트 수 카운터
        function updateTitleByteCount() {
            const text = $('#title').val();
            let currentBytes = calculateBytes(text);

            // 90 byte 초과 시 자르기
            if (currentBytes > 90) {
                // 바이너리 검색 방식으로 최적화(가장 효율적으로 90바이트 이내로 잘라내기)
                let start = 0;
                let end = text.length;
                let mid;
                let cutText = text;

                while (start < end) {
                    mid = Math.floor((start + end) / 2);
                    cutText = text.substring(0, mid);

                    if (calculateBytes(cutText) <= 90) {
                        start = mid + 1;
                    } else {
                        end = mid;
                    }
                }

                // 최종 적합한 지점 찾기(90 바이트 이내 최대 길이 찾기)
                while (calculateBytes(cutText) > 90) {
                    cutText = cutText.slice(0, -1);
                }

                // 잘린 텍스트로 내용 업데이트
                $('#title').val(cutText);

                // 업데이트 된 바이트 수 계산
                currentBytes = calculateBytes(cutText);
            }

            // byte 수 표시
            $('#titleCounter').text(currentBytes);
        }

        // 내용 바이트 수 카운터
        function updateContentByteCount() {
            const text = $('#content').text();
            let currentBytes = calculateBytes(text);

            // 3000 byte 초과 시 자르기
            if (currentBytes > 3000) {
                // 바이너리 검색 방식으로 최적화(가장 효율적으로 3000바이트 이내로 잘라내기)
                let start = 0;
                let end = text.length;
                let mid;
                let cutText = text;

                while (start < end) {
                    mid = Math.floor((start + end) / 2);
                    cutText = text.substring(0, mid);

                    if (calculateBytes(cutText) <= 3000) {
                        start = mid + 1;
                    } else {
                        end = mid;
                    }
                }

                // 최종 적합한 지점 찾기(3000 바이트 이내 최대 길이 찾기)
                while (calculateBytes(cutText) > 3000) {
                    cutText = cutText.slice(0, -1);
                }

                // 잘린 텍스트로 내용 업데이트
                $('#content').text(cutText);

                // 업데이트 된 바이트 수 계산
                currentBytes = calculateBytes(cutText);
            }

            // byte 수 표시
            $('#contentCounter').text(currentBytes);
        }

        // 디바운싱 적용 (입력이 빠르게 연속될 때 성능 최적화)
        const debouncedTitleUpdate = debounce(updateTitleByteCount, 100);
        const debouncedContentUpdate = debounce(updateContentByteCount, 100);

        // 제목 이벤트 리스너
        $('#title').on('input', debouncedTitleUpdate);

        // 내용 이벤트 리스너
        $('#content').on('input', function() {
            // placeholder 처리
            if ($(this).text().trim() === '') {
                $(this).empty(); // 내용이 비어있으면 완전히 비워서 placeholder가 보이게 함
            }
            debouncedContentUpdate();
        });

        // 내용 영역 포커스 처리
        $('#content').on('focus', function() {
            if ($(this).text().trim() === '') {
                $(this).empty();
            }
        });

        // 내용 영역 포커스 아웃 처리
        $('#content').on('blur', function() {
            if ($(this).text().trim() === '') {
                $(this).empty(); // 완전히 비워서 placeholder가 보이게 함
            }
        });

        // 등록 버튼 클릭 시 확인 모달 표시
        $('#submitBtn').click(function() {
            // 유효성 검사
            if (!$('#inquiryType').val()) {
                alert('문의 유형을 선택해주세요.');
                $('#inquiryType').focus();
                return;
            }

            if (!$('#title').val()) {
                alert('제목을 입력해주세요.');
                $('#title').focus();
                return;
            }

            if (!$('#content').text().trim()) {
                alert('내용을 입력해주세요.');
                $('#content').focus();
                return;
            }

            // 확인 모달 표시
            $('#confirmModal').css('display', 'flex');
        });

        // 취소 버튼 클릭 시 모달 닫기
        $('#cancelBtn').click(function() {
            $('#confirmModal').css('display', 'none');
        });

        // 확인 버튼 클릭 시 성공 모달로 전환
        $('#confirmBtn').click(function() {
            $('#confirmModal').css('display', 'none');
            $('#successModal').css('display', 'flex');
        });

        // 성공 모달의 확인 버튼 클릭 시 1:1 문의 목록 페이지로 이동
        $('#okBtn').click(function() {
            location.href = 'myPage-inquiry.jsp';
        });

        // 취소 버튼 클릭 시 이전 페이지로 이동
        $('.btn-secondary').click(function() {
            location.href = 'myPage-inquiry.jsp';
        });

        // 초기 로드 시 카운터 업데이트
        updateTitleByteCount();
        updateContentByteCount();
    });
</script>
</body>
</html>