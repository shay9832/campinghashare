<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>결제 정보 확인</title>
    <link rel="stylesheet" href="css/Pay_Info.css">
</head>
<body>
<div class="payment_popup">
    <!-- 결제 정보 확인 제목 -->
    <div class="pay_info_title">
        <h2>결제 정보 확인</h2>
    </div>

    <!-- 결제 정보 확인 내용 -->
    <div class="pay_info_content">
        <table class="pay_info_table">
            <tr>
                <td>상품명</td>
                <td>스토렌(보관비)</td>
            </tr>
            <tr>
                <td>최종 결제 금액</td>
                <td>270,000원</td>
            </tr>
        </table>

        <!-- 취소/확인 버튼 -->
        <div class="pay_info_check">
            <button class="btn btn-cancel">취소</button>
            <button class="btn btn-check">확인</button>
        </div>
    </div>
</div>
</body>
</html>