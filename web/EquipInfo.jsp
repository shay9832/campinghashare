<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Equip Info</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/equipinfo.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 브랜드 값에 따라 UI 초기 설정
            setupUIBasedOnBrand();

            // 사진 업로드 처리
            $("#photoInput").change(function() {
                handleFileSelect(this.files);
            });

            // 가격 입력 처리
            $("#priceInput").on('input', function() {
                if (!isBrandOther()) {
                    updatePriceComparison();
                }
            });

            // 가격 정보에 tooltips 표시 - 직접 이벤트 리스너 사용
            $(document).on('mouseenter', '.tooltip-trigger', function() {
                $(this).find(".tooltip-content").fadeIn(200);
            });

            $(document).on('mouseleave', '.tooltip-trigger', function() {
                $(this).find(".tooltip-content").fadeOut(200);
            });
        });

        // 브랜드가 '기타'인지 확인하는 함수
        function isBrandOther() {
            const brandValue = $("#brandInput").val();
            return brandValue === "기타";
        }

        // 브랜드 값에 따라 UI 설정
        function setupUIBasedOnBrand() {
            if (isBrandOther()) {
                // 장비명 입력 필드를 직접 입력 모드로 변경
                $("#equipNameSearch").attr("placeholder", "장비명 직접 입력");
                $("#equipNameSearch").attr("readonly", false);
                $(".search-button").hide(); // 검색 버튼 숨기기

                // 가격 비교 정보 숨기기
                $("#priceComparison").hide();
            } else {
                // 장비명 입력 필드를 검색 모드로 설정
                $("#equipNameSearch").attr("placeholder", "장비명 검색 및 선택");
                $("#equipNameSearch").attr("readonly", false);
                $(".search-button").show(); // 검색 버튼 표시

                // 가격 입력 시 가격 비교 정보 표시
                if ($("#priceInput").val()) {
                    updatePriceComparison();
                }
            }
        }

        // 파일 선택 처리 함수
        function handleFileSelect(files) {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (!file.type.match('image.*')) {
                    continue;
                }

                const reader = new FileReader();
                reader.onload = (function(theFile) {
                    return function(e) {
                        // 미리보기 이미지 생성
                        const photoDiv = document.createElement('div');
                        photoDiv.className = 'photo-preview';
                        photoDiv.innerHTML = [
                            '<img class="thumb" src="', e.target.result, '" title="', theFile.name, '"/>',
                            '<button class="remove-photo" onclick="removePhoto(this)"><i class="fa-solid fa-times"></i></button>'
                        ].join('');

                        $('#photosContainer').append(photoDiv);
                    };
                })(file);

                reader.readAsDataURL(file);
            }
        }

        // 사진 제거 함수
        function removePhoto(element) {
            $(element).parent().remove();
        }

        // 가격 비교 업데이트 함수
        function updatePriceComparison() {
            const inputPrice = parseInt($("#priceInput").val().replace(/,/g, '')) || 0;
            const avgPrice = 2500000; // 예시 평균 가격, 실제로는 서버에서 가져와야 함

            if (inputPrice > 0) {
                const diff = ((inputPrice - avgPrice) / avgPrice * 100).toFixed(0);
                const symbol = diff >= 0 ? "▲" : "▼";
                const absDiff = Math.abs(diff);

                $("#priceDiff").html(`(평균 대비 ${absDiff}%${symbol})`);
                $("#priceDiff").css('color', diff >= 0 ? '#d9534f' : '#5cb85c');
                $("#priceComparison").show();
            } else {
                $("#priceComparison").hide();
            }
        }
    </script>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<main class="main-content">
    <h1 class="page-title">내 장비 등록</h1>

    <div class="equipinfo-container">
        <div class="equipinfo-item">
            <label>장비 사진</label>
            <div class="photo-area">
                <div class="photos-container" id="photosContainer">
                    <!-- 업로드된 사진이 여기에 표시 -->
                </div>
                <div class="photo-upload">
                    <label for="photoInput" class="add-photo-btn">
                        <i class="fa-solid fa-plus"></i>
                    </label>
                    <input type="file" id="photoInput" accept="image/*" multiple style="display: none;">
                </div>
            </div>
        </div>

        <div class="equipinfo-item">
            <label>카테고리(대)</label>
            <div class="input-container">
                <input type="text" readonly="readonly" value="텐트/쉘터" disabled="disabled">
            </div>
        </div>

        <div class="equipinfo-item">
            <label>카테고리(중)</label>
            <div class="input-container">
                <input type="text" readonly="readonly" value="텐트" disabled="disabled">
            </div>
        </div>

        <div class="equipinfo-item">
            <label>브랜드</label>
            <div class="input-container">
                <input type="text" id="brandInput" readonly="readonly" value="스노우피크" disabled="disabled">
            </div>
        </div>

        <div class="equipinfo-item">
            <label>장비명</label>
            <div class="input-container">
                <input type="text" placeholder="장비명 검색 및 선택" class="search-input" id="equipNameSearch">
                <button class="search-button">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
        </div>

        <div class="equipinfo-item">
            <label>신품가격</label>
            <div class="input-container price-row">
                <input type="text" placeholder="금액 입력" class="price-input" id="priceInput">
                <span class="currency">원</span>
                <div class="price-comparison" id="priceComparison">
                    <span class="price-diff" id="priceDiff">(평균 대비 22%▲)</span>
                    <span class="avg-price">평균 신품 가격</span>
                    <span class="avg-price-value">2,500,000원</span>
                    <div class="info-icon tooltip-trigger">
                        <i class="fa-solid fa-circle-question"></i>
                        <div class="tooltip-content">이 가격은 최근 등록된 동일 상품의 평균 가격입니다.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="divider">
        <p class="divider-text">등록 시 주의사항</p>
    </div>

    <div class="notice-container">
        <ul class="notice-list">
            <li><strong>브랜드, 장비명을 정확히 기재해 주세요.</strong></li>
            <li><strong>장비의 전체 모습과 상세 부분을 여러 각도에서 촬영한 사진을 첨부해 주세요.</strong></li>
            <li><strong>신품가격을 명확히 표시해 주세요.</strong></li>
        </ul>
    </div>

    <div class="nav-buttons">
        <a href="#" class="nav-button">취소</a>
        <a href="#" class="nav-button">다음</a>
    </div>
</main>


<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>
