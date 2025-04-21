<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 마이페이지</title>
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
        /* 테이블에만 적용되는 스타일 */
        #boardfree-table th,
        #boardfree-table td {
            width: auto !important;
            min-width: auto !important;
        }

        /* 게시판 특화 스타일 */
        .board-category-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-semibold);
            margin-right: 8px;
        }

        .board-category-tag.question {
            background-color: #e3f2fd;
            color: #0066cc;
        }

        .board-category-tag.review {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .board-category-tag.chat {
            background-color: #f3e5f5;
            color: #7b1fa2;
        }

        .board-category-tag.notice {
            background-color: #fff9c4;
            color: #ffa000;
        }

        .board-category-tag.freeboard {
            background-color: #e3f2fd;
            color: #0066cc;
        }

        .board-category-tag.solocamping {
            background-color: #ffebee;
            color: #d32f2f;
        }

        .notice-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: var(--color-error);
            color: var(--color-white);
        }

        .hot-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: #ff6b6b;
            color: white;
        }

        .hot-number {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-bold);
            background-color: #ff9800;
            color: white;
        }

        .title-cell {
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-left: 10px;
        }

        .title-cell a:hover {
            text-decoration: underline;
            color: var(--color-maple);
        }

        .board-row.notice {
            background-color: #fff8e1;
        }

        .board-row.hot-post {
            background-color: #ffebee;
        }

        .icon-heart {
            color: var(--color-error);
        }

        .icon-eye {
            color: var(--text-secondary);
        }

        .icon-comment {
            color: var(--color-info);
        }

        .table-icon {
            margin-right: 5px;
        }

        .filter-btn {
            padding: 6px 16px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-medium);
            background-color: var(--bg-secondary);
            cursor: pointer;
            transition: all var(--transition-normal);
            font-size: var(--font-xs);
        }

        .filter-btn:hover {
            background-color: var(--color-gray-200);
        }

        .filter-btn.active {
            background-color: var(--color-beige-light);
            border-color: var(--color-maple);
            color: var(--color-maple);
            font-weight: var(--font-semibold);
        }

        .info-line {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 0 5px;
        }

        .info-text {
            color: var(--text-secondary);
            font-size: var(--font-sm);
        }
        .empty-state-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 200px; /* 슬라이더와 비슷한 높이로 조정 */
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            background-color: var(--bg-secondary);
            margin: 20px 0;
        }

        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            text-align: center;
            color: var(--text-secondary);
            width: 100%;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--color-gray-300);
        }

        .empty-state p {
            font-size: var(--font-md);
            margin-bottom: 15px;
        }

        .empty-state .empty-action {
            font-size: var(--font-sm);
            padding: 8px 16px;
            border-color: var(--color-maple-light);
            color: var(--color-maple);
            border-radius: var(--radius-sm);
            transition: all var(--transition-normal);
            cursor: pointer;
        }

        .empty-state .empty-action:hover {
            background-color: var(--color-maple);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

<div class="container container-wide mypage-container section">
    <!-- 마이페이지 사이드바 -->
    <div class="sidebar">
        <div class="sidebar-title">마이 페이지</div>
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>회원 관리</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-infoedit-passwordcheck.action" class="sidebar-link">회원 정보 수정</a></li>
                    <li><a href="mypage-trust.action" class="sidebar-link">신뢰도</a></li>
                    <li><a href="mypage-point.action" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="mypage-myequip.action" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="mypage-inspecList.action" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="mypage-delivery.action" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="mypage-matchinglist.action" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="mypage-rentequip.action" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="mypage-mypost.action" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-wishlist.action" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-diary.action" class="sidebar-link title">
                    <span>나의 캠핑일지</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-bookmark.action" class="sidebar-link title">
                    <span>북마크</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-coupon.action" class="sidebar-link title">
                    <span>쿠폰 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-inquiry.action" class="sidebar-link title">
                    <span>1:1 문의 내역</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="mypage-leave.action" class="sidebar-link title">
                    <span>회원 탈퇴</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">마이 페이지</h2>
        </div>

        <!-- 회원 정보 섹션 -->
        <div class="content-box">
            <div class="user-info-section">
                <div class="user-info-content">
                    <div class="user-details">
                        <h3>${user.nickname} 님</h3>
                        <div class="user-status">
                            <span>회원 등급: ${user.userGrade}</span>
                            <span class="profit-info">총 수익 +${user.totalProfit}원</span>
                        </div>
                        <div class="user-stats">
                            <div class="stat-item">
                                <span class="stat-label">포인트:</span>
                                <span class="stat-value">${user.totalPoint}</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">신뢰도:</span>
                                <span class="stat-value">${user.totalTrust}%</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">쿠폰:</span>
                                <span class="stat-value">${user.couponCount}개</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 거래 내역 탭 섹션 -->
        <div class="tab-nav">
            <button class="tab-link active" id="registerEquip-tab">
                <i class="fa fa-exchange-alt"></i> 등록 장비 내역: ${user.equipmentCount}건
            </button>
            <button class="tab-link" id="rentEquip-tab">
                <i class="fa fa-shopping-cart"></i> 대여 장비 내역: ${user.matchingCount}건
            </button>
        </div>


        <div class="content-box">
            <!-- 등록 장비 내역 콘텐츠 -->
            <div class="transaction-content" id="registerEquip-content">
                <div class="info-line">
                    <span class="info-text">최근 등록된 ${myEquipMap.size()}개의 장비를 간략하게 조회 중입니다.</span>
                    <a href="mypage-myequip.action" class="view-more-link">전체보기 <i class="fa fa-angle-right"></i></a>
                </div>
                <c:choose>
                <c:when test="${not empty myEquipMap and myEquipMap.size() > 0}">
                <div class="custom-table">
                    <table class="table">
                        <tbody>
                        <c:forEach var="entry" items="${myEquipMap}">
                            <%-- key, value를 개별 변수에 저장 --%>
                            <c:set var="key" value="${entry.key}" />
                            <c:set var="val" value="${entry.value}" />
                            <c:choose>
                                <%-- 해당 장비가 스토렌일 때 --%>
                                <c:when test="${fn:contains(key, 'storen')}">
                                    <tr class="table-row">
                                        <td style="width: 20%;">
                                            <div class="product-image">
                                                <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="장비 이미지">
                                            </div>
                                        </td>
                                        <td style="width: 55%;">
                                            <div class="equipment-info-container">
                                                <input type="hidden" name="storen_id" value="${val.storen_id}">
                                                <a href="#" class="equipment-name"><c:choose>
                                                    <c:when test="${not empty val.storen_title}">
                                                        ${val.storen_title}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${val.equipmentDTO.equip_name}
                                                    </c:otherwise>
                                                </c:choose></a>
                                                <div class="equipment-info-text">${val.equipmentDTO.majorCategory} > ${val.equipmentDTO.middleCategory}</div>
                                                <div class="equipment-info-text">${val.equipmentDTO.brand}</div>
                                                <div class="status-badge status-storage">${val.status}</div>
                                            </div>
                                        </td>
                                        <td style="width: 25%;">
                                            <div class="button-group-vertical">
                                                <button class="btn-sm btn-storen">스토렌 정보 확인</button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:when test="${fn:contains(key, 'general')}">
                                    <tr class="table-row">
                                        <td style="width: 20%;">
                                            <div class="product-image">
                                                <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="장비 이미지">
                                            </div>
                                        </td>
                                        <td style="width: 55%;">
                                            <div class="equipment-info-container">
                                                <input type="hidden" name="equip_code" value="${val.equip_code}">
                                                <a href="#" class="equipment-name">${val.equip_name}</a>
                                                <div class="equipment-info-text">${val.majorCategory} > ${val.middleCategory}</div>
                                                <div class="equipment-info-text">${val.brand}</div>
                                            </div>
                                        </td>
                                        <td style="width: 25%;">
                                            <div class="button-group-vertical">
                                                <button class="btn-sm btn-storen">스토렌 신청</button>
                                                <button class="btn-sm btn-rental">렌탈 신청</button>
                                                <button class="btn-sm btn-storage">보관 신청</button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                    </c:when>
                <c:otherwise>
                    <%-- 등록 장비가 없을 때 --%>
                    <div class="empty-state">
                        <i class="fa fa-box-open"></i>
                        <p>등록한 장비가 없습니다.</p>
                        <a href="equipment-register.action" class="empty-action">장비 등록하러 가기</a>
                    </div>
                </c:otherwise>
                </c:choose>
            </div>

            <!-- 대여 장비 내역 콘텐츠 -->
            <div class="transaction-content" id="rentEquip-content" style="display: none;">
                <div class="info-line">
                    <span class="info-text">최근 대여한 ${rentEquipMap.size()}개의 장비를 간략하게 조회 중입니다.</span>
                    <a href="mypage-rentequip.action" class="view-more-link">전체보기 <i class="fa fa-angle-right"></i></a>
                </div>
                <c:choose>
                <c:when test="${not empty rentEquipMap and rentEquipMap.size() > 0}">
                    <div class="custom-table">
                        <table class="table">
                            <tbody>
                                <c:forEach var="entry" items="${rentEquipMap}">
                                    <%-- key, value를 개별 변수에 저장 --%>
                                    <c:set var="key" value="${entry.key}" />
                                    <c:set var="val" value="${entry.value}" />
                                    <c:choose>
                                        <%-- 해당 장비가 스토렌일 때 --%>
                                        <c:when test="${fn:contains(key, 'storen')}">
                                            <tr class="table-row">
                                                <td style="width: 20%;">
                                                    <div class="product-image">
                                                        <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="장비 이미지">
                                                    </div>
                                                </td>
                                                <td style="width: 55%;">
                                                    <div class="equipment-info-container">
                                                        <input type="hidden" name="rental_id" value="${val.storen_id}">
                                                        <a href="#" class="equipment-name"><c:choose>
                                                            <c:when test="${not empty val.storen_title}">
                                                                ${val.storen_title}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${val.equipmentDTO.equip_name}
                                                            </c:otherwise>
                                                        </c:choose></a>
                                                        <div class="equipment-info-text">${val.equipmentDTO.majorCategory} > ${val.equipmentDTO.middleCategory}</div>
                                                        <div class="equipment-info-text">대여기간: ${val.matchingDTO.rental_start_date} ~ ${val.matchingDTO.rental_end_date}</div>
                                                        <div class="status-badge status-rental">${val.status}</div>
                                                    </div>
                                                </td>
                                                <td style="width: 25%;">
                                                    <div class="button-group-vertical">
                                                        <button class="btn-sm btn-rental">대여 정보 확인</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- 등록 장비가 없을 때 --%>
                    <div class="empty-state">
                        <i class="fa fa-shopping-cart"></i>
                        <p>대여한 장비가 없습니다.</p>
                        <a href="rentalsearch-main.action" class="empty-action">장비 대여하러 가기</a>
                    </div>
                </c:otherwise>
            </c:choose>
            </div>
        </div>


        <!-- 내가 작성한 글/댓글 탭 섹션 -->
        <div class="tab-nav">
            <button class="tab-link active" id="mypost-tab">
                <i class="fa fa-pen"></i> 내가 작성한 글: ${user.postCount}건
            </button>
            <button class="tab-link" id="mycomment-tab">
                <i class="fa fa-comment"></i> 내가 작성한 댓글: ${user.commentCount}건
            </button>
        </div>
        <div class="content-box">
            <!-- 내가 작성한 글 콘텐츠 -->
            <div class="post-content" id="mypost-content">
                <div class="info-line">
                    <span class="info-text">최근 작성한 ${postList.size()}개의 게시글을 간략하게 조회 중입니다.</span>
                    <a href="mypage-mypost.action" class="view-more-link">전체보기 <i class="fa fa-angle-right"></i></a>
                </div>
                <c:choose>
                <c:when test="${not empty postList and postList.size() > 0}">
                <table class="w-100 board-table">
                    <thead>
                    <tr class="border-bottom">
                        <th width="15%" class="p-2 text-center">게시판</th>
                        <th width="50%" class="p-2 text-center">제목</th>
                        <th width="15%" class="p-2 text-center">작성일</th>
                        <th width="10%" class="p-2 text-center">조회</th>
                        <th width="10%" class="p-2 text-center">추천</th>
                    </tr>
                    </thead>
                    <tbody>
                            <c:forEach var="post" items="${postList}">
                                <tr class="board-row border-bottom">
                                    <td class="p-2 text-center">
                                        <span class="board-category-tag freeboard">${post.boardName}</span>
                                    </td>
                                    <td class="p-2 title-cell">
                                        <c:choose>
                                        <c:when test="${fn:contains(post.boardName, '자유')}">
                                        <a href="boardfree-post.action?postId=${post.postId}">${post.postTitle}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="boardimage-post.action?postId=${post.postId}">${post.postTitle}</a>
                                        </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-2 text-center">${post.createdDate}</td>
                                    <td class="p-2 text-center">${post.viewCount}</td>
                                    <td class="p-2 text-center">
                                        <i class="fa-solid fa-heart table-icon icon-heart"></i>${post.recommendCount}
                                    </td>
                                </tr>
                            </c:forEach>
                    </tbody>
                </table>
                        </c:when>
                        <c:otherwise>
                            <%-- 등록한 글이 없을 때 --%>
                            <div class="empty-state">
                                <i class="fa fa-file-alt"></i>
                                <p>작성한 게시글이 없습니다.</p>
                                <a href="boardfree-main.action" class="empty-action">게시글 작성하러 가기</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
            </div>

            <!-- 내가 작성한 댓글 콘텐츠 -->
            <div class="post-content" id="mycomment-content" style="display: none;">
                <div class="info-line">
                    <span class="info-text">최근 작성한 ${commentList.size()}개의 댓글을 간략하게 조회 중입니다.</span>
                    <a href="mypage-mypost.action" class="view-more-link">전체보기 <i class="fa fa-angle-right"></i></a>
                </div>
                <c:choose>
                <c:when test="${not empty commentList and commentList.size() > 0}">
                <table class="w-100 board-table">
                    <thead>
                    <tr class="border-bottom">
                        <th width="60%" class="p-2 text-center">댓글 내용</th>
                        <th width="25%" class="p-2 text-center">원글 제목</th>
                        <th width="15%" class="p-2 text-center">작성일</th>
                    </tr>
                    </thead>
                    <tbody>
                            <c:forEach var="comment" items="${commentList}">
                                <tr class="board-row border-bottom">
                                    <td class="p-2 comment-cell">
                                        <c:choose>
                                            <c:when test="${fn:contains(post.boardName, '자유')}">
                                            <a href="boardfree-post.action?postId=${comment.postId}">${comment.replyContent}</a>
                                    </td>
                                    <td class="p-2 text-center">
                                        <a href="boardfree-post.action?postId=${comment.postId}">${comment.replyPostDTO.postTitle}</a>
                                            </c:when>
                                            <c:otherwise>
                                        <a href="boardimage-post.action?postId=${comment.postId}">${comment.replyContent}</a>
                                    </td>
                                    <td class="p-2 text-center">
                                        <a href="boardimage-post.action?postId=${comment.postId}">${comment.replyPostDTO.postTitle}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-2 text-center">${comment.createdDate}</td>
                                </tr>
                            </c:forEach>
                    </tbody>
                </table>
                        </c:when>
                        <c:otherwise>
                            <%-- 등록한 댓글이 없을 때 --%>
                            <div class="empty-state">
                                <i class="fa fa-comment-dots"></i>
                                <p>작성한 댓글이 없습니다.</p>
                                <a href="boardfree-main.action" class="empty-action">게시판으로 이동하기</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
            </div>
        </div>


        <!-- 이용 내역 섹션 -->
        <div class="section-header">이용 내역</div>
        <div class="two-column-layout">
            <!-- 즉시 확인 필요 박스 (왼쪽) -->
            <div class="urgent-box">
                <div class="urgent-header">즉시 확인 필요</div>
                <div class="urgent-content">
                    <a href="#" class="urgent-item">
                        <div class="item-label">보관비 결제 대기</div>
                        <div class="item-count">${emergencyMap["보관비 결제 대기"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">검수 결과 확인(입고/반환)</div>
                        <div class="item-count">${emergencyMap["검수 결과 확인"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">매칭 승인 대기</div>
                        <div class="item-count">${emergencyMap["매칭 승인 대기"]}</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">문제 상황 발생</div>
                        <div class="item-count">${emergencyMap["문제 상황 발생"]}</div>
                    </a>
                </div>
            </div>

            <!-- 거래 현황 박스 (오른쪽) -->
            <div class="transaction-status-box">
                <div class="status-header">거래 현황</div>
                <div class="status-content">
                    <!-- 스토렌 -->
                    <div class="status-row">
                        <div class="status-type">스토렌</div>
                        <div class="chevron-arrows">
                            <c:if test="${!empty storenStatusMap}">
                                <c:forEach var="status" items="${storenStatusMap}">
                                    <c:set var="cssClass" value=""/>
                                    <c:if test="${status.value > 0}">
                                        <c:set var="cssClass" value="active"/>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${status.key eq '보관비 결제 대기' || status.key eq '상태 불명' || status.key eq '강제 반환'}">
                                            <%-- 아무것도 하지 않음(continue처럼) --%>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" class="arrow-step ${cssClass}" data-status="${status.key}">
                                                <span class="arrow-badge">${status.value}</span>
                                                <span class="arrow-label">${status.key}</span>
                                                <div class="arrow-chevron"></div>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>

                    <!-- 렌탈 -->
                    <div class="status-row">
                        <div class="status-type">렌탈</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 보관 -->
                    <div class="status-row">
                        <div class="status-type">보관</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">0</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 찜 목록 섹션 -->
        <div class="product-list-section">
            <div class="section-header-with-link">
                <h3>찜 목록</h3>
                <a href="mypage-wishlist.action" class="view-all-link">전체보기</a>
            </div>
            <c:choose>
                <c:when test="${not empty wishlist and wishlist.size() > 0}">
                    <div class="product-slider-container">
                        <button class="slider-nav-button prev-button">
                            <i class="fa fa-chevron-left"></i>
                        </button>
                        <div class="product-slider">
                            <c:forEach var="wish" items="${wishlist}">
                                <div class="product-card">
                                    <div class="product-image">
                                        <img src="${pageContext.request.contextPath}/resources/images/placeholder-image.jpg" alt="아이템 이미지">
                                    </div>
                                    <div class="product-info">
                                        <div class="product-title"><c:choose>
                                            <c:when test="${not empty val.storen_title}">
                                                ${wish.storen_title}
                                            </c:when>
                                            <c:otherwise>
                                                ${wish.equipmentDTO.equip_name}
                                            </c:otherwise>
                                        </c:choose></div>
                                        <div class="product-brand">${wish.equipmentDTO.brand}</div>
                                        <div class="product-price">${wish.daily_rent_price}원</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <button class="slider-nav-button next-button">
                            <i class="fa fa-chevron-right"></i>
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state-container">
                        <div class="empty-state">
                                <i class="fa-solid fa-heart-crack"></i>
                                <p>찜한 상품이 없습니다</p>
                                <div class="hint">대여하고 싶은 상품을 찾으면 하트를 눌러서 찜해주세요!</div>
                            <a href="rentalsearch-main.action" class="empty-action mt-5">찜하러 가기</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        // 장비 내역 탭 전환 기능
        $('#registerEquip-tab').click(function() {
            $(this).addClass('active');
            $('#rentEquip-tab').removeClass('active');
            $('#registerEquip-content').show();
            $('#rentEquip-content').hide();
        });

        $('#rentEquip-tab').click(function() {
            $(this).addClass('active');
            $('#registerEquip-tab').removeClass('active');
            $('#rentEquip-content').show();
            $('#registerEquip-content').hide();
        });

        // 글/댓글 탭 전환 기능
        $('#mypost-tab').click(function() {
            $(this).addClass('active');
            $('#mycomment-tab').removeClass('active');
            $('#mypost-content').show();
            $('#mycomment-content').hide();
        });

        $('#mycomment-tab').click(function() {
            $(this).addClass('active');
            $('#mypost-tab').removeClass('active');
            $('#mycomment-content').show();
            $('#mypost-content').hide();
        });
    });
    // 다음 찜 아이템 카드로 이동 기능 구현
    $(document).ready(function() {
        const $slider = $('.product-slider');
        const $prevButton = $('.prev-button');
        const $nextButton = $('.next-button');
        const $cards = $slider.find('.product-card');

        const cardWidth = $cards.outerWidth(true); // 카드 + 마진 포함
        const visibleWidth = $slider.innerWidth(); // 현재 보이는 영역 너비

        let currentScroll = 0;

        $nextButton.on('click', function() {
            // 한 번에 '카드 하나 분량'만큼 이동
            currentScroll = Math.min(currentScroll + cardWidth, $slider[0].scrollWidth - visibleWidth);
            $slider.animate({ scrollLeft: currentScroll }, 100);
        });

        $prevButton.on('click', function() {
            currentScroll = Math.max(currentScroll - cardWidth, 0);
            $slider.animate({ scrollLeft: currentScroll }, 100);
        });
    });
</script>
</body>
</html>