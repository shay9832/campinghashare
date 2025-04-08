<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>footer.jsp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<%--footer영역--%>
<footer>
    <div class="footer-container">
        <div class="footer-menu">
            <a href="#" class="brand-name">캠핑하쉐어</a>
            <a href="#">공지사항</a>
            <a href="#">이벤트</a>
            <a href="#">고객센터</a>
        </div>
        <div class="dropdown footer-dropdown">
            <select onchange="handleDropdown(this)">
                <option selected disabled>FAMILY SITE</option>
                <option value="#">옵션 1</option>
                <option value="#">옵션 2</option>
                <option value="#">옵션 3</option>
            </select>
        </div>

        <script>
            function handleDropdown(select) {
                const url = select.value;
                if (url) location.href = url;
            }
        </script>
    </div>
</footer>
</body>
</html>