<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>4-equip-info.jsp</title>
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
        }

        .dropdown-item {
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
            border-bottom: 1px solid #f0f0f0;
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


            // 검색창 검색어 드랍다운 호출
            setupEquipNameDropdown();

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

        // 가격 비교 업데이트 함수
        <%--function updatePriceComparison() {--%>
        <%--    const inputPrice = parseInt($("#priceInput").val().replace(/,/g, '')) || 0;--%>
        <%--    const avgPrice = 2500000; // 예시 평균 가격, 실제로는 서버에서 가져와야 함--%>

        <%--    if (inputPrice > 0) {--%>
        <%--        const diff = ((inputPrice - avgPrice) / avgPrice * 100).toFixed(0);--%>
        <%--        const symbol = diff >= 0 ? "▲" : "▼";--%>
        <%--        const absDiff = Math.abs(diff);--%>

        <%--        $("#priceDiff").html(`(평균 대비 ${absDiff}%${symbol})`);--%>
        <%--        $("#priceDiff").css('color', diff >= 0 ? '#d9534f' : '#5cb85c');--%>
        <%--    }--%>
        <%--}--%>

        // 추가: setupUIBasedOnBrand 함수 빈 구현 (원래 주석 처리되어 있음)
        function setupUIBasedOnBrand() {
            // 원래 주석처리된 함수이지만, ready 함수에서 호출되므로 빈 함수로 구현
        }


        // 검색창 드랍다운 함수
        function setupEquipNameDropdown() {
            try {
                const brand = "${brand}";
                console.log("브랜드명:", brand);

                // 기존 드롭다운 요소 제거 후 새로 생성
                $("#equipNameDropdown").remove();
                $(".search-container").append('<div id="equipNameDropdown" style="display:none;"></div>');

                // 전역에서 사용할 장비명 데이터 변수
                let equipNameData = [];

                // AJAX로 장비명 데이터 가져오기
                $.ajax({
                    url: "${pageContext.request.contextPath}/listequipnamesbybrandid.action",
                    type: "GET",
                    data: { brand: brand },
                    success: function(data) {
                        console.log("받은 장비명 목록:", data);
                        equipNameData = data; // 데이터 저장

                        // 검색창 클릭 시 드롭다운 표시
                        $("#equipNameSearch").on('click focus', function() {
                            updateDropdown($(this).val());
                            $("#equipNameDropdown").show();
                        });

                        // 검색 필터링 처리
                        $("#equipNameSearch").on('input', function() {
                            updateDropdown($(this).val());
                        });

                        // 드롭다운 항목 클릭 이벤트
                        $(document).on('click', '.dropdown-item', function() {
                            $("#equipNameSearch").val($(this).text());
                            $("#equipNameDropdown").hide();
                        });

                        // 문서 클릭 시 드롭다운 숨김
                        $(document).on('click', function(e) {
                            if (!$(e.target).closest('.search-container').length) {
                                $("#equipNameDropdown").hide();
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error("장비명 요청 오류:", error);
                    }
                });

                // 드롭다운 업데이트 함수
                function updateDropdown(searchTerm) {
                    searchTerm = searchTerm.toLowerCase();

                    // 검색어로 필터링
                    const filteredNames = equipNameData.filter(name =>
                        name.toLowerCase().includes(searchTerm)
                    );

                    if (filteredNames.length > 0) {
                        let items = '';
                        $.each(filteredNames, function(index, name) {
                            items += '<div class="dropdown-item">' + name + '</div>';
                        });
                        $("#equipNameDropdown").html(items);
                    } else {
                        $("#equipNameDropdown").html('<div class="dropdown-item">기타</div>');
                    }

                    $("#equipNameDropdown").show();
                }

            } catch (error) {
                console.error("setupEquipNameDropdown 함수 오류:", error);
            }
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

            // AJAX로 폼 제출
            <%--$.ajax({--%>
            <%--    url: $("#equipmentForm").attr("action"),--%>
            <%--    type: "POST",--%>
            <%--    data: formData,--%>
            <%--    processData: false,  // FormData와 함께 사용 시 필수--%>
            <%--    contentType: false,  // FormData와 함께 사용 시 필수--%>
            <%--    success: function(response) {--%>
            <%--        // 성공 시 처리--%>
            <%--        window.location.href = "${pageContext.request.contextPath}/equipregister-complete.action";--%>
            <%--    },--%>
            <%--    error: function(xhr, status, error) {--%>
            <%--        // 에러 처리--%>
            <%--        console.error("Error:", error);--%>
            <%--        alert("파일 업로드 중 오류가 발생했습니다.");--%>
            <%--    }--%>
            <%--});--%>

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


        <form id="equipmentForm" method="POST" action="${pageContext.request.contextPath}/equipregister-complete.action" enctype="multipart/form-data">

            <input type="hidden" name="majorCategory" value="${majorCategory}" />
            <input type="hidden" name="middleCategory" value="${middleCategory}" />
            <input type="hidden" name="brand" value="${brand}" />

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
                                <input type="file" id="photoInput" name="photos" accept="image/*" multiple style="display: none;">
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
                <a href="${pageContext.request.contextPath}/equipregister-brand.action?majorCategory=${majorCategory}&middleCategory=${middleCategory}" class="btn">이전</a>
                <button type="button" class="btn btn-primary" onclick="submitEquipmentForm()">등록</button>
            </div>
        </form>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>