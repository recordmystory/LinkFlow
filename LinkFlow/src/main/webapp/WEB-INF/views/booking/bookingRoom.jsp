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
<script src="${contextPath }/resources/htmlTemplate/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- fullCalendar 2.2.5 -->
<script src="${contextPath }/resources/htmlTemplate/plugins/moment/moment.min.js"></script>
<script src="${contextPath }/resources/htmlTemplate/plugins/fullcalendar/main.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${contextPath }/resources/htmlTemplate/dist/js/demo.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/fontawesome-free/css/all.min.css">
<!-- fullCalendar -->
<link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/fullcalendar/main.css">
<!-- Theme style -->
<link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/dist/css/adminlte.min.css">

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
    min-height:900px;
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
		<jsp:include page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />
			<div class="LinkFlowMainContent">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <!-- <h1 class="m-0">&nbsp;</h1> -->
                        </div>
                    </div>
                </section>
                <div class="calsection" style="background-color: white; width: 95%;">
                    <section class="content-header">
                        <div class="container-fluid">
                            <div class="row mb-2">
                                <!-- search attest -->
                                <input type="checkbox" class="chex1" checked> &nbsp;회의실 A &nbsp;&nbsp;
                                <input type="checkbox" class="chex2" checked> &nbsp;회의실 B &nbsp;&nbsp;
                                <input type="checkbox" class="chex3" checked> &nbsp;회의실 C
                            </div>
                        </div><!-- /.container-fluid -->
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
                        </div><!-- /.container-fluid -->
                    </section>
                    <!-- /.content -->
                </div>
            </div>
            <!-- /maincontent -->
         <script>
         
         document.addEventListener('DOMContentLoaded', function () {
             $(function () {
                 var request = $.ajax({
                     url: '${contextPath}/booking/room.list', // 변경하기
                     method: "GET",
                     
                     dataType: "json"
                 });
  
                 request.done(function (data) {
                     console.log(data); // log 로 데이터 찍어주기.
  
                     var calendarEl = document.getElementById('calendar');
  
                     var calendar = new FullCalendar.Calendar(calendarEl, {
                         initialDate: '2022-02-07',
                         initialView: 'timeGridWeek',
                         headerToolbar: {
                             left: 'prev,next today',
                             center: 'title',
                             right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                         },
                         editable: true,
                         droppable: true, // this allows things to be dropped onto the calendar
                         drop: function (arg) {
                             // is the "remove after drop" checkbox checked?
                             if (document.getElementById('drop-remove').checked) {
                                 // if so, remove the element from the "Draggable Events" list
                                 arg.draggedEl.parentNode.removeChild(arg.draggedEl);
                             }
                         },
                         /**
                          * data 로 값이 넘어온다. log 값 전달.
                          */
                         events: data
                     });
  
                     calendar.render();
                 });
  
                 request.fail(function( jqXHR, textStatus ) {
                     alert( "Request failed: " + textStatus );
                 });
             });
  
         });

         
         
         
         	$(function () {

                  /* initialize the external events
                   -----------------------------------------------------------------*/
            	function ini_events(ele) {
                	ele.each(function () {

                    // create an Event Object (https://fullcalendar.io/docs/event-object)
                    // it doesn't need to have a start or end
                    var eventObject = {
                        title: $.trim($(this).text()) // use the element's text as the event title
                    }

                    // store the Event Object in the DOM element so we can get to it later
                    $(this).data('eventObject', eventObject)

                    // make the event draggable using jQuery UI
                    $(this).draggable({
                        zIndex: 1070,
                        revert: true, // will cause the event to go back to its
                        revertDuration: 0  //  original position after the drag
                    })

                })
            }

            // ini_events($('#external-events div.external-event'))

            /* initialize the calendar
             -----------------------------------------------------------------*/
            //Date for the calendar events (dummy data)
            var date = new Date()
            var d = date.getDate(),
                m = date.getMonth(),
                y = date.getFullYear()

            var Calendar = FullCalendar.Calendar;
            var Draggable = FullCalendar.Draggable;

            // var containerEl = document.getElementById('external-events');
            // var checkbox = document.getElementById('drop-remove');
            var calendarEl = document.getElementById('calendar');

            // initialize the external events
            // -----------------------------------------------------------------

            var calendar = new Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek'
                },
                themeSystem: 'bootstrap',
                //Random default events
                events: [
                    {
                        title: '4:00p 회의실C',
                        start: new Date(y, m, 1, 16, 0),
                        end: new Date(y, m, 1, 15, 0),
                        backgroundColor: '#f56954', //red
                        borderColor: '#f56954', //red
                        allDay: true
                    },
                    {
                        title: '11:00a 회의실B',
                        start: new Date(y, m, d - 1, 11, 0),
                        end: new Date(y, m, d - 1, 13, 0),
                        backgroundColor: '#f39c12', //yellow
                        borderColor: '#f39c12', //yellow
                        allDay: true
                    },
                    {
                        title: '4:00p 회의실C',
                        start: new Date(y, m, d, 16, 0),
                        end: new Date(y, m, d, 18, 0),
                        backgroundColor: '#f56954', //red
                        borderColor: '#f56954', //red
                        allDay: true
                    },
                    {
                        title: '12:00a 회의실B',
                        start: new Date(y, m, d, 12, 0),
                        end: new Date(y, m, d, 14, 0),
                        backgroundColor: '#f39c12', //yellow
                        borderColor: '#f39c12', //yellow
                        allDay: true
                    },
                    {
                        title: '2:00p 회의실A',
                        start: new Date(y, m, d + 1, 14, 0),
                        end: new Date(y, m, d + 1, 16, 0),
                        allDay: true,
                        backgroundColor: '#00a65a', //Success (green)
                        borderColor: '#00a65a' //Success (green)
                    },

                ],
                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar !!!
                drop: function (info) {
                    // is the "remove after drop" checkbox checked?
                    if (checkbox.checked) {
                        // if so, remove the element from the "Draggable Events" list
                        info.draggedEl.parentNode.removeChild(info.draggedEl);
                    }
                },
                views:{
                	timeGrid:{
                		
                	}
                }
            });

            calendar.render();
            // $('#calendar').fullCalendar()

            /* ADDING EVENTS */
            var currColor = '#3c8dbc' //Red by default
            // Color chooser button
            $('#color-chooser > li > a').click(function (e) {
                e.preventDefault()
                // Save color
                currColor = $(this).css('color')
                // Add color effect to button
                $('#add-new-event').css({
                    'background-color': currColor,
                    'border-color': currColor
                })
            })
            $('#add-new-event').click(function (e) {
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
	</div>

</body>
</html>