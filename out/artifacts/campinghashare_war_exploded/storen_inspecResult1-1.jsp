<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 배송지 정보 저장할 변수
    String recipient = "고길동";
    String tel = "010-0000-0000";
    String zipCode = "04001";
    String address1 = "서울 마포구 월드컵북로 21";
    String address2 = "풍성빌딩 쌍용강북교육센터 0층 0강의실";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>storen_inspecResult1-1.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/button.css">
    <link rel="stylesheet" href="css/address.css">
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<div class="container">
    <div class="page-title">
        스토렌 신청 (반환 예정 주소 확인)
    </div>

    <%-- 배송지 정보 : 배송주소 기존 내용 확인 및 수정 가능 --%>
    <div class="info-section">
        <div class="section-title">배송지</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">받는사람</div>
                <div class="info-value"><%= recipient %></div>
            </div>
            <div class="info-row">
                <div class="info-label">휴대전화</div>
                <div class="info-value"><%= tel %></div>
            </div>

            <%-- 섹션 내 내용 구분선 --%>
            <div class="divider"></div>

            <div class="info-row">
                <div class="info-label">주소</div>
                <div class="info-value">
                    <div class="zipcode-row">
                        <input type="text" id="postcode" placeholder="우편번호" value="<%= zipCode %>">
                        <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
                    </div>
                    <input type="text" id="address" placeholder="주소" value="<%= address1 %>" readonly>
                    <input type="text" id="detailAddress" placeholder="상세주소" value="<%= address2 %>">
                    <input type="hidden" id="extraAddress" placeholder="참고항목">

                    <%-- 우편번호 검색 API 컨테이너 (기본 숨김) --%>
                    <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
                        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--이전 / 다음 페이지 이동 버튼(관련 메뉴명) --%>
    <div class="button-container" style="margin-top: 15px;">
        <button class="btn">이전</button>
        <button class="btn btn-primary">다음</button>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />

<%-- 아이콘 라이브러리 자바스크립트로 로드 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<!-- 다음 우편번호/주소 API 소스 코드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    // 우편번호 검색창 접기 함수
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    // 우편번호 검색 실행 함수
    function execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다. (검색창 닫은 후 위치 복원)
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {        // 주소 선택 완료 시 실행되는 콜백 함수
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = '';          // 주소 변수
                var extraAddr = '';     // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') {    // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else {                                // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;

                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;

                // 새 주소 선택한 경우, 기 입력되어있던 상세주소 필드 초기화 (※ 추가한 구문)
                document.getElementById("detailAddress").value = '';

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',     // iframe 가로 크기
            height : '100%'     // iframe 세로 크기
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다. (검색창 활성화)
        element_wrap.style.display = 'block';
    }
</script>

</body>
</html>