<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.sql.*" import="office.*" import="java.util.ArrayList" import="java.io.PrintWriter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" 
id="companyDAO" class="dao.CompanyDAO" scope="page" 
id="officeDAO" class="dao.OfficeDAO" scope="page"
id="buildingDAO" class="dao.BuildingDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>오피스 예약</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
	<link rel="stylesheet" type="text/css"
		href="../vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css"
		href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="../css/util.css">
	<link rel="stylesheet" type="text/css" href="../css/main.css">
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/styles.css">
	<link rel="stylesheet" href="../css/tablestyles.css">
</head>
<body>

	<%@ include file="../pagemain/mainpage_nav.jsp"%>

	<div class="bg-contact3"
		style="background-image: url('../assets/img/main_slider_img_01.jpg');"
		id="dropDownSelect1">
		<div class="container-contact3">
			<section>
				<div class="wrap-contact3">
					<%
						//세션 값 불러오기
						String cEmail = (String) session.getAttribute("uEmail");
						PrintWriter script = response.getWriter();
						//로그인이 되었는지 안되었는지 판단
						if (cEmail == null) {
							script.println("<script>");
							script.println("alert('로그인 후 이용해주세요')");
							script.println("location.href='../pagemain/mainpage.jsp'");
							script.println("</script>");
						}
					%>
					<form id="from-1" class="contact3-form validate-form" method="post"
						action="./reservationAction.jsp">
						<span class="contact3-form-title"> 오피스 예약 </span>

						<div class="wrap-contact3-form-radio">
							<div class="contact3-form-radio m-r-42">
								<input class="input-radio3" id="radio1" type="radio"
									name="rvType" value="개인" checked onClick="companyOff()"> <label
									class="label-radio3" for="radio1"> 개인 </label>
							</div>
							<div class="contact3-form-radio">
								<input class="input-radio3" id="radio2" type="radio"
									name="rvType" value="기업" onClick="companyOn()"> <label class="label-radio3"
									for="radio2" > 기업 </label>
							</div>
						</div>
						<%
							ArrayList<Building> buildingArr = buildingDAO.selectBuildingAll();
						%>
						<div>
							<select id="building" class="selection-2" name="rvBname" required
								onchange="officeCategory();officeList();">
								<optgroup label="지점 선택">
									<c:forEach var="building" items="<%=buildingArr%>"
										varStatus="status">
										<option value="${building.getbName()}">${building.getbName()}</option>
									</c:forEach>
								</optgroup>
							</select>
							<hr style="color: white;">
						</div>
						<div class="wrap-input3 validate-input">
						<div class="d-flex">
							<div class="col-sm" style="padding-left:0px;">
								<select id="personSelect" class="selection-2" required onchange="officeList()">
								</select>
							</div>
							
							<div class="col-sm" style="padding-right:0px;">
								<select id="officeSelect" class="selection-2" name="rvOname" required>
								</select>
							</div>
							<hr style="color: white;">
						</div>
						</div>
						<div>
							<select class="selection-2" name="rvPeriod" required>
								<optgroup label="기간 선택(1개월 단위)">
									<option value="1">1개월</option>
									<option value="2">2개월</option>
									<option value="3">3개월</option>
									<option value="4">4개월</option>
									<option value="5">5개월</option>
									<option value="6">6개월(5% 할인)</option>
									<option value="7">7개월(5% 할인)</option>
									<option value="8">8개월(5% 할인)</option>
									<option value="9">9개월(5% 할인)</option>
									<option value="10">10개월(5% 할인)</option>
									<option value="11">11개월(5% 할인)</option>
									<option value="12">12개월(10% 할인)</option>
								</optgroup>
							</select>
							<hr style="color: white;">
						</div>
						<div class="wrap-input3 validate-input">
							<span class="form-label" style="font-size: 15px; color: white;">입주
								날짜<br></br>
							</span> <input class="form-control" type=month name="rvIndate" required>
						</div>
						<hr style="color: white;">

						<%
							User_account user1 = userDAO.selectOneuser(cEmail);
						%>
						
						<!-- 관리자로 로그인 시 관리자임을 알림 -->
						<div class="wrap-input3 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<p style="font-size: 15px; color: white;">&nbsp;EMAIL</p>
							<input class="input3" type="text" name="uEmail"
								value="<%= user1.getuType().equals("user") ? user1.getuEmail() : "관리자 모드입니다." %>"
								required readonly>
								<span class="focus-input3"></span>
						</div>
						<div class="wrap-input3 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<p style="font-size: 15px; color: white;">&nbsp;이름</p>
							<input class="input3" type="text" name="uName"
								value="<%=user1.getuType().equals("user") ? user1.getuName() : "관리자 모드입니다."%>"
								required readonly>
								<span class="focus-input3"></span>
						</div>
						<div class="wrap-input3 validate-input"
							data-validate="phone is required">
							<p style="font-size: 15px; color: white;">&nbsp;연락처</p>
							<input class="input3" type="text" name="uPhone"
								value="<%=user1.getuType().equals("user") ? user1.getuPhone() : "관리자 모드입니다."%>"
								required readonly>
								<span class="focus-input3"></span>
						</div>
						<%
							userDAO.close();
							Companyinfo_history company = companyDAO.selectLatestCompany(cEmail);
						%>
						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;기업명</p>
							<input class="input3" type="text" name="cName"
								value="<%=company.getcName()==null?"":company.getcName()%>">
								<span class="focus-input3"></span>
						</div>
						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;사업자등록번호</p>
							<input class="input3" type="text" name="cBuznum"
								value="<%=company.getcBuznum()==null?"":company.getcBuznum()%>">
								<span class="focus-input3"></span>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="office.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" />
<jsp:useBean id="companyDAO" class="dao.CompanyDAO" scope="page" />
<jsp:useBean id="officeDAO" class="dao.OfficeDAO" scope="page" />
<jsp:useBean id="buildingDAO" class="dao.BuildingDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>오피스 예약</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
	<link rel="stylesheet" type="text/css"
		href="../vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css"
		href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css"
		href="../vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="../css/util.css">
	<link rel="stylesheet" type="text/css" href="../css/main.css">
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/styles.css">
	<link rel="stylesheet" href="../css/tablestyles.css">
</head>
<body>

	<%@ include file="../pagemain/mainpage_nav.jsp"%>

	<div class="bg-contact3"
		style="background-image: url('../assets/img/main_slider_img_01.jpg');"
		id="dropDownSelect1">
		<div class="container-contact3">
			<section>
				<div class="wrap-contact3">
					<%
						//세션 값 불러오기
						String cEmail = (String) session.getAttribute("uEmail");
						PrintWriter script = response.getWriter();
						//로그인이 되었는지 안되었는지 판단
						if (cEmail == null) {
							script.println("<script>");
							script.println("alert('로그인 후 이용해주세요')");
							script.println("location.href='../pagemain/mainpage.jsp'");
							script.println("</script>");
						}
					%>
					<form id="from-1" class="contact3-form validate-form" method="post"
						action="./reservationAction.jsp">
						<span class="contact3-form-title"> 오피스 예약 </span>

						<div class="wrap-contact3-form-radio">
							<div class="contact3-form-radio m-r-42">
								<input class="input-radio3" id="radio1" type="radio"
									name="rvType" value="개인" checked onClick="companyOff()"> <label
									class="label-radio3" for="radio1"> 개인 </label>
							</div>
							<div class="contact3-form-radio">
								<input class="input-radio3" id="radio2" type="radio"
									name="rvType" value="기업" onClick="companyOn()"> <label class="label-radio3"
									for="radio2" > 기업 </label>
							</div>
						</div>
						<%
							ArrayList<Building> buildingArr = buildingDAO.selectBuildingAll();
						%>
						<div>
							<select id="building" class="selection-2" name="rvBname" required
								onchange="officeCategory();officeList();">
								<optgroup label="지점 선택">
									<c:forEach var="building" items="<%=buildingArr%>"
										varStatus="status">
										<option value="${building.getbName()}">${building.getbName()}</option>
									</c:forEach>
								</optgroup>
							</select>
							<hr style="color: white;">
						</div>
						<div class="wrap-input3 validate-input">
						<div class="d-flex">
							<div class="col-sm" style="padding-left:0px;">
								<select id="personSelect" class="selection-2" required onchange="officeList()">
								</select>
							</div>
							
							<div class="col-sm" style="padding-right:0px;">
								<select id="officeSelect" class="selection-2" name="rvOname" required>
								</select>
							</div>
							<hr style="color: white;">
						</div>
						</div>
						<div>
							<select class="selection-2" name="rvPeriod" required>
								<optgroup label="기간 선택(1개월 단위)">
									<option value="1">1개월</option>
									<option value="2">2개월</option>
									<option value="3">3개월</option>
									<option value="4">4개월</option>
									<option value="5">5개월</option>
									<option value="6">6개월(5% 할인)</option>
									<option value="7">7개월(5% 할인)</option>
									<option value="8">8개월(5% 할인)</option>
									<option value="9">9개월(5% 할인)</option>
									<option value="10">10개월(5% 할인)</option>
									<option value="11">11개월(5% 할인)</option>
									<option value="12">12개월(10% 할인)</option>
								</optgroup>
							</select>
							<hr style="color: white;">
						</div>
						<div class="wrap-input3 validate-input">
							<span class="form-label" style="font-size: 15px; color: white;">입주
								날짜<br></br>
							</span> <input class="form-control" type=month name="rvIndate" required>
						</div>
						<hr style="color: white;">

						<%
							User_account user1 = userDAO.selectOneuser(cEmail);
						%>

						<div class="wrap-input3 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<p style="font-size: 15px; color: white;">&nbsp;EMAIL</p>
							<input class="input3" type="text" name="uEmail"
								value="<%=user1.getuEmail()%>" required readonly> <span
								class="focus-input3"></span>
						</div>
						<div class="wrap-input3 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<p style="font-size: 15px; color: white;">&nbsp;이름</p>
							<input class="input3" type="text" name="uName"
								value="<%=user1.getuName()%>" required readonly> <span
								class="focus-input3"></span>
						</div>
						<div class="wrap-input3 validate-input"
							data-validate="phone is required">
							<p style="font-size: 15px; color: white;">&nbsp;연락처</p>
							<input class="input3" type="text" name="uPhone"
								value="<%=user1.getuPhone()%>" required readonly> <span
								class="focus-input3"></span>
						</div>
						<%
							userDAO.close();
							Companyinfo_history company = companyDAO.selectLatestCompany(cEmail);
						%>
						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;기업명</p>
							<input class="input3" type="text" name="cName"
								value="<%=company.getcName()==null?"":company.getcName()%>"> <span
								class="focus-input3"></span>
						</div>
						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;사업자등록번호</p>
							<input class="input3" type="text" name="cBuznum"
								value="<%=company.getcBuznum()==null?"":company.getcBuznum()%>"> <span
								class="focus-input3"></span>
>>>>>>> refs/remotes/origin/main
						</div>

						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;대표자명</p>
							<input class="input3" type="text" name="cRepersentative"
								value="<%=company.getcRepersentative()==null?"":company.getcRepersentative()%>"> <span
								class="focus-input3"></span>
						</div>
						<div class="wrap-input3 input3-select">
							<p style="font-size: 15px; color: white;">&nbsp;기업 연락처</p>
							<input class="input3" type="text" name="cPhone"
								value="<%=company.getcPhone()==null?"":company.getcPhone()%>"> <span
								class="focus-input3"></span>
						</div>

						<div class="container-md-center" align="center">

							<br>
							<button class="contact3-form-btn" onclick="$('#form-1').submit()">
								예약
							</button>
						</div>						
					</form>
				</div>
			</section>
		</div>
	</div>
	
	<%@ include file="../pagemain/mainpage_Footer.jsp"%>
	
	<script src="../vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="../vendor/bootstrap/js/popper.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="../vendor/select2/select2.min.js"></script>
	<script src="../js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js" ></script>
	
	<script>
		$(".selection-2").select2({
			minimumResultsForSearch : 20,
			dropdownParent : $('#dropDownSelect1')
		});
	</script>

	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag() {
			dataLayer.push(arguments);
		}
		gtag('js', new Date());
		gtag('config', 'UA-23581568-13');
	</script>

	<script>
		var arrayListArr;
		var personSelect = $("#personSelect");
		var officeSelect = $("#officeSelect");
			
		officeCategory();
		
		var cName = $("input[name='cName']");
		var cBuznum = $("input[name='cBuznum']");
		var cRepersentative = $("input[name='cRepersentative']");
		var cPhone = $("input[name='cPhone']");
		
		function companyOn(){
			cName.prop('required',true);
			cBuznum.prop('required',true);
			cRepersentative.prop('required',true);
			cPhone.prop('required',true);			
		}
		function companyOff(){
			cName.prop('required',false);
			cBuznum.prop('required',false);
			cRepersentative.prop('required',false);
			cPhone.prop('required',false);	
		}
		

		function officeCategory() {
			
			$.ajax({
				type : "post",
				url : "./reservationAction.jsp",
				async : true,
				data : "building=" + $("#building").val(),
				success : function(re) {
					var array = re.trim().split(",");
					personSelect.empty();
					personSelect.append("<optgroup label='인원 선택'>");
					for (var i = 0; i < array.length; i++) {
							var option = $("<option value="+array[i]+" >"
									+ array[i] + "</option>");
						personSelect.append(option);
					}
					personSelect.append("</optgroup>");
					officeList();
				}
			
			,
				error : function() {
					alert("오류 발생. 반복될 시 관리자에게 문의하시기 바랍니다.");
				}
			});
		}
		
		function officeList() {
			console.log($("#building").val()+"  "+$("#personSelect").val());
			var buildingReg=$("#building").val();
			$.ajax({
				type : "post",
				url : "./reservationAction.jsp",
				async : true,
				data : "building=" + $("#building").val()+"&officeKinds=" + $("#personSelect").val(),
				success : function(re) {
					var array = re.trim().split(",");
					officeSelect.empty();
					officeSelect.append("<optgroup label='오피스 선택'>");
					for (var i = 0; i < array.length; i++) {
							var option = $("<option value="+array[i]+" >"
									+ array[i]+" "+buildingReg + "</option>");
						officeSelect.append(option);
						officeSelect.append("</optgroup>");
					}

				},
				error : function() {
					alert("오류 발생. 반복될 시 관리자에게 문의하시기 바랍니다.");
				}
			});
		}
	</script>

</body>
</html>
