<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

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
/*공휴일 스타일*/
.holiday{
	background-color: transparent;
	border-color: transparent; /*투명화*/
	font-size: smaller; 
	font-weight: bolder; 
	margin-bottom: 5px;
	pointer-events: none;
	
}

.fc-daygrid-day-top, .holiday{
	/*position: absolute;
     top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); 중앙 정렬 */
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
                    right: 'dayGridMonth,timeGridWeek'
                },
                themeSystem: 'bootstrap',
                dayMaxEvents: true,
                eventMaxStack: 3,
                googleCalendarApiKey: 'AIzaSyABRUUYRcpsMexmdUBwypBZLh9Ft-8PgrA',
                events: function(info, successCallback, failureCallback) {
                    $.ajax({
                        url: '${contextPath}/booking/room.list',
                        type: 'get',
                        data:{ A:A, B:B, C:C },
                        dataType: 'json',
                        success: function(list) {
                        	console.log(list);
                            var events = [];
                            if (list != null) {
                                $.each(list, function(index, bk) {
                                    var event = {
                                        title: '',
                                        start: bk.bkStartDate + 'T' + bk.bkStartTime,
                                        end: bk.bkStartDate + 'T' + bk.bkEndTime,
                                        backgroundColor: '',
                                        borderColor: '',
                                        allDay: false
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
                eventSources: [
                    //공휴일 
                      {
                          googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
                          classNames: 'holiday',
                          textColor: 'rgba(190, 0, 50, 0.5)',
                          constraint: 'availableForMeeting'
                      }
                  ]
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