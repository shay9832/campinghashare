<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>equipRegister-middleCategory.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <script>
        var selectedCategory = "";

        function selectCategory(element, category) {
            // 모든 카테고리 아이템에서 active 클래스 제거
            var categoryItems = document.querySelectorAll(".category-item");
            for (var i = 0; i < categoryItems.length; i++) {
                categoryItems[i].classList.remove("active");
            }

            // 선택된 카테고리 아이템에 active 클래스 추가
            element.classList.add("active");

            // 선택된 카테고리 값 저장
            selectedCategory = category;
        }

        function goToNextStep() {
            // 카테고리가 선택되었는지 확인
            if (selectedCategory) {
                // 다음 페이지로 이동 (선택된 카테고리 파라미터 전달)
                window.location.href =
                    "equipRegister-brand.jsp?category=" +
                    encodeURIComponent(selectedCategory);
            } else {
                // 카테고리가 선택되지 않은 경우 알림
                alert("카테고리를 선택해주세요.");
            }
        }
    </script>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="header.jsp"></jsp:include>

    <main class="main-content container">
        <h1 class="page-title">내 장비 등록</h1>

        <h2 class="category-title">카테고리(중분류) 선택</h2>
        <div class="category-grid category-grid-medium">
            <div class="category-item" onclick="selectCategory(this, '텐트')">
                <span class="category-item-text">텐트</span>
            </div>
            <div class="category-item" onclick="selectCategory(this, '쉘터/타프')">
                <span class="category-item-text">쉘터/타프</span>
            </div>
            <div class="category-item" onclick="selectCategory(this, '설치용 부속품')">
                <span class="category-item-text">설치용 부속품</span>
            </div>
            <div class="category-item" onclick="selectCategory(this, '보조텐트류')">
                <span class="category-item-text">보조텐트류</span>
            </div>
            <div class="category-item" onclick="selectCategory(this, '바닥보호시트')">
                <span class="category-item-text">바닥보호시트</span>
            </div>
            <div class="category-item" onclick="selectCategory(this, '기타용품')">
                <span class="category-item-text">기타용품</span>
            </div>
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="equipRegister-majorCategory.jsp" class="btn">이전</a>
            <a href="equipRegister-brand.jsp" class="btn btn-primary" onclick="goToNextStep()">다음</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>