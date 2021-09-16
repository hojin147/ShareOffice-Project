<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.CounselDAO" import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="coun" class="office.Counsel" scope="page" />
<jsp:setProperty name="coun" property="sNum" />
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Counsel Detail</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
			
		CounselDAO counselDAO = new CounselDAO();
		int result = counselDAO.deleteCounsel(coun.getsNum());
		
		if(result == 1) {
			script.println("<script>");
			script.println("alert('삭제성공')");
			script.println("location.href = '../manager/counselManager.jsp'");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('삭제 실패')");
			script.println("location.href = './counselManage.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>