<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 시스템 - 브랜드/장비명 생성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-createBrand.css">
</head>

<body>
<jsp:include page="/WEB-INF/view/admin-header.jsp" />

<!-- 메인 컨테이너 -->
<div id="container">
    <!-- 좌측 메뉴 영역 -->
    <div id="leftMenu">
        <!-- 장비 관리 메뉴 -->
        <button class="menu-button">장비 관리</button>
        <div class="submenu">
            <form action="${pageContext.request.contextPath}/admin-equipList.action" method="get">
                <button type="submit" class="submenu-btn">장비 목록</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-equipStatistics.action" method="get">
                <button type="submit" class="submenu-btn">장비 통계</button>
            </form>
            <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get">
                <button type="submit" class="submenu-btn active">브랜드/장비명 생성</button>
            </form>
        </div>

        <!-- 기타 관리 메뉴들... (간결함을 위해 생략) -->
    </div>

    <!-- 콘텐츠 영역 - 실제 데이터와 컨트롤이 표시되는 부분 -->
    <div id="content">
        <!-- 콘텐츠 헤더 - 페이지 제목 -->
        <div class="content-header">
            <h2>브랜드/장비명 생성</h2>
        </div>

        <div class="coupon-form">
            <!-- 브랜드 관리 섹션 -->
            <div class="title-box">
                브랜드 관리
            </div>

            <!-- 브랜드 목록 -->
            <div style="margin-bottom: 20px; max-height: 300px; overflow-y: auto; border: 1px solid #ddd; border-radius: 5px;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                    <tr style="background-color: #f0f0f0;">
                        <th style="padding: 10px; border-bottom: 1px solid #ddd;">No</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ddd;">브랜드 ID</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ddd;">브랜드명</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ddd;">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="brand" items="${brandList}" varStatus="status">
                        <tr>
                            <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${status.count}</td>
                            <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${brand.brandId}</td>
                            <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${brand.brandName}</td>
                            <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">
                                <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get" style="display: inline-block;">
                                    <input type="hidden" name="action" value="editBrand">
                                    <input type="hidden" name="brandId" value="${brand.brandId}">
                                    <button type="submit" class="option-button">수정</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="post" style="display: inline-block;"
                                      onsubmit="return confirm('정말로 이 브랜드를 삭제하시겠습니까? 연관된 모든 장비명도 함께 삭제됩니다.');">
                                    <input type="hidden" name="formAction" value="deleteBrand">
                                    <input type="hidden" name="brandId" value="${brand.brandId}">
                                    <button type="submit" class="option-button">삭제</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get" style="display: inline-block;">
                                    <input type="hidden" name="action" value="selectBrand">
                                    <input type="hidden" name="brandId" value="${brand.brandId}">
                                    <button type="submit" class="option-button">장비명 관리</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                    <!-- 데이터가 없는 경우 -->
                    <c:if test="${empty brandList}">
                        <tr>
                            <td colspan="4" style="padding: 20px; text-align: center;">등록된 브랜드가 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <!-- 브랜드 생성/수정 폼 -->
            <div class="title-box">
                <c:choose>
                    <c:when test="${not empty brandToEdit}">브랜드 수정</c:when>
                    <c:otherwise>브랜드 생성</c:otherwise>
                </c:choose>
            </div>

            <form id="brandForm" action="${pageContext.request.contextPath}/admin-createBrand.action" method="post">
                <c:choose>
                    <c:when test="${not empty brandToEdit}">
                        <input type="hidden" name="formAction" value="updateBrand">
                        <input type="hidden" name="brandId" value="${brandToEdit.brandId}">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="formAction" value="createBrand">
                    </c:otherwise>
                </c:choose>

                <!-- 브랜드명 -->
                <div class="form-row">
                    <div class="label">브랜드명</div>
                    <div class="input-field">
                        <input type="text" name="brandName" placeholder="브랜드 이름을 입력하세요" value="${brandToEdit.brandName}" required>
                    </div>
                </div>

                <!-- 브랜드 설명 -->
                <div class="form-row">
                    <div class="label">브랜드 설명</div>
                    <div class="input-field">
                        <textarea name="brandDescription" rows="4" placeholder="브랜드에 대한 설명을 입력하세요" style="width: 100%; padding: 10px;">${brandToEdit.brandDescription}</textarea>
                    </div>
                </div>

                <!-- 버튼 그룹 -->
                <div class="button-group">
                    <c:choose>
                        <c:when test="${not empty brandToEdit}">
                            <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/admin-createBrand.action'">취소</button>
                            <button type="submit" class="button create">수정</button>
                        </c:when>
                        <c:otherwise>
                            <button type="reset" class="button">취소</button>
                            <button type="submit" class="button create">생성</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>

            <!-- 장비명 관리 섹션 - 브랜드 선택 시에만 표시 -->
            <c:if test="${not empty selectedBrand}">
                <div style="margin-top: 30px;">
                    <div class="title-box">
                        장비명 관리 - ${selectedBrand.brandName}
                    </div>

                    <!-- 장비명 목록 -->
                    <div style="margin-bottom: 20px; max-height: 300px; overflow-y: auto; border: 1px solid #ddd; border-radius: 5px;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                            <tr style="background-color: #f0f0f0;">
                                <th style="padding: 10px; border-bottom: 1px solid #ddd;">No</th>
                                <th style="padding: 10px; border-bottom: 1px solid #ddd;">장비 ID</th>
                                <th style="padding: 10px; border-bottom: 1px solid #ddd;">장비명</th>
                                <th style="padding: 10px; border-bottom: 1px solid #ddd;">카테고리</th>
                                <th style="padding: 10px; border-bottom: 1px solid #ddd;">관리</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="equipment" items="${equipmentList}" varStatus="status">
                                <tr>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${status.count}</td>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${equipment.equipmentId}</td>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${equipment.equipmentName}</td>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">${equipment.category}</td>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd; text-align: center;">
                                        <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="get" style="display: inline-block;">
                                            <input type="hidden" name="action" value="editEquipment">
                                            <input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
                                            <button type="submit" class="option-button">수정</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin-createBrand.action" method="post" style="display: inline-block;"
                                              onsubmit="return confirm('정말로 이 장비명을 삭제하시겠습니까?');">
                                            <input type="hidden" name="formAction" value="deleteEquipment">
                                            <input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
                                            <button type="submit" class="option-button">삭제</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                            <!-- 데이터가 없는 경우 -->
                            <c:if test="${empty equipmentList}">
                                <tr>
                                    <td colspan="5" style="padding: 20px; text-align: center;">등록된 장비가 없습니다.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- 장비명 생성/수정 폼 -->
                    <div class="title-box">
                        <c:choose>
                            <c:when test="${not empty equipmentToEdit}">장비명 수정</c:when>
                            <c:otherwise>장비명 생성</c:otherwise>
                        </c:choose>
                    </div>

                    <form id="equipmentForm" action="${pageContext.request.contextPath}/admin-createBrand.action" method="post">
                        <c:choose>
                            <c:when test="${not empty equipmentToEdit}">
                                <input type="hidden" name="formAction" value="updateEquipment">
                                <input type="hidden" name="equipmentId" value="${equipmentToEdit.equipmentId}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="formAction" value="createEquipment">
                            </c:otherwise>
                        </c:choose>
                        <input type="hidden" name="brandId" value="${selectedBrand.brandId}">

                        <!-- 장비명 -->
                        <div class="form-row">
                            <div class="label">장비명</div>
                            <div class="input-field">
                                <input type="text" name="equipmentName" placeholder="장비 이름을 입력하세요" value="${equipmentToEdit.equipmentName}" required>
                            </div>
                        </div>

                        <!-- 장비 설명 -->
                        <div class="form-row">
                            <div class="label">장비 설명</div>
                            <div class="input-field">
                                <textarea name="equipmentDescription" rows="4" placeholder="장비에 대한 설명을 입력하세요" style="width: 100%; padding: 10px;">${equipmentToEdit.equipmentDescription}</textarea>
                            </div>
                        </div>

                        <!-- 카테고리 -->
                        <div class="form-row">
                            <div class="label">카테고리</div>
                            <div class="input-field">
                                <select name="category" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                                    <option value="">카테고리를 선택하세요</option>
                                    <option value="CAMERA" <c:if test="${equipmentToEdit.category == 'CAMERA'}">selected</c:if>>카메라</option>
                                    <option value="LENS" <c:if test="${equipmentToEdit.category == 'LENS'}">selected</c:if>>렌즈</option>
                                    <option value="LIGHTING" <c:if test="${equipmentToEdit.category == 'LIGHTING'}">selected</c:if>>조명</option>
                                    <option value="AUDIO" <c:if test="${equipmentToEdit.category == 'AUDIO'}">selected</c:if>>오디오</option>
                                    <option value="ACCESSORY" <c:if test="${equipmentToEdit.category == 'ACCESSORY'}">selected</c:if>>액세서리</option>
                                </select>
                            </div>
                        </div>

                        <!-- 버튼 그룹 -->
                        <div class="button-group">
                            <c:choose>
                                <c:when test="${not empty equipmentToEdit}">
                                    <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/admin-createBrand.action?action=selectBrand&brandId=${selectedBrand.brandId}'">취소</button>
                                    <button type="submit" class="button create">수정</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="reset" class="button">취소</button>
                                    <button type="submit" class="button create">생성</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- 자바스크립트 - 페이지 기능 구현 -->
<script>
    // 드롭다운 메뉴 기능 구현
    // 모든 메뉴 버튼 요소 선택
    const menuButtons = document.querySelectorAll('.menu-button');

    // 각 메뉴 버튼에 클릭 이벤트 리스너 추가
    menuButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 클릭된 버튼에 활성화 클래스 토글 (추가/제거)
            this.classList.toggle('active');

            // 버튼 다음 요소(하위메뉴) 가져오기
            const submenu = this.nextElementSibling;

            // 하위메뉴 표시 상태 체크 및 변경
            if (submenu.style.maxHeight) {
                // 열려있으면 닫기
                submenu.style.maxHeight = null;
            } else {
                // 닫혀있으면 열기 (콘텐츠 높이만큼)
                submenu.style.maxHeight = submenu.scrollHeight + 'px';
            }
        });
    });

    // 페이지 로드 시 장비 관리 메뉴 열기
    window.onload = function() {
        // 첫 번째 메뉴 버튼(장비 관리) 찾기
        const equipManageBtn = document.querySelector('.menu-button');
        // 클릭 이벤트 강제 발생시키기
        equipManageBtn.click();
    };
</script>
</body>
</html>