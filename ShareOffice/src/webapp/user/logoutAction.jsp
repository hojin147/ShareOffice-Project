<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Log out</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = '../pagemain/mainpage.jsp';
	</script>
</body>
</html>