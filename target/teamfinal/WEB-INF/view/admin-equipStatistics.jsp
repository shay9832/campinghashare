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
    <title>관리자 시스템 - 장비통계</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-equipStatistics.css">
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
        <!-- 콘텐츠 헤더 -->
        <div class="content-header">
            <h2>장비통계</h2>
        </div>

        <!-- 탭 메뉴 -->
        <div class="tabs">
            <button class="tab-btn active" data-tab="popular-equipment">카테고리별 인기 장비</button>
            <button class="tab-btn" data-tab="grade-distribution">등급별 장비 분포</button>
        </div>

        <!-- 검색 필터 -->
        <div class="content-search-info">
            <span>기간</span>
            <select>
                <option>전체</option>
                <option>최근 1개월</option>
                <option>최근 3개월</option>
                <option>최근 6개월</option>
                <option>최근 1년</option>
            </select>

            <span>카테고리</span>
            <select>
                <option>전체</option>
                <option>텐트</option>
                <option>타프</option>
                <option>의자</option>
                <option>렌턴</option>
                <option>기타</option>
            </select>

            <span>브랜드</span>
            <select>
                <option>전체</option>
                <option>몬테라</option>
                <option>브루클린윅스</option>
                <option>스노우라인</option>
                <option>듀랑고</option>
                <option>지프</option>
            </select>

            <div class="content-search-btn">
                <input type="button" value="검색하기">
            </div>
        </div>

        <!-- 다운로드 버튼 -->
        <button class="download-btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                <polyline points="7 10 12 15 17 10"></polyline>
                <line x1="12" y1="15" x2="12" y2="3"></line>
            </svg>
            통계 데이터 내보내기
        </button>

        <!-- 카테고리별 인기 장비 탭 콘텐츠 -->
        <div class="tab-content active" id="popular-equipment">
            <!-- 통계 카드 -->
            <div class="statistics-cards">
                <div class="statistic-card">
                    <h3>총 장비 렌탈 수</h3>
                    <div class="value">42,851</div>
                    <div class="change positive">+12.5% 전월 대비</div>
                </div>
                <div class="statistic-card">
                    <h3>인기 카테고리</h3>
                    <div class="value">텐트</div>
                    <div class="change">전체의 38%</div>
                </div>
                <div class="statistic-card">
                    <h3>인기 브랜드</h3>
                    <div class="value">듀랑고</div>
                    <div class="change">전체의 29%</div>
                </div>
                <div class="statistic-card">
                    <h3>가장 많이 대여된 장비</h3>
                    <div class="value">에어300</div>
                    <div class="change positive">+18.3% 전월 대비</div>
                </div>
            </div>

            <!-- 인기 장비 차트 -->
            <div class="chart-container">
                <!-- 차트가 들어갈 자리 (실제 구현 시 차트 라이브러리 사용) -->
                <img src="/api/placeholder/800/350" alt="인기 장비 차트 예시" style="width: 100%; height: 100%; object-fit: contain;">
            </div>

            <!-- 인기 장비 테이블 -->
            <div class="statistics-table">
                <table>
                    <tr>
                        <th>카테고리명</th>
                        <th>브랜드명</th>
                        <th>장비명</th>
                        <th>렌탈건수</th>
                        <th>스토렌 렌탈건수</th>
                        <th>총 렌탈수</th>
                    </tr>
                    <tr>
                        <td>카메라</td>
                        <td>소니</td>
                        <td>Sony A7S III</td>
                        <td>2,845</td>
                        <td>1,253</td>
                        <td>4,098</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- 등급별 장비 분포 탭 콘텐츠 -->
        <div class="tab-content" id="grade-distribution">
            <!-- 통계 카드 -->
            <div class="statistics-cards">
                <div class="statistic-card">
                    <h3>전체 장비 수</h3>
                    <div class="value">4,328</div>
                    <div class="change positive">+8.2% 전월 대비</div>
                </div>
                <div class="statistic-card">
                    <h3>최다 등급</h3>
                    <div class="value">B등급</div>
                    <div class="change">전체의 35%</div>
                </div>
                <div class="statistic-card">
                    <h3>S등급 장비 비율</h3>
                    <div class="value">12%</div>
                    <div class="change positive">+2.1% 전월 대비</div>
                </div>
                <div class="statistic-card">
                    <h3>장비 평균 등급</h3>
                    <div class="value">B등급</div>
                    <div class="change">(점수: 3.2/5.0)</div>
                </div>
            </div>

            <!-- 등급별 장비 분포 차트 -->
            <div class="chart-container">
                <!-- 차트가 들어갈 자리 (실제 구현 시 차트 라이브러리 사용) -->
                <img src="/api/placeholder/800/350" alt="등급별 장비 분포 차트 예시" style="width: 100%; height: 100%; object-fit: contain;">
            </div>

            <!-- 등급별 장비 분포 테이블 -->
            <div class="statistics-table">
                <table>
                    <tr>
                        <th>카테고리명</th>
                        <th>장비등급</th>
                        <th>장비수</th>
                        <th>비율</th>
                    </tr>
                    <tr>
                        <td>카메라</td>
                        <td><span class="grade-badge grade-s">S등급</span></td>
                        <td>128</td>
                        <td>10.2%</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // 드롭다운 메뉴 기능 구현
    const menuButtons = document.querySelectorAll('.menu-button');

    menuButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('active');
            const submenu = this.nextElementSibling;

            if (submenu.style.maxHeight) {
                submenu.style.maxHeight = null;
            } else {
                submenu.style.maxHeight = submenu.scrollHeight + 'px';
            }
        });
    });

    // 탭 전환 기능
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 모든 탭 버튼에서 active 클래스 제거
            tabButtons.forEach(btn => btn.classList.remove('active'));
            // 현재 클릭한 버튼에 active 클래스 추가
            this.classList.add('active');

            // 모든 탭 콘텐츠 숨기기
            tabContents.forEach(content => content.classList.remove('active'));
            // 클릭한 탭에 해당하는 콘텐츠 표시
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // 초기화: 활성화된 메뉴의 하위 메뉴 펼치기
    document.querySelectorAll('.menu-button.active').forEach(button => {
        const submenu = button.nextElementSibling;
        submenu.style.maxHeight = submenu.scrollHeight + 'px';
    });

    // 데이터 다운로드 기능
    document.querySelector('.download-btn').addEventListener('click', function() {
        alert('통계 데이터가 Excel 파일로 다운로드됩니다.');
        // 실제 구현 시 서버에 AJAX 요청하여 파일 다운로드 처리
    });
</script>
</body>
</html>
