<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>storenRegister-inspecResult.jsp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
            word-wrap: break-word;
            margin-top: 10px;
        }

        th, td {
            word-break: keep-all;
            white-space: normal;
            overflow-wrap: break-word;
            padding: 10px;
            text-align: center;
        }

        /* 테이블 컬럼 너비 */
        th:nth-child(1), td:nth-child(1) {
            width: 5%; /* 항목 */
        }
        th:nth-child(2), td:nth-child(2),
        th:nth-child(3), td:nth-child(3),
        th:nth-child(4), td:nth-child(4) {
            width: 15%; /* 상, 중, 하 */
        }
        th:nth-child(5), td:nth-child(5) {
            width: 25%; /* 코멘트 */
        }
        th:nth-child(6), td:nth-child(6),
        th:nth-child(7), td:nth-child(7) {
            width: 7.5%; /* 결과, 점수 열 */
        }

        /* 검수 결과 소제목 스타일 */
        .inspection-subtitle {
            font-size: 1.1rem;
            font-weight: bold;
            margin: 20px 0 10px 0;
            background-color: #f5f5f5;
            padding: 8px;
            border-radius: 4px;
        }

        /* 등급 원형 아이콘 공통 스타일 */
        .grade-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 14px;
        }

        /* 등급별 색상 */
        .grade-A { background-color: #4CAF50; } /* 녹색 */
        .grade-B { background-color: #8BC34A; } /* 연한 녹색 */
        .grade-C { background-color: #FFC107; } /* 노란색 */
        .grade-D { background-color: #FF9800; } /* 주황색 */
        .grade-E { background-color: #FF5722; } /* 주황-빨강 */
        .grade-F { background-color: #F44336; } /* 빨강 */

        /* 등급 기준 디자인 개선 */
        .grade-criteria {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .grade-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 장비 등급 행 스타일 개선 */
        .equipment-grade-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
            margin-bottom: 12px;
        }
        .equipment-grade-label {
            font-weight: bold;
            min-width: 120px;
        }

        /* 모바일 화면일 때는 스크롤로 대체 */
        @media (max-width: 768px) {
            .table-responsive {
                overflow-x: auto;
            }

            table {
                display: block;
            }

            .grade-criteria {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<main class="main-content container">
    <div class="storen-container">
        <h1 class="page-title page-title-storen-register">스토렌 신청 (검수 결과 확인)</h1>

        <!-- 신청 정보 -->
        <div class="info-section card">
            <div class="card-header"><h3 class="card-title">신청 정보</h3></div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">장비 사진</label>
                    <div class="form-input">
                        <div class="image-upload d-flex gap-3">
                            <c:if test="${not empty equipmentImages}">
                                <c:forEach var="image" items="${equipmentImages}" varStatus="status">
                                    <div class="photo-preview">
                                        <img src="${image.attachmentPath}" alt="장비 사진 ${status.index + 1}" />
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty equipmentImages}">
                                <div class="image-placeholder"></div>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="form-row mt-3"><label class="form-label">카테고리(대)</label><div class="form-input"><span class="info-text">${equipmentCategory}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">카테고리(중)</label><div class="form-input"><span class="info-text">${equipmentSubCategory}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">브랜드</label><div class="form-input"><span class="info-text">${brand}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">장비명</label><div class="form-input"><span class="info-text">${equipmentName}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">장비 사이즈</label><div class="form-input"><span class="info-text">${equipmentSize}</span></div></div>
            </div>
        </div>

        <div class="info-section card mt-4">
            <div class="card-header"><h3 class="card-title">검수 결과</h3></div>
            <div class="card-body">
                <div class="form-row"><label class="form-label">스토렌 번호</label><div class="form-input"><span class="info-text">${storenId}</span></div></div>

                <c:forEach var="type" items="${fn:split('1차,2차', ',')}">
                    <c:choose>
                        <c:when test="${type eq '1차'}">
                            <c:set var="tableList" value="${inspectionResults1st}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="tableList" value="${inspectionResults2nd}" />
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${not empty tableList}">
                        <div class="form-row mt-3"><label class="form-label">검수일</label><div class="form-input"><span class="info-text">${tableList[0].inspectionDate}</span></div></div>

                        <div class="equipment-grade-row">
                            <div class="equipment-grade-label">장비 등급</div>
                            <div>
                                <!-- 장비 등급을 원형 아이콘으로 표시 -->
                                <div class="grade-icon grade-${tableList[0].equipmentGrade}">${tableList[0].equipmentGrade}</div>
                            </div>
                        </div>

                        <!-- 검수 결과 소제목 -->
                        <div class="inspection-subtitle">&lt;${type} 검수 결과&gt;</div>

                        <!-- 검수 항목 테이블 -->
                        <div class="table-responsive">
                            <table class="w-100 border-collapse">
                                <thead>
                                <tr class="bg-primary text-light">
                                    <th rowspan="2" class="text-center">항목</th>
                                    <th colspan="3" class="text-center">기준</th>
                                    <th colspan="3" class="text-center">결과</th>
                                </tr>
                                <tr class="bg-primary text-light">
                                    <th class="text-center">상</th>
                                    <th class="text-center">중</th>
                                    <th class="text-center">하</th>
                                    <th class="text-center">코멘트</th>
                                    <th class="text-center">등급</th>
                                    <th class="text-center">점수</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="partialSum" value="0" />
                                <c:forEach var="item" items="${tableList}" varStatus="status">
                                    <tr class="${status.index % 2 == 1 ? 'bg-secondary' : ''} border-bottom">
                                        <td class="font-bold">${item.inspecItemName}</td>
                                        <td>${item.inspecItemDescHigh}</td>
                                        <td>${item.inspecItemDescMid}</td>
                                        <td>${item.inspecItemDescLow}</td>
                                        <td>${item.inspectComment}</td>
                                        <td class="text-center">${item.inspectResult}</td>
                                        <td class="text-center">${item.inspecGradeDeduction}</td>
                                    </tr>
                                    <c:set var="partialSum" value="${partialSum + item.inspecGradeDeduction}" />
                                </c:forEach>
                                <tr class="bg-primary text-light font-bold">
                                    <td colspan="6" class="text-center">합계</td>
                                    <td class="text-center">${partialSum}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="notice-area mt-4">
            <strong>[등급 판정 기준]</strong>
            <div class="grade-criteria">
                <div class="grade-item">
                    <div class="grade-icon grade-A">A</div>
                    <span>100~90점</span>
                </div>
                <div class="grade-item">
                    <div class="grade-icon grade-B">B</div>
                    <span>89~80점</span>
                </div>
                <div class="grade-item">
                    <div class="grade-icon grade-C">C</div>
                    <span>79~70점</span>
                </div>
                <div class="grade-item">
                    <div class="grade-icon grade-D">D</div>
                    <span>69~60점</span>
                </div>
                <div class="grade-item">
                    <div class="grade-icon grade-E">E</div>
                    <span>59~50점</span>
                </div>
                <div class="grade-item">
                    <div class="grade-icon grade-F">F</div>
                    <span>49점 이하</span>
                </div>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="button-container mt-5">
            <button class="btn"
                    onclick="location.href='${pageContext.request.contextPath}/mypage-inspecList.action'">이전</button>

            <c:if test="${not empty inspectionResults1st || not empty inspectionResults2nd}">
                <c:choose>
                    <c:when test="${totalScore <= 49}">
                        <button type="button" class="btn btn-danger"
                                onclick="location.href='${pageContext.request.contextPath}/storenRegister-inspecResult-return.action?storen_id=${storenId}'">다음</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/storenRegister-rentalRegister.action?storen_id=${storenId}'">다음</button>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 이미지 컨테이너 찾기
        const imageContainer = document.querySelector('.image-upload');
        if(imageContainer) {
            // 이미지 순서 역순으로 정렬 (마지막 올린 것이 처음으로 오게 정렬)
            [...imageContainer.children].reverse().forEach(child => imageContainer.appendChild(child));
        }

        $(document).on('mouseenter', '.tooltip-trigger', function () {
            $(this).find('.tooltip-content').css({ visibility: 'visible', opacity: '1' });
        });
        $(document).on('mouseleave', '.tooltip-trigger', function () {
            $(this).find('.tooltip-content').css({ visibility: 'hidden', opacity: '0' });
        });
    });
</script>

</body>
</html>