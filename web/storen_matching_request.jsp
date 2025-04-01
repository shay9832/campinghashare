<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>캠핑하쉐어 - 렌탈 매칭 신청</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 0 0 30px 0;
            box-shadow: none;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            padding: 20px;
        }
        .product-images {
            width: 50%;
            padding-right: 20px;
        }
        .main-image-container {
            position: relative;
            width: 100%;
            margin-bottom: 10px;
        }
        .main-image {
            width: 100%;
            height: 300px;
            border: 1px solid #e1e1e1;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        .main-image::before, .main-image::after {
            content: "";
            position: absolute;
            background-color: #e1e1e1;
            width: 140%;
            height: 2px;
            left: -20%;
            top: 50%;
        }
        .main-image::before {
            transform: translateY(-50%) rotate(45deg);
        }
        .main-image::after {
            transform: translateY(-50%) rotate(-45deg);
        }
        .image-counter {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background-color: rgba(0,0,0,0.5);
            color: white;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 12px;
        }
        .image-nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            color: #777;
            border: none;
            font-size: 24px;
            cursor: pointer;
            z-index: 3;
        }
        .prev-btn {
            left: 10px;
        }
        .next-btn {
            right: 10px;
        }
        .thumbnail-container {
            display: flex;
            justify-content: flex-start;
            gap: 10px;
            overflow-x: auto;
        }
        .thumbnail {
            width: 70px;
            height: 70px;
            border: 1px solid #e1e1e1;
            flex-shrink: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            cursor: pointer;
            overflow: hidden;
        }
        .thumbnail::before, .thumbnail::after {
            content: "";
            position: absolute;
            background-color: #e1e1e1;
            width: 140%;
            height: 2px;
            left: -20%;
            top: 50%;
        }
        .thumbnail::before {
            transform: translateY(-50%) rotate(45deg);
        }
        .thumbnail::after {
            transform: translateY(-50%) rotate(-45deg);
        }
        .product-info {
            width: 50%;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }
        .info-table th {
            width: 120px; /* 더 넓게 변경 */
            text-align: left;
            padding: 10px 0;
            color: #555;
            font-weight: normal;
            white-space: nowrap; /* 줄바꿈 방지 */
        }
        .info-table td {
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-table tr:last-child td {
            border-bottom: none;
        }
        .price {
            font-weight: bold;
            font-size: 18px;
        }
        .original-price {
            text-decoration: line-through;
            color: #999;
            font-size: 14px;
            margin-left: 10px;
        }
        .discount {
            color: #FF6B6B;
            font-size: 14px;
            margin-left: 5px;
        }
        .avg-price {
            color: #777;
            font-size: 14px;
        }
        .help-icon {
            display: inline-block;
            width: 16px;
            height: 16px;
            background-color: #e1e1e1;
            border-radius: 50%;
            text-align: center;
            line-height: 16px;
            color: white;
            font-size: 10px;
            cursor: pointer;
            margin-left: 5px;
        }
        .grade-link {
            color: #1E88E5;
            text-decoration: underline;
            cursor: pointer;
        }
        .rental-form {
            margin-top: 20px;
            border-top: 1px solid #e1e1e1;
            padding-top: 20px;
        }
        .date-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            margin-bottom: 5px;
            cursor: pointer;
            font-size: 15px;
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
            position: relative;
        }
        .calendar-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
            pointer-events: none;
        }
        .rental-days {
            text-align: right;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        .total-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .match-btn {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .user-info img {
            margin-right: 5px;
            max-width: 24px;
            display: inline-block;
        }
        .report-btn {
            background-color: #f0f0f0;
            border: none;
            border-radius: 3px;
            padding: 3px 8px;
            font-size: 12px;
            color: #777;
            cursor: pointer;
            margin-left: 10px;
        }
        .separator {
            margin: 30px 0;
            border: none;
            border-top: 1px solid #e1e1e1;
        }
        .description {
            padding: 0 20px;
        }
        .description h3 {
            margin-bottom: 15px;
        }
        .comment-section {
            margin: 0 20px 50px 20px;
        }
        .comment-list {
            margin-bottom: 20px;
        }
        .comment {
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 10px;
        }
        .comment-container {
            display: flex;
            width: 100%;
        }
        .comment-left {
            width: 120px;
            padding-right: 15px;
            display: flex;
            flex-direction: column;
        }
        .comment-user {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }
        .comment-user span {
            font-weight: bold;
            margin-right: 5px;
        }
        .comment-user img {
            max-width: 24px;
            display: inline-block;
        }
        .comment-date {
            font-size: 12px;
            color: #888;
        }
        .comment-right {
            flex: 1;
        }
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        .comment-text {
            margin: 6px 0;
            line-height: 1.4;
        }
        .comment-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 8px;
        }
        .reply-btn-text {
            color: #4CAF50;
            font-size: 13px;
            cursor: pointer;
            padding: 3px 8px;
            background: none;
            border: none;
        }
        .reply-section {
            margin-left: 120px;
            padding: 10px 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            margin-top: 8px;
        }
        .reply-form {
            display: none;
            margin-top: 10px;
            margin-left: 120px;
            flex-wrap: wrap;
        }
        .reply-input {
            flex-grow: 1;
            padding: 8px 10px;
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            margin-right: 5px;
            font-size: 13px;
            min-width: 200px;
        }
        .reply-btn {
            padding: 0 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            height: 36px;
        }
        .comment-form {
            display: flex;
            align-items: flex-start;
            background-color: #f9f9f9;
            padding: 12px;
            border-radius: 5px;
            margin-top: 15px;
        }
        .comment-form-left {
            width: 120px;
            padding-right: 15px;
        }
        .comment-user {
            display: flex;
            align-items: center;
        }
        .comment-form-right {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .comment-input-container {
            display: flex;
            margin-bottom: 8px;
            flex-wrap: wrap;
        }
        .comment-input {
            flex-grow: 1;
            padding: 8px 10px;
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            margin-right: 5px;
            font-size: 13px;
            min-width: 150px;
            margin-bottom: 5px;
        }
        .comment-btn {
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            height: 36px;
        }
        .file-btn {
            padding: 8px 12px;
            background-color: #f0f0f0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 13px;
            height: 36px;
        }
        /* 캘린더 커스텀 스타일 */
        .flatpickr-calendar {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            width: 300px;
        }
        .flatpickr-months {
            display: flex;
            background-color: #4CAF50;
            padding: 8px 0;
        }
        .flatpickr-prev-month,
        .flatpickr-next-month {
            fill: white;
            padding: 5px;
            height: 34px;
        }
        .flatpickr-current-month {
            color: white;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }
        .flatpickr-current-month .cur-month {
            font-size: 16px;
        }
        .flatpickr-current-month select {
            font-size: 15px;
        }
        .flatpickr-day {
            line-height: 36px;
            height: 36px;
            font-size: 14px;
        }
        .flatpickr-day.selected,
        .flatpickr-day.startRange,
        .flatpickr-day.endRange {
            background: #4CAF50;
            border-color: #4CAF50;
        }
        .flatpickr-day.inRange {
            background: rgba(76, 175, 80, 0.3);
            border-color: rgba(76, 175, 80, 0.3);
            color: #333;
        }
        .flatpickr-day.today {
            border-color: #FFC107;
        }
        .flatpickr-weekday {
            color: #555;
            font-size: 13px;
            font-weight: bold;
        }

        /* 반응형 조정 */
        @media (max-width: 768px) {
            .product-images, .product-info {
                width: 100%;
                padding-right: 0;
            }
            .comment-left {
                width: 100px;
            }
            .reply-section, .reply-form {
                margin-left: 100px;
            }
        }
    </style>
</head>

<body>
    <header>
        <jsp:include page="Header.jsp"></jsp:include>
    </header>

    <div class="container">
        <div class="product-container">
            <div class="product-images">
                <div class="main-image-container">
                    <button class="image-nav-btn prev-btn"><i class="fas fa-chevron-left"></i></button>
                    <div class="main-image">
                        <span class="image-counter">1/5</span>
                    </div>
                    <button class="image-nav-btn next-btn"><i class="fas fa-chevron-right"></i></button>
                </div>
                <div class="thumbnail-container">
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                </div>
                <div class="user-info">
                    <span>가나초콜릿</span>
                    <img src="rank-icon5.png" class="rank-icon">
                    <span>(신뢰도 00% / 신고 0회 접수)</span>
                    <button class="report-btn">신고</button>
                </div>
                <div>2025.06.01 등록</div>
            </div>
            <div class="product-info">
                <table class="info-table">
                    <tr>
                        <th>장비명</th>
                        <td>스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653</td>
                    </tr>
                    <tr>
                        <th>카테고리</th>
                        <td>텐트/쉘터</td>
                    </tr>
                    <tr>
                        <th>브랜드</th>
                        <td>스노우피크</td>
                    </tr>
                    <tr>
                        <th>신품 가격</th>
                        <td>
                            <span class="price">3,050,000원</span>
                            <span class="discount">(평균 대비 22%↑)</span>
                            <br>
                            <span class="avg-price">평균 신품 가격 2,500,000원</span>
                            <span class="help-icon">?</span>
                        </td>
                    </tr>
                    <tr>
                        <th>장비 등급</th>
                        <td>C <span class="grade-link">(상세 내용 보기)</span></td>
                    </tr>
                </table>

                <div class="rental-form">
                    <table class="info-table">
                        <tr>
                            <th>렌탈 가능 기간</th>
                            <td>2025.06.01 - 2025.09.30</td>
                        </tr>
                        <tr>
                            <th>렌탈 가격</th>
                            <td>
                                <span class="price rental-price-value">25,000원/일</span>
                                <span class="discount">(평균 대비 25%↑)</span>
                                <br>
                                <span class="avg-price">평균 렌탈 가격 20,000원/일</span>
                                <span class="help-icon">?</span>
                            </td>
                        </tr>
                        <tr>
                            <th>렌탈 기간</th>
                            <td>
                                <div style="position: relative;">
                                    <input type="text" class="date-input" placeholder="클릭하여 날짜 선택" readonly>
                                    <i class="fas fa-calendar-alt calendar-icon"></i>
                                </div>
                                <div class="rental-days">(0일)</div>
                            </td>
                        </tr>
                    </table>

                    <div class="total-price">
                        <span>총 렌탈 금액</span>
                        <span class="price total-price-value">0원</span>
                    </div>

                    <button class="match-btn">매칭 신청</button>
                </div>
            </div>
        </div>

        <hr class="separator">

        <div class="description">
            <h3>거래 시 주의사항</h3>
            <p>
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>

        <hr class="separator">

        <div class="comment-section">
            <div class="comment-list">
                <!-- 댓글 1 -->
                <div class="comment">
                    <div class="comment-container">
                        <div class="comment-left">
                            <div class="comment-user">
                                <span>스키틀즈</span>
                                <img src="rank-icon3.png" class="rank-icon">
                            </div>
                            <div class="comment-date">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right">
                            <div class="comment-header">
                                <div></div>
                                <button class="report-btn">신고</button>
                            </div>
                            <div class="comment-text">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form">
                        <input type="text" class="reply-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="reply-btn">등록</button>
                    </div>
                </div>

                <!-- 댓글 2 -->
                <div class="comment">
                    <div class="comment-container">
                        <div class="comment-left">
                            <div class="comment-user">
                                <span>가나초콜릿</span>
                                <img src="rank-icon5.png" class="rank-icon">
                            </div>
                            <div class="comment-date">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right">
                            <div class="comment-header">
                                <div></div>
                                <button class="report-btn">신고</button>
                            </div>
                            <div class="comment-text">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form">
                        <input type="text" class="reply-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="reply-btn">등록</button>
                    </div>
                </div>

                <!-- 댓글 3 -->
                <div class="comment">
                    <div class="comment-container">
                        <div class="comment-left">
                            <div class="comment-user">
                                <span>스키틀즈</span>
                                <img src="rank-icon3.png" class="rank-icon">
                            </div>
                            <div class="comment-date">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right">
                            <div class="comment-header">
                                <div></div>
                                <button class="report-btn">신고</button>
                            </div>
                            <div class="comment-text">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form">
                        <input type="text" class="reply-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="reply-btn">등록</button>
                    </div>
                </div>

                <!-- 댓글 4 (가나초콜릿 댓글 + 말랑카우 답글) -->
                <div class="comment">
                    <div class="comment-container">
                        <div class="comment-left">
                            <div class="comment-user">
                                <span>가나초콜릿</span>
                                <img src="rank-icon5.png" class="rank-icon">
                            </div>
                            <div class="comment-date">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right">
                            <div class="comment-header">
                                <div></div>
                                <button class="report-btn">신고</button>
                            </div>
                            <div class="comment-text">
                                OOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <!-- 말랑카우 답글 -->
                    <div class="reply-section">
                        <div class="comment-container">
                            <div class="comment-left">
                                <div class="comment-user">
                                    <span>말랑카우</span>
                                    <img src="rank-icon1.png" class="rank-icon">
                                </div>
                                <div class="comment-date">2025.00.00. 00:00</div>
                            </div>
                            <div class="comment-right">
                                <div class="comment-header">
                                    <div></div>
                                    <div>
                                        <button class="report-btn">수정</button>
                                        <button class="report-btn">삭제</button>
                                    </div>
                                </div>
                                <div class="comment-text">
                                    OOOOOOOOOOOOOOOOOOOOOOOO
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form">
                        <input type="text" class="reply-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="reply-btn">등록</button>
                    </div>
                </div>

                <!-- 댓글 5 -->
                <div class="comment">
                    <div class="comment-container">
                        <div class="comment-left">
                            <div class="comment-user">
                                <span>청포도사탕</span>
                                <img src="rank-icon2.png" class="rank-icon">
                            </div>
                            <div class="comment-date">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right">
                            <div class="comment-header">
                                <div></div>
                                <button class="report-btn">신고</button>
                            </div>
                            <div class="comment-text">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form">
                        <input type="text" class="reply-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="reply-btn">등록</button>
                    </div>
                </div>
            </div>

            <!-- 댓글 작성 폼 -->
            <div class="comment-form">
                <div class="comment-form-left">
                    <div class="comment-user">
                        <span>말랑카우</span>
                        <img src="rank-icon1.png" class="rank-icon">
                    </div>
                </div>
                <div class="comment-form-right">
                    <div class="comment-input-container">
                        <input type="text" class="comment-input" placeholder="댓글을 작성하세요">
                        <button class="file-btn">파일첨부</button>
                        <button class="comment-btn">등록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <jsp:include page="Footer.jsp"></jsp:include>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 일일 렌탈 가격 추출
            function getDailyRentalPrice() {
                const priceText = document.querySelector('.rental-price-value').textContent;
                return parseInt(priceText.replace(/[^0-9]/g, ''));
            }

            // 날짜 간격 계산 (일수)
            function calculateDays(startDate, endDate) {
                const diffTime = Math.abs(endDate - startDate);
                return Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // 시작일과 종료일 포함
            }

            // 총 렌탈 금액 계산 및 표시
            function calculateTotalPrice(days) {
                const dailyPrice = getDailyRentalPrice();
                const totalPrice = dailyPrice * days;

                // 금액 포맷팅 (천 단위 콤마)
                const formattedPrice = totalPrice.toLocaleString('ko-KR');

                document.querySelector('.rental-days').textContent = `(${days}일)`;
                document.querySelector('.total-price-value').textContent = `${formattedPrice}원`;
            }

            // 캘린더 초기화
            const flatpickrCalendar = flatpickr(".date-input", {
                mode: "range",
                dateFormat: "Y.m.d",
                minDate: "2025.06.01",
                maxDate: "2025.09.30",
                showMonths: 1,
                disableMobile: true,
                static: true,
                position: "below center",
                monthSelectorType: "static",
                locale: {
                    rangeSeparator: ' - ',
                    weekdays: {
                        shorthand: ['일', '월', '화', '수', '목', '금', '토'],
                        longhand: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일']
                    },
                    months: {
                        shorthand: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                        longhand: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
                    }
                },
                onChange: function(selectedDates, dateStr) {
                    if (selectedDates.length === 2) {
                        const startDate = selectedDates[0];
                        const endDate = selectedDates[1];
                        const days = calculateDays(startDate, endDate);
                        calculateTotalPrice(days);
                    } else {
                        document.querySelector('.rental-days').textContent = "(0일)";
                        document.querySelector('.total-price-value').textContent = "0원";
                    }
                }
            });

            // 토글 스위치 기능
            document.querySelector('#toggle').addEventListener('change', function() {
                if(this.checked) {
                    // 거래 선택 시 동작
                    console.log('거래 모드 활성화');
                    // 여기에 거래 관련 컨텐츠를 표시하는 코드 추가
                } else {
                    // 커뮤니티 선택 시 동작
                    console.log('커뮤니티 모드 활성화');
                    // 여기에 커뮤니티 관련 컨텐츠를 표시하는 코드 추가
                }
            });

            // 카테고리 버튼 클릭 이벤트
            document.querySelector('.toggle-btn').addEventListener('click', function() {
                // 카테고리 버튼 클릭 시 동작
                console.log('카테고리 메뉴 표시');
                // 여기에 카테고리 메뉴를 표시하는 코드 추가
            });

            // 이미지 내비게이션
            let currentImageIndex = 0;
            const totalImages = 5;

            document.querySelector('.prev-btn').addEventListener('click', function() {
                currentImageIndex = (currentImageIndex - 1 + totalImages) % totalImages;
                updateImageCounter();
            });

            document.querySelector('.next-btn').addEventListener('click', function() {
                currentImageIndex = (currentImageIndex + 1) % totalImages;
                updateImageCounter();
            });

            function updateImageCounter() {
                document.querySelector('.image-counter').textContent = `${currentImageIndex + 1}/${totalImages}`;
            }

            // 썸네일 클릭시 메인 이미지 변경
            document.querySelectorAll('.thumbnail').forEach((thumbnail, index) => {
                thumbnail.addEventListener('click', function() {
                    currentImageIndex = index;
                    updateImageCounter();
                });
            });

            // Grade details popup
            document.querySelector('.grade-link').addEventListener('click', function() {
                // Show grade details popup
                alert('장비 등급 상세내용이 표시됩니다');
            });

            // 댓글 클릭시 답글 폼 표시
            document.querySelectorAll('.comment-text, .reply-btn-text').forEach(element => {
                element.addEventListener('click', function() {
                    // 현재 표시된 모든 답글 폼 닫기
                    document.querySelectorAll('.reply-form').forEach(form => {
                        form.style.display = 'none';
                    });

                    // 클릭한 댓글의 답글 폼만 표시
                    const comment = this.closest('.comment');
                    const replyForm = comment.querySelector('.reply-form');
                    if (replyForm) {
                        replyForm.style.display = 'flex';
                    }
                });
            });

            // 답글 등록 버튼 이벤트
            document.querySelectorAll('.reply-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const replyForm = this.closest('.reply-form');
                    if (replyForm) {
                        // 답글 등록 처리 코드 (서버로 전송 등)

                        // 폼 숨기기
                        replyForm.style.display = 'none';

                        // 테스트용 알림
                        alert('답글이 등록되었습니다.');
                    }
                });
            });
        });
    </script>
</body>
</html>
