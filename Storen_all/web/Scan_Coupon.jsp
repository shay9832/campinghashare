<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 2.
  Time: 오전 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>쿠폰 조회 적용</title>
    <link rel="stylesheet" href="css/Scan_coupon.css">
</head>
<body>
<!-- 팝업창 메인 컨테이너 시작 -->
<div class="main_container_coupon_select">
    <!-- 헤더 영역 시작 -->
    <header>
        <!-- 페이지 제목 -->
        <div class="coupon_select_title">
            <h2>쿠폰 조회 적용</h2>
        </div>
    </header>
    <!-- 헤더 영역 종료 -->

    <!-- 메인 콘텐츠 영역 시작 -->
    <main>
        <!-- 메인 콘텐츠 컨테이너 -->
        <div class="main_container_coupon_content">
            <!-- 쿠폰 유의사항 섹션 시작 -->
            <div class="main_container_coupon_title">
                <!-- 쿠폰 유의사항 제목 -->
                <div class="main_container_coupon_title_info">
                    <span>쿠폰 관련 유의 사항</span>
                </div>
                <!-- 쿠폰 유의사항 내용 -->
                <div class="main_container_coupon_info">
                    <ul>
                        <li>해당 제품에 사용 가능한 쿠폰만 조회됩니다.</li>
                        <li>가장 큰 할인 금액의 쿠폰을 자동 선택한 상태로 보여집니다.</li>
                        <li>쿠폰은 주문 당 1장만 사용 가능합니다.</li>
                    </ul>
                </div>
            </div>
            <!-- 쿠폰 유의사항 섹션 종료 -->

            <!-- 쿠폰 리스트 섹션 시작 - 스크롤바가 적용되는 영역 -->
            <div class="main_container_coupon_list">
                <!-- 쿠폰 테이블 시작 -->
                <table class="coupon_table">
                    <!-- 테이블 헤더 - 스크롤 시 고정됨 -->
                    <thead>
                    <tr class="main_container_list_title">
                        <th style="width: 25%;">할인 금액</th>
                        <th style="width: 25%;">쿠폰명</th>
                        <th style="width: 50%;">참고사항</th>
                    </tr>
                    </thead>
                    <!-- 테이블 본문 - 스크롤되는 영역 -->
                    <tbody>
                    <!-- 첫 번째 쿠폰 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon1">
                            <label for="coupon1">10,000원 할인</label>
                        </td>
                        <td style="text-align: center;">상품 할인 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 10,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 두 번째 쿠폰 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon2" checked>
                            <label for="coupon2">27,000원 할인</label>
                        </td>
                        <td style="text-align: center;">신규 고객 특별 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 27,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 세 번째 쿠폰 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon3">
                            <label for="coupon3">50,000원 할인</label>
                        </td>
                        <td style="text-align: center;">VIP 전용 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 50,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 네 번째 쿠폰 - 스크롤 테스트용 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon4">
                            <label for="coupon4">15,000원 할인</label>
                        </td>
                        <td style="text-align: center;">시즌 할인 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 15,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 다섯 번째 쿠폰 - 스크롤 테스트용 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon5">
                            <label for="coupon5">30,000원 할인</label>
                        </td>
                        <td style="text-align: center;">생일 축하 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 30,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 여섯 번째 쿠폰 - 스크롤 테스트용 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon6">
                            <label for="coupon6">20,000원 할인</label>
                        </td>
                        <td style="text-align: center;">회원가입 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 20,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 일곱 번째 쿠폰 - 스크롤 테스트용 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon7">
                            <label for="coupon7">12,000원 할인</label>
                        </td>
                        <td style="text-align: center;">주말 특별 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 12,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    <!-- 여덟 번째 쿠폰 - 스크롤 테스트용 -->
                    <tr>
                        <td style="text-align: center;">
                            <input type="radio" name="coupon_name" id="coupon8">
                            <label for="coupon8">8,000원 할인</label>
                        </td>
                        <td style="text-align: center;">첫 구매 쿠폰</td>
                        <td>
                            <ul>
                                <li>최대 할인 금액: 8,000원</li>
                                <li>만료 예정 일자: 25.12.31까지</li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <!-- 쿠폰 테이블 종료 -->
            </div>
            <!-- 쿠폰 리스트 섹션 종료 -->

            <!-- 버튼 영역 시작 -->
            <div class="button_container">
                <button class="btn btn-reset" onclick="resetCoupon()">초기화</button>
                <button class="btn btn-complete" onclick="completeCoupon()">완료</button>
            </div>
            <!-- 버튼 영역 종료 -->
        </div>
    </main>
    <!-- 메인 콘텐츠 영역 종료 -->
</div>
<!-- 팝업창 메인 컨테이너 종료 -->

<!-- 자바스크립트 시작 -->
<script>
    // 초기화 버튼 클릭 시 실행되는 함수
    function resetCoupon() {
        // 체크된 라디오 버튼 초기화
        const radios = document.querySelectorAll('input[name="coupon_name"]');
        radios.forEach(radio => {
            radio.checked = false;
        });
    }

    // 완료 버튼 클릭 시 실행되는 함수
    function completeCoupon() {
        // 선택된 쿠폰 확인
        const selectedCoupon = document.querySelector('input[name="coupon_name"]:checked');
        if (selectedCoupon) {
            // 선택된 쿠폰이 있으면 알림 표시 및 팝업창 닫기
            alert("쿠폰이 적용되었습니다.");
            // window.close(); // 팝업창 닫기 - 실제 사용 시 주석 해제
        } else {
            // 선택된 쿠폰이 없으면 알림 표시
            alert("쿠폰을 선택해주세요.");
        }
    }
</script>
<!-- 자바스크립트 종료 -->
</body>
</html>