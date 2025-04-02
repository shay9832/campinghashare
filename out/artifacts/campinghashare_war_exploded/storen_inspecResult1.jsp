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
    <title>검수 결과 확인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="css/storen_inspecResult.css">
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="Header.jsp" />

<div class="container">
    <div class="page-title">
        스토렌 신청 (검수결과 확인)
    </div>

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
                <div class="info-label">장비 사이즈</div>
                <div class="info-value"><%= equipmentSize %></div>
            </div>
        </div>
    </div>

    <div class="info-section">
        <div class="section-title">검수 결과</div>
        <div class="section-content">
            <div class="info-row">
                <div class="info-label">스토렌 번호</div>
                <div class="info-value"><%= storenNumber %></div>
            </div>
            <div class="info-row">
                <div class="info-label">검수일</div>
                <div class="info-value"><%= inspectionDate %></div>
            </div>
            <div class="info-row">
                <div class="info-label">장비 등급</div>
                <div class="info-value">
                    <span class="grade-value grade-<%= equipmentGrade %>"><%= equipmentGrade %></span>
                </div>
            </div>
            <div class="info-row" style="white-space: nowrap;">
                <div class="info-label">검수 항목별 기준 및 결과</div>
            </div>

            <table class="result-table">
                <colgroup>
                    <col style="width: 15%">
                    <col style="width: 19%">
                    <col style="width: 19%">
                    <col style="width: 19%">
                    <col style="width: 19%">
                    <col style="width: 80px">
                    <col style="width: 80px">
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="item-col">검수항목</th>
                    <th colspan="3">검수 기준</th>
                    <th colspan="3">검수 결과</th>
                </tr>
                <tr>
                    <th class="criteria-col">상</th>
                    <th class="criteria-col">중</th>
                    <th class="criteria-col">하</th>
                    <th class="comment-col">코멘트</th>
                    <th class="grade-col">등급</th>
                    <th class="score-col">점수</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td data-label="검수항목">외관 보존 상태</td>
                    <td data-label="상">사용감 거의 없음, 신품 수준 외관</td>
                    <td data-label="중">마모 등 경미한 사용감 있음</td>
                    <td data-label="하">뚜렷한 사용 흔적, 외관 낡고 변색</td>
                    <td data-label="코멘트"><%= inspectionResults[0][0] %></td>
                    <td data-label="등급" class="grade-col"><%= inspectionResults[0][1] %></td>
                    <td data-label="점수" class="score-col"><%= inspectionResults[0][2] %></td>
                </tr>
                <tr>
                    <td data-label="검수항목">물리적 무손상 상태</td>
                    <td data-label="상">파손 없음</td>
                    <td data-label="중">작은 손상 있음</td>
                    <td data-label="하">심한 손상 있음</td>
                    <td data-label="코멘트"><%= inspectionResults[1][0] %></td>
                    <td data-label="등급" class="grade-col"><%= inspectionResults[1][1] %></td>
                    <td data-label="점수" class="score-col"><%= inspectionResults[1][2] %></td>
                </tr>
                <tr>
                    <td data-label="검수항목">청결/세정 상태</td>
                    <td data-label="상">오염 없음</td>
                    <td data-label="중">약간의 오염 있음</td>
                    <td data-label="하">심한 오염 있음</td>
                    <td data-label="코멘트"><%= inspectionResults[2][0] %></td>
                    <td data-label="등급" class="grade-col"><%= inspectionResults[2][1] %></td>
                    <td data-label="점수" class="score-col"><%= inspectionResults[2][2] %></td>
                </tr>
                <tr>
                    <td data-label="검수항목">부속품 완비</td>
                    <td data-label="상">부속품(매뉴얼 등) 모두 보유</td>
                    <td data-label="중">일부 부속품 누락</td>
                    <td data-label="하">필수 부속품 누락</td>
                    <td data-label="코멘트"><%= inspectionResults[3][0] %></td>
                    <td data-label="등급" class="grade-col"><%= inspectionResults[3][1] %></td>
                    <td data-label="점수" class="score-col"><%= inspectionResults[3][2] %></td>
                </tr>
                <tr>
                    <td data-label="검수항목">기능 작동성</td>
                    <td data-label="상">기능 모두 정상 작동</td>
                    <td data-label="중">일부 기능 약간 미흡</td>
                    <td data-label="하">기능 중 하나 이상 심각한 문제 있음</td>
                    <td data-label="코멘트"><%= inspectionResults[4][0] %></td>
                    <td data-label="등급" class="grade-col"><%= inspectionResults[4][1] %></td>
                    <td data-label="점수" class="score-col"><%= inspectionResults[4][2] %></td>
                </tr>
                <tr class="total-row">
                    <td colspan="6" data-label="합계" style="text-align: center; font-weight: bold;">합계</td>
                    <td data-label="총점"><%= totalScore %></td>
                </tr>
                </tbody>
            </table>

            <div class="grade-info">
                <b>[등급 판정 기준]</b>
                <p>- <span class="grade-indicator grade-A">A</span> : 100-90점</p>
                <p>- <span class="grade-indicator grade-B">B</span> : 89-80점</p>
                <p>- <span class="grade-indicator grade-C">C</span> : 79-70점</p>
                <p>- <span class="grade-indicator grade-D">D</span> : 69-60점</p>
                <p>- <span class="grade-indicator grade-E">E</span> : 59-50점</p>
                <p>- <span class="grade-indicator grade-F">F</span> : 49점 이하 (스토렌/렌탈 이용 불가)
                    <span class="help-icon" id="f-grade-help">?
                        <span class="help-tooltip">F 등급 장비의 경우, 소유자분께 즉시 반환됩니다.</span>
                    </span>
                </p>
            </div>
        </div>
    </div>

    <div class="button-container">
        <button class="btn">이전</button>
        <button class="btn btn-primary">다음</button>
    </div>
</div>

<!-- 푸터 포함 -->
<jsp:include page="Footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 도움말 아이콘 기능
        const helpIcons = document.querySelectorAll('.help-icon');
        helpIcons.forEach(function(icon) {
            icon.addEventListener('click', function(e) {
                e.preventDefault();
                const tooltip = this.querySelector('.help-tooltip');
                if (tooltip) {
                    if (tooltip.style.display === 'block') {
                        tooltip.style.display = 'none';
                    } else {
                        tooltip.style.display = 'block';
                    }
                }
            });
        });
    });
</script>
</body>
</html>