<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="resources/css/index.css"/>
<link rel="stylesheet" href="resources/css/all.css"/>
<script type="text/javascript" src="resources/js/nav.js"></script>
<meta name="viewport" content="width=device-width"/>
<title>Insert title here</title>
</head>
<body>
  <jsp:include page="sub_header.jsp"/>
  <jsp:include page="nav.jsp"/>
  <section class="container">
  	<form name="newImage" action="processAddImage.jsp" method="POST" enctype="multipart/form-data">
  		<input class="inputBox" type="file" name="filename" id="filename">
  		<input id="sendbtn" type="submit" value="보내기"/>
  	</form>
  </section>
</body>
</html>