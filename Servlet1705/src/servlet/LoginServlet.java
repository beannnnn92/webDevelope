package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDao;
import member.MemberVo;

public class LoginServlet extends HttpServlet {	// 패키지에 있는 servlet을 항상 상속 받는다.
	private static final long serialVersionUID = 1L;
	
/*	doGet, doPost -> 제일 많이 쓰는 애들 
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}*/
	
	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// 요청 정보 상태와 응답 정보의 상태값을 설정
			req.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			
			// 폼에 입력된 정보를 화면에 출력
			// web.xml이 dispatcher file
			PrintWriter pw = resp.getWriter();		// 응답정보에 있는 '결과'(?)를 출력하기 위한 소스 : 새로운 구조
			RequestDispatcher dispat = null;
			
			// variable - form name
			String mid = req.getParameter("mid");
			String pwd = req.getParameter("pwd");
			
			// TODO(DB를 연동하여 회원정보의 유무 판단)
			boolean r = true;		// 회원 정보가 있는 경우
			MemberDao dao = new MemberDao();
			MemberVo vo = new MemberVo();
			vo.setMid(mid);
			vo.setPwd(pwd);
			MemberVo rVo = dao.loginCheck(mid, pwd);
			if(rVo==null) r=false;
			
			// 세션에 mid를 sId로 저장하도록 처리 
			if(r){
				HttpSession session = req.getSession();		// session객체를 얻은 것.. '-'
				session.setAttribute("sId", rVo.getIrum());
				session.setAttribute("email", rVo.getEmail());
				resp.sendRedirect("../index.jsp");
			}else{
/*				HttpSession session = req.getSession();
				session.setAttribute("sId", null);*/
				pw.println("login fail...");
			}
		}
}
