<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>error.jsp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 외부 리소스 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Pretendard', sans-serif;
        }

        .error-container {
            max-width: 600px;
            margin: 100px auto;
            padding: 40px;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }

        .error-icon {
            color: #d9534f;
            font-size: 48px;
            margin-bottom: 16px;
        }

        .error-title {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 8px;
        }

        .error-message {
            font-size: 16px;
            color: #777777;
            margin-bottom: 30px;
        }

        .btn-home {
            padding: 10px 24px;
            background-color: #2c5f2d;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        .btn-home:hover {
            background-color: #1e3f1f;
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="error-container">
    <div class="error-icon">
        <i class="fa-solid fa-triangle-exclamation"></i>
    </div>
    <div class="error-title">접근이 제한되었습니다</div>
    <div class="error-message">
        <c:out value="${error != null ? error : '잘못된 접근입니다. 권한이 없거나 요청이 잘못되었습니다.'}" />
    </div>
    <a href="${pageContext.request.contextPath}/main.action" class="btn-home">메인으로 돌아가기</a>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
