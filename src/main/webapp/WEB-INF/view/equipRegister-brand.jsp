<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>3-search-brand.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <script>
        var selectedBrand = "";

        // 선택된 브랜드를 selectedBrand에 저장
        function selectBrand(element, brand) {
            // 모든 브랜드 아이템에서 active 클래스 제거
            var brandItems = document.querySelectorAll(".brand-item");
            for (var i = 0; i < brandItems.length; i++) {
                brandItems[i].classList.remove("active");
            }

            // 선택된 브랜드 아이템에 active 클래스 추가
            element.classList.add("active");

            // 선택된 브랜드 값 저장
            selectedBrand = brand;
        }

        // 다음 버튼 클릭시 brand값을 다음 페이지에 전달
        function goToNextStep() {
            // 브랜드가 선택되었는지 확인
            if (selectedBrand) {
                // 다음 페이지로 이동 (선택된 브랜드 파라미터 전달)
                window.location.href =
                    "equipregister-newprice.action?brand=" +
                    encodeURIComponent(selectedBrand);
            } else {
                // 브랜드가 선택되지 않은 경우 알림
                alert("브랜드를 선택해주세요.");
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
                <input type="text" id="search-input" class="search-input" name="keyword" placeholder="브랜드명을 입력하세요">
                <button type="submit" id="search-btn" class="search-icon-button">
                    <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                </button>
            </form>
        </div>

        <div class="brand-grid">
            <div class="brand-item" onclick="selectBrand(this, '힐베르그(HILLEBERG)')">
                <span class="brand-item-text">힐베르그(HILLEBERG)</span>
            </div>
            <div class="brand-item" onclick="selectBrand(this, '엠에스알(MSR)')">
                <span class="brand-item-text">엠에스알(MSR)</span>
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

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="equipregister-middlecategory.action" class="btn">이전</a>
            <a href="equipregister-newprice.action" class="btn btn-primary">다음</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>