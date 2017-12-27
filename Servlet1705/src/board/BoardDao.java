package board;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import db.DBConn;

public class BoardDao {
	String sDirectory="C:/Users/JHTA/git/webDevelope/Servlet1705/WebContent/download/";
	int mSize=1024*100000; 
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	/*페이지 분리와 관련한 변수들*/
	int listSize=20;		// 한 페이지에 표시할 데이터의 갯수
	int blockSize=3;	// 한 블럭 당 표시할 페이지 변수의 갯수
	int totSize=0;		// 검색된 결과의 전체 갯수 - 기준 ㅇㅇ
	int totPage=0;	// 전체 페이지 수
	int totBlock=0;	// 전체 블럭 수
	int nowPage=1; 	// 현재 페이지  - user
	int nowBlock=1;	// 현재 블럭
	int startNo=1;		// 표시할 데이터의 시작 번호
	int endNo=0;		// 표시할 데이터의 끝 번호
	int startPage=1;	// 표시할 페이지의 시작 번호
	int endPage=0;	// 표시할 페이지의 끝 번호
	
	public BoardDao(){
		try {
			conn=new DBConn().getConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 데이터를 가져오는 것 serial을 받아서..ㅇㅇ.. hit는 +1
	public BoardVo selectData(HttpServletRequest request){
		BoardVo vo = new BoardVo();
		try {
			MultipartRequest mr=new MultipartRequest(request, sDirectory, mSize, "utf-8", new DefaultFileRenamePolicy());
			int serial = Integer.parseInt(mr.getParameter("serial"));
			String sql = " select * from board2 b left join board_att ba on b.serial = ba.pserial where b.serial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);			
			rs=ps.executeQuery();
			
			while(rs.next()){
				vo.setWorker(rs.getString("worker"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content").replaceAll("\n", "<br/>"));
				vo.setMdate(rs.getDate("mdate").toString());
				vo.setHit(rs.getInt("hit")+1);
				// reply 처리를 위해 객체에 담는 것.
				vo.setGrp(rs.getInt("grp"));
				vo.setDeep(rs.getString("deep"));
				vo.setSerial(rs.getInt("serial"));
			}			
			
			Map<String, String> map = new HashMap<String, String>();
			sql = " select * from board_att where pserial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);
			rs=ps.executeQuery();
			while(rs.next()){
				map.put(rs.getString("attfile"), rs.getString("oriattfile"));
			}
			if(map.size()==0) map = null;
			vo.setAttFile(map);
			conn.commit();
	        conn.close();	        
	        
	        conn = new DBConn().getConn();
			sql = " update board2 set hit = hit+1 where serial = ? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, serial);
			ps.executeUpdate();
			
			conn.commit();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			vo=null;
		}
		return vo;
	}
	
	public BoardVo selectOne(int serial){
		BoardVo vo = new BoardVo();
		try {
			String sql = " select b.*, ba.*, m.email email from board2 b left join board_att ba on b.serial = ba.pserial join member m on m.irum=b.worker where b.serial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);			
			rs=ps.executeQuery();
			
			while(rs.next()){
				vo.setWorker(rs.getString("worker"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content").replaceAll("\n", "<br/>"));
				vo.setMdate(rs.getDate("mdate").toString());
				vo.setHit(rs.getInt("hit")+1);
				// reply 처리를 위해 객체에 담는 것.
				vo.setGrp(rs.getInt("grp"));
				vo.setDeep(rs.getString("deep"));
				vo.setSerial(rs.getInt("serial"));
				vo.setEmail(rs.getString("email"));
				vo.setPwd(rs.getString("pwd"));
			}
			
			Map<String, String> map = new HashMap<String, String>();
			sql = " select * from board_att where pserial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);
			rs=ps.executeQuery();
			while(rs.next()){
				map.put(rs.getString("attfile"), rs.getString("oriattfile"));
			}
			if(map.size()==0) map = null;
			vo.setAttFile(map);
			conn.commit();
	        conn.close();	        
	        
	        conn = new DBConn().getConn();
			sql = " update board2 set hit = hit+1 where serial = ? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, serial);
			ps.executeUpdate();
			
			conn.commit();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			vo=null;
		}
		return vo;
	}
	
	public void pageCompute(String findStr) throws Exception{
		// findStr을 통해 전체 건 수를 구함
		String sql =" select count(*) totSize from board2 where worker like ? or subject like ? or content like ? ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + findStr + "%");
		ps.setString(2, "%" + findStr + "%");
		ps.setString(3, "%" + findStr + "%");
		rs = ps.executeQuery();
		if(rs.next()){
			totSize=rs.getInt("totSize");
		}
		totPage = (int) Math.ceil(totSize / (double)listSize);
		totBlock = (int) Math.ceil(totPage / (double)blockSize);
		
		nowBlock = (int) Math.ceil(nowPage / (double)blockSize);
		
		endPage = blockSize * nowBlock;
		startPage = endPage - blockSize + 1;

		if(endPage>totPage) endPage=totPage;

		endNo = nowPage * listSize;
		startNo = endNo - listSize + 1;
		
		if(endNo>totSize) endNo=totSize;
	}
	public ArrayList<BoardVo> select(){
		return select("",1)	;
	}
	public ArrayList<BoardVo> select(String findStr, int nowPage){
		this.nowPage=nowPage;
		ArrayList<BoardVo> list = new ArrayList<BoardVo>();
		try {
			pageCompute(findStr);
			String sql="select * from (select rownum rn, b.* from(select a.*, (select count(*) from board_att where a.serial=pserial) cnt from board2 a where subject like ? or content like ? or worker like ? order by grp desc, deep asc) b ) where rn between ? and ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+findStr+"%");
			ps.setString(2, "%"+findStr+"%");
			ps.setString(3, "%"+findStr+"%");
			ps.setInt(4, startNo);
			ps.setInt(5, endNo);
			rs = ps.executeQuery();
			while(rs.next()){
				int deepCnt=rs.getString("deep").split("-").length;
				String temp="";
				for(int i=1; i<deepCnt; i++) temp+="&nbsp;&nbsp;";
				if(deepCnt>1) temp += "└";				
				BoardVo vo = new BoardVo();
				vo.setSerial(rs.getInt("serial"));
				vo.setSubject(temp+rs.getString("subject"));
				vo.setWorker(rs.getString("worker"));
				vo.setMdate(rs.getDate("mdate").toString());
				vo.setHit(rs.getInt("hit"));
				vo.setCnt(rs.getInt("cnt"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			list = null;
		}
		return list;
	}
	public Map<String, Object> reply(HttpServletRequest request){
		Map<String, Object> replyMap = new HashMap<String, Object>();
		replyMap.put("rs", "");
		try {
			MultipartRequest mr=new MultipartRequest(request, sDirectory, mSize, "utf-8", new DefaultFileRenamePolicy());
			String worker = mr.getParameter("worker");
			String subject = mr.getParameter("subject");
			String content = mr.getParameter("content");
			String pwd = mr.getParameter("pwd");
			int grp = Integer.parseInt(mr.getParameter("grp"));
			String deep = mr.getParameter("deep");
			
			String findStr=mr.getParameter("findStr");
			int nowPage = Integer.parseInt(mr.getParameter("nowPage"));
			int serial = Integer.parseInt(mr.getParameter("serial"));
			
			// 원본 글의 grp를 넣어주고, deep은 deep-n - 20... 머 이런 식...
			String sql = "insert into board2(serial, mdate, worker, subject, content, pwd, hit, grp, deep) "
											+"values(seq_board.nextval, sysdate, ?, ?, ?, ?, 0, ?, ?||'-'||seq_board.currval)";			
			// rollback and commit
			conn.setAutoCommit(false);		// 자동커밋을 수동으로 돌리는 작업			
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, worker);
			ps.setString(2, subject);
			ps.setString(3, content);
			ps.setString(4, pwd);
			ps.setInt(5, grp);
			ps.setString(6, deep);
			
			int r = ps.executeUpdate();
			if(r>0) {
				// 정상적으로 저장된 경우에만 board_att로 넣어주는 거야 
				Enumeration enum_file = mr.getFileNames();
				while(enum_file.hasMoreElements()){
					String tag = (String)enum_file.nextElement();
					String ori = mr.getOriginalFileName(tag);
					String sys = mr.getFilesystemName(tag);
					
					if(ori==null) continue;
					
					sql = "insert into board_att(serial, pserial, attfile, oriattfile) values(seq_board_att.nextval, seq_board.currval, ?, ?)";
					ps=conn.prepareStatement(sql);
					ps.setString(1, sys);
					ps.setString(2, ori);
					
					r=ps.executeUpdate();
					if(r<1) replyMap.put("rs", "첨부파일 저장 중 DB오류. ");;
				}
			}
			if(r>0){
				conn.commit();
				replyMap.put("rs", "답변이 정상적으로 처리되었습니다. ");
			}else{ conn.rollback(); }
			
			replyMap.put("findStr", findStr);
			replyMap.put("nowPage", nowPage);
			replyMap.put("serial", serial);
			
			conn.close();
		} catch (Exception e) {
			replyMap.put("rs",  "db처리 도중 exception 발생");
			replyMap = null;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return replyMap;
	}
	
	public Map<String, Object> modify(HttpServletRequest request){
		String sql="";
		int r=0;
		Map<String, Object> modifyMap = new HashMap<String, Object>();
		modifyMap.put("rs", "");
		
		try {
			MultipartRequest mr=new MultipartRequest(request, sDirectory, mSize, "utf-8", new DefaultFileRenamePolicy());
//			String worker = mr.getParameter("worker");
			String subject = mr.getParameter("subject");
			String content = mr.getParameter("content");
			String pwd = mr.getParameter("pwd");
			
			int serial = Integer.parseInt(mr.getParameter("serial"));
			String findStr=mr.getParameter("findStr");
			int nowPage = Integer.parseInt(mr.getParameter("nowPage"));
//			String deleteAtt = mr.getParameter("deleteAtt");
			
			// rollback and commit
			conn.setAutoCommit(false);		// 자동커밋을 수동으로 돌리는 작업: error 발생 시 롤백하기 위해

			sql = "update board2 set mdate = sysdate, subject = ?, content = ? where serial = ? and pwd = ?";			
			ps=conn.prepareStatement(sql);
			ps.setString(1, subject);
			ps.setString(2, content);
			ps.setInt(3, serial);
			ps.setString(4, pwd);			
			r = ps.executeUpdate();
			
			if(r<=0){
				modifyMap.put("rs", "data modify 중 오류 발생");
			}else{
				// 삭제 정상 진행 부분
				String[] delAtt=mr.getParameterValues("deleteAtt");
				if(delAtt!=null){
					/*삭제할 파일 갯수만큼(length) for문 돈다*/
					for(int i=0;i<delAtt.length; i++){
						File f=new File(sDirectory+delAtt[i]);
						if(f.exists()) f.delete();
						sql="delete from board_att where attfile =?";
						ps=conn.prepareStatement(sql);
						ps.setString(1, delAtt[i]);
						ps.executeQuery();
					}
				}
			}
			
			Enumeration enum_file = mr.getFileNames();
			while(enum_file.hasMoreElements()){
				String tag = (String)enum_file.nextElement();
				String ori = mr.getOriginalFileName(tag);
				String sys = mr.getFilesystemName(tag);
				
				if(ori==null) continue;
				
				sql = "insert into board_att(serial, pserial, attfile, oriattfile) values(seq_board_att.nextval, ?, ?, ?)";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, serial);
				ps.setString(2, sys);
				ps.setString(3, ori);
				
				r=ps.executeUpdate();
				if(r<1) modifyMap.put("rs", "첨부파일 새로 저장 중 DB오류. ");;
			}

			if(r>0){ 
				conn.commit();
				modifyMap.put("rs", "수정작업이 정상적으로 처리되었습니다. ");
				modifyMap.put("serial", serial);
				modifyMap.put("findStr", findStr);
				modifyMap.put("nowPage", nowPage);			
			}
				else{ conn.rollback(); }
			
			conn.close();
		}catch (Exception e) {
			modifyMap.put("rs",  "db처리 도중 exception 발생");
			modifyMap = null;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return modifyMap;
	}
	
	public String delete(int serial, String pwd){
		String rStr="삭제...??";
		String sql="";
		try {
			// board 삭제
			sql = "delete from board2 where serial = ? and pwd = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);
			ps.setString(2, pwd);
			int r = ps.executeUpdate();
			if(r>0){
				rStr = "정상적으로 삭제되었습니다.";
			}else{
				rStr = "비밀번호가 맞지 않거나 or 본인의 작성글이 아닙니다. ";
			}
			
			// board_att로부터 첨부 파일 정보를 얻어온다
			// 첨부 파일 삭제
			sql = " select attfile from board_att where pserial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);
			rs = ps.executeQuery();
			while(rs.next()){
				String file = rs.getString("attfile");
				File f = new File(file);
				if(f.exists()) f.delete();
			}
			// board_att 삭제(pserial)
			sql = " delete from board_att where pserial = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, serial);
			ps.executeUpdate();
			
			conn.commit();
			conn.close();			
		} catch (Exception e) {
			e.printStackTrace();
			rStr = "삭제 중 예외 발생";
		}		
		return rStr;
	}
	
	
	public String insert(HttpServletRequest request){
		String file1, file2;
		String imgPath = "c:/poster/";
		String thumbPath ="c:/poster/thumb_poster";
		
		String str="파일이 정상적으로 업로드되었습니다. ";
		try {
			MultipartRequest mr=new MultipartRequest(request, sDirectory, mSize, "utf-8", new DefaultFileRenamePolicy());
			String worker = mr.getParameter("worker");
			String subject = mr.getParameter("subject");
			String content = mr.getParameter("content");
			String pwd = mr.getParameter("pwd");
			String sql = "insert into board2(serial, mdate, worker, subject, content, pwd, hit, grp, deep) values(seq_board.nextval, sysdate, ?, ?, ?, ?, 0, seq_board.currval, seq_board.currval)";
			
			// rollback and commit
			conn.setAutoCommit(false);		// 자동커밋을 수동으로 돌리는 작업
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, worker);
			ps.setString(2, subject);
			ps.setString(3, content);
			ps.setString(4, pwd);
			int r = ps.executeUpdate();
			if(r>0) {
				// 정상적으로 저장된 경우에만 board_att로 넣어주는 거야 
				Enumeration<String> files = mr.getFileNames();//
				file1 = mr.getFilesystemName(files.nextElement());
				file2 = mr.getFilesystemName(files.nextElement());
				
				Enumeration enum_file = mr.getFileNames();
				while(enum_file.hasMoreElements()){
					String tag = (String)enum_file.nextElement();
					String ori = mr.getOriginalFileName(tag);
					String sys = mr.getFilesystemName(tag);
					
					if(ori==null) continue;
					
					sql = "insert into board_att(serial, pserial, attfile, oriattfile) values(seq_board_att.nextval, seq_board.currval, ?, ?)";
					ps=conn.prepareStatement(sql);
					ps.setString(1, sys);
					ps.setString(2, ori);
					
					r=ps.executeUpdate();
					if(r<1) str="db 저장 중 오류 발생";
					
					System.gc();
				}
			}
			if(r>0){
				conn.commit();
			}else{ conn.rollback(); }
			conn.close();
		} catch (Exception e) {
			str = "db처리 도중 exception 발생";
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return str;
	}

	public int getListSize() {
		return listSize;
	}

	public void setListSize(int listSize) {
		this.listSize = listSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getTotSize() {
		return totSize;
	}

	public void setTotSize(int totSize) {
		this.totSize = totSize;
	}

	public int getTotPage() {
		return totPage;
	}

	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getNowBlock() {
		return nowBlock;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
