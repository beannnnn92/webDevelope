package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	//아래의 네개 변수는 원래 private형태로 만드는 것, connection: db연결에 제일 중요
	String driver;
	String url;
	String userId;
	String userPwd;
	Connection conn;		//db가 바뀌었다면 위의 
	
	public DBConn(){
		// 사용하려는 DB에따라 지정된 상수 - 웬만하면 바뀔 일이 없습니다. sql사이트에 driver명 정의되어있음.
		driver = "oracle.jdbc.driver.OracleDriver";
		url = "jdbc:oracle:thin:@192.168.0.6:1521:xe"; 		// 얘도 dbms마다 달라. 로컬호스트, 포트번호, 사용 오라클버전
		userId = "HR";
		userPwd = "HR";
		try {
			Class.forName(driver);
//			System.out.println("driver loading complete!"); // 나중에 지워랑~~!
			conn = DriverManager.getConnection(url, userId, userPwd);
//			System.out.println("connection success!");			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Connection getConn() {
		return conn;
	}
}
