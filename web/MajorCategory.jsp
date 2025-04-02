<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MajorCategory</title>
    <link rel="stylesheet" href="style/major-category.css">
    <script>
        var selectedCategory = "";

        function selectCategory(element, category) {
            var categoryItems = document.querySelectorAll(".category-item");
            for (var i = 0; i < categoryItems.length; i++) {
                categoryItems[i].classList.remove("active");
            }

            element.classList.add("active");

            selectedCategory = category;
        }

        function goToNextStep() {
            if (selectedCategory) {
                window.location.href =
                    "MiddleCategory.jsp?category=" +
                    encodeURIComponent(selectedCategory);
            } else {
                alert("카테고리를 선택해주세요.");
            }
        }
    </script>

</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<main class="main-content">
    <h1 class="page-title">내 장비 등록</h1>

    <h2 class="category-title">카테고리(대분류) 선택</h2>
    <div class="category-grid">
        <div class="category-item" onclick="selectCategory(this, '텐트/쉘터')">
            <i class="fa-solid fa-campground"></i>
            <span class="category-item-text">텐트/쉘터</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '취침용품')">
            <i class="fa-solid fa-bed"></i>
            <span class="category-item-text">취침용품</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '캠핑가구')">
            <i class="fa-solid fa-chair"></i>
            <span class="category-item-text">캠핑가구</span>
        </div>
        <div
                class="category-item"
                onclick="selectCategory(this, '조명/전력장비')"
        >
            <i class="fa-solid fa-lightbulb"></i>
            <span class="category-item-text">조명/전력장비</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '조리장비')">
            <i class="fa-solid fa-utensils"></i>
            <span class="category-item-text">조리장비</span>
        </div>
        <div
                class="category-item"
                onclick="selectCategory(this, '냉/난방장비')"
        >
            <i class="fa-solid fa-fan"></i>
            <span class="category-item-text">냉/난방장비</span>
        </div>
        <div
                class="category-item"
                onclick="selectCategory(this, '수납/운반용품')"
        >
            <i class="fa-solid fa-box"></i>
            <span class="category-item-text">수납/운반용품</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '기타장비')">
            <i class="fa-solid fa-tools"></i>
            <span class="category-item-text">기타장비</span>
        </div>
    </div>

    <div class="nav-buttons">
        <a href="#" class="nav-button">메인으로 돌아가기</a>
        <a href="#" class="nav-button" onclick="goToNextStep()">다음</a>
    </div>
</main>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>
