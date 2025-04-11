<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko"> <!-- 한국어 페이지 설정 -->
<head>
    <meta charset="UTF-8"> <!-- 문자 인코딩 UTF-8 설정 -->
    <title>관리자 시스템 - 쿠폰 조회</title> <!-- 브라우저 탭에 표시될 제목 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-couponList.css">
    <style>
    </style>
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
        <button class="menu-button">장비 관리</button>
        <div class="submenu">
            <a href="#">장비 목록</a>
            <a href="#">검수 목록</a>
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

        <!-- 배송 관리 메뉴 -->
        <button class="menu-button">배송 관리</button>
        <div class="submenu">
            <a href="#">배송 현황</a>
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

        <!-- 쿠폰 관리 메뉴 -->
        <button class="menu-button active">쿠폰 관리</button>
        <div class="submenu" style="max-height: 200px;">
            <a href="#">쿠폰 발급</a>
            <a href="#" style="color: #3f861d; font-weight: bold; border-left: 2px solid #3f861d;">쿠폰 조회</a>
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
            <h2>쿠폰 조회</h2>
        </div>

        <!-- 검색 영역 - 쿠폰 검색 필터링 옵션 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select>
                <option>이름</option>
                <option>전화번호</option>
                <option>이메일</option>
                <option>닉네임</option>
            </select>

            <span>쿠폰 종류</span>
            <select>
                <option>전체</option>
                <option>신규가입 쿠폰</option>
                <option>첫 구매 할인 쿠폰</option>
                <option>생일 축하 쿠폰</option>
                <option>리뷰 작성 보상 쿠폰</option>
                <option>VIP 회원 전용 쿠폰</option>
                <option>계절 할인 쿠폰</option>
                <option>이벤트 쿠폰</option>
            </select>

            <span>상태</span>
            <select>
                <option>전체</option>
                <option>활성화</option>
                <option>사용됨</option>
                <option>만료됨</option>
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

        <!-- 쿠폰 정보 요약 - 주요 통계 -->
        <div class="coupon-count">
            <div class="coupon-all">
                <span>총 쿠폰 수 : 3,450장</span>
            </div>
            <div class="coupon-used">
                <span>사용된 쿠폰 : 1,245장</span>
            </div>
            <div class="coupon-active">
                <span>유효 쿠폰 : 2,205장</span>
            </div>
        </div>

        <!-- 전체 선택 체크박스 -->
        <div class="select-all-checkbox">
            <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
        </div>

        <!--삭제 버튼-->
        <div class="delete-btn">
            <input type="button" class="delete" value="삭제하기">
        </div>

        <!-- 쿠폰 목록 테이블 - 가로 스크롤 가능 -->
        <div class="coupon-index">
            <table>
                <tr>
                    <!-- 테이블 헤더 - 각 열의 제목 -->
                    <th class="col-select">선택</th>
                    <th class="col-id">회원번호</th>
                    <th class="col-name">이름</th>
                    <th class="col-phone">핸드폰번호</th>
                    <th class="col-nickname">닉네임</th>
                    <th class="col-email">이메일주소</th>
                    <th class="col-coupon-type">쿠폰종류</th>
                    <th class="col-coupon-usage">쿠폰사용횟수</th>
                    <th class="col-status">상태</th>
                </tr>

                <!-- 쿠폰 데이터 행 -->
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>1</td>
                    <td>김철수</td>
                    <td>010-1234-5678</td>
                    <td>철수123</td>
                    <td>chulsoo@example.com</td>
                    <td>신규가입 쿠폰</td>
                    <td>0</td>
                    <td><span class="status-badge status-active">활성화</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>2</td>
                    <td>이영희</td>
                    <td>010-9876-5432</td>
                    <td>영희야</td>
                    <td>yhlee@example.com</td>
                    <td>첫 구매 할인 쿠폰</td>
                    <td>1</td>
                    <td><span class="status-badge status-used">사용됨</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>3</td>
                    <td>박지민</td>
                    <td>010-5555-6666</td>
                    <td>지민이</td>
                    <td>jimin@example.com</td>
                    <td>생일 축하 쿠폰</td>
                    <td>0</td>
                    <td><span class="status-badge status-active">활성화</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>4</td>
                    <td>최수진</td>
                    <td>010-1111-2222</td>
                    <td>수진맘</td>
                    <td>sjchoi@example.com</td>
                    <td>리뷰 작성 보상 쿠폰</td>
                    <td>2</td>
                    <td><span class="status-badge status-used">사용됨</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>5</td>
                    <td>정민호</td>
                    <td>010-7777-8888</td>
                    <td>민호쓰</td>
                    <td>minho@example.com</td>
                    <td>VIP 회원 전용 쿠폰</td>
                    <td>0</td>
                    <td><span class="status-badge status-active">활성화</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>6</td>
                    <td>오은지</td>
                    <td>010-3333-4444</td>
                    <td>은지공주</td>
                    <td>ejoh@example.com</td>
                    <td>계절 할인 쿠폰</td>
                    <td>0</td>
                    <td><span class="status-badge status-expired">만료됨</span></td>
                </tr>
                <tr>
                    <td class="checkbox-column"><input type="checkbox"></td>
                    <td>7</td>
                    <td>강현우</td>
                    <td>010-9999-0000</td>
                    <td>강하다</td>
                    <td>hwkang@example.com</td>
                    <td>이벤트 쿠폰</td>
                    <td>1</td>
                    <td><span class="status-badge status-used">사용됨</span></td>
                </tr>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <button class="page-btn first-page">&laquo;</button>
            <button class="page-btn prev-page">&lt;</button>
            <div class="page-numbers">
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">4</button>
                <button class="page-btn">5</button>
            </div>
            <button class="page-btn next-page">&gt;</button>
            <button class="page-btn last-page">&raquo;</button>
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

    // 전체 선택 체크박스 기능 구현
    const selectAllCheckbox = document.getElementById('selectAll');
    const rowCheckboxes = document.querySelectorAll('.coupon-index td.checkbox-column input[type="checkbox"]');

    // 전체 선택 체크박스 이벤트 리스너
    selectAllCheckbox.addEventListener('change', function() {
        // 행 체크박스만 선택하도록 수정
        rowCheckboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    // 개별 체크박스 상태 변화에 따른 전체 선택 체크박스 상태 업데이트
    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // 모든 체크박스가 선택되었는지 확인 (행 체크박스만 대상으로)
            const allChecked = Array.from(rowCheckboxes).every(cb => cb.checked);
            // 전체 선택 체크박스 상태 업데이트
            selectAllCheckbox.checked = allChecked;
        });
    });

    // 페이지네이션 기능 구현
    document.addEventListener('DOMContentLoaded', function() {
        const pageButtons = document.querySelectorAll('.page-numbers .page-btn');
        const firstPageBtn = document.querySelector('.first-page');
        const prevPageBtn = document.querySelector('.prev-page');
        const nextPageBtn = document.querySelector('.next-page');
        const lastPageBtn = document.querySelector('.last-page');

        // 현재 페이지를 관리하는 상태 변수
        let currentPage = 1;
        const totalPages = 5; // 예시로 5페이지로 설정 (실제로는 데이터 기반으로 계산)

        // 페이지 버튼 클릭 이벤트
        pageButtons.forEach(button => {
            button.addEventListener('click', function() {
                // 현재 활성화된 버튼에서 active 클래스 제거
                document.querySelector('.page-btn.active').classList.remove('active');
                // 클릭한 버튼에 active 클래스 추가
                this.classList.add('active');
                // 현재 페이지 업데이트
                currentPage = parseInt(this.textContent);

                // 여기에 실제 데이터 로드 또는 페이지 변경 로직 추가
                console.log('페이지 변경:', currentPage);

                // 처음/이전/다음/마지막 버튼 상태 업데이트
                updateNavigationButtons();
            });
        });

        // 처음 페이지 버튼 클릭 이벤트
        firstPageBtn.addEventListener('click', function() {
            if (currentPage !== 1) {
                goToPage(1);
            }
        });

        // 이전 페이지 버튼 클릭 이벤트
        prevPageBtn.addEventListener('click', function() {
            if (currentPage > 1) {
                goToPage(currentPage - 1);
            }
        });

        // 다음 페이지 버튼 클릭 이벤트
        nextPageBtn.addEventListener('click', function() {
            if (currentPage < totalPages) {
                goToPage(currentPage + 1);
            }
        });

        // 마지막 페이지 버튼 클릭 이벤트
        lastPageBtn.addEventListener('click', function() {
            if (currentPage !== totalPages) {
                goToPage(totalPages);
            }
        });

        // 특정 페이지로 이동하는 함수
        function goToPage(pageNumber) {
            // 현재 활성화된 버튼에서 active 클래스 제거
            document.querySelector('.page-btn.active').classList.remove('active');
            // 새 페이지 버튼에 active 클래스 추가
            pageButtons[pageNumber - 1].classList.add('active');
            // 현재 페이지 업데이트
            currentPage = pageNumber;

            // 여기에 실제 데이터 로드 또는 페이지 변경 로직 추가
            console.log('페이지 변경:', currentPage);

            // 처음/이전/다음/마지막 버튼 상태 업데이트
            updateNavigationButtons();
        }

        // 네비게이션 버튼 상태 업데이트 함수
        function updateNavigationButtons() {
            // 첫 페이지일 경우 처음/이전 버튼 비활성화
            firstPageBtn.disabled = currentPage === 1;
            prevPageBtn.disabled = currentPage === 1;

            // 마지막 페이지일 경우 다음/마지막 버튼 비활성화
            nextPageBtn.disabled = currentPage === totalPages;
            lastPageBtn.disabled = currentPage === totalPages;
        }

        // 초기 상태 설정
        updateNavigationButtons();
    });
</script>
</body>
</html>