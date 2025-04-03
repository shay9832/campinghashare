<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String matching_done = request.getParameter("matching_done");
System.out.println(matching_done);
%>
<html>
<head>
<title>캠핑하쉐어 - 스토렌 매칭 신청</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="css/matching_request.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
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
                $(location).attr("href", "storen_matching_request.jsp?matching_done=true");
            });
        });



    </script>
</head>

<body>
	<header>
		<jsp:include page="Header.jsp"></jsp:include>
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
		<div class="product-container">
			<div class="product-images">
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
					<!-- .main-image -->
				</div>
				<!-- .main-image-container -->
				<div class="thumbnail-container">
					<div class="thumbnail"></div>
					<div class="thumbnail"></div>
					<div class="thumbnail"></div>
					<div class="thumbnail"></div>
					<div class="thumbnail"></div>
				</div>
				<!-- .thumbnail-container -->
				<div class="user-info">
					<span>가나초콜릿</span> <img src="rank-icon5.png" class="rank-icon">
					<span>(신뢰도 00% / 신고 0회 접수)</span>
					<button class="report-btn">신고</button>
				</div>
				<!-- .user-info -->
				<div>2025.06.01 등록</div>
			</div>
			<!-- .product-images -->
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
						<td><span class="price">3,050,000원</span> <span
							class="discount">(평균 대비 22%↑)</span> <br> <span
							class="avg-price">평균 신품 가격 2,500,000원</span> <span
							class="help-icon">?</span></td>
					</tr>
					<tr>
						<th>장비 등급</th>
						<td>C <span class="grade-link">(상세 내용 보기)</span></td>
					</tr>
				</table>
				<!-- .info-table -->

				<div class="rental-form">
					<table class="info-table">
						<tr>
							<th>렌탈 가능 기간</th>
							<td>2025.06.01 - 2025.09.30</td>
						</tr>
						<tr>
							<th>렌탈 가격</th>
							<td><span class="price rental-price-value">25,000원/일</span>
								<span class="discount">(평균 대비 25%↑)</span> <br> <span
								class="avg-price">평균 렌탈 가격 20,000원/일</span> <span
								class="help-icon">?</span></td>
						</tr>
						<tr>
							<th>렌탈 기간</th>
							<td>
								<div style="position: relative;">
									<input type="text" class="date-input" placeholder="클릭하여 날짜 선택"
										readonly> <i class="fas fa-calendar-alt calendar-icon"></i>
								</div>
								<div class="rental-days">(0일)</div>
							</td>
						</tr>
					</table>

					<div class="total-price">
						<span>총 렌탈 금액</span> <span class="price total-price-value">0원</span>
					</div>
					<%
						if ("true".equals(matching_done)) {
					%>
					<button class="match-btn" style="background-color: #e0e0e0"
						disabled="disabled">매칭 중</button>
					<%
						} else {
					%>
					<button class="match-btn">매칭 신청</button>
					<%
						}
					%>
				</div>
				<!-- .rental-form -->
			</div>
			<!-- .product-info -->
		</div>
		<!-- .product-container -->

		<hr class="separator">

		<div class="description">
			<h3>거래 시 주의사항</h3>
			<p>OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
				OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
				OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
				OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
				OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
				OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO</p>
		</div>
		<!-- .description -->

		<hr class="separator">

		<div class="comment-section" style="display: none;">
			<div class="comment-list">
				<!-- 댓글 1 -->
				<div class="comment">
					<div class="comment-container">
						<div class="comment-left">
							<div class="comment-user">
								<span>스키틀즈</span> <img src="rank-icon3.png" class="rank-icon">
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
								OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO</div>
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
								<span>가나초콜릿</span> <img src="rank-icon5.png" class="rank-icon">
							</div>
							<div class="comment-date">2025.00.00. 00:00</div>
						</div>
						<div class="comment-right">
							<div class="comment-header">
								<div></div>
								<button class="report-btn">신고</button>
							</div>
							<div class="comment-text">
								OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO</div>
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
								<span>스키틀즈</span> <img src="rank-icon3.png" class="rank-icon">
							</div>
							<div class="comment-date">2025.00.00. 00:00</div>
						</div>
						<div class="comment-right">
							<div class="comment-header">
								<div></div>
								<button class="report-btn">신고</button>
							</div>
							<div class="comment-text">
								OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO</div>
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
								<span>가나초콜릿</span> <img src="rank-icon5.png" class="rank-icon">
							</div>
							<div class="comment-date">2025.00.00. 00:00</div>
						</div>
						<div class="comment-right">
							<div class="comment-header">
								<div></div>
								<button class="report-btn">신고</button>
							</div>
							<div class="comment-text">OOOOOOOOOOOOOOOOOOOOOOOO</div>
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
									<span>말랑카우</span> <img src="rank-icon1.png" class="rank-icon">
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
								<div class="comment-text">OOOOOOOOOOOOOOOOOOOOOOOO</div>
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
								<span>청포도사탕</span> <img src="rank-icon2.png" class="rank-icon">
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
								OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO</div>
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
						<span>말랑카우</span> <img src="rank-icon1.png" class="rank-icon">
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
		<!-- .comment-section -->
	</div>
	<!-- .main-container -->


	<jsp:include page="Footer.jsp"></jsp:include>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
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
<!-- end body -->




</html>
