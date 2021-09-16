<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.UserDAO" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="office.User_account" scope="page" />
<jsp:setProperty name="user" property="uEmail" />
<jsp:setProperty name="user" property="uPassword" />
<jsp:setProperty name="user" property="uName" />
<jsp:setProperty name="user" property="uPhone" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User Update</title>
</head>
<body>
	<%
		String uPasspword = request.getParameter("uPassword");
		String olduPassword = request.getParameter("olduPassword");
		String uPasspword2 = request.getParameter("uPassword2");
		PrintWriter script = response.getWriter();

		//DB에 저장되어 있는 비밀번호와 입력한 현재 비밀번호가 일치하지 않음
		if(!(user.getuPassword().equals(olduPassword))) {
			script.println("<script>");
			script.println("alert('현재 비밀번호를 확인해 주세요')");
			script.println("history.back()");
			script.println("</script>");
		
		//비밀번호는 4자~12자 사이
		} else if(user.getuPassword().length() < 4 || user.getuPassword().length() > 12) {
			script.println("<script>");
			script.println("alert('비밀번호는 4자에서 12자 사이로 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
			
		//입력을 했으나 비밀번호와 비밀번호 확인이 일치하지 않으면 넘어가지 않음
		} else if(!(user.getuPassword().equals(uPasspword2))) {
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다')");
			script.println("history.back()");
			script.println("</script>");
				
		//현재 비밀번호와 입력한 새 비밀번호 일치하면 현재 비밀번호와 다르게 입력해 주세요
		} else if(uPasspword.equals(olduPassword)) {
			script.println("<script>");
			script.println("alert('현재 비밀번호와 다르게 입력해 주세요')");
			script.println("history.back()");
			script.println("</script>");
		
		//수정 성공
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.updateUser(user);
			script.println("<script>");
			script.println("alert('정보수정이 완료되었습니다.')");
			script.println("location.href = '../pagemain/mainpage.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>