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
	<title>Sign up</title>
</head>
<body>
	<%
		String uPasspword2 = request.getParameter("uPassword2");
		PrintWriter script = response.getWriter();
			
		//비밀번호는 4자~12자 사이
		if(user.getuPassword().length() < 4 || user.getuPassword().length() > 12) {
			script.println("<script>");
			script.println("alert('비밀번호는 4자에서 12자 사이로 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		
		//입력을 했으나 비밀번호와 비밀번호 확인이 일치하지 않으면 넘어가지 않음
		} else if(!(user.getuPassword().equals(uPasspword2))) {
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
				
		//값을 쿼리문 메소드로 넘겨서 확인한 후 값 resutl로 받아서 확인한다.
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			//아이디가 있는 경우
			if(result == -1) {
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
				
			//회원가입 성공
			} else {
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href = '../pagemain/mainpage.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>