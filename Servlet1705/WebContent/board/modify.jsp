<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<title>board>list>view>modify</title>
</head>
<body>
<div id='mod'>
	<h3>data modify</h3>

	<form name='frm_brd' method='post' action='' enctype='multipart/form-data'>
	
		<label>>writer</label><input type='text' name='worker' size='10' value='${vo.worker }' readonly="readonly"/> [ ${vo.mdate } / hit: ${vo.hit } ] <br />
		<label>>subject </label><input type='text' name='subject' id='subject' size='69' value='${vo.subject }' placeholder='제목을 입력해주세요.'/><output id='sub_check' style='color: red'></output><br />
		<label></label><textarea rows="20" cols="61" name='content' id='b_contents' placeholder='내용을 입력해주세요.(5자 이상)'>${vo.content }</textarea><output id='con_check' style='color: red'></output><br />	
		<label>>pwd </label><input type='text' name='pwd' size='10' id='m_pwd' /><output id='pwd_check' style='color: red'></output><br />
		<label style='float: left'>&nbspfile(modify) </label>
		<c:if test='${vo.attFile!=null }'>
			<c:forEach var='att' items='${vo.attFile }'>
				<div class='attFile'>
					<img src='./download/${att.key }' alt='${att.value }' width='200px' height='30%'><label>
					<input type='checkbox' name='deleteAtt' value='${att.key }' onclick='delFunc(this)'> delete </label>
				</div><br />
			</c:forEach>			
		</c:if>
		<div id='attZone'>
			<c:forEach var='att' begin='1' end='${2-vo.attFile.size() }'>
				<div><label></label><input type='file' name='attch${att }' /></div>
			</c:forEach>		
		</div>
		<br />
		<p />
			<input type='hidden' name='serial' value='${vo.serial }'/>
			<input type='hidden' name='nowPage' value='${param.nowPage }'/>
			<input type='hidden' name='findStr' value='${param.findStr }'/>
			<input type='hidden' name='grp' value='${vo.grp }'/>
			<input type='hidden' name='deep' value='${vo.deep }'/>
			<input type='hidden' name='voPwd' id='voPwd' value='${vo.pwd }'/>
		<div id='btns'>
			<input type='button' value='SAVE' name='btnModify' id='btnModify'/>
			<input type='button' value='CANCEL' name='btnList' id='btnList' />
		</div>
		<!-- hidden tag -->
	</form>
</div>

<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.btnList.onclick=function(){
	history.back();
}
frm.btnModify.onclick=function(){
	if($('#m_pwd').val().length!=0 && $('#subject').val().length!=0 && $('#b_contents').val().length>=5  ){
		if($('#m_pwd').val()==$('#voPwd').val()){
			frm.action="modifyR.do";
			frm.submit();					
		}else{
			$('#pwd_check').val(" *글 작성 시 기입한 비밀번호와 일치하지 않습니다. ");
		}		
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
		
		if( $('#m_pwd').val().length == 0){
			$('#pwd_check').val(" *비밀번호를 입력하세요.");
		}else{
			$('#pwd_check').empty("");
		}
	}
}

var cnt=3;
function delFunc(obj){
	var attZone=document.getElementById("attZone");
	if(obj.checked){		//obj가 checked 되어있으면 if문을 돈다. (obj: type=checkbox)
		var div=document.createElement('div');
		var lbl=document.createElement('label');
		var input=document.createElement('input');
		input.setAttribute('type', 'file');
		input.setAttribute('name', 'att'+cnt);
		div.appendChild(lbl);
		div.appendChild(input);
		attZone.appendChild(div);
		cnt++;
	}else{
		var remove = attZone.lastChild;
		attZone.removeChild(remove);
		cnt--;
	}
}
</script>
</body>
</html>