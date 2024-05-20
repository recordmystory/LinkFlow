<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

/* 예약 상세 */
.ymd {
	display: flex;
	justify-content: space-between;
	align-items: center;
	/* padding-top: 10px; */
	margin-left: 10px;
}

.ass-detail {
	display: flex;
	align-items: center;
	margin-left: 20px;
}

.bk-head {
	display: flex;
	justify-content: flex-end;
	width: 92%;
	padding-left: 40px;
	padding-right: 10px;
}

.bk-detail {
	width: 90%;
	min-height: 600px;
	margin: 20px;
}

.bk-detailArea {
	background-color: white;
	border: 1px solid rgb(163, 161, 161);
	border-radius: 10px;
	padding: 40px;
}

.bk-content{
	border:0;
}

.form-control {
	text-align: center;
}

.coment {
	border: 1px solid rgb(47, 46, 46);
	border-radius: 3px;
}

.can-coment {
	border: none;
	border-bottom: 1px solid steelblue;
	width: 80%;
	height: 50px;
	margin-left: 20px;
}

.modal-body {
	margin-left: 10px;
}

.modal-mod-body {
	text-align: center;
	margin: 10px;
	font-size: 15px;
	padding-top: 8px;
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
							<h1 class="m-0">예약 상세</h1>
						</div>

					</div>
					</section>
					<!-- /.container-fluid -->
				<div class="" style="display: flex; flex-wrap: wrap;">
					<div class="bk-head">

						<div>
							<a class="btn bg-gradient-secondary" href="${ contextPath }/booking/mylist.bk">목록으로</a>
						</div>
					</div>
					<%
						// 현재 날짜와 시간 가져오기
						Date now = new Date();
						
						// 날짜 형식 지정
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
						
						// 현재 날짜를 문자열로 변환
						String today = dateFormat.format(now);
					%>
					<c:set var="todayArr" value="${fn:split(today, '/')}"/>
					
					<div class="bk-detail">
						<input type="hidden" name="bookingNo" value="${bk.bookingNo }" id="bookingNo">
					
						<div class="bk-detailArea">
							<div class="ymd" style="height:30px;">
								<div class="ymd">
									<c:set var="ymd" value="${bk.bkStartDate}" />
									<c:set var="ymdArr" value="${fn:split(ymd, '/')}" />
									<c:if test="${ not empty bk.bkStartDate}">
										<select id="year" name="year" class="form-control" style="width: 100px;">
											<option value="${ ymdArr[0] }">${ ymdArr[0] }</option>
											<c:if test="${ ymdArr[0] == 12 }">
												<option value="${ ymdArr[0] + 1 }">${ ymdArr[0] + 1}</option>
											</c:if>
										</select>&nbsp; 
									<select id="month" name="month" class="form-control" style="width: 80px;">
										<option value="${ ymdArr[1] }">${ ymdArr[1] }</option>
										<c:choose>
											<c:when test="${ymdArr[1] eq todayArr[1]}">
												<option value="0${ ymdArr[1] +1 }">0${ ymdArr[1] +1}</option>
											</c:when>
											<c:otherwise>
												<option value="0${ymdArr[1] -1}">0${ymdArr[1] -1}</option>
											</c:otherwise>
										</c:choose>
											<!-- 해당 월과 +1 월만 나오게 하기-->
									</select>&nbsp; 
									<select id="day" name="day" class="form-control" style="width: 80px;">
										<option value="${ ymdArr[2] }">${ ymdArr[2] }</option>
										<option value="${ ymdArr[2] +1 }">${ ymdArr[2] +1 }</option>
										<!-- 01~30 또는 31 까지 나오게 하기 -->
									</select>&nbsp;
									<p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp;
										</p>
										<select id="start" name="bkStartTime" class="form-control" style="width: 110px;">
											<option value="09:00">09:00</option>
											<option value="09:30">09:30</option>
											<option value="10:00">10:00</option>
											<option value="10:30">10:30</option>
											<option value="11:00">11:00</option>
											<option value="11:30">11:30</option>
											<option value="12:00">12:00</option>
											<option value="12:30">12:30</option>
											<option value="13:00">13:00</option>
											<option value="13:30">13:30</option>
											<option value="14:00">14:00</option>
											<option value="14:30">14:30</option>
											<option value="15:00">15:00</option>
											<option value="15:30">15:30</option>
											<option value="16:00">16:00</option>
											<option value="16:30">16:30</option>
											<option value="17:00">17:00</option>
											<!-- 09시부터 18시 까지-->
										</select>&nbsp; &nbsp; 
									<span>~</span> &nbsp; &nbsp; 
									<select id="end" name="bkEndTime" class="form-control" style="width: 110px;">
											<option value="10:00">10:00</option>
											<option value="10:30">10:30</option>
											<option value="11:00">11:00</option>
											<option value="11:30">11:30</option>
											<option value="12:00">12:00</option>
											<option value="12:30">12:30</option>
											<option value="13:00">13:00</option>
											<option value="13:30">13:30</option>
											<option value="14:00">14:00</option>
											<option value="14:30">14:30</option>
											<option value="15:00">15:00</option>
											<option value="15:30">15:30</option>
											<option value="16:00">16:00</option>
											<option value="16:30">16:30</option>
											<option value="17:00">17:00</option>
											<option value="17:30">17:30</option>
											<option value="18:00">18:00</option>
										</select>&nbsp;
								</c:if>
								</div>
								<div>
									<h5 style="margin-right: 20px;">${bk.status }</h5>
								</div>
							</div>
							<hr>
							<div class="ass-detail">
								<select id="ass-type" class="form-control " name="subName" style="width: 100px;" disabled>
									<option>${ bk.subName }</option>
								</select>&nbsp;
								<p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp; </p>
								<select id="ass-name" name="assetsName" class="form-control" style="width: 80px;">
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<!-- ass-type 에 따라 내용 바뀌게 -->
								</select>
							</div>

							<hr>
							<div style="margin: 40px;">
								<h4>사유</h4>
								<div class="coment" style="height: 150px;">
									<input type="text" id="bk-content" name="bkContent" value="${ bk.bkContent }" class="bk-content"></div>
							</div>
							<!-- 비고란에 값이 있을 때만 보여지는 영역 -->
							<hr>
							<div style="margin: 40px;">
								<h4>비고</h4>
								<div class="coment" style="height: 100px;">${ bk.rejContent }
								</div>
							</div>

						</div>
						<div class="md-btn" style="padding-top: 30px; float: right;">
							<c:if test="${bk.status eq '예약대기' }">
								<!-- 상태가 예약 대기일 때 보여질 수 있도록-->
								<button class="btn bg-gradient-primary" data-toggle="modal" data-target="#bk-mod">예약 수정</button>
								<button class="btn btn-default" data-toggle="modal" data-target="#bk-can">예약 취소</button>
							</c:if>
						</div>
					
					</div>
					<!-- /.card -->
				</div>
				<!-- /.content-wrapper -->
			</div>
		</div>
		<!-- /.content-wrapper -->
	</div>
	<!-- 예약 수정 -->
	<div class="modal fade" id="bk-mod">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예약 수정하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-mod-body">
					<p>예약 내용을 확인하였으며, 예약 상세 내용을 수정합니다.</p>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
					<button type="button" class="btn btn-outline-primary" onclick="bkUpdate();">&nbsp;OK&nbsp;</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- 예약 취소 모달-->
	<div class="modal fade" id="bk-can">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예약 취소하기</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="cancleBk" action="${contextPath }/booking/cancle.bk" method="post">
					<div class="modal-body">
						<h6>사유</h6>
						<input type="text" class="can-coment" name="bkContent" placeholder="취소 사유">
					</div>
						<input type="hidden" name="bookingNo" value="${ bk.bookingNo }">
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
	<script>
		function bkUpdate(){
			let year = document.getElementById('year').value;
			let month = document.getElementById('month').value;
			let day = document.getElementById('day').value;
			let bkStartDate = year +'/' +month+ '/'+ day;
			let bkStartTime = document.getElementById('start').value;
			let bkEndDate = year +'/' +month+ '/'+ day;
			let bkEndTime = document.getElementById('end').value;
			let assetsName = document.getElementById('ass-name').value;
			let bkContent = document.getElementById('bk-content').value;
			let bookingNo = document.getElementById('bookingNo').value;
			
			$.ajax({
				url:'${contextPath}/booking/modify.bk',
				type:'post',
				data:{
					bkStartDate:bkStartDate,
					bkStartTime:bkStartTime,
					bkEndDate:bkEndDate,
					bkEndTime:bkEndTime,
					assetsName:assetsName,
					bkContent:bkContent,
					bookingNo:bookingNo
				},success:function(bk){
					if(bk != null){
						alert('예약이 수정되었습니다.');
						window.location.href = '${contextPath}/booking/mylist.bk'
					}
				},error:function(){
					
				}
				
			})
		}
		
		$(document).ready(function(){
			 var todayArr = [<c:out value="${todayArr[0]}" />, <c:out value="${todayArr[1]}" />, <c:out value="${todayArr[2]}" />];
				    console.log(todayArr);
		})
	</script>


</body>
</html>