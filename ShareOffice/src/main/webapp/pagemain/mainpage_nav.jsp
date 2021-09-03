<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="office.User_account"%>
<%@ page import="dao.UserDAO"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String uEmail = null;
	if(session.getAttribute("uEmail") != null) {
		uEmail = (String) session.getAttribute("uEmail");
	}
	UserDAO dao = new UserDAO();
	User_account user = dao.selectOneuser(uEmail);
	System.out.println(user.getuType());
%>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav" style=" padding-bottom: 5px; padding-top: 5px;">
	<div class="container" style="font-size:32px;">
		<a class="navbar-brand" href="../pagemain/mainpage.jsp">OU</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu
			<i class="fas fa-bars ms-1"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
				<li class="nav-item"><a class="nav-link" href="../pagemain/mainpage.jsp">회사 소개</a></li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
						서비스 소개
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li><a class="dropdown-item" href="../service/servicePage.jsp">부산진구점</a></li>
						<li><a class="dropdown-item" href="../service/servicePage2.jsp">연산점</a></li>
						<li><a class="dropdown-item" href="../service/servicePage3.jsp">해운대점</a></li>
					</ul>
		        </li>
				<li class="nav-item"><a class="nav-link" href="../reservation/officeReservation.jsp">예약</a></li>
				<li class="nav-item"><a class="nav-link" href="../user/counsel.jsp">상담신청</a></li>
				<%
					if(user.getuType() == null) {
				%>
				<li class="nav-item"><a class="nav-link" href="../user/signup.jsp">회원가입</a></li>
				<li class="nav-item"><a class="nav-link" href="../user/login.jsp">로그인</a></li>
				<%
					} else if(user.getuType().equals("admin")) {
				%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
						관리자페이지
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li><a class="dropdown-item" href="../manager/officeManager.jsp">지점 및 오피스관리</a></li>
						<li><a class="dropdown-item" href="../manager/reservationManager.jsp">예약 관리</a></li>
						<li><a class="dropdown-item" href="../manager/stayManager.jsp">입주 현황</a></li>
						<li><a class="dropdown-item" href="../manager/userManager.jsp">회원 관리</a></li>
						<li><a class="dropdown-item" href="../manager/counselManager.jsp">상담 관리</a></li>
						<li><a class="dropdown-item" href="../user/logoutAction.jsp">로그아웃</a></li>
					</ul>
		        </li>
				<%
					} else {
				%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
						마이페이지
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li><a class="dropdown-item" href="../user/myReservation.jsp">My 예약</a></li>
						<li><a class="dropdown-item" href="../user/userUpdate.jsp">회원 정보 수정</a></li>
						<li><a class="dropdown-item" href="../user/userDelete.jsp">회원 탈퇴</a></li>
						<li><a class="dropdown-item" href="../user/logoutAction.jsp">로그아웃</a></li>
					</ul>
		        </li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
</nav>	