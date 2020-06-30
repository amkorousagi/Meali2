<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dao.stt"%>
<%@ page import="dao.Natural_Language"%>
<%@ page import="dao.Pair"%>
<%@ page import="java.net.URL"%> 
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String saveFolder = "C:\\filestorage";
	String encoding = "utf-8";
	int maxSize = 5*1024*1024;
	MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy()); 
	File f = multi.getFile("filename");
	stt s = new stt();
	String text =  s.speechtotext(new FileInputStream(f));
	Natural_Language nl = new Natural_Language();
	List<Pair> list = nl.analyzeEntitiesText(text);
%>
<html>
  <head>
    <title>Meali 2</title>
    <link rel="stylesheet" href="resources/css/index.css"/>
	<link rel="stylesheet" href="resources/css/all.css"/>
	<script type="text/javascript" src="resources/js/nav.js"></script>
    <script src="resources/js/sigma.min.js"></script>
    <script src="resources/js/plugins/sigma.plugins.relativeSize.min.js"></script>
    <style>
      html { height:100%;}
      body {height: 100%;}
      #sigma-container { width:100%; height:70%; background-color:#E1E1E1}
    </style>
  </head>
  <body>
    <jsp:include page="sub_header.jsp"/>
  	<jsp:include page="nav.jsp"/>
    <div id='sigma-container'></div>
    <script>
    var s = new sigma(
  		  {
  		    renderer: {
  		      container: document.getElementById('sigma-container'),
  		      type: 'canvas'
  		    },
  		    settings: {
  		    	minNodeSize:1,
  		    	maxNodeSize:50
  		    }
  		  }
  		);

  		// Generate a random graph:
  		var nbNode = <%=list.size()%>;
  		var graph = {
  		  nodes: [],
  		  edges: []
  		};
  		<%for(int i = 0; i < list.size(); i++) {%>
  		  graph.nodes.push({ 
  		    id:  <%=i%>,
  		    label: '<%=list.get(i).getKey()%>' ,
  		    x: Math.random(),
  		    y: Math.random(),
  		    size: <%=list.get(i).getValue()*100%>,
  		    color: '#'+Math.round(Math.random() * 0xFFFFFF).toString(16)
  		  });
  		<%}%>
  		// load the graph
  		s.graph.read(graph);
  		// draw the graph
  		s.refresh();
  		// launch force-atlas for 5sec
  		s.startForceAtlas2();
  		window.setTimeout(function() {s.killForceAtlas2()}, 10000);
    </script>
    <a><%=text%></a>
    <jsp:include page="footer.jsp"/>
  </body>
</html>