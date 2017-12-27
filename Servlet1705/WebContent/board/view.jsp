<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board>list>view</title>
<style type="text/css">
#view span{ display: inline-block;}
#view .pwd { margin-right: 300px;}
#view .lbpwd { width: 46px;}
</style>
</head>
<body>
<div id='view'>
	<h3>>>database detail view</h3>
	<%
	String sId=null;
	if(session.getAttribute("sId")!=null){
		sId = (String)session.getAttribute("sId"); 
	}
	%>

	<form name='frm_brd' method='post' action=''>
	<label>>writer</label><input type='text' name='worker' size='10' value='${vo.worker }' readonly="readonly"/> [ ${vo.mdate } / hit: ${vo.hit } ] <br />
	<label>>e-mail</label><a href='#' onclick="mail('${vo.email }')"><span class='email'>${vo.email }</span></a><br />
		<label>>subject </label><input type='text' name='subject' size='69' readonly="readonly" value='${vo.subject }' /><br />
		<div id='view_result'>${vo.content }</div><c:if test="${vo.attFile !=null }">
		<label style='width: 60px'>>file</label> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - <br />
		<c:forEach var="att" items="${vo.attFile }">
			<a href="./download/${att.key }" download><img src="./download/${att.key }" alt = "${att.value }" width='320px' height='38%' />
			</a>
		</c:forEach>
		</c:if><br />
		<p />
		<input type='hidden' name='serial' value='${param.serial }'/>
		<input type='hidden' name='nowPage' value='${param.nowPage }'/>
		<input type='hidden' name='findStr' value='${param.findStr }'/>
		<input type='hidden' name='grp' value='${vo.grp }'/>
		<input type='hidden' name='deep' value='${vo.deep }'/>
			<input type='hidden' name='voPwd' id='voPwd' value='${vo.pwd }'/>
		<div id='btns'>
		<c:if test="${sId==vo.worker||sId==null }">
			<input type="button" value='MODIFY' name='btnModify' id='btnModify' />
			<input type="button" value='DELETE' name='btnDelete' id='btnDelete' />
		</c:if>			
			<input type="button" value='REPLY' name='btnRepl' id='btnRepl' />
			<input type="button" value='TO LIST' name='btnList' id='btnList' />
		</div>
	</form>	
</div>

<script type="text/javascript">
var frm = document.frm_brd;
var win;
var url = "index.jsp?inc=./board/";
if(frm.btnModify!=null){
	frm.btnModify.onclick=function(){
		frm.action="modify.do";
		frm.submit();		
	}
}
if(frm.btnDelete!=null){
frm.btnDelete.onclick=function(){
	frm.action="delete.do";
	frm.submit();		
	}
}
frm.btnRepl.onclick=function(){
	frm.action="repl.do";
	frm.submit();
}
frm.btnList.onclick=function(){
	frm.action="list.do";
	frm.submit();
}

function mail(reciever){
	var page='./email/mail_form.jsp?reciever='+reciever;
	win = window.open(page, 'win','width=620px, height=660px, resizable=no');
}
</script>
</body>
</html>