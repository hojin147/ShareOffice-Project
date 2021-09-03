<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="office.Office"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="officeDAO" class="dao.OfficeDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Office Manage</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<link rel="canonical" href="https://www.creative-tim.com/product/fresh-bootstrap-table" />
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
		integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
		crossorigin="anonymous"></script>
	<link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300" rel="stylesheet" type="text/css">
	<link href="../css/reservation.css" rel="stylesheet" />
	<link href="../css/styles2.css" rel="stylesheet" />
	<script src="../js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://unpkg.com/bootstrap-table/dist/bootstrap-table.min.js"></script>
	
<style>
	span .loading-text {
		opacity: 0;
	}
	
	.caret {
		opacity: 0;
	}
	
	i {
		font-size: 2.0rem;
	}
	
	.refresh {
		display: none;
	}
	
	.dropdown-toggle {
		font-size: 1.5rem;
	}
	
	.search {
		float:right;
		width: 30%;
	}
	
	#mainNav {
		zoom: 1.2;
	}
	
	.btn-secondary {
		display: none;
	}
	
	.btn-social {
	    height: 4rem;
	    width: 4rem;
	    display: inline-flex;
	    align-items: center;
	    justify-content: center;
	    padding: 0;
	    border-radius: 100%;
	}
	
	.container {
	    padding-left: 20px;
	    padding-right: 5px;
	}
	
	.svg-inline--fa {
	    display: inline-block;
	    font-size: initial;
	    height: 1em;
	    overflow: visible;
	    vertical-align: -.125em;
	}
	
	.dropdown-menu {
		font-size: 14px;
	}
</style>

</head>
<body>

	<section style="padding-top: 70px; padding-bottom: 40px;"></section>

	<%@ include file="../pagemain/mainpage_nav.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div style="text-align: center;" class="description">
					<h1>지점 및 오피스 목록</h1>
				</div><br>
				<div style="text-align: center;" class="fresh-table full-color-orange">
					<table style="zoom: 1.5;" id="fresh-table" class="table">
						<thead>
							<th data-field="no">NO</th>
							<th data-field="building">지점</th>
							<th data-field="office" data-sortable="true">오피스</th>
							<th>상세보기</th>
						</thead>
						<tbody>
							<%

								ArrayList<Office> officeArr = officeDAO.selectOfficeAll();

							%>
							<c:forEach var="office" items="<%=officeArr%>" varStatus="status">
								<tr>
									<th scope="row" class="scope">${status.count}</th>
									<td>${office.getoBuildingName()}</td>
									<td>${office.getoName()}</td>
									<td><a style="zoom: 0.9;"
										href="officeDetail.jsp?num=${office.getoNum()}"
										class="btn btn-primary">상세보기</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../pagemain/mainpage_Footer.jsp"%>

	<script type="text/javascript">
		var $table = $('#fresh-table')
	
		$(function() {
			$table.bootstrapTable({
				classes : 'table table-hover table-striped',
				toolbar : '.toolbar',
	
				search : true,
				showRefresh : true,
				showToggle : true,
				showColumns : true,
				pagination : true,
				striped : true,
				sortable : true,
				pageSize : 10,
				pageList : [ 8, 10, 25, 50, 100 ],
	
				formatShowingRows : function(pageFrom, pageTo, totalRows) {
					return ''
				},
				formatRecordsPerPage : function(pageNumber) {
					return pageNumber + ''
				}
			})
	
		})
		
		(function(i, s, o, g, r, a, m) {
			i['GoogleAnalyticsObject'] = r;
			i[r] = i[r] || function() {
				(i[r].q = i[r].q || []).push(arguments)
			}, i[r].l = 1 * new Date();
			a = s.createElement(o), m = s.getElementsByTagName(o)[0];
			a.async = 1;
			a.src = g;
			m.parentNode.insertBefore(a, m)
		})(window, document, 'script', '//www.google-analytics.com/analytics.js',
				'ga')
	
		ga('create', 'UA-46172202-1', 'auto')
		ga('send', 'pageview')
	</script>

</body>
</html>