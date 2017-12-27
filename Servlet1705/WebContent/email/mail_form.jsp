<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css">
<title>EMAIL FORM</title>
<style type="text/css">
#mail_form label{
	display: inline-block; width: 120px;
}
#mail_form { line-height: 30px; margin-left: 13%;}

#mail_form #btns { margin-left: 29%;}
</style>
<script type="text/javascript">
var cnt = 0; //file태그의 name값을 구분{fleName1, fleName2, ...)
function append(ev) {
	var tags = document.getElementsByClassName('fleName');
	var yn = true; //fle 태그중 값이 비어있는 태그가 없다면 true
	for (var t = 0; t < tags.length - 1; t++) {
		if (tags[t].value == '') {
			var br = tags[t].nextElementSibling;//fle태그 오른쪽에 있는 br 태그
			var img = tags[t].previousElementSibling; // file태그 왼쪽에 있는 img 태그

			img.parentNode.removeChild(img);
			br.parentNode.removeChild(br);
			tags[t].parentNode.removeChild(tags[t]);
			yn = false;
		}
	}
	if (yn) {
		cnt++;
		var img = document.createElement("img");
		var file = document.createElement('input');
		var br = document.createElement('br');

		file.setAttribute('type', 'file');
		file.setAttribute('class', 'fileName');
		file.setAttribute('name', 'fileName' + cnt);
		file.onchange = append;

		//imgs 속성
		img.setAttribute("width", "30px");
		img.setAttribute("align", "center");
		img.setAttribute("id", "fileName" + cnt);

		// file태그와 br를 attfile 영역에 추가
		var div = document.getElementById("attfile");
		div.appendChild(img);
		div.appendChild(file);
		div.appendChild(br);

		// 첨부파일 미리보기 - 섬네일

		var event = ev || window.event;
		if (event == null)
			return;

		var file = event.srcElement; //이벤트가 발생한 요소
		var tagName = file.name; // 이벤트가 발생한 태그의 이름
		var url = file.files[0]; // 파일 태그에 선택된 파일 오브젝트

		var reader = new FileReader();//파일을 로딩하기 위한 자바스크립트 객체

		reader.onload = function(ev2) {
			var img = new Image();
			img.src = ev2.target.result; // 로딩된 이미지 경로
			document.getElementById(tagName).src = img.src;
		}
		reader.readAsDataURL(url);
	}
}
</script>
</head>
<body>
<div id='mail_form'>
<br />
<h1>>E-Mail Send. . .</h1>
	<form name='frm_mail' method='post' action='mail_send.jsp' enctype='multipart/form-data'>
		<label>>sender </label><input type='text' size='26' name='sender' value='${email }' readonly="readonly"/><br />
		<label>>reciever </label><input type='text' size='26' name='receiver' value='${param.reciever }' readonly="readonly"/><br />
		<label>>subject </label><input type='text' size='42' name='subject' /><br />
		<label></label><textarea rows="20" cols="61" name='content'></textarea><br />
		<div id='attfile'>
		<label>>file upload </label></div><br ><br /><br />
	<div id='btns'>
		<input type='submit' value='SEND' name='btnSend' id='btnSend' />
		<input type='button' value='CANCEL' name='btnCancel' id='btnCancel' />
	</div>
	</form> 
</div>
<script type="text/javascript">
var frm=document.frm_mail;
frm.btnSend.onclick=function(){
}
frm.btnCancel.onclick=function(){
	self.close();
}
append()
</script>

</body>
</html>