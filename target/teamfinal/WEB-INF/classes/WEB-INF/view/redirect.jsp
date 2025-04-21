<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>알림</title>
  <script type="text/javascript">
    window.onload = function() {
      var message = "${message}";
      if(message) {
        alert(message);
      }
      var redirectUrl = "${redirectUrl}";
      if(redirectUrl) {
        window.location.href = "${pageContext.request.contextPath}" + redirectUrl;
      } else {
        window.location.href = "${pageContext.request.contextPath}/equipregister-majorcategory.action";
      }
    };
  </script>
</head>
<body>
<p>페이지 이동 중입니다...</p>
</body>
</html>
