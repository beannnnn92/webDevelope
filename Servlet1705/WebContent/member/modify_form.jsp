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
<style>

</style>
<script type="text/javascript">
function initModifyForm() {
	var url = 'index.jsp?inc=';
	var frm = document.frm_insert;
	
	var btnDelete = frm.btnDelete;
	var btnModify = frm.btnModify;
	
	btnDelete.onclick=function(){
		if($("input[name='pwd']").val().length>0 && $("input[name='pwd_c']").val().length>0 && $("input[name='pwd_c']").val()==$("input[name='pwd']").val() && $("input[name='pwd']").val() == $("input[name=voPwd]").val()){
			frm.action = 'deleteR.mm';
			frm.submit();
		}else{
			if( $("input[name='pwd']").val().length == 0){
				$('#pwd_check').val(" *비밀번호를 입력하세요.");
			} else{
				$('#pwd_check').empty("");
			}
			if( $("input[name='pwd_c']").val().length == 0){
				$('#pwdC_check').val(" *확인용 비밀번호 입력하세요.");
			}else if($("input[name='pwd_c']").val()!=$("input[name='pwd']").val()){
				$('#pwdC_check').val(" *입력하신 비밀번호가 일치하지 않습니다.");
			}else if($("input[name='pwd']").val()==$("input[name='pwd_c']").val() && $("input[name='pwd']").val()!=$("input[name='voPwd']").val()){
				alert("회원정보의 비밀번호와 일치하지 않습니다.");
				$('#pwdC_check').empty("");
			}else{
				$('#pwdC_check').empty("");
			}
			
		}
		
		
	}
	frm.btnModify.onclick = function() {
		var yn=confirm("입력한 값으로 회원 정보를 업데이트 합니다.");
			frm.action = 'modifyR.mm';
			frm.submit();
	}
	frm.btnCancel.onclick = function() {
		history.back();
	}
	document.getElementById("btnPost").onclick=function(ev){
		var x=ev.screenX+40;
		var y=ev.screenY-100;
		var pos='left='+x+', top='+y;
		var url='./member/zipCode.jsp';
		var win=window.open(url, 'win', pos+', width=600, height=320');
	}
	
	
}


</script>
</head>
<body>

	<div id='m_modify'>
			<form name='frm_insert' method='POST'>
				<label>아이디</label><input type='text' name='mid' id='mid'
					readonly="readonly" value='${vo.mid }' /><br /> <label>이름</label><input
					type='text' name='irum' id='irum' value='${vo.irum }' /><br />
					<label>닉네임</label><input
					type='text' name='nickname' id='nickname' value='${vo.nickName }' /><br />
				<label>비밀번호</label><input type="password" name='pwd' id='pwd' /><output id='pwd_check' style='color: red'></output><br /> <label>비밀번호 확인</label><input
					type="password" name='pwd_c' id='pwd_c' /><output id='pwdC_check' style='color: red'></output><br /><label>성별</label><label><input
					type="radio" name='gender' ${(vo.gender eq 'MALE' )?'checked':''} value='MALE' />남성</label>&nbsp&nbsp <label><input
					type="radio" name='gender' ${(vo.gender eq 'FEMALE' )?'checked':''} value='FEMALE'/>여성</label><br /> 
					<label>핸드폰 번호</label><input
					type='text' name='phone' id='phone' value='${vo.phone}' size='10'/><br />
					<label>이메일</label><input
					type='text' name='email' id='email' value='${vo.email }' size='30'/><br />
					<label>Postal Code</label><input type='text' name='post' id='post' placeholder='우편번호' /> <input type='button' name='btnPost' id='btnPost' value='검색'/><br />
				<label>주소</label><input type='text' name='addr1' id='addr1'
					value='${vo.addr1 }' size='36' /><br /> <label>상세 주소</label><input
					type='text' name='addr2' id='addr2' value='${vo.addr2 }' size='36' /><br /><br /><br />
		<div id='btns'>
			<input type='button' name='delete' id='btnDelete' value='삭제하기' />&nbsp&nbsp&nbsp
			<input type='button' name='modify' id='btnModify' value='확인(수정)' />&nbsp&nbsp&nbsp<input
				type='button' name='cancel' id='btnCancel' value='취소' /><input
				type='hidden' name='nowPage' value='${param.nowPage }' /><input
				type='hidden' name='findStr' value='${param.findStr }' />
				<input	type='hidden' name='voPwd' value='${vo.pwd }' />
		</div>
			</form><br />

	</div>
	<script>
		initModifyForm()
	</script>
</body>
</html>