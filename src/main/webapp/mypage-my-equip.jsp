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
        /* 정렬 옵션 스타일 */
        .sort-select {
            min-width: 120px;
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            font-size: 14px;
        }

        /* 테이블 스타일 */
        .equipment-table {
            width: 100%;
            border-collapse: collapse;
        }

        .equipment-table .table {
            width: 100%;
            border-collapse: collapse;
        }

        .equipment-row {
            border-bottom: 1px solid #e0e0e0;
        }

        .equipment-row td,
        .equipment-table th {
            padding: 15px 10px;
            vertical-align: middle;
        }

        .equipment-table th {
            font-weight: normal;
            color: #666;
            border-bottom: 1px solid #ddd;
        }

        /* 드롭다운 스타일 */
        .dropdown-toggle {
            text-decoration: none;
            color: inherit;
            cursor: pointer;
        }

        .dropdown-toggle::after {
            display: inline-block;
            margin-left: 0.255em;
            vertical-align: 0.255em;
            content: "";
            border-top: 0.3em solid;
            border-right: 0.3em solid transparent;
            border-bottom: 0;
            border-left: 0.3em solid transparent;
        }

        .dropdown-menu {
            position: absolute;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 0.5rem 0;
            min-width: 160px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            display: none;
            z-index: 1000;
        }

        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            text-decoration: none;
            color: #333;
        }

        .dropdown-item:hover {
            background-color: #f8f8f8;
        }

        .dropdown.show .dropdown-menu {
            display: block;
        }

        /* 물품 이미지 스타일 */
        .product-image {
            width: 100px;
            height: 60px;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            max-width: 100%;
            max-height: 100%;
        }

        /* 장비명 스타일 */
        .equipment-name {
            display: block;
            font-weight: 500;
            color: #333;
            text-decoration: none;
            margin-bottom: 5px;
        }

        .equipment-name:hover {
            color: #2C5F2D;
            text-decoration: underline;
        }

        .equipment-grade {
            font-size: 13px;
            color: #666;
        }

        /* 상태 배지 스타일 */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-shipping {
            background-color: #ffe8cc;
            color: #996633;
        }

        .status-checking {
            background-color: #e1e9f9;
            color: #4d6ea8;
        }

        .status-storage {
            background-color: #f9e1e1;
            color: #a84d4d;
        }

        /* 버튼 그룹 수직 스타일 */
        .button-group-vertical {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            text-align: center;
        }

        .btn-storen {
            background-color: var(--color-coral);
            color: var(--text-light);
        }
        .btn-rental {
            background-color: var(--color-mustard);
            color: var(--text-light);
        }
        .btn-storage {
            background-color: var(--color-maple);
            color: var(--text-light);
        }


        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .page-item {
            margin: 0 2px;
        }

        .page-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
        }

        .page-item.active .page-link {
            background-color: #2C5F2D;
            color: white;
            border-color: #2C5F2D;
        }

        .page-item.disabled .page-link {
            color: #aaa;
            pointer-events: none;
            background-color: #f5f5f5;
        }

        .page-link:hover:not(.disabled) {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
<!-- 헤더 인클루드 (JSP 방식) -->
<jsp:include page="header.jsp" />

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
                    <li><a href="mypage-password-check.jsp" class="sidebar-link">회원 정보 수정</a></li>
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
                    <li><a href="mypage-my-equip.jsp" class="sidebar-link active">내 장비 목록</a></li>
                    <li><a href="#" class="sidebar-link">내가 대여한 장비</a></li>
<<<<<<< Updated upstream
                    <li><a href="#" class="sidebar-link">내가 작성한 글</a></li>
=======
                    <li><a href="mypage-my-post.jsp" class="sidebar-link">내가 작성한 글</a></li>
>>>>>>> Stashed changes
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

    <!-- 마이페이지 메인 콘텐츠 -->
    <div class="mypage-main-content">
        <div class="page-header">
            <h2 class="page-title">내가 소유한 장비</h2>
        </div>

        <!-- 이용 내역 섹션 -->
        <div class="section-header">이용 내역</div>
        <div class="two-column-layout">
            <!-- 즉시 확인 필요 박스 (왼쪽) -->
            <div class="urgent-box">
                <div class="urgent-header">즉시 확인 필요</div>
                <div class="urgent-content">
                    <a href="#" class="urgent-item">
                        <div class="item-label">검수 결과 확인</div>
                        <div class="item-count">3</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">매칭 승인 대기</div>
                        <div class="item-count">5</div>
                    </a>
                    <a href="#" class="urgent-item">
                        <div class="item-label">주가 비용 결제 대기</div>
                        <div class="item-count">2</div>
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
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>

                    <!-- 렌탈 -->
                    <div class="status-row">
                        <div class="status-type">렌탈</div>
                        <div class="chevron-arrows">
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">매칭대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">승인대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">렌탈 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
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
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">배송대기</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">1</span>
                                <span class="arrow-label">배송 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">3</span>
                                <span class="arrow-label">검수 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step active">
                                <span class="arrow-badge">5</span>
                                <span class="arrow-label">보관 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                            <a href="#" class="arrow-step">
                                <span class="arrow-badge">2</span>
                                <span class="arrow-label">반환 중</span>
                                <div class="arrow-chevron"></div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 검색 섹션 -->
        <div class="search-container mb-4">
            <input type="text" class="form-control" placeholder="어떤 캠핑장비를 찾으시나요?(상품명 키워드 / 브랜드명 검색)">
            <button class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <!-- 카테고리 필터와 정렬 옵션을 한 줄에 배치 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <!-- 카테고리 필터 (왼쪽) -->
            <div class="filter-buttons d-flex flex-wrap">
                <button class="btn mr-2 mb-2" style="border: 1px solid #ddd; background-color: #f8f8f8;">
                    전체(00)
                </button>
                <button class="btn mr-2 mb-2" style="border: 1px solid #ddd; background-color: #f8f8f8;">
                    스토렌(00)
                </button>
                <button class="btn mr-2 mb-2" style="border: 1px solid #ddd; background-color: #f8f8f8;">
                    렌탈(00)
                </button>
                <button class="btn mr-2 mb-2" style="border: 1px solid #ddd; background-color: #f8f8f8;">
                    보관(00)
                </button>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="sort-container">
                <select class="form-control sort-select">
                    <option>최신순</option>
                    <option>이름순</option>
                    <option>등급순</option>
                    <option>...</option>
                </select>
            </div>
        </div>

        <!-- 물품 관리 테이블 -->
        <div class="equipment-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 15%;">
                        물품 이미지
                    </th>
                    <th style="width: 10%;">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-secondary d-flex align-items-center" data-toggle="dropdown">
                                거래 구분
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">전체</a>
                                <a class="dropdown-item" href="#">스토렌</a>
                                <a class="dropdown-item" href="#">렌탈</a>
                                <a class="dropdown-item" href="#">보관</a>
                            </div>
                        </div>
                    </th>
                    <th style="width: 35%;">
                            물품명
                    </th>
                    <th style="width: 15%;">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-secondary d-flex align-items-center" data-toggle="dropdown">
                                거래상태
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">전체</a>
                                <a class="dropdown-item" href="#">배송 중</a>
                                <a class="dropdown-item" href="#">검수 중</a>
                                <a class="dropdown-item" href="#">보관 중</a>
                            </div>
                        </div>
                    </th>
                    <th style="width: 25%;">
                        <a href="#" class="text-secondary d-flex align-items-center">
                        </a>
                    </th>
                </tr>
                </thead>
                <tbody>
                <!-- 첫 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <div class="product-image">
                            <img src="images/product-placeholder.jpg" alt="상품 이미지">
                        </div>
                    </td>
                    <td>스토렌</td>
                    <td>
                        <a href="product-detail.html" class="equipment-name">진정한 캠핑고수의 텐트</a>
                        <div class="equipment-grade">
                            등급: <span class="grade-badge grade-B">B</span>
                            <a href="#" class="check-inspection" style="font-size: 12px; margin-left: 8px; color: #4d6ea8;">검수확인</a>
                        </div>
                    </td>
                    <td>
                        <span class="status-badge status-shipping">배송 중</span>
                    </td>
                    <td>
                        <div class="button-group-vertical">
                            <button class="btn-sm btn-storen">스토렌 신청</button>
                            <button class="btn-sm btn-rental">렌탈 신청</button>
                            <button class="btn-sm btn-storage">보관 신청</button>
                        </div>
                    </td>
                </tr>

                <!-- 두 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <div class="product-image">
                            <img src="images/product-placeholder.jpg" alt="상품 이미지">
                        </div>
                    </td>
                    <td>스토렌</td>
                    <td>
                        <a href="product-detail.html" class="equipment-name">진정한 캠핑고수의 텐트</a>
                        <div class="equipment-grade">
                            등급: <span class="grade-badge grade-B">B</span>
                            <a href="#" class="check-inspection" style="font-size: 12px; margin-left: 8px; color: #4d6ea8;">검수확인</a>
                        </div>
                    </td>
                    <td>
                        <span class="status-badge status-checking">검수 중</span>
                    </td>
                    <td>
                        <div class="button-group-vertical">
                            <button class="btn-sm btn-storen">스토렌 신청</button>
                            <button class="btn-sm btn-rental">렌탈 신청</button>
                            <button class="btn-sm btn-storage">보관 신청</button>
                        </div>
                    </td>
                </tr>

                <!-- 세 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <div class="product-image">
                            <img src="images/product-placeholder.jpg" alt="상품 이미지">
                        </div>
                    </td>
                    <td>스토렌</td>
                    <td>
                        <a href="product-detail.html" class="equipment-name">진정한 캠핑고수의 텐트</a>
                        <div class="equipment-grade">
                            등급: <span class="grade-badge grade-B">B</span>
                            <a href="#" class="check-inspection" style="font-size: 12px; margin-left: 8px; color: #4d6ea8;">검수확인</a>
                        </div>
                    </td>
                    <td>
                        <span class="status-badge status-storage">보관 중</span>
                    </td>
                    <td>
                        <div class="button-group-vertical">
                            <button class="btn-sm btn-storen">스토렌 신청</button>
                            <button class="btn-sm btn-rental">렌탈 신청</button>
                            <button class="btn-sm btn-storage">보관 신청</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 추가 버튼 -->
        <div class="text-right mb-5">
            <button class="btn-circle" style="width: 50px; height: 50px; border-radius: 50%; background-color: white; border: 1px solid #ddd; box-shadow: 0 2px 5px rgba(0,0,0,0.1); font-size: 20px;">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <!-- 페이징 처리 -->
        <div class="pagination-container d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </div>

    </div>
</div>

<!-- 푸터 인클루드 (JSP 방식) -->
<jsp:include page="footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

</body>

<script>
    $(document).ready(function() {
        // 드롭다운 토글 이벤트
        $('.dropdown-toggle').click(function(e) {
            e.preventDefault();
            $(this).parent().toggleClass('show');
        });

        // 외부 클릭 시 드롭다운 닫기
        $(document).click(function(e) {
            if (!$(e.target).closest('.dropdown').length) {
                $('.dropdown').removeClass('show');
            }
        });

        // 정렬 옵션 변경 이벤트
        $('.sort-select').change(function() {
            // 정렬 기능 구현 (실제 구현 시에는 여기에 정렬 로직 추가)
            alert('정렬 옵션이 변경되었습니다: ' + $(this).val());
        });

        // 페이지네이션 클릭 이벤트
        $('.page-link').click(function(e) {
            if (!$(this).parent().hasClass('disabled') && !$(this).parent().hasClass('active')) {
                e.preventDefault();
                $('.page-item').removeClass('active');
                $(this).parent().addClass('active');
                // 페이지 이동 기능 구현 (실제 구현 시에는 여기에 페이지 이동 로직 추가)
            }
        });

        // 장비명 클릭 이벤트
        $('.equipment-name').click(function(e) {
            // 여기에 페이지 이동 로직 추가 (기본 동작은 유지)
            console.log('장비 상세 페이지로 이동: ' + $(this).text());
        });
    });
</script>
</html>