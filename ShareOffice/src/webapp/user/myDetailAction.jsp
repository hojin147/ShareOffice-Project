<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.text.SimpleDateFormat" import="office.Reservation"
import="office.User_account" import="java.sql.Date" %>
<jsp:useBean id="reservationDAO" class="dao.ReservationDAO" scope="page" />
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	int RvNum = Integer.parseInt((String)request.getParameter("rvNum"));
	
	String uname = (String)request.getParameter("uName");
	String uphone = (String)request.getParameter("uPhone");
	
	String RvEmail = (String)request.getParameter("uEmail");
	
	String RvBname = (String)request.getParameter("place");
	String RvOname = (String)request.getParameter("personnel");
	
	Date RvIndate = Date.valueOf((String)request.getParameter("startdate"));
	
	Date RvEnddate = Date.valueOf((String)request.getParameter("enddate"));
	
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
	
	System.out.println(user+"  "+reser);
	
	if(type==null) type="";
	switch(type){
	case "delete": reservationDAO.deleteReservation(RvNum); break;
	case "update": reservationDAO.updateReservation(user,reser); break;
	default: break;
	}
	
	response.sendRedirect("../user/myReservation.jsp");
%>



