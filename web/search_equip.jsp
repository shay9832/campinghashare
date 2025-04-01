<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 검색결과</title>
  <style type="text/css">
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
    }
    body {
      background-color: white;
    }
    div {
      display: block;
      unicode-bidi: isolate;
    }
    li {
      list-style-type: none;
    }
    .main-container {
      padding: 10px 20px;
    }
    .content {
      display: flex;
    }
    .left-category {
      position: sticky;
      background: rgba(255, 255, 255, 1);
      box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.1);
      border-top: 0;
      margin: 0 17px 0 0;
      border-radius: 20px;
      height: 528px;
      width: 10%;
    }
    .left-category li {
      position: relative; /* 부모 li에 relative 추가 */
    }
    .left-category li a {
      display: block;
      padding: 0 16px 0 16px;
      font-size: 13px;
      line-height: 44px;
      letter-spacing: -1px;
      color: #333;
      transition: all .5s;
    }
    .left-category li a:hover {
      color: beige;
      background: #E97451;
      border-radius: 8px;
    }
    .left-category li:hover .left-category-sub {
      visibility: visible;
      opacity: 1; /* 마우스를 올렸을 때 보이게 설정 */
      /*transition: opacity 0.3s ease, visibility 0s linear 0s;*/
    }
    .right-contents {
      width: 90%;
      background-color:beige;
    }
    .left-category-sub {
      position: absolute;
      top: 0;
      left: 100%;
      width: 160px;
      padding: 8px;
      box-sizing: border-box;
      background-color: #fff;
      box-shadow: 1px 1px 10px rgb(0 0 0 / 10%);
      opacity: 0;
      visibility: hidden;
      transition: all .5s;
    }
    .left-category-sub li a:hover{
      color: #E97451;
      background-color: transparent;
    }

  /* 오른쪽 콘텐츠 부분  */
    .filter-container {
      display: flex;
      flex-direction: column;
      gap: 15px;
      width: 100%;
    }
    .search-container, .search-container2 {
      width: 100%;
      max-width: 800px;  /* 최대 너비를 800px로 제한 */
      margin: 0 auto;  /* 중앙 정렬 및 좌우 여백 확보 */
    }
    .search-container {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 10px;
    }

    .search-container form {
      display: flex;
      align-items: center;
      border: 1px solid #ddd;
      border-radius: 25px;
      padding: 8px 12px;
      background-color: #fff;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      width: 100%;
      /*max-width: 400px;*/

    }

    .search-container label {
      display: none; /* 접근성을 위해 숨김 */
    }

    #search-input {
      flex-grow: 1;
      width: 100%;
      min-width: 150px;
      border: none;
      outline: none;
      font-size: 16px;
      padding: 8px;
      border-radius: 25px;
    }

    #search-btn {
      border: none;
      background: none;
      cursor: pointer;
      font-size: 18px;
      padding: 5px 10px;
    }
    /*검색창 아래 날짜선택, 가격필터*/
    .search-container2 {
      max-width: 1200px;
      background-color: white;
      border-radius: 50px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      padding: 10px;
      display: flex;
      align-items: center;
      overflow: hidden;
    }

    .search-inputs {
      display: flex;
      flex: 1;
      border-right: 1px solid #e5e5e5;
    }

    .input-group {
      flex: 1;
      padding: 10px 15px;
      border-right: 1px solid #e5e5e5;
    }

    .input-group:last-child {
      border-right: none;
    }

    .input-label {
      display: block;
      color: #666;
      font-size: 12px;
      margin-bottom: 5px;
    }

    .input-value {
      font-size: 14px;
      color: #333;
      font-weight: 500;
    }

    .search-button {
      background-color: #2C5F2D;
      color: white;
      border: none;
      border-radius: 30px;
      padding: 15px 30px;
      font-weight: bold;
      cursor: pointer;
      margin-left: 10px;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .search-button:hover {
      background-color: #2C5F2D;
    }

    @media (max-width: 768px) {
      .search-container2 {
        flex-direction: column;
        border-radius: 20px;
        padding: 15px;
      }
      .search-inputs {
        flex-direction: column;
        width: 100%;
        border-right: none;
      }

      .input-group {
        border-right: none;
        border-bottom: 1px solid #e5e5e5;
        padding: 10px 0;
      }

      .search-button {
        width: 100%;
        margin-left: 0;
        margin-top: 10px;
      }

      /* 검색결과 총 개수와 정렬방법 선택*/
      .count-sort {
        display: flex;
        background-color: red;
        border: 3px solid red;
        align-items: center;
        width: 100%; /* 전체 너비 설정 */
        /*max-width: 95%;*/
        margin: 0 auto;
        padding: 0 20px;
        justify-content: space-between; /* 각 요소를 양쪽 끝으로 배치 */
        gap: 20px; /* 두 항목 사이에 간격을 추가할 수 있습니다 */
      }

      .count p {
        justify-content: flex-start;
        font-size: 14px;
        color: #333;
        text-decoration: none;
        display: inline-block;
        padding: 10px 0;
        width: 50px;
      }

      .dropdown-sort {
        justify-content: flex-end;
        position: relative;
      }

      .dropdown-sort select {
        padding: 6px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #fff;
        font-size: 14px;
        color: #333;
        cursor: pointer;
        min-width: 120px;
      }
    }
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function () {
      $(".left-category > ul > li").hover(
              function () {
                // 마우스를 올렸을 때
                $(this).children(".left-category-sub").stop(true, true).fadeIn(50);
              },
              function() {
                // 마우스를 뗐을 때
                $(this).children(".left-category-sub").stop(true, true).fadeOut(50);
              })

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
      <div class="right-contents">
          <div class="filter-container">
            <div class="search-container">
              <form>
                <label for="search-input">검색</label>
                <input type="text" id="search-input" placeholder="키워드 검색(상품명 일부 키워드 / 브랜드명 등을 입력)">
                <button type="submit" id="search-btn">
                  <i class="fa-solid fa-magnifying-glass" style="color: #2c5f2d;"></i>
                </button>
              </form>
            </div><!-- .search-container-->
            <div class="search-container2">
              <div class="search-inputs">
                <div class="input-group">
                  <div class="input-label">키워드</div>
                  <div class="input-value">상품명 혹은 브랜드명을 입력해주세요</div>
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

      </div><!-- .right-contents-->
    </div><!-- .content -->
  </div><!-- .main-container-->
</body>
</html>
