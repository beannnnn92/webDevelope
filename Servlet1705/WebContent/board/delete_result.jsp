<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modify>delete</title>
</head>
<body>
<div id='delete_result'>
	<h3>delete result</h3>
	<span style='color: #e43030'>${delete_result }<br /><br /></div>
	<form name='frm_brd' method='post' action=''>
		<input type='button' name='btnList' value='to members' class='btn_list' /><br />
		
		
		<input type="hidden" name='serial' value='${param.serial }' />
		<input type="hidden" name='nowPage' value='${param.nowPage }' />
		<input type="hidden" name='findStr' value='${param.findStr }' />
	</form>
	
</div>
<script type="text/javascript">
var frm = document.frm_brd;
frm.btnList.onclick=function(){
	frm.action="list.do";
	frm.submit();
}
</script>
</body>
</html>