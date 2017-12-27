<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modify>complete</title>
</head>
<body>
<div id='brd_modify_rs'>
	<h3>data modification result</h3>
	<font color='green'>${modifyMap['rs'] }..!</font>
	<form name='frm_brd' method='post' action=''>
		<input type='button' value='TO LIST' name='btnList' id='btnList' />
		<input type='button' value='DETAIL' name='btnView' id='btnView' />
		
		<input type='hidden' name='findStr' value="${modifyMap['findStr'] }"/>
		<input type='hidden' name='nowPage' value="${modifyMap['nowPage'] }"/>
		<input type='text' name='serial' value="${modifyMap['serial'] }" />		
	</form>
</div>
<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.btnList.onclick=function(){
	frm.action="list.do";
	frm.submit();
}
frm.btnView.onclick=function(){
	frm.action="view.do";
	frm.submit();
}
</script>
</body>
</html>