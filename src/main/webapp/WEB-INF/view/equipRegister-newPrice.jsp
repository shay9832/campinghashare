<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>4-equip-info.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 브랜드 값에 따라 UI 초기 설정
            setupUIBasedOnBrand();

            // 사진 업로드 처리 - 이벤트 리스너 수정
            $("#photoInput").on('change', function() {
                console.log("File selected"); // 디버깅용 로그
                handleFileSelect(this.files);
            });

            /*
            // 장비명 입력 필드에 대한 이벤트 리스너
            $("#equipNameSearch").on('input', function() {
                // 장비명이 입력된 경우에만 가격 비교 정보를 표시
                if ($(this).val().trim().length > 0) {
                    updatePriceComparison();
                    $("#priceComparison").show();
                } else {
                    $("#priceComparison").hide();
                }
            });
             */

            /*
            // 가격 입력 처리
            $("#priceInput").on('input', function() {
                if (!isBrandOther() && $("#equipNameSearch").val().trim().length > 0) {
                    updatePriceComparison();
                    $("#priceComparison").show();
                } else {
                    $("#priceComparison").hide();
                }
            });
            */

            // 툴팁 이벤트 처리 수정
            $(document).on('mouseenter', '.tooltip-trigger', function() {
                $(this).find('.tooltip-content').stop().fadeIn(200);
            });

            $(document).on('mouseleave', '.tooltip-trigger', function() {
                $(this).find('.tooltip-content').stop().fadeOut(200);
            });

            // 최초 로딩 시 가격 비교 정보 숨기기
            //$("#priceComparison").hide();
        });

        // 브랜드가 '기타'인지 확인하는 함수
        function isBrandOther() {
            const brandValue = $("#brandInput").val();
            return brandValue === "기타";
        }

        /*
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
                if ($("#priceInput").val() && $("#equipNameSearch").val().trim().length > 0) {
                    updatePriceComparison();
                    $("#priceComparison").show();
                } else {
                    $("#priceComparison").hide();
                }
            }
        }
        */

        // 파일 선택 처리 함수
        function handleFileSelect(files) {
            console.log("Processing files:", files.length); // 디버깅용 로그

            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (!file.type.match('image.*')) {
                    console.log("Skipping non-image file:", file.name);
                    continue;
                }

                const reader = new FileReader();
                reader.onload = (function(theFile) {
                    return function(e) {
                        console.log("File loaded:", theFile.name); // 디버깅용 로그

                        // 미리보기 이미지 생성
                        const photoDiv = document.createElement('div');
                        photoDiv.className = 'photo-preview';
                        photoDiv.innerHTML = [
                            '<img class="thumb" src="', e.target.result, '" title="', theFile.name, '"/>',
                            '<button type="button" class="remove-photo" onclick="removePhoto(this)"><i class="fa-solid fa-times"></i></button>'
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
            }
        }

        // 추가: setupUIBasedOnBrand 함수 빈 구현 (원래 주석 처리되어 있음)
        function setupUIBasedOnBrand() {
            // 원래 주석처리된 함수이지만, ready 함수에서 호출되므로 빈 함수로 구현
        }
    </script>

</head>
<body>
<div class="page-wrapper">
    <jsp:include page="header.jsp"></jsp:include>

    <main class="main-content container">
        <h1 class="page-title">내 장비 등록</h1>

        <div class="equipinfo-container">
            <div class="equipinfo-item">
                <label>장비 사진</label>
                <div class="input-container">
                    <div class="photo-area">
                        <div class="photos-container" id="photosContainer">
                            <!-- 업로드된 사진이 여기에 표시됩니다 -->
                        </div>
                        <div class="photo-upload">
                            <label for="photoInput" class="add-photo-btn">
                                <span class="center-icon"><i class="fa-solid fa-plus"></i></span>
                            </label>
                            <input type="file" id="photoInput" accept="image/*" multiple style="display: none;">
                        </div>
                    </div>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>카테고리(대)</label>
                <div class="input-container">
                    <span class="info-text">텐트/쉘터</span>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>카테고리(중)</label>
                <div class="input-container">
                    <span class="info-text">텐트</span>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>브랜드</label>
                <div class="input-container">
                    <span class="info-text">스노우피크</span>
                    <input type="hidden" id="brandInput" value="스노우피크">
                </div>
            </div>

            <div class="equipinfo-item">
                <label>장비명</label>
                <div class="input-container">
                    <div class="search-container">
                        <input type="text" placeholder="장비명 검색 및 선택" class="search-input" id="equipNameSearch">
                        <button class="search-button">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
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
                            <div class="tooltip-content">이 가격은 유저들이 등록한 동일 상품의 평균 가격입니다.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 등록 시 주의사항 섹션 -->
        <div class="notice-container">
            <div class="notice-title">등록 시 주의사항</div>
            <ul class="notice-list">
                <li><strong>브랜드, 장비명을 정확히 기재해 주세요.</strong></li>
                <li><strong>장비의 전체 모습과 상세 부분을 여러 각도에서 촬영한 사진을 첨부해 주세요.</strong></li>
                <li><strong>신품가격을 명확히 표시해 주세요.</strong></li>
            </ul>
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="equipregister-brand.action" class="btn">이전</a>
            <a href="equipregister-complete.action" class="btn btn-primary">등록</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>