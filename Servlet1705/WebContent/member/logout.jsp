<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css">
<title>logout</title>
</head>
<body>
<%
session.setAttribute("sId", null);
response.sendRedirect("/Servlet1705/index.jsp");
%>
<div id='logout'>

	
</div>
</body>
</html>