<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>zipCode.jsp</title>
<style type="text/css">
#zipCode{
	margin: 0 auto;
	text-align: center;
}
#result{
	width: 400px; 
	margin-top: 10px;
	font-size: 12px;
}

#zipCode input[type='button']{
	color: black;
	background-color: #a9d6be;
	font-size: 12px;
	line-height: 12px;
	padding: 3px;
}
</style>
<script type="text/javascript">
var xhr;
function zipFind(){
	var frm=document.frm_zip;
	var road=frm.road.value;

	var ip='./zip2.jsp?srchwrd='+encodeURIComponent(road);
	
	xhr = new XMLHttpRequest();
	xhr.open('get', ip);
	xhr.send();
	xhr.onreadystatechange=function(){
		if(this.status==200 && this.readyState==4){
			var rs=document.getElementById("result");
			rs.length=0;
			var doc = this.responseText;
			// 메모리 공간의 document에 저장 --이상한 곳에 출력되는 것을 막기 위해
			var newDoc = document.implementation.createHTMLDocument(""); //자동완성 기능이 없으니 사용할 때 유의할 것 
			newDoc.open();
			newDoc.write(doc);
			
			var nodeList=newDoc.getElementsByTagName("newAddressListAreaCd");/* 
			alert(nodeList.length);	//얼럿창으로 사이즈가 나오면 되겠지  */
			for(i=0; i<nodeList.length; i++){	//루핑작업
				var node=nodeList.item(i);
			var zipNo=node.getElementsByTagName('zipNo').item(0).firstChild.nodeValue;
			var rnAdres=node.getElementsByTagName('rnAdres').item(0).firstChild.nodeValue;
			var lnmAdres=node.getElementsByTagName('lnmAdres').item(0).firstChild.nodeValue;
			
			var op=new Option('우) '+zipNo+' / '+rnAdres, zipNo);
			rs.options[rs.length]=op;
			}
			
		}		
	}
	frm.result.ondblclick=function(){
		var idx=frm.result.selectedIndex;	//내가 선택한 것이 실제 들어가는 값이 되게끔 일치시키는 작업
		var zipCode=frm.result[idx].value;	//zipCode ㅇㅇ 
		var tempAddress=frm.result[idx].text.split('/ ');	// split하면 찢어져서 앞/뒤가 배열로 들어간다 '/ '은 분기점
		
		opener.document.frm_modify.post.value=zipCode;
		opener.document.frm_modify.addr1.value=tempAddress[1];
		self.close();
	}
}
</script>
</head>
<body>
<div id='zipCode'>
<h3>postal code search</h3>
	<form name='frm_zip' method='POST'>
		<input type='text' name='road' value='' placeholder='도로명 주소를 검색해주세요.'/>
		<input type='button' id='btnZipFind' onclick='zipFind()' value='search' />
		<select size='10' name='result' id='result'></select> <!-- form 안에 있어야겠지 -->
		<br /><br /><!-- <input type='button' name='btnOkay' id='btnOkay' value='확인' /> --><input type='button' name='btnClose' id='btnClose' value='닫기' /> 
	</form>
</div>
</body>
</html>