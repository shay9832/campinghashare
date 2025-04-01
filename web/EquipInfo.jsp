<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Equip Info</title>
    <link rel="stylesheet" href="style/equipinfo.css">
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<main class="main-content">
    <h1 class="page-title">내 장비 등록</h1>

    <div class="equipinfo-container">
        <div class="equipinfo-item">
           <label>장비 사진</label>
            <div class="photo-upload">
                <button class="add-photo-btn">
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>
        </div>

        <div class="equipinfo-item">
            <label>카테고리(대)</label>
            <input type="text" readonly="readonly" value="텐트/쉘터" disabled="disabled">
        </div>

        <div class="equipinfo-item">
            <label>카테고리(중)</label>
            <input type="text" readonly="readonly" value="텐트" disabled="disabled">
        </div>

        <div class="equipinfo-item">
            <label>브랜드</label>
            <input type="text" readonly="readonly" value="스노우피크" disabled="disabled">
        </div>

        <div class="equipinfo-item">
            <label>장비명</label>
            <input type="text">
        </div>

        <div class="equipinfo-item">
            <label>신품가격</label>
            <input type="text">
        </div>
    </div>


    <div class="nav-buttons">
        <a href="#" class="nav-button">취소</a>
        <a href="#" class="nav-button">다음</a>
    </div>
</main>


<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>
