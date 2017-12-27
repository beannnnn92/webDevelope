<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board>insert_result</title>
</head>
<body>
<%
String worker = request.getParameter("worker");
String subject = request.getParameter("subject");
%>
<div id='brd_insert_rs'>
	<h2>insert result...</h2>
	<span style='color: #e43030'>${msg }</div>
	<form name='frm_brd' method='post' action=''>
		<input type='button' value='to upload' name='btnAdd' id='btnAdd' />
		<input type='button' value='to list' name='btnList' id='btnList' />
	</form>
</div>
<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.btnList.onclick=function(){
	frm.action=url+"list.jsp";
	frm.submit();
}
frm.btnAdd.onclick=function(){
	frm.action=url+"insert.jsp";
	frm.submit();
}
</script>
</body>
</html>