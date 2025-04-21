<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>3-search-brand.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        #equipBrandDropdown {
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
        }

        .dropdown-item:last-child {
            border-bottom: none;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        .search-container {
            position: relative;
            margin-bottom: 20px;
        }
    </style>

    <script>
        $(document).ready(function() {
            setupBrandDropdown();
        });

        var selectedBrand = "";

        // 선택된 브랜드를 selectedBrand에 저장
        function selectBrand(element, brand) {
            // 모든 브랜드 아이템에서 active 클래스 제거
            $(".brand-item").removeClass("active");

            // 선택된 브랜드 아이템에 active 클래스 추가
            if (element instanceof HTMLElement) {
                $(element).addClass("active");
            } else {
                $(element).addClass("active");
            }

            // 선택된 브랜드 값 저장
            selectedBrand = brand;
        }

        // 다음 버튼 클릭시 brand값을 다음 페이지에 전달
        function goToNextStep() {
            // 브랜드가 선택되었는지 확인
            if (selectedBrand) {
                // 다음 페이지로 이동 (선택된 브랜드 파라미터 전달)
                window.location.href =
                    "${pageContext.request.contextPath}/equipregister-newprice.action?majorCategory=" +
                    encodeURIComponent('${majorCategory}') +
                    "&middleCategory=" +
                    encodeURIComponent('${middleCategory}') +
                    "&brand=" +
                    encodeURIComponent(selectedBrand);
            } else {
                // 브랜드가 선택되지 않은 경우 알림
                alert("브랜드를 선택해주세요.");
            }
        }

        function setupBrandDropdown() {
            try {
                // 브랜드 데이터 저장 변수
                let brandData = [];

                // 브랜드 그리드에서 브랜드 데이터 수집
                $('.brand-item').each(function() {
                    brandData.push($(this).find('.brand-item-text').text());
                });

                console.log("브랜드 목록:", brandData);

                // 검색창 클릭 시 드롭다운 표시
                $(".search-input").on('click focus', function() {
                    updateDropdown($(this).val());
                    $("#equipBrandDropdown").show();
                });

                // 검색 필터링 처리
                $(".search-input").on('input', function() {
                    updateDropdown($(this).val());
                });

                // 드롭다운 항목 클릭 이벤트
                $(document).on('click', '.dropdown-item', function() {
                    const selectedBrandName = $(this).text();
                    $(".search-input").val(selectedBrandName);
                    $("#equipBrandDropdown").hide();

                    // 해당 브랜드 아이템 찾아서 선택 상태로 만들기
                    $('.brand-item').each(function() {
                        const brandText = $(this).find('.brand-item-text').text();
                        if (brandText === selectedBrandName) {
                            selectBrand(this, selectedBrandName);
                            // 해당 브랜드 아이템으로 스크롤
                            $('html, body').animate({
                                scrollTop: $(this).offset().top - 200
                            }, 500);
                        }
                    });
                });

                // 문서 클릭 시 드롭다운 숨김
                $(document).on('click', function(e) {
                    if (!$(e.target).closest('.search-container').length) {
                        $("#equipBrandDropdown").hide();
                    }
                });

                // 드롭다운 업데이트 함수
                function updateDropdown(searchTerm) {
                    searchTerm = searchTerm.toLowerCase();

                    // 검색어로 필터링
                    const filteredBrands = brandData.filter(brand =>
                        brand.toLowerCase().includes(searchTerm)
                    );

                    if (filteredBrands.length > 0) {
                        let items = '';
                        $.each(filteredBrands, function(index, brand) {
                            items += '<div class="dropdown-item">' + brand + '</div>';
                        });

                        $("#equipBrandDropdown").html(items);
                    } else {
                        $("#equipBrandDropdown").html('<div class="dropdown-item">기타</div>');
                    }

                    $("#equipBrandDropdown").show();
                }
            } catch (error) {
                console.error("setupBrandDropdown 함수 오류:", error);
            }
        }

    </script>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="header.jsp"></jsp:include>

    <main class="main-content container">
        <h1 class="page-title">내 장비 등록</h1>

        <h2 class="brand-title">브랜드 선택</h2>
        <div class="search-container">
            <form action="" method="GET" class="search-form">
                <input type="text" name="keyword" placeholder="검색어를 입력하세요" class="search-input">
                <button type="submit" class="search-button">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
                <div id="equipBrandDropdown"></div>
            </form>
        </div>

        <div class="brand-grid">
            <c:forEach var="brand" items="${brands}">
                <div class="brand-item" onclick="selectBrand(this, '${brand.brandName}')">
                    <span class="brand-item-text">${brand.brandName}</span>
                </div>
            </c:forEach>
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/equipregister-middlecategory.action?category=${majorCategory}" class="btn">이전</a>
            <a href="#" class="btn btn-primary" onclick="goToNextStep()">다음</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>