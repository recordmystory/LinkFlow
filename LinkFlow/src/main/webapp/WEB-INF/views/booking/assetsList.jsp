<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	min-height: 900px;
	padding: 30px;
	border-radius: 5px;
}

/ /* 게시판 */
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

/* 모달 */
/* 모달 */
.md-header {
	padding-top: 20px;
	padding-left: 40px;
	display: flex;
	align-items: center;
}

.md-header p {
	padding: 10px;
	margin-top: 10px;
	font-size: larger;
}

.md-type {
	width: 70px;
	padding-left: 12px;
	height: 40px;
}

.md-list {
	color: rgb(203, 200, 200);
	padding-left: 25px;
	font-size: small;
	padding-top: 15px;
}

.md-select {
	text-align: center;
	height: 30px;
	width: 60px;
}

.md-div {
	display: flex;
	padding-left: 40px;
	padding-top: 13px;
}

.can-coment {
	border: none;
	border-bottom: 1px solid steelblue;
	width: 80%;
	height: 50px;
	margin-left: 20px;
}

.modal-body {
	margin-left: 13px;
	padding-bottom: 20px;
}

.modal-body h6 {
	padding-top: 12px;
}

.modal-content {
	width: 400px;
}

.bk-modal {
	padding-left: 30px;
	display: flex;
	/* align-items: center; */
}

.bk-content {
	padding: 15px;
	padding-bottom: 22px;
	/* width: 90%; */
	text-align: center;
}

.rej-coment {
	border: none;
	border: 1px solid steelblue;
	width: 90%;
	height: 50px;
	margin-left: 20px;
}

.bk-time {
	display: flex;
	flex-direction: column;
}

.bk-time p {
	margin-bottom: 20px;
	/* 아래쪽 간격 조절 */
}

.bk-time p:first-child {
	margin-bottom: 2px;
	/* 마지막 p 요소의 아래쪽 간격을 0으로 설정하여 두 요소 사이의 간격을 없앰 */
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
			<jsp:include
				page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />

			<div class="LinkFlowMainContent">
				<!-- Content Header (Page header) -->
				<div class="card-header">
					<div class="card-tools">
						<div class="input-group input-group-sm">
							<select id="dropdownOptions" class="form-control main-cate">
								<option value="room">시설</option>
								<option value="supplies">비품</option>
							</select> &nbsp; 
							<select id="dropdownOptions" class="form-control middle-cate">
								<option value="">회의실</option>
							</select> &nbsp; <input type="text" name="table_search" class="form-control float-right" placeholder="Search">
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
								<th style="width: 150px;">카테고리</th>
								<th style="width: 150px;">자원</th>
								<th>상품명</th>
								<th style="width: 220px;">상태</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span data-toggle="modal" data-target="#acc-update">수정</span>
									| <span>삭제</span></td>
							</tr>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span>수정</span> | <span>삭제</span></td>
							</tr>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span>수정</span> | <span>삭제</span></td>
							</tr>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span>수정</span> | <span>삭제</span></td>
							</tr>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span>수정</span> | <span>삭제</span></td>
							</tr>
							<tr>
								<td>시설</td>
								<td>회의실</td>
								<td>A</td>
								<td><span>수정</span> | <span>삭제</span></td>
							</tr>

						</tbody>
					</table>
				</div>
				<!-- /.card-body -->
				<div class="modal fade" id="acc-update">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="bk-modal" style="padding-top: 40px;">
								<p>예약 비품 :</p>
								&nbsp;
								<p>노트북 / 맥북</p>
							</div>
							<div class="bk-modal bk-time">
								<p>예약 시간</p>
								<!-- 차량일 때만 -->
								<p>2024 / 04 / 25 ~ 2024 / 05 / 15</p>
							</div>
							<div class="bk-modal">
								<p>요청자 :
								<p>&nbsp;
								<p>조성모(개발1팀)</p>
							</div>
							<div class="modal-body">
								<h6>사용 용도</h6>
								<input type="text" class="can-coment" placeholder="부서 회의">
							</div>

							<!-- 승인일 때 -->
							<!-- <div class="bk-modal bk-content">
                                            <h5>예약 내용을 확인하였으며, 예약을 승인합니다.</h5>
                                        </div> -->

							<!-- 반려일 때 -->
							<div class="modal-body">
								<h6>비고</h6>
								<input type="text" class="rej-coment" placeholder=" 반려 사유">
							</div>

							<div class="modal-footer justify-content-between">
								<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
								<button type="button" class="btn btn-outline-primary">&nbsp;OK&nbsp;</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<div
				style="display: flex; justify-content: space-between; align-items: flex-end;">
				<div></div>
				<!-- 이 부분은 왼쪽 정렬을 유지하기 위한 간격입니다. -->
				<div>
					<button class="btn bg-gradient-secondary">자산 추가</button>
				</div>
			</div>


		</div>
		<div class="pagination" id="pageArea"
			style="display: flex; justify-content: center;">
			<ul class="pagination">
				<li class="page-item" ${pi.currentPage ==1 ? 'disabled' : '' }>
					<a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage -1}">&laquo;</a>
				</li>
				<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
					<li class="page-item" ${ pi.currentPage == p ? 'disabled' : '' }>
						<a class="page-link" href="${contextPath }/booking/mylist.bk?page=${p}">${p }</a>
					</li>
				</c:forEach>
				<li class="page-item" ${pi.currentPage == pi.maxPage ? 'disabled' : '' }>
					<a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage +1}">&raquo;</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- /.card -->

	<!-- /.content-wrapper -->
	<script>
		
		 $(document).ready(function() {
		 	$('#roomCheckbox, #supCheckbox, #status').change(function() {
		    	// search(); // 변경 사항이 감지되면 검색 실행
		    });
	    });
		</script>
	

</body>
</html>