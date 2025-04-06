<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String matching_done = request.getParameter("matching_done");
    System.out.println(matching_done);
%>
<html>
<head>
    <title>캠핑하쉐어 - 스토렌 매칭 신청</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/matching_request.css">
    <style>
        /* 기존 CSS로 해결되지 않는 최소한의 스타일만 추가 */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .top-section {
            display: flex;
            flex-direction: column; /* 세로 배치로 변경 */
            gap: 20px;
            margin-bottom: 30px;
        }

        .top-content {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .left-column {
            flex: 1;
            min-width: 300px;
        }

        .right-column {
            flex: 1;
            min-width: 300px;
        }

        /* 나머지 기존 스타일은 그대로 유지 */
        .matching-confirm-modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: var(--z-modal);
        }

        .matching-confirm-content {
            background-color: var(--bg-primary);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            text-align: center;
            width: 90%;
            max-width: 400px;
            box-shadow: var(--shadow-lg);
        }

        .matching-confirm-content p {
            font-size: var(--font-md);
            margin-bottom: var(--spacing-lg);
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
        }

        .confirm-btn {
            padding: var(--spacing-sm) var(--spacing-md);
            background-color: var(--color-maple);
            color: var(--color-white);
            border: none;
            border-radius: var(--radius-sm);
            cursor: pointer;
            font-weight: var(--font-semibold);
        }

        .cancel-btn {
            padding: var(--spacing-sm) var(--spacing-md);
            background-color: var(--bg-secondary);
            color: var(--text-primary);
            border: none;
            border-radius: var(--radius-sm);
            cursor: pointer;
        }

        .single-button {
            justify-content: center;
        }

        /* 이미지 관련 스타일 */
        .main-image-container {
            width: 100%;
            position: relative;
            margin-bottom: 15px;
        }

        .main-image {
            width: 100%;
            height: 400px;
            background-color: #f5f5f5;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-md);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .image-nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(255, 255, 255, 0.7);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 2;
            transition: all var(--transition-normal);
        }

        .prev-btn {
            left: var(--spacing-sm);
        }

        .next-btn {
            right: var(--spacing-sm);
        }

        .image-nav-btn:hover {
            background-color: white;
            color: var(--color-maple);
        }

        .image-counter {
            position: absolute;
            bottom: var(--spacing-sm);
            right: var(--spacing-sm);
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: var(--font-xxs);
        }

        .thumbnail-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .thumbnail {
            width: 70px;
            height: 70px;
            background-color: #f5f5f5;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: border-color var(--transition-normal);
        }

        .thumbnail:hover {
            border-color: var(--color-maple);
        }

        /* 반응형 조정 */
        @media (max-width: 768px) {
            .top-content {
                flex-direction: column;
            }

            .main-image {
                height: 300px;
            }
        }
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // 매칭 신청 버튼 눌렀을 때 모달 보이기
            $(".match-btn").on('click', function () {
                $("#matching-confirm-modal").show().css("display", "flex");
                $("body").css("overflow", "hidden"); // 페이지 스크롤 방지
            });

            // 모달1 중 취소 버튼 눌렀을 때 모달 닫기
            $("#cancel").on("click", function() {
                $("#matching-confirm-modal").hide(); // 모달 숨기기
                $("body").css("overflow", "auto"); // 페이지 스크롤 복원
            });

            // 모달1 중 확인 버튼 눌렀을 때 모달 보이기
            $("#confirm").on('click', function () {
                $("#matching-confirm-modal").hide();
                $("#matching-confirm-modal2").show().css("display", "flex");
                $("body").css("overflow", "hidden"); // 페이지 스크롤 방지
            });

            // 모달2 중 확인 버튼 눌렀을 때 리다이렉트(matching_done = true 를 GET 방식으로 넘기기)
            $("#confirm2").on("click", function() {
                $(location).attr("href", "16-storen-matching-request.jsp?matching_done=true");
            });
        });
    </script>
</head>

<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>

<!-- 매칭 신청 여부 모달 -->
<div id="matching-confirm-modal" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청하시겠습니까?</p>
        <div class="modal-buttons">
            <button id="confirm" class="confirm-btn">확인</button>
            <button id="cancel" class="cancel-btn">취소</button>
        </div>
    </div>
</div>

<!-- 매칭 신청 확인 모달 -->
<div id="matching-confirm-modal2" class="matching-confirm-modal">
    <div class="matching-confirm-content">
        <p>매칭 신청되었습니다.</p>
        <div class="modal-buttons single-button">
            <button id="confirm2" class="confirm-btn">확인</button>
        </div>
    </div>
</div>

<div class="main-container">
    <!-- 상단 섹션: 이미지 + 장비/렌탈 정보 세로 배치 -->
    <div class="top-section">
        <!-- 이미지와 장비 정보를 가로로 배치 -->
        <div class="top-content">
            <!-- 왼쪽 컬럼: 이미지 영역과 작성자 정보 -->
            <div class="left-column card p-4">
                <!-- 이미지 영역 -->
                <div class="main-image-container">
                    <div class="main-image">
                        <button class="image-nav-btn prev-btn">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <span class="image-counter">1/5</span>
                        <button class="image-nav-btn next-btn">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                <div class="thumbnail-container d-flex">
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                    <div class="thumbnail"></div>
                </div>

                <!-- 작성자 정보 -->
                <div class="user-info d-flex align-items-center mb-2">
                    <span class="font-medium">가나초콜릿</span>
                    <img src="rank-icon5.png" class="rank-icon ml-2">
                    <span class="text-secondary text-xs">(신뢰도 00% / 신고 0회 접수)</span>
                    <button class="report-btn btn-sm btn-text ml-auto">신고</button>
                </div>
                <div class="text-tertiary text-xs">2025.06.01 등록</div>
            </div>

            <!-- 오른쪽 컬럼: 장비 정보 및 렌탈 신청 -->
            <div class="right-column card p-4">
                <!-- 장비 정보 -->
                <table class="info-table w-100">
                    <tr>
                        <th class="text-secondary">장비명</th>
                        <td>스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">카테고리</th>
                        <td>텐트/쉘터</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">브랜드</th>
                        <td>스노우피크</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">신품 가격</th>
                        <td>
                            <span class="price font-bold text-lg">3,050,000원</span>
                            <span class="discount text-coral text-xs">(평균 대비 22%↑)</span>
                            <br>
                            <span class="avg-price text-secondary text-xs">평균 신품 가격 2,500,000원</span>
                            <span class="help-icon tooltip-trigger">?</span>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-secondary">장비 등급</th>
                        <td>
                            <span class="grade-badge grade-C">C</span>
                            <span class="grade-link text-maple text-xs">(상세 내용 보기)</span>
                        </td>
                    </tr>
                </table>

                <hr class="my-4">

                <!-- 렌탈 신청 폼 -->
                <table class="info-table w-100">
                    <tr>
                        <th class="text-secondary">렌탈 가능 기간</th>
                        <td>2025.06.01 - 2025.09.30</td>
                    </tr>
                    <tr>
                        <th class="text-secondary">렌탈 가격</th>
                        <td>
                            <span class="price rental-price-value font-bold">25,000원/일</span>
                            <span class="discount text-coral text-xs">(평균 대비 25%↑)</span>
                            <br>
                            <span class="avg-price text-secondary text-xs">평균 렌탈 가격 20,000원/일</span>
                            <span class="help-icon tooltip-trigger">?</span>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-secondary">렌탈 기간</th>
                        <td>
                            <div class="position-relative">
                                <input type="text" class="date-input form-control" placeholder="클릭하여 날짜 선택" readonly>
                                <i class="fas fa-calendar-alt calendar-icon position-absolute" style="right: 10px; top: 50%; transform: translateY(-50%)"></i>
                            </div>
                            <div class="rental-days text-secondary text-xs mt-1">(0일)</div>
                        </td>
                    </tr>
                </table>

                <div class="total-price d-flex justify-content-between align-items-center bg-beige p-3 mt-3 mb-3 rounded">
                    <span class="font-medium">총 렌탈 금액</span>
                    <span class="price total-price-value font-bold text-lg">0원</span>
                </div>

                <%
                    if ("true".equals(matching_done)) {
                %>
                <button class="match-btn btn btn-block disabled" disabled="disabled">매칭 중</button>
                <%
                } else {
                %>
                <button class="match-btn btn btn-primary btn-block">매칭 신청</button>
                <%
                    }
                %>
            </div>
        </div>

        <!-- 거래 주의사항 -->
        <div class="card p-4 mb-4">
            <h3 class="text-lg font-bold mb-3">거래 시 주의사항</h3>
            <p class="text-secondary">
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            </p>
        </div>
        <!-- 댓글 영역 -->
        <div class="card p-4">
            <h3 class="text-lg font-bold mb-3">거래 문의</h3>
            <div class="comment-list">
                <!-- 댓글 1 -->
                <div class="comment border-bottom py-3">
                    <div class="comment-container d-flex">
                        <div class="comment-left mr-4">
                            <div class="comment-user d-flex align-items-center">
                                <span class="font-medium">스키틀즈</span>
                                <img src="rank-icon3.png" class="rank-icon ml-2">
                            </div>
                            <div class="comment-date text-tertiary text-xxs">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right flex-1">
                            <div class="comment-header d-flex justify-content-between mb-2">
                                <div></div>
                                <button class="report-btn btn-sm btn-text">신고</button>
                            </div>
                            <div class="comment-text mb-2">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions d-flex justify-content-end">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form d-none p-3 mt-2 bg-secondary rounded">
                        <input type="text" class="reply-input form-control" placeholder="댓글을 작성하세요">
                        <button class="file-btn btn-sm btn-secondary">파일첨부</button>
                        <button class="reply-btn btn-sm btn-primary">등록</button>
                    </div>
                </div>

                <!-- 댓글 2 -->
                <div class="comment border-bottom py-3">
                    <div class="comment-container d-flex">
                        <div class="comment-left mr-4">
                            <div class="comment-user d-flex align-items-center">
                                <span class="font-medium">가나초콜릿</span>
                                <img src="rank-icon5.png" class="rank-icon ml-2">
                            </div>
                            <div class="comment-date text-tertiary text-xxs">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right flex-1">
                            <div class="comment-header d-flex justify-content-between mb-2">
                                <div></div>
                                <button class="report-btn btn-sm btn-text">신고</button>
                            </div>
                            <div class="comment-text mb-2">
                                OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                            </div>
                            <div class="comment-actions d-flex justify-content-end">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form d-none p-3 mt-2 bg-secondary rounded">
                        <input type="text" class="reply-input form-control" placeholder="댓글을 작성하세요">
                        <button class="file-btn btn-sm btn-secondary">파일첨부</button>
                        <button class="reply-btn btn-sm btn-primary">등록</button>
                    </div>
                </div>

                <!-- 댓글 3 (가나초콜릿 댓글 + 말랑카우 답글) -->
                <div class="comment border-bottom py-3">
                    <div class="comment-container d-flex">
                        <div class="comment-left mr-4">
                            <div class="comment-user d-flex align-items-center">
                                <span class="font-medium">가나초콜릿</span>
                                <img src="rank-icon5.png" class="rank-icon ml-2">
                            </div>
                            <div class="comment-date text-tertiary text-xxs">2025.00.00. 00:00</div>
                        </div>
                        <div class="comment-right flex-1">
                            <div class="comment-header d-flex justify-content-between mb-2">
                                <div></div>
                                <button class="report-btn btn-sm btn-text">신고</button>
                            </div>
                            <div class="comment-text mb-2">OOOOOOOOOOOOOOOOOOOOOOOO</div>
                            <div class="comment-actions d-flex justify-content-end">
                                <button class="reply-btn-text">대댓글 작성</button>
                            </div>
                        </div>
                    </div>
                    <!-- 말랑카우 답글 -->
                    <div class="reply-section pl-5 ml-4 mt-2 border-left">
                        <div class="comment-container d-flex">
                            <div class="comment-left mr-4">
                                <div class="comment-user d-flex align-items-center">
                                    <span class="font-medium">말랑카우</span>
                                    <img src="rank-icon1.png" class="rank-icon ml-2">
                                </div>
                                <div class="comment-date text-tertiary text-xxs">2025.00.00. 00:00</div>
                            </div>
                            <div class="comment-right flex-1">
                                <div class="comment-header d-flex justify-content-between mb-2">
                                    <div></div>
                                    <div>
                                        <button class="report-btn btn-sm btn-text">수정</button>
                                        <button class="report-btn btn-sm btn-text">삭제</button>
                                    </div>
                                </div>
                                <div class="comment-text mb-2">OOOOOOOOOOOOOOOOOOOOOOOO</div>
                            </div>
                        </div>
                    </div>
                    <div class="reply-form d-none p-3 mt-2 bg-secondary rounded">
                        <input type="text" class="reply-input form-control" placeholder="댓글을 작성하세요">
                        <button class="file-btn btn-sm btn-secondary">파일첨부</button>
                        <button class="reply-btn btn-sm btn-primary">등록</button>
                    </div>
                </div>

                <!-- 댓글 작성 폼 -->
                <div class="comment-form d-flex mt-4">
                    <div class="comment-form-left mr-4">
                        <div class="comment-user d-flex align-items-center">
                            <span class="font-medium">말랑카우</span>
                            <img src="rank-icon1.png" class="rank-icon ml-2">
                        </div>
                    </div>
                    <div class="comment-form-right flex-1">
                        <div class="comment-input-container d-flex">
                            <input type="text" class="comment-input form-control" placeholder="댓글을 작성하세요">
                            <button class="file-btn btn-sm btn-secondary ml-2">파일첨부</button>
                            <button class="comment-btn btn-sm btn-primary ml-2">등록</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- .main-container -->

<jsp:include page="footer.jsp"></jsp:include>

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
                    form.classList.add('d-none');
                });

                // 클릭한 댓글의 답글 폼만 표시
                const comment = this.closest('.comment');
                const replyForm = comment.querySelector('.reply-form');
                if (replyForm) {
                    replyForm.style.display = 'flex';
                    replyForm.classList.remove('d-none');
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
                    replyForm.classList.add('d-none');

                    // 테스트용 알림
                    alert('답글이 등록되었습니다.');
                }
            });
        });
    });
</script>
</body>
</html>