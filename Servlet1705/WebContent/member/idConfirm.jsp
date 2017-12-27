<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 확인창</title>
<style type="text/css">
body {
	background-color: rgb(220,215,212);
	color: black;
}
#frm_id_confirm {
	text-align: center;
	font-family: Monospaced;
	font-weight: bold;
	font-size: 13px;
}

#frm_id_confirm span {
	color: black;
	font-size: 15px;
}
#frm_id_confirm input{
	background-color: black;
	color: white;
	width: 70px;
}
</style>
<script type="text/javascript">
function func(b){
	if(b==0){
		window.opener.document.frm_insert.mid.value='';
		//ㄴ---> 아니면 못 쓰게 텍스트 폼을 초기화 시켜주는 것! 
	}
	self.close();
}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>

		<%
			String msg="";
			String mid = request.getParameter("mid");
			MemberDao dao = new MemberDao();
			boolean b = dao.idConfirm(mid);
			
		%>
	<div id='frm_id_confirm'>
	<span>중복 확인 창</span>
		<form name='frm_confirm'>
				<input type='hidden' name='mid' />
			<br />
		</form>
	<%
	if(b==true&&mid!=null){
		out.print(mid+"는 사용 가능한 ID입니다.<br /><br />");
		out.print("<input type='button' value='CLOSE' onclick='func(1)'>");
	} else {
		out.print(mid+"는 사용 불가능(중복)한 ID입니다.<br /><br />");
		out.print("<input type='button' value='CLOSE' onclick='func(0)'>");
	}
	%>
	</div>
	<script type="text/javascript">initJoin()</script>
</body>
</html>