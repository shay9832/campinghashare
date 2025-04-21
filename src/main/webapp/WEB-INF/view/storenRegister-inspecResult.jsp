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
            table-layout: fixed; /* ← auto 대신 fixed */
            border-collapse: collapse;
            word-wrap: break-word;
        }

        th, td {
            word-break: keep-all;
            white-space: normal; /* ← nowrap 제거 */
            overflow-wrap: break-word;
            padding: 10px;
            text-align: center;
        }

        /* 모바일 화면일 때는 스크롤로 대체 */
        @media (max-width: 768px) {
            .table-responsive {
                overflow-x: auto;
            }

            table {
                display: block;
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

        <!-- 검수 결과: 1차 + 2차 루프 -->
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
                <div class="card-body">
                    <div class="form-row"><label class="form-label">스토렌 번호</label><div class="form-input"><span class="info-text">${storenId}</span></div></div>
                    <div class="form-row mt-3"><label class="form-label">검수일</label><div class="form-input"><span class="info-text">${tableList[0].inspectionDate}</span></div></div>
                    <div class="form-row mt-3"><label class="form-label">장비 등급</label>
                        <div class="form-input">
                            <span class="grade-badge grade-${tableList[0].equipmentGrade}">${tableList[0].equipmentGrade}</span>
                        </div>
                    </div>

                    <div class="">&lt;${type} 검수 결과&gt;</h3></div>

                    <!-- 검수 항목 테이블 -->
                    <div class="form-row mt-3">
                        <label class="form-label"></label>
                        <div class="form-input">
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
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        </div>

        <!-- 등급 기준은 마지막에 한 번만 출력 -->
        <div class="notice-area mt-4">
            <strong>[등급 판정 기준]</strong>
            <div class="d-flex flex-wrap gap-3 mt-2">
                <span class="grade-badge grade-A">A: 100-90점</span>
                <span class="grade-badge grade-B">B: 89-80점</span>
                <span class="grade-badge grade-C">C: 79-70점</span>
                <span class="grade-badge grade-D">D: 69-60점</span>
                <span class="grade-badge grade-E">E: 59-50점</span>
                <span class="grade-badge grade-F">F: 49점 이하</span>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="button-container mt-5">
            <button class="btn btn-primary"
                    onclick="location.href='${pageContext.request.contextPath}/mypage-myequip.action'">이전</button>

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

    $(function () {
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
