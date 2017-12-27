<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>member>insert</title>
<script type="text/javascript">
function initJoin() {
	var frm = document.frm_insert;
	var win;
	frm.btnJoin.onclick = function() {
		
		if($("input[name='mid']").val().length!=0 && $("input[name='irum']").val().length!=0 && $("input[name='pwd']").val().length!=0 && $("input[name='pwd_c']").val().length!=0 && $("input[name='nickName']").val().length!=0 && $("input[name='phone']").val().length!=0 && $("input[name='email']").val().length!=0 && $("input[name='addr1']").val().length!=0 && $("input[name='addr2']").val().length!=0 && $("input[name='post']").val().length!=0 && $("input[name='pwd_c']").val()==$("input[name='pwd']").val() && $("input[name='gender']").is(':checked')==true){
			frm.action="insertR.mm";
			frm.submit();					
		}else{
			if( $("input[name='mid']").val().length == 0){
				$('#mid_check').val(" *아이디를 입력하세요.");
			} else{
				$('#mid_check').empty("");
			}
			if( $("input[name='irum']").val().length == 0){
				$('#iru_check').val(" *이름을 입력하세요.");
			} else{
				$('#iru_check').empty("");
			}
			if( $("input[name='pwd']").val().length == 0){
				$('#pwd_check').val(" *비밀번호를 입력하세요.");
			} else{
				$('#pwd_check').empty("");
			}
			if( $("input[name='pwd_c']").val().length == 0){
				$('#pwdC_check').val(" *확인용 비밀번호 입력하세요.");
			}else if($("input[name='pwd_c']").val()!=$("input[name='pwd']").val()){
				$('#pwdC_check').val(" *비밀번호가 일치하지 않습니다.");
			}else{
				$('#pwdC_check').empty("");
			}
			if( $("input[name='nickName']").val().length == 0){
				$('#nic_check').val(" *닉네임을 입력하세요.");
			} else{
				$('#nic_check').empty("");
			}
			if( $("input[name='gender']").is(':checked')==false){
				$('#gen_check').val(" *성별을 체크하세요.");
			} else{
				$('#gen_check').empty("");
			}
			if( $("input[name='phone']").val().length == 0){
				$('#pho_check').val(" *핸드폰 번호를 입력하세요.");
			} else{
				$('#pho_check').empty("");
			}
			if( $("input[name='email']").val().length == 0){
				$('#ema_check').val(" *이메일 주소를 입력하세요.");
			} else{
				$('#ema_check').empty("");
			}
			if( $("input[name='addr1']").val().length == 0){
				$('#ad1_check').val(" *주소를 입력하세요.");
			} else{
				$('#ad1_check').empty("");
			}
			if( $("input[name='addr2']").val().length == 0){
				$('#ad2_check').val(" *상세 주소를 입력하세요.");
			} else{
				$('#ad2_check').empty("");
			}
			if( $("input[name='post']").val().length == 0){
				$('#pos_check').val(" *우편번호를 입력하세요.");
			} else{
				$('#pos_check').empty("");
			}
		}
	}
	frm.btnIdConfirm.onclick = function() {
		var page='./member/idConfirm.jsp?mid='+frm.mid.value;
		win = window.open(page, 'win',
				'width=380px, height=120px, resizable=no');
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
<div id='m_insert'>
<h1>J o i n . . . #</h1>
				<form name='frm_insert' method='POST' action='' >
					<label>> ID</label><input type='text' name='mid' id='mid' size='10' placeholder='아이디' />&nbsp<input type='button' name='id_confirm'
						id='btnIdConfirm' value='중복확인' /><output id='mid_check' style='color: red'></output><br /> <label>> Name</label><input
						type='text' name='irum' id='irum' size='8'  placeholder='이름'/><output id='iru_check' style='color: red'></output><br /> <label>> Password</label><input
						type='password' name='pwd' id='pwd' /><output id='pwd_check' style='color: red'></output><br /> <label>> Password check</label><input
						type='password' name='pwd_c' id='pwd_c' /><output id='pwdC_check' style='color: green'></output><br />
						<label>> Nickname</label>
						<input	type='text' name='nickName' id='nickName'  placeholder='닉네임'/>	<output id='nic_check' style='color: red'></output><br />
					
						 <label>> Gender
					</label><label><input type="radio" id='male' name='gender' value='MALE'/>남자</label><label><input
						type="radio" id='female' name='gender' value='FEMALE' />여자</label><output id='gen_check' style='color: red'></output><br /> 
						<label>> Phone</label><input
						type='text' name='phone' id='phone'  placeholder='핸드폰 번호'/><output id='pho_check' style='color: red'></output><br /> 
						<label>> E-mail</label><input
						type='text' name='email' id='email'  placeholder='abc123@ggg.com'/><output id='ema_check' style='color: red'></output><br /> 
						<label>> Postal Code</label><input type='text' name='post' id='post'  placeholder='우편 번호' readonly="readonly"/> <input type='button' name='btnPost' id='btnPost' value='검색' /><output id='pos_check' style='color: red'></output><br />
						<label>> Address</label><input type='text' name='addr1' id='addr1' placeholder='주소' size='34' readonly="readonly"/><output id='ad1_check' style='color: red'></output><br /> 
						<label>> Address2</label><input type='text' name='addr2' id='addr2'  placeholder='상세주소' size='34'/><output id='ad2_check' style='color: red'></output><br /> 
						<br /> <br /><br />
						<div id='btns'>
						<input	type='button' name='Join' id='btnJoin' value='save' />&nbsp&nbsp&nbsp<input
						type='button' name='cancel' id='btnCancel' value='취소' /></div>
				</form><br /><br /><br />

</div>
	<script>
		initJoin()
	</script>
</body>
</html>