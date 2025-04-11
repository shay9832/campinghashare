<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 캠핑일지 조회</title>
    <!-- 외부 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css">
    <!-- 메인 CSS 로드 (모든 스타일시트 통합) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- 마이페이지 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 마이페이지 사이드바 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-sidebar.css">
    <!-- 제이쿼리 사용 CDN 방식 -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

    <style>
        /* 캠핑일지 조회 페이지 스타일 */
        .diary-post-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            padding: var(--spacing-lg);
        }

        /* 캠핑일지 헤더 */
        .diary-header {
            border-bottom: 1px solid var(--border-medium);
            padding-bottom: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }

        .diary-title {
            font-size: var(--font-lg);
            font-weight: var(--font-bold);
            color: var(--text-primary);
            margin-bottom: var(--spacing-sm);
        }

        .diary-meta {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-md);
            font-size: var(--font-xs);
            color: var(--text-tertiary);
        }

        .diary-meta-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-xxs);
        }

        .diary-meta-item i {
            color: var(--color-maple);
        }

        /* 날씨 표시 */
        .weather-badge {
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-xxs);
            background-color: var(--color-beige);
            padding: var(--spacing-xxs) var(--spacing-sm);
            border-radius: var(--radius-lg);
            font-size: var(--font-xxs);
            margin-left: var(--spacing-sm);
        }

        /* 캠핑일지 내용 */
        .diary-content {
            padding: var(--spacing-md) 0;
            min-height: 300px;
            line-height: 1.6;
            color: var(--text-primary);
        }

        /* 지도 영역 */
        .map-container {
            margin: var(--spacing-lg) 0;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-sm);
            overflow: hidden;
        }

        .map-header {
            background-color: var(--bg-secondary);
            padding: var(--spacing-sm);
            border-bottom: 1px solid var(--border-medium);
            font-weight: var(--font-semibold);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .map-header i {
            color: var(--color-maple);
        }

        .map-view {
            height: 300px;
            background-color: var(--color-gray-100);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-tertiary);
        }

        /* 버튼 영역 */
        .post-navigation {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-lg);
            padding-top: var(--spacing-md);
            border-top: 1px solid var(--border-medium);
        }

        .nav-buttons {
            display: flex;
            gap: var(--spacing-sm);
        }

        .nav-btn {
            background-color: var(--bg-secondary);
            border: 1px solid var(--border-medium);
            color: var(--text-secondary);
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            transition: all var(--transition-normal);
        }

        .nav-btn:hover {
            background-color: var(--color-beige);
            border-color: var(--color-maple);
            color: var(--color-maple);
        }

        .list-btn {
            background-color: var(--color-maple);
            color: var(--color-white);
            border: none;
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-sm);
            font-size: var(--font-xs);
            transition: background-color var(--transition-normal);
        }

        .list-btn:hover {
            background-color: var(--btn-primary-hover-bg);
        }

        /* 이미지 스타일 */
        .diary-content img {
            max-width: 100%;
            height: auto;
            border-radius: var(--radius-sm);
            margin: var(--spacing-sm) 0;
        }

        /* 수정/삭제 버튼 */
        .diary-actions {
            display: flex;
            gap: var(--spacing-sm);
        }

        .action-btn {
            background-color: transparent;
            border: none;
            color: var(--text-tertiary);
            font-size: var(--font-xs);
            cursor: pointer;
            padding: 0;
        }

        .action-btn:hover {
            color: var(--color-maple);
        }
    </style>
</head>
<body>
<jsp:include page="WEB-INF/view/header.jsp" />

<div class="container mypage-container section">

    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-infoEdit-passwordCheck.jsp" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="#" class="sidebar-link">회원 등급</a></li>
                    <li><a href="#" class="sidebar-link">신뢰도</a></li>
                    <li><a href="#" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title active">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title"><i class="fa-solid fa-book-open"></i>캠핑일지</h2>
        </div>

        <div class="content-box p-5">
            <div class="diary-post-container">
                <!-- 캠핑일지 헤더 -->
                <div class="diary-header">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <h1 class="diary-title">가을 단풍이 아름다운 청계산 캠핑</h1>
                        <div class="diary-actions">
                            <button type="button" class="action-btn" id="editBtn"><i class="fa-solid fa-pen"></i> 수정</button>
                            <button type="button" class="action-btn" id="deleteBtn"><i class="fa-solid fa-trash"></i> 삭제</button>
                        </div>
                    </div>
                    <div class="diary-meta">
                        <div class="diary-meta-item">
                            <i class="fa-regular fa-calendar"></i>
                            <span>2024-10-15 ~ 2024-10-17</span>
                        </div>
                        <div class="diary-meta-item">
                            <i class="fa-regular fa-clock"></i>
                            <span>작성일: 2024-10-20</span>
                        </div>
                        <div class="diary-meta-item">
                            <i class="fa-regular fa-eye"></i>
                            <span>조회수: 24</span>
                        </div>
                        <div class="diary-meta-item">
                            <i class="fa-solid fa-cloud-sun" style="color: #87CEEB;"></i>
                            <span class="weather-badge">구름조금</span>
                        </div>
                    </div>
                </div>

                <!-- 캠핑일지 내용 -->
                <div class="diary-content">
                    <p>지난 주말, 가족들과 함께 청계산으로 캠핑을 다녀왔습니다. 가을 단풍이 절정이라 정말 아름다웠어요.</p>

                    <p>첫날은 텐트 설치와 저녁 식사 준비로 바빴습니다. 준비해 간 삼겹살과 소시지를 구워먹었는데, 캠핑장에서 먹는 바베큐는 정말 별미입니다.</p>

                    <img src="/api/placeholder/700/400" alt="캠핑 사진" />

                    <p>둘째 날은 아침부터 산책을 나갔습니다. 청계산 등산로를 따라 걸으며 단풍을 감상했어요. 공기도 맑고 경치도 좋아서 정말 힐링이 되었습니다.</p>

                    <p>점심에는 미리 준비해간 된장찌개를 끓여 먹었습니다. 캠핑용 가스버너로 끓인 된장찌개지만 야외에서 먹으니 더욱 맛있게 느껴졌어요.</p>

                    <img src="/api/placeholder/700/400" alt="캠핑 요리 사진" />

                    <p>셋째 날은 간단히 아침을 먹고 주변 정리를 한 후 귀가했습니다. 비록 짧은 여행이었지만 가족들과 함께 한 소중한 시간이었습니다.</p>

                    <p>다음에는 좀 더 장비를 보완해서 다시 방문해보려고 합니다. 특히 야간에 좀 더 따뜻하게 지낼 수 있는 난방 장비가 필요할 것 같아요.</p>
                </div>

                <!-- 지도 영역 -->
                <div class="map-container">
                    <div class="map-header">
                        <i class="fa-solid fa-location-dot"></i>
                        <span>캠핑 위치</span>
                    </div>
                    <div class="map-view" id="map">
                        카카오맵 API가 연결될 예정입니다
                    </div>
                </div>

                <!-- 이전글/다음글 네비게이션 -->
                <div class="post-navigation">
                    <div class="nav-buttons">
                        <a href="#" class="nav-btn">
                            <i class="fa-solid fa-chevron-left"></i>
                            <span>이전글</span>
                        </a>
                        <a href="#" class="nav-btn">
                            <span>다음글</span>
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </div>
                    <a href="myPage-diary.jsp" class="list-btn">목록</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal-overlay" id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div class="modal" style="background-color: white; padding: 20px; border-radius: 8px; min-width: 400px; text-align: center; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <div class="modal-header" style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">캠핑일지를 삭제 하시겠습니까?</div>
        <div class="modal-footer" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button class="btn btn-secondary" id="cancelDeleteBtn">취소</button>
            <button class="btn btn-danger" id="confirmDeleteBtn">삭제</button>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/view/footer.jsp" />

<!-- 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // 수정 버튼 클릭 이벤트
        $('#editBtn').click(function() {
            // 수정 페이지로 이동
            location.href = 'myPage-diary-edit.jsp?id=123'; // 실제로는 해당 게시글 ID를 파라미터로 전달
        });

        // 삭제 버튼 클릭 이벤트
        $('#deleteBtn').click(function() {
            // 삭제 확인 모달 표시
            $('#deleteModal').css('display', 'flex');
        });

        // 삭제 취소 버튼 클릭 이벤트
        $('#cancelDeleteBtn').click(function() {
            $('#deleteModal').css('display', 'none');
        });

        // 삭제 확인 버튼 클릭 이벤트
        $('#confirmDeleteBtn').click(function() {
            // 삭제 처리 후 목록 페이지로 이동
            // 실제로는 AJAX 요청으로 서버에 삭제 요청을 보내야 함
            alert('캠핑일지가 삭제되었습니다.');
            location.href = 'myPage-diary.jsp';
        });

        // 카카오맵 API 연결 예시 (실제로는 API 키와 함께 사용해야 함)
        // 이 부분은 실제 API 키를 사용하여 구현하셔야 합니다
        function initMap() {
            // 카카오맵 초기화 코드를 여기에 작성
            console.log('지도를 초기화합니다.');
        }

        // 페이지 로드 시 지도 초기화 시도
        try {
            // 카카오맵 API가 로드되었는지 확인
            if (typeof kakao !== 'undefined' && kakao.maps) {
                initMap();
            } else {
                console.log('카카오맵 API가 로드되지 않았습니다.');
            }
        } catch (e) {
            console.error('지도 초기화 중 오류 발생:', e);
        }
    });
</script>
</body>
</html>