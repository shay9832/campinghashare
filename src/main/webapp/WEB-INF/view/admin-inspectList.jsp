<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 시스템 - 검수 목록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-inspectList.css">
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
    </div>

    <!-- 검수 관리 메뉴 - 초기에 활성화 -->
    <button class="menu-button active">검수 관리</button>
    <div class="submenu active">
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
      <form action="${pageContext.request.contextPath}/admin-payment.action" method="get">
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

  <!-- 콘텐츠 영역 -->
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
        <button type="button" class="toggle-button" data-stage="primary">플랫폼 검수</button>
        <button type="button" class="toggle-button" data-stage="secondary">플랫폼 반환 검수</button>
      </div>
    </div>

    <!-- 전체 선택 체크박스 -->
    <div class="select-all-checkbox">
      <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
    </div>

    <!-- 전체 검수 영역 -->
    <div id="all-inspections" class="content-area active">
      <!-- 검수 목록 테이블 -->
      <div class="inspection-index">
        <table>
          <tr>
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

          <!-- 전체 검수 데이터 행 -->
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
                    <button class="process-btn" onclick="openModal('${inspect.equipCode}', '${inspect.platformDeliveryId}', '${inspect.inspectName}', '${inspect.equipName}', '${inspect.categoryName}')">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
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
                    <button class="process-btn" onclick="openModal('${inspect.equipCode}', '${inspect.platformDeliveryId}', '${inspect.inspectName}', '${inspect.equipName}', '${inspect.categoryName}')">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
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

    <!-- 1차 검수 영역 -->
    <div id="primary-inspections" class="content-area">
      <!-- 검수 목록 테이블 -->
      <div class="inspection-index">
        <table>
          <tr>
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
                    <button class="process-btn" onclick="openModal('${inspect.equipCode}', '${inspect.platformDeliveryId}', '${inspect.inspectName}', '${inspect.equipName}', '${inspect.categoryName}')">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
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
      <!-- 검수 목록 테이블 -->
      <div class="inspection-index">
        <table>
          <tr>
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

          <!-- 2차 검수 데이터 행 -->
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
                    <button class="process-btn" onclick="openModal('${inspect.equipCode}', '${inspect.platformDeliveryId}', '${inspect.inspectName}', '${inspect.equipName}', '${inspect.categoryName}')">검수처리</button>
                  </c:when>
                  <c:otherwise>
                    <button class="process-btn disabled" disabled>처리완료</button>
                  </c:otherwise>
                </c:choose>
              </td>
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
          <span class="close-modal" onclick="closeModal()">&times;</span>
        </div>
        <div class="modal-body">
          <form action="${pageContext.request.contextPath}/admin-inspectList.action" method="POST" id="inspectionForm">
            <!-- 프로시저에 필요한 필드 -->
            <input type="hidden" name="platformDeliveryId" id="platformDeliveryId">
            <input type="hidden" name="platformDeliveryReturnId" id="platformDeliveryReturnId">
            <input type="hidden" name="equipGradeId" id="equipGradeId" value="1">
            <input type="hidden" name="inspecGradeId" id="inspecGradeId" value="1">

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
              </select>
            </div>
            <div class="form-group">
              <label for="equipName">장비명</label>
              <input type="text" id="equipName" class="form-control" disabled>
            </div>
            <div class="form-group">
              <label for="equipCategory">카테고리</label>
              <input type="text" id="equipCategory" class="form-control" disabled>
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
                  <!-- DB에서 가져온 검수 항목으로 체크리스트 동적 생성 -->
                  <c:forEach var="item" items="${getItemList}">
                    <tr>
                      <td>${item.inspecItemName}</td>
                      <td><input type="radio" name="${item.inspecItemName}" value="상" class="grade-checkbox" onclick="updateScores()"> ${item.inspecItemDescHigh}</td>
                      <td><input type="radio" name="${item.inspecItemName}" value="중" class="grade-checkbox" onclick="updateScores()"> ${item.inspecItemDescMid}</td>
                      <td><input type="radio" name="${item.inspecItemName}" value="하" class="grade-checkbox" onclick="updateScores()"> ${item.inspecItemDescLow}</td>
                      <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                      <td class="score-cell">20</td>
                    </tr>
                  </c:forEach>
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
                  <span class="grade-info-badge grade-a">A</span> 100-90점
                  <span class="grade-info-badge grade-b">B</span> 89-80점
                  <span class="grade-info-badge grade-c">C</span> 79-70점
                  <span class="grade-info-badge grade-d">D</span> 69-60점
                  <span class="grade-info-badge grade-e">E</span> 59-50점
                  <span class="grade-info-badge grade-f">F</span> 49점 이하
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="inspecComment">검수 코멘트</label>
              <textarea id="inspecComment" name="inspecComment" class="form-control" rows="3"></textarea>
            </div>

            <div class="modal-actions">
              <button type="button" class="modal-btn btn-cancel" onclick="closeModal()">취소</button>
              <button type="submit" class="modal-btn btn-save">저장</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
      // 페이지 로드 시 실행
      window.onload = function() {
        console.log("페이지 로드 완료");

        // 메뉴 버튼 클릭 이벤트 초기화
        initMenuButtons();

        // 토글 버튼 클릭 이벤트 초기화
        initToggleButtons();

        // 전체 선택 체크박스 초기화
        initSelectAllCheckbox();
      };

      // 메뉴 버튼 클릭 이벤트 초기화
      function initMenuButtons() {
        var menuButtons = document.querySelectorAll('.menu-button');

        menuButtons.forEach(function(button) {
          button.addEventListener('click', function() {
            // 현재 클릭된 버튼의 active 상태 토글
            this.classList.toggle('active');

            // 다음 요소(서브메뉴)의 active 상태 토글
            var submenu = this.nextElementSibling;
            if (submenu.classList.contains('active')) {
              submenu.classList.remove('active');
              submenu.style.maxHeight = null;
            } else {
              submenu.classList.add('active');
              submenu.style.maxHeight = submenu.scrollHeight + "px";
            }
          });
        });
      }

      // 토글 버튼 클릭 이벤트 초기화
      function initToggleButtons() {
        var toggleButtons = document.querySelectorAll('.toggle-button');

        toggleButtons.forEach(function(button) {
          button.addEventListener('click', function() {
            // 모든 토글 버튼에서 active 클래스 제거
            toggleButtons.forEach(function(btn) {
              btn.classList.remove('active');
            });

            // 클릭된 버튼에 active 클래스 추가
            this.classList.add('active');

            // 선택된 단계 가져오기
            var stage = this.getAttribute('data-stage');

            // 모든 콘텐츠 영역 숨기기
            var contentAreas = document.querySelectorAll('.content-area');
            contentAreas.forEach(function(area) {
              area.classList.remove('active');
            });

            // 선택된 단계에 해당하는 콘텐츠 영역 표시
            document.getElementById(stage + '-inspections').classList.add('active');
          });
        });
      }

      // 전체 선택 체크박스 초기화
      function initSelectAllCheckbox() {
        var selectAllCheckbox = document.getElementById('selectAll');

        if (selectAllCheckbox) {
          selectAllCheckbox.addEventListener('change', function() {
            var activeContentArea = document.querySelector('.content-area.active');

            if (activeContentArea) {
              var checkboxes = activeContentArea.querySelectorAll('input[type="checkbox"]');

              checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
              });
            }
          });
        }
      }

      // 모달 열기 함수 수정
      function openModal(code, platformDeliveryId, inspectName, equipName, category) {
        console.log("모달 열기:", code, platformDeliveryId, inspectName, equipName, category);

        // 모달 요소 가져오기
        var modal = document.getElementById('inspectionModal');

        // 폼 데이터 설정
        document.getElementById('equipCode').value = code;
        document.getElementById('inspectionType').value = inspectName;
        document.getElementById('equipName').value = equipName;
        document.getElementById('equipCategory').value = category;

        // 검수 유형에 따라 적절한 ID 설정
        if (inspectName === '입고검수') {
          document.getElementById('platformDeliveryId').value = platformDeliveryId;
          document.getElementById('platformDeliveryReturnId').value = "";
          document.getElementById('deliveryId').value = 'DELV-' + platformDeliveryId;
        } else if (inspectName === '스토렌반환검수') {
          document.getElementById('platformDeliveryReturnId').value = platformDeliveryId;
          document.getElementById('platformDeliveryId').value = "";
          document.getElementById('deliveryId').value = 'DELV-RTN-' + platformDeliveryId;
        }

        // 모달 표시
        modal.style.display = 'block';
      }

      // 모달 닫기 함수
      function closeModal() {
        var modal = document.getElementById('inspectionModal');
        modal.style.display = 'none';

        // 폼 초기화
        document.getElementById('inspectionForm').reset();

        // 점수 초기화
        updateScores();

        console.log('모달 닫기');
      }

      // 체크리스트 점수 계산 함수
      function updateScores() {
        var rows = document.querySelectorAll('#checklistTable tbody tr:not(.total-row)');
        var totalScore = 0;
        var totalRows = rows.length;
        var scorePerRow = 100 / totalRows; // 각 항목당 최대 점수를 동적으로 계산

        rows.forEach(function(row) {
          var scoreCell = row.querySelector('.score-cell');
          if (!scoreCell) return;

          var radios = row.querySelectorAll('input[type="radio"]');
          var score = 0;

          // 체크된 라디오 버튼 찾기
          var selectedRadio = null;
          for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
              selectedRadio = radios[i];
              break;
            }
          }

          if (selectedRadio) {
            var selectedGrade = selectedRadio.value;

            switch(selectedGrade) {
              case '상':
                score = scorePerRow;
                break;
              case '중':
                score = scorePerRow * 0.65;
                break;
              case '하':
                score = scorePerRow * 0.3;
                break;
              default:
                score = 0;
            }
          }

          scoreCell.textContent = score.toFixed(1);
          totalScore += score;
        });

        // 총점 업데이트
        var totalScoreElement = document.getElementById('totalScore');
        if (totalScoreElement) {
          totalScoreElement.textContent = totalScore.toFixed(1);
        }

        // 최종 등급 업데이트
        updateFinalGrade(totalScore);
      }

      // 최종 등급 업데이트 함수
      function updateFinalGrade(totalScore) {
        var finalGradeElement = document.getElementById('finalGrade');
        if (!finalGradeElement) return;

        var grade = '';
        var gradeClass = '';
        var equipGradeId = 1;
        var inspecGradeId = 1;

        // 등급 결정
        if (totalScore >= 90) {
          grade = 'A';
          gradeClass = 'grade-a';
          equipGradeId = 1;
          inspecGradeId = 1; // 상
        } else if (totalScore >= 80) {
          grade = 'B';
          gradeClass = 'grade-b';
          equipGradeId = 2;
          inspecGradeId = 1; // 상
        } else if (totalScore >= 70) {
          grade = 'C';
          gradeClass = 'grade-c';
          equipGradeId = 3;
          inspecGradeId = 2; // 중
        } else if (totalScore >= 60) {
          grade = 'D';
          gradeClass = 'grade-d';
          equipGradeId = 4;
          inspecGradeId = 2; // 중
        } else if (totalScore >= 50) {
          grade = 'E';
          gradeClass = 'grade-e';
          equipGradeId = 5;
          inspecGradeId = 3; // 하
        } else {
          grade = 'F';
          gradeClass = 'grade-f';
          equipGradeId = 6;
          inspecGradeId = 3; // 하
        }

        // 등급 표시 업데이트
        finalGradeElement.textContent = grade;
        finalGradeElement.className = 'final-grade ' + gradeClass;

        // 등급 ID 설정
        document.getElementById('equipGradeId').value = equipGradeId;
        document.getElementById('inspecGradeId').value = inspecGradeId;
      }
    </script>
  </div>
</div>
</body>
</html>