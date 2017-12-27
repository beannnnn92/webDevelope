<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원삭제</title>

</head>
<body>

<div id='m_deleteR'>
	<h3>회원삭제 결과</h3>
	${delete_result }<br /><br />
	<br />
	<form name='frm_member' method='post'>
		<input type='button' value='to members' class='btn_list' name='btnList' id='btnList'/> 
		<input type="hidden" name='serial' value='${param.serial }' />
		<input type="hidden" name='nowPage' value='${param.nowPage }' />
		<input type="hidden" name='findStr' value='${param.findStr }' />
	</form>
</div>
<script type="text/javascript">
var frm = document.frm_member;
frm.btnList.onclick=function(){
	frm.action="list.mm";
	frm.submit();
}
</script>
</body>
</html>