<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>storenRegister-storage-pay.jsp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>
<jsp:include page="header.jsp" />
<main class="main-content container">
    <form id="storenForm" action="storenRegister-storage-pay-info.action" method="GET">
        <c:set var="discountAmount" value="0" />
        <c:set var="finalStorageCost" value="${storageCost - discountAmount}" />

        <input type="hidden" name="equip_code" value="${equip_code}" />
        <input type="hidden" name="equipSize" value="${equipSize}" />
        <input type="hidden" name="storageDays" value="${storageDays}" />
        <input type="hidden" name="storageCost" value="${storageCost}" />
        <input type="hidden" name="discountAmount" value="${discountAmount}" />
        <input type="hidden" name="finalStorageCost" value="${finalStorageCost}" />

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
                        <div class="form-input">
                            <c:out value="${addressInfo.userName}" default="이름 미입력" />
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">휴대 전화</label>
                        <div class="form-input">
                            <c:out value="${addressInfo.userTel}" default="번호 미입력" />
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">주소</label>
                        <div class="form-input">
                            <div class="zipcode-row">
                                <input type="text" id="postcode" class="form-control" placeholder="우편번호" value="${addressInfo.zipcode}" />
                                <button type="button" onclick="execDaumPostcode()" class="btn">우편번호 찾기</button>
                            </div>
                            <input type="text" id="address" class="form-control mt-2" placeholder="주소" value="${addressInfo.address1}" readonly />
                            <input type="text" id="detailAddress" class="form-control mt-2" placeholder="상세주소" value="${addressInfo.address2}" />
                            <input type="text" id="extraAddress" class="form-control mt-2" placeholder="참고항목" readonly />

                            <!-- 다음 주소 iframe 위치 -->
                            <div id="wrap" style="display:none; border:1px solid #000; width:100%; margin-top:10px;"></div>
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
                        <label class="form-label">카테고리(대)</label>
                        <div class="form-input">${equipInfo.majorCategory}</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">카테고리(중)</label>
                        <div class="form-input">${equipInfo.middleCategory}</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">브랜드</label>
                        <div class="form-input">${equipInfo.brand}</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">장비명</label>
                        <div class="form-input">${equipInfo.equip_name}</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">장비 사이즈</label>
                        <div class="form-input">${equipSize}</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">보관 기간</label>
                        <div class="form-input">${storageDays}개월</div>
                    </div>
                    <div class="form-row">
                        <label class="form-label">총 보관 비용</label>
                        <div class="form-input">
                            <fmt:formatNumber value="${storageCost}" type="number" groupingUsed="true" />원
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
                            <button type="button" class="btn btn-secondary">쿠폰 적용</button>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">쿠폰 할인 금액</div>
                        <div class="col-6 text-right text-coral">-<fmt:formatNumber value="${discountAmount}" type="number" groupingUsed="true" />원</div>
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
                        <div class="col-6 text-right"><fmt:formatNumber value="${storageCost}" type="number" groupingUsed="true" />원</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">배송비</div>
                        <div class="col-6 text-right">+0원</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">할인</div>
                        <div class="col-6 text-right">-<fmt:formatNumber value="${discountAmount}" type="number" groupingUsed="true" />원</div>
                    </div>
                    <hr class="my-3" />
                    <div class="row">
                        <div class="col-6 font-weight-bold">최종 결제 금액</div>
                        <div class="col-6 text-right font-weight-bold text-primary"><fmt:formatNumber value="${finalStorageCost}" type="number" groupingUsed="true" />원</div>
                    </div>
                </div>
            </div>

            <!-- 버튼 섹션 -->
            <div class="info-section card mt-4">
                <div class="card-body text-center">
                    <div class="form-check d-inline-flex align-items-center justify-content-center gap-2">
                        <input type="checkbox" class="form-check-input" id="confirm_order" name="confirm_order">
                        <label class="form-check-label mb-0" for="confirm_order">주문 내용을 확인하였습니다.</label>
                    </div>
                    <div class="button-container mt-3">
                        <a href="${pageContext.request.contextPath}/storenRegister-storage-info.action?equip_code=${equip_code}" class="btn">이전</a>
                        <button type="button" class="btn btn-primary" onclick="validateAndSubmit()">다음</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>

<jsp:include page="footer.jsp"/>

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

    document.addEventListener('DOMContentLoaded', function() {
        // 이미지 컨테이너 찾기
        const imageContainer = document.querySelector('.image-upload');
        if(imageContainer) {
            // 이미지 순서 역순으로 정렬 (마지막 올린 것이 처음으로 오게 정렬)
            [...imageContainer.children].reverse().forEach(child => imageContainer.appendChild(child));
        }
    });

    function validateAndSubmit() {
        const zipcode = document.getElementById("postcode").value.trim();
        const address1 = document.getElementById("address").value.trim();
        const address2 = document.getElementById("detailAddress").value.trim();

        if (!zipcode || !address1 || !address2) {
            alert("배송지 정보를 모두 입력해주세요.");
            return;
        }

        const form = document.getElementById("storenForm");

        // equipSize 처리
        let inputSize = form.querySelector('input[name="equipSize"]');
        let equipSize = inputSize ? inputSize.value.trim() : "";

        if (!inputSize) {
            inputSize = document.createElement("input");
            inputSize.type = "hidden";
            inputSize.name = "equipSize";
            equipSize = "${equipSize}"; // 서버 값이 있다면 보완
            inputSize.value = equipSize;
            form.appendChild(inputSize);
        }

        if (!equipSize) {
            alert("장비 사이즈를 선택해주세요.");
            return;
        }

        // 주소 필드
        let inputZip = form.querySelector('input[name="zipcode"]');
        if (!inputZip) {
            inputZip = document.createElement("input");
            inputZip.type = "hidden";
            inputZip.name = "zipcode";
            form.appendChild(inputZip);
        }

        let inputAddr1 = form.querySelector('input[name="address1"]');
        if (!inputAddr1) {
            inputAddr1 = document.createElement("input");
            inputAddr1.type = "hidden";
            inputAddr1.name = "address1";
            form.appendChild(inputAddr1);
        }

        let inputAddr2 = form.querySelector('input[name="address2"]');
        if (!inputAddr2) {
            inputAddr2 = document.createElement("input");
            inputAddr2.type = "hidden";
            inputAddr2.name = "address2";
            form.appendChild(inputAddr2);
        }

        inputZip.value = zipcode;
        inputAddr1.value = address1;
        inputAddr2.value = address2;

        form.submit();
    }
</script>

</body>
</html>