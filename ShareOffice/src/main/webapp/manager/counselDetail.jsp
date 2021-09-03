<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="office.Counsel" %>
<jsp:useBean id="counselDAO" class="dao.CounselDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>상담 신청 상세</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
	<link rel="stylesheet" type="text/css" href="../vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="../vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="../vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="../css/util.css">
	<link rel="stylesheet" type="text/css" href="../css/main.css">
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/styles.css">
	<link rel="stylesheet" href="../css/tablestyles.css">
	<script src="../vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="../vendor/bootstrap/js/popper.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="../vendor/select2/select2.min.js"></script>
	<script src="../js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>

<body>

	<%@ include file="../pagemain/mainpage_nav.jsp" %>
	
	<%
		String num = request.getParameter("num");
		Counsel counsel = counselDAO.selectOne(Integer.parseInt(num));
		
		String email = counsel.getsUseremail();
		String subject = counsel.getsSubject();
		String content = counsel.getsContent();
	%>

	<section>
		<div class="container">
			<div class="row">
				<form method="post" action="counselDetailAction.jsp">
					<input type="text" name="sNum" value="<%=num%>" required readonly hidden>
					<table class="table table-stariped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="1" style="backgraound-color: #eeeeee; text-align: center; width: 500px">상담 신청 상세</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td style="text-align: left;">답변 받을 email</td>
							</tr>
							<tr>
								<td><input type="text" class="form-control" placeholder="답변받을 email" name="sUseremail" maxlength="50" value="<%=email%>" required readonly></td>
							</tr>
							<tr>
								<td style="text-align: left;">글 제목</td>
							</tr>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="sSubject" maxlength="50" value="<%=subject%>"  required readonly></td>
							</tr>
							<tr>
								<td style="text-align: left;">내용</td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="sContent" rows="15" maxlength="2048"  required readonly><%=content%></textarea></td>
							</tr>
						</tbody>
					</table>
					<div style="float:right;">
						<input type="submit" class="btn btn-danger pull-right" value="삭제">
						<a style="float:right;">&nbsp;</a>
						<input type="button" class="btn btn-primary" value="돌아가기" onclick="location.href='../manager/counselManager.jsp'">
					</div>
				</form>
			</div>
		</div>
	</section>
	
	<%@ include file="../pagemain/mainpage_Footer.jsp" %>

	<script>
		$(".selection-2").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $('#dropDownSelect1')
		});
		
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'UA-23581568-13');
	</script>
	
</body>
</html>
