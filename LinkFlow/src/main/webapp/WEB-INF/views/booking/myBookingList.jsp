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
								<input type="checkbox"> 시설 &nbsp; 
								<input type="checkbox"> 비품
							</h6>

							<div class="card-tools">
								<div class="input-group input-group-sm" style="width: 120px;">
									<select id="dropdownOptions" class="form-control">
										<option value="">전체</option>
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
								<c:choose>
								<c:when test="${empty bkList}">
									<tr>
										<td colspan='7'>조회된 내역이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="bk" items="${ bkList }">
										<tr onclick="location.href='${contextPath}/booking/detail.bk?no=${ bk.bookingNo }'">
											<td>${ bk.bookingNo }</td>
											<td>${ bk.mainName }</td>
											<td>${ bk.subName }</td>
											<td>${ bk.assetsName }</td>
											<th>${ bk.bkStartDate }</th>
											<th>${ bk.bkStartTime } ~ ${ bk.bkEndTime }</th>
											<th>${ bk.status }</th>
										</tr>
									</c:forEach>
								</c:otherwise>
								</c:choose>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
					</div>
					<div class="pagination" id="pageArea" style="display: flex; justify-content: center;">
						<ul class="pagination">
							<li class="page-item" ${pi.currentPage ==1 ? 'disabled' : '' }><a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage -1}">&laquo;</a></li>
							<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
								<li class="page-item" ${ pi.currentPage == p ? 'disabled' : '' }><a class="page-link" href="${contextPath }/booking/mylist.bk?page=${p}">${p }</a></li>
							</c:forEach>
							<li class="page-item" ${pi.currentPage == pi.maxPage ? 'disabled' : '' }><a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage +1}">&raquo;</a></li>
						</ul>
					</div>
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