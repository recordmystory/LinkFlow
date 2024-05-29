<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
         
        document.addEventListener('DOMContentLoaded', function () {
     	    let roomA = $("#check1").prop("checked") ? "A" : "";
     	    let roomB = $("#check2").prop("checked") ? "B" : "";
     	    let roomC = $("#check3").prop("checked") ? "C" : "";
     	   
     	    $(function() {
     	        /* initialize the calendar
     	        -----------------------------------------------------------------*/
     	        // Date for the calendar events (dummy data)
     	        var date = new Date();
     	        var d = date.getDate(), m = date.getMonth(), y = date.getFullYear();

     	        var Calendar = FullCalendar.Calendar;
     	        var Draggable = FullCalendar.Draggable;

     	        // var containerEl = document.getElementById('external-events');
     	        var checkbox = document.getElementById('drop-remove');
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
     	            // Random default events
     	            events: function(info, successCallback, failureCallback) {
     	                $.ajax({
     	                    url: '${contextPath}/booking/room.list',
     	                    type: 'get',
     	                    dataType: 'json',
     	                    success: function(list) {
     	                        var events = [];
     	                        if (list != null) {
     	                            $.each(list, function(index, bk) {
     	                                if (bk.assetsName == "A") {
     	                                    events.push({
     	                                        title: '회의실A',
     	                                        start: bk.bkStartDate +'T'+ bk.bkStartTime,
     	                                        end: bk.bkStartDate +'T'+ bk.bkEndTime,
     	                                        backgroundColor: '#29ce17', // green
     	                                        borderColor: '#29ce17', // green
     	                                        allDay: true
     	                                    });
     	                                } else if (bk.assetsName == "B") {
     	                                    events.push({
     	                                        title: '회의실B',
     	                                        start: bk.bkStartDate +'T'+ bk.bkStartTime,
     	                                        end: bk.bkStartDate +'T'+ bk.bkEndTime,
     	                                        backgroundColor: '#f3d037', // yellow
     	                                        borderColor: '#f3d037', // yellow
     	                                        allDay: true
     	                                    });
     	                                } else {
     	                                    events.push({
     	                                        title: '회의실C',
     	                                        start: bk.bkStartDate +'T'+ bk.bkStartTime,
     	                                        end: bk.bkStartDate +'T'+ bk.bkEndTime,
     	                                        backgroundColor: '#f0674b', // red
     	                                        borderColor: '#f0674b', // red
     	                                        allDay: true
     	                                    });
     	                                }
     	                            });
     	                            console.log(events);
     	                        }
     	                        successCallback(events);
     	                    }
     	                });
     	            },
     	            editable: true,
     	            droppable: true, // this allows things to be dropped onto the calendar !!!
     	            drop: function(info) {
     	                // is the "remove after drop" checkbox checked?
     	                if (checkbox.checked) {
     	                    // if so, remove the element from the "Draggable Events" list
     	                    info.draggedEl.parentNode.removeChild(info.draggedEl);
     	                }
     	            }
     	        });

     	        calendar.render();
     	        // $('#calendar').fullCalendar()

     	        /* ADDING EVENTS */
     	        var currColor = '#3c8dbc'; // Red by default
     	        // Color chooser button
     	        $('#color-chooser > li > a').click(function(e) {
     	            e.preventDefault();
     	            // Save color
     	            currColor = $(this).css('color');
     	            // Add color effect to button
     	            $('#add-new-event').css({
     	                'background-color': currColor,
     	                'border-color': currColor
     	            });
     	        });

     	        $('#add-new-event').click(function(e) {
     	            e.preventDefault();
     	            // Get value and make sure it is not null
     	            var val = $('#new-event').val();
     	            if (val.length == 0) {
     	                return;
     	            }

     	            // Add draggable funtionality
     	            ini_events(event);

     	            // Remove event from text input
     	            $('#new-event').val('');
     	        });
     	    });
     	});
    </script>
</div>
</body>
</html>