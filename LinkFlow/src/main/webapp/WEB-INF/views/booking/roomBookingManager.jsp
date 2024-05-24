<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my booking list</title>

<!-- jQuery UI -->
<script
	src="${contextPath }/resources/htmlTemplate/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- fullCalendar 2.2.5 -->
<script
	src="${contextPath }/resources/htmlTemplate/plugins/moment/moment.min.js"></script>
<script
	src="${contextPath }/resources/htmlTemplate/plugins/fullcalendar/main.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${contextPath }/resources/htmlTemplate/dist/js/demo.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath }/resources/htmlTemplate/plugins/fontawesome-free/css/all.min.css">
<!-- fullCalendar -->
<link rel="stylesheet"
	href="${contextPath }/resources/htmlTemplate/plugins/fullcalendar/main.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath }/resources/htmlTemplate/dist/css/adminlte.min.css">

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

/* 체크박스 */
input[type="checkbox"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 25px;
	height: 25px;
	border-radius: 50%;
	border: 2px solid #ccc;
}

.chex1:checked {
	background-color: #29ce17;
}

.chex2:checked {
	background-color: #f3d037;
}

.chex3:checked {
	background-color: #f0674b;
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
									<tbody>
										<tr>
											<td>A</td>
											<td>조성모(개발1팀)</td>
											<td>2024/04/25 14:00 ~ 16:00</td>
											<td>24/04/16 11:41:16</td>
											<td><span data-toggle="modal" data-target="#bk-result">승인</span>
												| <span data-toggle="modal" data-target="#bk-result">반려</span>
											</td>
										</tr>
										<tr>
											<td>C</td>
											<td>홍해인(인사팀)</td>
											<td>2024/04/25 14:00 ~ 16:00</td>
											<td>24/04/17 13:41:16</td>
											<td><span data-toggle="modal" data-target="#bk-result">승인</span>
												| <span data-toggle="modal" data-target="#bk-result">반려</span>
											</td>
										</tr>
										<tr>
											<td>A</td>
											<td>백현우(경영지원팀)</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-primary">Approved</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
										<tr>
											<td>B</td>
											<td>Mike Doe</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-danger">Denied</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
										<tr>
											<td>B</td>
											<td>Jim Doe</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-success">Approved</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
										<tr>
											<td>C</td>
											<td>Victoria Doe</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-warning">Pending</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
										<tr>
											<td>A</td>
											<td>Michael Doe</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-primary">Approved</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
										<tr>
											<td>C</td>
											<td>Rocky Doe</td>
											<td>11-7-2014</td>
											<td><span class="tag tag-danger">Denied</span></td>
											<td><a>승인</a> | <a>반려</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.card -->
						<div class="modal fade" id="bk-result">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="bk-modal" style="padding-top: 40px;">
										<p>예약 시설 :</p>
										<p>회의실A</p>
									</div>
									<div class="bk-modal bk-time">
										<p>예약 시간</p>
										<p>20204 / 04 / 25 14:00 ~ 16:00</p>
									</div>
									<div class="bk-modal">
										<p>요청자 :</p>
										&nbsp;
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
										<button type="button" class="btn btn-default"
											data-dismiss="modal">CANCEL</button>
										<button type="button" class="btn btn-outline-primary">&nbsp;OK&nbsp;</button>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->
					</div>
				</section>
				<!-- Content Header (Page header) -->
				<div class="calsection" style="background-color: white; width: 95%;">
					<section class="content-header">
						<div class="container-fluid">
							<div class="row mb-2">
								<!-- search attest -->
								<input type="checkbox" class="chex1" checked> &nbsp;회의실
								A &nbsp;&nbsp; <input type="checkbox" class="chex2" checked>
								&nbsp;회의실 B &nbsp;&nbsp; <input type="checkbox" class="chex3"
									checked> &nbsp;회의실 C
							</div>
						</div>
						<!-- /.container-fluid -->
					</section>

					<!-- Main content -->
					<section class="content">
						<div class="container-fluid">
							<div class="row caldiv">
								<div class="col-md-9">
									<div class="card card-primary">
										<div class="card-body p-0">
											<!-- THE CALENDAR -->
											<div id="calendar"></div>
										</div>
										<!-- /.card-body -->
									</div>
									<!-- /.card -->
								</div>
								<!-- /.col -->
							</div>
							<!-- /.row -->
						</div>
						<!-- /.container-fluid -->
					</section>

				</div>
			</div>
		</div>

		<!-- /maincontent -->
		<script>
			$(function() {

				/* initialize the external events
				 -----------------------------------------------------------------*/
				function ini_events(ele) {
					ele.each(function() {

						// create an Event Object (https://fullcalendar.io/docs/event-object)
						// it doesn't need to have a start or end
						var eventObject = {
							title : $.trim($(this).text())
						// use the element's text as the event title
						}

						// store the Event Object in the DOM element so we can get to it later
						$(this).data('eventObject', eventObject)

						// make the event draggable using jQuery UI
						$(this).draggable({
							zIndex : 1070,
							revert : true, // will cause the event to go back to its
							revertDuration : 0
						//  original position after the drag
						})

					})
				}

				// ini_events($('#external-events div.external-event'))

				/* initialize the calendar
				 -----------------------------------------------------------------*/
				//Date for the calendar events (dummy data)
				var date = new Date()
				var d = date.getDate(), m = date.getMonth(), y = date
						.getFullYear()

				var Calendar = FullCalendar.Calendar;
				var Draggable = FullCalendar.Draggable;

				// var containerEl = document.getElementById('external-events');
				// var checkbox = document.getElementById('drop-remove');
				var calendarEl = document.getElementById('calendar');

				// initialize the external events
				// -----------------------------------------------------------------

				var calendar = new Calendar(calendarEl, {
					headerToolbar : {
						left : 'prev,next today',
						center : 'title',
						right : 'dayGridMonth,timeGridWeek'
					},
					themeSystem : 'bootstrap',
					//Random default events
					events : [ {
						title : '4:00p 회의실C',
						start : new Date(y, m, 1, 16, 0),
						end : new Date(y, m, 1, 15, 0),
						backgroundColor : '#f56954', //red
						borderColor : '#f56954', //red
						allDay : true
					}, {
						title : '11:00a 회의실B',
						start : new Date(y, m, d - 1, 11, 0),
						end : new Date(y, m, d - 1, 13, 0),
						backgroundColor : '#f39c12', //yellow
						borderColor : '#f39c12', //yellow
						allDay : true
					}, {
						title : '4:00p 회의실C',
						start : new Date(y, m, d, 16, 0),
						end : new Date(y, m, d, 18, 0),
						backgroundColor : '#f56954', //red
						borderColor : '#f56954', //red
						allDay : true
					}, {
						title : '12:00a 회의실B',
						start : new Date(y, m, d, 12, 0),
						end : new Date(y, m, d, 14, 0),
						backgroundColor : '#f39c12', //yellow
						borderColor : '#f39c12', //yellow
						allDay : true
					}, {
						title : '2:00p 회의실A',
						start : new Date(y, m, d + 1, 14, 0),
						end : new Date(y, m, d + 1, 16, 0),
						allDay : true,
						backgroundColor : '#00a65a', //Success (green)
						borderColor : '#00a65a' //Success (green)
					},

					],
					editable : true,
					droppable : true, // this allows things to be dropped onto the calendar !!!
					drop : function(info) {
						// is the "remove after drop" checkbox checked?
						if (checkbox.checked) {
							// if so, remove the element from the "Draggable Events" list
							info.draggedEl.parentNode
									.removeChild(info.draggedEl);
						}
					}
				});

				calendar.render();
				// $('#calendar').fullCalendar()

				/* ADDING EVENTS */
				var currColor = '#3c8dbc' //Red by default
				// Color chooser button
				$('#color-chooser > li > a').click(function(e) {
					e.preventDefault()
					// Save color
					currColor = $(this).css('color')
					// Add color effect to button
					$('#add-new-event').css({
						'background-color' : currColor,
						'border-color' : currColor
					})
				})
				$('#add-new-event').click(function(e) {
					e.preventDefault()
					// Get value and make sure it is not null
					var val = $('#new-event').val()
					if (val.length == 0) {
						return

						

					}

					// Add draggable funtionality
					ini_events(event)

					// Remove event from text input
					$('#new-event').val('')
				})
			})
		</script>

	</div>

</body>
</html>