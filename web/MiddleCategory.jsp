<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MiddleCategory</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/middle-category.css">
    <script>
        var selectedCategory = "";

        // 선택된 카테고리를 selectedCategory에 저장
        function selectCategory(element, category) {
            var categoryItems = document.querySelectorAll(".category-item");
            for (var i = 0; i < categoryItems.length; i++) {
                categoryItems[i].classList.remove("active");
            }

            element.classList.add("active");

            selectedCategory = category;
        }

        // 다음 버튼 클릭시 category값을 다음 페이지에 전달
        function goToNextStep() {
            if (selectedCategory) {
                window.location.href =
                    "${pageContext.request.contextPath}/selectbrand?majorCategory=" +
                    encodeURIComponent('${majorCategory}') +
                    "&middleCategory=" +
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

    <h2 class="category-title">카테고리(중분류) 선택</h2>
    <div class="category-grid">
        <div class="category-item" onclick="selectCategory(this, '텐트')">
            <span class="category-item-text">텐트</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '쉘터/타프')">
            <span class="category-item-text">쉘터/타프</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '설치용 부속품')">
            <span class="category-item-text">설치용 부속품</span>
        </div>
        <div
                class="category-item"
                onclick="selectCategory(this, '보조텐트류')"
        >
            <span class="category-item-text">보조텐트류</span>
        </div>
        <div class="category-item" onclick="selectCategory(this, '바닥보호시트')">
            <span class="category-item-text">바닥보호시트</span>
        </div>
        <div
                class="category-item"
                onclick="selectCategory(this, '기타용품')"
        >
            <span class="category-item-text">기타용품</span>
        </div>
    </div>

    <div class="nav-buttons">
        <a href="${pageContext.request.contextPath}/majorcategory" class="nav-button">이전</a>
        <a href="#" class="nav-button" onclick="goToNextStep()">다음</a>
    </div>
</main>


<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>
