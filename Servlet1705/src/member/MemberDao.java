package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import db.DBConn;

public class MemberDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	/*페이지 분리와 관련한 변수들*/
	int listSize=10;		// 한 페이지에 표시할 데이터의 갯수
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

	public MemberDao() {
		conn = new DBConn().getConn();
	}
	
	public MemberVo loginCheck(String mid, String pwd){
		MemberVo vo = new MemberVo();
		try {
			String sql = " select irum, email from member where memid = ? and pwd = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			if(rs.next()){
				vo.setIrum(rs.getString("irum"));
				vo.setEmail(rs.getString("email"));
			}else{
				vo = null;
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			vo = null;
		}		
		return vo;
	}
	
	public boolean idConfirm(String mid) {
		boolean b = true;
		String sql = "select * from member where memid = ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				b=false;
			}else{
				b=true;
			}
			conn.commit();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	
	
	
	
	
	
	
	
	
	
	
	public ArrayList<MemberVo> select(){
		return select("", 0);
	}
	
	public void pageCompute(String findStr) throws Exception{
		// findStr을 통해 전체 건 수를 구함
		String sql =" select count(*) totSize from member where memid like ? or irum like ? or phone like ? or addr1 like ? or addr2 like ? or email like ? ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + findStr + "%");
		ps.setString(2, "%" + findStr + "%");
		ps.setString(3, "%" + findStr + "%");
		ps.setString(4, "%" + findStr + "%");
		ps.setString(5, "%" + findStr + "%");
		ps.setString(6, "%" + findStr + "%");
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
	public ArrayList<MemberVo> select(String findStr, int nowPage) {
		this.nowPage=nowPage;
		ArrayList<MemberVo> data = new ArrayList<MemberVo>();
		try {// db쓸 땐 항상 예외처리 ㅇㅇ
			pageCompute(findStr);
			String sql = " select b.* from (select rownum cnt, a.* from (select * from member where memid like ? or irum like ? order by rdate desc) a) b where b.cnt between ? and ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+findStr+"%");
			ps.setString(2, "%"+findStr+"%");
			ps.setInt(3, startNo);
			ps.setInt(4, endNo);
			rs = ps.executeQuery();
			while(rs.next()) {
				MemberVo vo = new MemberVo();
				vo.setMid(rs.getString("memid"));
				vo.setIrum(rs.getString("irum"));
				vo.setPhone(rs.getString("phone"));
				vo.setGender(rs.getString("gender"));
				vo.setAddr1(rs.getString("addr1"));
				vo.setAddr2(rs.getString("addr2"));
				data.add(vo);
			}
		} catch (Exception e) {
			data = null;
		}
		return data;
	}
	
	//selectOne 만들장 
	public MemberVo selectOne(String findStr) {
		MemberVo vo = new MemberVo();
		try {// db쓸 땐 항상 예외처리 ㅇㅇ
			String sql = "select * from member where memid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, findStr);
			rs = ps.executeQuery();
			if(rs.next()) {
				vo.setMid(rs.getString("memid"));
				vo.setNickName(rs.getString("nickname"));
				vo.setIrum(rs.getString("irum"));
				vo.setGender(rs.getString("gender"));
				vo.setEmail(rs.getString("email"));
				vo.setAddr1(rs.getString("addr1"));
				vo.setAddr2(rs.getString("addr2"));
				vo.setPost(rs.getString("post"));
				vo.setPhone(rs.getString("phone"));
				vo.setPwd(rs.getString("pwd"));
			}
			conn.close();
		} catch (Exception e) {
			vo = null;
		}
		return vo;
	}
	
	// insert용 insert indo DAO 필요
	public String memberInsert(MemberVo vo){
		String str="X";
		try {
			String sql="insert into member(memid, pwd, nickname, irum, gender, email, post, addr1, addr2, phone, rdate, point) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, 5000) ";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getMid());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getNickName());
			ps.setString(4, vo.getIrum());
			ps.setString(5, vo.getGender());
			ps.setString(6, vo.getEmail());
			ps.setString(7, vo.getPost());
			ps.setString(8, vo.getAddr1());
			ps.setString(9, vo.getAddr2());
			ps.setString(10, vo.getPhone());
			int r= ps.executeUpdate();
			if(r<1) str="회원가입 db 오류 발생";
			str="회원가입 완료!";
			conn.commit();
			conn.close();			
		} catch (Exception e) {
			// TODO: handle exception
		}		
		return str;
	}
	
	// modify용 update DAO
	public String memberModify(HttpServletRequest req){
		String str="";
		try {
			
			String sql="update member set nickname=?, irum=?, gender=?, email=?, post=?,addr1=?, addr2=?,  phone=? where memid=? ";
			ps=conn.prepareStatement(sql);
			ps.setString(1, req.getParameter("nickname"));
			ps.setString(2, req.getParameter("irum"));
			ps.setString(3, req.getParameter("gender"));
			ps.setString(4, req.getParameter("email"));
			ps.setString(5, req.getParameter("post"));
			ps.setString(6, req.getParameter("addr1"));
			ps.setString(7, req.getParameter("addr2"));
			ps.setString(8, req.getParameter("phone"));
			ps.setString(9, req.getParameter("mid"));
			int r= ps.executeUpdate();
			if(r<1) str="회원 정보 수정 db처리 중 오류 발생";
			str="회원 정보 수정 완료!";
			conn.commit();
			conn.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	public String delete(HttpServletRequest req){
		String rs="";
		try {
			String sql=" delete from member where memid=? and pwd=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, req.getParameter("mid"));
			ps.setString(2, req.getParameter("pwd"));
			int r=ps.executeUpdate();
			if(r<1) rs="삭제 db처리가 안 됨.";
			else{
				rs="정상적으로 삭제 처리가 완료되었습니다.";
				conn.commit();
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
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
