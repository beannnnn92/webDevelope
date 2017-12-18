<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function header_init(){
	var btnLogin=document.getElementById("btnLogin");
	var btnLogout=document.getElementById("btnLogout");
	
	if(btnLogin!=null){
		btnLogin.onclick=function(){
			location.href='./member/login.jsp';		
		}
	}
	if(btnLogout!=null){
		btnLogout.onclick=function(){
			location.href='./member/logout.jsp';		
		}
	}
}
</script>
<title>header</title>
</head>
<body>
<%-- <%
String sId= (String)session.getAttribute("sId");
%>
<div id='header'><%
if(sId==null){%>
	<input type='button' value='LOGIN' id='btnLogin' /><%
}else{%>
	<input type='button' value='LOGOUT' id='btnLogout' /><%
}%>
</div> --%>
<%-- 
<%
session.setAttribute("sId", "dd");
%> --%>
<div id='header'>
	<c:if test="${sId==null }">
		<input type='button' value='LOGIN' id='btnLogin' /></c:if>
	<c:if test="${sId!=null }">
		<input type='button' value='LOGOUT' id='btnLogout' /></c:if>
</div>
<script type="text/javascript">header_init()</script>
</body>
</html>