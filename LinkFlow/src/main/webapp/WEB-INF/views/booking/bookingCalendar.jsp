<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 시설/비품</title>

<style>
.fc-event-title{
	color:black;
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
	background-color: #d05ffc;
}

.chex3:checked {
	background-color: #f0674b;
}

.holiday {
	background-color: transparent;
	border-color: transparent; /*투명화*/
	font-size: smaller;
	font-weight: bolder;
	margin-bottom: 5px;
	pointer-events: none;
}
.holiday * {
	color:#e63c09!important;

}

.fc-day-sun a {
	color: red !important;
	text-decoration: none;
}

.fc-day-sat a {
	color: blue !important;;
	text-decoration: none;
}

.fc-daygrid-day-frame {
	position: relative;
}

.fc-daygrid-day-frame>div:nth-child(1), .fc-daygrid-day-frame>div:nth-child(2) {
	position: absolute;
	width: 100%;
	top: 0;
	left: 0;
}
.fc-daygrid-day-frame {
   position: relative;
   min-height: 100px !important; /* 테이블의 최소 높이 설정 */
}


</style>
</head>
<body>
<div class="calsection" style="background-color: white; width: 95%;">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <!-- search attest -->
                <input type="checkbox" class="chex1" checked name="A" onchange="roomCheck();"> &nbsp;회의실 A &nbsp;&nbsp;
                <input type="checkbox" class="chex2" checked name="B" onchange="roomCheck();"> &nbsp;회의실 B &nbsp;&nbsp;
                <input type="checkbox" class="chex3" checked name="C" onchange="roomCheck();"> &nbsp;회의실 C
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
    
    <script>
    
        function callCalendar(A,B,C) {
            var Calendar = FullCalendar.Calendar;
            var calendarEl = document.getElementById('calendar');

            var calendar = new Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                themeSystem: 'bootstrap',
                dayMaxEvents: true,
                eventMaxStack: 3,
                googleCalendarApiKey: 'AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE',
                events: function(info, successCallback, failureCallback) {
                    $.ajax({
                        url: '${contextPath}/booking/room.list',
                        type: 'get',
                        data:{ A:A, B:B, C:C },
                        dataType: 'json',
                        success: function(list) {
                            var events = [];
                            if (list != null) {
                                $.each(list, function(index, bk) {
                                    var event = {
                                        title: '',
                                        start: bk.bkStartDate + 'T' + bk.bkStartTime,
                                        end: bk.bkStartDate + 'T' + bk.bkEndTime,
                                        backgroundColor: '',
                                        borderColor: '',
                                        /* allDay: false */
                                    };
                                    if (bk.assetsName == "A") {
                                        event.title = '회의실A';
                                        event.backgroundColor = '#29ce17'; 
                                        event.borderColor = '#29ce17';
                                    } else if (bk.assetsName == "B") {
                                        event.title = '회의실B';
                                        event.backgroundColor = '#d05ffc'; 
                                        event.borderColor = '#d05ffc'; 
                                    } else {
                                        event.title = '회의실C';
                                        event.backgroundColor = '#f0674b'; 
                                        event.borderColor = '#f0674b'; 
                                    }
                                    events.push(event);
                                    
                                });
                            }
                            successCallback(events);
                        }
                    });
                },
                eventSources: [{
		                          googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
		                          classNames: 'holiday',
		                          constraint: 'availableForMeeting'
                      			
                }] 
            });
           
            calendar.render();
        }
        
        function roomCheck(){
        	let roomA = $(".chex1").prop("checked") ? "A" : "";
            let roomB = $(".chex2").prop("checked") ? "B" : "";
            let roomC = $(".chex3").prop("checked") ? "C" : "";
            
            callCalendar(roomA,roomB,roomC);
        }

        document.addEventListener('DOMContentLoaded', function () {

            roomCheck();
        });
    </script>
</div>
</body>
</html>