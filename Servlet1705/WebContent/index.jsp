<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css/index.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<title>INDEX: 채송화</title>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");
String inc = "./board/list.jsp";

if(request.getParameter("inc")!=null) {
	inc = request.getParameter("inc");
}
%>
<div id='index'>
	<%@include file="header.jsp" %>
	
	<div id='content'>
		<h2 id='h2id'>S e r v l e t #</h2>
		<jsp:include page="<%=inc %>" />
	</div>
	<div id='footer'>
		<%@include file="footer.jsp" %>
	</div>
	
</div>
</body>
</html>