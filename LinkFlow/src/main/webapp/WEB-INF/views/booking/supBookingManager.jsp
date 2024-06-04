<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

/* 게시판 */
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
	padding: 20px;
	margin-bottom: 15px;
	/* width: 85%; */
	text-align: center;
	font-size:small;
	font-weight: bold;
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
				<section class="content-header">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">예약 목록</h1>
						</div>
					</div>
				</section>

				<!-- Main content -->
				<section class="content">
					<!-- /.container-fluid -->
					<div class="bk-table">
						<div class="card">
							<!-- /.card-header -->
							<div class="card-body table-responsive p-0">
								<table class="table table-hover text-nowrap">
									<thead>
										<tr>
											<th style="width: 70px;">자원 종류</th>
											<th style="width: 150px;">상품명</th>
											<th>요청자</th>
											<th>예약 시간</th>
											<th>신청일</th>
											<th style="width: 100px;">설정</th>
										</tr>
									</thead>
									<tbody id="bkWaitTable">
										
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
							<div class="modal fade" id="sup-confirm">
								<div class="modal-dialog">
								<form id="sup-conForm" action="${contextPath }/booking/supCon.bk" method="post">
									<input type="hidden" id="con-bkNo" name="bookingNo">
									<div class="modal-content">
									
										<div class="bk-modal" id="con-supUser" style="padding-top: 40px;">
											
										</div>
										<div class="bk-modal" id="con-sub-ass">
											
										</div>
										<div class="bk-modal bk-time" id="con-supTime">
											
										</div>
										<div class="modal-body">
											<h6>사용 용도</h6>
											<input type="text" class="can-coment" id="con-bkContent" placeholder="" disabled>
										</div>

										<!-- 승인일 때 -->
										<div class="bk-modal bk-content" id="con-conDiv">
					                        <h5>예약 내용을 확인하였으며, 예약을 승인합니다.</h5>
					                    </div> 
					                    <!-- 반려일 때 -->
										<div class="modal-body" id="con-rejDiv" style="margin-bottom: 20px;">
											<h6>반려 사유</h6>
											<input type="text" class="rej-coment" name="rejContent" id="rej-content">
										</div>

										<div class="modal-footer justify-content-between">
											<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
											<button type="submit" class="btn btn-outline-primary">&nbsp; OK &nbsp;</button>
										</div>
									</div>
								</form>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- /.modal -->
						</div>
						<div class="pagination" id="pageArea" style="display: flex; justify-content: center;">
							<ul class="pagination" id ="bkWaitPage">
							<!-- 페이징 -->
							</ul>
						</div>
						
					</div>
				</section>
				<br> <br>
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">완료 목록</h1>
						</div>

					</div>
				</section>

				<!-- Main content -->
				<section class="content">
					<!-- /.container-fluid -->
					<div class="bk-table">
						<div class="card">
							<div class="card-header">
								<!-- <h6 class="card-title"><input type="radio"> 예약 가능한 상품만 보기</h6> -->

								<div class="card-tools">
									<div class="input-group input-group-sm" style="width: 300px;">
										<select id="condition" class="form-control" name="condition">
											<option value="subName">자원종류</option>
											<option value="assetsName">상품명</option>
											<option value="userName">요청자</option>
										</select> &nbsp; 
										<input type="text" id="keyword" name="keyword" class="form-control float-right" placeholder="Search">
										<div class="input-group-append">
											<button type="button" class="btn btn-default" onclick="bkStatusList();">
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
											<th style="width: 70px;">자원 종류</th>
											<th style="width: 150px;">상품명</th>
											<th>요청자</th>
											<th>예약 시간</th>
											<th>신청일</th>
											<th style="width: 100px;">설정</th>
										</tr>
									</thead>
									<tbody id="bkStatusTable">
										
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
							<!-- 반납 모달 -->
							<div class="modal fade" id="sup-detail">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="bk-modal" id="de-header" style="padding-top: 40px;">
											<h4>예약 상세</h4>
										</div>
										<div class="bk-modal" id="de-supUser" style="padding-top: 20px;">
											
										</div>
										<div class="bk-modal" id="de-sub-ass">
											
										</div>
										<div class="bk-modal bk-time" id="de-supTime">
											
										</div>
										<div class="modal-body">
											<h6>사용 용도</h6>
											<input type="text" class="can-coment" id="de-bkContent" placeholder="" disabled>
										</div>
										
										<!-- 반려일때  -->
										<div class="modal-body" id="de-rejDiv">
											<h6>반려 사유</h6>
											<input type="text" class="rej-coment" id="de-rejContent" placeholder="" style="margin-bottom: 20px;" disabled>
										</div>
										
										<!-- 반납일때 -->
										<div class="bk-modal bk-content" id="de-return">
											<h5>상세 내용을 확인하였으며, 반납완료 처리합니다.</h5>
										</div>
										<form id="sup-reForm" action="" method="post">
										<input type="hidden" id="re-bkNo" name="bookingNo">
										<div class="modal-footer justify-content-between">
											<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
											<button type="submit" class="btn btn-outline-primary submit-btn">&nbsp; OK &nbsp;</button>
										</div>
										</form>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- /.modal -->
						</div>
						<div class="pagination" id="pageArea" style="display: flex; justify-content: center;">
							<ul class="pagination" id="bkStatPage">
							</ul>
						</div>
					</div>
				</section>
			</div>
		</div>
		<!-- /.content-wrapper -->
	</div>
	<script>
	$(document).ready(function () {
       bkWaitList(1);
       bkStatusList(1);
      });
	
	function bkWaitList(currentPage){
		$.ajax({
			url:'${contextPath}/booking/supWait.list',
			type:'get',
			data:{ page:currentPage },success:function(result){
				let table="";
				let bk = result.bkWaitList;
				let pi = result.pi;
				if(!bk || bk.length === 0){
					table+= "<tr><td colspan='6'>조회된 내역이 없습니다.</td></tr>";
				}else{
					for (let i = 0; i < bk.length; i++) {
	                    let bkDto = JSON.stringify(bk[i]).replace(/'/g, "\\'").replace(/"/g, '&quot;'); // 작은따옴표와 큰따옴표 이스케이프
	                    table += "<tr>"
	                          + "<td>" + bk[i].subName + "</td>"
	                          + "<td>" + bk[i].assetsName + "</td>"
	                          + "<td>" + bk[i].userName + "(" + bk[i].deptName + ")</td>";
	                    if (bk[i].subName === '차량') {
	                        table += "<td>"+ bk[i].bkStartDate + " - "+ bk[i].bkEndDate +"</td>";
	                    } else {
	                        table += "<td> - </td>";
	                    }
	                    table += "<td>"+ bk[i].enrDate +"</td>"
	                          + "<td>"
	                          + "<a data-toggle='modal' data-target='#sup-confirm' onclick='supBooking(1, " + JSON.stringify(bk[i]) + ");'>승인</a>"
	                          + " | " 
	                          + "<a data-toggle='modal' data-target='#sup-confirm' onclick='supBooking(2, " + JSON.stringify(bk[i]) + ");'>반려</a>"
	                          + "</td></tr>";
	            		
	                }
					
				}
				
				let page = "";

			  	page += "<li class=\"page-item " + (pi.currentPage == 1 ? 'disabled' : '') + "\"><a class=\"page-link\" href='#' onclick=\"bkWaitList(" + (pi.currentPage - 1) + ");\">&laquo;</a></li>";

			  	for(let i = pi.startPage; i <= pi.endPage; i++){
			  	    page += "<li class=\"page-item " + (pi.currentPage == i ? 'disabled' : '') + "\"><a class=\"page-link\" href='#' onclick=\"bkWaitList(" + i + ");\">" + i + "</a></li>";
			  	}

			  	page += "<li class=\"page-item " + (pi.currentPage == pi.maxPage ? 'disabled' : '') + "\"><a class=\"page-link\"  href='#' onclick=\"bkWaitList(" + (pi.currentPage + 1) + ");\">&raquo;</a></li>";
				
				
				$("#bkWaitTable").html(table);
				$("#bkWaitPage").html(page);
				
			},error:function(){
				console.log("에작 에러");
			}
			
		})
	}
	
	function bkStatusList(currentPage){
		let keywordElement = document.getElementById('keyword');
	    let keyword = (keywordElement != null && keywordElement.value != null) ? keywordElement.value : "";
	    let conditionElement = document.getElementById('condition');
	    let condition = (conditionElement != null && conditionElement.value != null) ? conditionElement.value : "";
		
	    $("#bkStatusTable").empty();
	    $("#bkStatPage").empty();
	    
		$.ajax({
			url:'${contextPath}/booking/supStat.list',
			type:'get',
			data:{
				page:currentPage,
				keyword: keyword,
				condition: condition
			},success:function(result){
				let table="";
				let bk= result.bkStatusList;
				if(!bk || bk.length === 0){
					table+= "<tr><td colspan='6'>조회된 내역이 없습니다.</td></tr>";
				}else{
					for(let i=0; i<bk.length; i++){
						table += "<tr>"
							  + "<td>"+ bk[i].subName + "</td>"
							  + "<td>"+ bk[i].assetsName + "</td>"
							  + "<td>"+ bk[i].userName + "("+ bk[i].deptName +")</td>";
						 if (bk[i].subName === '차량') {
		                       table += "<td>"+ bk[i].bkStartDate + " - "+ bk[i].bkEndDate +"</td>";
		                   } else {
		                        table += "<td> - </td>";
		                   }
						table += "<td>"+ bk[i].enrDate +"</td>";
						if(bk[i].status == "COM" || bk[i].status == "USE"){
							table += "<td>"
								  + "<a data-toggle='modal' data-target='#sup-detail' onclick='supDetail(1, "+ JSON.stringify(bk[i]) +")'>사용중</a>"
								  + " | " 
								  + "<a data-toggle='modal' data-target='#sup-detail' onclick='supDetail(2, "+ JSON.stringify(bk[i]) +")'>반납</a>"
								  + "</td></tr>";
						}else if(bk[i].status == "REJ"){
							table += "<td>"
								  + "<a data-toggle='modal' data-target='#sup-detail' onclick='supDetail(3, "+ JSON.stringify(bk[i]) +")'>반려</a>"
								  + "</td></tr>";
						}else{
							table += "<td>"
								  + "<a data-toggle='modal' data-target='#sup-detail' onclick='supDetail(1, "+ JSON.stringify(bk[i]) +")'>사용완료</a>"
								  + "</td></tr>";
						}
					}
				}
				let page = "";
	            let pi = result.pi;

	            page += "<li class='page-item " + (pi.currentPage == 1 ? 'disabled' : '') + "'><a class='page-link' onclick='bkStatusList(" + (pi.currentPage - 1) + ");'>&laquo;</a></li>";

	            for (let i = pi.startPage; i <= pi.endPage; i++) {
	                page += "<li class=\"page-item " + (pi.currentPage == i ? 'disabled' : '') + "\"><a class=\"page-link\" onclick='bkStatusList(" + i + ");'>" + i + "</a></li>";
	            }

	            page += "<li class=\"page-item " + (pi.currentPage == pi.maxPage ? 'disabled' : '') + "\"><a class=\"page-link\" onclick='bkStatusList(" + (pi.currentPage + 1) + ");'>&raquo;</a></li>";

				$("#bkStatusTable").html(table);
				$("#bkStatPage").html(page);
			},error:function(){
				console.log("에작 에러");
			}
		})
	}
	
	function supBooking(type,bk){
		$('#rej-content').val('');
		if(type === 1){ // 승인
			$('#con-conDiv').css('display', 'block');
			$('#con-rejDiv').css('display', 'none');
			
			$('#rej-content').removeAttr('required');
			
		}else{ // 반려
			$('#con-rejDiv').css('display', 'block');
			$('#con-conDiv').css('display', 'none');
			$('#rej-content').prop('placeholder',' 반려 사유');
			$('#rej-content').attr('required','required');
		}
		
		$("#con-bkNo").val(bk.bookingNo);
		
		$("#con-supUser").empty();
		$("#con-supUser").append("<p>요청자 &nbsp;&nbsp; &nbsp;&nbsp;:&nbsp;</p> <input type='hidden' name='bookingId' value='"+ bk.bookingId +"'><p>" + bk.userName + "(" + bk.deptName + ")</p>");
		
		$("#con-sub-ass").empty();
		$("#con-sub-ass").append("<p>예약비품 :</p> &nbsp; <input type='hidden' name='subName' value='"+ bk.subName +"'> <p>"+ bk.subName + " / " + bk.assetsName + "</p>");
		
		$("#con-supTime").empty();
		$("#con-supTime").append("<p>예약시간</p>");
		if(bk.subName === "차량"){
			$("#con-supTime").append("<p>"+ bk.bkStartDate +" ~ " + bk.bkEndDate + "</p>");
		}else{
			$("#con-supTime").append("<p> - </p>");
		}
		
		$('#con-bkContent').prop('placeholder', bk.bkContent);
		
	}
	

	function supDetail(type,bk){
		
		if(type === 2){ // 반납
			$("#sup-reForm").attr('action', '${contextPath}/booking/supEnd.bk');
			$('#de-header').empty();
			
			$('#de-rejDiv').css('display', 'none');
			$('#de-return').css('display', 'block');
			$("#re-bkNo").val(bk.bookingNo);
			$("#de-bkContent").css('margin-bottom', '0');
			
			$('#sup-reForm button[type="button"].submit-btn').attr('type', 'submit').removeAttr('data-dismiss');
		}else{ 
			$("#sup-reForm").attr('action', '');
			
			$('#de-header').empty();
			$("#de-header").append("<h4>예약 상세</h4>");
			$('#de-return').css('display', 'none');
			$('#de-rejContent').prop('placeholder', bk.rejContent);
			$("#re-bkNo").val('');
			if(type === 3){ // 반려
				$('#de-rejDiv').css('display', 'block');
			}else{ // 상세
				$('#de-rejDiv').css('display', 'none');
				$("#de-bkContent").css('margin-bottom', '20px');
			}
			
			$('#sup-reForm button[type="submit"]').attr('type', 'button').attr('data-dismiss', 'modal');
		}
		
		
		$("#de-supUser").empty();
		$("#de-supUser").append("<p>요청자 &nbsp;&nbsp; &nbsp;&nbsp;:&nbsp;</p><p>" + bk.userName + "(" + bk.deptName + ")</p>");

		$("#de-sub-ass").empty();
		$("#de-sub-ass").append("<p>예약비품 :</p> &nbsp; <p>"+ bk.subName + " / " + bk.assetsName + "</p>");
		
		$("#de-supTime").empty();
		$("#de-supTime").append("<p>예약시간</p>");
		if(bk.subName === "차량"){
			$("#de-supTime").append("<p>"+ bk.bkStartDate +" ~ " + bk.bkEndDate + "</p>");
		}else{
			$("#de-supTime").append("<p> - </p>");
		}
		
		$('#de-bkContent').prop('placeholder', bk.bkContent);
		
	}
	</script>

</body>
</html>