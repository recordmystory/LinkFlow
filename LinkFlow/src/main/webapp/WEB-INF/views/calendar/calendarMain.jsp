<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendarMain</title>

	<!-- fullcalendar CDN -->  
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
	<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>


	<style>
   

     /*풀캘린더 style */
    #calendar {
      max-width: 90%;
      margin: auto;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;

    }

    .nav{
      font-weight: bold;
    }

    #cal_name {
      color: white;
      font-size: large;
    }

    .fc-day.fc-day-sat.fc-day-past.fc-daygrid-day,
    .fc-day.fc-day-sun.fc-day-past.fc-daygrid-day{
     background-color: rgba(236, 224, 232, 0.515);

    }    

    /*공휴일 스타일*/
    .holiday{
      background-color: transparent;
      border-color: transparent; /*투명화*/
      font-size: smaller; 
      font-weight: bolder; 
      text-align: end;
      margin-bottom: 5px;
    }

    /*휴지통 스타일*/
    
   .blue-button{
    background-color: rgba(5, 93, 209, 0.903) !important; 
    border: rgba(5, 93, 209, 0.903); 
    
   }
   
   .gray-button{
    background-color: gray !important; 
    border: gray;
    
   }
   
   .blue-button, .gray-button{
    display: flex;
    text-align: center;
    justify-content: center;
    color:white !important; 
   }
   

    /*상세 정보 모달 스타일*/

    .schDetailModal_content > div,
    .search, .schDetailModal_content > textarea, 
    .schDetailModal_content > form {
      margin:auto;
   }

   </style>

    

</head>
<body>
<div class="wrapper">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="LinkFlowMainSection">
	            
	   <jsp:include page="/WEB-INF/views/common/sidebar/calendar/calendarSidebar.jsp"/>
	   
	    
	    <!-- 캘린더 header start -->
	    <div class="LinkFlowMainContent">
	      <section class="content-header">
	        <div class="row mb-2">
	          <div class="col-sm-6">
	              <h1 class="m-0 mx-5">캘린더</h1>
	          </div>
	    
	        </div>
	       <!-- /.container-fluid -->
	      </section>
	       <!-- 캘린더 header end -->
	
	        <!-- 캘린더 Main content start -->
	       <section class="content">
	         <div class="container-fluid"> 
	           <div id='calendar' style="margin-right: 100px;"></div>  
	         </div>
	       </section>
	            <!-- /캘린더 Main content end -->
	     </div>
	        <!-- /.content-wrapper -->
                
     </div>
    </div>
    

    
    
    
    
    
        	<jsp:include page="/WEB-INF/views/calendar/include/calendarModal.jsp"/>
    
    <script>

  //풀캘린더 script start
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
            },
            //부트스트랩 more팝오버 
            initialView: 'dayGridMonth', //월간뷰 기본값
            moreLinkClick: "popover",
            //구글api로 공휴일 가져오기
            googleCalendarApiKey: 'AIzaSyABRUUYRcpsMexmdUBwypBZLh9Ft-8PgrA',
            timeZone: 'Asia/Seoul', //시간대 -확인
            dayMaxEvents: true, 
            initialDate: '2023-01-12', //기준일
            navLinks: true, // 주/주말 이름을 클릭하여 뷰를 이동할 수 있음
            editable: true, // 이벤트를 드래그하여 이동할 수 있음
            selectable: true, // 날짜를 클릭하여 이벤트를 생성할 수 있음
            //more 갯수 제한
            views: {
                timeGrid: {
                    dayMaxEventRows: 5 // adjust to 6 only for timeGridWeek/timeGridDay
                }
            },
            eventClick: function(info) {
                // prevent browser from following the link
                info.jsEvent.preventDefault();
            },
            eventSources: [
                //공휴일 이벤트
                {
                    googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
                    //backgroundColor: 'red', // 휴일 이벤트의 배경색을 빨간색으로 지정
                    //borderColor: 'black'
                    //className지정가능 ->알아보기
                    classNames: 'holiday',
                    textColor: 'rgba(190, 0, 50, 0.5)',
                    constraint: 'availableForMeeting' 
                },
                {
                     //일정 이벤트
                    events: function(info, successCallback, failureCallback) {
                        var checkedCalendars = []; 
                        
                     // 개인 
                        if ($("#personalCalCheckbox").is(":checked")) {
                            checkedCalendars.push($("#personalCalCheckbox").val());
                        }

                        // 부서 
                        if ($("#departCalCheckbox").is(":checked")) {
                            checkedCalendars.push($("#departCalCheckbox").val());
                        }

                        // 회사 
                        if ($("#companyCalCheckbox").is(":checked")) {
                            checkedCalendars.push($("#companyCalCheckbox").val());
                        }

                        $.ajax({
                            url: "${contextPath}/calendar/schList.do", 
                            type: "get",
                            data: {
                            		schCalSubCode: checkedCalendars.join(",")// 배열을 콤마로 구분된 문자열로 변환하여 전달  
                            },                          
                            success: function(result) {
                                var events = [];
                                for (var i = 0; i < result.length; i++) {
                                    var eventData = {
                                        title: result[i].schTitle,
                                        start: result[i].startDate,
                                        end: result[i].endDate,
                                        color: result[i].calColor
                                    };
                                    events.push(eventData);
                                }
                                successCallback(events);
                            },
                            error: function(result) {
                                console.error("일정 조회 오류"); 
                                failureCallback(result);
                            }
                        });
                    } 
                }
            ]
        });
        calendar.render();
    });
    //풀캘린더 

	 
	 
	 

 
//캘린더 모달 이벤트 start
      $(document).ready(function() {
		    // 상세 모달
		    $('.fc-daygrid-day-events').click(function(event) {
		        	/* if (!$(this).hasClass('div.fc-event-title-container')) {
		        	// 장기 일정
		            $('#schDetailModal').modal('show');
		        } else if ($(event.target).is('div.fc-daygrid-event-harness')) {
		            // 단일 일정
		            $('#schDetailModal').modal('show');
		        } else if ($(event.target).is('a.fc-daygrid-more-link.fc-more-link')) {
		            event.preventDefault(); // 모달 이벤트 막기
		        } */
		    	if ($(event.target).is('a.fc-daygrid-more-link.fc-more-link')) {
		            $('#schDetailModal').modal('hide'); 
	        } else{
		            $('#schDetailModal').modal('show');
	
	   			}
				 });
			


        $('#schDetailModal').on('show.bs.modal', function(e) {
            $('body').addClass('modal-open'); // 바디에 modal-open 클래스 추가
        });

    // schDetailModal이 닫힐 때
        $('#schDetailModal').on('hidden.bs.modal', function(e) {
            $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
        });

    //schDetailModals에서 detailBtn 클릭시(schUpdateModal수정 detailBtn모달과 삭제 모달로 이동)
        $('.schDetailModal_blueBtn').click(function() {
          $('#schDetailModal').modal('hide'); 
            $('#schUpdateModal').modal('show');
            $('body').addClass('overflow-hidden');   
        });

        $('.schDetailModal_grayBtn').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn').modal('show');
          $('#detailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 휴지통에서 복구 가능합니다.</p></div>');
          $('body').addClass('overflow-hidden');
        });

        $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
        });
        
  //일정 수정하기 모달 schUpdateModal
      // schUpdateModal 닫힐 때
        $('#schUpdateModal').on('hidden.bs.modal', function(e) {
            $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
        });

        // schUpdateModal 닫힐 때
        $('#schUpdateModal').on('hidden.bs.modal', function(e) {
              $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
        });
      });

    	 

	</script>
</body>
</html>