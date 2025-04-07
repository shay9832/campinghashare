<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 스타일시트 파일 불러오기 -->
    <link rel="stylesheet" href="css/Equip.css">
</head>
<body>
<!-- 헤더 영역 포함 -->
<jsp:include page="Header.jsp"></jsp:include>
<div class="page-wrapper">
    <div class="container">
        <!-- 페이지 제목 -->
        <h1>스토렌 신청</h1>

        <!-- 장비 사진 업로드 영역 -->
        <div class="form-row">
            <div class="form-label">장비 사진</div>
            <div class="form-input">
                <div class="image-upload">
                    <!-- 이미지 미리보기 영역 (2개) -->
                    <div class="image-placeholder"></div>
                    <div class="image-placeholder"></div>
                    <!-- 파일 업로드 버튼 -->
                    <button class="upload-btn"><i class="fas fa-plus"></i> 첨부파일</button>
                </div>
            </div>
        </div>

        <!-- 대분류 카테고리 선택 -->
        <div class="form-row">
            <div class="form-label">카테고리(대)</div>
            <div class="form-input">
                <select>
                    <option>텐트/쉘터</option>
                </select>
            </div>
        </div>

        <!-- 중분류 카테고리 선택 -->
        <div class="form-row">
            <div class="form-label">카테고리(중)</div>
            <div class="form-input">
                <select>
                    <option>텐트</option>
                </select>
            </div>
        </div>

        <!-- 브랜드 선택 -->
        <div class="form-row">
            <div class="form-label">브랜드</div>
            <div class="form-input">
                <select>
                    <option>스노우피크</option>
                </select>
            </div>
        </div>

        <!-- 장비명 입력 필드 -->
        <div class="form-row">
            <div class="form-label">장비명</div>
            <div class="form-input">
                <input type="text" value="스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653">
            </div>
        </div>

        <!-- 신품 가격 정보 표시 영역 -->
        <div class="form-row">
            <div class="form-label">신품 가격</div>
            <div class="form-input">
                <!-- 가격 정보 (원가 및 할인율) -->
                <div class="price-row">
                    <div class="price-original">3,050,000 원</div>
                    <div class="price-discount">(평균 대비 22% ▲)</div>
                </div>
                <!-- 평균 신품 가격 정보 -->
                <div class="price-average">
                    평균 신품 가격
                    <span>2,500,000원</span>
                    <div class="price-question">?</div>
                </div>
            </div>
        </div>

        <!-- 장비 정보 수정 안내 -->
        <div class="size-note">※ 상단 정보 '내 장비 목록' 메뉴에서 수정 가능</div>

        <!-- 구분선 -->
        <div class="divider"></div>

        <!-- 장비 사이즈 선택 영역 -->
        <div class="form-row">
            <div class="form-label">장비 사이즈</div>
            <div class="form-input">
                <!-- 사이즈 선택 버튼 그룹 (각 버튼에 가격 데이터 속성 포함) -->
                <div class="size-options">
                    <div class="size-option" data-price="1000">XS</div>
                    <div class="size-option" data-price="3000">S</div>
                    <div class="size-option active" data-price="4000">M</div>
                    <div class="size-option" data-price="6000">L</div>
                    <div class="size-option" data-price="9000">XL</div>
                </div>
                <!-- 현재 선택된 사이즈의 일일 보관 비용 표시 -->
                <div style="background-color: #94bd97; border-radius: 4px; width: 20%">보관 비용 <span id="daily-price">3,000원/일</span></div>

                <!-- 사이즈 가이드 설명 -->
                <div class="size-guide">
                    <div class="size-guide-title">＜사이즈 기준 가로+세로+높이 합(cm)＞</div>
                    <div class="size-guide-item">- XS(50cm) : 1,000원 (예시) 미니 버너</div>
                    <div class="size-guide-item">- S(100cm) : 2,000원 (예시) 테이블</div>
                    <div class="size-guide-item">- M(150cm) : 3,000원 (예시) 2~3인용 텐트</div>
                    <div class="size-guide-item">- L(200cm) : 4,000원 (예시) 4~6인용 돔 텐트</div>
                    <div class="size-guide-item">- XL(250cm) : 5,000원 (예시) 거실형 텐트, 대형 타프</div>
                </div>
            </div>
        </div>

        <!-- 보관 기간 및 비용 계산 영역 -->
        <div class="rental-info">
            <!-- 보관 기간 선택 (개월 수) -->
            <div class="rental-days">
                보관 기간
                <div style="display: inline-flex; align-items: center; border: 1px solid #ddd; border-radius: 4px; margin: 0 10px;">
                    <!-- 감소 버튼 -->
                    <button style="width: 30px; height: 30px; background-color: #f0f0f0; border: none; cursor: pointer; font-size: 16px; display: flex; align-items: center; justify-content: center; border-right: 1px solid #ddd; border-radius: 4px 0 0 4px;" class="decrease">-</button>
                    <!-- 현재 선택된 개월 수 -->
                    <span style="min-width: 40px; text-align: center; font-weight: bold; padding: 0 10px;" class="counter-value">3</span>
                    <!-- 증가 버튼 -->
                    <button style="width: 30px; height: 30px; background-color: #f0f0f0; border: none; cursor: pointer; font-size: 16px; display: flex; align-items: center; justify-content: center; border-left: 1px solid #ddd; border-radius: 0 4px 4px 0;" class="increase">+</button>
                </div>
                개월
            </div>
            <!-- 일일 보관 비용 표시 -->
            <div class="rental-price">X <span>3,000원/일</span></div>
        </div>

        <!-- 자바스크립트: 가격 계산 및 UI 동작 처리 -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // DOM 요소 참조 가져오기
                const decreaseBtn = document.querySelector('.decrease');
                const increaseBtn = document.querySelector('.increase');
                const counterValue = document.querySelector('.counter-value');
                const sizeOptions = document.querySelectorAll('.size-option');
                const dailyPriceDisplay = document.getElementById('daily-price');
                const pricePerDay = document.getElementById('price-per-day');

                // 초기 값 설정
                let count = 3; // 기본 보관 개월 수
                let dailyPrice = 3000; // 기본 일일 보관 비용 (M 사이즈)

                // 사이즈 옵션 클릭 이벤트 처리
                sizeOptions.forEach(option => {
                    option.addEventListener('click', function() {
                        // 모든 옵션에서 active 클래스 제거
                        sizeOptions.forEach(opt => opt.classList.remove('active'));

                        // 클릭한 옵션에 active 클래스 추가
                        this.classList.add('active');

                        // 선택한 사이즈의 가격 정보 가져오기
                        dailyPrice = parseInt(this.getAttribute('data-price'));

                        // 화면에 일일 가격 표시 업데이트
                        dailyPriceDisplay.textContent = dailyPrice.toLocaleString() + '원/일';
                        pricePerDay.textContent = dailyPrice.toLocaleString() + '원/일';

                        // 총 보관 비용 다시 계산
                        updateTotalPrice();
                    });
                });

                // 증가 버튼 클릭 이벤트 처리
                increaseBtn.addEventListener('click', function() {
                    count++;
                    counterValue.textContent = count;
                    updateTotalPrice();
                });

                // 감소 버튼 클릭 이벤트 처리
                decreaseBtn.addEventListener('click', function() {
                    if (count > 1) { // 최소 1개월 이상 선택 가능
                        count--;
                        counterValue.textContent = count;
                        updateTotalPrice();
                    }
                });

                // 총 보관 비용 업데이트 함수
                function updateTotalPrice() {
                    const days = count * 30; // 개월 수를 일 수로 변환 (대략적으로 30일/월)
                    const totalPrice = dailyPrice * days;

                    // 총 보관 비용 업데이트
                    document.querySelector('.rental-total div:last-child').textContent =
                        totalPrice.toLocaleString() + '원';
                }

                // 페이지 로드 시 초기 총 보관 비용 계산
                updateTotalPrice();
            });
        </script>

        <!-- 총 보관 비용 표시 영역 -->
        <div class="rental-total">
            <div>총 보관 비용</div>
            <div>000,0000원</div>
        </div>

        <!-- 구분선 -->
        <div class="divider"></div>

        <!-- 거래 주의사항 영역 -->
        <div class="notice-area">
            거래 시 주의사항
        </div>

        <!-- 구분선 -->
        <div class="divider"></div>

        <!-- 이전/다음 버튼 영역 -->
        <div class="buttons">
            <button class="btn btn-prev">이전</button>
            <button class="btn btn-next">다음</button>
        </div>
    </div>
</div>
<!-- 푸터 영역 포함 -->
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>