<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SelectBrand</title>
    <link rel="stylesheet" href="style/selectbrand.css">
    <script>
        var selectedBrand = "";

        function selectBrand(element, brand) {
            var brandItems = document.querySelectorAll(".brand-item");
            for (var i = 0; i < brandItems.length; i++) {
                brandItems[i].classList.remove("active");
            }

            element.classList.add("active");

            selectedBrand = brand;
        }

        function goToNextStep() {
            if (selectedBrand) {
                window.location.href =
                    "register-equipment-detail.jsp?brand=" +
                    encodeURIComponent(selectedBrand);
            } else {
                alert("브랜드를 선택해주세요.");
            }
        }
    </script>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<main class="main-content">
    <h1 class="page-title">내 장비 등록</h1>

    <h2 class="brand-title">브랜드 선택</h2>
    <div class="search-container">
        <form action="" method="GET" class="search-form">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요" class="search-input">
            <button type="submit" class="search-button">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>
    </div>

    <div class="brand-grid">
        <div class="brand-item" onclick="selectBrand(this, '힐베르그(HILLEBERG)')">
            <span class="brand-item-text">힐베르그(HILLEBERG)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '엠에스알(MSR')">
            <span class="brand-item-text">엠에스알(MSR</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '노르디스크(NORDISK)')">
            <span class="brand-item-text">노르디스크(NORDISK)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '헬스포츠(HELSPORT)')">
            <span class="brand-item-text">헬스포츠(HELSPORT)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '몽벨(MONTBELL)')">
            <span class="brand-item-text">몽벨(MONTBELL)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '콜맨(COLEMAN)')">
            <span class="brand-item-text">콜맨(COLEMAN)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '스노우피크(SNOW PEAK)')">
            <span class="brand-item-text">스노우피크(SNOW PEAK)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '블랙다이아몬드(BLACK DIAMOND)')">
            <span class="brand-item-text">블랙다이아몬드(BLACK DIAMOND)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '코오롱스포츠(KOLON SPORT)')">
            <span class="brand-item-text">코오롱스포츠(KOLON SPORT)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '니모(NEMO)')">
            <span class="brand-item-text">니모(NEMO)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '씨투써밋(SEATOSUMMIT)')">
            <span class="brand-item-text">씨투써밋(SEATOSUMMIT)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '코베아(KOVEA)')">
            <span class="brand-item-text">코베아(KOVEA)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '헬리녹스(HELINOX)')">
            <span class="brand-item-text">헬리녹스(HELINOX)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '텐터(TENTER)')">
            <span class="brand-item-text">텐터(TENTER)</span>
        </div>
        <div class="brand-item" onclick="selectBrand(this, '노스피크(NORTHPEAK)')">
            <span class="brand-item-text">노스피크(NORTHPEAK)</span>
        </div>
    </div>

    <div class="nav-buttons">
        <a href="#" class="nav-button">이전</a>
        <a href="#" class="nav-button">다음</a>
    </div>
</main>


<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>
