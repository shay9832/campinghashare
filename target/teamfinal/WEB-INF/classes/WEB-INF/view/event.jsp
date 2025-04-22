<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>이벤트</title>

    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <style>
        /* 이벤트 카드 레이아웃 */
        .event-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-lg);
        }

        /* 이벤트 내용 스타일 */
        .event-content {
            padding: var(--spacing-md);
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .event-title {
            font-size: var(--font-sm);
            font-weight: var(--font-bold);
            margin-bottom: var(--spacing-xs);
            color: var(--text-primary);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            line-height: 1.3;
            height: 2.6em;
        }

        .event-period {
            font-size: var(--font-xxs);
            color: var(--text-secondary);
            margin-bottom: var(--spacing-xs);
            display: flex;
            align-items: center;
        }

        .event-period i {
            margin-right: var(--spacing-xxs);
            color: var(--color-maple);
        }

        .event-description {
            font-size: var(--font-xxs);
            color: var(--text-secondary);
            margin-bottom: var(--spacing-md);
            line-height: 1.4;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .event-footer {
            display: flex;
            justify-content: space-between;
            padding-top: var(--spacing-xs);
            border-top: 1px solid var(--border-light);
            font-size: var(--font-xxs);
        }

        .event-status {
            font-weight: var(--font-bold);
        }

        .event-status.ongoing {
            color: var(--color-maple);
        }

        .event-status.upcoming {
            color: var(--color-info);
        }

        .event-status.ended {
            color: var(--color-error);
        }

        .event-views {
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        /* 이미지 없음 아이콘 */
        .no-image-icon {
            font-size: 48px;
            color: var(--text-tertiary);
        }

        /* 카테고리 태그 */
        .category-tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            font-size: var(--font-xxs);
            font-weight: var(--font-semibold);
            margin-right: 8px;
        }

        .category-tag.contest {
            background-color: #e3f2fd;
            color: #0066cc;
        }

        .category-tag.promotion {
            background-color: #fff9c4;
            color: #ffa000;
        }

        .category-tag.offline {
            background-color: #ffebee;
            color: #d32f2f;
        }

        .category-tag.giveaway {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        /* 필터 영역 */
        .filter-area {
            display: flex;
            margin-bottom: var(--spacing-lg);
            background-color: var(--bg-primary);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            box-shadow: var(--shadow-sm);
        }

        .filter-group {
            display: flex;
            margin-right: var(--spacing-lg);
            align-items: center;
        }

        .filter-label {
            font-weight: var(--font-bold);
            margin-right: var(--spacing-sm);
            font-size: var(--font-xs);
        }

        .filter-options {
            display: flex;
            gap: var(--spacing-sm);
        }

        .filter-option {
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-medium);
            font-size: var(--font-xxs);
            cursor: pointer;
            transition: all var(--transition-normal);
        }

        .filter-option:hover {
            background-color: var(--color-gray-200);
        }

        .filter-option.active {
            background-color: var(--color-beige-light);
            border-color: var(--color-maple);
            color: var(--color-maple);
            font-weight: var(--font-semibold);
        }

        /* 반응형 조정 */
        @media (max-width: 992px) {
            .event-container {
                grid-template-columns: repeat(2, 1fr);
            }

            .filter-area {
                flex-wrap: wrap;
            }

            .filter-group {
                margin-bottom: var(--spacing-sm);
            }
        }

        @media (max-width: 576px) {
            .event-container {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <script>
        // 문서가 로드되면 실행
        document.addEventListener('DOMContentLoaded', function() {
            // 필터 옵션 버튼들을 선택
            const filterOptions = document.querySelectorAll('.filter-option');
            // 모든 이벤트 카드를 선택
            const eventCards = document.querySelectorAll('.card.product-card');

            // 각 필터 옵션 버튼에 클릭 이벤트 추가
            filterOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // 모든 필터 옵션에서 active 클래스 제거
                    filterOptions.forEach(opt => opt.classList.remove('active'));
                    // 클릭된 옵션에 active 클래스 추가
                    this.classList.add('active');

                    // 선택된 필터 값 가져오기
                    const filterValue = this.textContent.trim();

                    // 모든 이벤트 카드를 순회하며 필터링
                    eventCards.forEach(card => {
                        // 이벤트 상태 텍스트 가져오기
                        const statusElement = card.querySelector('.event-status');
                        const statusText = statusElement.textContent.trim();

                        // 필터에 따라 카드 표시 여부 결정
                        if (filterValue === '전체') {
                            // '전체' 선택 시 모든 카드 표시
                            card.style.display = 'flex';
                        } else if (filterValue === '진행중' && statusText === '진행중') {
                            // '진행중' 필터와 상태가 일치할 때
                            card.style.display = 'flex';
                        } else if (filterValue === '진행예정' && statusText === '진행예정') {
                            // '진행예정' 필터와 상태가 일치할 때
                            card.style.display = 'flex';
                        } else if (filterValue === '종료' && statusText === '종료') {
                            // '종료' 필터와 상태가 일치할 때
                            card.style.display = 'flex';
                        } else {
                            // 조건에 맞지 않으면 카드 숨김
                            card.style.display = 'none';
                        }
                    });
                });
            });
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="page-wrapper">
    <div class="container section" style="width: 100%; max-width: 1500px; padding: 0 15px; margin: 0 auto">
        <div class="main-content my-5">
            <!-- 메인 콘텐츠 -->
            <div class="w-100">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-gift"></i> 이벤트</h1>
                </div>

                <div class="filter-area mb-4">
                    <!-- 필터 영역 -->
                    <div class="filter-group">
                        <div class="filter-label">진행상태</div>
                        <div class="filter-options">
                            <div class="filter-option active">전체</div>
                            <div class="filter-option">진행중</div>
                            <div class="filter-option">진행예정</div>
                            <div class="filter-option">종료</div>
                        </div>
                    </div>
                </div>

                <!-- 이벤트 카드 컨테이너 -->
                <div class="event-container">
                    <c:forEach var="eventList" items="${eventList}">
                        <div class="card product-card">
                            <div class="product-image">
                                <i class="fas fa-gift no-image-icon"></i>
                            </div>
                            <div class="event-content">
                                <h3 class="event-title">${eventList.eventTitle}</h3>
                                <div class="event-period">
                                    <i class="fa-solid fa-calendar-days"></i>
                                    <span>${eventList.eventStartDate.substring(0, 10)} ~ ${eventList.eventEndDate.substring(0, 10)}</span>
                                </div>
                                <p class="event-description">
                                    ${eventList.eventContent}
                                </p>
                                <div class="event-footer">
                                    <div class="event-status ${eventList.status}">
                                        <c:choose>
                                            <c:when test="${eventList.status == 'going'}">진행중</c:when>
                                            <c:when test="${eventList.status == 'coming'}">진행예정</c:when>
                                            <c:otherwise>종료</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <form action="event.action" method="get">
                            <div class="d-flex border rounded">
                                <select name="searchType" class="form-control-sm border-0"
                                        style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                    <option value="titlecontent" ${searchType == 'titlecontent' ? 'selected' : ''}>
                                        제목+내용
                                    </option>
                                    <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                                    <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                                    <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                                </select>
                                <input type="text" name="searchKeyword" value="${searchKeyword}"
                                       class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요"
                                       style="padding: 8px 10px; font-size: 13px;">
                                <button type="submit" class="btn border-0"
                                        style="background-color: #f8f9fa; padding: 8px 10px;">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- 페이지네이션 - 중앙에 가깝게 -->
                    <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
                        <div class="d-flex gap-1 pagination">
                            <!-- 첫 페이지로 -->
                            <c:if test="${pagenation.pageNum > 1}">
                                <a href="event.action?page=1${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </c:if>

                            <!-- 이전 블록으로 -->
                            <c:if test="${pagenation.startPage > pagenation.blockSize}">
                                <a href="event.action?page=${pagenation.prevPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <c:forEach var="i" begin="${pagenation.startPage}" end="${pagenation.endPage}">
                                <a href="event.action?page=${i}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn ${pagenation.pageNum == i ? 'btn-primary' : ''} btn-sm">${i}</a>
                            </c:forEach>

                            <!-- 다음 블록으로 -->
                            <c:if test="${pagenation.endPage < pagenation.totalPage}">
                                <a href="event.action?page=${pagenation.nextPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:if>

                            <!-- 마지막 페이지로 -->
                            <c:if test="${pagenation.pageNum < pagenation.totalPage}">
                                <a href="event.action?page=${pagenation.totalPage}${not empty searchKeyword ? '&searchType='.concat(searchType).concat('&searchKeyword=').concat(searchKeyword) : ''}"
                                   class="btn btn-sm">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>

                    <!-- 관리자만 보이는 글쓰기 버튼 - 오른쪽 -->
                    <div style="flex: 1; display: flex; justify-content: flex-end;">
                        <button class="btn btn-primary">
                            <i class="fa-solid fa-pen mr-1"></i> 글쓰기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>