<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board_list</title>
</head>
<body>
<div id='brd_list'>
	<h1>Data List</h1>
	<form name='frm_brd' method='post' action='' >
	<div id='topZone'>
			<input type='button' value='add data' name='btnInsert' id='btnInsert' class='enjoy-css'/>
		<div id='findZone'>
			<input type='text' value='${param.findStr }' name='findStr' id='findStr' class='tf_findStr' placeholder="검색어를 입력해주세요. " />
			<input type='button' value='search' name='btnFind' id='btnFind'  class='enjoy-css'/>
		</div>
	</div>
		<input type='hidden' name='serial' value="" /> 
		<input type='hidden' name='nowPage' value='${(param.nowPage==null)? 1:param.nowPage }' /> 

	<hr />
	<div id='title'>
		<span class='no'>No</span>
		<span class='subject'>Subject</span>
		<span class='worker'>Writer</span>
		<span class='mdate'>Date</span>
		<span class='hit'>Hit</span>
	</div>
		<c:set var='no' value="${dao.startNo }"/>
	<c:forEach var='vo' items="${list }">	
		<div id='list'>
			<span class='no'>${no }</span>
			<span class='subject'><a href='#' onclick="go(${vo.serial})">${vo.subject }</a><span class='cnt'>[${vo.cnt }]</span></span>
			<span class='worker'>${vo.worker }</span>
			<span class='mdate'>${vo.mdate }</span>
			<span class='hit'>${vo.hit }</span>
		</div>
		<c:set var='no' value='${no+1 }' />
	</c:forEach>
	<div id='pageZone'>
					<c:if test='${dao.nowBlock>1 }'>
						<input type='button' value="|<" name="btnFirst" onclick='goPage(1)' />
						<input type='button' value="<" name="btnPrev" onclick='goPage(${dao.startPage-1})' />
					</c:if>
					
					<c:forEach var='p' begin='${dao.startPage }' end='${dao.endPage }'>
						<c:choose>
							<c:when test='${p==0 }'></c:when>
							<c:otherwise>	
								<input type='button' value='${p }' ${(dao.nowPage==p)? 'disabled':'' } onclick='goPage(${p})' />
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${dao.nowBlock<dao.totBlock }" >
						<input type='button' value=">" name='btnNext' onclick='goPage(${dao.endPage+1})' />
						<input type='button' value=">|" name='btnLast' onclick='goPage(${dao.totPage})' />
					</c:if>
		</div>
	</form>

</div>
<script type="text/javascript">
var frm = document.frm_brd;
var url = "index.jsp?inc=./board/";
frm.btnInsert.onclick=function(){
	frm.action= "insert.do";
	frm.submit();
}
// 현재 정보를 가지고 list 재호출(나)
frm.btnFind.onclick=function(){
	frm.action = "list.do"; /* 수정 전: url + 'list.jsp' (jsp 페이지 다이렉트 호출) */
	frm.nowPage.value = 1;
	frm.submit();
}
function go(serial){
	frm.serial.value=serial;
	frm.action="view.do";
	frm.submit();	
}
function goPage(nowPage){
	if(frm==null) return;
	frm.nowPage.value=nowPage;
	frm.submit();
}
</script>
</body>
</html>