package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {
	private static Connection conn;
	private static PreparedStatement pstmt;
	private static ResultSet rs;
	private static String url ,user, passwd;

	//데이터 베이스 접속
	public static Connection getConnection(){
		url = "jdbc:oracle:thin:@localhost:1521:xe";
		user = "office";
		passwd = "dteam";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			if(conn==null) conn = DriverManager.getConnection(url, user, passwd);
			return conn;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	//닫는 메소드
	public static void close() {
		try {
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
		} catch(Exception e) {
			System.out.println("닫기 오류");
		}
	}
	
	//닫는 메소드
	public static void closeConn() {
		try {
			if(conn != null)
				conn.close();
		} catch(Exception e) {
			System.out.println("DB 연결끊기 오류");
		}
	}
}
