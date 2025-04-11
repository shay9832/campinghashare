<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 배송지 정보 저장할 변수
    String recipient = "고길동";
    String tel = "010-0000-0000";
    String zipCode = "04001";
    String address1 = "서울 마포구 월드컵북로 21";
    String address2 = "풍성빌딩 쌍용강북교육센터 0층 0강의실";

    // 장비 정보를 저장할 변수
    String categoryMain = "텐트/쉘터";
    String categorySub = "텐트";
    String brand = "스노우피크";
    String equipName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipSize = "M";

    // 보관 정보 저장
    String storagePeriod = "3개월";
    int storageCost = 90000;
    int discountAmount = 20000;
    int finalPayment = storageCost - discountAmount;

    // 천 단위 콤마 형식 지정
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
%>
<html>
<head>
    <title>storenRegister-storage-pay.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<jsp:include page="WEB-INF/view/header.jsp"/>

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title page-title-storen-register">스토렌 신청(보관비 결제)</h1>

        <!-- 배송지 정보 섹션 -->
        <div class="info-section card">
            <div class="card-header">
                <h3 class="card-title">배송 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">받는 사람</label>
                    <div class="form-input"><%=recipient%></div>
                </div>
                <div class="form-row">
                    <label class="form-label">휴대 전화</label>
                    <div class="form-input"><%=tel%></div>
                </div>
                <div class="form-row">
                    <label class="form-label">주소</label>
                    <div class="form-input">
                        <div class="zipcode-row">
                            <input type="text" id="postcode" class="form-control" placeholder="우편번호" value="<%= zipCode %>">
                            <button onclick="execDaumPostcode()" class="btn">우편번호 찾기</button>
                        </div>
                        <input type="text" id="address" class="form-control mt-2" placeholder="주소" value="<%= address1 %>" readonly>
                        <input type="text" id="detailAddress" class="form-control mt-2" placeholder="상세주소" value="<%= address2 %>">

                        <!-- 우편번호 검색 API 컨테이너 (기본 숨김) -->
                        <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
                            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- 신청 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">신청 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">장비 사진</label>
                    <div class="form-input">
                        <div class="image-upload d-flex gap-3">
                            <div class="image-placeholder"></div>
                            <div class="image-placeholder"></div>
                        </div>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">카테고리(대)</label>
                    <div class="form-input">
                        <span class="info-text"><%= categoryMain %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">카테고리(중)</label>
                    <div class="form-input">
                        <span class="info-text"><%= categorySub %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">브랜드</label>
                    <div class="form-input">
                        <span class="info-text"><%= brand %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비명</label>
                    <div class="form-input">
                        <span class="info-text"><%= equipName %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비 사이즈</label>
                    <div class="form-input">
                        <span class="info-text"><%= equipSize %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">보관 기간</label>
                    <div class="form-input">
                        <span class="info-text"><%= storagePeriod %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">총 보관 비용</label>
                    <div class="form-input">
                        <span class="info-text"><%= formatter.format(storageCost) %>원</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 할인 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">할인</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">보유 쿠폰</label>
                    <div style="margin-left: auto; display: flex; align-items: center; gap: 10px;">
                        <div>3장</div>
                        <button class="btn btn-secondary">쿠폰 적용</button>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">쿠폰 할인 금액</div>
                    <div class="col-6 text-right text-coral">-<%= formatter.format(discountAmount) %>원</div>
                </div>
            </div>
        </div>

        <!-- 결제 정보 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">결제 정보</h3>
            </div>
            <div class="card-body">
                <div class="row mb-2">
                    <div class="col-6">주문상품</div>
                    <div class="col-6 text-right"><%= formatter.format(storageCost) %>원</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">배송비</div>
                    <div class="col-6 text-right">+0원</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">할인</div>
                    <div class="col-6 text-right text-coral">-<%= formatter.format(discountAmount) %>원</div>
                </div>
                <hr class="my-3">
                <div class="row">
                    <div class="col-6 font-weight-bold">최종 결제 금액</div>
                    <div class="col-6 text-right font-weight-bold text-primary"><%= formatter.format(finalPayment) %>원</div>
                </div>
            </div>
        </div>

        <!-- 결제 수단 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">결제 수단</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">결제수단 선택</label>
                    <div class="form-input">
                        <div class="form-check form-check-inline">
                            <input type="radio" class="form-check-input" name="payment_method" id="credit_card" value="credit_card" checked>
                            <label class="form-check-label" for="credit_card">신용카드</label>
                        </div>
                        <div class="form-check form-check-inline ml-3">
                            <input type="radio" class="form-check-input" name="payment_method" id="bank_transfer" value="bank_transfer">
                            <label class="form-check-label" for="bank_transfer">무통장 입금</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 주문 확인 및 버튼 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-body">
                <div class="form-check text-center mb-4">
                    <input type="checkbox" class="form-check-input" name="confirm_order" id="confirm_order">
                    <label class="form-check-label" for="confirm_order">주문 내용을 확인하였습니다.</label>
                </div>
                <!-- 버튼 컨테이너 -->
                <div class="button-container">
                    <a href="#" class="btn">이전</a>
                    <a href="#" class="btn btn-primary">다음</a>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="WEB-INF/view/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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