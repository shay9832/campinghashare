<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 검수 결과 정보를 저장할 변수들
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우피크";
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";
    String storenNumber = "00000000";
    String inspectionDate = "2025.09.30";
    String equipmentGrade = "C";

    // 검수 항목별 결과 (코멘트, 등급, 점수)
    String[][] inspectionResults = {
            {"외관에 주름이 약간 있음", "중", "13"},
            {"텐트 하단 약간 찢어짐", "중", "13"},
            {"청결도 우수함", "상", "20"},
            {"부속품 모두 포함되어 있음", "상", "20"},
            {"지퍼가 약간 뻑뻑함", "중", "13"}
    };

    int totalScore = 0;
    for (String[] result : inspectionResults) {
        totalScore += Integer.parseInt(result[2]);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스토렌 신청 - 렌탈비 결제</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="css/storen_inspecResult.css">
    <style type="text/css">
        .info-value.gray {
            color: #888;
            font-size: 13px;
        }

        .info-value.red {
            color: #e53e3e;
        }

        /* 쿠폰 적용 버튼 */
        .coupon-button {
            padding: 8px 15px;
            /*background-color: #2C5F2D;*/
            border: 1px solid #2C5F2D;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
        }

        /* 결제 선택 옵션 */
        .payment-row {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }
        .payment-option {
            width:100%;
            height: 40px;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
            cursor: pointer;
        }

        /* 완료 메시지 */
        .completion-message {
            text-align: center;
            padding: 30px 0;
            color: #333;
            font-size: 15px;
        }
    </style>
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<div class="container">
    <!-- 페이지 제목 -->
    <div class="page-title">
        스토렌 신청 (렌탈비 결제)
    </div>

    <!-- 배송지 정보 섹션 -->
    <div class="info-section">
        <div class="section-title">배송지 (배송 & 수거 예정 주소)</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">받는사람</div>
                <div class="info-value">김철수</div>
                <div class="info-value gray">(※ 필요 시 '마이페이지'에서 수정 가능)</div>
            </div>
            <div class="info-row">
                <div class="info-label">휴대전화</div>
                <div class="info-value">010 - 0000 - 0000</div>
            </div>
            <div class="info-row">
                <div class="info-label">이메일</div>
                <div class="info-value">cheolsoo@example.com</div>
            </div>
            <div class="divider"></div>
            <div class="info-row">
                <div class="info-label">주소</div>
                <div class="info-value">
                    <input type="text" id="sample3_postcode" placeholder="우편번호">
                    <input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
                    <input type="text" id="sample3_address" placeholder="주소"><br>
                    <input type="text" id="sample3_detailAddress" placeholder="상세주소">
                    <input type="text" id="sample3_extraAddress" placeholder="참고항목">

                    <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
                        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
                    </div>

                    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script>
                        // 우편번호 찾기 찾기 화면을 넣을 element
                        var element_wrap = document.getElementById('wrap');

                        function foldDaumPostcode() {
                            // iframe을 넣은 element를 안보이게 한다.
                            element_wrap.style.display = 'none';
                        }

                        function sample3_execDaumPostcode() {
                            // 현재 scroll 위치를 저장해놓는다.
                            var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
                            new daum.Postcode({
                                oncomplete: function(data) {
                                    // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                                    var addr = ''; // 주소 변수
                                    var extraAddr = ''; // 참고항목 변수

                                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                        addr = data.roadAddress;
                                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
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
                                        document.getElementById("sample3_extraAddress").value = extraAddr;

                                    } else {
                                        document.getElementById("sample3_extraAddress").value = '';
                                    }

                                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                                    document.getElementById('sample3_postcode').value = data.zonecode;
                                    document.getElementById("sample3_address").value = addr;
                                    // 커서를 상세주소 필드로 이동한다.
                                    document.getElementById("sample3_detailAddress").focus();

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
                                width : '100%',
                                height : '100%'
                            }).embed(element_wrap);

                            // iframe을 넣은 element를 보이게 한다.
                            element_wrap.style.display = 'block';
                        }
                    </script>

                    <div class="short-divider"></div>
                    <div class="delivery-dropdown">
                        <select>
                            <option>배송 메시지 선택 (선택사항)<span class="dropdown-icon"></span></option>
                            <option>옵션 1</option>
                            <option>옵션 2</option>
                            <option>옵션 3</option>
                        </select>
                    </div><!-- .delivery-dropdown -->
                </div><!-- .info-value -->
            </div><!-- .info-row -->
        </div><!-- .section-content -->
    </div><!-- .info-section -->


    <!-- 신청 정보 섹션 -->
    <div class="info-section">
        <div class="section-title">신청 정보</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">장비 사진</div>
                <div class="info-value">
                    <div class="equipment-image"></div>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">카테고리(대)</div>
                <div class="info-value"><%= equipmentCategory %></div>
            </div>
            <div class="info-row">
                <div class="info-label">카테고리(중)</div>
                <div class="info-value"><%= equipmentSubCategory %></div>
            </div>
            <div class="info-row">
                <div class="info-label">브랜드</div>
                <div class="info-value"><%= brand %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비명</div>
                <div class="info-value"><%= equipmentName %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비 등급</div>
                <div class="info-value">C</div>
            </div>
            <div class="info-row">
                <div class="info-label">렌탈 기간</div>
                <div class="info-value">2025.06.04 ~ 2025.06.10 (7일)</div>
            </div>
            <div class="info-row">
                <div class="info-label">총 렌탈 비용</div>
                <div class="info-value">175,000원</div>
            </div>
        </div>
    </div>

    <!-- 할인 섹션 -->
    <div class="info-section">
        <div class="section-title">할인</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">쿠폰 할인</div>
                <div class="info-value">20,000원</div>
                <button class="btn coupon-button">쿠폰 적용</button>
            </div>
            <div class="info-row">
                <div class="info-value">보유 쿠폰 2개</div>
            </div>
        </div>
    </div>

    <!-- 결제 정보 섹션 -->
    <div class="info-section">
        <div class="section-title">결제 정보</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">주문 상품</div>
                <div class="info-value">175,000원</div>
            </div>
            <div class="info-row">
                <div class="info-label">배송비</div>
                <div class="info-value">+0원</div>
            </div>
            <div class="info-row">
                <div class="info-label">할인</div>
                <div class="info-value red">-20,000원</div>
            </div>
            <div class="info-row">
                <div class="info-label">최종 결제 금액</div>
                <div class="info-value"><strong>155,000원</strong></div>
            </div>
        </div>
    </div>

    <!-- 결제 수단 섹션 -->
    <div class="info-section">
        <div class="section-title">결제 수단</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">결제 수단 선택</div>
            </div>
            <div class="payment-row">
                <button class="btn payment-option">
                    신용카드
                </button>
                <button class="btn payment-option">
                    무통장입금
                </button>
            </div>
        </div>
    </div>

    <!-- 완료 메시지 -->
    <div class="completion-message">
        주문 내용을 확인하였습니다.
    </div>

    <!-- 버튼 영역 -->
    <div class="button-container">
        <button class="btn">이전</button>
        <button class="btn btn-primary">다음</button>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />
</body>
</html>