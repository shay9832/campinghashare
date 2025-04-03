<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 완료된 프로세스 정보를 저장할 변수
    String processName = "렌탈 글 등록";

    // 관련 메뉴명을 저장할 변수들
    String prevMenu = "내 장비 목록";
    String nextMenu = "등록한 글 보기";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>trans_process_complete</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/button.css">
    <link rel="stylesheet" href="css/completeMessage.css">
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<%--프로세스 완료 메시지 표시--%>
<div class="complete-message">
    '<%=processName%>'이 완료되었습니다.
</div>

<%-- 버튼 컨테이너 : 이전 / 다음 페이지 이동 --%>
<div class="button-container">
    <button class="btn"><%=prevMenu%></button>              <%-- 일반 스타일 버튼 : 장비 목록으로 돌아가기 --%>
    <button class="btn btn-primary"><%=nextMenu%></button>  <%-- 강조 스타일 버튼 : 등록한 글 확인하기 --%>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

</body>
</html>
