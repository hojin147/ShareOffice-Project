<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="office.Office" import="office.Building" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="officeDAO" class="dao.OfficeDAO" scope="page" />
<jsp:useBean id="buildingDAO" class="dao.BuildingDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>오피스 정보</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style.css">
</head>

<body>

	<%
		String num = request.getParameter("num");
		Office office = officeDAO.selectOneoffice(Integer.parseInt(num));
		
		int num1 = office.getoNum();
		String building  = office.getoBuildingName();
		String oname = office.getoName();
		int floor = office.getoFloor();
		int people = office.getoPeople();
		int rent = office.getoMonthlyRent();
		
		Building building2 = buildingDAO.selectOneobuilding(building);
		String addess = building2.getbAddress();
	%>
	
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">오피스 정보</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="fa fa-user-o"></span>
						</div>
						<h3 class="text-center mb-4">오피스 정보</h3>
						<form class="login-form" method="post">
							<div style="text-align:left;" class="form-group">
								오피스 번호<br>
								<input type="text" class="form-control rounded-left" value=<%=num1%> name="oNum" readonly>
							</div>
							<div style="text-align:left;" class="form-group">
								지점<br>
								<input type="text" class="form-control rounded-left" value=<%=building%> name="oBuildingName" readonly>
							</div>
							<div class="form-group">
								인실<br>
								<input type="text" class="form-control rounded-left" value=<%=oname%> name="oName" required>
							</div>
							<div class="form-group">
								인원<br>
								<input type="number" min="0" class="form-control rounded-left" value=<%=people%> name="oPeople" required numberOnly>
							</div>
							<div class="form-group">
								층<br>
								<input type="number" min="0" class="form-control rounded-left" value=<%=floor%> name="oFloor" required>
							</div>
							<div class="form-group">
								가격<br>
								<input type="number"  min="0" class="form-control rounded-left" value=<%=rent%> name="oMonthlyRent" required>
							</div>
							  <div style="float: left; width: 47%" class="form-group">
								<input type="submit" class="form-control btn btn-primary rounded submit px-3" value="수정"
										onclick="javascript: form.action='officeDetailUpdate.jsp';">
							</div>
							<div style="float: right; width: 47%" class="form-group">
								<input type="submit" class="form-control btn btn-primary rounded button px-3" value="삭제"
										onclick="javascript: form.action='officeDetailDelete.jsp';">
							</div>
							<div class="form-group">
								<input type="button" class="form-control btn btn-primary rounded button px-3" value="돌아가기"
										onclick="location.href='officeManager.jsp'">
							</div> 
						</form>
						<%
							officeDAO.close();
							buildingDAO.close();
						%>	
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>