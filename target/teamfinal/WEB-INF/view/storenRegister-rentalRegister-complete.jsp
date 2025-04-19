<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 완료된 프로세스 정보를 저장할 변수
    String processName = "렌탈 글 등록";

    // 관련 메뉴명을 저장할 변수들
    String prevMenu = "메인으로";
    String nextMenu = "내가 소유한 장비";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>렌탈 글 등록 완료</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<jsp:include page="header.jsp"/>

<main class="main-content container">
    <div class="complete-message">
        '<%=processName%>'이(가) 완료되었습니다.
    </div>

    <div class="button-container">
        <button class="btn" onclick="location.href='${pageContext.request.contextPath}/main.action'"><%=prevMenu%></button>
        <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/mypage-myequip.action'"><%=nextMenu%></button>
    </div>
</main>

<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>