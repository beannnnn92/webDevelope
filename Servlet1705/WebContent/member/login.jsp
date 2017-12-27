<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css">
<title>login</title>
<style type="text/css">
#login{
	position: relative;
}

#login #li_form{
	position: absolute;
	text-align: center;
	left: 44%; 
	top: 420px;
}
#li_form input {
	margin-top: 5px;
}
body {
background-image: url('https://vignette.wikia.nocookie.net/the-gossip/images/4/42/Welcome.png/revision/latest?cb=20140910233645');
background-repeat: no-repeat;
background-position: center 300px;
}
</style>
</head>
<body>
<div id='login'>
	<div id='li_form'>
	<form name='frm_login' method='post' action='login'>
		<label>ID &nbsp</label><input type='text' name='mid' size='18'/><br />
		<label>PWD &nbsp</label><input type='text' name='pwd' size='15' /><br /><p />
		
		<input type='submit' name='btnSubmit' value='로그인' />
		<input type='button' name='btnCancel' value='취소' onclick='history.back()' />
	</form>
	</div>
</div>
</body>
</html>