<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@page import="member.MemberVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="../css/index.css">
<script src='../js/member.js'></script>
<style>
#content {
	margin: 0 auto;
	box-sizing: border-box;
	border: 1px dashed rgba(250, 250, 250, 0.3);
	background-color: rgba(0, 0, 0, 0.7);
	color: white;
	font-size: 13px;
	font-family: Verdana;
	line-height: 2.5;
}
#modify form label {
	width: 200px;
}
</style>
<script type="text/javascript">
function initModifyForm() {
	var url = 'index.jsp?inc=';
	var frm = document.frm_modify;
	
	var btnDelete = frm.btnDelete;
	var btnModify = frm.btnModify;
	
	btnDelete.onclick=function(){
		var yn = confirm("정말 삭제?");
		if(yn) {
			frm.action = 'delete_result.jsp';
			frm.submit();
		}
	}
	frm.btnModify.onclick = function() {
		var yn=confirm("수정?");
			frm.action = 'modify_result.jsp';
			frm.submit();
	}
	frm.btnCancel.onclick = function() {
		history.back();
	}
}


</script>
</head>
<body>
<div id='m_modify'>
<h1>J o i n . . . #</h1>
				<form name='frm_insert' method='POST' action='' >
					<label>> ID</label><input type='text' name='mid' id='mid' size='10' placeholder='아이디' />&nbsp<input type='button' name='id_confirm'
						id='btnIdConfirm' value='중복확인' /><br /> <label>> Name</label><input
						type='text' name='irum' id='irum' size='8'  placeholder='이름'/><br /> <label>> Password</label><input
						type='password' name='pwd' id='pwd' /><br /> <label>> Password check</label><input
						type='password' name='pwd_c' id='pwd_c' /><br />
						<label>> Nickname</label><input
						type='text' name='nickName' id='nickName'  placeholder='닉네임'/><br />
					
						 <label>> Gender
					</label><label><input type="radio" id='male' name='gender' value='MALE'/>남자</label><label><input
						type="radio" id='female' name='gender' value='FEMALE' />여자</label><br /> 
						<label>> Phone</label><input
						type='text' name='phone' id='phone'  placeholder='핸드폰 번호'/><br /> 
						<label>> E-mail</label><input
						type='text' name='email' id='email'  placeholder='abc123@ggg.com'/><br /> <label>> Address</label><input
						type='text' name='addr1' id='addr1'  placeholder='주소'/><br /> 
						<label>> Address2</label><input
						type='text' name='addr2' id=''addr2''  placeholder='상세주소'/><br /> <label>> Postal Code</label><input
						type='text' name='post' id='post'  placeholder='우편 번호'/><br /> <br /><br />
						<div id='btns'>
						<input
						type='button' name='Join' id='btnJoin' value='save' />&nbsp&nbsp&nbsp<input
						type='button' name='cancel' id='btnCancel' value='cancel' /></div>
				</form><br /><br /><br />


</div>

<script>
	initModifyForm()
</script>
</body>
</html>