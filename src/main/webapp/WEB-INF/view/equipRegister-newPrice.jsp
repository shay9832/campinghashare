<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>equipRegister-newPrice.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        #equipNameDropdown {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 0 0 4px 4px;
            z-index: 1000;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: none;
        }

        .dropdown-item {
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dropdown-item:last-child {
            border-bottom: none;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        .search-container {
            position: relative;
        }

        .dropdown-item-price {
            color: #999;
            font-size: 0.85em;
            margin-left: 8px;
        }

    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 전역 변수로 선택된 파일들을 저장할 배열 선언
        let selectedFiles = [];

        $(document).ready(function () {
            // 브랜드 값에 따라 UI 초기 설정
            setupUIBasedOnBrand();

            // 사진 업로드 처리 - 이벤트 리스너 수정
            $("#photoInput").on('change', function () {
                console.log("File selected"); // 디버깅용 로그
                handleFileSelect(this.files);
            });

            // 장비 폼 초기화
            initializeEquipmentForm();

            // 툴팁 이벤트 처리 수정
            $(document).on('mouseenter', '.tooltip-trigger', function () {
                $(this).find('.tooltip-content').stop().fadeIn(200);
            });

            $(document).on('mouseleave', '.tooltip-trigger', function () {
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

        // 파일 선택 처리 함수
        function handleFileSelect(files) {
            console.log("Processing files:", files.length);
            // 기존 미리보기를 비우지 않음 ($('#photosContainer').empty() 제거)

            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (!file.type.match('image.*')) {
                    console.log("Skipping non-image file:", file.name);
                    continue;
                }

                // 전역 배열에 파일 추가
                selectedFiles.push(file);

                const reader = new FileReader();
                reader.onload = (function (theFile) {
                    return function (e) {
                        console.log("File loaded:", theFile.name);

                        // 미리보기 이미지 생성
                        const photoDiv = document.createElement('div');
                        photoDiv.className = 'photo-preview';
                        photoDiv.setAttribute('data-filename', theFile.name);
                        photoDiv.innerHTML = [
                            '<img class="thumb" src="', e.target.result, '" title="', theFile.name, '"/>',
                            '<button type="button" class="remove-photo" onclick="removePhoto(this)"><i class="fa-solid fa-times"></i></button>'
                        ].join('');

                        $('#photosContainer').append(photoDiv);
                    };
                })(file);

                reader.readAsDataURL(file);
            }

            // 파일 입력 필드 초기화 (다시 파일을 선택할 수 있도록)
            $("#photoInput").val('');
        }

        // 사진 제거 함수 수정
        function removePhoto(element) {
            const photoDiv = $(element).parent();
            const filename = photoDiv.attr('data-filename');

            // 전역 배열에서 해당 파일 제거
            selectedFiles = selectedFiles.filter(file => file.name !== filename);

            // 미리보기에서 제거
            photoDiv.remove();
        }

        // 추가: setupUIBasedOnBrand 함수 빈 구현 (원래 주석 처리되어 있음)
        function setupUIBasedOnBrand() {
            // 원래 주석처리된 함수이지만, ready 함수에서 호출되므로 빈 함수로 구현
        }

        /**
         * 브랜드 ID에 따라 장비명 목록을 가져와 드롭다운에 표시하는 함수
         * @param {string} brandId - 선택된 브랜드 ID
         */
        function fetchEquipNames(brandId) {
            // 기존 드롭다운 요소 초기화
            $("#equipNameDropdown").remove();
            $(".search-container").append('<div id="equipNameDropdown" style="display:none;"></div>');

            // AJAX로 장비명 목록 조회
            $.ajax({
                url: "${pageContext.request.contextPath}/listequipnamesbybrandid.action",
                type: "GET",
                data: { brand: brandId },
                success: function(data) {
                    console.log("받은 장비명 목록:", data);

                    // 데이터 로드 완료 표시
                    window.equipNameData = data;
                    window.dataLoaded = true;

                    // 검색어가 입력된 경우 필터링 적용
                    updateEquipNameDropdown($("#equipNameSearch").val());
                    $("#equipNameDropdown").show();
                },
                error: function(xhr, status, error) {
                    console.error("장비명 요청 오류:", error);
                    $("#equipNameDropdown").html('<div class="dropdown-item">장비명을 불러올 수 없습니다</div>');
                    $("#equipNameDropdown").show();
                }
            });
        }

        /**
         * 검색어에 따라 장비명 드롭다운 목록을 업데이트하는 함수
         * @param {string} searchTerm - 검색어
         */
        function updateEquipNameDropdown(searchTerm) {
            if (!window.equipNameData) {
                return;
            }

            searchTerm = searchTerm.toLowerCase();

            // 필터링 전에 데이터 구조 로깅
            console.log("필터링할 데이터:", JSON.stringify(window.equipNameData));

            let filteredItems = window.equipNameData.filter(item => {
                // 항목 데이터 로깅
                console.log("항목 데이터:", item);

                // 문자열인 경우
                if (typeof item === 'string') {
                    return item.toLowerCase().includes(searchTerm);
                }

                // 객체인 경우
                if (typeof item === 'object' && item !== null) {
                    // 객체의 키 로깅
                    console.log("객체 키:", Object.keys(item));

                    // equipName 속성 확인
                    if (item.equipName && typeof item.equipName === 'string') {
                        return item.equipName.toLowerCase().includes(searchTerm);
                    }

                    // 모든 문자열 속성 확인
                    for (const key in item) {
                        if (typeof item[key] === 'string' && item[key].toLowerCase().includes(searchTerm)) {
                            return true;
                        }
                    }
                }

                return false;
            });

            if (filteredItems.length > 0) {
                let items = '';
                $.each(filteredItems, function(index, item) {
                    let name = '';
                    let price = 0;

                    // 아이템 유형에 따라 처리
                    if (typeof item === 'string') {
                        // 문자열인 경우
                        name = item;
                        price = 0;
                    } else if (typeof item === 'object' && item !== null) {
                        // 객체인 경우
                        // 장비명을 찾는 로직 개선
                        if (item.equipName) name = item.equipName;
                        else if (item.EQUIPNAME) name = item.EQUIPNAME;
                        else if (item.equip_name) name = item.equip_name;
                        else if (item.name) name = item.name;
                        else if (item[0]) name = item[0];
                        else {
                            // 객체 내 첫 번째 문자열 속성 찾기
                            for (const key in item) {
                                if (typeof item[key] === 'string') {
                                    name = item[key];
                                    break;
                                }
                            }
                        }

                        // 여전히 이름을 찾지 못했다면 [object Object] 대신 "(이름 없음)" 표시
                        if (!name) name = "(이름 없음)";

                        // 가격 정보 찾기
                        price = (name === '기타') ? 0 : (
                            item.price || item.PRICE || item.original_price || item.ORIGINAL_PRICE || 0
                        );
                    }

                    // 중복 항목 방지를 위한 배열
                    if (!window.processedNames) window.processedNames = [];

                    // 이미 처리된 이름이면 스킵
                    if (window.processedNames.includes(name)) return;
                    window.processedNames.push(name);

                    const priceStr = (name !== '기타' && price > 0) ?
                        ' <span class="dropdown-item-price">(평균 ' + Number(price).toLocaleString() + '원)</span>' : '';

                    items += '<div class="dropdown-item" data-name="' + name + '" data-price="' + price + '">'
                        + name
                        + priceStr
                        + '</div>';
                });

                $("#equipNameDropdown").html(items);
            } else {
                $("#equipNameDropdown").html('<div class="dropdown-item" data-name="기타" data-price="0">기타</div>');
            }

            // 다음 검색을 위해 processedNames 초기화
            window.processedNames = [];
        }

        /**
         * 장비명 검색 및 드롭다운 기능 설정
         */
        function setupEquipNameSearch() {
            try {
                // 브랜드명 가져오기
                const brand = "${brand}";
                console.log("브랜드명:", brand);

                // 기존 드롭다운 요소 제거 후 새로 생성
                $("#equipNameDropdown").remove();
                $(".search-container").append('<div id="equipNameDropdown" style="display:none;"></div>');

                // 전역에서 사용할 장비명 데이터 변수
                window.equipNameData = [];
                window.dataLoaded = false;

                // 검색창 클릭 시 데이터 로드 및 드롭다운 표시
                $("#equipNameSearch").on('click focus', function() {
                    if (!window.dataLoaded) {
                        // 데이터가 로드되지 않은 경우에만 AJAX 요청
                        fetchEquipNames(brand);
                    } else {
                        // 이미 데이터가 로드된 경우 드롭다운만 표시
                        updateEquipNameDropdown($(this).val());
                        $("#equipNameDropdown").show();
                    }
                });

                // 검색 필터링 처리
                $("#equipNameSearch").on('input', function() {
                    if (window.dataLoaded) {
                        updateEquipNameDropdown($(this).val());
                        $("#equipNameDropdown").show();
                    }
                });

                // 드롭다운 항목 클릭 이벤트
                $(document).on('click', '#equipNameDropdown .dropdown-item', function() {
                    const equipName = $(this).data('name');
                    const price = $(this).data('price');

                    $("#equipNameSearch").val(equipName);

                    // 가격 입력란에 자동 입력 (0보다 큰 경우)
                    if (price && price > 0) {
                        $("#priceInput").val(Number(price).toLocaleString());
                    } else {
                        // 가격 정보가 없거나 0인 경우 입력란을 비움
                        $("#priceInput").val('');
                    }

                    $("#equipNameDropdown").hide();
                });

                // 문서 클릭 시 드롭다운 숨김
                $(document).on('click', function(e) {
                    if (!$(e.target).closest('.search-container').length) {
                        $("#equipNameDropdown").hide();
                    }
                });
            } catch (error) {
                console.error("setupEquipNameSearch 함수 오류:", error);
            }
        }

        /**
         * 페이지 로드 시 실행될 초기화 함수
         */
        function initializeEquipmentForm() {
            setupEquipNameSearch();

            // 가격 입력 필드에 숫자 포맷팅 적용
            $("#priceInput").on('input', function() {
                // 숫자만 추출
                let value = $(this).val().replace(/[^0-9]/g, '');

                // 천 단위 콤마 추가하여 표시
                if (value) {
                    $(this).val(Number(value).toLocaleString());
                }
            });
        }

        // 장비 등록 폼 제출
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

            // 선택된 파일 확인
            if (selectedFiles.length === 0) {
                alert("최소 1개 이상의 장비 사진을 등록해주세요.");
                return false;
            }

            console.log("선택된 파일 수: " + selectedFiles.length);

            // FormData 객체 생성
            const formData = new FormData(document.getElementById("equipmentForm"));

            // 기존 input[type=file] 필드에 선택된 파일들이 없으므로, 수동으로 파일 추가
            for (let i = 0; i < selectedFiles.length; i++) {
                formData.append("photos", selectedFiles[i]);
            }

            // 장비명 선택 시 동적으로 평균 신품가격 및 평균 렌탈가격 표시
            function updatePriceInfo(equipName) {
                if (!equipName || equipName === "기타") return;

                $.ajax({
                    url: "${pageContext.request.contextPath}/getAvgPricesByEquipName.action",
                    type: "GET",
                    data: { equipName: equipName },
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            const avgNewPrice = response.avgNewPrice;
                            const avgRentalPrice = response.avgRentalPrice;
                            const formattedNewPrice = response.formattedNewPrice;
                            const formattedRentalPrice = response.formattedRentalPrice;

                            // 신품가격 입력란에 평균가 표시
                            if (avgNewPrice > 0) {
                                $("#originalPrice").val(formattedNewPrice);
                                $("#avgPriceInfo").html("평균 신품 가격: " + formattedNewPrice + "원");
                                $("#avgPriceInfo").show();
                            } else {
                                $("#avgPriceInfo").hide();
                            }

                            // 평균 렌탈가격 정보 표시
                            if (avgRentalPrice > 0) {
                                $("#avgRentalInfo").html("평균 렌탈 가격: " + formattedRentalPrice + "원/일 (참고용)");
                                $("#avgRentalInfo").show();
                            } else {
                                $("#avgRentalInfo").hide();
                            }
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("가격 정보 불러오기 실패:", error);
                    }
                });
            }


            // AJAX로 폼 제출
            $.ajax({
                url: $("#equipmentForm").attr("action"),
                type: "POST",
                data: formData,
                processData: false,  // FormData와 함께 사용 시 필수
                contentType: false,  // FormData와 함께 사용 시 필수
                success: function(response) {
                    // 성공 시 처리
                    window.location.href = "${pageContext.request.contextPath}/equipregister-complete.action";
                },
                error: function(xhr, status, error) {
                    // 에러 처리
                    console.error("Error:", error);
                    alert("파일 업로드 중 오류가 발생했습니다.");
                }
            });

            // 일시적으로 AJAX 대신 직접 폼 제출
            document.getElementById("equipmentForm").submit();
            return false;
        }
    </script>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="header.jsp"></jsp:include>

    <main class="main-content container">
        <h1 class="page-title">내 장비 등록</h1>


        <form id="equipmentForm" method="POST" action="${pageContext.request.contextPath}/equipregister-complete.action"
              enctype="multipart/form-data">

            <input type="hidden" name="majorCategory" value="${majorCategory}"/>
            <input type="hidden" name="middleCategory" value="${middleCategory}"/>
            <input type="hidden" name="brand" value="${brand}"/>

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
                                <input type="file" id="photoInput" name="photos" accept="image/*" multiple
                                       style="display: none;">
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
                            <input type="text" placeholder="장비명 검색 및 선택" class="search-input" id="equipNameSearch"
                                   name="equipName">
                            <button type="button" class="search-button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                            <div id="equipNameDropdown"></div>
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
                <a href="${pageContext.request.contextPath}/equipregister-brand.action?majorCategory=${majorCategory}&middleCategory=${middleCategory}"
                   class="btn">이전</a>
                <button type="button" class="btn btn-primary" onclick="submitEquipmentForm()">등록</button>
            </div>
        </form>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>