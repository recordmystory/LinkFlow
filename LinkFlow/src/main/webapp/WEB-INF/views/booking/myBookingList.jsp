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

/* 예약관련게시판 */
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

		<jsp:include page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />

		<div class="LinkFlowMainSection">
		
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
				<div class="">
					<div class="card">
						<div class="card-header">
							<h6 class="card-title">
								<input type="checkbox"> 시설 &nbsp; 
								<input type="checkbox"> 비품
							</h6>

							<div class="card-tools">
								<div class="input-group input-group-sm" style="width: 120px;">
									<select id="dropdownOptions" class="form-control">
										<option value="WAI">예약대기</option>
										<option value="COM">예약완료</option>
										<option value="USE">사용중</option>
										<option value="END">사용완료</option>
										<option value="REJ">예약반려</option>
										<option value="CAN">예약취소</option>
									</select>
								</div>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body table-responsive p-0">
							<table class="table table-hover text-nowrap">
								<thead>
									<tr>
										<th style="width: 50px;">No</th>
										<th style="width: 120px;">카테고리</th>
										<th style="width: 120px;">자원</th>
										<th>상품명</th>
										<th>예약날짜</th>
										<th>예약시간</th>
										<th style="width: 170px;">상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>
									<tr>
										<td>10</td>
										<td>시설</td>
										<td>회의실</td>
										<td>A</td>
										<th>2024-04-05</th>
										<th>13:00 ~ 15:00</th>
										<th>예약대기</th>
									</tr>

								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
					</div>
					<div class="pagination"
						style="display: flex; justify-content: center;">
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
				<!-- /.content-wrapper -->
			</div>
		</div>
		<!-- /.content-wrapper -->
	</div>

</body>
</html>