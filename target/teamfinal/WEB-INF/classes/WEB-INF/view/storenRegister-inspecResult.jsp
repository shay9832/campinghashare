<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>스토렌 검수 결과</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* 기본 스타일 */
        .inspection-subtitle {
            font-size: 1.1rem;
            font-weight: bold;
            margin: 20px 0 10px 0;
            background-color: #f5f5f5;
            padding: 8px;
            border-radius: 4px;
        }

        /* 테이블 스타일 */
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
            border: 1px solid #ddd;
        }

        /* 테이블 컬럼 너비 */
        th:nth-child(1), td:nth-child(1) {
            width: 8%; /* 항목 */
        }
        th:nth-child(2), td:nth-child(2),
        th:nth-child(3), td:nth-child(3),
        th:nth-child(4), td:nth-child(4) {
            width: 18%; /* 상, 중, 하 */
        }
        th:nth-child(5), td:nth-child(5) {
            width: 28%; /* 코멘트 */
        }
        th:nth-child(6), td:nth-child(6),
        th:nth-child(7), td:nth-child(7) {
            width: 5%; /* 등급, 점수 열 */
        }

        .bg-primary {
            background-color: #607360;
            color: white;
        }

        .text-light {
            color: white;
        }

        .text-center {
            text-align: center;
        }

        .border-bottom {
            border-bottom: 1px solid #ddd;
        }

        .font-bold {
            font-weight: bold;
        }

        .bg-secondary {
            background-color: #f9f9f9;
        }

        /* 장비 등급 행 스타일 */
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

        /* 등급 기준 */
        .notice-area {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }

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

        /* 버튼 스타일 */
        .button-container {
            margin-top: 30px;
            text-align: center;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            margin: 0 5px;
        }

        .btn-primary {
            background-color: #2C5F2D;
            color: white;
            border: none;
        }

        .btn-danger {
            background-color: var(--color-coral);
            color: white;
            border: none;
        }

        .tooltip-icon {
            position: relative;
            cursor: pointer;
            margin-left: 6px;
            color: #999;
            font-size: 14px;
        }

        .tooltip-icon::after {
            content: attr(data-tooltip);
            position: absolute;
            top: -40px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0, 0, 0, 0.85);
            color: #fff;
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 13px;
            white-space: nowrap;
            z-index: 999;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s ease-in-out;
        }

        .tooltip-icon:hover::after {
            opacity: 1;
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

                <c:choose>
                    <c:when test="${not empty firstInspect}">
                        <div class="form-row mt-3"><label class="form-label">장비명</label><div class="form-input"><span class="info-text">${firstInspect.equipName}</span></div></div>
                        <div class="form-row mt-3"><label class="form-label">브랜드</label><div class="form-input"><span class="info-text">${firstInspect.brandName}</span></div></div>
                        <div class="form-row mt-3"><label class="form-label">신품 가격</label><div class="form-input"><span class="info-text"><fmt:formatNumber value="${firstInspect.originalPrice}" pattern="#,###"/>원</span></div></div>
                        <div class="form-row mt-3"><label class="form-label">카테고리</label><div class="form-input"><span class="info-text">${firstInspect.majorCategory} > ${firstInspect.middleCategory}</span></div></div>
                        <div class="form-row mt-3"><label class="form-label">사이즈</label><div class="form-input"><span class="info-text">${firstInspect.equipSize}</span></div></div>
                    </c:when>
                    <c:otherwise>
                        <div class="form-row mt-3"><label class="form-label">장비 정보가 없습니다.</label></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 검수 결과 -->
        <div class="info-section card mt-4">
            <div class="card-header"><h3 class="card-title">검수 결과</h3></div>
            <div class="card-body">
                <div class="form-row">
                    <label class="form-label">스토렌 번호</label>
                    <div class="form-input">
                        <span class="info-text">${param.storen_id}</span>
                    </div>
                </div>

                <!-- 1차 검수 -->
                <c:if test="${not empty firstInspect}">
                    <c:if test="${not empty firstInspect.inspectionDate}">
                        <div class="form-row mt-3">
                            <label class="form-label">검수일</label>
                            <div class="form-input">
                        <span class="info-text">
                            <fmt:formatDate value="${firstInspect.inspectionDate}" pattern="yyyy-MM-dd"/> (1차 검수 완료)
                        </span>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty firstInspect.gradeName}">
                        <div class="equipment-grade-row">
                            <div class="equipment-grade-label">장비 등급</div>
                            <div><div class="grade-icon grade-${firstInspect.gradeName}">${firstInspect.gradeName}</div></div>
                        </div>
                    </c:if>

                    <div class="inspection-subtitle">&lt;1차 검수 결과&gt;</div>
                    <c:if test="${not empty firstInspect.itemList}">
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
                                <c:set var="firstTotal" value="0"/>
                                <c:forEach var="row" items="${firstInspect.itemList}" varStatus="status">
                                    <c:set var="score" value="${20 - row.deduction}"/>
                                    <c:set var="firstTotal" value="${firstTotal + score}"/>
                                    <tr class="${status.index % 2 == 1 ? 'bg-secondary' : ''} border-bottom">
                                        <td class="font-bold">${row.itemName}</td>
                                        <td>${row.inspecItemDescHigh}</td>
                                        <td>${row.inspecItemDescMid}</td>
                                        <td>${row.inspecItemDescLow}</td>
                                        <td>${row.comment}</td>
                                        <td class="text-center">${row.gradeName}</td>
                                        <td class="text-center">${score}</td>
                                    </tr>
                                </c:forEach>
                                <tr class="bg-primary text-light font-bold">
                                    <td colspan="6" class="text-center">합계</td>
                                    <td class="text-center">${firstTotal}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </c:if>

                <!-- 2차 검수 -->
                <c:if test="${not empty secondInspect and fn:length(secondInspect.itemList) > 0}">
                    <c:if test="${not empty secondInspect.inspectionDate}">
                        <div class="form-row mt-3">
                            <label class="form-label">검수일</label>
                            <div class="form-input">
                        <span class="info-text">
                            <fmt:formatDate value="${secondInspect.inspectionDate}" pattern="yyyy-MM-dd"/> (2차 검수 완료)
                        </span>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty secondInspect.gradeName}">
                        <div class="equipment-grade-row">
                            <div class="equipment-grade-label">장비 등급</div>
                            <div><div class="grade-icon grade-${secondInspect.gradeName}">${secondInspect.gradeName}</div></div>
                        </div>
                    </c:if>

                    <div class="inspection-subtitle">&lt;2차 검수 결과&gt;</div>
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
                            <c:set var="secondTotal" value="0"/>
                            <c:forEach var="row" items="${secondInspect.itemList}" varStatus="status">
                                <c:set var="score" value="${20 - row.deduction}"/>
                                <c:set var="secondTotal" value="${secondTotal + score}"/>
                                <tr class="${status.index % 2 == 1 ? 'bg-secondary' : ''} border-bottom">
                                    <td class="font-bold">${row.itemName}</td>
                                    <td>${row.inspecItemDescHigh}</td>
                                    <td>${row.inspecItemDescMid}</td>
                                    <td>${row.inspecItemDescLow}</td>
                                    <td>${row.comment}</td>
                                    <td class="text-center">${row.gradeName}</td>
                                    <td class="text-center">${score}</td>
                                </tr>
                            </c:forEach>
                            <tr class="bg-primary text-light font-bold">
                                <td colspan="6" class="text-center">합계</td>
                                <td class="text-center">${secondTotal}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- 등급 판정 기준 -->
        <div class="notice-area mt-4">
            <strong>[등급 판정 기준]</strong>
            <div class="grade-criteria">
                <div class="grade-item"><div class="grade-icon grade-A">A</div><span>100~90점</span></div>
                <div class="grade-item"><div class="grade-icon grade-B">B</div><span>89~80점</span></div>
                <div class="grade-item"><div class="grade-icon grade-C">C</div><span>79~70점</span></div>
                <div class="grade-item"><div class="grade-icon grade-D">D</div><span>69~60점</span></div>
                <div class="grade-item"><div class="grade-icon grade-E">E</div><span>59~50점</span></div>
                <div class="grade-item"><div class="grade-icon grade-F">F</div><span>49점 이하</span>
                    <span class="tooltip-icon" data-tooltip="스토렌 신청 불가(소유자에게 반환 예정)">
                        <i class="fa-solid fa-circle-info"></i>
                    </span>
            </div>
        </div>

        <!-- 추가 설명 표시 영역 -->
        <c:if test="${equipGrade eq 'F' and hasReturnAddress eq true}">
            <p style="margin-top: 10px; color: var(--color-coral); font-weight: bold;">
                검수 결과 F등급이므로, 검수 완료일 기준 3일 내 소유자분께 반환 배송될 예정입니다.
            </p>
        </c:if>

        <div class="button-container">
            <c:choose>
                <c:when test="${isOwner}">
                    <button class="btn"
                            onclick="location.href='${pageContext.request.contextPath}/mypage-inspecList.action?id=${storen_id}'">
                        이전
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn" onclick="history.back()">이전</button>
                </c:otherwise>
            </c:choose>

            <c:if test="${isOwner}">
                <c:if test="${equipGrade eq 'F'}">
                    <button class="btn btn-danger"
                            onclick="location.href='${pageContext.request.contextPath}/storenRegister-inspecResult-return.action?storen_id=${storen_id}'">
                        다음 (반환주소 입력)
                    </button>
                </c:if>
                <c:if test="${equipGrade ne 'F'}">
                    <c:if test="${not empty storen}">
                        <c:if test="${empty storen.storenTitle or empty storen.storenContent or storen.dailyRentPrice == null}">
                            <button class="btn btn-primary"
                                    onclick="location.href='${pageContext.request.contextPath}/storenRegister-rentalRegister.action?storen_id=${storen_id}'">
                                다음 (렌탈정보 입력)
                            </button>
                        </c:if>
                    </c:if>
                </c:if>
            </c:if>
        </div>

<%--        <!-- 검수 결과 분할 -->--%>
<%--        <jsp:include page="storenRegister-inspecResult-table.jsp" />--%>

<%--        <!-- 버튼 영역 분할 -->--%>
<%--        <jsp:include page="storenRegister-inspecResult-buttons.jsp" />--%>
    </div>
</main>

<jsp:include page="footer.jsp" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imageContainer = document.querySelector('.image-upload');
        if(imageContainer) {
            [...imageContainer.children].reverse().forEach(child => imageContainer.appendChild(child));
        }
    });
</script>
</body>
</html>