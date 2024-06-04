<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

/* 테이블 */
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

.caldiv {
	justify-content: center;
}

.mb-2 {
	padding-left: 30px;
	padding-top: 10px;
}

.calsection {
	width: 95%;
	justify-content: center;
	border: 0.5px solid lightgray;
	border-radius: 5px;
	padding-bottom: 20px;
	padding-top: 10px;
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
							<!-- <h1 class="m-0">&nbsp;</h1> -->
						</div>
					</div>
				</section>

				<!-- Main content -->
				<section class="content">
					<!-- /.container-fluid -->
					<div class="bk-table">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">예약 요청건</h3>

								<div class="card-tools">
									<div class="input-group input-group-sm" style="width: 100px;">
										<!-- <div class="card-btn">
                                            <button class="btn btn-outline-dark"> 완료목록</button>
                                        </div> -->
									</div>
								</div>
							</div>
							<!-- /.card-header -->
							<div class="card-body table-responsive p-0"
								style="height: 300px;">
								<table class="table table-head-fixed text-nowrap">
									<thead>
										<tr>
											<th style="width: 50px;">회의실</th>
											<th>요청자</th>
											<th>예약시간</th>
											<th>신청일</th>
											<th>설정</th>
										</tr>
									</thead>
									<tbody id="roomTable">
										
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.card -->
						<div class="modal fade" id="bk-result">
							<div class="modal-dialog">
								<div class="modal-content">
								<form id="roomConForm" action="${contextPath }/booking/upRoom.bk" method="post">
									<input type="hidden" name="bookingNo" id="room-bkNo">
									<div class="bk-modal" id="room-name" style="padding-top: 40px;">
										<p>예약 시설 :</p> &nbsp;
										<p>회의실A</p>
									</div>
									<div class="bk-modal bk-time" id="room-time">
										<p>예약 시간</p>
										<p>20204 / 04 / 25 14:00 ~ 16:00</p>
									</div>
									<div class="bk-modal" id="bkId">
										<p>요청자 :</p>
										&nbsp;
										<p>조성모(개발1팀)</p>
									</div>
									<div class="modal-body">
										<h6>사용 용도</h6>
										<input type="text" id="room-bkContent" class="can-coment" placeholder="부서 회의" disabled>
									</div>

									<!-- 승인일 때 -->
									<div class="bk-modal bk-content" id="roomCon">
                                        <h5>예약 내용을 확인하였으며, 예약을 승인합니다.</h5>
                                    </div>
									<!-- 반려일 때 -->
									<div class="modal-body" id="roomRej">
										<h6>반려 사유 </h6>
										<input type="text" class="rej-coment" name="rejContent" id="roomRejContent" placeholder=" 반려 사유">
									</div>

									<div class="modal-footer justify-content-between">
										<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
										<button type="submit" class="btn btn-outline-primary">&nbsp;OK&nbsp;</button>
									</div>
								</form>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->
					</div>
				</section>
				<!-- Content Header (Page header) -->
				
				<jsp:include page="/WEB-INF/views/booking/bookingCalendar.jsp" />
			</div>
		</div>

		<!-- /maincontent -->
		<script>
		$(document).ready(function(){
			
			selectRoomBk();
			
		})
		
		function selectRoomBk(){
			$.ajax({
				url: '${contextPath}/booking/roomWait.list',
				type:'get',
				success:function(result){
					let table = "";
					
					for(let i=0; i<result.length; i++){
						table += "<tr>"
							  + "<td>" + result[i].assetsName + "</td>"
							  + "<td>" + result[i].userName + "("+ result[i].deptName +")" + "</td>"
							  + "<td>" + result[i].bkStartDate + " " + result[i].bkStartTime + " ~ " + result[i].bkEndTime + "</td>"
							  + "<td>" + result[i].enrDate + "</td>"
							  + "<td><span data-toggle='modal' data-target='#bk-result' onclick='roomConfirm(1,"+ JSON.stringify(result[i]) + ")'>승인</span>"
							  + " |  <span data-toggle='modal' data-target='#bk-result' onclick='roomConfirm(2,"+ JSON.stringify(result[i]) + ")'>반려</span>"
							  + "</td></tr>";
					}
					
					$("#roomTable").html(table);
				}
			})
		}
		
		function roomConfirm(type,bk){
			$('#roomRejContent').val('');
			if(type === 1){ // 승인
				$('#roomCon').css('display', 'block');
				$('#roomRej').css('display', 'none');
				
				$('#roomRejContent').removeAttr('required');
				
			}else{ // 반려
				$('#roomRej').css('display', 'block');
				$('#roomCon').css('display', 'none');
				$('#roomRejContent').prop('placeholder',' 반려 사유');
				$('#roomRejContent').attr('required','required');
			}
			
			$("#room-bkNo").val(bk.bookingNo);
			
			$("#rommName").empty();
			$("#rommName").append("<p>예약 시설 :</p> &nbsp; <p> 회의실 " + bk.assetsName + "</p>");

			$("#bkId").empty();
			$("#bkId").append("<p>요청자 &nbsp;&nbsp; &nbsp;&nbsp;:&nbsp;</p><input type='hidden' name='bookingId' value='"+ bk.bookingId + "'><p>" + bk.userName + "(" + bk.deptName + ")</p>");
			
			$("#room-time").empty();
			$("#room-time").append("<p>예약 시간</p> <p>" + bk.bkStartDate + " " + bk.bkStartTime + " ~ " + bk.bkEndTime + "</p>");
			$('#room-bkContent').prop('placeholder', bk.bkContent);
			
		}
	
		</script>

	</div>

</body>
</html>