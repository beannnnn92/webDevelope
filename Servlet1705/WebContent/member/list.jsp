<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberVo"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>servlet member list</title>
<script type="text/javascript">
function initList(){
	var frm = document.frm_member;
	var btnAddMember = frm.btnAddMember;
	var btnFind = frm.btnFind;
	
	if(btnFind!=null){
		btnFind.onclick = function(){
			frm.nowPage.value=1;
			frm.action="list.mm";
			frm.submit();
		}
	}
	
	if(btnAddMember!=null){
		btnAddMember.onclick = function(){
			frm.action="insert.mm";
			frm.submit();
		}
	}
}

function listModify(obj){
	var frm=document.frm_member;
	if(frm != null){
		frm.action='modify.mm';
		frm.mid.value=obj.text;
		frm.submit();
	}
}

function movePage(nowPage){
	if(document.frm_member==null) return;
	var frm=document.frm_member;
	frm.nowPage.value=nowPage;
	frm.submit();
}
</script>
</head>
<body>
<div id='m_list'>
	<form name='frm_member' method='POST'>
	<div id='topZone'>
	<div id='btnInsert'><input type='button' id='btnAddMember' value='회원 추가' />&nbsp&nbsp&nbsp</div>
		<div id='findZone'>
		<input type='text' id='findStr' name='findStr' value='${param.findStr }' class='tf_findStr' placeholder="검색어를 입력해주세요. " />&nbsp<input type='submit' name='btnFind' id='btnFind' value='검색' /><br />
		<input type='hidden' name='mid'/></div>
	</div>
	<div id='title'>
		<span class='no'>NO</span>
		<span class='mid'>ID</span>
		<span class='irum'>NICKNAME</span>
		<span class='phone'>PHONE</span>
		<span class='gender'>GENDER</span>
		<span class='address'>ADDRESS</span>
	</div>
<c:set var='no' value="${dao.startNo }"/>
<c:forEach var='vo' items="${list }">
	<div id='list'>
		<span class='no'>${no }</span>
		<span class='mid'>
			<a href='#' onclick='return listModify(this)'>${vo.mid }</a></span>
		<span class='irum'>${vo.irum }</span>
		<span class='phone'>${vo.phone }</span>
		<span class='gender'>${vo.gender }</span>
		<span class='address'>${vo.addr1} / ${vo.addr2}</span></div>
		<c:set var='no' value='${no+1 }' />
</c:forEach><br />
				<div id='page' style='text-align: center'>
					<c:if test='${dao.nowBlock>1 }'>
						<input type='button' value="|<" name="btnFirst" onclick='movePage(1)' />
						<input type='button' value="<" name="btnPrev" onclick='movePage(${dao.startPage-1})' />
					</c:if>
							<c:forEach var='i' begin='${dao.startPage }' end='${dao.endPage }'>
					<c:choose>
						<c:when test='${i==0 }'>						
						</c:when>
						<c:otherwise>
								
								<input type='button' value='${i }' name='btn1'
									onclick='movePage(${i})' />
						</c:otherwise>
					</c:choose>
							</c:forEach>
					<c:if test="${dao.nowBlock<dao.totBlock }" >
							<input type='button' value=">" name='btnNext' onclick='movePage(${dao.endPage+1})' />
							<input type='button' value=">|" name='btnLast' onclick='movePage(${dao.totPage})' />
						</c:if>
							<input type="hidden" name='nowPage' value='${dao.nowPage }' />
				</div>
		</form>
</div>
<script type="text/javascript">initList()</script>
</body>
</html>