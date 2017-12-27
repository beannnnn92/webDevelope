<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id='reply'>
	<h3>>>reply to...</h3>
	<form name='frm_brd' method='post' action='' enctype='multipart/form-data'>
		<label>>writer </label><input type='text' size='12' name='worker' value='${sId }' readonly="readonly"/> [ <output name='mdate' ></output> ] <br />
		<label>>subject </label><input type='text' size='60' name='subject' placeholder='제목을 입력해주세요.' id='subject'/><output id='sub_check' style='color: red'></output><br />
		<label></label><textarea rows="20" cols="61" name='content' placeholder='내용을 입력해주세요.(5자 이상)' id='r_contents'></textarea><output id='con_check' style='color: red'></output><br />
		<label>>file upload </label><input type='file' name='attach1' /><br >
		<label></label><input type='file' name='attach2' /><br />
		<label>>pwd </label><input type='text' size='12' name='pwd' id='b_pwd'/><output id='pwd_check' style='color: red'></output><br />

<br /><br />
	<input type='text' name='serial' value='${param.serial }'/>
		<input type='hidden' name='nowPage' value='${param.nowPage }'/>
		<input type='hidden' name='findStr' value='${param.findStr }'/>
		<input type='hidden' name='grp' value='${param.grp }'/>
		<input type='hidden' name='deep' value='${param.deep }'/>
		<div id='btns'>
			<input type='button' value='SAVE' name='btnSave' id='btnSave'/>
			<input type='button' name='btnList' value='TO LIST' />
			<input type='button' name='btnCancel' value='CANCEL' />
		</div>
	</form>
	
</div>
<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.mdate.value=new Date().toLocaleDateString();
frm.btnList.onclick=function(){
	frm.action="list.do";
	frm.submit();
}
frm.btnSave.onclick=function(){
	if($('#subject').val().length!=0 && $('#r_contents').val().length>=5 && $('#b_pwd').val().length!=0){
		frm.action="replR.do";
		frm.submit();
	}else{
		if( $('#subject').val().length == 0){
			$('#sub_check').val("*제목을 입력하세요.");
		}else{
			$('#sub_check').empty("");
		}	
		if( $('#r_contents').val().length < 5){
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
frm.btnCancel.onclick=function(){
	frm.enctype='';
	frm.action="view.do";
	frm.submit();
}
</script>
</body>
</html>