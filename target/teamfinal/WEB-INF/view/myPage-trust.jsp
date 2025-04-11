<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampingHaShare - 신뢰도 내역</title>
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
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
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
                    <li><a href="myPage-trust.jsp" class="sidebar-link active">신뢰도</a></li>
                    <li><a href="myPage-point.jsp" class="sidebar-link">포인트</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="#" class="sidebar-link title">
                    <span>이용 내역 조회</span>
                </a>
                <ul class="submenu">
                    <li><a href="myPage-myEquip.jsp" class="sidebar-link">내가 소유한 장비</a></li>
                    <li><a href="myPage-inspecList.jsp" class="sidebar-link">검수 결과 조회</a></li>
                    <li><a href="myPage-delivery.jsp" class="sidebar-link">배송 조회/내역</a></li>
                    <li><a href="myPage-matchingList.jsp" class="sidebar-link">매칭 조회/내역</a></li>
                    <li><a href="myPage-rentEquip.jsp" class="sidebar-link">내가 대여한 장비</a></li>
                    <li><a href="myPage-myPost.jsp" class="sidebar-link">내가 작성한 글</a></li>
                </ul>
            </li>
            <li class="sidebar-menu-item">
                <a href="myPage-wishlist.jsp" class="sidebar-link title">
                    <span>찜</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="" class="sidebar-link title">
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
            <h2 class="page-title">신뢰도 내역</h2>
        </div>

        <!-- 신뢰도 요약 정보 -->
        <div class="trust-summary-container mb-4">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="trust-summary-card">
                        <div class="trust-summary-title">
                            <i class="fas fa-user-check me-2"></i>현재 신뢰도 점수
                        </div>
                        <div class="trust-summary-value">
                            <span class="trust-value">72</span>
                            <span class="trust-unit">점</span>
                        </div>
                        <div class="trust-description">
                            거래 후 만족도 조사 결과를 통해 산정됩니다.
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="trust-summary-card">
                        <div class="trust-summary-title">
                            <i class="fas fa-medal me-2"></i>회원 등급
                        </div>
                        <div class="trust-summary-rating">
                            <span class="rating-badge">실버</span>
                            <div class="rating-progress-container">
                                <div class="rating-progress-bar" style="width: 70%"></div>
                            </div>
                        </div>
                        <div class="trust-description">
                            신뢰도 72점 + 포인트 84P = 156점 (골드까지 44점 남음)
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 만족도 평가 평균 섹션 -->
        <div class="satisfaction-average-container mb-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <div class="satisfaction-card">
                        <div class="satisfaction-title">평균 만족도</div>
                        <div class="satisfaction-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                        <div class="satisfaction-score">4.5 / 5.0</div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="satisfaction-card">
                        <div class="satisfaction-title">평가 분포</div>
                        <div class="satisfaction-bars">
                            <div class="satisfaction-bar-item">
                                <span class="bar-label">5점</span>
                                <div class="bar-container">
                                    <div class="bar-fill" style="width: 65%"></div>
                                </div>
                                <span class="bar-value">65%</span>
                            </div>
                            <div class="satisfaction-bar-item">
                                <span class="bar-label">4점</span>
                                <div class="bar-container">
                                    <div class="bar-fill" style="width: 25%"></div>
                                </div>
                                <span class="bar-value">25%</span>
                            </div>
                            <div class="satisfaction-bar-item">
                                <span class="bar-label">3점</span>
                                <div class="bar-container">
                                    <div class="bar-fill" style="width: 5%"></div>
                                </div>
                                <span class="bar-value">5%</span>
                            </div>
                            <div class="satisfaction-bar-item">
                                <span class="bar-label">2점</span>
                                <div class="bar-container">
                                    <div class="bar-fill" style="width: 5%"></div>
                                </div>
                                <span class="bar-value">5%</span>
                            </div>
                            <div class="satisfaction-bar-item">
                                <span class="bar-label">1점</span>
                                <div class="bar-container">
                                    <div class="bar-fill" style="width: 0%"></div>
                                </div>
                                <span class="bar-value">0%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 만족도 조사 내역 필터 -->
        <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
            <!-- 탭 필터 -->
            <div class="d-flex flex-wrap align-items-center">
                <div class="tab-nav">
                    <a class="tab-link active" href="#">전체 내역</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">대여자 평가</a>
                </div>
                <div class="tab-nav">
                    <a class="tab-link" href="#">대여인 평가</a>
                </div>
            </div>

            <!-- 정렬 옵션 (오른쪽) -->
            <div class="d-flex align-items-center">
                <!-- 날짜 필터 -->
                <div class="date-filter me-2">
                    <select class="form-control">
                        <option>전체 기간</option>
                        <option>최근 1개월</option>
                        <option>최근 3개월</option>
                        <option>최근 6개월</option>
                    </select>
                </div>

                <!-- 정렬 옵션 -->
                <div class="sort-container">
                    <select class="form-control sort-select">
                        <option>최신순</option>
                        <option>높은 점수순</option>
                        <option>낮은 점수순</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- 만족도 조사 내역 테이블 -->
        <div class="satisfaction-history-table">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 12%;">날짜</th>
                    <th style="width: 15%;">거래 유형</th>
                    <th style="width: 23%;">거래 내역</th>
                    <th style="width: 15%;">평가자</th>
                    <th style="width: 10%;">만족도</th>
                    <th style="width: 25%;">코멘트</th>
                </tr>
                </thead>
                <tbody>
                <!-- 만족도 조사 내역 - 높은 평가 -->
                <tr class="satisfaction-high-row">
                    <td>2025/04/05</td>
                    <td>대여인</td>
                    <td>코베아 텐트 3박 4일 대여</td>
                    <td>캠핑마스터</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="rating-value">5.0</span>
                        </div>
                    </td>
                    <td>약속 시간을 잘 지키고 장비도 깨끗하게 반납해주셨어요.</td>
                </tr>

                <!-- 만족도 조사 내역 - 높은 평가 -->
                <tr class="satisfaction-high-row">
                    <td>2025/04/01</td>
                    <td>대여자</td>
                    <td>캠핑 의자 2개 1박 2일 대여</td>
                    <td>자연인123</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="rating-value">5.0</span>
                        </div>
                    </td>
                    <td>의자 상태 좋았고 거래 과정이 매우 원활했습니다.</td>
                </tr>

                <!-- 만족도 조사 내역 - 보통 평가 -->
                <tr class="satisfaction-medium-row">
                    <td>2025/03/25</td>
                    <td>대여인</td>
                    <td>버너 세트 2박 3일 대여</td>
                    <td>불멍러버</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <span class="rating-value">3.0</span>
                        </div>
                    </td>
                    <td>대체로 만족했으나 약속 시간보다 30분 정도 늦게 도착하셨어요.</td>
                </tr>

                <!-- 만족도 조사 내역 - 높은 평가 -->
                <tr class="satisfaction-high-row">
                    <td>2025/03/20</td>
                    <td>대여자</td>
                    <td>침낭 1개 2박 3일 대여</td>
                    <td>캠퍼스타</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <span class="rating-value">4.0</span>
                        </div>
                    </td>
                    <td>침낭이 깨끗하고 좋았어요. 다음에도 이용할게요!</td>
                </tr>

                <!-- 만족도 조사 내역 - 낮은 평가 -->
                <tr class="satisfaction-low-row">
                    <td>2025/03/15</td>
                    <td>대여인</td>
                    <td>헬리녹스 체어 2개 1박 2일 대여</td>
                    <td>산속여우</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <span class="rating-value">2.0</span>
                        </div>
                    </td>
                    <td>의자에 얼룩이 있었고 약속 시간보다 늦게 반납하셨어요.</td>
                </tr>

                <!-- 만족도 조사 내역 - 높은 평가 -->
                <tr class="satisfaction-high-row">
                    <td>2025/03/10</td>
                    <td>대여자</td>
                    <td>랜턴 2개 3박 4일 대여</td>
                    <td>라이트맨</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span class="rating-value">4.5</span>
                        </div>
                    </td>
                    <td>좋은 상품 대여해주셔서 감사합니다! 다음에 또 이용할게요.</td>
                </tr>

                <!-- 만족도 조사 내역 - 높은 평가 -->
                <tr class="satisfaction-high-row">
                    <td>2025/03/05</td>
                    <td>대여인</td>
                    <td>캠핑 테이블 1개 2박 3일 대여</td>
                    <td>아웃도어맨</td>
                    <td>
                        <div class="star-rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="rating-value">5.0</span>
                        </div>
                    </td>
                    <td>매우 깨끗하게 사용하고 반납해 주셨습니다.</td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 신뢰도 안내 사항 -->
        <div class="trust-info-container mt-4 mb-4">
            <div class="trust-info-header">
                <i class="fas fa-info-circle me-2"></i> 신뢰도 안내
            </div>
            <div class="trust-info-content">
                <div class="trust-rule-section">
                    <h5 class="trust-rule-title">신뢰도 점수 산정 방식</h5>
                    <ul class="trust-rule-list">
                        <li>신뢰도는 거래 후 만족도 조사 결과를 기반으로 산정됩니다.</li>
                        <li>만족도 5점 = +5점, 4점 = +4점, 3점 = +2점, 2점 = -2점, 1점 = -5점으로 반영됩니다.</li>
                        <li>초기 신뢰도는 50점이며, 최대 100점까지 상승 가능합니다.</li>
                    </ul>
                </div>
                <div class="trust-rule-section">
                    <h5 class="trust-rule-title">회원 등급 기준</h5>
                    <ul class="trust-rule-list grade-list">
                        <li><span class="badge bg-secondary">브론즈</span> 포인트+신뢰도 합산 100점 미만</li>
                        <li><span class="badge bg-secondary" style="background-color: #C0C0C0 !important;">실버</span> 포인트+신뢰도 합산 100~199점</li>
                        <li><span class="badge bg-secondary" style="background-color: #FFD700 !important; color: #000 !important;">골드</span> 포인트+신뢰도 합산 200~299점</li>
                        <li><span class="badge bg-secondary" style="background-color: #50C8FF !important;">다이아몬드</span> 포인트+신뢰도 합산 300점 이상</li>
                    </ul>
                </div>
                <div class="trust-rule-section">
                    <h5 class="trust-rule-title">신뢰도 혜택</h5>
                    <ul class="trust-rule-list">
                        <li>신뢰도 70점 이상: 대여 가능 수량 증가 (5개 → 10개)</li>
                        <li>신뢰도 80점 이상: 대여 시 신분증 인증 절차 간소화</li>
                        <li>신뢰도 90점 이상: 프리미엄 장비 대여 자격 획득</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 페이징 처리 -->
        <div class="pagination-container d-flex justify-content-center">
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

<script>
    $(document).ready(function() {
        // 탭 클릭 이벤트
        $('.tab-link').click(function(e) {
            e.preventDefault();
            $('.tab-link').removeClass('active');
            $(this).addClass('active');

            // 여기에 탭 필터링 로직 추가
            const tabType = $(this).text().trim();

            if (tabType === '전체 내역') {
                $('tbody tr').show();
            } else if (tabType === '대여자 평가') {
                $('tbody tr').hide();
                $('tbody tr td:nth-child(2):contains("대여자")').parent().show();
            } else if (tabType === '대여인 평가') {
                $('tbody tr').hide();
                $('tbody tr td:nth-child(2):contains("대여인")').parent().show();
            }
        });

        // 정렬 옵션 변경 이벤트
        $('.sort-select').change(function() {
            const sortOption = $(this).val();
            const $items = $('tbody tr').get();

            $items.sort(function(a, b) {
                if (sortOption === '최신순') {
                    const dateA = new Date($(a).find('td:first').text());
                    const dateB = new Date($(b).find('td:first').text());
                    return dateB - dateA;
                } else if (sortOption === '높은 점수순') {
                    const scoreA = parseFloat($(a).find('.rating-value').text());
                    const scoreB = parseFloat($(b).find('.rating-value').text());
                    return scoreB - scoreA;
                } else if (sortOption === '낮은 점수순') {
                    const scoreA = parseFloat($(a).find('.rating-value').text());
                    const scoreB = parseFloat($(b).find('.rating-value').text());
                    return scoreA - scoreB;
                }
            });

            $.each($items, function(i, item) {
                $('tbody').append(item);
            });
        });

        // 날짜 필터 변경 이벤트
        $('.date-filter select').change(function() {
            const filterOption = $(this).val();
            const now = new Date();
            let filterDate = new Date();

            if (filterOption === '최근 1개월') {
                filterDate.setMonth(now.getMonth() - 1);
            } else if (filterOption === '최근 3개월') {
                filterDate.setMonth(now.getMonth() - 3);
            } else if (filterOption === '최근 6개월') {
                filterDate.setMonth(now.getMonth() - 6);
            } else {
                // 전체 기간
                $('tbody tr').show();
                return;
            }

            $('tbody tr').each(function() {
                const rowDate = new Date($(this).find('td:first').text());
                if (rowDate >= filterDate) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
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
    });
</script>

<style>
    /* 신뢰도 내역 페이지 전용 CSS */

    /* 신뢰도 요약 카드 스타일 */
    .trust-summary-card {
        background-color: #fff;
        border-radius: 10px;
        padding: 20px;
        height: 100%;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
    }

    .trust-summary-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .trust-summary-title {
        font-size: 16px;
        font-weight: 600;
        color: #495057;
        margin-bottom: 15px;
    }

    .trust-summary-value {
        display: flex;
        align-items: baseline;
        margin-bottom: 10px;
    }

    .trust-value {
        font-size: 32px;
        font-weight: 700;
        color: #2C5F2D;
    }

    .trust-unit {
        font-size: 20px;
        font-weight: 600;
        color: #6c757d;
        margin-left: 5px;
    }

    .trust-description {
        font-size: 14px;
        color: #6c757d;
        line-height: 1.5;
    }

    /* 회원 등급 관련 스타일 */
    .trust-summary-rating {
        margin-bottom: 10px;
    }

    .rating-badge {
        display: inline-block;
        background-color: #C0C0C0;
        color: white;
        font-size: 16px;
        font-weight: 600;
        padding: 5px 12px;
        border-radius: 4px;
        margin-bottom: 10px;
    }

    .rating-progress-container {
        height: 8px;
        background-color: #e9ecef;
        border-radius: 4px;
        overflow: hidden;
        margin-bottom: 10px;
    }

    .rating-progress-bar {
        height: 100%;
        background: linear-gradient(90deg, #C0C0C0 0%, #FFD700 100%);
        border-radius: 4px;
    }

    /* 만족도 평가 평균 섹션 */
    .satisfaction-card {
        background-color: #fff;
        border-radius: 10px;
        padding: 20px;
        height: 100%;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .satisfaction-title {
        font-size: 16px;
        font-weight: 600;
        color: #495057;
        margin-bottom: 15px;
        text-align: center;
    }

    .satisfaction-stars {
        font-size: 24px;
        color: #FFD700;
        margin-bottom: 10px;
    }

    .satisfaction-score {
        font-size: 18px;
        font-weight: 600;
        color: #333;
    }

    .satisfaction-bars {
        width: 100%;
    }

    .satisfaction-bar-item {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
    }

    .bar-label {
        width: 40px;
        font-size: 14px;
        font-weight: 500;
        color: #495057;
        text-align: right;
        margin-right: 10px;
    }

    .bar-container {
        flex: 1;
        height: 12px;
        background-color: #e9ecef;
        border-radius: 6px;
        overflow: hidden;
        margin-right: 10px;
    }

    .bar-fill {
        height: 100%;
        background-color: #2C5F2D;
        border-radius: 6px;
    }

    .bar-value {
        width: 40px;
        font-size: 14px;
        color: #495057;
    }

    /* 만족도 내역 테이블 스타일 */
    .satisfaction-history-table {
        margin-top: 20px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .satisfaction-history-table .table {
        margin-bottom: 0;
    }

    .satisfaction-history-table thead th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
        font-weight: 600;
        padding: 12px 15px;
        vertical-align: middle;
    }

    .satisfaction-history-table tbody td {
        padding: 12px 15px;
        vertical-align: middle;
        border-bottom: 1px solid #e9ecef;
    }

    .star-rating {
        display: flex;
        align-items: center;
        color: #FFD700;
    }

    .star-rating .fas.fa-star,
    .star-rating .far.fa-star,
    .star-rating .fas.fa-star-half-alt {
        font-size: 12px;
        margin-right: 1px;
    }

    .rating-value {
        margin-left: 5px;
        font-weight: 600;
        color: #495057;
        font-size: 14px;
    }

    /* 평가 등급별 행 스타일 */
    .satisfaction-high-row {
        background-color: rgba(40, 167, 69, 0.05);
    }

    .satisfaction-high-row:hover {
        background-color: rgba(40, 167, 69, 0.1);
    }

    .satisfaction-medium-row {
        background-color: rgba(255, 193, 7, 0.05);
    }

    .satisfaction-medium-row:hover {
        background-color: rgba(255, 193, 7, 0.1);
    }

    .satisfaction-low-row {
        background-color: rgba(220, 53, 69, 0.05);
    }

    .satisfaction-low-row:hover {
        background-color: rgba(220, 53, 69, 0.1);
    }

    /* 신뢰도 안내사항 스타일 */
    .trust-info-container {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .trust-info-header {
        font-size: 16px;
        font-weight: 600;
        color: #495057;
        margin-bottom: 15px;
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 10px;
    }

    .trust-info-content {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .trust-rule-section {
        flex: 1;
        min-width: 250px;
    }

    .trust-rule-title {
        font-size: 14px;
        font-weight: 600;
        color: #495057;
        margin-bottom: 10px;
    }

    .trust-rule-list {
        padding-left: 0;
        list-style: none;
        margin-bottom: 0;
    }

    .trust-rule-list li {
        margin-bottom: 8px;
        font-size: 14px;
        color: #6c757d;
        position: relative;
        padding-left: 12px;
    }

    .trust-rule-list li:before {
        content: "•";
        position: absolute;
        left: 0;
        color: #2C5F2D;
    }

    .grade-list li .badge {
        margin-right: 8px;
        min-width: 70px;
        text-align: center;
    }

    /* 탭 네비게이션 스타일 */
    .tab-nav {
        margin-right: 10px;
        margin-bottom: 10px;
    }

    .tab-link {
        display: inline-block;
        padding: 8px 16px;
        border-radius: 20px;
        text-decoration: none;
        color: #495057;
        background-color: #f8f9fa;
        transition: all 0.3s ease;
    }

    .tab-link:hover {
        background-color: #e9ecef;
    }

    .tab-link.active {
        background-color: #2C5F2D;
        color: white;
    }

    /* 정렬 및 필터 컨테이너 스타일 */
    .date-filter select,
    .sort-select {
        padding: 8px 12px;
        border-radius: 4px;
        border: 1px solid #ddd;
        font-size: 14px;
        color: #495057;
        background-color: white;
        cursor: pointer;
    }

    .date-filter select:focus,
    .sort-select:focus {
        outline: none;
        border-color: #2C5F2D;
    }

    /* 반응형 조정 */
    @media (max-width: 768px) {
        .trust-summary-container .row,
        .satisfaction-average-container .row {
            gap: 15px;
        }

        .trust-info-content {
            flex-direction: column;
        }

        .satisfaction-history-table {
            font-size: 14px;
        }

        .satisfaction-history-table .star-rating .fas.fa-star,
        .satisfaction-history-table .star-rating .far.fa-star,
        .satisfaction-history-table .star-rating .fas.fa-star-half-alt {
            font-size: 10px;
        }
    }

    @media (max-width: 576px) {
        .satisfaction-history-table thead th:nth-child(4),
        .satisfaction-history-table tbody td:nth-child(4) {
            display: none;
        }

        .tab-link {
            padding: 6px 12px;
            font-size: 13px;
        }
    }
</style>
</body>
</html>