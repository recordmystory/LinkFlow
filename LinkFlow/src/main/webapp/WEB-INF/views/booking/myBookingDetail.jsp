<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
								<button class="btn bg-gradient-secondary">목록으로</button>
							</div>
						</div>
						<%--
						 <%
						    java.util.Date now = new java.util.Date();
						    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd");
						    String today = sdf.format(now);
						%>
						
						<!-- 문자열을 '/'로 나누어 배열로 변환 -->
						<c:set var="todayArr" value="${fn:split(today, '/')}"/> --%>
					    
						<div class="bk-detail">
							<div class="bk-detailArea">
								<div class="ymd" sytle="height:30px;">
									<div class="ymd">
									<c:set var="ymd" value="${bk.bkStartDate}" />
   									<c:set var="ymdArr" value="${fn:split(ymd, '/')}"/>
										<select id="year" class="form-control" style="width: 100px;">
											<option>${ ymdArr[0] }</option>
											<option>${ ymdArr[0] + 1}</option>
										</select>&nbsp; <select id="month" class="form-control"
											style="width: 80px;">
											<option>${ ymdArr[1] }</option>
											<c:choose>
												<c:when test="${ymdArr[1] == todayArr[1]}">
													<option>${ ymdArr[1] +1}</option>
												</c:when>
												<c:otherwise>
													<option>${ ymdArr[1] -1}</option>
												</c:otherwise>
											</c:choose>
										<!-- 해당 월과 +1 월만 나오게 하기-->
										</select>&nbsp; <select id="day" class="form-control"
											style="width: 80px;">
											<option>04</option>
											<option>05</option>
											<!-- 01~30 또는 31 까지 나오게 하기 -->
										</select>&nbsp;
										<p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp;
										</p>
										<select id="hour" class="form-control" style="width: 110px;">
											<option>09:00</option>
											<option>09:30</option>
											<option>10:00</option>
											<option>10:30</option>
											<!-- 09시부터 18시 까지-->
										</select>&nbsp; &nbsp; <span>~</span> &nbsp; &nbsp; <select id="minn"
											class="form-control" style="width: 110px;">
											<option>09:00</option>
											<option>09:30</option>
											<option>10:00</option>
											<option>10:30</option>
										</select>&nbsp;
									</div>
									<div>
										<h5 style="margin-right: 20px;">예약 대기</h5>
									</div>
								</div>
								<hr>
								<div class="ass-detail">
									<select id="ass-type" class="form-control "
										style="width: 100px;">
										<option>회의실</option>
										<option>차량</option>
									</select>&nbsp;
									<p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp;
									</p>
									<select id="ass-name" class="form-control" style="width: 80px;">
										<option>A</option>
										<option>B</option>
										<option>C</option>
										<!-- ass-type 에 따라 내용 바뀌게 -->
									</select>
								</div>

								<hr>
								<div style="margin: 40px;">
									<h4>사유</h4>
									<div class="coment" style="height: 150px;">
										${ bk.bkContent }
									</div>
								</div>
								<!-- 비고란에 값이 있을 때만 보여지는 영역 -->
								<hr>
								<div style="margin: 40px;">
									<h4>비고</h4>
									<div class="coment" style="height: 100px;" disabled>
										${ bk.rejContent }<c:out value="${todayArr}" />
									</div>
								</div>

							</div>
							<div class="md-btn" style="padding-top: 30px; float: right;">
								<!-- 상태가 예약 대기일 때 보여질 수 있도록-->
								<button class="btn bg-gradient-primary" data-toggle="modal"
									data-target="#bk-mod">예약 수정</button>
								<button class="btn btn-default" data-toggle="modal"
									data-target="#bk-can">예약 취소</button>
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
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-mod-body">
					<p>예약 내용을 확인하였으며, 예약 상세 내용을 수정합니다.</p>
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
				<div class="modal-body">
					<h6>사유</h6>
					<input type="text" class="can-coment" placeholder="취소 사유">
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


</body>
</html>