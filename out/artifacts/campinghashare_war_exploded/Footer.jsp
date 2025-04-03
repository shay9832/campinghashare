<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        footer {
            bottom: 0;
            background-color: #f5f5f5;
            padding: 15px 0;
            border-top: 1px solid #e0e0e0;
            width: 100%;
            height: 60px;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 95%;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-menu {
            display: flex;
            gap: 30px;
        }

        .footer-menu a {
            font-size: 14px;
            color: #333;
            text-decoration: none;
        }

        .dropdown {
            position: relative;
        }

        .dropdown select {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            font-size: 14px;
            color: #333;
            cursor: pointer;
            min-width: 120px;
        }
    </style>
</head>
<body>
<footer>
    <div class="footer-container">
        <div class="footer-menu">
            <a href="#">캠핑하쉐어</a>
            <a href="#">공지사항</a>
            <a href="#">이벤트</a>
            <a href="#">고객센터</a>
        </div>
        <div class="dropdown">
            <select>
                <option>Dropdown</option>
                <option>옵션 1</option>
                <option>옵션 2</option>
                <option>옵션 3</option>
            </select>
        </div>
    </div>
</footer>
</body>
</html>
