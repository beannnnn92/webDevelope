<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<title>board>insert</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); 
%>
<div id='brd_insert'>
	<h1>>Data Insert. . .</h1>
	<form name='frm_brd' method='post' action='' enctype='multipart/form-data'>
		<label>>writer </label><input type='text' size='12' name='worker' value='${sId }' readonly="readonly"/> [ <output name='mdate' ></output> ] <br />
		<label>>subject </label><input type='text' size='60' name='subject' id='subject' placeholder='제목을 입력해주세요.'/><output id='sub_check' style='color: red'></output><br />
		<label></label><textarea rows="20" cols="61" name='content' id='b_contents' placeholder='내용을 입력해주세요.(5자 이상)'></textarea><output id='con_check' style='color: red'></output><br />
		<label>>file upload </label><input type='file' name='attach1' /><br >
		<label></label><input type='file' name='attach2' /><br />
		<label>>pwd </label><input type='text' size='12' name='pwd' id='b_pwd'/><output id='pwd_check' style='color: red'></output><br />
	<div id='btns'>
		<input type='button' value='save' name='btnSave' id='btnSave' />
		<input type='button' value='to list' name='btnList' id='btnList' />
	</div>
	</form><br /><br /><br />
</div>

<script type="text/javascript">
var frm = document.frm_brd;
frm.mdate.value=new Date().toLocaleDateString();
var url = "index.jsp?inc=./board/";
frm.btnList.onclick=function(){
	frm.action=url+"list.jsp";
	frm.submit();
}
frm.btnSave.onclick=function(){
	if($('#subject').val().length!=0 && $('#b_contents').val().length>=5 && $('#b_pwd').val().length!=0){
		frm.action="insertR.do";
		frm.submit();
	}else{
		if( $('#subject').val().length == 0){
			$('#sub_check').val("*제목을 입력하세요.");
		}else{
			$('#sub_check').empty("");
		}	
		if( $('#b_contents').val().length < 5){
			$('#con_check').val("*5글자 이상 입력해주세요."); 
		}else{
			$('#con_check').val("");
		}
		if( $('#b_pwd').val().length ==0){
			$('#pwd_check').val("*비밀번호 필요(수정, 삭제 시 필요)"); 
		}else{
			$('#pwd_check').val("");
		}
	}
}

</script>
</body>
</html>