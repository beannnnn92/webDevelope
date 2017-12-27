<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modify>reply>result</title>
</head>
<body>
<div id='reply_result'>
	<h3>>> reply result</h3>
	${rMap['rs'] }..!
	<form name='frm_brd' method='post' action=''>
		<input type='button' name='btnList' value='TO LIST' />
		<input type="hidden" name='serial' value="${rMap['serial'] }" />
		<input type='hidden' name='findStr' value="${rMap['findStr'] }"/>
		<input type='hidden' name='nowPage' value="${rMap['nowPage'] }"/>
	</form>
	
</div>
<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.btnList.onclick=function(){
	frm.action="list.do";
	frm.submit();
}
</script>
</body>
</html>