<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="resources/css/index.css"/>
<link rel="stylesheet" href="resources/css/all.css"/>
<script type="text/javascript" src="resources/js/nav.js"></script>
<meta name="viewport" content="width=device-width"/>
<title>Meali 2</title>
</head>
<body>
	<jsp:include page="main_header.jsp"/>
	<jsp:include page="nav.jsp"/>
	<section class="container">
    	<a href="record.jsp">음성인식</a>
    	<a href="image.jsp">이미지인식</a>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>