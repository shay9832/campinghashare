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

        function submitEquipmentForm() {
            const equipName = document.getElementById("equipNameSearch").value;
            const price = document.getElementById("priceInput").value.replace(/,/g, '');

            // 입력값 검증
            if (equipName.trim() === '') {
                alert("장비명을 입력해주세요.");
                return false;
            }

            if (price.trim() === '' || isNaN(price) || parseInt(price) <= 0) {
                alert("유효한 가격을 입력해주세요.");
                return false;
            }

            // 폼 생성 및 제출
            const form = document.createElement("form");
            form.method = "POST";
            form.action = "${pageContext.request.contextPath}/equipregister-complete.action";

            // 히든 필드 추가
            const fields = {
                "majorCategory": "${majorCategory}",
                "middleCategory": "${middleCategory}",
                "brand": "${brand}",
                "equipName": equipName,
                "originalPrice": price
            };

            // 사진 정보도 함께 전송하기 위한 처리
            if (document.querySelectorAll('#photosContainer .photo-preview').length > 0) {
                const hasPhotosInput = document.createElement("input");
                hasPhotosInput.type = "hidden";
                hasPhotosInput.name = "hasPhotos";
                hasPhotosInput.value = "true";
                form.appendChild(hasPhotosInput);
            }

            // 각 필드를 폼에 추가
            for (const key in fields) {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            }

            // 폼을 body에 추가하고 제출
            document.body.appendChild(form);
            form.submit();
        }

        function setupEquipNameDropdown() {
            const searchInput = document.getElementById('equipNameSearch');
            const searchContainer = searchInput.closest('.search-container');
            const brand = "${brand}"; // JSP 표현식으로 브랜드 값 가져오기

            // 드롭다운 엘리먼트 생성
            const dropdown = document.createElement('div');
            dropdown.id = 'equipNameDropdown';
            searchContainer.appendChild(dropdown);

            // AJAX로 장비명 목록 가져오기
            function fetchEquipNames(searchTerm = '') {
                $.ajax({
                    url: "${pageContext.request.contextPath}/getEquipNamesByBrand.action",
                    type: "GET",
                    data: { brand: brand },
                    success: function(equipNames) {
                        // 검색어 필터링
                        const filteredNames = equipNames.filter(name =>
                            name.toLowerCase().includes(searchTerm.toLowerCase())
                        );

                        // 드롭다운 내용 업데이트
                        dropdown.innerHTML = filteredNames.map(name =>
                            `<div class="dropdown-item">${name}</div>`
                        ).join('');

                        // 드롭다운 표시
                        dropdown.style.display = filteredNames.length > 0 ? 'block' : 'none';
                    },
                    error: function() {
                        // 에러 처리
                        dropdown.innerHTML = '<div class="dropdown-item">장비명을 불러올 수 없습니다.</div>';
                        dropdown.style.display = 'block';
                    }
                });
            }

            // 초기 로딩 시 한 번 호출
            fetchEquipNames();

            // 입력 이벤트 리스너
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value;
                fetchEquipNames(searchTerm);
            });

            // 드롭다운 항목 클릭 이벤트
            dropdown.addEventListener('click', function(e) {
                if (e.target.classList.contains('dropdown-item')) {
                    // 선택된 항목으로 입력창 채우기
                    searchInput.value = e.target.textContent;
                    // 드롭다운 숨기기
                    dropdown.style.display = 'none';
                }
            });

            // 문서 클릭 시 드롭다운 숨기기
            document.addEventListener('click', function(e) {
                if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
                    dropdown.style.display = 'none';
                }
            });
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
                    <span class="info-text">${majorCategory}</span>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>카테고리(중)</label>
                <div class="input-container">
                    <span class="info-text">${middleCategory}</span>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>브랜드</label>
                <div class="input-container">
                    <span class="info-text">${brand}</span>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>장비명</label>
                <div class="input-container">
                    <div class="search-container">
                        <input type="text" placeholder="장비명 검색 및 선택" class="search-input" id="equipNameSearch" name="equipName">
                        <button class="search-button">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="equipinfo-item">
                <label>신품가격</label>
                <div class="input-container price-row">
                    <input type="text" placeholder="금액 입력" class="price-input" id="priceInput" name="originalPrice">
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
            <a href="${pageContext.request.contextPath}/equipregister-brand.action?majorCategory=${majorCategory}&middleCategory=${middleCategory}" class="btn">이전</a>
            <a href="javascript:void(0)" class="btn btn-primary" onclick="submitEquipmentForm()">등록</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>