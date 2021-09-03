package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import office.*;

public class CounselDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// 데이터 베이스 접속
	public CounselDAO() {
		this.conn = DBConnection.getConnection();
		System.out.println("커넥션 불러옴");
	}

	//닫는 메소드
	public void close() {
		DBConnection.close();
		System.out.println("sql문 끝");
	}
	
	//DB연결끊기
	public void closeconn() {
		DBConnection.closeConn();
		System.out.println("DB연결 끊기 불러옴");
	}

	//상담글 목록 불러오기
	public ArrayList<Counsel> selectCounselAll() {
		ArrayList<Counsel> counselArr = new ArrayList<Counsel>();
		//최신글이 맨 위로 오도록
		String sql = "SELECT * FROM COUNSEL ORDER BY NUM DESC";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Counsel counsel = new Counsel();
				counsel.setsNum(rs.getInt("NUM"));
				counsel.setsUseremail(rs.getString("E_MAIL"));
				counsel.setsSubject(rs.getString("SUBJECT"));
				counsel.setsContent(rs.getString("CONTENT"));
				counsel.setsRegdate(rs.getTimestamp("REGDATE"));
				counselArr.add(counsel);
			}
		} catch (Exception e) {
			System.out.println("상담글 목록 불러오기 오류");
		} finally {
			close();
		}		
		return counselArr;
	}
	
	//상담글 입력 양식 저장
	public int input(Counsel counsel) {
		String sql = "INSERT INTO COUNSEL VALUES(COUNSEL_SEQ.nextval, ?, ?, ?, SYSDATE)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, counsel.getsUseremail());
			pstmt.setString(2, counsel.getsSubject());
			pstmt.setString(3, counsel.getsContent());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("상담신청 입력 오류");
		} finally {
			close();			
		}
		//DB오류
		return -1;
	}
	
	//상담목록 총 레코드 수
	public int countRecord() {
		int count=0;
		String sql = "SELECT COUNT(*) AS COUNT FROM COUNSEL";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("COUNT");
			}

		} catch (Exception e) {
			System.out.println("총 레코드수 불러오기 오류");
		} finally {
			close();		
		}
		return count;
	}
	
	//상담글 선택
	public Counsel selectOne(int num) {
		System.out.println("start counselDAO/selectOne");

		String sql = "SELECT * FROM COUNSEL WHERE NUM = ?";
		Counsel counsel = new Counsel();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				counsel.setsNum(rs.getInt("NUM"));
				counsel.setsUseremail(rs.getString("E_MAIL"));
				counsel.setsSubject(rs.getString("SUBJECT"));
				counsel.setsContent(rs.getString("CONTENT"));
				counsel.setsRegdate(rs.getTimestamp("REGDATE"));
			}
			System.out.print(counsel);
		} catch (Exception e) {
			System.out.println("상담 상세 불러오기 오류");
		} finally {
			close();
		}
		return counsel;
	}
	
	//상담글 삭제
	public int deleteCounsel(int num) {
		String sql = "DELETE FROM COUNSEL WHERE NUM = ?";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			System.out.println("상담신청서 삭제 오류");
		} finally {
			close();
		}
		return result;
	}
}
