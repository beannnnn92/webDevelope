<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css">
<title>login</title>
</head>
<body>
<div id='login'>
	<form name='frm_login' method='post' action='login'>
		<label>아이디</label><input type='text' name='mid' /><br />
		<label>비밀번호</label><input type='text' name='pwd' /><br /><p />
		
		<input type='submit' name='btnSubmit' value='로그인' />
	</form>
</div>
</body>
</html>