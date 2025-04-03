<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 검색결과</title>
  <link rel="stylesheet" type="text/css" href="css/search_equip_css.css">
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function () {
      // 왼쪽 카테고리 대분류에 마우스 올렸을 때/뗐을 때 오른쪽으로 중분류 나오게 처리
      $(".left-category > ul > li").hover(
              function () {
                // 마우스를 올렸을 때
                $(this).children(".left-category-sub").stop(true, true).fadeIn(50);
              },
              function() {
                // 마우스를 뗐을 때
                $(this).children(".left-category-sub").stop(true, true).fadeOut(50);
              });
      $(".fa-solid").click(function () {
        var currentColor = $(this).css('color');
        if (currentColor === 'rgb(242, 232, 207)') {
          $(this).css('color', '#e9745e');
        } else {
          $(this).css('color', '#f2e8cf');
        }
      });

      });
  </script>
</head>
<body>

  <header>
    <jsp:include page="Header.jsp"></jsp:include>
  </header>

  <div class="main-container">
    <div class="content">
      <!-- local category nav -->
      <div class="left-category">
        <ul>
          <li>
            <a id="all" href="" onclick="" class="on">ALL</a>
          </li>
          <li>
            <a id="brand" href="" onclick="">브랜드</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">가나다</a></li>
              <li><a href="" onclick="">라바사</a></li>
              <li><a href="" onclick="">아자카</a></li>
              <li><a href="" onclick="">타파하</a></li>
            </ul>
          </li>
          <li>
            <a id="category1" href="" onclick="">텐트/쉘터</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category2" href="" onclick="">취침용품</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category3" href="" onclick="">캠핑가구</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category4" href="" onclick="">조명/전력장비</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category5" href="" onclick="">조리장비</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category6" href="" onclick="">냉/난방장비</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category7" href="" onclick="">수납/운반용품</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
          <li>
            <a id="category8" href="" onclick="">기타장비</a>
            <ul class="left-category-sub">
              <li><a href="" onclick="">ALL</a></li>
              <li><a href="" onclick="">텐트</a></li>
              <li><a href="" onclick="">쉘터/타프</a></li>
              <li><a href="" onclick="">설치용부속품</a></li>
              <li><a href="" onclick="">보조텐트류</a></li>
              <li><a href="" onclick="">바닥보호시트</a></li>
              <li><a href="" onclick="">기타용품</a></li>
            </ul>
          </li>
        </ul>
      </div><!-- .left-category -->

      <!-- 오른쪽 상품 검색 결과 부분 -->
      <div class="right-contents">

          <!-- 상품 검색 키워드, 가격, 날짜 지정 -->
          <div class="filter-container">
            <div class="search-container2">
              <div class="search-inputs">
                <div class="input-group search">
                  <div class="input-label">키워드</div>
                  <div class="input-value">
                    <div class="search-container">
                      <form>
                        <label for="search-input">검색</label>
                        <input type="text" id="search-input" placeholder="키워드 검색(상품명 일부 키워드 / 브랜드명 등을 입력)">
                        <button type="submit" id="search-btn">
                          <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                        </button>
                      </form>
                    </div><!-- .search-container-->
                  </div>
                </div>
                <div class="input-group">
                  <div class="input-label">가격</div>
                  <div class="input-value">얼마 ~ 얼마까지 가능하신가요?</div>
                </div>
                <div class="input-group">
                  <div class="input-label">날짜</div>
                  <div class="input-value">대여 날짜는 언제인가요?</div>
                </div>
              </div><!-- .search-inputs-->
              <button class="search-button">필터적용</button>
            </div><!-- .search-container2-->
          </div><!-- .filter-container-->

        <!-- 총 개수, 정렬 -->
        <div class="count-sort">
          <p class="count">총 100개</p><!--ajax 처리 필요-->
          <div class="dropdown-sort">
            <label>
              <select>
                <option>정렬</option>
                <option>최신순</option>
                <option>낮은가격순</option>
                <option>높은가격순</option>
              </select>
            </label>
          </div><!-- .dropdown-sort-->
        </div><!-- .count-sort-->

        <!-- 검색 결과 상품 리스트 -->
        <div class="product-container">
          <!-- 상품 카드 반복 -->
          <ul>
            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <!-- 더 많은 상품 카드들 반복 (총 12개) -->
            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>

            <li>
              <a href="storen_matching_request.jsp"></a>
              <div class="product-card">
                <div class="product-image">
                  <div class="product-placeholder"></div>
                  <button class="like-button"><i class="fa-solid fa-heart" style="color: #f2e8cf;"></i></button>
                </div>
                <div class="product-info">
                  <p class="product-title">크라이어스 KOVEA W 4인용 거실형 텐트 패밀리 텐트</p>
                  <p class="product-brand">코베아몰</p>
                  <p class="product-price">36,000원</p>
                </div>
              </div>
            </li>
          </ul>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button>◀</button>
          <button class="active">1</button>
          <button>2</button>
          <button>3</button>
          <button>4</button>
          <button>5</button>
          <button>6</button>
          <button>7</button>
          <button>8</button>
          <button>9</button>
          <button>10</button>
          <button>▶</button>
          <button>≫</button>
        </div>
      </div><!-- .right-contents-->
    </div><!-- .content -->
  </div><!-- .main-container-->

  <!-- footer 외부 jsp 참조-->
  <jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>
