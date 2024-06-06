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
									<input type="checkbox" id="roomCheckbox" name="room" onchange="searchMyList(1); checkYN();"> 시설 &nbsp;
									 <input type="checkbox" id="supCheckbox" name="supplies" onchange="searchMyList(1); checkYN();"> 비품
								</h6>

							<div class="card-tools">
								<div class="input-group input-group-sm" style="width: 120px;">
									<select id="status" name="status" class="form-control" onchange="searchMyList(1);">
										<option value="ALL">전체</option>
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
								<tbody id="listBody">
								<c:choose>
								<c:when test="${empty bkList}">
									<tr>
										<td colspan='7'>조회된 내역이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="bk" items="${ bkList }" varStatus="num" >
										<tr onclick="location.href='${contextPath}/booking/detail.bk?no=${ bk.bookingNo }&sup=${bk.subName }'">
											<td>${fn:length(bkList) - num.index}</td>
											<td>${ bk.mainName }</td>
											<td>${ bk.subName }</td>
											<td>${ bk.assetsName }</td>
											<td>${ bk.bkStartDate }</td>
											<c:choose>
											<c:when test="${ bk.subName eq '차량' }">
												<td> ~ </td>
											</c:when>
											<c:otherwise>
												<td>${ bk.bkStartTime } ~ ${ bk.bkEndTime }</td>
											</c:otherwise>
											</c:choose>
											<td>${ bk.status }</td>
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
						    <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
						        <a class="page-link" href="${contextPath}/booking/mylist.bk?page=${pi.currentPage - 1}">&laquo;</a>
						    </li>
						    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
						        <li class="page-item ${pi.currentPage == p ? 'disabled' : ''}">
						            <a class="page-link" href="${contextPath}/booking/mylist.bk?page=${p}">${p}</a>
						        </li>
						    </c:forEach>
						    <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
						        <a class="page-link" href="${contextPath}/booking/mylist.bk?page=${pi.currentPage + 1}">&raquo;</a>
						    </li>
						</ul>
					</div>
					</div>
					<!-- /.card -->
				</div>
				<!-- /.content-wrapper -->
			</div>
		</div>
		<!-- /.content-wrapper -->
		<script>
		
		// 체크박스 값 확인 및 반환하는 함수
	    function checkYN() {
	        let room = document.getElementById('roomCheckbox').checked ? 'Y' : 'N';
	        let supplies = document.getElementById('supCheckbox').checked ? 'Y' : 'N';
	        return { room, supplies };
	    }

	    // 검색 실행 함수
	    function searchMyList(no) {
	        let { room, supplies } = checkYN(); // checkYN()으로부터 값을 가져옴
	        let status = document.getElementById('status').value;

			$.ajax({
				url: "${contextPath }/booking/mylist.search",
				type: "get",
				data:{
					room: room,
					supplies: supplies,
					status: status,
					page:no
				},success:function(result){
					let table ="";
					let page = "";
					let list = result.bkList;
					let pi = result.pi;
					if(list != null){
						for(let i=0; i<list.length; i++){
							table +="<tr onclick=\"location.href='${contextPath}/booking/detail.bk?no=" + list[i].bookingNo + "&sup=" + list[i].supName + "'\">";
							table +="<td>"+ (list.length - i)+"</td>";
							table +="<td>"+ list[i].mainName +"</td>";
							table +="<td>"+ list[i].subName +"</td>";
							table +="<td>"+ list[i].assetsName+"</td>";
							table +="<td>"+ list[i].bkStartDate +"</td>";
							if(list[i].subName === '차량'){
								table += "<td> ~ </td>";
							}else{
								table +="<td>"+ list[i].bkStartTime +" ~ "+ list[i].bkEndTime +"</td>";
							}
							table +="<td>"+ list[i].status +"</th></tr>";
						}
					  	
						page += "<li class=\"page-item " + (pi.currentPage == 1 ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchMyList(" + (pi.currentPage - 1) + ");\">&laquo;</a></li>";

						for (let i = pi.startPage; i <= pi.endPage; i++) {
						    page += "<li class=\"page-item " + (pi.currentPage == i ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchMyList(" + i + ");\">" + i + "</a></li>";
						}

						page += "<li class=\"page-item " + (pi.currentPage == pi.maxPage ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchMyList(" + (pi.currentPage + 1) + ");\">&raquo;</a></li>";
					}
					
					$("#roomCheckbox").prop("checked",result.search.room == 'Y' ? true: false);
					$("#supCheckbox").prop("checked",result.search.supplies == 'Y' ? true: false);
					
					$("#listBody").html(table);
					$("#pageArea ul").html(page);
				},error:function(){
					console.log("에작 실패");
				}
				
			})
		}
		 $(document).ready(function() {
		 	$('#roomCheckbox, #supCheckbox, #status').change(function() {
		 		searchMyList(1); // 변경 사항이 감지되면 검색 실행
		    });
		 	
	    });
		</script>
	

</body>
</html>