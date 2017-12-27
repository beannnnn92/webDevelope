<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view>delete>pwd</title>
</head>
<body>
<div id='delete_pwd'>
	<form name='frm_brd' method='post' >
		<label>>pwd </label><input type='text' name='pwd' size='10' id='m_pwd' /><output id='pwd_check' style='color: red'></output><br /><br />
		<input type="button" value='DELETE' name='btnDelete' id='btnDelete' />
		
		<input type='hidden' name='voPwd' id='voPwd' value='${pwd }'/>
		<input type='hidden' name='serial' id='serial' value='${serial }'/>
		<input type='hidden' name='nowPage' value='${param.nowPage }'/>
		<input type='hidden' name='findStr' value='${param.findStr }'/>
	</form>

</div>
<script type="text/javascript">
var frm = document.frm_brd;
frm.btnDelete.onclick=function(){
	if($('#m_pwd').val().length!=0){
		if($('#m_pwd').val()==$('#voPwd').val()){
			frm.action="deleteR.do";
			frm.submit();					
		}else{
			$('#pwd_check').val(" *글 작성 시 기입한 비밀번호와 일치하지 않습니다. ");
		}	
	}else{
		$('#pwd_check').val(" *비밀번호를 입력해주세요. ");
	}
}
</script>

</body>
</html>