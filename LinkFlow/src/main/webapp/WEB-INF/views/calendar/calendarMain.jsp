<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 캘린더</title>

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

		  .fc-col-header-cell-cushion, .fc-daygrid-day-number{
		  color:rgba(55, 55, 56, 0.85) !important; 
		 
		 }
		 
		 .fc-scrollgrid-section.fc-scrollgrid-section-header {
		 	 background-color: rgba(150, 150, 150, 0.15) !important; 
		 }
		 
		 .fc-col-header-cell.fc-day.fc-day-sun,.fc-col-header-cell.fc-day.fc-day-sat{
		 		background-color: rgba(150, 150, 150, 0) !important; 
		 
		 }
		 
    .nav{
      font-weight: bold;
    }

    #cal_name {
      color: white;
      font-size: large;
    }

    .fc-day.fc-day-sat,
    .fc-day.fc-day-sun{
      background-color: rgba(30, 100, 1000, 0.1);
    }    

		.fc-day-other{
		     background-color: rgb(244, 246, 249) !important;
		
		}
    /*공휴일 스타일*/
    .holiday{
      background-color: transparent;
      border-color: transparent; /*투명화*/
      font-size: smaller; 
      font-weight: bolder; 
      text-align: end;
      margin-bottom: 5px;
			pointer-events: none;   
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
	
	/*캘인더메인에서 일반 일정 커서 포인더 설정*/
	.fc-event {
 	   cursor: pointer;
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
            //timeZone: 'Asia/Seoul', //시간대 
            //locale : 'ko',
            dayMaxEvents: true, //5
            initialDate:  new Date(), //기준일
            navLinks: true, // 주/주말 이름을 클릭하여 뷰를 이동
            editable: false, // 이벤트를 드래그하여 이동할 수 있음(막기)
            //selectable: true, // 날짜 클릭시 등록
            //more 갯수 제한
            views: {
                timeGrid: {
                     dayMaxEventRows: 5 //5개만 보이고 나머지는 more보이게
                }
            },
            displayEventTime: false,
            //중요일정, 전사 부서 개인 일정 순으로 정렬 //정렬
            eventOrder: function(a, b) {
            	
            	if(b.extendedProps.schCalSubCode == null){ 
            		return 1;
            	}else{
            		//중요일정일 때 a를 위로 //양수면 앞뒤 자리가 바뀌고 음수면 그대로 sort참고 
   	            if (a.extendedProps.schImport === 'Y' && b.extendedProps.schImport !== 'Y') {
   	                return -1; //a와 b를 비교해서 a>b이면 1이면 위치 그대로, a<b -1이면 a는 뒤로 넘어가서 자리가 바뀜
   	            } else if (a.extendedProps.schImport !== 'Y' && b.extendedProps.schImport === 'Y') {
   	                return 1;
   	            }
            	}
            	 
            	
	
            	//중요일정 없을 때
	            var order = {
	                '01': 1, // 전사일정
	                '02': 2, // 부서일정
	                '03': 3  // 개인일정
	            };
           	 return order[a.extendedProps.schCalSubCode] - order[b.extendedProps.schCalSubCode]; 
            },
            
						//중요일정 클릭시 클래스명 추가
      			eventDidMount: function(info) {
              if (info.event.extendedProps.schImport === 'Y') {
                 info.el.classList.add('important-event');
           	  	
              }  
	         	},
            eventClick: function(info) { //캘린더 메인에 있는 일정 클릭시에만 (나머지는 모달 버튼에 이벤트 걸어야함)
	            var event = info.event; 
	 						
            	if(event.url === ''){ //공휴일만 url 값이 있음. 공휴일 눌렀을 시 상세일정 실행 막기
	            //상세일정   
	            schDetail(event);
            	}
	            // 일정 수정 폼 상세일정의 내용 끌어오기
	            schUpdateForm(event);
	            
	            //공휴일 클릭시 링크 이동 막기(기본 이벤트 막기)
              info.jsEvent.preventDefault();

		        },
            eventSources: [
            	
              //공휴일 
                {
                    googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
                    //backgroundColor: 'red', // 휴일 이벤트의 배경색을 빨간색으로 지정
                    //borderColor: 'black'
                    classNames: 'holiday',
                    textColor: 'rgba(160, 50, 0, 0.45)',
                    constraint: 'holidayConstraint' //일정 옮기지 못하게 제약조건 걸 때 필요
               
                }
            ]
        });
        calendar.render();

    });
    //풀캘린더 
    
    // 넘겨받은 그룹코드의 일정들을 조회해서 캘린더에 뿌리는 역할의함수
     function addEventAndShow(code){
    	$.ajax({
          url: "${contextPath}/calendar/schList.do",
          type: "get",
          //traditional: true,
          data: {
              schCalSubCode: code
          },
          contentType: "application/json",
          dataType: "json",
          success: function(calendarEvents) { // [{일정}, {일정}]
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
                               schContent: calendarEvents[i].schContent,
                               schNo: calendarEvents[i].schNo,
                               calNo: calendarEvents[i].calNo,
															 modId: calendarEvents[i].modId
                           }
                   };
                   calendar.addEvent(eventData);
               }

          },
          error: function() {
          }
      });
		}
 
    // 일정 상세 ******************
		function schDetail(event) {
        var extendedProps = event.extendedProps;
        
        $('#schNo').val(extendedProps.schNo); //삭제에서 쓰기위해 저장
		    $('#schDetailTitle').text(event.title);
		    $('#schImport').val(extendedProps.schImport);
		    $('#schCalSubCode').val(extendedProps.schCalSubCode);
			
		    //날짜 텍스트로 형식 맞춰넣기 위한 처리
		    var startDateChange = new Date(event.start);
		    var startDate = startDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		        

		    });
		    $('#startDate').text(startDate);
		
		    
		    var endDateChange = event.end ? new Date(event.end) : null;
		    var endDate = endDateChange ? endDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		    }) : '';

		    // 같은 날짜인 경우 endDate를 표시하지 않음
		    $('#endDate').text(endDate && endDate !== startDate ? '~  ' + endDate : '');

		    
		    
		    $('#endDate').text(endDate === startDate ? '' : '~  ' + endDate);
		
		    $('#address').text(extendedProps.address);
		    $('#schDetailModal_content_text').text(extendedProps.schContent);
		
		    $('#schImport').prop('checked', extendedProps.schImport === 'Y');
		    $('#notifyYn').prop('checked', extendedProps.notifyYn === 'Y');
		
		    //캘린더명 처리
		    if (extendedProps.schCalSubCode == '03') {
		        $('#schCalSubCode').text('개인 캘린더');
		    } else if (extendedProps.schCalSubCode == '02') {
		        $('#schCalSubCode').text('부서 캘린더');
		    } else if (extendedProps.schCalSubCode == '01') {
		        $('#schCalSubCode').text('전사 캘린더');
		    }
		
		    //버튼 표시여부 처리(직급에 따라)
		    var spRight = '${loginUser.spRight}'; //전사
		    var deptRight = '${loginUser.deptRight}';//부서
		    var subCode = extendedProps.schCalSubCode;
		
		    if (spRight === 'Y' && subCode === '01' || subCode === '03' ) {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').show();
		    } else if (deptRight === 'Y' && subCode === '02' || subCode === '03') {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').show();
    		}else {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').hide();
		    }
		    
		    //공유일정 수정하기 버튼 막기
		     var userId = '${loginUser.userId}';
		     var modId = $('#modId').text(extendedProps.modId).text();		  
		     console.log(modId);

		     if (userId != modId) {
			     $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').hide();
			    }  
	       $('body').addClass('overflow-hidden'); 

		    $('#schDetailModal').modal('show');
		}
					 $('#schDetailModal').on('hidden.bs.modal', function(e) {
	            $('body').removeClass('modal-open'); 
	            $('body').removeClass('overflow-hidden');
	        });
    
		 // 캘린더 등록하기 (schInsertModal)***********************************************
	      //캘린더 일정등록 ajax
	     			//일정등록 클릭시 모달 띄우기
	     			 // 로그인 확인

	     	    var mod = '${loginUser.userId}'; 
	             $('input[name="modId"]').val(mod); 
	     	
	     	    // 일정 등록 버튼 클릭 시 모달 띄우기
	     	    if (mod === '') {
	     	            alert("일정을 등록하려면 로그인을 해 주세요.");
	     	            window.location.href = "${contextPath}/member/loginout.me"; // 로그인 페이지 경로로 이동
	     	    } else {
	     	        $('.schInsertModalBtn').click(function() {
	     	            $('#schInsertModal').modal('show');
	     	            $('body').addClass('modal-open'); 
	     	        });
	     	    }

	     		  // 중요일정 체크박스 클릭 시 조건
	     	    $('#schImportInsertBtn').click(function() {
	     	        var important = $(this).is(':checked') ? 'Y' : 'N';
	     	        $('input[name="schImport"]').val(important);
	     	    });
	     		  


	         	//등록 ajax
	        		 $('#schInsertButton').click(function() {
					    // 날짜 비교 시간까지 비교
					    var start = $('input[name="startDate"]').val();
					    var end = $('input[name="endDate"]').val();
					    var title = $('input[name="schTitle"]').val();
					
					    if (title === '') {
					        alert("제목을 입력하세요");
					        event.preventDefault();
					        return;
					    } else if (start >= end) {
					        alert("종료일이 시작일보다 같거나 작을 수 없습니다.");
					        event.preventDefault();
					        return;
					    }
					
					    $.ajax({
					        type: "POST",
					        url: "${contextPath}/calendar/regist.do",
					        data: $('#scheduleForm').serialize(),
					        success: function(result) {
					            if (result === "success") {
					                // 성공-  모달 닫기
					                console.log("일정 등록이 성공했습니다.");
					                alert("일정 등록이 성공했습니다.");
					                $("#schInsertModal").modal("hide");
					
					                var calColor;
					                var schCalSubCode = $('select[name="schCalSubCode"]').val();
					                if (schCalSubCode === '03') {
					                    calColor = '#358657c3';
					                } else if (schCalSubCode === '02') {
					                    calColor = '#104fa1c3';
					                } else if (schCalSubCode === '01') {
					                    calColor = '#a82626c3';
					                }
					
					                var eventData = {
					                    title: $('input[name="schTitle"]').val(),
					                    start: $('input[name="startDate"]').val(),
					                    end: $('input[name="endDate"]').val(),
					                    color: calColor,
					                    extendedProps: {
					                        schTitle: $('input[name="schTitle"]').val(),
					                        schImport: $('input[name="schImport"]').is(':checked') ? 'Y' : 'N',
					                        schCalSubCode: schCalSubCode,
					                        address: $('input[name="address"]').val(),
					                        schContent: $('textarea[name="schContent"]').val()
					                    }
					                };
					                checkboxReSelect();
					            }
					        },
					        error: function() {
					            console.error("일정 등록에 실패했습니다.");
					            alert("일정 등록에 실패했습니다.");
					        }
					    });
					});
	      //캘린더 일정등록 ajax end **************************************
	      

	   	  	//등록모달 -> 삭제버튼 클릭시
	   	    $('#cencelBtn').click(function() {
	          $('#schInsertModal').modal('hide');
	      	}); 
	   	  	
	   	// 캘린더 일정등록하기 모달이 닫힐 때
	   	 $('#schInsertModal').on('hidden.bs.modal', function (e) {
	   	     // 폼의 입력 필드 초기화
	   	     $('#scheduleForm')[0].reset();
	   	 });

	   	 // 캘린더 일정수정하기 모달이 닫힐 때
	   	 $('#schUpdateModal').on('hidden.bs.modal', function (e) {
	   	     // 폼의 입력 필드 초기화
	   	     $('#updateScheduleForm')[0].reset();
	   	 });

		// 일정 수정 폼 ******************
		function schUpdateForm(event) {
	      var extendedProps = event.extendedProps;

		    $('.schDetailModal_blueBtn').click(function() {
 	            $('body').addClass('modal-open'); 

		    	$('#schUpdateModal').modal('show');

		        $('#schUpdateModal input[name="schTitle"]').val(event.title);
		        $('#schUpdateModal input[name="address"]').val(extendedProps.address);
		        $('#schUpdateModal textarea[name="schContent"]').val(extendedProps.schContent);
		        $('#schUpdateModal input[name="schImport"]').prop('checked', extendedProps.schImport === 'Y');
		        $('#schUpdateModal select[name="schCalSubCode"]').val(extendedProps.schCalSubCode).change();
		        $('#schUpdateModal input[name="schNo"]').val(extendedProps.schNo);
		        $('#schUpdateModal input[name="calNo"]').val(extendedProps.calNo);
		      //  var startDate = new Date(event.start).toISOString().slice(0, 16);
		        //var endDate = event.end ? new Date(event.end).toISOString().slice(0, 16) : startDate;

		        $('#schUpdateModal input[name="startDate"]').val(startDate);
		        $('#schUpdateModal input[name="endDate"]').val(endDate);
		        console.log("schNo:", extendedProps.schNo);
		    });
		}
	
		//중복제거 및 재조회(insert용)
		function checkboxReSelect() {
		    // 추가된 일정 바로 추가 + 다른 모달에 영향끼지치않도록 재조회
		    var calSubCode = $('select[name="schCalSubCode"]').val();
		    var events = calendar.getEvents();
		    var changeCheckboxVal = $(".calCheckbox").val();

		    // 중복일정 제거 및 재조회
		    events.forEach(function(event) {
		        // 체크박스가 선택되지 않았을 때
		        if (!$(".calCheckbox").is(":checked")) {
		            // 현재 캘린더 코드와 일정의 서브 코드가 일치할 경우 해당 일정 제거
		            if (event.extendedProps.schCalSubCode === calSubCode) {
		                event.remove(); // 중복되는 일정 제거
		            }
		        } else {
		            // 체크박스가 선택된 경우
		            if (event.extendedProps.schCalSubCode === calSubCode) {
		                event.remove(); // 중복되는 일정 제거
		            }
		        }
		    });

		    // 체크박스가 선택된 경우만 일정 추가
		    if ($(".calCheckbox").is(":checked")) {
		        addEventAndShow(calSubCode);  
		    }

		    // 일정 공유 값 비우기
		    $('#schShareModal .referenceArea').empty();
		}
		
    //일정 삭제, 수정, 캘린더 체크박스 
	  	  //일정 수정하기 모달 클릭시 more과 곂치지않도록 조정
        $('#schDetailModal').on('show.bs.modal', function() {
        	 $('.fc-popover').css({
        	        'z-index': '-1',
        	        'position': 'relative'
        	    });
	  	  });
			  
     
    
     // 일정 수정하기 모달에서 저장 버튼 클릭 시  ***************
        $('#schUpdateButton').click(function() {
        	var shareIds = $('#shareIds').val().split(',');
            if (shareIds.length === 1 && shareIds[0] === '') {
                shareIds = null;
            }
	        	
            var data = {
                calNo: $('#schUpdateModal input[name="calNo"]').val(),
                schNo: $('#schUpdateModal input[name="schNo"]').val(),
                schTitle: $('#schUpdateModal input[name="schTitle"]').val(),
                schImport: $('#schUpdateModal input[name="schImport"]').is(':checked') ? 'Y' : 'N',
                schCalSubCode: $('#schUpdateModal select[name="schCalSubCode"]').val(),
                startDate: $('#schUpdateModal input[name="startDate"]').val(),
                endDate: $('#schUpdateModal input[name="endDate"]').val(),
                address: $('#schUpdateModal input[name="address"]').val(),
                schContent: $('#schUpdateModal textarea[name="schContent"]').val(),
                shareIds: shareIds
            };
           
            
            if (data.schTitle === '') {
                alert("제목을 입력하세요");
                event.preventDefault();
                return; 
            } else if (data.startDate >= data.endDate) {
	              alert("종료일이 시작일보다 같거나 작을 수 없습니다.");
	              return; 
	          }
            
            $.ajax({
                type: "POST",
                url: "${contextPath}/calendar/updateSch.do",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function(resultSch) {
                    if (resultSch === "success") {
                        alert("일정 수정 성공.");

                        $('#schUpdateModal').modal('hide');
                        $('#schDetailModal').modal('hide');
                        $('.NameArea').val('');

                    } 
                    var events = calendar.getEvents();
                    events.forEach(function(event) {
                        if (event.extendedProps.schNo == data.schNo) {
                            event.setProp('title', data.schTitle);
                            event.setStart(data.startDate);
                            event.setEnd(data.endDate);
                            event.setExtendedProp('address', data.address);
                            event.setExtendedProp('schContent', data.schContent);
                            event.setExtendedProp('schImport', data.schImport);
                            event.setExtendedProp('schCalSubCode', data.schCalSubCode);

                            var calColor;
                            if (data.schCalSubCode === '03') {
                                calColor = '#358657c3';
                            } else if (data.schCalSubCode === '02') {
                                calColor = '#104fa1c3';
                            } else if (data.schCalSubCode === '01') {
                                calColor = '#a82626c3';
                            }
                            event.setProp('color', calColor);
                        }
                    });
                },
                error: function() {
                    console.log("일정 수정 실패.");
                }
            });
        });


  
    		//수정모달에서 취소 클릭시
			  $('#schUpdateCancelBtn').click(function() {
           $('#schUpdateModal').modal('hide');
			  });
		
		    
    // 일정 삭제 *******************************
    	//삭제모달 html text
        $('.schDetailModal_grayBtn').click(function() {
        	
          $('#detailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 휴지통에서 복구 가능합니다.</p></div>');
        });
    
    	//삭제모달에서 삭제 버튼 클릭시 
        $('#schDeleteBtn').click(function() {
        
        	var schNo = $('#schNo').val(); 
        	
            $.ajax({
                url: "${contextPath}/calendar/deleteSch.do",
                type: "get",
                data: {
                    schNo: schNo
                },
                success: function(result) {
                    console.log("success:", result);

                    if (result === "success") {
                        alert("일정 삭제 성공");
                        $('#schDetailModal').modal('hide');
                        $('#detailBtn').modal('hide');
                        
                        //선택 일정만 삭제
                        var events = calendar.getEvents(); 
                        events.forEach(function(event) {
                        	event.extendedProps.schNo == schNo && event.remove();
                        });         
                        
                    } else {
                        alert("일정 삭제 실패.");
                    }
                },
                error: function(result) {
                	if (result === "fail") {
                        $('#schDetailModal').modal('hide');
                        
                    } 
                }
            });
        });
    
	
		  // 중요일정 체크박스 클릭 시 조건
	    $('#schImportInsertBtn').click(function() {
	        var important = $(this).is(':checked') ? 'Y' : 'N';
	        $('input[name="schImport"]').val(important);
	        var mod = '${loginUser.userId}'; 
	        $('input[name="modId"]').val(mod); 
	        
	        // 일정 등록 버튼 클릭 시 모달 띄우기
	        if (mod === '') {
	            alert("일정을 등록하려면 로그인을 해 주세요.");
	            window.location.href = "/linkflow/member/loginout.me"; // 로그인 페이지 경로로 이동
	        } else {
	                $('#schInsertModal').modal('show');
	                $('body').addClass('modal-open'); 
	        }

	    });
		  
      //삭제모달에서 취소버튼 클릭시
      $('#schDeleteCancelBtn').click(function() {
          $('#detailBtn').modal('hide');
          $('body').removeClass('overflow-hidden');

      });

    // 개인캘린더, 부서캘린더, 전사캘린더 체크박스 클릭 시 일정 목록 조회
       $(".calCheckbox").change(function() {
       	
       		var changeCheckboxVal = $(this).val();
           if($(this).is(":checked")) {
           	addEventAndShow($(this).val());
           }else { // 체크해제일 경우
           	
               var events = calendar.getEvents(); // 현재보여지는 모든 일정을 다 가져오고 
               
               events.forEach(function(event) {
  
               	event.extendedProps.schCalSubCode == changeCheckboxVal && event.remove();
               });
               
           }
       });
    
 
   

          
 	 
	</script>
</body>
</html>