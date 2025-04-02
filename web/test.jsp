<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 25. 4. 2.
  Time: 오후 2:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #modalOpenButton, #modalCloseButton {
            cursor: pointer;
        }

        #modalContainer {
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: rgba(0, 0, 0, 0.5);
        }

        #modalContent {
            position: absolute;
            background-color: #ffffff;
            width: 300px;
            height: 150px;
            padding: 15px;
        }

        #modalContainer.hidden {
            display: none;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const modalOpenButton = document.getElementById('modalOpenButton');
            const modalCloseButton = document.getElementById('modalCloseButton');
            const modal = document.getElementById('modalContainer');

            modalOpenButton.addEventListener('click', () => {
                modal.classList.remove('hidden');
            });

            modalCloseButton.addEventListener('click', () => {
                modal.classList.add('hidden');
            });
        });
    </script>
</head>
<body>
<button id="modalOpenButton">모달창 열기</button>
<div id="modalContainer" class="hidden">
    <div id="modalContent">
        <p>호소세 화이팅</p>
        <button id="modalCloseButton">닫기</button>
    </div>
</div>
</body>
</html>
