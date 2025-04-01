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
    .local-sub-nav {
      position: relative;
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
          <div class="count">
            <p></p>
          </div>
      </div><!-- .right-contents"-->
    </div><!-- .content -->
  </div><!-- .main-container-->
</body>
</html>
