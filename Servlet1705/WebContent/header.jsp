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
	var btnJoin=document.getElementById("btnJoin");
	
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
	if(btnJoin!=null){
		btnJoin.onclick=function(){
			location.href='index.jsp?inc=./member/insert.jsp';		
		}
	}
	if(btnMemberList!=null){
		btnMemberList.onclick=function(){
			location.href='index.jsp?inc=./member/list.jsp';		
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
	<div id='login_area'>
		<c:if test="${sId==null }">로그인해주세요...<input type='button' value='log-in' id='btnLogin' class='enjoy-css' /> <input type='button' value='join' id='btnJoin' class='enjoy-css' /></c:if>
		<c:if test="${sId!=null }"><span class='li_msg'>${sId }님이 로그인했습니다!</span><input type='button' value='log-out' id='btnLogout' /> <input type='button' value='members' id='btnMemberList' /></c:if></div>
	<div id='nav_area'>
		<h2><a href="index.jsp" >data management site(feat.Servlet)</a></h2>
	</div>
</div>
<script type="text/javascript">header_init()</script>
</body>
</html>