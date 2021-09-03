<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description"/>
	<meta name="author"/>
	<title>공유 오피스 메인</title>
	<link rel="icon" type="../image/x-icon" href="../assets/favicon.ico" />
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
	<link href="../css/styles.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</head>
 
<body id="page-top">

	<%@ include file="mainpage_nav.jsp" %>

	<header class="masthead">
		<div class="container">
			<div class="masthead-subheading">사무실 또는 오피스를 찾으시나요?</div>
			<div class="masthead-heading text-uppercase">원하는 오피스를 알아보세요</div>
		</div><br><br><br><br><br><br><br><br><br><br><br><br>
	</header>

	<section class="page-section" id="services">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">공유 오피스</h2>
				<h3 class="section-subheading text-muted">공유오피스는 우리 회사만을 위한 독립 공간과<br>
				다른 회사와 함께 쓰는 공용 공간이 결합된 새로운 오피스입니다</h3>
			</div>
			<div class="row text-center">
				<div class="col-md-4" >
					<span class="fa-stack fa-4x">
						<i class="fas fa-circle fa-stack-2x text-primary"></i>
						<i class="fas fa-laptop fa-stack-1x fa-inverse"></i>
					</span>
					<h4 class="my-3">1인실</h4>
				</div>
				<div class="col-md-4">
					<span class="fa-stack fa-4x">
						<i class="fas fa-circle fa-stack-2x text-primary"></i>
						<i class="fas fa-laptop-house fa-stack-1x fa-inverse"></i>
					</span>
					<h4 class="my-3">5인실</h4>
				</div>
				<div class="col-md-4">
					<span class="fa-stack fa-4x">
						<i class="fas fa-circle fa-stack-2x text-primary"></i>
						<i class="fas fa-building fa-stack-1x fa-inverse"></i>
					</span>
					<h4 class="my-3">10인실</h4>
				</div>
			</div>
		</div>
	</section>
	
	<%@ include file="mainpage_Footer.jsp" %>

</body>
</html>
