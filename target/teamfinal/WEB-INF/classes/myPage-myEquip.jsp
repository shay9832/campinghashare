<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<% String equip_code = null; %>
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
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link active">내 장비 목록</a></li>
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
                                <a class="dropdown-item" href="#">배송대기</a>
                                <a class="dropdown-item" href="#">배송 중</a>
                                <a class="dropdown-item" href="#">검수 중</a>
                                <a class="dropdown-item" href="#">보관 중</a>
                                <a class="dropdown-item" href="#">매칭 대기</a>
                                <a class="dropdown-item" href="#">승인 대기</a>
                                <a class="dropdown-item" href="#">렌탈 중</a>
                                <a class="dropdown-item" href="#">반환 중</a>
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
                <form action="" method="get">
                    <tr class="equipment-row">
                        <td>
                            <div class="product-image">
                                <img src="images/product-placeholder.jpg" alt="상품 이미지">
                            </div>
                        </td>
                        <td>일반 장비</td>
                        <td>
                            <% equip_code = "3"; %>
                            <%--                        <a href="myPage-myEquip-info.jsp?equip_code=<%= equip_code%>" class="equipment-name">진정한 캠핑고수의 텐트</a>--%>
                            <a href="4-equip-info.jsp?equip_code=<%= equip_code%>" class="equipment-name">진정한 캠핑고수의 텐트</a>
                        </td>
                        <td>
                            <span class="status-badge status-storage">서비스 신청 대기</span>
                        </td>
                        <td>
                            <div class="button-group-vertical">
                                <button class="btn-sm btn-storen" onclick="form.action='6-storen-register.jsp?equip_code=<%=equip_code%>'">스토렌 신청</button>
                                <button class="btn-sm btn-rental">렌탈 신청</button>
                                <button class="btn-sm btn-storage">보관 신청</button>
                            </div>
                        </td>
                    </tr>
                </form>
                <!-- 두 번째 행 -->
                <tr class="equipment-row">
                    <td>
                        <div class="product-image">
                            <img src="images/product-placeholder.jpg" alt="상품 이미지">
                        </div>
                    </td>
                    <td>스토렌</td>
                    <td>
                        <% equip_code = "1"; %>
                        <a href="myPage-myEquip-info.jsp?equip_code=<%= equip_code%>" class="equipment-name">진정한 캠핑고수의 텐트</a>
                        <div class="equipment-grade">
                            등급: <span class="grade-badge grade-B">B</span>
                            <a href="#" class="check-inspection" style="font-size: 12px; margin-left: 8px; color: #4d6ea8;">검수확인</a>
                        </div>
                    </td>
                    <td>
                        <span class="status-badge status-shipping">검수 중</span>
                    </td>
                    <td>
                        <div class="button-group-vertical">
                            <button class="btn-sm btn-storen">검수결과확인</button>
                            <button class="btn-sm btn-rental">추가정보입력</button>
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
                        <% equip_code = "2"; %>
<%--                        <a href="myPage-myEquip-info.jsp?equip_code=<%= equip_code%>" class="equipment-name">진정한 캠핑고수의 텐트</a>--%>
                        <a href="6-storen-register.jsp?equip_code=<%= equip_code%>" class="equipment-name" name="openEquipRegisterModal">진정한 캠핑고수의 텐트</a>
                        <div class="equipment-grade">
                            등급: <span class="grade-badge grade-B">B</span>
                            <a href="#" class="check-inspection" style="font-size: 12px; margin-left: 8px; color: #4d6ea8;">검수확인</a>
                        </div>
                    </td>
                    <td>
                        <span class="status-badge status-checking">승인대기</span>
                    </td>
                    <td>
                        <div class="button-group-vertical">
                            <button class="btn-sm btn-storen">매칭 요청 확인</button>
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

<!-- 내 장비 등록 모달 -->
<div id="equipRegisterModal" class="modal">
    <div class="modal-overlay"></div>
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">내 장비 등록</h3>
            <button class="modal-close"><i class="fas fa-times"></i></button>
        </div>

        <div class="modal-content">
            <div class="equipinfo-container">
                <div class="equipinfo-item">
                    <label>장비 사진</label>
                    <div class="input-container">
                        <div class="photo-area">
                            <div class="photos-container" id="photosContainer">
                                <!-- 업로드된 사진이 여기에 표시됩니다 -->
                            </div>
                            <div class="photo-upload">
                                <label for="photoInput" class="add-photo-btn">
                                    <span class="center-icon"><i class="fa-solid fa-plus"></i></span>
                                </label>
                                <input type="file" id="photoInput" accept="image/*" multiple style="display: none;">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="equipinfo-item">
                    <label>카테고리(대)</label>
                    <div class="input-container">
                        <span class="info-text">텐트/쉘터</span>
                    </div>
                </div>

                <div class="equipinfo-item">
                    <label>카테고리(중)</label>
                    <div class="input-container">
                        <span class="info-text">텐트</span>
                    </div>
                </div>

                <div class="equipinfo-item">
                    <label>브랜드</label>
                    <div class="input-container">
                        <span class="info-text">스노우피크</span>
                        <input type="hidden" id="brandInput" value="스노우피크">
                    </div>
                </div>

                <div class="equipinfo-item">
                    <label>장비명</label>
                    <div class="input-container">
                        <div class="search-container">
                            <input type="text" placeholder="장비명 검색 및 선택" class="search-input" id="equipNameSearch">
                            <button class="search-button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="equipinfo-item">
                    <label>신품가격</label>
                    <div class="input-container price-row">
                        <input type="text" placeholder="금액 입력" class="price-input" id="priceInput">
                        <span class="currency">원</span>
                        <div class="price-comparison" id="priceComparison">
                            <span class="price-diff" id="priceDiff">(평균 대비 22%▲)</span>
                            <span class="avg-price">평균 신품 가격</span>
                            <span class="avg-price-value">2,500,000원</span>
                            <div class="info-icon tooltip-trigger">
                                <i class="fa-solid fa-circle-question"></i>
                                <div class="tooltip-content">이 가격은 유저들이 등록한 동일 상품의 평균 가격입니다.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 등록 시 주의사항 섹션 -->
            <div class="notice-container">
                <div class="notice-title">등록 시 주의사항</div>
                <ul class="notice-list">
                    <li><strong>브랜드, 장비명을 정확히 기재해 주세요.</strong></li>
                    <li><strong>장비의 전체 모습과 상세 부분을 여러 각도에서 촬영한 사진을 첨부해 주세요.</strong></li>
                    <li><strong>신품가격을 명확히 표시해 주세요.</strong></li>
                </ul>
            </div>
        </div>

        <!-- 버튼 컨테이너 -->
        <div class="modal-footer">
            <button class="btn modal-cancel">취소</button>
            <button class="btn btn-primary modal-confirm">등록하기</button>
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



    // 모달 처리
    $(document).ready(function() {
        // 모달 관련 기능
        $("#openEquipRegisterModal").click(function() {
            $("#equipRegisterModal").addClass("show");
            $("body").addClass("modal-open");
        });

        $(".modal-close, .modal-cancel").click(function() {
            $("#equipRegisterModal").removeClass("show");
            $("body").removeClass("modal-open");
        });

        $(".modal-overlay").click(function() {
            $("#equipRegisterModal").removeClass("show");
            $("body").removeClass("modal-open");
        });

        $(".modal-confirm").click(function() {
            // 여기에 등록 로직 구현
            showToast("장비가 성공적으로 등록되었습니다");

            // 모달 닫기
            setTimeout(function() {
                $("#equipRegisterModal").removeClass("show");
                $("body").removeClass("modal-open");
            }, 1500);
        });

        // 브랜드 값에 따라 UI 초기 설정
        setupUIBasedOnBrand();

        // 사진 업로드 처리 - 이벤트 리스너 수정
        $("#photoInput").on('change', function() {
            console.log("File selected"); // 디버깅용 로그
            handleFileSelect(this.files);
        });

        // 툴팁 이벤트 처리 수정
        $(document).on('mouseenter', '.tooltip-trigger', function() {
            $(this).find('.tooltip-content').stop().fadeIn(200);
        });

        $(document).on('mouseleave', '.tooltip-trigger', function() {
            $(this).find('.tooltip-content').stop().fadeOut(200);
        });
    });

    // 브랜드가 '기타'인지 확인하는 함수
    function isBrandOther() {
        const brandValue = $("#brandInput").val();
        return brandValue === "기타";
    }

    // 파일 선택 처리 함수
    function handleFileSelect(files) {
        console.log("Processing files:", files.length); // 디버깅용 로그

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            if (!file.type.match('image.*')) {
                console.log("Skipping non-image file:", file.name);
                continue;
            }

            const reader = new FileReader();
            reader.onload = (function(theFile) {
                return function(e) {
                    console.log("File loaded:", theFile.name); // 디버깅용 로그

                    // 미리보기 이미지 생성
                    const photoDiv = document.createElement('div');
                    photoDiv.className = 'photo-preview';
                    photoDiv.innerHTML = [
                        '<img class="thumb" src="', e.target.result, '" title="', theFile.name, '"/>',
                        '<button type="button" class="remove-photo" onclick="removePhoto(this)"><i class="fa-solid fa-times"></i></button>'
                    ].join('');

                    $('#photosContainer').append(photoDiv);
                };
            })(file);

            reader.readAsDataURL(file);
        }
    }

    // 사진 제거 함수
    function removePhoto(element) {
        $(element).parent().remove();
    }

    // 가격 비교 업데이트 함수
    function updatePriceComparison() {
        const inputPrice = parseInt($("#priceInput").val().replace(/,/g, '')) || 0;
        const avgPrice = 2500000; // 예시 평균 가격, 실제로는 서버에서 가져와야 함

        if (inputPrice > 0) {
            const diff = ((inputPrice - avgPrice) / avgPrice * 100).toFixed(0);
            const symbol = diff >= 0 ? "▲" : "▼";
            const absDiff = Math.abs(diff);

            $("#priceDiff").html(`(평균 대비 ${absDiff}%${symbol})`);
            $("#priceDiff").css('color', diff >= 0 ? '#d9534f' : '#5cb85c');
        }
    }

    // 토스트 메시지 표시 함수
    function showToast(message) {
        $("#toastMessage").text(message).fadeIn(300);
        setTimeout(function() {
            $("#toastMessage").fadeOut(300);
        }, 3000);
    }

    // 빈 setupUIBasedOnBrand 함수
    function setupUIBasedOnBrand() {
        // 원래 주석처리된 함수이지만, ready 함수에서 호출되므로 빈 함수로 구현
    }
</script>
</html>