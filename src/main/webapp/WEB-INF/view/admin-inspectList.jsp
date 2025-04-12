<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
  <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
  <title>관리자 시스템 - 검수 목록</title> <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-inspectList.css">
</head>

<body>
<!-- 헤더 영역 - 페이지 상단 타이틀 -->
<div id="header">
  <h1>관리자 시스템</h1>
</div>

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
    </div>

    <!-- 검수 관리 메뉴 -->
    <button class="menu-button">검수 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-inspectList.action" method="get">
        <button type="submit" class="submenu-btn">검수 관리</button>
      </form>
    </div>

    <!-- 매칭 관리 메뉴 -->
    <button class="menu-button">매칭 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-matchingList.action" method="get">
        <button type="submit" class="submenu-btn">매칭 관리</button>
      </form>
    </div>

    <!-- 결제 관리 메뉴 -->
    <button class="menu-button">결제 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-payUpdate.action" method="get">
        <button type="submit" class="submenu-btn">결제 관리</button>
      </form>
    </div>

    <!-- 배송 관리 메뉴 -->
    <button class="menu-button">배송 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-deliveryUpdate.action" method="get">
        <button type="submit" class="submenu-btn">배송 관리</button>
      </form>
    </div>

    <!-- 게시판 관리 메뉴 -->
    <button class="menu-button">게시판 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-boardUpdate.action" method="get">
        <button type="submit" class="submenu-btn">게시물 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-replyUpdate.action" method="get">
        <button type="submit" class="submenu-btn">댓글 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-communityStatistics.action" method="get">
        <button type="submit" class="submenu-btn">커뮤니티 통계</button>
      </form>
    </div>

    <!-- 회원 관리 메뉴 -->
    <button class="menu-button">회원 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-userList.action" method="get">
        <button type="submit" class="submenu-btn">회원 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-userDrop.action" method="get">
        <button type="submit" class="submenu-btn">회원 제재 관리</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
        <button type="submit" class="submenu-btn">포인트 관리</button>
      </form>
    </div>

    <!-- 신고 관리 메뉴 -->
    <button class="menu-button">신고 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-userReport.action" method="get">
        <button type="submit" class="submenu-btn">신고 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-userReportList.action" method="get">
        <button type="submit" class="submenu-btn">신고 처리 내역</button>
      </form>
    </div>

    <!-- 포인트 관리 메뉴 -->
    <button class="menu-button">포인트 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-pointUpdate.action" method="get">
        <button type="submit" class="submenu-btn">포인트 관리</button>
      </form>
    </div>

    <!-- 쿠폰 관리 메뉴 -->
    <button class="menu-button">쿠폰 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-couponList.action" method="get">
        <button type="submit" class="submenu-btn">쿠폰 목록</button>
      </form>
      <form action="${pageContext.request.contextPath}/admin-createCoupon.action" method="get">
        <button type="submit" class="submenu-btn">쿠폰 생성</button>
      </form>
    </div>

    <!-- 이벤트 관리 메뉴 -->
    <button class="menu-button">이벤트 관리</button>
    <div class="submenu">
      <form action="${pageContext.request.contextPath}/admin-eventUpdate.action" method="get">
        <button type="submit" class="submenu-btn">이벤트 관리</button>
      </form>
    </div>
  </div>

  <!-- 콘텐츠 영역 - 실제 데이터와 컨트롤이 표시되는 부분 -->
  <div id="content">
    <!-- 콘텐츠 헤더 - 페이지 제목 -->
    <div class="content-header">
      <h2>검수 목록 조회</h2>
    </div>

    <!-- 검색 영역 - 장비 검색 필터링 옵션 -->
    <div class="content-search-info">
      <span>검색유형</span>
      <select>
        <option>장비코드</option>
        <option>장비명</option>
        <option>관리자ID</option>
        <option>검수항목</option>
      </select>

      <span>검수결과</span>
      <select>
        <option>전체</option>
        <option>합격</option>
        <option>불합격</option>
        <option>대기중</option>
      </select>

      <span>카테고리</span>
      <select>
        <option>전체</option>
        <option>텐트/타프</option>
        <option>침낭/매트</option>
        <option>캠핑 가구</option>
        <option>조리도구</option>
        <option>랜턴/조명</option>
        <option>기타</option>
      </select>

      <!-- 날짜 범위 선택 -->
      <div class="content-search-date">
        <input type="date">
        <span>~</span>
        <input type="date">
      </div>

      <!-- 검색어 입력 -->
      <div class="content-search-bar">
        <input type="search" placeholder="검색어 입력">
      </div>

      <!-- 검색 버튼 -->
      <div class="content-search-btn">
        <input type="button" value="검색하기">
      </div>
    </div>

    <!-- 검수 정보 요약 - 주요 통계 -->
    <div class="inspection-count">
      <div class="inspection-all">
        <span>총 검수 건수: 156건</span>
      </div>
      <div class="inspection-pass">
        <span>합격: 98건</span>
      </div>
      <div class="inspection-fail">
        <span>불합격: 58건</span>
      </div>
      <div class="inspection-pending">
        <span>대기중: 35건</span>
      </div>
    </div>

    <!-- 검수 단계 토글 스위치 -->
    <div class="toggle-container">
      <div class="toggle-button-group">
        <button type="button" class="toggle-button active" data-stage="all">전체 검수</button>
        <button type="button" class="toggle-button" data-stage="primary">1차 검수</button>
        <button type="button" class="toggle-button" data-stage="secondary">2차 검수</button>
      </div>
    </div>

    <!-- 전체 선택 체크박스 -->
    <div class="select-all-checkbox">
      <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
    </div>

    <!-- 전체 검수 영역 -->
    <div id="all-inspections" class="content-area active">
      <!-- 검수 목록 테이블 - 가로 스크롤 가능 -->
      <div class="inspection-index">
        <table>
          <tr>
            <!-- 테이블 헤더 - 각 열의 제목 -->
            <th class="col-select">선택</th>
            <th class="col-code">장비코드</th>
            <th class="col-type">검수유형</th>
            <th class="col-name">장비명</th>
            <th class="col-category">카테고리명</th>
            <th class="col-item">검수항목</th>
            <th class="col-admin">관리자ID</th>
            <th class="col-process">검수처리</th>
            <th class="col-result">검수결과</th>
            <th class="col-comment">검수코멘트</th>
            <th class="col-status">검수상태</th>
          </tr>

          <!-- 검수 데이터 행 -->



        </table>
      </div>
    </div>

    <!-- 1차 검수 영역 -->
    <div id="primary-inspections" class="content-area">
      <!-- 검수 목록 테이블 - 가로 스크롤 가능 -->
      <div class="inspection-index">
        <table>
          <tr>
            <!-- 테이블 헤더 - 각 열의 제목 -->
            <th class="col-select">선택</th>
            <th class="col-code">장비코드</th>
            <th class="col-type">검수유형</th>
            <th class="col-name">장비명</th>
            <th class="col-category">카테고리명</th>
            <th class="col-item">검수항목</th>
            <th class="col-admin">관리자ID</th>
            <th class="col-process">검수처리</th>
            <th class="col-result">검수결과</th>
            <th class="col-comment">검수코멘트</th>
            <th class="col-status">검수상태</th>
          </tr>

          <!-- 1차 검수 데이터 행 -->

          <c:forEach var="inspect" items="${list}">
            <tr>
              <td class="checkbox-column"><input type="checkbox"></td>
              <td>${inspect.equipCode}</td>
              <td>${inspect.inspectName}</td>
              <td>${inspect.equipName}</td>
              <td>${inspect.categoryName}</td>
              <td>${inspect.inspectList}</td>
              <td>${inspect.adminId}</td>
              <td>
                <c:choose>
                  <c:when test="${empty inspect.inspectResult}">
                    <button class="process-btn" onclick="openInspectionModal(this)">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
                <%--검수결과에 따른 결과처리--%>
              <td>
                <c:if test="${inspect.inspectResult eq '상'}">
                  <span class="status-badge status-pass">${inspect.inspectResult}</span>
                </c:if>
                <c:if test="${inspect.inspectResult eq '중'}">
                  <span class="status-badge status-pending">${inspect.inspectResult}</span>
                </c:if>
                <c:if test="${inspect.inspectResult eq '하'}">
                  <span class="status-badge status-fail">${inspect.inspectResult}</span>
                </c:if>
              </td>
              <td>${inspect.inspectComment}</td>
              <td>
                <c:choose>
                  <c:when test="${empty inspect.inspectResult}">
                    <span class="status-badge status-waiting">검수대기</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-badge status-pass">${inspect.inspectState}</span>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>


        </table>
      </div>
    </div>

    <!-- 2차 검수 영역 -->
    <div id="secondary-inspections" class="content-area">
      <!-- 검수 목록 테이블 - 가로 스크롤 가능 -->
      <div class="inspection-index">
        <table>
          <tr>
            <!-- 테이블 헤더 - 각 열의 제목 -->
            <th class="col-select">선택</th>
            <th class="col-code">장비코드</th>
            <th class="col-type">검수유형</th>
            <th class="col-name">장비명</th>
            <th class="col-category">카테고리명</th>
            <th class="col-item">검수항목</th>
            <th class="col-admin">관리자ID</th>
            <th class="col-process">검수처리</th>
            <th class="col-result">검수결과</th>
            <th class="col-comment">검수코멘트</th>
            <th class="col-status">검수상태</th>
          </tr>

          <!--2차 검수 데이터 행-->
          <c:forEach var="inspect" items="${listr}">
            <tr>
              <td class="checkbox-column"><input type="checkbox"></td>
              <td>${inspect.equipCode}</td>
              <td>${inspect.inspectName}</td>
              <td>${inspect.equipName}</td>
              <td>${inspect.categoryName}</td>
              <td>${inspect.inspectList}</td>
              <td>${inspect.adminId}</td>
              <td>
                <c:choose>
                  <c:when test="${empty inspect.inspectResult}">
                    <button class="process-btn" onclick="openInspectionModal(this)">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
                <%--검수결과에 따른 결과처리--%>
              <td>
                <c:if test="${inspect.inspectResult eq '상'}">
                  <span class="status-badge status-pass">${inspect.inspectResult}</span>
                </c:if>
                <c:if test="${inspect.inspectResult eq '중'}">
                  <span class="status-badge status-pending">${inspect.inspectResult}</span>
                </c:if>
                <c:if test="${inspect.inspectResult eq '하'}">
                  <span class="status-badge status-fail">${inspect.inspectResult}</span>
                </c:if>
              </td>
              <td>${inspect.inspectComment}</td>
              <td>
                <c:choose>
                  <c:when test="${empty inspect.inspectResult}">
                    <span class="status-badge status-waiting">검수대기</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-badge status-pass">${inspect.inspectState}</span>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
        </table>
      </div>
    </div>
    <!-- 검수처리 모달 -->
    <div id="inspectionModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>검수 처리</h3>
          <span class="close-modal" onclick="closeInspectionModal()">&times;</span>
        </div>
        <div class="modal-body">
          <form action="${pageContext.request.contextPath}/admin-inspectList.action" method="POST" id="inspectionForm">
            <!-- 프로시저에 필요한 필드 -->
            <input type="hidden" name="platformDeliveryId" id="platformDeliveryId">
            <input type="hidden" name="platformDeliveryReturnId" id="platformDeliveryReturnId">
            <input type="hidden" name="equipGradeId" id="equipGradeId">
            <input type="hidden" name="inspecGradeId" id="inspecGradeId">
            <input type="hidden" name="adminId" id="adminId">

            <div class="form-group">
              <label for="equipCode">장비코드</label>
              <input type="text" id="equipCode" class="form-control" disabled>
            </div>
            <div class="form-group">
              <label for="deliveryId">플랫폼배송ID 또는 플랫폼배송반환ID</label>
              <input type="text" id="deliveryId" class="form-control" disabled>
            </div>
            <div class="form-group">
              <label for="inspectionType">검수유형</label>
              <select id="inspectionType" class="form-control">
                <option value="입고검수">입고검수</option>
                <option value="스토렌반환검수">스토렌반환검수</option>
                <option value="최종검수">최종검수</option>
              </select>
            </div>
            <div class="form-group">
              <label for="equipName">장비명</label>
              <input type="text" id="equipName" class="form-control" disabled="disabled">
            </div>
            <div class="form-group">
              <label for="equipCategory">카테고리</label>
              <input type="text" id="equipCategory" class="form-control" disabled="disabled">
            </div>
            <div class="form-group checklist-form-group">
              <label for="checklistTable">체크리스트</label>
              <div class="checklist-container">
                <table id="checklistTable" class="checklist-table">
                  <thead>
                  <tr>
                    <th rowspan="2">검수 항목</th>
                    <th colspan="3">기준</th>
                    <th colspan="2">결과</th>
                  </tr>
                  <tr>
                    <th>상</th>
                    <th>중</th>
                    <th>하</th>
                    <th>코멘트</th>
                    <th>점수</th>
                  </tr>
                  </thead>
                  <tbody>
                  <!-- DB에서 가져온 항목을 동적으로 표시 -->
                  <c:forEach var="item" items="${getItemList}">
                    <tr>
                      <td>${item.inspecItemName}</td>
                      <td>
                        <input type="radio" name="item_${item.inspecItemId}" value="상" class="grade-checkbox">
                          ${item.inspecItemDescHigh}
                      </td>
                      <td>
                        <input type="radio" name="item_${item.inspecItemId}" value="중" class="grade-checkbox">
                          ${item.inspecItemDescMid}
                      </td>
                      <td>
                        <input type="radio" name="item_${item.inspecItemId}" value="하" class="grade-checkbox">
                          ${item.inspecItemDescLow}
                      </td>
                      <td><input type="text" name="comment_${item.inspecItemId}" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                  </c:forEach>

                  <!-- 데이터가 없는 경우 기본 항목 표시 -->
                  <c:if test="${empty getItemList}">
                    <tr>
                      <td>외관 보존 상태</td>
                      <td><input type="radio" name="외관보존상태" value="상" class="grade-checkbox"> 사용감 거의 없음, 신품 수준 외관</td>
                      <td><input type="radio" name="외관보존상태" value="중" class="grade-checkbox"> 마모 등 경미한 사용감 있음</td>
                      <td><input type="radio" name="외관보존상태" value="하" class="grade-checkbox"> 뚜렷한 사용 흔적, 외관 낡고 변색</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                    <tr>
                      <td>물리적 무손상 상태</td>
                      <td><input type="radio" name="물리적무손상상태" value="상" class="grade-checkbox"> 파손 없음</td>
                      <td><input type="radio" name="물리적무손상상태" value="중" class="grade-checkbox"> 작은 손상 있음</td>
                      <td><input type="radio" name="물리적무손상상태" value="하" class="grade-checkbox"> 심한 손상 있음</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                    <tr>
                      <td>청결/세정 상태</td>
                      <td><input type="radio" name="청결세정상태" value="상" class="grade-checkbox"> 오염 없음</td>
                      <td><input type="radio" name="청결세정상태" value="중" class="grade-checkbox"> 약간의 오염 있음</td>
                      <td><input type="radio" name="청결세정상태" value="하" class="grade-checkbox"> 심한 오염 있음</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                    <tr>
                      <td>부속품 완비</td>
                      <td><input type="radio" name="부속품완비" value="상" class="grade-checkbox"> 부속품(매뉴얼 등) 모두 보유</td>
                      <td><input type="radio" name="부속품완비" value="중" class="grade-checkbox"> 일부 부속품 누락</td>
                      <td><input type="radio" name="부속품완비" value="하" class="grade-checkbox"> 필수 부속품 누락</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                    <tr>
                      <td>기능 작동성</td>
                      <td><input type="radio" name="기능작동성" value="상" class="grade-checkbox"> 기능 모두 정상 작동</td>
                      <td><input type="radio" name="기능작동성" value="중" class="grade-checkbox"> 일부 기능 약간 미흡</td>
                      <td><input type="radio" name="기능작동성" value="하" class="grade-checkbox"> 기능 중 하나 이상 심각한 문제 있음</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                  </c:if>

                  <tr class="total-row">
                    <td colspan="4" style="text-align: right;"><strong>합계</strong></td>
                    <td id="totalScore" class="total-score">100</td>
                    <td id="finalGrade" class="final-grade">A</td>
                  </tr>
                  </tbody>
                </table>
              </div>
              <div class="grade-info">
                <p><strong>[등급 판정 기준]</strong></p>
                <div class="grade-badges">
                  <!-- 등급 정보를 DB에서 가져오거나 기본값 표시 -->
                  <c:choose>
                    <c:when test="${not empty getGradeList}">
                      <c:forEach var="grade" items="${getGradeList}">
                        <c:choose>
                          <c:when test="${grade.inspecGradeName == 'A'}">
                            <span class="grade-info-badge grade-a">${grade.inspecGradeName}</span> 100-90점
                          </c:when>
                          <c:when test="${grade.inspecGradeName == 'B'}">
                            <span class="grade-info-badge grade-b">${grade.inspecGradeName}</span> 89-80점
                          </c:when>
                          <c:when test="${grade.inspecGradeName == 'C'}">
                            <span class="grade-info-badge grade-c">${grade.inspecGradeName}</span> 79-70점
                          </c:when>
                          <c:when test="${grade.inspecGradeName == 'D'}">
                            <span class="grade-info-badge grade-d">${grade.inspecGradeName}</span> 69-60점
                          </c:when>
                          <c:when test="${grade.inspecGradeName == 'E'}">
                            <span class="grade-info-badge grade-e">${grade.inspecGradeName}</span> 59-50점
                          </c:when>
                          <c:when test="${grade.inspecGradeName == 'F'}">
                            <span class="grade-info-badge grade-f">${grade.inspecGradeName}</span> 49점 이하 (스토렌/렌탈 이용 불가)
                          </c:when>
                        </c:choose>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <!-- 기본 등급 정보 -->
                      <span class="grade-info-badge grade-a">A</span> 100-90점
                      <span class="grade-info-badge grade-b">B</span> 89-80점
                      <span class="grade-info-badge grade-c">C</span> 79-70점
                      <span class="grade-info-badge grade-d">D</span> 69-60점
                      <span class="grade-info-badge grade-e">E</span> 59-50점
                      <span class="grade-info-badge grade-f">F</span> 49점 이하 (스토렌/렌탈 이용 불가)
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="processDate">처리일</label>
              <input type="text" id="processDate" class="form-control" disabled>
            </div>

            <div class="modal-actions">
              <button type="button" class="modal-btn btn-cancel" onclick="closeInspectionModal()">취소</button>
              <button type="submit" class="modal-btn btn-save">저장</button>
            </div>
          </form>
        </div>
      </div>
    </div>


    <script>
      // 전역 변수 선언
      let currentRow = null;
      const modal = document.getElementById('inspectionModal');

      // DOM이 완전히 로드된 후 실행되는 초기화 함수
      document.addEventListener('DOMContentLoaded', function() {
        // 브라우저 호환성을 위한 closest 메소드 폴리필
        if (!Element.prototype.closest) {
          Element.prototype.closest = function(s) {
            let el = this;
            do {
              if (el.matches(s)) return el;
              el = el.parentElement || el.parentNode;
            } while (el !== null && el.nodeType === 1);
            return null;
          };
        }

        // 메뉴 초기화 - 장비 관리 메뉴 초기 상태 설정 (페이지에 맞게 열어두기)
        initMenu();

        // 이벤트 리스너 등록
        registerEventListeners();
      });

      // 메뉴 초기화 함수
      function initMenu() {
        const menuButtons = document.querySelectorAll('.menu-button');

        // 장비 관리 메뉴 초기 상태 설정 (페이지에 맞게 열어두기)
        const equipmentMenu = menuButtons[1]; // 장비 관리 메뉴 (인덱스 1)
        equipmentMenu.classList.add('active');
        const submenu = equipmentMenu.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + "px";

        // 다른 메뉴는 닫힌 상태로 설정
        menuButtons.forEach((button, index) => {
          if (index !== 1) { // 장비 관리 메뉴가 아닌 경우
            const submenu = button.nextElementSibling;
            submenu.style.maxHeight = null;
          }
        });
      }

      // 이벤트 리스너 등록 함수
      function registerEventListeners() {
        // 메뉴 드롭다운 토글 기능
        const menuButtons = document.querySelectorAll('.menu-button');
        menuButtons.forEach(button => {
          button.addEventListener('click', function() {
            this.classList.toggle('active');
            const submenu = this.nextElementSibling;

            if (submenu.style.maxHeight) {
              submenu.style.maxHeight = null;
            } else {
              submenu.style.maxHeight = submenu.scrollHeight + "px";
            }
          });
        });

        // 토글 버튼 이벤트 처리
        const toggleButtons = document.querySelectorAll('.toggle-button');
        toggleButtons.forEach(button => {
          button.addEventListener('click', function() {
            // 모든 토글 버튼에서 active 클래스 제거
            toggleButtons.forEach(btn => btn.classList.remove('active'));

            // 클릭된 버튼에 active 클래스 추가
            this.classList.add('active');

            // 선택된 검수 단계 가져오기
            const stage = this.getAttribute('data-stage');

            // 모든 콘텐츠 영역 숨기기
            const contentAreas = document.querySelectorAll('.content-area');
            contentAreas.forEach(area => area.classList.remove('active'));

            // 선택된 단계에 해당하는 콘텐츠 영역 표시
            if (stage === 'all') {
              document.getElementById('all-inspections').classList.add('active');
            } else if (stage === 'primary') {
              document.getElementById('primary-inspections').classList.add('active');
            } else if (stage === 'secondary') {
              document.getElementById('secondary-inspections').classList.add('active');
            }
          });
        });

        // 전체 선택 체크박스 이벤트 처리
        const selectAllCheckbox = document.getElementById('selectAll');
        if (selectAllCheckbox) {
          selectAllCheckbox.addEventListener('change', function() {
            const activeContentArea = document.querySelector('.content-area.active');
            if (activeContentArea) {
              const checkboxes = activeContentArea.querySelectorAll('input[type="checkbox"]');
              checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
              });
            }
          });
        }

        // 검수 처리 버튼에 이벤트 리스너 할당
        const processButtons = document.querySelectorAll('.process-btn');
        processButtons.forEach(button => {
          button.addEventListener('click', function() {
            openInspectionModal(this);
          });
        });

        // 모달 닫기 버튼 이벤트 리스너
        const closeButtons = document.querySelectorAll('.close-modal, .btn-cancel');
        closeButtons.forEach(button => {
          button.addEventListener('click', closeInspectionModal);
        });

        // 검수 폼 제출 이벤트 리스너
        const inspectionForm = document.getElementById('inspectionForm');
        if (inspectionForm) {
          inspectionForm.addEventListener('submit', handleFormSubmit);
        }
      }

      // 디버깅 함수 - 실제 사용 중인 라디오 버튼 name 출력
      function debugRadioNames() {
        console.log("=== 라디오 버튼 name 속성 디버깅 ===");
        const radioButtons = document.querySelectorAll('input[type="radio"]');
        const uniqueNames = new Set();

        radioButtons.forEach(radio => {
          uniqueNames.add(radio.name);
        });

        console.log("사용 중인 라디오 버튼 name들:", Array.from(uniqueNames));
      }



      // 검수 모달 열기 함수 수정
      function openInspectionModal(button) {
        try {
          // 현재 행의 데이터 가져오기
          currentRow = button.closest('tr');
          if (!currentRow) {
            throw new Error('테이블 행을 찾을 수 없습니다.');
          }

          // 필요한 데이터 추출
          const equipCode = currentRow.cells[1]?.textContent || '';
          const inspectionType = currentRow.cells[2]?.textContent || '';
          const equipName = currentRow.cells[3]?.textContent || '';
          const categoryName = currentRow.cells[4]?.textContent || '';
          const inspectResult = currentRow.cells[8]?.textContent || '';

          // 이미 검수 완료된 항목인지 확인
          if (inspectResult && inspectResult.trim() !== '') {
            alert('이미 검수 처리가 완료된 항목입니다.');
            return;
          }

          // 모달 폼에 기본 데이터 설정
          document.getElementById('equipCode').value = equipCode;
          document.getElementById('inspectionType').value = inspectionType;
          document.getElementById('equipName').value = equipName;
          document.getElementById('equipCategory').value = categoryName;

          // platformDeliveryId와 platformDeliveryReturnId 초기화
          document.getElementById('platformDeliveryId').value = '';
          document.getElementById('platformDeliveryReturnId').value = '';

          // 검수 유형에 따라 배송 ID 또는 반환 ID 설정
          if (inspectionType === '입고검수') {
            document.getElementById('platformDeliveryId').value = equipCode;
            document.getElementById('platformDeliveryReturnId').value = '';
            document.getElementById('deliveryId').value = 'DELV-' + equipCode;
          } else if (inspectionType === '스토렌반환검수') {
            document.getElementById('platformDeliveryId').value = '';
            document.getElementById('platformDeliveryReturnId').value = equipCode;
            document.getElementById('deliveryId').value = 'DELV-RTN-' + equipCode;
          }

          // 현재 날짜와 시간 설정
          const now = new Date();
          const formattedDate = now.getFullYear() + '-' +
                  String(now.getMonth() + 1).padStart(2, '0') + '-' +
                  String(now.getDate()).padStart(2, '0') + ' ' +
                  String(now.getHours()).padStart(2, '0') + ':' +
                  String(now.getMinutes()).padStart(2, '0') + ':' +
                  String(now.getSeconds()).padStart(2, '0');
          document.getElementById('processDate').value = formattedDate;

          // 체크리스트 초기화
          initChecklistFunctionality();

          // 등급 정보 로드 (AJAX 호출)
          loadEquipGradeInfo();

          // 모달 표시
          modal.style.display = 'block';

          // 디버깅
          console.log('모달 열기 - platformDeliveryId:', document.getElementById('platformDeliveryId').value);
          console.log('모달 열기 - platformDeliveryReturnId:', document.getElementById('platformDeliveryReturnId').value);
        } catch (error) {
          console.error('검수 모달 열기 오류:', error);
          alert('검수 처리 준비 중 오류가 발생했습니다.');
        }
      }

      // 등급 정보 로드 함수 (AJAX 사용)
      function loadEquipGradeInfo() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/admin-getEquipGrades.action', true);

        xhr.onload = function() {
          if (xhr.status === 200) {
            try {
              const gradeInfo = JSON.parse(xhr.responseText);
              updateGradeInfoDisplay(gradeInfo);
            } catch (e) {
              console.error('등급 정보 파싱 오류:', e);
            }
          }
        };

        xhr.onerror = function() {
          console.error('등급 정보 요청 실패');
        };

        xhr.send();
      }

      // 등급 정보 표시 업데이트
      function updateGradeInfoDisplay(gradeInfo) {
        const gradeInfoContainer = document.querySelector('.grade-badges');
        if (!gradeInfoContainer || !gradeInfo || !gradeInfo.length) return;

        let gradeHtml = '';

        gradeInfo.forEach(grade => {
          const className = `grade-${grade.equipGradeName.toLowerCase()}`;
          let rangeText = '';

          // 등급별 점수 범위 설정
          if (grade.equipGradeName === 'A') {
            rangeText = '100-90점';
          } else if (grade.equipGradeName === 'B') {
            rangeText = '89-80점';
          } else if (grade.equipGradeName === 'C') {
            rangeText = '79-70점';
          } else if (grade.equipGradeName === 'D') {
            rangeText = '69-60점';
          } else if (grade.equipGradeName === 'E') {
            rangeText = '59-50점';
          } else if (grade.equipGradeName === 'F') {
            rangeText = '49점 이하 (스토렌/렌탈 이용 불가)';
          }

          gradeHtml += `<span class="grade-info-badge ${className}">${grade.equipGradeName}</span> ${rangeText} `;
        });

        gradeInfoContainer.innerHTML = gradeHtml;
      }

      // 최종 등급 업데이트 함수 개선
      function updateFinalGrade(totalScore) {
        const finalGradeElement = document.getElementById('finalGrade');
        if (!finalGradeElement) return;

        let gradeClass = '';
        let grade = '';
        let equipGradeId = 1; // 기본값

        // 등급 결정
        if (totalScore >= 90) {
          grade = 'A';
          gradeClass = 'grade-a';
          equipGradeId = 1;
        } else if (totalScore >= 80) {
          grade = 'B';
          gradeClass = 'grade-b';
          equipGradeId = 2;
        } else if (totalScore >= 70) {
          grade = 'C';
          gradeClass = 'grade-c';
          equipGradeId = 3;
        } else if (totalScore >= 60) {
          grade = 'D';
          gradeClass = 'grade-d';
          equipGradeId = 4;
        } else if (totalScore >= 50) {
          grade = 'E';
          gradeClass = 'grade-e';
          equipGradeId = 5;
        } else {
          grade = 'F';
          gradeClass = 'grade-f';
          equipGradeId = 6;
        }

        finalGradeElement.textContent = grade;
        finalGradeElement.className = 'final-grade ' + gradeClass;

        // 등급 ID 설정
        const equipGradeIdElement = document.getElementById('equipGradeId');
        if (equipGradeIdElement) {
          equipGradeIdElement.value = equipGradeId;
        }

        // inspecGradeId 설정 - 등급에 따라 다른 검수 등급 할당
        const inspecGradeIdElement = document.getElementById('inspecGradeId');
        if (inspecGradeIdElement) {
          // A, B 등급은 1(상), C, D 등급은 2(중), E, F 등급은 3(하)
          if (grade === 'A' || grade === 'B') {
            inspecGradeIdElement.value = 1; // 상
          } else if (grade === 'C' || grade === 'D') {
            inspecGradeIdElement.value = 2; // 중
          } else {
            inspecGradeIdElement.value = 3; // 하
          }
        }

        // 관리자 ID 설정
        const adminIdElement = document.getElementById('adminId');
        if (adminIdElement) {
          // 세션에서 관리자 ID 가져오기
          const adminId = '${sessionScope.adminId}' || 'ADMIN1';
          adminIdElement.value = adminId;
        }
      }

      // 폼 제출 처리 함수 개선
      function handleFormSubmit(event) {
        // 폼 제출 기본 동작 방지
        event.preventDefault();

        // 이벤트 핸들러가 두 번 호출되는 것을 방지하기 위한 플래그
        if (event.submitting) return;
        event.submitting = true;

        try {
          // 실제 체크리스트 테이블의 각 행에서 라디오 버튼 검증
          const rows = document.querySelectorAll('#checklistTable tbody tr:not(.total-row)');
          let isValid = true;
          let commentText = '';

          // 유효성 검사 로직
          for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const itemName = row.cells[0].textContent.trim();
            const radios = row.querySelectorAll('input[type="radio"]');
            const isChecked = Array.from(radios).some(radio => radio.checked);

            if (!isChecked) {
              isValid = false;
              alert(`'${itemName}' 항목을 평가해주세요.`);
              event.submitting = false;
              return;
            }

            // 코멘트 수집
            const commentInput = row.querySelector('.comment-input');
            if (commentInput && commentInput.value.trim() !== '') {
              commentText += `${itemName}: ${commentInput.value.trim()}\n`;
            }
          }

          // 유효성 검사 통과 시 AJAX 요청 준비
          if (isValid && currentRow) {
            // 폼 데이터 생성
            const form = document.getElementById('inspectionForm');
            const formData = new FormData(form);

            // platformDeliveryId 또는 platformDeliveryReturnId 중 하나는 값이 있는지 확인
            const platformDeliveryId = document.getElementById('platformDeliveryId').value;
            const platformDeliveryReturnId = document.getElementById('platformDeliveryReturnId').value;

            if (!platformDeliveryId && !platformDeliveryReturnId) {
              alert('배송 ID 또는 반환 ID가 설정되지 않았습니다.');
              event.submitting = false;
              return;
            }

            // 코멘트 추가
            formData.append('inspecComment', commentText || '자동 검수 처리');

            // 최종 등급 정보 추가
            const finalGrade = document.getElementById('finalGrade').textContent;
            formData.append('finalGrade', finalGrade);

            // AJAX 요청 설정
            const xhr = new XMLHttpRequest();
            xhr.open('POST', form.action, true);

            // 응답 처리
            xhr.onload = function() {
              // 플래그 초기화
              event.submitting = false;

              if (xhr.status === 200) {
                try {
                  const response = JSON.parse(xhr.responseText);
                  if (response.success) {
                    alert('검수 처리가 완료되었습니다.');
                    // UI 업데이트
                    updateUIAfterSubmission(commentText, finalGrade);
                    closeInspectionModal();
                  } else {
                    if (response.message && response.message.includes('이미 검수 처리가 완료된 항목')) {
                      alert('이미 검수 처리가 완료된 항목입니다.');
                      closeInspectionModal();
                    } else {
                      alert('검수 처리 중 오류가 발생했습니다: ' + (response.message || '알 수 없는 오류'));
                    }
                  }
                } catch (e) {
                  // JSON 파싱 실패 시 응답 텍스트 확인
                  if (xhr.responseText.includes('success') || xhr.responseText.includes('완료')) {
                    alert('검수 처리가 완료되었습니다.');
                    // UI 업데이트
                    updateUIAfterSubmission(commentText, finalGrade);
                    closeInspectionModal();
                  } else if (xhr.responseText.includes('이미 검수 처리가 완료된 항목')) {
                    alert('이미 검수 처리가 완료된 항목입니다.');
                    closeInspectionModal();
                  } else {
                    console.error('응답 처리 오류', e);
                    alert('서버 응답을 처리할 수 없습니다.');
                  }
                }
              } else {
                alert('서버 오류: ' + xhr.status);
              }
            };

            // 오류 처리
            xhr.onerror = function() {
              event.submitting = false;
              alert('네트워크 오류가 발생했습니다.');
            };

            // 요청 전송
            xhr.send(formData);
          } else {
            // 플래그 초기화
            event.submitting = false;
          }
        } catch (error) {
          event.submitting = false;
          console.error('폼 제출 오류:', error);
          alert('검수 처리 중 오류가 발생했습니다: ' + error.message);
        }
      }

      // UI 업데이트 함수 개선
      function updateUIAfterSubmission(commentText, finalGrade) {
        if (!currentRow) return;

        // 등급에 따른 결과 설정
        let resultType, resultClass;
        if (finalGrade === 'A' || finalGrade === 'B') {
          resultType = '상';
          resultClass = 'status-pass';
        } else if (finalGrade === 'C' || finalGrade === 'D') {
          resultType = '중';
          resultClass = 'status-pending';
        } else {
          resultType = '하';
          resultClass = 'status-fail';
        }

        // 검수 결과 셀 업데이트
        updateCellWithBadge(currentRow.cells[8], resultType, resultClass);

        // 검수 코멘트 업데이트
        currentRow.cells[9].textContent = commentText || '검수 완료';

        // 검수상태 업데이트
        updateCellWithBadge(currentRow.cells[10], '검수 완료', 'status-pass');

        // 버튼 비활성화 (이미 처리됨)
        const processBtn = currentRow.querySelector('.process-btn');
        if (processBtn) {
          processBtn.disabled = true;
          processBtn.classList.add('disabled');
          processBtn.textContent = '처리완료';
        }
      }

      // 셀 배지 업데이트 헬퍼 함수
      function updateCellWithBadge(cell, text, className) {
        if (!cell) return;

        let badge = cell.querySelector('.status-badge');
        if (!badge) {
          badge = document.createElement('span');
          badge.className = 'status-badge';
          cell.innerHTML = '';
          cell.appendChild(badge);
        }

        badge.textContent = text;
        badge.className = 'status-badge ' + className;
      }

      // 윈도우 클릭 이벤트 - 모달 외부 클릭 시 닫기
      window.addEventListener('click', function(event) {
        if (event.target === modal) {
          closeInspectionModal();
        }
      });

      // ESC 키 누를 때 모달 닫기
      document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape' && modal.style.display === 'block') {
          closeInspectionModal();
        }
      });
    </script>
  </div>
</div>
</body>
</html>
