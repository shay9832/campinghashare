<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 완료된 프로세스 정보를 저장할 변수 (동적으로 변경 가능)
    String processName = "장비 등록";

    // 관련 메뉴명을 저장할 변수들 (메뉴 흐름에 따라 변경 가능)
    String prevMenu = "내 장비 목록";
    String nextMenu = "등록한 글 보기";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장비 등록 완료</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="header.jsp"></jsp:include>

<!-- 메인 컨텐츠 래퍼 -->
<div class="page-wrapper">
    <main class="main-content container">
        <!-- 프로세스 완료 메시지 (모듈화된 스타일 적용) -->
        <div class="complete-message">
            '<%= processName %>'이(가) 완료되었습니다.
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="button-container">
            <a href="#" class="btn"><%= prevMenu %></a>
            <a href="#" class="btn btn-primary"><%= nextMenu %></a>
        </div>
    </main>
</div>

<!-- 푸터 포함 -->
<jsp:include page="footer.jsp"></jsp:include>

<!-- 폰트 어썸 아이콘 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>