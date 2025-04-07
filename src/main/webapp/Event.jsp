<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>이벤트</title>
    <!-- CSS 파일 로드 -->
    <link rel="stylesheet" href="resources/css/main.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            background-color: var(--color-gray-100);
        }

        .filter-option.active {
            background-color: var(--color-beige);
            border-color: var(--color-maple);
            color: var(--color-maple);
            font-weight: var(--font-bold);
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
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<div class="page-wrapper">
    <div class="container section" style="width: 100%; max-width: 1500px; padding: 0 15px; margin: 0 auto">
        <div class="main-content my-5">
            <!-- 메인 콘텐츠 -->
            <div class="w-100">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-gift"></i> 이벤트</h1>
                </div>

                <div class="filter-area mb-4">
                    <!-- 정렬 옵션 -->
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <select class="form-control form-control-sm mr-5">
                                <option>정렬</option>
                                <option>최신순</option>
                                <option>조회순</option>
                                <option>추천순</option>
                            </select>
                        </div>
                    </div>

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
                    <div class="filter-group">
                        <div class="filter-label">유형</div>
                        <div class="filter-options">
                            <div class="filter-option active">전체</div>
                            <div class="filter-option">공모전</div>
                            <div class="filter-option">프로모션</div>
                            <div class="filter-option">오프라인</div>
                            <div class="filter-option">경품</div>
                        </div>
                    </div>
                </div>


                <!-- 이벤트 카드 컨테이너 -->
                <div class="event-container">
                    <!-- 이벤트 카드 1 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-gift no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag contest">공모전</span>
                            <h3 class="event-title">봄맞이 캠핑 인증 이벤트</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.04.01 ~ 2025.04.30</span>
                            </div>
                            <p class="event-description">
                                봄철 캠핑 사진을 올려주세요! 베스트 샷으로 선정된 10분께 캠핑 용품을 드립니다.
                                봄의 느낌이 물씬 나는 캠핑 사진이라면 무엇이든 좋습니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ongoing">진행중</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,245</span>
                                    <span><i class="fa-solid fa-comment"></i> 85</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 2 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-campground no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag offline">오프라인</span>
                            <h3 class="event-title">2025 캠퍼스데이 참가자 모집</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.05.15 ~ 2025.05.17</span>
                            </div>
                            <p class="event-description">
                                전국 캠퍼들이 한자리에 모이는 캠퍼스데이! 다양한 캠핑 장비 전시와 체험,
                                캠핑 요리 대회 등 풍성한 이벤트가 준비되어 있습니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status upcoming">진행예정</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 978</span>
                                    <span><i class="fa-solid fa-comment"></i> 42</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 3 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-percentage no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag promotion">프로모션</span>
                            <h3 class="event-title">캠핑 용품 할인 기획전</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.04.10 ~ 2025.04.25</span>
                            </div>
                            <p class="event-description">
                                봄 캠핑 시즌을 맞아 인기 캠핑 용품을 최대 50% 할인된 가격에 만나보세요.
                                텐트, 침낭, 의자 등 다양한 제품이 할인됩니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ongoing">진행중</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,543</span>
                                    <span><i class="fa-solid fa-comment"></i> 67</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 4 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-award no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag giveaway">경품</span>
                            <h3 class="event-title">신규 회원 가입 이벤트</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.04.01 ~ 2025.04.30</span>
                            </div>
                            <p class="event-description">
                                캠핑하쉐어에 새로 가입하신 모든 분들께 웰컴 포인트 5,000점을 드립니다!
                                추첨을 통해 5명에게 프리미엄 캠핑 의자를 증정합니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ongoing">진행중</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,876</span>
                                    <span><i class="fa-solid fa-comment"></i> 124</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 5 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-utensils no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag contest">공모전</span>
                            <h3 class="event-title">캠핑 요리 레시피 공모전</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.03.15 ~ 2025.04.15</span>
                            </div>
                            <p class="event-description">
                                캠핑장에서 만들 수 있는 특별한 레시피를 공유해주세요.
                                선정된 레시피는 캠핑하쉐어 공식 레시피북에 수록됩니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ongoing">진행중</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,342</span>
                                    <span><i class="fa-solid fa-comment"></i> 98</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 6 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-camera no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag contest">공모전</span>
                            <h3 class="event-title">겨울 캠핑 사진 공모전</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.01.15 ~ 2025.02.28</span>
                            </div>
                            <p class="event-description">
                                겨울 캠핑의 매력을 담은 사진을 공모합니다.
                                눈 내리는 풍경, 따뜻한 모닥불 등 겨울 캠핑만의 특별한 순간을 공유해주세요.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ended">종료</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 2,134</span>
                                    <span><i class="fa-solid fa-comment"></i> 156</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 7 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-users no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag offline">오프라인</span>
                            <h3 class="event-title">2025년 첫 오프라인 캠핑 모임</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.01.25 ~ 2025.01.26</span>
                            </div>
                            <p class="event-description">
                                새해 첫 캠핑하쉐어 오프라인 모임에 초대합니다.
                                따뜻한 음식과 대화를 나누며 캠핑 동호인들과 교류하는 시간을 가져보세요.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ended">종료</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,876</span>
                                    <span><i class="fa-solid fa-comment"></i> 143</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 8 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-shopping-cart no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag promotion">프로모션</span>
                            <h3 class="event-title">신년맞이 캠핑 장비 할인 이벤트</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.01.01 ~ 2025.01.15</span>
                            </div>
                            <p class="event-description">
                                새해를 맞아 다양한 캠핑 장비를 특별 할인가에 제공합니다.
                                신년 첫 캠핑을 준비하는 분들에게 좋은 기회가 될 것입니다.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ended">종료</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 2,345</span>
                                    <span><i class="fa-solid fa-comment"></i> 187</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 이벤트 카드 9 -->
                    <div class="card product-card">
                        <div class="product-image">
                            <i class="fas fa-fire no-image-icon"></i>
                        </div>
                        <div class="event-content">
                            <span class="category-tag giveaway">경품</span>
                            <h3 class="event-title">캠핑 화로대 신제품 체험단 모집</h3>
                            <div class="event-period">
                                <i class="fa-solid fa-calendar-days"></i>
                                <span>2025.04.05 ~ 2025.04.20</span>
                            </div>
                            <p class="event-description">
                                새롭게 출시된 휴대용 화로대 체험단을 모집합니다.
                                선정된 20분께는 제품을 무상으로 제공하며, 솔직한 후기를 작성해주세요.
                            </p>
                            <div class="event-footer">
                                <div class="event-status ongoing">진행중</div>
                                <div class="event-views">
                                    <span><i class="fa-solid fa-eye"></i> 1,435</span>
                                    <span><i class="fa-solid fa-comment"></i> 112</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 하단 검색 및 페이지네이션 -->
                <div style="display: flex; align-items: center; margin-top: 30px; width: 100%;">
                    <!-- 검색 영역 - 왼쪽 -->
                    <div style="width: 240px; position: relative; z-index: 1; flex: 1;">
                        <div class="d-flex border rounded">
                            <select class="form-control-sm border-0"
                                    style="border-right: 1px solid #ddd; background-color: white; padding: 8px 5px; font-size: 13px; width: 60%">
                                <option>제목+내용</option>
                                <option>제목</option>
                                <option>내용</option>
                                <option>작성자</option>
                            </select>
                            <input type="text" class="form-control-sm border-0 w-100" placeholder="검색어를 입력하세요"
                                   style="padding: 8px 10px; font-size: 13px;">
                            <button class="btn border-0" style="background-color: #f8f9fa; padding: 8px 10px;">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>

                    <!-- 페이지네이션 - 중앙에 가깝게 -->
                    <div style="margin: 0; flex: 2; display: flex; justify-content: center;">
                        <div class="d-flex gap-1">
                            <a href="#" class="btn btn-sm"><i class="fa-solid fa-chevron-left"></i></a>
                            <a href="#" class="btn btn-primary btn-sm">1</a>
                            <a href="#" class="btn btn-sm">2</a>
                            <a href="#" class="btn btn-sm">3</a>
                            <a href="#" class="btn btn-sm">4</a>
                            <a href="#" class="btn btn-sm">5</a>
                            <a href="#" class="btn btn-sm"><i class="fa-solid fa-chevron-right"></i></a>
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

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>