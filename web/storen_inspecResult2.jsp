<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    // 렌탈 정보 저장할 변수
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우 피크(SNOW PEAK)"; // "기타"인 경우, 평균 미표시 및 권장 가격 문구 변경됨
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";             // 장비 사이즈
    String storagePeriod = "3 개월";         // 보관 개월 수
    String equipmentGrade = "C";            // 장비 등급
    int newPrice = 3050000;                 // 신품 가격(사용자 기존 입력)
    int avgNewPrice = 2500000;              // 평균 신품 가격
    int avgRentalPrice = 20000;             // 평균 렌탈 가격

    // 브랜드가 '기타'인지 확인하는 변수
    boolean isOtherBrand = "기타".equals(brand);

    // 신품 가격 대비 차이율 계산 (브랜드가 '기타'가 아닌 경우에만)
    int priceDiff = 0;
    String priceDiffSymbol = "-";                   // 변화 없음(중립)
    String priceDiffClass = "price-diff-neutral";   // 중립

    // 브랜드가 '기타'가 아닌 경우
    if (!isOtherBrand) {
        priceDiff = (int)(((double)(newPrice - avgNewPrice) / avgNewPrice) * 100);
        priceDiffSymbol = priceDiff > 0 ? "▲" : "▼";
        if (priceDiff == 0) priceDiffSymbol = "-";

        // 차이에 따른 '평균가 비교 정보' 색상 결정 (신품 가격)
        if (priceDiff > 0) {
            priceDiffClass = "price-diff-positive";
        } else if (priceDiff < 0) {
            priceDiffClass = "price-diff-negative";
        }

        // 절대값 연산
        priceDiff = Math.abs(priceDiff);
    }

    // 천 단위 콤마 포맷팅
    NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
    String priceFormatted = nf.format(newPrice);
    String avgPriceFormatted = nf.format(avgNewPrice);
    String avgRentalPriceFormatted = nf.format(avgRentalPrice);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>storen_inspecResult2.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/button.css">
    <link rel="stylesheet" href="css/equipImage.css">
    <link rel="stylesheet" href="css/equipRank.css">
    <link rel="stylesheet" href="css/transPost.css">
    <link rel="stylesheet" href="css/avgPrice.css">
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<div class="container">
    <div class="page-title">
        스토렌 신청 (렌탈 정보 등록)
    </div>
    <div class="info-section">
        <div class="section-title">신청 정보</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">장비 사진</div>
                <div class="info-value">
                    <div class="equipment-image"></div>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">카테고리(대)</div>
                <div class="info-value"><%= equipmentCategory %></div>
            </div>
            <div class="info-row">
                <div class="info-label">카테고리(중)</div>
                <div class="info-value"><%= equipmentSubCategory %></div>
            </div>
            <div class="info-row">
                <div class="info-label">브랜드</div>
                <div class="info-value"><%= brand %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비명</div>
                <div class="info-value"><%= equipmentName %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비 사이즈</div>
                <div class="info-value"><%= equipmentSize %></div>
            </div>
            <div class="info-row">
                <div class="info-label">보관 기간</div>
                <div class="info-value"><%= storagePeriod %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비 등급</div>
                <div class="info-value">
                    <span class="grade-badge"><%= equipmentGrade %></span>
                    <a href="storen_inspecResult1.jsp" class="detail-link">(상세 내용 보기)</a>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">신품 가격</div>
                <div class="info-value">
                    <span><%= priceFormatted %>원</span>  <%-- 포맷팅된 신품 가격 출력 --%>
                    <% if (!isOtherBrand) { %>            <%-- '브랜드 : 기타' 아닌 경우에만 표시 --%>
                    <span class="<%= priceDiffClass %>">(평균 대비 <%= priceDiff %>%<%= priceDiffSymbol %>)</span>   <%-- 평균 대비 가격 차이 표시 --%>
                    <span class="price-avg">평균 신품 가격 <%= avgPriceFormatted %>원</span>   <%-- 평균 신품 가격 표시 --%>
                    <span class="help-icon">?           <%-- 도움말 아이콘 --%>
                        <span class="help-tooltip">     <%-- 도움말 툴팁 --%>
                            '평균 신품 가격'은 유저들이 해당 장비에 대해 입력한 데이터를 기반으로 산출됩니다. (보통 브랜드 공식 홈페이지, 쇼핑몰 가격을 기준으로 입력)
                        </span>
                    </span>
                    <% } %>
                </div>
            </div>
        </div>

        <%-- 구분선 --%>
        <div class="divider"></div>

        <%-- 렌탈 정보 입력 섹션 --%>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">렌탈 가격</div>
                <div class="info-value">
                    <input type="text" id="rentalPrice" class="input-normal" placeholder="일 렌탈가 입력" maxlength="10"> 원/일
                    <% if (!isOtherBrand) { %>      <%-- '브랜드 : 기타' 아닌 경우에만 표시 --%>
                    <span id="priceCompare" class="price-diff-neutral">(평균 대비 0% -)</span>          <%-- 평균 렌탈 가격 대비 차이(초기값 0) --%>
                    <span class="price-avg">평균 렌탈 가격 <%= avgRentalPriceFormatted %>원/일</span>    <%-- 평균 렌탈 가격 표시 --%>
                    <span class="help-icon">?       <%-- 도움말 아이콘 --%>
                        <span class="help-tooltip"> <%-- 도움말 툴팁 --%>
                            '평균 렌탈 가격'은 유저들이 해당 장비에 대해 입력한 데이터를 기반으로 산출됩니다.
                        </span>
                    </span>
                    <div class="note-text">
                        렌탈 가격은 '(평균)신품 가격 * 1%' 수준으로 작성 권장 드립니다.<br>
                        시세 초과 시 거래 성사가 어려울 수 있습니다.
                    </div>
                    <% } else { %>          <%-- '브랜드 : 기타'인 경우 --%>
                    <div class="note-text"> <%-- 간소화된 렌탈 가격 지침 안내 --%>
                        렌탈 가격은 '신품 가격 * 1%' 수준으로 작성 권장 드립니다.<br>
                    </div>
                    <% } %>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">글 제목</div>
                <div class="info-value">
                    <%-- 렌탈 글 제목 --%>
                    <input type="text" id="titleInput" class="input-wide" placeholder="렌탈 글 제목 입력">
                    <div style="margin-top: 10px;">
                        <label>
                            <input type="checkbox" id="titleCheck"> 장비명과 동일하게 설정
                        </label>
                    </div>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">상품 내용</div>
                <div class="info-value">
                    <%-- 렌탈 글 내용 입력 --%>
                    <textarea id="contentArea" class="textarea-field" placeholder="렌탈 글 내용 입력&#13;(구매 시점, 장비 소재 등 참고사항 입력)"></textarea>
                    <div class="char-counter" id="charCounter">0/1000byte</div>
                </div>
            </div>
        </div>

        <%-- 주의사항 표시 섹션 --%>
        <div class="section-content">
            <div class="short-divider"></div>   <%-- 짧은 구분선 --%>
            <div class="centered-text">거래 시 주의사항</div>
            <div class="short-divider" style="margin-bottom: 25px;"></div>
        </div>
    </div>

    <%--이전 / 다음 페이지 이동 버튼 --%>
    <div class="button-container">
        <button class="btn">이전</button>
        <button class="btn btn-primary">다음</button>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />

<%-- 아이콘 라이브러리 자바스크립트로 로드 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {  <%-- 문서 로딩 완료 후 실행되는 브랜드(기타 여부) 확인 --%>
        // 브랜드가 '기타'인지 확인
        const isOtherBrand = <%= isOtherBrand %>;

        // 렌탈 가격 입력란 숫자만 입력 제한 및 가격 비교 업데이트
        const rentalPrice = document.getElementById('rentalPrice');     // 렌탈 가격 입력 필드
        const priceCompare = document.getElementById('priceCompare');   // 가격 비교 표시 요소

        if (rentalPrice) {      // 요소 존재할 경우
            rentalPrice.addEventListener('input', function() {          // 입력 이벤트 리스너
                // 숫자만 허용하는 정규식 사용(숫자 이외 문자 제거)
                this.value = this.value.replace(/[^0-9]/g, '');

                // '브랜드 : 기타' 아닌 경우에만 렌탈 가격 비교 업데이트
                if (!isOtherBrand && priceCompare) {
                    const avgPrice = <%= avgRentalPrice %>;             // 평균 대비 가격 높음/낮음 구분
                    const price = parseInt(this.value) || 0;            // 가격 같으면 '-'

                    // 차이에 따른 평균가 높낮이 표시
                    if (price > 0) {         // 가격 입력된 경우
                        const diff = ((price - avgPrice) / avgPrice * 100).toFixed(0);  // 평균 대비 차이 백분율
                        const symbol = diff > 0 ? '▲' : diff < 0 ? '▼' : '-';           // 높음/동일/낮음 표시 기호

                        // 평균가 비교 정보 업데이트
                        priceCompare.textContent = '(평균 대비 ' + Math.abs(diff) + '%' + symbol + ')';

                        // CSS 클래스 변경 (평균 이상일 경우 빨간색, 낮거나 같으면 녹색)
                        priceCompare.className = diff > 0 ? 'price-diff-positive' : 'price-diff-negative';
                    } else {        // 가격 입력되지 않은 경우
                        priceCompare.textContent = '(평균 대비 0% -)';  // 기본 텍스트로 재설정
                        priceCompare.className = 'price-diff-neutral'; // 중립 색상 클래스로 설정
                    }
                }
            });
        }

        // 상품 내용 byte 수 카운터 (한글 및 이모지 처리)
        const contentArea = document.getElementById('contentArea'); // 상품 내용 텍스트 영역
        const charCounter = document.getElementById('charCounter'); // 글자 수 카운트

        if (contentArea && charCounter) {       // 2개 요소 모두 존재할 경우
            // 바이트 수 계산 함수
            function calculateBytes(str) {
                let byteCount = 0;
                for (let i = 0; i < str.length; i++) {
                    const charCode = str.codePointAt(i);

                    // '서로 게이트(Surrogate Pair, 특수문자 인코딩 UTF-16)' 쌍 처리
                    if (charCode > 0xFFFF) {
                        byteCount += 4;             // 이모지 및 특수 유니코드 문자는 4바이트
                        i++;                        // '서로 게이트' 쌍 : 2개의 JavaScript 문자로 표현
                    } else if (charCode > 0x7FF) {
                        byteCount += 3;             // 대부분의 한글 및 일본어, 중국어 등 CJK 문자 (3바이트)
                    } else if (charCode > 0x7F) {
                        byteCount += 2;             // 라틴 확장 문자 및 기타 유럽 문자 (2바이트)
                    } else {
                        byteCount += 1;             // ASCII 문자 (1바이트)
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

            // 바이트 수 계산 및 표시 함수
            function updateByteCount() {
                const text = contentArea.value;
                let currentBytes = calculateBytes(text);

                // 1000 byte 초과 시 자르기
                if (currentBytes > 1000) {
                    // 바이너리 검색 방식으로 최적화(가장 효율적으로 1000바이트 이내로 잘라내기)
                    let start = 0;
                    let end = text.length;
                    let mid;
                    let cutText = text;

                    while (start < end) {
                        mid = Math.floor((start + end) / 2);
                        cutText = text.substring(0, mid);

                        if (calculateBytes(cutText) <= 1000) {
                            start = mid + 1;
                        } else {
                            end = mid;
                        }
                    }

                    // 최종 적합한 지점 찾기(1000 바이트 이내 최대 길이 찾기)
                    while (calculateBytes(cutText) > 1000) {
                        cutText = cutText.slice(0, -1);
                    }

                    // 잘린 텍스트로 내용 업데이트
                    contentArea.value = cutText;
                    // 업데이트 된 바이트 수 계산
                    currentBytes = calculateBytes(cutText);
                }

                // byte 수 표시
                charCounter.textContent = currentBytes + '/1000byte';
            }

            // 디바운싱 적용 (입력이 빠르게 연속될 때 성능 최적화)
            const debouncedUpdate = debounce(updateByteCount, 100);
            contentArea.addEventListener('input', debouncedUpdate);
        }

        // 제목과 장비명 동일하게 설정(체크박스)
        const titleCheck = document.getElementById('titleCheck');
        const titleInput = document.getElementById('titleInput');

        if (titleCheck && titleInput) {                                         // 2가지 다 값 존재하면
            titleCheck.addEventListener('change', function() {                  // 체크박스 변경 이벤트 리스너
                titleInput.value = this.checked ? "<%= equipmentName %>" : "";  // 체크되면 장비명으로 설정 (체크 없을 시, 공백)
            });
        }
    });
</script>
</body>
</html>