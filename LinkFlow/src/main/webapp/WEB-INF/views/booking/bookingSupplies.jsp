<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my booking list</title>
<style>

.LinkFlowMainSection {
	width: 100%;
	min-height: 100%;
	display: flex;
}

.LinkFlowMainContent {
	width: 100%;
	min-width: 1260px;
	background-color: #f4f6f9;
	min-height:900px;
	padding: 30px;
	border-radius: 5px;
}

/* 비품예약 */
.card-title, .card-tools {
	padding: 10px;
}

.card-body {
	text-align: center;
}

.bk-table {
	width: 95%;
	justify-content: space-between;
}

/* 체크박스 */
input[type="checkbox"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 15px;
	height: 15px;
	border-radius: 50%;
	border: 2px solid #ccc;
}

input[type="checkbox"]:checked {
	background-color: #007bff;
}
</style>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="LinkFlowMainSection">
			<jsp:include page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />
			<div class="LinkFlowMainContent">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">&nbsp;</h1>
						</div>
					</div>
				</section>
					<!-- /.container-fluid -->
					<div class="bk-table">
						<div class="card">
							<div class="card-header">
								<h6 class="card-title">
									<input type="checkbox"> &nbsp; 예약 가능한 상품만 보기
								</h6>

								<div class="card-tools">
									<div class="input-group input-group-sm " style="width: 300px;">
										<select id="dropdownOptions" class="form-control ">
											<option value="">상품종류</option>
											<option value="">상품명</option>
										</select> <input type="text" name="table_search"
											class="form-control float-right" placeholder="Search">
										<div class="input-group-append">
											<button type="submit" class="btn btn-default">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
							<!-- /.card-header -->
							<div class="card-body table-responsive p-0">
								<table class="table table-hover text-nowrap">
									<thead>
										<tr>
											<th style="width: 70px;"></th>
											<th style="width: 300px;">상품종류</th>
											<th>상품명</th>
											<th style="width: 200px;">상태</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
									<c:when test="${empty assList}">
										<tr> 
											<th colspan=4> 조회된 내역이 없습니다. </th>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="ass" items="${ assList }">
											<tr>
												<td> </td>
												<td>${ ass.subName }</td>
												<td>${ ass.assetsName }</td>
												<td>${ ass.useYN = 'Y' ? '예약 가능' : '사용중' }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
									</c:choose>
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
						</div>
						<div class="pagination" style="display: flex; justify-content: center;">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
							</ul>
						</div>
						<!-- /.card -->
					</div>
			</div>
			<!-- /.content-wrapper -->
		</div>
	</div>

</body>
</html>