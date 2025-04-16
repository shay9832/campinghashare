<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>storenRegister-rentalRegister.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<jsp:include page="header.jsp" />

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title page-title-storen-register">스토렌 신청 (렌탈 정보 등록)</h1>

        <!-- 신청 정보 섹션 -->
        <div class="info-section card">
            <div class="card-header">
                <h3 class="card-title">신청 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">장비 사진</label>
                    <div class="form-input">
                        <div class="image-upload d-flex gap-3">
                            <c:if test="${info.photoList != null && not empty info.photoList}">
                                <c:forEach var="photo" items="${info.photoList}" varStatus="status">
                                    <c:if test="${photo != null && not empty photo.attachmentPath}">
                                        <div class="photo-preview">
                                            <img src="${photo.attachmentPath}" alt="장비 사진 ${status.index + 1}" />
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
                <c:if test="${info.equipmentDTO != null}">
                    <div class="form-row mt-3">
                        <label class="form-label">카테고리(대)</label>
                        <div class="form-input">
                            <span class="info-text">${info.equipmentDTO.majorCategory}</span>
                        </div>
                    </div>
                    <div class="form-row mt-3">
                        <label class="form-label">카테고리(중)</label>
                        <div class="form-input">
                            <span class="info-text">${info.equipmentDTO.middleCategory}</span>
                        </div>
                    </div>
                    <div class="form-row mt-3">
                        <label class="form-label">브랜드</label>
                        <div class="form-input">
                            <span class="info-text">${info.equipmentDTO.brand}</span>
                        </div>
                    </div>
                    <div class="form-row mt-3">
                        <label class="form-label">장비명</label>
                        <div class="form-input">
                            <span class="info-text">${info.equipmentDTO.equip_name}</span>
                        </div>
                    </div>
                </c:if>
                <div class="form-row mt-3">
                    <label class="form-label">장비 사이즈</label>
                    <div class="form-input">
                        <span class="info-text">${info.equip_size_name}</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">보관 기간</label>
                    <div class="form-input">
                        <span class="info-text">${info.store_month} 개월</span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">신품 가격</label>
                    <div class="form-input">
                        <span class="info-text">${info.priceFormatted}원</span>
                        <c:if test="${!info.otherBrand}">
                            <span class="${info.priceDiffClass} ml-2">(평균 대비 ${info.priceDiff}%${info.priceDiffSymbol})</span>
                            <span class="text-secondary ml-2">평균 신품 가격 ${info.avgPriceFormatted}원</span>
                            <span class="info-icon tooltip-trigger ml-1">
                                <i class="fas fa-question-circle text-secondary"></i>
                                <span class="tooltip-content">
                                    유저들이 직접 입력한 해당 장비 '신품 가격'의 평균입니다. (보통 공식 홈페이지, 쇼핑몰 가격 기준으로 입력)
                                </span>
                            </span>
                        </c:if>
                    </div>
                </div>

                <hr class="my-4">

                <!-- 렌탈 정보 입력 폼 -->
                <form action="${pageContext.request.contextPath}/updateStorenRegister-rentalRegister.action" method="post">
                    <input type="hidden" name="equip_code" value="${info.equip_code}">
                    <input type="hidden" name="storen_id" value="${param.storen_id}">

                    <!-- 렌탈 가격 입력 -->
                    <div class="form-row mt-3">
                        <label class="form-label">렌탈 가격</label>
                        <div class="form-input">
                            <div class="d-flex align-items-center">
                                <input type="text" id="rentalPrice" name="daily_rent_price" class="form-control"
                                       placeholder="일 렌탈가 입력" maxlength="10" style="width: 150px;" required>
                                <span class="ml-2">원/일</span>
                                <c:if test="${!info.otherBrand}">
                                    <span id="priceCompare" class="text-secondary ml-3">(평균 대비 0% -)</span>
                                    <span class="text-secondary ml-2">평균 렌탈 가격 ${info.avgRentalPriceFormatted}원/일</span>
                                    <span class="info-icon tooltip-trigger ml-1">
                                        <i class="fas fa-question-circle text-secondary"></i>
                                        <span class="tooltip-content">
                                            유저들이 직접 입력한 해당 장비 '렌탈 가격'의 평균입니다.
                                        </span>
                                    </span>
                                </c:if>
                            </div>
                            <div class="notice-area mt-2">
                                <c:if test="${!info.otherBrand}">
                                    렌탈 가격은 '(평균)신품 가격 * 1%' 수준으로 작성 권장 드립니다.<br>
                                    시세 초과 시 거래 성사가 어려울 수 있습니다.
                                </c:if>
                                <c:if test="${info.otherBrand}">
                                    렌탈 가격은 '신품 가격 * 1%' 수준으로 작성 권장 드립니다.
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- 글 제목 입력 -->
                    <div class="form-row mt-3">
                        <label class="form-label">렌탈 글 제목</label>
                        <div class="form-input">
                            <input type="text" id="titleInput" name="storen_title" class="form-control"
                                   placeholder="렌탈 글 제목 입력" required>
                            <div class="form-check mt-2">
                                <input type="checkbox" class="form-check-input" id="titleCheck">
                                <label class="form-check-label" for="titleCheck">장비명과 동일하게 설정</label>
                            </div>
                        </div>
                    </div>

                    <!-- 상품 내용 입력 -->
                    <div class="form-row mt-3">
                        <label class="form-label">상품 내용</label>
                        <div class="form-input">
                            <textarea id="contentArea" name="storen_content" class="form-control"
                                      placeholder="렌탈 글 내용 입력&#13;(구매 시점, 장비 소재 등 참고사항 입력)"
                                      rows="6" required></textarea>
                            <div class="text-right mt-1 text-secondary" id="charCounter">0/1000byte</div>
                        </div>
                    </div>

                    <!-- 등록 시 주의사항 -->
                    <div class="notice-container">
                        <div class="notice-title">거래 시 주의사항</div>
                        <ul class="notice-list">
                            <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
                            <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
                            <li><strong>OOOOOOOOOOOOOOOOOOOOOOOOO</strong></li>
                        </ul>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="button-container">
                        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/inspec-result.action?storen_id=${param.storen_id}'">이전</button>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 이미지 컨테이너 찾기
        const imageContainer = document.querySelector('.image-upload');
        if(imageContainer) {
            // 이미지 순서 역순으로 정렬 (마지막 올린 것이 처음으로 오게 정렬)
            [...imageContainer.children].reverse().forEach(child => imageContainer.appendChild(child));
        }

        // 브랜드가 '기타'인지 확인
        const isOtherBrand = ${info.otherBrand};
        const avgRentalPrice = parseInt("${info.avgRentalPrice}") || 0;
        const equipName = "${info.equipmentDTO.equip_name}";

        // 렌탈 가격 입력란 숫자만 입력 제한 및 가격 비교 업데이트
        const rentalPrice = document.getElementById('rentalPrice');
        const priceCompare = document.getElementById('priceCompare');

        if (rentalPrice) {
            rentalPrice.addEventListener('input', function() {
                // 숫자만 허용하는 정규식 사용(숫자 이외 문자 제거)
                this.value = this.value.replace(/[^0-9]/g, '');

                // '브랜드 : 기타' 아닌 경우에만 렌탈 가격 비교 업데이트
                if (!isOtherBrand && priceCompare && avgRentalPrice > 0) {
                    const price = parseInt(this.value) || 0;

                    // 차이에 따른 평균가 높낮이 표시
                    if (price > 0) {
                        const diff = ((price - avgRentalPrice) / avgRentalPrice * 100).toFixed(0);
                        const symbol = diff > 0 ? '▲' : diff < 0 ? '▼' : '-';

                        // 평균가 비교 정보 업데이트
                        priceCompare.textContent = '(평균 대비 ' + Math.abs(diff) + '%' + symbol + ')';

                        // CSS 클래스 변경
                        if (diff > 0) {
                            priceCompare.className = 'text-coral ml-3';
                        } else if (diff < 0) {
                            priceCompare.className = 'text-success ml-3';
                        } else {
                            priceCompare.className = 'text-secondary ml-3';
                        }
                    } else {
                        priceCompare.textContent = '(평균 대비 0% -)';
                        priceCompare.className = 'text-secondary ml-3';
                    }
                }
            });
        }

        // 상품 내용 byte 수 카운터 (한글 및 이모지 처리)
        const contentArea = document.getElementById('contentArea');
        const charCounter = document.getElementById('charCounter');

        if (contentArea && charCounter) {
            // 바이트 수 계산 함수
            function calculateBytes(str) {
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

        if (titleCheck && titleInput) {
            titleCheck.addEventListener('change', function() {
                titleInput.value = this.checked ? equipName : "";
            });
        }

        // 툴팁 기능
        const tooltipTriggers = document.querySelectorAll('.tooltip-trigger');
        tooltipTriggers.forEach(function(trigger) {
            trigger.addEventListener('mouseenter', function() {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) {
                    tooltip.style.display = 'block';
                }
            });

            trigger.addEventListener('mouseleave', function() {
                const tooltip = this.querySelector('.tooltip-content');
                if (tooltip) {
                    tooltip.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>