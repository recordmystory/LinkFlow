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
  var calendar; //풀캠 밖에서도 사용 가능하게 전역변수 지정
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        calendar = new FullCalendar.Calendar(calendarEl, {
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
            timeZone: 'Asia/Seoul', //시간대 서울
            dayMaxEvents: true, 
            initialDate:  new Date(), //기준일
            navLinks: true, // 주/주말 이름을 클릭하여 뷰를 이동할 수 있음
            editable: true, // 이벤트를 드래그하여 이동할 수 있음
            selectable: true, // 날짜를 클릭하여 이벤트를 생성할 수 있음
            //more 갯수 제한
            views: {
                timeGrid: {
                     dayMaxEventRows: 5 //5개만 보이고 나머지는 more보이게
                
                }
            },
             eventClick: function(info) { //캘린더 메인에 있는 일정 클릭시에만 (나머지는 모달 버튼에 이벤트 걸어야함)
		            var event = info.event; 
		            var extendedProps = event.extendedProps;
		
		            //상세일정
		            schDetail(event.title, extendedProps);
		
		            // 일정 수정 폼 상세일정의 내용 끌어오기
		            schUpdateForm(event.title, extendedProps);
		        },
            eventSources: [
                //공휴일 
                {
                    googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
                    //backgroundColor: 'red', // 휴일 이벤트의 배경색을 빨간색으로 지정
                    //borderColor: 'black'
                    classNames: 'holiday',
                    textColor: 'rgba(190, 0, 50, 0.5)',
                    constraint: 'availableForMeeting' //일정 옮기지 못하게 제약조건 걸 때 필요
                },
                {
                     //특정 캘린더의 전체 일정 조회
                	events: function(info, success, error) {
                        var schCalSubCode = [];

                        if ($("#personalCalCheckbox").is(":checked")) {
                            schCalSubCode.push($("#personalCalCheckbox").val());
                        }
                        if ($("#departCalCheckbox").is(":checked")) {
                        	schCalSubCode.push($("#departCalCheckbox").val());
                        }
                        if ($("#companyCalCheckbox").is(":checked")) {
                        	schCalSubCode.push($("#companyCalCheckbox").val());
                        }

                        $.ajax({
                            url: "${contextPath}/calendar/schList.do",
                            type: "get",
                            traditional: true,
                            data: {
                                schCalSubCodes: schCalSubCode
                            },
                            success: function(result) {
                                var events = [];
                                for (var schCalSubCode in result) {
                                    if (result.hasOwnProperty(schCalSubCode)) {
                                        var calendarEvents = result[schCalSubCode];
                                        for (var i = 0; i < calendarEvents.length; i++) {
                                            var eventData = {
                                            				title: calendarEvents[i].schTitle, //풀캠 필수속성
                                                    start: calendarEvents[i].startDate, 
                                                    end: calendarEvents[i].endDate, 
                                                    color: calendarEvents[i].calColor, 
                                                    extendedProps: { // 사용자 정의 속성
                                                        schTitle: calendarEvents[i].schTitle,
                                                        schImport: calendarEvents[i].schImport,
                                                        schCalSubCode: calendarEvents[i].schCalSubCode,
                                                        address: calendarEvents[i].address,
                                                        notifyYn: calendarEvents[i].notifyYn,
                                                        schContent: calendarEvents[i].schContent,
                                                        schNo: calendarEvents[i].schNo,
                                                        calNo: calendarEvents[i].calNo

                                                    }
                                            };
                                            events.push(eventData);//addEvent로도 가능
                                        }
                                    }
                                }
                                
                                success(events);
                            },
                            error: function() {
                            }
                        });
                    }
                }
            ]
        });
        calendar.render();
    });
    //풀캘린더 
	 
    // 일정 상세 ******************
		function schDetail(title, extendedProps) {
		    $('#schDetailTitle').text(title);
		    $('#schImport').val(extendedProps.schImport);
		
		    var startDateChange = new Date(extendedProps.start);
		    var startDate = startDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		    });
		    $('#startDate').text(startDate);
		
		    var endDateChange = new Date(extendedProps.end);
		    var endDate = endDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		    });
		    $('#endDate').text(endDate === startDate ? '' : '~  ' + endDate);
		
		    $('#address').text(extendedProps.address);
		    $('#schDetailModal_content_text').text(extendedProps.schContent);
		
		    $('#schImport').prop('checked', extendedProps.schImport === 'Y');
		    $('#notifyYn').prop('checked', extendedProps.notifyYn === 'Y');
		
		    if (extendedProps.schCalSubCode == '03') {
		        $('#schCalSubCode').text('개인 캘린더');
		    } else if (extendedProps.schCalSubCode == '02') {
		        $('#schCalSubCode').text('부서 캘린더');
		    } else if (extendedProps.schCalSubCode == '01') {
		        $('#schCalSubCode').text('전사 캘린더');
		    }
		
		    $('#schDetailModal').modal('show');
		}
		    
    
    
		// 일정 수정 폼 ******************
		function schUpdateForm(title, extendedProps) {
		    $('.schDetailModal_blueBtn').click(function() {
		        $('#schUpdateModal').modal('show');

		        $('#schUpdateModal input[name="schTitle"]').val(title);
		        $('#schUpdateModal input[name="address"]').val(extendedProps.address);
		        $('#schUpdateModal textarea[name="schContent"]').val(extendedProps.schContent);
		        $('#schUpdateModal input[name="schImport"]').prop('checked', extendedProps.schImport === 'Y');
		        $('#schUpdateModal input[name="notifyYn"]').prop('checked', extendedProps.notifyYn === 'Y');
		        $('#schUpdateModal select[name="schCalSubCode"]').val(extendedProps.schCalSubCode).change();
		        $('#schUpdateModal input[name="schNo"]').val(extendedProps.schNo);
		        $('#schUpdateModal input[name="calNo"]').val(extendedProps.calNo);
		    });
		}
    
    //일정 삭제, 수정, 캘린더 체크박스 
		  $(document).ready(function() {
         // 일정 수정하기 모달에서 저장 버튼 클릭 시  ***************
			  $('#schUpdateButton').click(function() {
            var data = {
                calNo: $('#schUpdateModal input[name="calNo"]').val(),
                schNo: $('#schUpdateModal input[name="schNo"]').val(),
                schTitle: $('#schUpdateModal input[name="schTitle"]').val(),
                schImport: $('#schUpdateModal input[name="schImport"]').is(':checked') ? 'Y' : 'N',
                schCalSubCode: $('#schUpdateModal select[name="schCalSubCode"]').val(),
                startDate: $('#schUpdateModal input[name="startDate"]').val(),
                
                endDate: $('#schUpdateModal input[name="endDate"]').val(),
                address: $('#schUpdateModal input[name="address"]').val(),
                
                notifyYn: $('#schUpdateModal input[name="notifyYn"]').is(':checked') ? 'Y' : 'N',
                schContent: $('#schUpdateModal textarea[name="schContent"]').val()
            };

            $.ajax({
                type: "POST",
                url: "${contextPath}/calendar/updateSch.do",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "text",
                success: function(resultSch) {
                    if (resultSch === "success") {
                        $('#schUpdateModal').modal('hide');
                        alert("일정 수정 성공.");
                        calendar.refetchEvents();
                    } else {
                        alert("일정 수정 실패.");
                    }
                },
                error: function() {
                    alert("일정 수정 실패.");
                }
            });
        });

        // 일정 삭제
        $('#detailBtn').click(function() {
            var schNo = $('#schDetailModal input[name="schNo"]').val();
            $.ajax({
                url: "${contextPath}/calendar/deleteSch.do",
                type: "get",
                data: {
                    schNo: schNo
                },
                success: function(result) {
                    if (result === "success") {
                        alert("삭제 성공");
                        $('#schDetailModal').modal('hide');
                        calendar.refetchEvents();
                    } else {
                        alert("삭제 실패.");
                    }
                },
                error: function() {
                    alert("삭제 실패.");
                }
            });
        });

        // 개인캘린더, 부서캘린더, 전사캘린더 체크박스 클릭 시 일정 목록 조회
        $("#personalCalCheckbox, #departCalCheckbox, #companyCalCheckbox").change(function() {
       				 	//체크된게 있으면 리패치
            if ($("#personalCalCheckbox").is(":checked") || $("#departCalCheckbox").is(":checked") || $("#companyCalCheckbox").is(":checked")) {
                calendar.refetchEvents();
            } else {
                // 체크된게 하나도 없으면 공휴일 제외하고 삭제
                var events = calendar.getEvents();
                events.forEach(function(event) {
                    var extendedProps = event.extendedProps;
                    if (extendedProps.schCalSubCode === '03') {
                        event.remove();
                    } else if (extendedProps.schCalSubCode === '02' ) { 
                        event.remove();
                    } else if (extendedProps.schCalSubCode === '01' ) {
                        event.remove();
                    }
                });
            }
        });
    });

          
    
    
    
    
    
  /*  수정전*******************
  
  
  //풀캘린더 수정, 삭제
     $(document).ready(function() {

    	 // 현아띵 개인캘린더,부서캘린더,전사캘린더 체크박스 클릭시 일정 목록 조회
         $("#personalCalCheckbox, #departCalCheckbox, #companyCalCheckbox").change(function(){
         	addEventAndShow(); // 이벤트 불러오기
         });
   
    //
      $('#schUpdateButton').click(function() {
      	
      	  // 시작 날짜-밖
      	var selectedSchCalSubCode = $('#schUpdateModal select[name="schCalSubCode"]').val();
        var startDate1 = startDateChange.toISOString().slice(0, -8);
				var endDate1 = endDateChange.toISOString().slice(0, -8);
         var data = {
         		calNo: $('#calNo').val(),
             schNo: $('#schNo').val(),//임의의 정의 속성 schNo 불러오기 extendedProps
             schTitle: $('#schTitle').val(), 
             schImport: $('#schImport').is(':checked') ? 'Y' : 'N', 
             schCalSubCode: selectedSchCalSubCode,

             startDate: startDate1,
             endDate: endDate1,
             
             address: $('#address').val(), 
             notifyYn: $('#notifyYn').is(':checked') ? 'Y' : 'N', 
             schContent: $('#schContent').val() 
             
         };
         console.log('Data:', data);

         $.ajax({
             type: "POST",
             url: "${contextPath}/calendar/updateSch.do",
             data: JSON.stringify(data),
             contentType: "application/json",
             dataType: "text", // 현아띵 추가요
             success: function(resultSch) {
                 if (resultSch === "success") {
                     $('#schUpdateModal').modal('hide');
                     alert("일정 수정 성공.");

                 }
             },
             error: function(resultSch) {
             	if (resultSch === "fail") {
                 alert("일정 수정 실패.");
                 $('#schUpdateModal').modal('hide');

             	}
             }
         });
      });
  
    
    //일정 삭제**************************************************
      $('#detailBtn').click(function() {
      	$.ajax({
              
              url:"${contextPath}/calendar/deleteSch.do",
              type:"get", 
              data: {
              	schNo:event.extendedProps.schNo
              },  
              success:function(result){
              	 if (result === "success") {
               	 console.log(result);
                  alert("삭제 성공")

              	 }
               },  
              error:function(result){
              	if (result === "fail") {
                 console.log("일정 삭제 실패.");
                 alert("일정 삭제 실패.");
              	}
              }
           });                
        });
    });
	     */
              
                
    
    /* 
 
//캘린더 모달 이벤트 start -> 나중에 풀캠 스크립트 내부로 이동
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
		        } 
		        	||$(event.target).is('div.fc-event-title.fc-sticky'
		        	
		        
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

        /*$('#schUpdateButton').click(function() {
          alert("일정 수정 성공.");

        $('#schUpdateButton').click(function() {

          $('#schUpdateModal').modal('hide'); 
           // $('#schUpdateModal').modal('show');
           // $('body').addClass('overflow-hidden'); 
          alert("일정 수정 성공.");

        });

        $('#schDetailModal').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn').modal('show');
          $('#datailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 휴지통에서 복구 가능합니다.</p></div>');
          $('body').addClass('overflow-hidden');
        });

        $('#deleteBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
        });
        
   //일정 수정하기 모달 schUpdateModal
     /*  // schUpdateModal 닫힐 때
        $('.schInsertModalBtn').click(function() {
  	        $('#schInsertModal').modal('show');
  	        $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
  	    }); 

        // schUpdateModal 닫힐 때
        $('#schUpdateModal').on('hidden.bs.modal', function(e) {
              $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
        }); 
        
      //일정 수정하기 -> 취소버튼
        $('#schUpdateCancelBtn').click(function() {
            $('#schUpdateModal').modal('hide');
            $('#detailBtn').modal('hide'); 
						//새로고침 또는 캘린더 메인으로
						
          });
      }); 
    
      function addEventAndShow(){
      	var schCalSubCode = [];

          if ($("#personalCalCheckbox").is(":checked")) {
              schCalSubCode.push($("#personalCalCheckbox").val());
          }
          
          if ($("#departCalCheckbox").is(":checked")) {
          	schCalSubCode.push($("#departCalCheckbox").val());
          }
          
          if ($("#companyCalCheckbox").is(":checked")) {
          	schCalSubCode.push($("#companyCalCheckbox").val());
          }
          
          $.ajax({
              url: "${contextPath}/calendar/schList.do",
              type: "get",
              traditional: true,
              data: {
                  schCalSubCodes: schCalSubCode
              },
              contentType: "application/json",
              dataType: "json",
              success: function(result) {
                  for (var schCalSubCode in result) {
                      if (result.hasOwnProperty(schCalSubCode)) {
                          var calendarEvents = result[schCalSubCode];
                          for (var i = 0; i < calendarEvents.length; i++) {
                              var eventData = {
                              				title: calendarEvents[i].schTitle, //풀캠 필수속성
                                      start: calendarEvents[i].startDate, 
                                      end: calendarEvents[i].endDate, 
                                      color: calendarEvents[i].calColor, 
                                      extendedProps: { // 사용자 정의 속성
                                          schTitle: calendarEvents[i].schTitle,
                                          schImport: calendarEvents[i].schImport,
                                          schCalSubCode: calendarEvents[i].schCalSubCode,
                                          address: calendarEvents[i].address,
                                          notifyYn: calendarEvents[i].notifyYn,
                                          schContent: calendarEvents[i].schContent,
                                          schNo: calendarEvents[i].schNo,
                                          calNo: calendarEvents[i].calNo

                                      }
                              };
                              //events.push(eventData);//addEvent로도 가능
                              calendar.addEventSource(eventData);
                          }
                      }
                  }
                  
                  //successCallback(events);
                  calendar.refetchEvents();
              },
              error: function(result) {
                  failureCallback(result);
              	
              }
          });
		}
 	 */
	</script>
</body>
</html>