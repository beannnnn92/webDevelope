<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/index.css">

</head>
<body>
	<div id='m_modifyR'>
	<h2>modify complete!</h2>
		${rs }<br /><br />
		<input type='button' onclick="location.href='index.jsp?inc=./member/list.jsp'" value='to members list' class='btn_list'/>

	</div>

</script>
</body>
</html>