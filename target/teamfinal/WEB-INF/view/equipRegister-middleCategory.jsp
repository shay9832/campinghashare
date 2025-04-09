<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>2-middle-category.jsp</title>
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
                    "${pageContext.request.contextPath}/equipregister-brand.action?majorCategory=" +
                    encodeURIComponent('${majorCategory}') +
                    "&middleCategory=" +
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
            <c:forEach var="category" items="${middleCategory}">
                <div class="category-item" onclick="selectCategory(this, '${category.category_name}')">
                    <span class="category-item-text">${category.category_name}</span>
                </div>
            </c:forEach>
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/equipregister-majorcategory.action" class="btn">이전</a>
            <a href="#" class="btn btn-primary" onclick="goToNextStep()">다음</a>
        </div>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>