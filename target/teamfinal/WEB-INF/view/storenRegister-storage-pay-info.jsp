<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

String equipName = request.getParameter("equipName");
String finalPayment = request.getParameter("finalPayment");




%>
<html>
<head>
    <title>결제 정보 확인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="info-section card mx-auto" style="max-width: 500px;">
        <div class="card-header">
            <h3 class="card-title text-center">결제 정보 확인</h3>
        </div>

        <div class="card-body">
            <!-- 결제 정보 테이블 -->
            <table class="w-100 mb-4">
                <tr class="border-bottom">
                    <td class="p-3 font-medium">상품명</td>
                    <td class="p-3">${equipName}</td>
                </tr>
                <tr class="border-bottom">
                    <td class="p-3 font-medium">최종 결제 금액</td>
                    <td class="p-3 font-bold text-primary">${finalPayment}원</td>
                </tr>
            </table>

            <!-- 버튼 영역 -->
            <div class="button-container d-flex justify-content-center gap-3 mt-4">
                <button class="btn" onclick="cancelPayment()">취소</button>
                <button class="btn btn-primary" onclick="confirmPayment()">확인</button>
            </div>


            <input type="hidden" name="finalPayment" value="<%= finalPayment %>">
            <input type="hidden" name="equipName" value="<%= equipName %>">
        </div>
    </div>
</div>

<script>
    // 취소 버튼 클릭 시 호출되는 함수
    function cancelPayment() {
        if(confirm("결제를 취소하시겠습니까?")) {
            window.close();
        }
    }

    // 확인 버튼 클릭 시 호출되는 함수
    function confirmPayment() {
        // 부모 창에 확인 메시지 전달 후 창 닫기
        if(window.opener && !window.opener.closed) {
            try {
                // 부모 창의 결제 진행 함수 호출
                window.opener.proceedPayment();
                alert("결제가 진행됩니다.");
                window.close();
            } catch (e) {
                console.error("부모 창과의 통신 중 오류 발생:", e);
                alert("결제가 진행됩니다.");
                window.close();
            }
        } else {
            alert("결제가 진행됩니다.");
            window.close();
        }
    }
</script>
</body>
</html>