package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardVo;
import member.MemberDao;
import member.MemberVo;

public class MemberServlet extends HttpServlet {
	String url = "index.jsp?inc=./member/";
	RequestDispatcher dispatcher;	
	MemberDao dao;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp); 
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		// PrintWriter pw =
		// resp.getWriter();
		// pw.write("OK!");
		String uri = req.getRequestURI();
		// url += req.getRequestURI();
		dao = new MemberDao();		

		if(uri.lastIndexOf("insertR.mm") >= 0) { 
			//dao작업
			MemberVo vo = new MemberVo();
			String mid=req.getParameter("mid");
			String pwd=req.getParameter("pwd");
			String nickName=req.getParameter("nickName");
			String irum=req.getParameter("irum");
			String gender=req.getParameter("gender");
			String email=req.getParameter("email");
			String post=req.getParameter("post");
			String addr1=req.getParameter("addr1");
			String addr2=req.getParameter("addr2");
			String phone=req.getParameter("phone");
			vo.setMid(mid);
			vo.setPwd(pwd);
			vo.setNickName(nickName);
			vo.setIrum(irum);
			vo.setGender(gender);
			vo.setEmail(email);
			vo.setPost(post);
			vo.setAddr1(addr1);
			vo.setAddr2(addr2);
			vo.setPhone(phone);
			
			String str =dao.memberInsert(vo);
			req.setAttribute("rs", str);
			
			dispatcher = req.getRequestDispatcher(url + "insert_result.jsp");
			dispatcher.forward(req, resp);
		}else if(uri.lastIndexOf("insert.mm")>=0){		// 발견 못 하면 -1 ㅇㅇ
			dispatcher = req.getRequestDispatcher(url+"insert.jsp");
			dispatcher.forward(req, resp);
		}else if(uri.lastIndexOf("list.mm")>=0|| uri.equals("/Servlet1705/index.jsp?inc=./member/list.jsp")){
			String findStr =""; 
			int nowPage = 1;				
			if(req.getParameter("findStr")!=null){
				findStr = req.getParameter("findStr");
			}
			if(req.getParameter("nowPage") != null){
				nowPage = Integer.parseInt(req.getParameter("nowPage"));
			}				
			ArrayList<MemberVo> list = dao.select(findStr, nowPage);
			req.setAttribute("list", list);
			req.setAttribute("dao", dao);
			
			dispatcher = req.getRequestDispatcher(url+"list.jsp");
			dispatcher.forward(req, resp);				
		}else if(uri.lastIndexOf("modify.mm")>=0){
			String findId = req.getParameter("mid");
			MemberVo vo = dao.selectOne(findId);
			req.setAttribute("vo", vo);
			
			dispatcher = req.getRequestDispatcher(url + "modify_form.jsp");
			dispatcher.forward(req, resp);
		}else if(uri.lastIndexOf("modifyR.mm")>=0){
			String str = dao.memberModify(req);
			req.setAttribute("rs", str);			
			
			dispatcher = req.getRequestDispatcher(url+"modify_result.jsp");
			dispatcher.forward(req, resp);
		}else if(uri.lastIndexOf("deleteR.mm")>=0){
			String str = dao.delete(req);
			req.setAttribute("delete_result", str);			
			
			dispatcher = req.getRequestDispatcher(url+"delete_result.jsp");
			dispatcher.forward(req, resp);
		}
	}
}
