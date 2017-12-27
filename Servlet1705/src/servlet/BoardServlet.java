package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDao;
import board.BoardVo;

public class BoardServlet extends HttpServlet {	// 패키지에 있는 servlet을 항상 상속 받는다.

	String url="index.jsp?inc=./board/";
	RequestDispatcher dispatcher;
	BoardDao dao;
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doPost(req, resp);		// doPost를 자동으로 호출하는 코드
		}
	
	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			//PrintWriter pw = resp.getWriter();
//			pw.write("OK!");
			String uri = req.getRequestURI();
//			url += req.getRequestURI();
			
			dao = new BoardDao();
			
			// 자료 입력 버튼이 클릭된 경우
			if(uri.lastIndexOf("insert.do")>=0){		// 발견 못 하면 -1 ㅇㅇ
				dispatcher = req.getRequestDispatcher(url+"insert.jsp");
				dispatcher.forward(req, resp);
			}else if(uri.lastIndexOf("insertR.do")>=0){
				// data들을 db에 저장하는 부분
				String msg = dao.insert(req);
				req.setAttribute("msg", msg);				
				dispatcher = req.getRequestDispatcher(url+"insert_result.jsp");
				dispatcher.forward(req, resp);
				
			}else if(uri.lastIndexOf("list.do")>=0 || uri.equals("/Servlet1705/")){
				String findStr =""; 
				int nowPage = 1;				
				if(req.getParameter("findStr")!=null){
					findStr = req.getParameter("findStr");
				}
				if(req.getParameter("nowPage")!=null){
					nowPage = Integer.parseInt(req.getParameter("nowPage"));
				}				
				List<BoardVo> list = dao.select(findStr, nowPage);
				req.setAttribute("list", list);
				req.setAttribute("dao", dao);
				
				dispatcher = req.getRequestDispatcher(url+"list.jsp");
				dispatcher.forward(req, resp);				
			}else if(uri.lastIndexOf("view.do")>=0){
				int serial = 0;
				if(req.getParameter("serial")!=null){
					serial = Integer.parseInt(req.getParameter("serial"));
				}			
				BoardVo vo = dao.selectOne(serial);
				req.setAttribute("vo", vo);
				
				dispatcher = req.getRequestDispatcher(url+"view.jsp");
				dispatcher.forward(req, resp);
				
			}else if(uri.lastIndexOf("modify.do")>=0){
				int serial = Integer.parseInt(req.getParameter("serial"));
				BoardVo vo = dao.selectOne(serial);
				req.setAttribute("vo", vo);
				
				dispatcher = req.getRequestDispatcher(url+"modify.jsp");
				dispatcher.forward(req, resp);
				
			}else if(uri.lastIndexOf("modifyR.do")>=0){
				Map<String, Object> modifyMap = dao.modify(req);
				req.setAttribute("modifyMap", modifyMap);
				
				dispatcher = req.getRequestDispatcher(url+"modify_result.jsp");
				dispatcher.forward(req, resp);
				
			}else if(uri.lastIndexOf("repl.do")>=0){
				dispatcher = req.getRequestDispatcher(url+"repl.jsp");
				dispatcher.forward(req, resp);
				
			}else if(uri.lastIndexOf("replR.do")>=0){
				Map<String, Object> rMap = dao.reply(req);
				req.setAttribute("rMap", rMap);
				dispatcher = req.getRequestDispatcher(url+"repl_result.jsp");
				dispatcher.forward(req, resp);				
			}else if(uri.lastIndexOf("deleteR.do")>=0){
				int serial = Integer.parseInt(req.getParameter("serial"));
				String pwd = req.getParameter("pwd");
				String rs = dao.delete(serial, pwd);
				req.setAttribute("delete_result", rs);
				dispatcher = req.getRequestDispatcher(url+"delete_result.jsp");
				dispatcher.forward(req, resp);
			}else if(uri.lastIndexOf("delete.do")>=0){
				int serial = Integer.parseInt(req.getParameter("serial"));
				String pwd = req.getParameter("voPwd");
				req.setAttribute("serial", serial);
				req.setAttribute("pwd", pwd);
				dispatcher = req.getRequestDispatcher(url+"delete_pwd.jsp");
				dispatcher.forward(req, resp);
			}
		}
}
