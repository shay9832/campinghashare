<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<!-- 메인 컨테이너 - 메뉴와 콘텐츠 영역 포함 -->
<div id="container">
  <!-- 좌측 메뉴 영역 - 드롭다운 메뉴 -->
  <div id="leftMenu">
    <!-- 회원 관리 메뉴 -->
    <button class="menu-button">회원 관리</button>
    <div class="submenu">
      <a href="#">회원 목록</a>
      <a href="#">제재내역</a>
    </div>

    <!-- 장비 관리 메뉴 -->
    <button class="menu-button active">장비 관리</button>
    <div class="submenu" style="max-height: 200px;">
      <a href="#">장비 목록</a>
      <a href="#" style="color: #3f861d; font-weight: bold; border-left: 2px solid #3f861d;">검수 목록</a>
      <a href="#">장비 통계</a>
    </div>

    <!-- 게시판 관리 메뉴 -->
    <button class="menu-button">게시판 관리</button>
    <div class="submenu">
      <a href="#">게시판 관리</a>
      <a href="#">게시글 관리</a>
      <a href="#">댓글 관리</a>
      <a href="#">커뮤니티 통계</a>
    </div>

    <!-- 신고 관리 메뉴 -->
    <button class="menu-button">신고 관리</button>
    <div class="submenu">
      <a href="#">신고 목록</a>
      <a href="#">처리 내역</a>
    </div>

    <!-- 이벤트 관리 메뉴 -->
    <button class="menu-button">이벤트 관리</button>
    <div class="submenu">
      <a href="#">이벤트 목록</a>
    </div>

    <!-- 배송 관리 메뉴 -->
    <button class="menu-button">배송 관리</button>
    <div class="submenu">
      <a href="#">배송 현황</a>
    </div>

    <!-- 쿠폰 관리 메뉴 -->
    <button class="menu-button">쿠폰 관리</button>
    <div class="submenu">
      <a href="#">쿠폰 발급</a>
      <a href="#">쿠폰 조회</a>
    </div>

    <!-- 거래 카테고리 관리 메뉴 -->
    <button class="menu-button">거래 관리</button>
    <div class="submenu">
      <a href="#">매칭 관리</a>
    </div>

    <!-- 통계 메뉴 -->
    <button class="menu-button">통계</button>
    <div class="submenu">
      <a href="#">일간 통계</a>
      <a href="#">월간 통계</a>
      <a href="#">연간 통계</a>
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
              <td><button class="process-btn" onclick="openInspectionModal(this)">검수처리</button></td>
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
              <td><span class="status-badge status-pass">${inspect.inspectState}</span></td>
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
          <c:forEach var="inspectr" items="${listr}">
            <tr>
              <td class="checkbox-column"><input type="checkbox"></td>
              <td>${inspectr.equipCode}</td>
              <td>${inspectr.inspectName}</td>
              <td>${inspectr.equipName}</td>
              <td>${inspectr.categoryName}</td>
              <td>${inspectr.inspectList}</td>
              <td>${inspectr.adminId}</td>
              <td><button class="process-btn" onclick="openInspectionModal(this)">검수처리</button></td>
                <%--검수결과에 따른 결과처리--%>
              <td>
                <c:if test="${inspectr.inspectResult eq '상'}">
                  <span class="status-badge status-pass">${inspectr.inspectResult}</span>
                </c:if>
                <c:if test="${inspectr.inspectResult eq '중'}">
                  <span class="status-badge status-pending">${inspectr.inspectResult}</span>
                </c:if>
                <c:if test="${inspectr.inspectResult eq '하'}">
                  <span class="status-badge status-fail">${inspectr.inspectResult}</span>
                </c:if>
              </td>
              <td>${inspectr.inspectComment}</td>
              <td><span class="status-badge status-pass">${inspectr.inspectState}</span></td>
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
          <form id="inspectionForm">
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
                  <tr>
                    <td>외관 보존 상태</td>
                    <td><input type="checkbox" name="외관보존상태" value="상" class="grade-checkbox"> 사용감 거의 없음, 신품 수준 외관</td>
                    <td><input type="checkbox" name="외관보존상태" value="중" class="grade-checkbox"> 마모 등 경미한 사용감 있음</td>
                    <td><input type="checkbox" name="외관보존상태" value="하" class="grade-checkbox"> 뚜렷한 사용 흔적, 외관 낡고 변색</td>
                    <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                    <td class="score-cell">20</td>
                  </tr>
                  <tr>
                    <td>물리적 무손상 상태</td>
                    <td><input type="checkbox" name="물리적무손상상태" value="상" class="grade-checkbox"> 파손 없음</td>
                    <td><input type="checkbox" name="물리적무손상상태" value="중" class="grade-checkbox"> 작은 손상 있음</td>
                    <td><input type="checkbox" name="물리적무손상상태" value="하" class="grade-checkbox"> 심한 손상 있음</td>
                    <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                    <td class="score-cell">20</td>
                  </tr>
                  <tr>
                    <td>청결/세정 상태</td>
                    <td><input type="checkbox" name="청결세정상태" value="상" class="grade-checkbox"> 오염 없음</td>
                    <td><input type="checkbox" name="청결세정상태" value="중" class="grade-checkbox"> 약간의 오염 있음</td>
                    <td><input type="checkbox" name="청결세정상태" value="하" class="grade-checkbox"> 심한 오염 있음</td>
                    <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                    <td class="score-cell">20</td>
                  </tr>
                  <tr>
                    <td>부속품 완비</td>
                    <td><input type="checkbox" name="부속품완비" value="상" class="grade-checkbox"> 부속품(매뉴얼 등) 모두 보유</td>
                    <td><input type="checkbox" name="부속품완비" value="중" class="grade-checkbox"> 일부 부속품 누락</td>
                    <td><input type="checkbox" name="부속품완비" value="하" class="grade-checkbox"> 필수 부속품 누락</td>
                    <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                    <td class="score-cell">20</td>
                  </tr>
                  <tr>
                    <td>기능 작동성</td>
                    <td><input type="checkbox" name="기능작동성" value="상" class="grade-checkbox"> 기능 모두 정상 작동</td>
                    <td><input type="checkbox" name="기능작동성" value="중" class="grade-checkbox"> 일부 기능 약간 미흡</td>
                    <td><input type="checkbox" name="기능작동성" value="하" class="grade-checkbox"> 기능 중 하나 이상 심각한 문제 있음</td>
                    <td><input type="text" class="comment-input" placeholder="코멘트 입력"></td>
                    <td class="score-cell">20</td>
                  </tr>
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
                  <span class="grade-info-badge grade-f">F</span> 49점 이하 (스토렌/렌탈 이용 불가)
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
      // 검수처리 모달 함수들
      const modal = document.getElementById('inspectionModal');

      // 모달 열기 함수
      function openInspectionModal(button) {
        // 현재 행의 데이터 가져오기
        const row = button.closest('tr');
        const equipCode = row.cells[1].textContent;
        const inspectionType = row.cells[2].textContent;
        const equipName = row.cells[3].textContent;
        const categoryName = row.cells[4].textContent;

        // 모달 폼에 데이터 설정
        document.getElementById('equipCode').value = equipCode;
        document.getElementById('deliveryId').value = 'DELV-' + Math.floor(Math.random() * 10000);
        document.getElementById('inspectionType').value = inspectionType;
        document.getElementById('equipName').value = equipName;
        document.getElementById('equipCategory').value = categoryName;

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

        // 모달 표시
        modal.style.display = 'block';
      }

      // 모달 닫기 함수
      function closeInspectionModal() {
        modal.style.display = 'none';
      }

      // 등급 계산 함수
      function calculateGrade() {
        const deductionPoints = parseInt(document.getElementById('deductionPoints').value) || 0;
        const gradeDisplay = document.getElementById('gradeDisplay');

        // 등급 계산 로직
        let grade;
        if (deductionPoints <= 5) {
          grade = 'S';
          gradeDisplay.className = 'grade-badge grade-s';
        } else if (deductionPoints <= 15) {
          grade = 'A';
          gradeDisplay.className = 'grade-badge grade-a';
        } else if (deductionPoints <= 30) {
          grade = 'B';
          gradeDisplay.className = 'grade-badge grade-b';
        } else if (deductionPoints <= 50) {
          grade = 'C';
          gradeDisplay.className = 'grade-badge grade-c';
        } else {
          grade = 'D';
          gradeDisplay.className = 'grade-badge grade-d';
        }

        gradeDisplay.textContent = grade;
      }

      // 전체 선택 체크박스 이벤트 처리
      document.getElementById('selectAll').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.inspection-index input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
          checkbox.checked = this.checked;
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

      // 폼 제출 처리
      document.getElementById('inspectionForm').addEventListener('submit', function(event) {
        event.preventDefault();

        // 현재 처리 중인 행 참조
        const row = document.querySelector('.process-btn:focus').closest('tr');

        // 최종 등급 가져오기
        const finalGrade = document.getElementById('finalGrade').textContent;

        // 검수 결과 설정 (A, B는 합격, C, D는 대기중, E, F는 불합격)
        let resultType;
        let resultClass;

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
        const resultCell = row.cells[8]; // 검수결과 열의 인덱스

        // 결과 배지 업데이트
        let resultBadge = resultCell.querySelector('.status-badge');
        if (!resultBadge) {
          resultBadge = document.createElement('span');
          resultBadge.className = 'status-badge';
          resultCell.innerHTML = ''; // 기존 내용 삭제
          resultCell.appendChild(resultBadge);
        }

        resultBadge.textContent = resultType;
        resultBadge.className = 'status-badge ' + resultClass;

        // 검수 코멘트 업데이트
        const commentCell = row.cells[9]; // 검수코멘트 열의 인덱스
        commentCell.textContent = commentText;

        // 검수상태 업데이트 (마지막 열)
        const statusCell = row.cells[10]; // 검수상태 열의 인덱스
        let statusBadge = statusCell.querySelector('.status-badge');

        // 상태 배지 업데이트 (없으면 새로 생성)
        if (!statusBadge) {
          statusBadge = document.createElement('span');
          statusBadge.className = 'status-badge';
          statusCell.innerHTML = ''; // 기존 내용 삭제
          statusCell.appendChild(statusBadge);
        }

        statusBadge.textContent = '완료';
        statusBadge.className = 'status-badge status-pass';

        alert('검수 처리가 완료되었습니다.');
        closeInspectionModal();
      });

      // 페이지 로드 시 실행할 초기화 코드
      document.addEventListener('DOMContentLoaded', function() {
        // 장비 관리 메뉴 초기 상태 설정 - 페이지에 맞게 열어두기
        const equipmentMenu = document.querySelectorAll('.menu-button')[1];
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
      });

      // 체크리스트 점수 계산 함수
      function initChecklistFunctionality() {
        const checkboxes = document.querySelectorAll('.grade-checkbox');

        // 각 체크박스에 이벤트 리스너 추가
        checkboxes.forEach(checkbox => {
          checkbox.addEventListener('change', function() {
            // 같은 행의 다른 체크박스 선택 해제
            const name = this.name;
            document.querySelectorAll(`input[name="${name}"]`).forEach(cb => {
              if(cb !== this) cb.checked = false;
            });

            updateScores();
          });
        });

        // 초기 점수 계산
        updateScores();
      }

      // 점수 업데이트 함수
      function updateScores() {
        const rows = document.querySelectorAll('#checklistTable tbody tr:not(.total-row)');
        let totalScore = 0; // 총점 초기화

        rows.forEach(row => {
          const checkboxes = row.querySelectorAll('.grade-checkbox');
          const scoreCell = row.querySelector('.score-cell');

          let score = 20; // 기본 점수 20점
          let selectedGrade = null;

          // 선택된 등급 확인
          checkboxes.forEach(checkbox => {
            if(checkbox.checked) {
              selectedGrade = checkbox.value;

              // 등급별 점수 설정
              switch(selectedGrade) {
                case '상':
                  score = 20; // 감점 없음
                  break;
                case '중':
                  score = 13; // 중간 점수
                  break;
                case '하':
                  score = 6; // 낮은 점수
                  break;
                default:
                  score = 20; // 기본값
              }
            }
          });

          // 점수 업데이트
          scoreCell.textContent = score;

          // 총점 계산에 추가
          totalScore += score;
        });

        // 총점 업데이트
        document.getElementById('totalScore').textContent = totalScore;

        // 등급 계산 및 업데이트
        const finalGradeElement = document.getElementById('finalGrade');
        let gradeClass = '';
        let grade = '';

        if (totalScore >= 90) {
          grade = 'A';
          gradeClass = 'grade-a';
        } else if (totalScore >= 80) {
          grade = 'B';
          gradeClass = 'grade-b';
        } else if (totalScore >= 70) {
          grade = 'C';
          gradeClass = 'grade-c';
        } else if (totalScore >= 60) {
          grade = 'D';
          gradeClass = 'grade-d';
        } else if (totalScore >= 50) {
          grade = 'E';
          gradeClass = 'grade-e';
        } else {
          grade = 'F';
          gradeClass = 'grade-f';
        }

        finalGradeElement.textContent = grade;
        finalGradeElement.className = 'final-grade ' + gradeClass;
      }
    </script>
  </div>
</div>
</body>
