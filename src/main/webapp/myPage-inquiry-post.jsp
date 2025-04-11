<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 1:1 문의 조회</title>
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
        /* 1:1 문의 조회 페이지 스타일 */
        .inquiry-view-container {
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            padding: var(--spacing-lg);
        }

        .inquiry-header {
            border-bottom: 1px solid var(--border-medium);
            padding-bottom: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }

        .inquiry-title {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            color: var(--text-primary);
            margin-bottom: var(--spacing-sm);
        }

        .inquiry-meta {
            display: flex;
            justify-content: space-between;
            font-size: var(--font-xs);
            color: var(--text-tertiary);
        }

        .inquiry-meta-left {
            display: flex;
            gap: var(--spacing-md);
        }

        .inquiry-label {
            color: var(--text-secondary);
            font-weight: var(--font-medium);
        }

        .inquiry-content {
            min-height: 300px;
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-md);
            white-space: pre-line;
            line-height: 1.6;
        }

        .inquiry-attachments {
            margin-top: var(--spacing-md);
            padding: var(--spacing-md);
            background-color: var(--bg-secondary);
            border-radius: var(--radius-sm);
        }

        .attachment-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .attachment-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            padding: var(--spacing-xs) 0;
        }

        .attachment-icon {
            color: var(--text-tertiary);
        }

        .attachment-link {
            color: var(--text-primary);
            text-decoration: none;
        }

        .attachment-link:hover {
            text-decoration: underline;
            color: var(--color-maple);
        }

        .inquiry-answer {
            margin-top: var(--spacing-xl);
            padding: var(--spacing-md);
            background-color: var(--bg-secondary);
            border-radius: var(--radius-md);
            border-left: 4px solid var(--color-maple);
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-md);
        }

        .answer-title {
            font-weight: var(--font-bold);
            color: var(--color-maple);
        }

        .answer-date {
            font-size: var(--font-xs);
            color: var(--text-tertiary);
        }

        .answer-content {
            white-space: pre-line;
            line-height: 1.6;
        }

        /* 이전글/다음글 영역 */
        .inquiry-nav {
            margin-top: var(--spacing-xl);
            border-top: 1px solid var(--border-medium);
            border-bottom: 1px solid var(--border-medium);
        }

        .nav-item {
            display: flex;
            padding: var(--spacing-md);
            border-bottom: 1px solid var(--border-light);
        }

        .nav-item:last-child {
            border-bottom: none;
        }

        .nav-label {
            flex: 0 0 100px;
            font-weight: var(--font-medium);
            color: var(--text-secondary);
        }

        .nav-title {
            flex: 1;
            color: var(--text-primary);
            text-decoration: none;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .nav-title:hover {
            color: var(--color-maple);
            text-decoration: underline;
        }

        .nav-date {
            flex: 0 0 120px;
            text-align: right;
            color: var(--text-tertiary);
            font-size: var(--font-xs);
        }

        /* 버튼 영역 */
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-lg);
        }

        .btn-secondary:hover {
            color: #000 !important;
        }

        /* 모달 스타일 */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: var(--z-modal);
        }

        .modal {
            background-color: var(--bg-primary);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            min-width: 400px;
            text-align: center;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            font-size: var(--font-md);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-lg);
            color: var(--text-primary);
        }

        .modal-footer {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
            margin-top: var(--spacing-lg);
        }

        /* 답변 상태 뱃지 */
        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-medium);
            margin-left: var(--spacing-sm);
        }

        .status-pending {
            background-color: var(--color-gray-200);
            color: var(--text-secondary);
        }

        .status-completed {
            background-color: var(--color-maple-light);
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
                <a href="#" class="sidebar-link title">
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
                <a href="#" class="sidebar-link title active">
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
            <h2 class="page-title"><i class="fa-solid fa-headset"></i> 1:1 문의 상세보기</h2>
        </div>

        <div class="content-box p-5">
            <!-- 문의 상세 내용 -->
            <div class="inquiry-view-container">
                <!-- 문의 헤더 -->
                <div class="inquiry-header">
                    <div class="inquiry-title">
                        [거래] 대여 완료 후 반납 과정에서 문제가 있었습니다
                        <span class="status-badge status-completed">답변완료</span>
                    </div>
                    <div class="inquiry-meta">
                        <div class="inquiry-meta-left">
                            <div><span class="inquiry-label">작성자:</span> 캠핑매니아</div>
                            <div><span class="inquiry-label">작성일:</span> 2023-09-15 14:30</div>
                        </div>
                        <div class="inquiry-meta-right">
                            <div><span class="inquiry-label">문의번호:</span> INQ-20230915-001</div>
                        </div>
                    </div>
                </div>

                <!-- 문의 내용 -->
                <div class="inquiry-content">
                    안녕하세요, 지난주에 텐트를 대여했는데 반납 과정에서 문제가 있었습니다.

                    반납 당일 약속한 시간보다 30분 일찍 도착했는데, 대여자가 나타나지 않아 1시간 넘게 기다렸습니다.
                    연락도 되지 않았고, 결국 다른 약속 시간에 늦게 되어 큰 불편을 겪었습니다.

                    이런 경우 어떻게 처리해야 하나요? 대여자에 대한 신뢰도 평가 시스템이 있는지도 궁금합니다.
                    앞으로 이런 일이 없도록 시스템 개선을 부탁드립니다.
                </div>

                <!-- 첨부파일 영역 -->
                <div class="inquiry-attachments">
                    <h6><i class="fa-solid fa-paperclip"></i> 첨부파일</h6>
                    <ul class="attachment-list">
                        <li class="attachment-item">
                            <i class="fa-solid fa-file-image attachment-icon"></i>
                            <a href="#" class="attachment-link">텐트_대여_영수증.jpg</a>
                            <span class="attachment-size">(2.1MB)</span>
                        </li>
                        <li class="attachment-item">
                            <i class="fa-solid fa-file-pdf attachment-icon"></i>
                            <a href="#" class="attachment-link">대화내용_캡처.pdf</a>
                            <span class="attachment-size">(1.5MB)</span>
                        </li>
                    </ul>
                </div>

                <!-- 관리자 답변 영역 -->
                <div class="inquiry-answer">
                    <div class="answer-header">
                        <div class="answer-title"><i class="fa-solid fa-reply"></i> 관리자 답변</div>
                        <div class="answer-date">2023-09-16 10:15</div>
                    </div>
                    <div class="answer-content">
                        안녕하세요, 캠핑매니아님

                        불편을 겪으셨다니 정말 죄송합니다.

                        저희 플랫폼에서는 '렌탈' 거래에 대한 소유자-대여자 서로 간 '만족도 평가' 기능을 제공하고 있습니다.
                        마이페이지 '만족도 평가'에 문제 부분 감안하여 별점 평가 및 코멘트 남겨주시면,
                        해당 결과 누적되며 유저에 대한 신뢰도 변동되는 점 참고해주길 바랍니다.

                        향후에는 이러한 개인 간 렌탈거래에서의 불편사항을 개선하고자 만든 '스토렌' 시스템을 이용해주시면,
                        검수부터 배송 전반 플랫폼이 책임지고 진행해드릴 수 있사오니
                        많은 관심 부탁 드리겠습니다.

                        추가 문의사항이 있으시면 언제든지 문의해 주시기 바랍니다.

                        감사합니다.
                        캠핑하쉐어 고객센터 드림
                    </div>
                </div>

                <!-- 이전글/다음글 내비게이션 -->
                <div class="inquiry-nav">
                    <div class="nav-item">
                        <div class="nav-label">이전글</div>
                        <a href="#" class="nav-title">[회원정보] 회원 등급 업그레이드는 어떻게 하나요?</a>
                        <div class="nav-date">2023-09-10</div>
                    </div>
                    <div class="nav-item">
                        <div class="nav-label">다음글</div>
                        <a href="#" class="nav-title">[신규 등록 요청] 새로운 장비 카테고리를 추가해주세요</a>
                        <div class="nav-date">2023-09-20</div>
                    </div>
                </div>

                <!-- 버튼 영역 -->
                <div class="button-group">
                    <div class="center-buttons">
                        <button type="button" class="btn btn-secondary" id="listBtn">목록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/view/footer.jsp" />

<!-- 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function() {
        // 목록 버튼 클릭 시 목록 페이지로 이동
        $('#listBtn').click(function() {
            location.href = 'myPage-inquiry.jsp';
        });
    });
</script>
</body>
</html>