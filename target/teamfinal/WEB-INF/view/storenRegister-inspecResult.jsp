<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 장비 정보 및 검수 결과들 저장할 변수 선언
    String equipmentCategory = "텐트/쉘터";
    String equipmentSubCategory = "텐트";
    String brand = "스노우피크";
    String equipmentName = "스노우피크 텐트 65주년 리빙 쉘 프로 이너 룸 세트 TP-653";
    String equipmentSize = "M";
    String storenId = "00000000";
    String inspectionDate = "2025.09.30";
    String equipmentGrade = "C";

    // 검수 항목별 결과 배열로 저장(코멘트, 등급, 점수)
    String[][] inspectionResults = {
            {"외관에 주름이 약간 있음", "중", "13"},
            {"텐트 하단 약간 찢어짐", "중", "13"},
            {"청결도 우수함", "상", "20"},
            {"부속품 모두 포함되어 있음", "상", "20"},
            {"지퍼가 약간 뻑뻑함", "중", "13"}
    };

    // 총점 계산
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

    <title>storenRegister-inspecResult.jsp</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

</head>
<body>

<jsp:include page="header.jsp" />

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title page-title-storen-register">스토렌 신청 (검수 결과 확인)</h1>

        <!-- 신청 정보 섹션 -->
        <div class="info-section card">
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
                        <span class="info-text"><%= equipmentCategory %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">카테고리(중)</label>
                    <div class="form-input">
                        <span class="info-text"><%= equipmentSubCategory %></span>
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
                        <span class="info-text"><%= equipmentName %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비 사이즈</label>
                    <div class="form-input">
                        <span class="info-text"><%= equipmentSize %></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 검수 결과 섹션 -->
        <div class="info-section card mt-4">
            <div class="card-header">
                <h3 class="card-title">검수 결과</h3>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">스토렌 번호</label>
                    <div class="form-input">
                        <span class="info-text"><%= storenId %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">검수일</label>
                    <div class="form-input">
                        <span class="info-text"><%= inspectionDate %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">장비 등급</label>
                    <div class="form-input">
                        <span class="grade-badge grade-<%= equipmentGrade %>"><%= equipmentGrade %></span>
                    </div>
                </div>
                <div class="form-row mt-3">
                    <label class="form-label">검수 항목별 기준 및 결과</label>
                    <div class="form-input">
                        <div class="table-responsive">
                            <table class="w-100 border-collapse">
                                <thead>
                                <tr class="bg-primary text-light">
                                    <th rowspan="2" class="p-2 text-center">검수 항목</th>
                                    <th colspan="3" class="p-2 text-center">기준</th>
                                    <th colspan="3" class="p-2 text-center">결과</th>
                                </tr>
                                <tr class="bg-primary text-light">
                                    <th class="p-2 text-center">상</th>
                                    <th class="p-2 text-center">중</th>
                                    <th class="p-2 text-center">하</th>
                                    <th class="p-2 text-center">코멘트</th>
                                    <th class="p-2 text-center">등급</th>
                                    <th class="p-2 text-center">점수</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="border-bottom">
                                    <td class="p-2 font-bold">외관 보존 상태</td>
                                    <td class="p-2">사용감 거의 없음, 신품 수준 외관</td>
                                    <td class="p-2">마모 등 경미한 사용감 있음</td>
                                    <td class="p-2">뚜렷한 사용 흔적, 외관 낡고 변색</td>
                                    <td class="p-2"><%= inspectionResults[0][0] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[0][1] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[0][2] %></td>
                                </tr>
                                <tr class="border-bottom bg-secondary">
                                    <td class="p-2 font-bold">물리적 무손상 상태</td>
                                    <td class="p-2">파손 없음</td>
                                    <td class="p-2">작은 손상 있음</td>
                                    <td class="p-2">심한 손상 있음</td>
                                    <td class="p-2"><%= inspectionResults[1][0] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[1][1] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[1][2] %></td>
                                </tr>
                                <tr class="border-bottom">
                                    <td class="p-2 font-bold">청결/세정 상태</td>
                                    <td class="p-2">오염 없음</td>
                                    <td class="p-2">약간의 오염 있음</td>
                                    <td class="p-2">심한 오염 있음</td>
                                    <td class="p-2"><%= inspectionResults[2][0] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[2][1] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[2][2] %></td>
                                </tr>
                                <tr class="border-bottom bg-secondary">
                                    <td class="p-2 font-bold">부속품 완비</td>
                                    <td class="p-2">부속품(매뉴얼 등) 모두 보유</td>
                                    <td class="p-2">일부 부속품 누락</td>
                                    <td class="p-2">필수 부속품 누락</td>
                                    <td class="p-2"><%= inspectionResults[3][0] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[3][1] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[3][2] %></td>
                                </tr>
                                <tr class="border-bottom">
                                    <td class="p-2 font-bold">기능 작동성</td>
                                    <td class="p-2">기능 모두 정상 작동</td>
                                    <td class="p-2">일부 기능 약간 미흡</td>
                                    <td class="p-2">기능 중 하나 이상 심각한 문제 있음</td>
                                    <td class="p-2"><%= inspectionResults[4][0] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[4][1] %></td>
                                    <td class="p-2 text-center"><%= inspectionResults[4][2] %></td>
                                </tr>
                                <tr class="bg-primary text-light font-bold">
                                    <td colspan="6" class="p-2 text-center">합계</td>
                                    <td class="p-2 text-center"><%= totalScore %></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- 등급별 점수 기준 -->
                        <div class="notice-area mt-4">
                            <strong>[등급 판정 기준]</strong>
                            <div class="d-flex flex-wrap gap-3 mt-2">
                                <div class="d-flex align-items-center">
                                    <span class="grade-badge grade-A mr-1">A</span>
                                    <span>100-90점</span>
                                </div>
                                <div class="d-flex align-items-center">
                                    <span class="grade-badge grade-B mr-1">B</span>
                                    <span>89-80점</span>
                                </div>
                                <div class="d-flex align-items-center">
                                    <span class="grade-badge grade-C mr-1">C</span>
                                    <span>79-70점</span>
                                </div>
                                <div class="d-flex align-items-center">
                                    <span class="grade-badge grade-D mr-1">D</span>
                                    <span>69-60점</span>
                                </div>
                                <div class="d-flex align-items-center">
                                    <span class="grade-badge grade-E mr-1">E</span>
                                    <span>59-50점</span>
                                </div>
                                <div class="d-flex align-items-center position-relative">
                                    <span class="grade-badge grade-F mr-1">F</span>
                                    <span>49점 이하 (스토렌/렌탈 이용 불가)</span>
                                    <div class="info-icon tooltip-trigger">
                                        <i class="fa-solid fa-circle-question"></i>
                                        <div class="tooltip-content">F 등급 장비의 경우, 소유자분께 즉시 반환됩니다.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 버튼 컨테이너 : 이전 / 다음 페이지 이동 -->
            <div class="button-container">
                <button class="btn">이전</button>              <!-- 일반 스타일 버튼 : 장비 목록으로 돌아가기 -->
                <button class="btn btn-primary">다음</button>  <!-- 강조 스타일 버튼 : 등록한 글 확인하기 -->
            </div>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {

        // 툴팁 이벤트 처리
        $(document).on('mouseenter', '.tooltip-trigger', function() {
            $(this).find('.tooltip-content').css({
                visibility: 'visible',
                opacity: '1'
            });
        });

        $(document).on('mouseleave', '.tooltip-trigger', function() {
            $(this).find('.tooltip-content').css({
                visibility: 'hidden',
                opacity: '0'
            });
        });
    });

</script>
</body>
</html>