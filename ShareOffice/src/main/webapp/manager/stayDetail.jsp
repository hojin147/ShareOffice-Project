<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="office.Reservation" import="office.User_account" import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reservationDAO" class="dao.ReservationDAO" scope="page"
id="userDAO" class="dao.UserDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>입주 확정</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
	<%
		String num = request.getParameter("num");
		Reservation reservation = reservationDAO.selectOne(Integer.parseInt(num));
		
		int rvNum = reservation.getRvNum();
		String rvBname = reservation.getRvBname(); 
		String rvOname = reservation.getRvOname();
		int rvPeriod = reservation.getRvPeriod();
		int rvPrice = reservation.getRvTotalprice();
		Date rvInDate = reservation.getRvIndate();
		Date rvEndDate = reservation.getRvEnddate();
		String rvStatus = reservation.getRvStatus();
		String rvEmail = reservation.getRvEmail();
		String rvType = reservation.getRvType();
		Timestamp rvRegdate = reservation.getRvRegdate();
		
		User_account user = userDAO.selectOneuser(rvEmail);
		String userName = user.getuName();
		String userPhone = user.getuPhone();
	%>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center"><div class="col-md-6 text-center mb-5"></div></div>
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="fa fa-user-o"></span>
						</div>
						<h3 class="text-center mb-4">입주 확정</h3>
							<div class="form-group">
								Email<br>
								<input type="text" class="form-control rounded-left"  name="uEmail" readonly required value="<%=rvEmail%>">
							</div>	
							<div class="form-group">
								이름<br>
								<input type="text" class="form-control rounded-left"  name="uName" readonly required value="<%=userName%>">
							</div>
							<div class="form-group">
								연락처<br>
								<input type="text" class="form-control rounded-left"   name="uPhone" readonly required value="<%=userPhone%>">
							</div>
							<div class="form-group">
								지점<br>
								<input type="text" class="form-control rounded-left"   name="place" readonly required value="<%=rvBname%>">
							</div>
							<div class="form-group">
								인원(실)<br>
								<input type="text" class="form-control rounded-left"   name="personnel" readonly required value="<%=rvOname%>">
							</div>
							<div class="form-group">
								신청일<br>
								<input type="text" class="form-control rounded-left"   name="date"  readonly required
								value="<fmt:formatDate value="<%=rvRegdate%>" pattern="yyyy.MM.dd HH:mm:ss" />">
							</div>
							<div class="form-group">
								입주 예정일<br>
								<input type="text" class="form-control rounded-left"   name="startdate" readonly required value="<%=rvInDate%>">
							</div>
							<div class="form-group">
								퇴거 예정일<br>
								<input type="text" class="form-control rounded-left"  name="enddate" readonly required value="<%=rvEndDate%>">
							</div>
							<div class="form-group">
								<input type="button" class="form-control btn btn-primary rounded button px-3" value="확인" onclick="location.href='../manager/stayManager.jsp'">
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>
</body>
</html>

