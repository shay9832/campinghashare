<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.team.mvc.DTO.InspecResultDTO" %>
<%
    DecimalFormat formatter = new DecimalFormat("#,###");

    // 1차 검수 객체 받아오기
    com.team.mvc.DTO.InspecResultDTO firstInspect =
            (com.team.mvc.DTO.InspecResultDTO) request.getAttribute("firstInspect");

    // 2차 검수 객체 받아오기
    com.team.mvc.DTO.InspecResultDTO secondInspect =
            (com.team.mvc.DTO.InspecResultDTO) request.getAttribute("secondInspect");
%>

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
            padding: 10px;
            border-radius: 0;
        }

        /* 검수 테이블 스타일 */
        .inspection-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .inspection-table th,
        .inspection-table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .inspection-table th {
            background-color: #607360;
            color: white;
            font-weight: normal;
        }

        .inspection-table th.category-header {
            background-color: #757b75;
        }

        .inspection-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .inspection-table tbody tr:hover {
            background-color: #f0f0f0;
        }

        .inspection-table tfoot td {
            background-color: #607360;
            color: white;
            font-weight: bold;
        }

        .inspection-table .score-cell {
            background-color: #d6c9a3;
        }

        /* 장비 정보 테이블 */
        .equip-info-table {
            width: 100%;
            margin-bottom: 20px;
        }

        .equip-info-table th {
            width: 20%;
            text-align: left;
            padding: 10px;
            background-color: #f5f5f5;
        }

        .equip-info-table td {
            width: 80%;
            text-align: left;
            padding: 10px;
        }

        /* 등급 기준 */
        .grade-info {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }

        .grade-info ul {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            list-style-type: none;
            padding-left: 0;
            margin-top: 10px;
        }

        .grade-info li {
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
            background-color: #dc3545;
            color: white;
            border: none;
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
                <div class="form-row mt-3"><label class="form-label">장비명</label><div class="form-input"><span class="info-text">${firstInspect.equipName}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">브랜드</label><div class="form-input"><span class="info-text">${firstInspect.brandName}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">신품 가격</label><div class="form-input"><span class="info-text"><%= formatter.format(firstInspect.getOriginalPrice()) %>원</span></div></div>
                <div class="form-row mt-3"><label class="form-label">카테고리</label><div class="form-input"><span class="info-text">${firstInspect.majorCategory} > ${firstInspect.middleCategory}</span></div></div>
                <div class="form-row mt-3"><label class="form-label">사이즈</label><div class="form-input"><span class="info-text">${firstInspect.equipSize}</span></div></div>
            </div>
        </div>

        <!-- 검수 결과 -->
        <div class="info-section card mt-4">
            <div class="card-header"><h3 class="card-title">검수 결과</h3></div>
            <div class="card-body">
                <div class="form-row"><label class="form-label">스토렌 번호</label><div class="form-input"><span class="info-text">${param.storen_id}</span></div></div>

                <!-- 1차 검수 -->
                <c:if test="${not empty firstInspect}">
                    <!-- 1차 검수 날짜 -->
                    <div class="form-row mt-3">
                        <label class="form-label">검수일</label>
                        <div class="form-input">
                            <span class="info-text">
                                <fmt:formatDate value="${firstInspect.inspectionDate}" pattern="yyyy-MM-dd"/> (1차 검수 완료)
                            </span>
                        </div>
                    </div>

                    <!-- 검수 결과 소제목 -->
                    <div class="inspection-subtitle">&lt;1차 검수 결과&gt;</div>

                    <!-- 검수 항목 테이블 -->
                    <table class="inspection-table">
                        <thead>
                        <tr>
                            <th rowspan="2">항목</th>
                            <th colspan="3" class="category-header">기준</th>
                            <th colspan="3" class="category-header">결과</th>
                        </tr>
                        <tr>
                            <th class="category-header">상</th>
                            <th class="category-header">중</th>
                            <th class="category-header">하</th>
                            <th class="category-header">코멘트</th>
                            <th class="category-header">등급</th>
                            <th class="category-header">점수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="firstTotal" value="0"/>
                        <c:forEach var="row" items="${firstInspect.itemList}" varStatus="status">
                            <c:set var="score" value="${20 - row.deduction}"/>
                            <c:set var="firstTotal" value="${firstTotal + score}"/>
                            <tr>
                                <td>${row.itemName}</td>
                                <td>${row.inspecItemDescHigh}</td>
                                <td>${row.inspecItemDescMid}</td>
                                <td>${row.inspecItemDescLow}</td>
                                <td>${row.comment}</td>
                                <td>${row.gradeName}</td>
                                <td class="score-cell">${score}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="6">합계</td>
                            <td class="score-cell">${firstTotal}</td>
                        </tr>
                        </tfoot>
                    </table>
                </c:if>

                <!-- 2차 검수 -->
                <c:if test="${not empty secondInspect}">
                    <!-- 2차 검수 날짜 -->
                    <div class="form-row mt-3">
                        <label class="form-label">검수일</label>
                        <div class="form-input">
                            <span class="info-text">
                                <fmt:formatDate value="${secondInspect.inspectionDate}" pattern="yyyy-MM-dd"/> (2차 검수 완료)
                            </span>
                        </div>
                    </div>

                    <!-- 검수 결과 소제목 -->
                    <div class="inspection-subtitle">&lt;2차 검수 결과&gt;</div>

                    <!-- 검수 항목 테이블 -->
                    <table class="inspection-table">
                        <thead>
                        <tr>
                            <th rowspan="2">항목</th>
                            <th colspan="3" class="category-header">기준</th>
                            <th colspan="3" class="category-header">결과</th>
                        </tr>
                        <tr>
                            <th class="category-header">상</th>
                            <th class="category-header">중</th>
                            <th class="category-header">하</th>
                            <th class="category-header">코멘트</th>
                            <th class="category-header">등급</th>
                            <th class="category-header">점수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="secondTotal" value="0"/>
                        <c:forEach var="row" items="${secondInspect.itemList}" varStatus="status">
                            <c:set var="score" value="${20 - row.deduction}"/>
                            <c:set var="secondTotal" value="${secondTotal + score}"/>
                            <tr>
                                <td>${row.itemName}</td>
                                <td>${row.inspecItemDescHigh}</td>
                                <td>${row.inspecItemDescMid}</td>
                                <td>${row.inspecItemDescLow}</td>
                                <td>${row.comment}</td>
                                <td>${row.gradeName}</td>
                                <td class="score-cell">${score}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="6">합계</td>
                            <td class="score-cell">${secondTotal}</td>
                        </tr>
                        </tfoot>
                    </table>
                </c:if>
            </div>
        </div>

        <!-- 등급 기준 안내 -->
        <div class="grade-info">
            <p><strong>※ 등급 기준</strong></p>
            <ul>
                <li>A: 90~100점</li>
                <li>B: 80~89점</li>
                <li>C: 70~79점</li>
                <li>D: 60~69점</li>
                <li>E: 50~59점</li>
                <li>F: 49점 이하 (등록 불가)</li>
            </ul>
        </div>

        <!-- 버튼 영역 -->
        <div class="button-container">
            <button class="btn" onclick="location.href='${pageContext.request.contextPath}/mypage-inspecList.action'">이전</button>

            <c:if test="${not empty firstInspect}">
                <c:choose>
                    <c:when test="${secondInspect.gradeName == 'F' || (empty secondInspect && firstInspect.gradeName == 'F')}">
                        <button type="button" class="btn btn-danger"
                                onclick="location.href='${pageContext.request.contextPath}/storenRegister-inspecResult-return.action?storen_id=${param.storen_id}'">다음 (강제반환)</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/storenRegister-rentalRegister.action?storen_id=${param.storen_id}'">다음 (렌탈정보입력)</button>
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
    });
</script>

</body>
</html>