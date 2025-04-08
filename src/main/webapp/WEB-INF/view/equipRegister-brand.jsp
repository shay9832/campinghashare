<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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