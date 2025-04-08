<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 캠핑일지 작성</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

    <style>
        /* 캠핑일지 작성 페이지 스타일 */
        .diary-form-container {
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

        /* 날짜 선택기 스타일 */
        .date-range-container {
            position: relative;
        }

        .date-input {
            padding-right: 40px;
        }

        .calendar-icon {
            position: absolute;
            right: var(--spacing-sm);
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-tertiary);
            pointer-events: none;
        }

        /* 날씨 아이콘 스타일 */
        .weather-icons {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }

        .weather-icon {
            display: flex;
            flex-direction: column;
            align-items: center;
            cursor: pointer;
            padding: var(--spacing-xs);
            border-radius: var(--radius-sm);
            transition: all var(--transition-normal);
        }

        .weather-icon:hover {
            background-color: var(--color-beige);
        }

        .weather-icon.active {
            background-color: var(--color-beige);
            color: var(--color-maple);
        }

        .weather-icon i {
            font-size: 24px;
            margin-bottom: var(--spacing-xxs);
        }

        .weather-icon span {
            font-size: var(--font-xxs);
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

        /* 지도 스타일 */
        .map-container {
            margin-bottom: var(--spacing-md);
        }

        .map-search {
            display: flex;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-sm);
        }

        .map-search-input {
            flex: 1;
        }

        .map-search-button {
            background-color: var(--color-maple);
            color: var(--color-white);
            border: none;
            border-radius: var(--radius-sm);
            padding: 0 var(--spacing-md);
            cursor: pointer;
            transition: background-color var(--transition-normal);
        }

        .map-search-button:hover {
            background-color: var(--btn-primary-hover-bg);
        }

        .map-view {
            height: 300px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            background-color: var(--color-gray-100);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-tertiary);
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
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="#" class="sidebar-link">회원 등급</a></li>
                    <li><a href="#" class="sidebar-link">신뢰도</a></li>
                    <li><a href="#" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title active">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title"><i class="fa-solid fa-book-open"></i> 캠핑일지 작성</h2>
        </div>

        <div class="content-box p-5">
            <form id="diaryForm">
                <!-- 제목 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="title">제목 <span style="color: var(--color-coral);">*</span></label>
                    <input type="text" class="input-field" id="title" name="title" placeholder="제목을 입력하세요" maxlength="90">
                    <div class="char-counter"><span id="titleCounter">0</span>/90byte</div>
                </div>

                <!-- 날짜 영역 -->
                <div class="mb-4">
                    <label class="input-label" for="date">날짜 <span style="color: var(--color-coral);">*</span></label>
                    <div class="date-range-container">
                        <input type="text" class="input-field date-input" id="date" name="date" placeholder="캠핑 날짜를 선택하세요">
                        <div class="calendar-icon">
                            <i class="fa-regular fa-calendar"></i>
                        </div>
                    </div>
                </div>

                <!-- 날씨 영역 - 필수값 표시 제거 -->
                <div class="mb-4">
                    <label class="input-label">날씨</label>
                    <div class="weather-icons">
                        <div class="weather-icon" data-weather="맑음">
                            <i class="fa-solid fa-sun" style="color: #FF9500;"></i>
                            <span>맑음</span>
                        </div>
                        <div class="weather-icon" data-weather="구름조금">
                            <i class="fa-solid fa-cloud-sun" style="color: #87CEEB;"></i>
                            <span>구름조금</span>
                        </div>
                        <div class="weather-icon" data-weather="구름많음">
                            <i class="fa-solid fa-cloud" style="color: #A9A9A9;"></i>
                            <span>구름많음</span>
                        </div>
                        <div class="weather-icon" data-weather="흐림">
                            <i class="fa-solid fa-smog" style="color: #778899;"></i>
                            <span>흐림</span>
                        </div>
                        <div class="weather-icon" data-weather="비">
                            <i class="fa-solid fa-cloud-rain" style="color: #4682B4;"></i>
                            <span>비</span>
                        </div>
                        <div class="weather-icon" data-weather="눈">
                            <i class="fa-regular fa-snowflake" style="color: #89CFF0;"></i>
                            <span>눈</span>
                        </div>
                        <div class="weather-icon" data-weather="천둥번개">
                            <i class="fa-solid fa-bolt" style="color: #FFD700;"></i>
                            <span>천둥번개</span>
                        </div>
                        <div class="weather-icon" data-weather="안개">
                            <i class="fa-solid fa-water" style="color: #B0C4DE;"></i>
                            <span>안개</span>
                        </div>
                    </div>
                    <input type="hidden" id="weather" name="weather">
                </div>

                <!-- 내용 영역 - boardFree-write.jsp와 일치, 필수값 표시 제거 -->
                <div class="mb-4">
                    <label class="input-label" for="content">내용</label>
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
                        <div class="editor-content" id="content" contenteditable="true" data-placeholder="내용을 입력해주세요"></div>
                    </div>
                    <div class="char-counter"><span id="contentCounter">0</span>/3000byte</div>
                </div>

                <!-- 위치 정보 영역 (카카오맵 API 연결 예정) -->
                <div class="mb-4">
                    <label class="input-label">위치</label>
                    <div class="map-container">
                        <div class="map-search">
                            <input type="text" class="input-field map-search-input" id="map-search" placeholder="주소나 장소를 검색하세요">
                            <button type="button" class="map-search-button">검색</button>
                        </div>
                        <div class="map-view" id="map">
                            카카오맵 API가 연결될 예정입니다
                        </div>
                        <input type="hidden" id="latitude" name="latitude">
                        <input type="hidden" id="longitude" name="longitude">
                    </div>
                </div>

                <!-- 버튼 영역 - boardFree-write.jsp와 맞춤 -->
                <div class="d-flex justify-content-end gap-2 mt-5">
                    <button type="button" class="btn btn-secondary">취소</button>
                    <button type="button" class="btn btn-primary" id="submitBtn">등록</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 확인 모달 -->
<div class="modal-overlay" id="confirmModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div class="modal" style="background-color: white; padding: 20px; border-radius: 8px; min-width: 400px; text-align: center; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <div class="modal-header" style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">캠핑일지를 등록 하시겠습니까?</div>
        <div class="modal-footer" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button class="btn btn-secondary" id="cancelBtn">취소</button>
            <button class="btn btn-primary" id="confirmBtn">확인</button>
        </div>
    </div>
</div>

<!-- 성공 모달 -->
<div class="modal-overlay" id="successModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div class="modal" style="background-color: white; padding: 20px; border-radius: 8px; min-width: 400px; text-align: center; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <div class="modal-header" style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">캠핑일지가 등록 되었습니다.</div>
        <div class="modal-footer" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button class="btn btn-primary" id="okBtn">확인</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<!-- 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

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

        // 날짜 선택기 초기화
        flatpickr("#date", {
            locale: "ko",
            mode: "range",
            dateFormat: "Y-m-d",
            disableMobile: "true"
        });

        // 날씨 선택 기능
        $('.weather-icon').click(function() {
            $('.weather-icon').removeClass('active');
            $(this).addClass('active');
            $('#weather').val($(this).data('weather'));
        });

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

        // 제목 바이트 수 카운터 - 고급 버전
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

        // 내용 바이트 수 카운터 - 고급 버전
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

        // 지도 검색 버튼 클릭 이벤트
        $('.map-search-button').click(function() {
            const keyword = $('#map-search').val();
            if (!keyword) {
                alert('검색어를 입력해주세요.');
                return;
            }

            // 카카오맵 API 검색 기능 추가 예정
            alert('카카오맵 API 연동 예정입니다.');
        });

        // 등록 버튼 클릭 시 확인 모달 표시
        $('#submitBtn').click(function() {
            // 유효성 검사 - 제목과 날짜만 필수값으로 변경
            if (!$('#title').val()) {
                alert('제목을 입력해주세요.');
                $('#title').focus();
                return;
            }

            if (!$('#date').val()) {
                alert('날짜를 선택해주세요.');
                $('#date').focus();
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

        // 성공 모달의 확인 버튼 클릭 시 일지 목록 페이지로 이동
        $('#okBtn').click(function() {
            location.href = 'myPage-diary.jsp';
        });

        // 취소 버튼 클릭 시 이전 페이지로 이동
        $('.btn-secondary').click(function() {
            location.href = 'myPage-diary.jsp';
        });

        // 초기 로드 시 카운터 업데이트
        updateTitleByteCount();
        updateContentByteCount();
    });
</script>
</body>
</html>