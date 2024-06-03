<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 시설/비품</title>
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
	min-height: 900px;
	padding: 30px;
	border-radius: 5px;
}

.card-tools {
	display: flex;
	justify-content: flex-end; /* 요소를 오른쪽으로 정렬합니다 */
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
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>

		<div class="LinkFlowMainSection">
			<jsp:include
				page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp"/>
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
							<form id="searchForm" action="${contextPath }/booking/sup.search" method="get" align="center">
								<h6 class="card-title">
									<input type="checkbox" id="useYN" onclick="useCheck(this);" ${ search.useYN == 'Y' ? 'checked' : '' }> &nbsp; 예약 가능한 상품만 보기 
									<input type="hidden" id="hiddenUse" name="useYN" value="N">
								</h6>

								<div class="card-tools">
									<input type="hidden" name="page" value="1">
									<div class="input-group input-group-sm select"
										style="width: 300px;">
										<select name="condition" class="form-control">
											<option value="sub_name">상품종류</option>
											<option value="assets_name">상품명</option>
										</select> 
										<input type="text" class="form-control float-right" placeholder="Search" name="keyword" value="${search.keyword}">
										<div class="input-group-append">
											<button type="submit" class="btn btn-default" >
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
								</div>
							</form>

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
									<tbody id="searchBody">
										<c:choose>
											<c:when test="${empty assList}">
												<tr>
													<th colspan=4>조회된 내역이 없습니다.</th>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="ass" items="${ assList }" varStatus="num">
													<tr>
														<td>${fn:length(assList) - num.index}</td>
														<td>${ ass.subName }</td>
														<td>${ ass.assetsName }</td>
														<td>${ ass.useYN == 'Y' ? '예약 가능' : '사용중' }</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							</div>
							<!-- /.card-body -->
						</div>
					</div>
			
				<div class="pagination" id="pageArea" style="display: flex; justify-content: center;">
					<ul class="pagination">
					    <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
					        <a class="page-link" href="${contextPath}/booking/supplies.bk?page=${pi.currentPage - 1}">&laquo;</a>
					    </li>
					    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
					        <li class="page-item ${pi.currentPage == p ? 'disabled' : ''}">
					            <a class="page-link" href="${contextPath}/booking/supplies.bk?page=${p}">${p}</a>
					        </li>
					    </c:forEach>
					    <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
					        <a class="page-link" href="${contextPath}/booking/supplies.bk?page=${pi.currentPage + 1}">&raquo;</a>
					    </li>
					</ul>
				</div>
				<!-- /.card -->
			</div>
		</div>
		<!-- /.content-wrapper -->
		</div>
			<script>
				$(document).ready(function() {
					if(${not empty search }){
						$("#searchForm select").val("${search.condition}");
	
						$("#pageArea a").on("click", function() {
							$("#searchForm input[name=page]").val($(this).text());
							$("#searchForm").submit();
	
							return false;
						});
	
						$("#useYN").on("click", function() {
							useCheck(this);
						});
					}

				});

				function useCheck(checkbox) {
					// 체크박스의 체크 여부 확인
					if (checkbox.checked) {
						document.getElementById("hiddenUse").value = "Y";
						$("#searchForm").submit();

					} else {
						document.getElementById("hiddenUse").value = "N";
						$("#searchForm").submit();
					}
				}
			</script>

</body>
</html>