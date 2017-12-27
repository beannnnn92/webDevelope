package board;

import java.util.Map;

public class BoardVo {
	int serial=0;
	String mdate="";
	String worker="";
	String subject="";
	String content="";
	int hit=0;
	int grp=0;
	String deep="";
	String pwd="";
	String email="";
	
	String findStr="";
	int cnt=0;		// 첨부파일의 갯수
	
	Map<String, String> attFile = null;
	// key는 폴더에 저장된 파일명이고 value는 사용자가 업로드한 실제 파일명
	
	public BoardVo(){}
	
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getWorker() {
		return worker;
	}
	public void setWorker(String worker) {
		this.worker = worker;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public String getDeep() {
		return deep;
	}
	public void setDeep(String deep) {
		this.deep = deep;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getFindStr() {
		return findStr;
	}

	public void setFindStr(String findStr) {
		this.findStr = findStr;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public Map<String, String> getAttFile() {
		return attFile;
	}

	public void setAttFile(Map<String, String> attFile) {
		this.attFile = attFile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
