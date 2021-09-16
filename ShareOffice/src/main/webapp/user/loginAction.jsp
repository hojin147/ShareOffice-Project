<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.UserDAO" import="office.User_account" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="office.User_account" scope="page" 
id="reservationDAO" class="dao.ReservationDAO" scope="page" />
<jsp:setProperty name="user" property="uEmail" property="uPassword" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Log in</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
	
		//객체화
		UserDAO userDAO = new UserDAO();
		//result결과값 저장
		int result = userDAO.login(user.getuEmail(), user.getuPassword());
		
		//로그인 성공
		if(result == 1) {
			session.setAttribute("uEmail", user.getuEmail());
			User_account isAdmin = userDAO.selectOneuser(user.getuEmail());
			//관리자로 로그인 시 업데이트 작업 자동 수행
			if(isAdmin.getuType().equals("admin")) reservationDAO.refreshReservationTable();
			script.println("<script>");
			script.println("location.href = '../pagemain/mainpage.jsp'");
			script.println("</script>");
			
		//비밀번호 틀림
		} else if(result == 0) {
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		//아이디 없음
		} else if(result == -1) {
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
			
		//DB오류
		} else if(result == -2) {
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>