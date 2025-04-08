<%--
  Created by IntelliJ IDEA.
  User: huni
  Date: 25. 4. 7.
  Time: 오전 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자페이지 - 장비리스트</title> <!-- 브라우저 탭에 표시될 제목 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-equipList.css">
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
            <a href="#" style="color: #3f861d; font-weight: bold; border-left: 2px solid #3f861d;">장비 목록</a>
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

        <!-- 거래 관리 메뉴 -->
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
            <h2>장비 목록 조회</h2>
        </div>

        <!-- 렌탈 타입 탭 메뉴 -->
        <div class="rental-type-tabs">
            <div class="rental-tab active" data-tab="all-equipment">전체 장비</div>
            <div class="rental-tab" data-tab="store-rentals">스토렌</div>
            <div class="rental-tab" data-tab="regular-rentals">일반렌탈</div>
        </div>

        <!-- 검색 영역 - 장비 검색 필터링 옵션 -->
        <div class="content-search-info">
            <span>검색유형</span>
            <select>
                <option>장비코드</option>
                <option>장비명</option>
                <option>소유자명</option>
            </select>

            <span>등급</span>
            <select>
                <option>전체</option>
                <option>텐트/타프</option>
                <option>침낭/매트</option>
                <option>캠핑 가구</option>
                <option>조리도구</option>
                <option>랜턴/조명</option>
                <option>기타</option>
            </select>

            <!-- 검색어 입력 -->
            <div class="content-search-bar">
                <input type="search" placeholder="검색어 입력">
            </div>

            <!-- 검색 버튼 -->
            <div class="content-search-btn">
                <input type="button" value="검색하기">
            </div>
        </div>

        <!-- 전체 장비 영역 -->
        <div id="all-equipment" class="content-area active">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 장비 : 287대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : 152대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 : 98대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : 37대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAll"> <label for="selectAll">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table>
                    <tr>
                        <!-- 테이블 헤더 - 각 열의 제목 -->
                        <th class="col-select">선택</th>
                        <th class="col-code">장비코드</th>
                        <th class="col-type">렌탈타입</th>
                        <th class="col-name">장비명</th>
                        <th class="col-category">카테고리</th>
                        <th class="col-grade">등급</th>
                        <th class="col-status">상태</th>
                        <th class="col-rentals">대여횟수</th>
                        <th class="col-last-inspection">마지막 검수일</th>
                        <th class="col-owner">소유자</th>
                        <th class="col-actions">관리</th>
                    </tr>

                    <!-- 장비 데이터 행 -->
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP001</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>코베아 익스페디션 텐트 4인용</td>
                        <td>텐트/타프</td>
                        <td><span class="grade-badge grade-s">S</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>32</td>
                        <td>2025-04-01</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP002</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>네이처하이크 침낭 겨울용</td>
                        <td>침낭/매트</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-rented">대여중</span></td>
                        <td>18</td>
                        <td>2025-03-18</td>
                        <td>산린이</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP003</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>콜맨 파이어플레이스 투버너</td>
                        <td>조리도구</td>
                        <td><span class="grade-badge grade-s">S</span></td>
                        <td><span class="status-badge status-rented">대여중</span></td>
                        <td>45</td>
                        <td>2025-03-25</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP004</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>헬리녹스 체어원 XL</td>
                        <td>캠핑 가구</td>
                        <td><span class="grade-badge grade-b">B</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>27</td>
                        <td>2025-03-12</td>
                        <td>캠퍼맘</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP005</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>블랙다이아몬드 헤드램프</td>
                        <td>랜턴/조명</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-maintenance">정비중</span></td>
                        <td>39</td>
                        <td>2025-04-03</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
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

        <!-- 스토렌 장비 영역 -->
        <div id="store-rentals" class="content-area">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 스토렌 장비 : 142대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : 82대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 : 43대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : 17대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAllStore"> <label for="selectAllStore">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table>
                    <tr>
                        <!-- 테이블 헤더 - 각 열의 제목 -->
                        <th class="col-select">선택</th>
                        <th class="col-code">장비코드</th>
                        <th class="col-type">렌탈타입</th>
                        <th class="col-name">장비명</th>
                        <th class="col-category">카테고리</th>
                        <th class="col-grade">등급</th>
                        <th class="col-status">상태</th>
                        <th class="col-rentals">대여횟수</th>
                        <th class="col-last-inspection">마지막 검수일</th>
                        <th class="col-owner">소유자</th>
                        <th class="col-actions">관리</th>
                    </tr>

                    <!-- 스토렌 장비 데이터 행 -->
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP001</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>코베아 익스페디션 텐트 4인용</td>
                        <td>텐트/타프</td>
                        <td><span class="grade-badge grade-s">S</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>32</td>
                        <td>2025-04-01</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP003</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>콜맨 파이어플레이스 투버너</td>
                        <td>조리도구</td>
                        <td><span class="grade-badge grade-s">S</span></td>
                        <td><span class="status-badge status-rented">대여중</span></td>
                        <td>45</td>
                        <td>2025-03-25</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP005</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>블랙다이아몬드 헤드램프</td>
                        <td>랜턴/조명</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-maintenance">정비중</span></td>
                        <td>39</td>
                        <td>2025-04-03</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP006</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>스노우피크 애드온 타프</td>
                        <td>텐트/타프</td>
                        <td><span class="grade-badge grade-s">S</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>28</td>
                        <td>2025-03-29</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP008</td>
                        <td><span class="rental-type-badge type-store">스토렌</span></td>
                        <td>MSR 포켓로켓 2 버너</td>
                        <td>조리도구</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>41</td>
                        <td>2025-03-20</td>
                        <td>스토렌</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
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

        <!-- 일반렌탈 장비 영역 -->
        <div id="regular-rentals" class="content-area">
            <!-- 장비 정보 요약 - 주요 통계 -->
            <div class="equipment-count">
                <div class="equipment-all">
                    <span>총 일반렌탈 장비 : 145대</span>
                </div>
                <div class="equipment-available">
                    <span>대여 가능 : 70대</span>
                </div>
                <div class="equipment-rented">
                    <span>대여 중 : 55대</span>
                </div>
                <div class="equipment-maintenance">
                    <span>정비 중 : 20대</span>
                </div>
            </div>

            <!-- 전체 선택 체크박스 -->
            <div class="select-all-checkbox">
                <input type="checkbox" id="selectAllRegular"> <label for="selectAllRegular">전체 선택</label>
            </div>

            <!-- 장비 목록 테이블 - 가로 스크롤 가능 -->
            <div class="equipment-index">
                <table>
                    <tr>
                        <!-- 테이블 헤더 - 각 열의 제목 -->
                        <th class="col-select">선택</th>
                        <th class="col-code">장비코드</th>
                        <th class="col-type">렌탈타입</th>
                        <th class="col-name">장비명</th>
                        <th class="col-category">카테고리</th>
                        <th class="col-grade">등급</th>
                        <th class="col-status">상태</th>
                        <th class="col-rentals">대여횟수</th>
                        <th class="col-last-inspection">마지막 검수일</th>
                        <th class="col-owner">소유자</th>
                        <th class="col-actions">관리</th>
                    </tr>

                    <!-- 일반렌탈 장비 데이터 행 -->
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP002</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>네이처하이크 침낭 겨울용</td>
                        <td>침낭/매트</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-rented">대여중</span></td>
                        <td>18</td>
                        <td>2025-03-18</td>
                        <td>산린이</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP004</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>헬리녹스 체어원 XL</td>
                        <td>캠핑 가구</td>
                        <td><span class="grade-badge grade-b">B</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>27</td>
                        <td>2025-03-12</td>
                        <td>캠퍼맘</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP007</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>캠프랜드 접이식 테이블</td>
                        <td>캠핑 가구</td>
                        <td><span class="grade-badge grade-c">C</span></td>
                        <td><span class="status-badge status-available">대여가능</span></td>
                        <td>15</td>
                        <td>2025-03-10</td>
                        <td>참살이</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP009</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>베어본즈 캠핑랜턴</td>
                        <td>랜턴/조명</td>
                        <td><span class="grade-badge grade-b">B</span></td>
                        <td><span class="status-badge status-maintenance">정비중</span></td>
                        <td>22</td>
                        <td>2025-04-02</td>
                        <td>밤산책</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="checkbox-column"><input type="checkbox"></td>
                        <td>CP010</td>
                        <td><span class="rental-type-badge type-regular">일반렌탈</span></td>
                        <td>캠프23 다용도 칼</td>
                        <td>조리도구</td>
                        <td><span class="grade-badge grade-a">A</span></td>
                        <td><span class="status-badge status-rented">대여중</span></td>
                        <td>13</td>
                        <td>2025-03-22</td>
                        <td>요리왕</td>
                        <td>
                            <button class="action-btn">정보</button>
                            <button class="action-btn">검수</button>
                        </td>
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
</div>

<script>
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

    // 페이지 로드 시 실행할 초기화 코드
    document.addEventListener('DOMContentLoaded', function() {
        // 장비 관리 메뉴 초기 상태 설정 - 페이지에 맞게 열어두기
        const equipmentMenu = document.querySelectorAll('.menu-button')[1];
        equipmentMenu.classList.add('active');
        const submenu = equipmentMenu.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + "px";

        // 렌탈 타입 탭 기능 구현
        const tabs = document.querySelectorAll('.rental-tab');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // 모든 탭에서 active 클래스 제거
                tabs.forEach(t => t.classList.remove('active'));

                // 클릭된 탭에 active 클래스 추가
                this.classList.add('active');

                // 모든 콘텐츠 영역 숨기기
                const contentAreas = document.querySelectorAll('.content-area');
                contentAreas.forEach(area => area.classList.remove('active'));

                // 클릭된 탭에 해당하는 콘텐츠 영역 표시
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });

        // 전체 선택 체크박스 이벤트 처리 - 전체 장비
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelector('#all-equipment').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 전체 선택 체크박스 이벤트 처리 - 스토렌 장비
        document.getElementById('selectAllStore').addEventListener('change', function() {
            const checkboxes = document.querySelector('#store-rentals').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 전체 선택 체크박스, 이벤트 처리 - 일반렌탈 장비
        document.getElementById('selectAllRegular').addEventListener('change', function() {
            const checkboxes = document.querySelector('#regular-rentals').querySelectorAll('.equipment-index input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
    });

    // 각 페이지네이션 영역 설정
    document.querySelectorAll('.pagination').forEach(pagination => {
        const pageButtons = pagination.querySelectorAll('.page-numbers .page-btn');
        const firstPageBtn = pagination.querySelector('.first-page');
        const prevPageBtn = pagination.querySelector('.prev-page');
        const nextPageBtn = pagination.querySelector('.next-page');
        const lastPageBtn = pagination.querySelector('.last-page');

        // 현재 페이지를 관리하는 상태 변수
        let currentPage = 1;
        const totalPages = 5; // 예시로 5페이지로 설정 (실제로는 데이터 기반으로 계산)

        // 페이지 버튼 클릭 이벤트
        pageButtons.forEach(button => {
            button.addEventListener('click', function() {
                // 현재 활성화된 버튼에서 active 클래스 제거
                pagination.querySelector('.page-btn.active').classList.remove('active');
                // 클릭한 버튼에 active 클래스 추가
                this.classList.add('active');
                // 현재 페이지 업데이트
                currentPage = parseInt(this.textContent);

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
            pagination.querySelector('.page-btn.active').classList.remove('active');
            // 새 페이지 버튼에 active 클래스 추가
            pageButtons[pageNumber - 1].classList.add('active');
            // 현재 페이지 업데이트
            currentPage = pageNumber;

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