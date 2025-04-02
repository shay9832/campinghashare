<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    // 렌탈 정보 변수 설정
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우피크";
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";
    String storagePeriod = "3 개월";
    String equipmentGrade = "C";
    int newPrice = 3050000;
    int avgNewPrice = 2500000;
    int avgRentalPrice = 20000;

    // 신품 가격 대비 차이율 계산
    int priceDiff = (int)(((double)(newPrice - avgNewPrice) / avgNewPrice) * 100);
    String priceDiffSymbol = priceDiff > 0 ? "▲" : "▼";
    if (priceDiff == 0) priceDiffSymbol = "-";

    // 차이에 따른 색상 결정 (신품 가격) - CSS 클래스로 변경
    String priceDiffClass = "price-diff-neutral";
    if (priceDiff > 0) {
        priceDiffClass = "price-diff-positive";
    } else if (priceDiff < 0) {
        priceDiffClass = "price-diff-negative";
    }

    priceDiff = Math.abs(priceDiff);

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
    <title>스토렌 렌탈 정보 등록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/storen_inspecResult.css">
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<div class="simple-container">
    <div class="simple-title">
        스토렌 신청 (렌탈 정보 등록)
    </div>

    <div class="info-box">
        <div class="info-header">신청 정보</div>
        <div class="info-content">
            <table class="info-table">
                <tr>
                    <th>장비 사진</th>
                    <td>
                        <div class="img-placeholder"></div>
                        <div class="img-placeholder"></div>
                    </td>
                </tr>
                <tr>
                    <th>카테고리(대)</th>
                    <td><%= equipmentCategory %></td>
                </tr>
                <tr>
                    <th>카테고리(중)</th>
                    <td><%= equipmentSubCategory %></td>
                </tr>
                <tr>
                    <th>브랜드</th>
                    <td><%= brand %></td>
                </tr>
                <tr>
                    <th>장비명</th>
                    <td><%= equipmentName %></td>
                </tr>
                <tr>
                    <th>장비 사이즈</th>
                    <td><%= equipmentSize %></td>
                </tr>
                <tr>
                    <th>보관 기간</th>
                    <td><%= storagePeriod %></td>
                </tr>
                <tr>
                    <th>장비 등급</th>
                    <td>
                        <span class="grade-badge"><%= equipmentGrade %></span>
                        <a href="storen_inspecResult1.jsp" class="detail-link">(상세 내용 보기)</a>
                    </td>
                </tr>
                <tr>
                    <th>신품 가격</th>
                    <td>
                        <%= priceFormatted %> 원
                        <span class="<%= priceDiffClass %>">(평균 대비 <%= priceDiff %>%<%= priceDiffSymbol %>)</span>
                        <span class="price-avg">평균 신품 가격 <%= avgPriceFormatted %>원</span>
                        <span class="help-btn">?
                            <span class="help-tooltip">'평균 신품 가격'은 유저들이 해당 장비에 대해 입력한 데이터를 기반으로 산출됩니다. (보통 브랜드 공식 홈페이지, 쇼핑몰 가격을 기준으로 입력)</span>
                        </span>
                    </td>
                </tr>
            </table>

            <div class="divider"></div>

            <table class="info-table">
                <tr>
                    <th>렌탈 가격</th>
                    <td>
                        <input type="text" id="rentalPrice" class="input-normal" placeholder="일 렌탈가 입력" maxlength="10"> 원/일
                        <span id="priceCompare" class="price-diff-neutral">(평균 대비 0% -)</span>
                        <span class="price-avg">평균 렌탈 가격 <%= avgRentalPriceFormatted %>원/일</span>
                        <span class="help-btn">?
                            <span class="help-tooltip">'평균 렌탈 가격'은 유저들이 해당 장비에 대해 입력한 데이터를 기반으로 산출됩니다.</span>
                        </span>
                        <div class="note-text">
                            렌탈 가격은 '(평균)신품 가격 * 1%' 수준으로 작성 권장 드립니다.<br>
                            시세 초과 시 거래 성사가 어려울 수 있습니다.
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>글 제목</th>
                    <td>
                        <input type="text" id="titleInput" class="input-wide" placeholder="렌탈 글 제목 입력">
                        <div style="margin-top: 10px;">
                            <label>
                                <input type="checkbox" id="titleCheck"> 장비명과 동일하게 설정
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>상품 내용</th>
                    <td>
                        <textarea id="contentArea" class="textarea-field" placeholder="렌탈 글 내용 입력&#13;(구매 시점, 장비 소재 등 참고사항 입력)"></textarea>
                        <div class="char-counter" id="charCounter">0/1000byte</div>
                    </td>
                </tr>
            </table>

            <div class="short-divider"></div>

            <div class="centered-text">
                <br>
                거래 시 주의사항
                <br><br>
            </div>
            <div class="short-divider"></div>
        </div>
    </div>

    <div class="button-row">
        <button class="simple-btn">이전</button>
        <button class="simple-btn primary-btn">다음</button>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 렌탈 가격 입력란 숫자만 입력 제한
        const rentalPrice = document.getElementById('rentalPrice');
        const priceCompare = document.getElementById('priceCompare');
        const avgPrice = <%= avgRentalPrice %>;

        if (rentalPrice && priceCompare) {
            rentalPrice.addEventListener('input', function() {
                // 숫자만 허용하는 정규식 사용
                this.value = this.value.replace(/[^0-9]/g, '');

                // 기존 렌탈 가격 계산 로직과 동일
                const price = parseInt(this.value) || 0;

                if (price > 0) {
                    const diff = ((price - avgPrice) / avgPrice * 100).toFixed(0);
                    const symbol = diff > 0 ? '▲' : diff < 0 ? '▼' : '-';

                    priceCompare.textContent = '(평균 대비 ' + Math.abs(diff) + '%' + symbol + ')';

                    // CSS 클래스 변경
                    priceCompare.className = diff > 0 ? 'price-diff-positive' : 'price-diff-negative';
                } else {
                    priceCompare.textContent = '(평균 대비 0% -)';
                    priceCompare.className = 'price-diff-neutral';
                }
            });
        }

        // 상품 내용 byte 수 카운터 (한글 및 이모지 처리)
        const contentArea = document.getElementById('contentArea');
        const charCounter = document.getElementById('charCounter');

        if (contentArea && charCounter) {
            // 개선된 byte 계산 함수 - 이모지 처리 포함
            function calculateBytes(str) {
                let byteCount = 0;
                for (let i = 0; i < str.length; i++) {
                    const charCode = str.codePointAt(i);

                    // 서로게이트 쌍 처리 (이모지 및 특수 유니코드 문자)
                    if (charCode > 0xFFFF) {
                        byteCount += 4; // 이모지 및 특수 유니코드 문자는 4바이트
                        i++; // 서로게이트 쌍은 2개의 JavaScript 문자로 표현되므로 인덱스 추가 건너뛰기
                    } else if (charCode > 0x7FF) {
                        byteCount += 3; // 대부분의 한글 및 일본어, 중국어 등 CJK 문자 (3바이트)
                    } else if (charCode > 0x7F) {
                        byteCount += 2; // 라틴 확장 문자 및 기타 유럽 문자 (2바이트)
                    } else {
                        byteCount += 1; // ASCII 문자 (1바이트)
                    }
                }
                return byteCount;
            }

            // 디바운스 함수 정의 (성능 최적화)
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
                    // 바이너리 검색 방식으로 최적화
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

                    // 최종 적합한 지점 찾기
                    while (calculateBytes(cutText) > 1000) {
                        cutText = cutText.slice(0, -1);
                    }

                    contentArea.value = cutText;
                    currentBytes = calculateBytes(cutText);
                }

                // byte 수 표시
                charCounter.textContent = currentBytes + '/1000byte';
            }

            // 디바운싱 적용 (입력이 빠르게 연속될 때 성능 최적화)
            const debouncedUpdate = debounce(updateByteCount, 100);
            contentArea.addEventListener('input', debouncedUpdate);
        }

        // 장비명 동일하게 설정
        const titleCheck = document.getElementById('titleCheck');
        const titleInput = document.getElementById('titleInput');

        if (titleCheck && titleInput) {
            titleCheck.addEventListener('change', function() {
                titleInput.value = this.checked ? "<%= equipmentName %>" : "";
            });
        }
    });
</script>
</body>
</html>