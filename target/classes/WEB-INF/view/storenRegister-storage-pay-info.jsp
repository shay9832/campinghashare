<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>결제 정보 확인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">

<main class="main-content container">

    <!-- 에러 메시지 출력 영역 -->
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger text-center mb-4" style="color: red; font-weight: bold;">
                ${errorMsg}
        </div>
    </c:if>

    <form action="storenRegister-storage-pay-complete.action" method="POST">
        <input type="hidden" name="equip_code" value="${equip_code}" />
        <input type="hidden" name="equipSize" value="${param.equipSize}" />
        <input type="hidden" name="storageDays" value="${storageDays}" />
        <input type="hidden" name="zipcode" value="${param.zipcode}" />
        <input type="hidden" name="address1" value="${param.address1}" />
        <input type="hidden" name="address2" value="${param.address2}" />
        <input type="hidden" name="finalStorageCost" value="${finalStorageCost}" />

        <div class="info-section card mx-auto" style="max-width: 500px;">
            <div class="card-header">
                <h3 class="card-title text-center">결제 정보 확인</h3>
            </div>

            <div class="card-body">
                <table class="w-100 mb-4">
                    <tr class="border-bottom">
                        <td class="p-3 font-medium">상품명</td>
                        <td class="p-3">스토렌(보관비)</td>
                    </tr>
                    <tr class="border-bottom">
                        <td class="p-3 font-medium">최종 결제 금액</td>
                        <td class="p-3 font-bold text-primary">
                            <fmt:formatNumber value="${finalStorageCost}" type="number" groupingUsed="true" />원
                        </td>
                    </tr>
                </table>

                <div class="button-container d-flex justify-content-center gap-3 mt-4">
                    <button type="button" class="btn" onclick="cancelPayment()">취소</button>
                    <button type="submit" class="btn btn-primary">결제 진행</button>
                </div>
            </div>
        </div>
    </form>
</main>

<script>
    function cancelPayment() {
        if(confirm("결제를 취소하시겠습니까?")) {
            window.close();
        }
    }
</script>

</body>
</html>
