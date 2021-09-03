package dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;
import java.util.ArrayList;
import office.*;

public class ReservationDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private static ResultSet rs;
	
	public ReservationDAO() {
		this.conn = DBConnection.getConnection();
		System.out.println("커넥션 불러옴");
	}
	
	public void close() {
		DBConnection.close();
		System.out.println("sql문 끝");
	}
	
	public void closeconn() {
		DBConnection.closeConn();
		System.out.println("DB연결 끊기 불러옴");
	}
	
	//입주대기에서 입주중으로, 입주중에서 계약만료로
	public void refreshReservationTable() {
		System.out.println("리프래쉬 예약 테이블");
		String sql = "UPDATE RESERVATION SET STATUS=? WHERE SYSDATE>=IN_DATE AND STATUS='입주대기'";
		String sql2 = "UPDATE RESERVATION SET STATUS=? WHERE SYSDATE>END_DATE AND STATUS='입주중'";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "입주중");
			pstmt.executeUpdate();
			
			close();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, "계약만료");
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("예약 테이블 리프래쉬 오류");
			e.printStackTrace();
		} finally {
			close();			
		}
		return;
	}
	
	//예약 데이터 인서트
	public int inputReser (Reservation reservation) {
		String sql = "INSERT INTO RESERVATION VALUES(COUNSEL_SEQ.nextval, ?, ?, ?, ?, ?, ?, 예약, ?, ?, SYSDATE)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reservation.getRvBname());
			pstmt.setString(2, reservation.getRvOname());
			pstmt.setInt(3, reservation.getRvPeriod());
			pstmt.setInt(4, reservation.getRvTotalprice());
			pstmt.setDate(5, reservation.getRvIndate());
			pstmt.setDate(6, reservation.getRvEnddate());
			pstmt.setString(7, reservation.getRvEmail());
			pstmt.setString(8, reservation.getRvType());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("예약신청 오류");
			e.printStackTrace();
		} finally {
			close();			
		}
		//DB오류
		return -1;
	}
	
	//예약정보 불러오기
	public ArrayList<Reservation> selectReservationAll() {
		ArrayList<Reservation> reservationArr = new ArrayList<Reservation>();
		String sql = "SELECT * FROM RESERVATION";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reservation reservation = new Reservation();
				
				reservation.setRvNum(rs.getInt("NUM"));
				reservation.setRvBname(rs.getString("BUILDING_NAME")); 
				reservation.setRvOname(rs.getString("OFFICE_NAME"));
				reservation.setRvPeriod(rs.getInt("PERIOD"));
				reservation.setRvTotalprice(rs.getInt("TOTAL_PRICE"));
				reservation.setRvIndate(rs.getDate("IN_DATE"));
				reservation.setRvEnddate(rs.getDate("END_DATE"));
				reservation.setRvStatus(rs.getString("STATUS"));
				reservation.setRvEmail(rs.getString("E_MAIL"));
				reservation.setRvType(rs.getString("TYPE"));
				reservation.setRvRegdate(rs.getTimestamp("REGDATE"));

				reservationArr.add(reservation);
			}

		} catch (Exception e) {
			System.out.println("예약정보 불러오기 오류");
		} finally {
			close();
		}		
		return reservationArr;
	}
	
	//입주중인 정보 불러오기
	public ArrayList<Reservation> selectOccupiedOffice() {
		ArrayList<Reservation> reservationArr = new ArrayList<Reservation>();
		String sql = "SELECT * FROM RESERVATION WHERE STATUS=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "입주중");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reservation reservation = new Reservation();
				
				reservation.setRvNum(rs.getInt("NUM"));
				reservation.setRvBname(rs.getString("BUILDING_NAME")); 
				reservation.setRvOname(rs.getString("OFFICE_NAME"));
				reservation.setRvPeriod(rs.getInt("PERIOD"));
				reservation.setRvTotalprice(rs.getInt("TOTAL_PRICE"));
				reservation.setRvIndate(rs.getDate("IN_DATE"));
				reservation.setRvEnddate(rs.getDate("END_DATE"));
				reservation.setRvStatus(rs.getString("STATUS"));
				reservation.setRvEmail(rs.getString("E_MAIL"));
				reservation.setRvType(rs.getString("TYPE"));
				reservation.setRvRegdate(rs.getTimestamp("REGDATE"));

				reservationArr.add(reservation);
			}

		} catch (Exception e) {
			System.out.println("입주정보 불러오기 오류");
		} finally {
			close();
		}		
		return reservationArr;
	}
		
	//목록에서 하나 선택
	public Reservation selectOne(int num) {
		System.out.println("start reservationDAO/selectOne");

		String sql = "SELECT * FROM RESERVATION WHERE NUM = ?";
		Reservation reservation = new Reservation();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				reservation.setRvNum(rs.getInt("NUM"));
				reservation.setRvBname(rs.getString("BUILDING_NAME")); 
				reservation.setRvOname(rs.getString("OFFICE_NAME"));
				reservation.setRvPeriod(rs.getInt("PERIOD"));
				reservation.setRvTotalprice(rs.getInt("TOTAL_PRICE"));
				reservation.setRvIndate(rs.getDate("IN_DATE"));
				reservation.setRvEnddate(rs.getDate("END_DATE"));
				reservation.setRvStatus(rs.getString("STATUS"));
				reservation.setRvEmail(rs.getString("E_MAIL"));
				reservation.setRvType(rs.getString("TYPE"));
				reservation.setRvRegdate(rs.getTimestamp("REGDATE"));
			}
			System.out.print(reservation);
		} catch (Exception e) {
			System.out.println("한개의 예약 정보 불러오기 오류");
		} finally {
			close();
		}
		return reservation;
	}
	
	//예약삭제
	//메소드 타입을 int로 해서 1이면 삭제 완료 -1이면 삭제오류(DB오류)
	public void deleteReservation(int num) throws Exception{
		System.out.println("start reservationDAO/deleteReservation");

		String sql = "DELETE FROM RESERVATION WHERE NUM = ?";
		Reservation reservation = new Reservation();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("예약 삭제 오류");
			throw e;
		} finally {
			close();
		}
		return;
	}
	
	//예약정보 수정
	public Reservation updateReservation(User_account user,Reservation reser) throws Exception{
		System.out.println("start reservationDAO/updateReservation"+"????????");

		String sql = "UPDATE RESERVATION SET BUILDING_NAME=?, OFFICE_NAME=?, IN_DATE=?, END_DATE=? WHERE NUM=?";
		Reservation reservation = new Reservation();
		try {			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reser.getRvBname());
			pstmt.setString(2, reser.getRvOname());
			pstmt.setDate(3, reser.getRvIndate());
			pstmt.setDate(4, reser.getRvEnddate());
			pstmt.setInt(5, reser.getRvNum());
			pstmt.executeUpdate();
		
			System.out.print(reservation);
		} catch (Exception e) {	
			e.printStackTrace();
			throw e;
		} finally {
			close();
		}
		return reservation;
	}
	
	//예약 확정 버튼 누른 후 실행되는 메소드
	public int checkReservationIndate(String building, String office, Date indate) throws Exception{
		System.out.println("start reservationDAO/checkReservationIndate");
		String sql = "SELECT COUNT(*) FROM RESERVATION "
				+ "WHERE IN_DATE<=? AND ?<=END_DATE AND (STATUS='입주대기' OR STATUS='입주중') AND BUILDING_NAME=? AND OFFICE_NAME=?";
		int result=0;
		System.out.println(indate+"인데이트");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1,indate);
			pstmt.setDate(2,indate);
			pstmt.setString(3, building);
			pstmt.setString(4, office);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt("COUNT(*)");
			}
		} catch (Exception e) {
			System.out.println("indate체크 메소드 오류");
			throw e;
		} finally {
			close();
		}
		System.out.println(result+"여기임");
		return result;
	}
	public int checkReservationEnddate(String building, String office, Date enddate) throws Exception{
		System.out.println("start reservationDAO/checkReservationEnddate");
		String sql = "SELECT COUNT(*) FROM RESERVATION "
				+ "WHERE IN_DATE<=? AND ?<=END_DATE AND (STATUS='입주대기' OR STATUS='입주중') AND BUILDING_NAME=? AND OFFICE_NAME=?";
		int result=0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1,enddate);
			pstmt.setDate(2,enddate);
			pstmt.setString(3, building);
			pstmt.setString(4, office);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt("COUNT(*)");
			}

		} catch (Exception e) {
			System.out.println("enddate체크 메소드 오류");
			throw e;
		} finally {
			close();
		}
		return result;
	}
	public void confirmReservation(int num) throws Exception{
		System.out.println("start reservationDAO/confirmReservation");
		String sql = "UPDATE RESERVATION SET STATUS=? WHERE NUM = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "입주대기");
			pstmt.setInt(2, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("입주대기 실행 메소드 오류");
			throw e;
		} finally {
			close();
		}
		return;
	}
	
	//상태가 예약중, 입주대기인 예약 불러오기
	public ArrayList<Reservation> selectReservationlOnWait() {
		ArrayList<Reservation> reservationlArr = new ArrayList<Reservation>();
		String sql = "SELECT * FROM RESERVATION WHERE STATUS='예약중' OR STATUS='입주대기'";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reservation reservation = new Reservation();
				
				reservation.setRvNum(rs.getInt("NUM"));
				reservation.setRvBname(rs.getString("BUILDING_NAME")); 
				reservation.setRvOname(rs.getString("OFFICE_NAME"));
				reservation.setRvPeriod(rs.getInt("PERIOD"));
				reservation.setRvTotalprice(rs.getInt("TOTAL_PRICE"));
				reservation.setRvIndate(rs.getDate("IN_DATE"));
				reservation.setRvEnddate(rs.getDate("END_DATE"));
				reservation.setRvStatus(rs.getString("STATUS"));
				reservation.setRvEmail(rs.getString("E_MAIL"));
				reservation.setRvType(rs.getString("TYPE"));
				reservation.setRvRegdate(rs.getTimestamp("REGDATE"));
				reservationlArr.add(reservation);
			}
		} catch (Exception e) {
			System.out.println("상태가 예약중인 예약정보 불러오기 오류");
		} finally {
			close();
		}		
		return reservationlArr;
	}
	
	//로그인 한 현재 세션의 예약중, 입주대기, 입주중만 불러오기
	public ArrayList<Reservation> selectUserReservationlOnWait(String user) {
		ArrayList<Reservation> reservationlArr = new ArrayList<Reservation>();
		String sql = "SELECT * FROM (SELECT * FROM RESERVATION WHERE STATUS='예약중' OR STATUS='입주대기' OR STATUS='입주중')"
				+ "WHERE E_MAIL=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reservation reservation = new Reservation();
				
				reservation.setRvNum(rs.getInt("NUM"));
				reservation.setRvBname(rs.getString("BUILDING_NAME")); 
				reservation.setRvOname(rs.getString("OFFICE_NAME"));
				reservation.setRvPeriod(rs.getInt("PERIOD"));
				reservation.setRvTotalprice(rs.getInt("TOTAL_PRICE"));
				reservation.setRvIndate(rs.getDate("IN_DATE"));
				reservation.setRvEnddate(rs.getDate("END_DATE"));
				reservation.setRvStatus(rs.getString("STATUS"));
				reservation.setRvEmail(rs.getString("E_MAIL"));
				reservation.setRvType(rs.getString("TYPE"));
				reservation.setRvRegdate(rs.getTimestamp("REGDATE"));
				reservationlArr.add(reservation);
			}
		} catch (Exception e) {
			System.out.println("현재세션에 해당하는 예약 불러오기 오류");
		} finally {
			close();
		}		
		return reservationlArr;
	}
	
	//오토 커밋 끄기
	public void setAutoCommitFalse() throws Exception{
		try {
			this.conn.setAutoCommit(false);
			System.out.println("ReservationDAO/start setAutoCommitFalse");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//오토 커밋 켜기
	public void setAutoCommitTrue() throws Exception{
		try {
			this.conn.setAutoCommit(true);
			System.out.println("ReservationDAO/start setAutoCommitTrue");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//커밋하기
	public void commit() throws Exception{
		try {
			this.conn.commit();
			System.out.println("ReservationDAO/start commit");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//롤백
	public void rollback() throws Exception{
		try {
			this.conn.rollback();
			System.out.println("ReservationDAO/start rollback");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//예약 신청 인서트
	public void insertReservation(Reservation reservation) throws Exception {
		System.out.println("ReservationDAO/start insertReservation");
		String sql = "INSERT INTO RESERVATION VALUES (RESERVATION_SEQ.nextval,?,?,?,?,?,?,?,?,?,SYSDATE)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			System.out.println(reservation);
			pstmt.setString(1,reservation.getRvBname());
			pstmt.setString(2,reservation.getRvOname());
			pstmt.setInt(3,reservation.getRvPeriod());
			pstmt.setInt(4,reservation.getRvTotalprice());
			pstmt.setDate(5, reservation.getRvIndate());
			pstmt.setDate(6, reservation.getRvEnddate());
			pstmt.setString(7,reservation.getRvStatus());
			pstmt.setString(8,reservation.getRvEmail());
			pstmt.setString(9,reservation.getRvType());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("인설트 오류");
			throw e;
		} finally {
			close();
		}	
	}
}
