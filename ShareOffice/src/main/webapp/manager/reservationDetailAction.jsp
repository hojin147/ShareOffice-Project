<%@ page import="java.io.PrintWriter" language="java" 
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.text.SimpleDateFormat" import="office.Reservation"
import="office.User_account" page import="java.sql.Date"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reservationDAO" class="dao.ReservationDAO" scope="page"
id="userDAO" class="dao.UserDAO" scope="page" />
<%
	String type = request.getParameter("type");
	int RvNum = Integer.parseInt((String) request.getParameter("rvNum"));
	
	String uname = (String) request.getParameter("uName");
	String uphone = (String) request.getParameter("uPhone");
	
	String RvEmail = (String) request.getParameter("uEmail");
	
	String RvBname = (String) request.getParameter("place");
	String RvOname = (String) request.getParameter("personnel");
	
	Date RvIndate = Date.valueOf((String) request.getParameter("startdate"));
	
	Date RvEnddate = Date.valueOf((String) request.getParameter("enddate"));
	
	User_account user = new User_account();
	user.setuName(uname);
	user.setuPhone(uphone);
	
	Reservation reser = new Reservation();
	reser.setRvEmail(RvEmail);
	reser.setRvNum(RvNum);
	reser.setRvBname(RvBname);
	reser.setRvOname(RvOname);
	reser.setRvIndate(RvIndate);
	reser.setRvEnddate(RvEnddate);
	
	System.out.println(user + "  " + reser);
	
	if (type == null)
		type = "";
	PrintWriter writer = response.getWriter();
	
	try{
		reservationDAO.setAutoCommitFalse();
		int indatePossible = 0;
		int enddatePossible = 0;
		switch (type) {
		case "delete":
			reservationDAO.deleteReservation(RvNum);
			break;
		case "update":
			reservationDAO.updateReservation(user, reser);
			break;
		case "confirm":
			Exception exception = new Exception();
			System.out.println(RvIndate+"  "+RvEnddate);
			indatePossible = reservationDAO.checkReservationIndate(RvBname,RvOname,RvIndate);
			if(indatePossible>0) {
				type = " 해당 입주일은 다른 예약을 침범합니다. \\n" + type;
				throw exception;
			}
			enddatePossible = reservationDAO.checkReservationEnddate(RvBname,RvOname,RvEnddate);
			if(enddatePossible>0) {
				type = " 해당 퇴실일은 다른 예약을 침범합니다. \\n" + type;
				throw exception;
			}
			reservationDAO.confirmReservation(RvNum);
			break;
		default:
			break;
		}
		reservationDAO.commit();
		writer.println("<script>");
		writer.println("alert('"+ type +"에 성공했습니다.')");
		writer.println("location.href='./reservationManager.jsp'");
		writer.println("</script>");
	} catch(Exception e){
		reservationDAO.rollback();
		e.printStackTrace();
		writer.println("<script>");
		writer.println("alert('"+ type +"에 실패했습니다.')");
		writer.println("history.back()");
		writer.println("</script>");
	} finally{
		
		reservationDAO.setAutoCommitTrue();
	}
%>