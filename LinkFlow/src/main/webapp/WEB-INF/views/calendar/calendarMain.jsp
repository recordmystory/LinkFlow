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
	<!-- 지도 api -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dffz3x1msk&submodules=geocoder"></script>
	

	<style>
    .wrapper{
      min-height: 100%;
      width: 100%;
   }
  .LinkFlowMainSection{
      width: 100%;
      min-height: 1500px;
     
      display: flex;
    
  }
  .LinkFlowMainContent{
      width: 100%;
      min-width: 1260px;
      background-color: #f4f6f9;
      min-height: 400px;
      padding: 30px;
  }
  .contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
  .contentArea{ 
   width: 100%;
  }
  
  .dmovePage .slimMenu {
     padding: .0rem 0rem;
   }

 /*여기까지 메인 영역 요소  공용 스타일임 */

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
     .bin_list_table td, .bin_list_table th{
      text-align: center;
      vertical-align: middle;
      font-size: small;
    }
     .dataTables_filter {
      float: right;
      margin-bottom: 5px;
    }

    /*휴지통 상세 정보 모달 스타일*/
    .schDetailModal_content, .modal-content{
      display: flex;
      justify-content: center;
      text-align: center;
      margin: 0px 0px 20px 10px;
    }

    .modal-title{
      margin-left: 20px;
      display: flex;
      text-align: center;
      justify-content: center;
    }

    .schDetailModal_content > div,
    .search, .schDetailModal_content > textarea, 
    .schDetailModal_content > form {
      margin:auto;
   }

    #schDetailModal_content_text{
      max-width: 300px;
    }

    #detailBtn-modal-body{
      font-size: large;
      font-weight: bolder;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      height: 350px;
    }
    

    /*공유캘린더 목록 모달창 스타일*/
    #shareCalMoreModal-body{
      margin: 30px;
      max-width: 500px;
      max-height: 500px;
    }

    .dataTables_info{
      font-size: small;
      justify-content: center;
      text-align: center;

    }
    
    .pagination{
      margin-top: 10px;
      justify-content: center;
      text-align: center;
      display: flex;
    }

    .schInsertModal_content_text{
      width: 320px;
      height: 100px;
      min-width: auto;
      min-height: auto;
      border: 2px solid rgba(201, 203, 212, 0.722);
      border-radius: 5px;
    }
    

    .form-select{
      border: 2px solid rgba(201, 203, 212, 0.722);
      border-radius: 5px;
      color: rgb(89, 88, 88);
      width: 120px;
      height: 28px;
      margin-left: 13px;
    }

    .schInsertModalTitle {
      border: none;
      text-align: center;
      outline: none; 
      font-size: large;
    }

    .schInsertModalTitle:hover {
      border: none; /* 호버 시 테두리 제거 */
    }

    /*일정공유 스타일*/
    .schShareBtn{
      margin-top: 10px;
      font-size: small;
      font-weight: bold;
      color:  rgba(89, 88, 88, 0.774);
    }

    /*공유 일정, 공유 캘린더 스타일 */
    /*결제선 설정 모달 내에 스타일 */
     .btnArea{
    
    margin-left: 20px;
    width: 50px;
    height: 500px;

    }
    .downArea i{
    cursor: pointer;
    margin: 15px;
    }
    .downArea{
    display: flex;
    flex-direction: column;
    margin: auto;
    margin-top: 150px;
    }
    .singArea{
    margin-left: 20px;
    
    }
    .searchUser{
        display: flex;
        margin: auto;
    }

    .modal-title{
      font-size:120%;
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
              events: [
                {
                  title: '개발2팀 부서회식',
                  start: '2023-01-03T13:00:00',
                  //constraint: 'businessHours' 무슨 속성인지 알아보기
                  color: '#104fa1c3' //부서 캘린더
                },
                {
                  title: '개발2팀 부서회식',
                  start: '2023-01-03T13:00:00',
                  //constraint: 'businessHours' 무슨 속성인지 알아보기
                  color: '#104fa1c3' //부서 캘린더
                },
                {
                  title: '개발2팀 부서회식',
                  start: '2023-01-03T13:00:00',
                  //constraint: 'businessHours' 무슨 속성인지 알아보기
                  color: '#104fa1c3' //부서 캘린더
                },
                {
                  title: '개발2팀 부서회식',
                  start: '2023-01-03T13:00:00',
                  //constraint: 'businessHours' 무슨 속성인지 알아보기
                  color: '#104fa1c3' //부서 캘린더
                },
                {
                  title: '개발2팀 부서회식',
                  start: '2023-01-03T13:00:00',
                  //constraint: 'businessHours' 무슨 속성인지 알아보기
                  color: '#104fa1c3' //부서 캘린더
                },
                {
                  title: 'Meeting',
                  start: '2023-01-13T11:00:00',
                  constraint: 'availableForMeeting', // defined below
                  color: '#358657c3' //개인 캘린더 
                },
                {
                  title: '창립기념일',
                  start: '2023-01-13T11:00:00',
                  constraint: 'availableForMeeting', // 일정 옮기기 불가 -전사
                  color: '#a82626c3' //전사 캘린더
                },
                {
                  title: '출장',
                  start: '2023-01-18',
                  end: '2023-01-20',
                  color: '#358657c3' //개인 
                },
                {
                  title: 'B사 프로젝트',
                  start: '2023-01-03T13:00:00',
                  end: '2023-01-09',
                  color: '#104fa1c3' //부서 
                },
                {
                  title: '워크숍',
                  start: '2023-01-13T11:00:00',
                  end: '2023-01-20',
                  constraint: 'availableForMeeting', // defined below
                  color: '#a82626c3' //전사
                },
                {
                  title: 'Party',
                  start: '2023-01-29T20:00:00'
                }
              ]
            }
          ]
      });
      calendar.render();
    });
//풀캘린더 script start


 
//캘린더 모달 이벤트 start
      $(document).ready(function() {
		    // 상세 모달
		    $('.fc-daygrid-day-events').click(function(event) {
		    		debugger;
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

    	    // 캘린더 날짜 클릭시 등록하기 모달(schInsertModal)
      $(document).ready(function() {
    	  /********************** 캘린더 날짜 function start *************************/
    	    $('.schInsertModalBtn').click(function() {
    	        $('#schInsertModal').modal('show');
    	        $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
    	    }); 

    	    // schInsertModal 닫힐 때
    	    $('#schInsertModal').on('hidden.bs.modal', function(e) {
    	        $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
    	    }); 
      });
      
    	   /*  $(document).ready(function() {

    	    // 등록 버튼 schInsertButton 클릭시 insert
    	    $('#schInsertButton').click(function() {
    	        var schInsert = {
    	            //등록하기 폼 보고 다시 쓰기
    	            scheduleNo: $("#scheduleNo").val(),
    	            title: $("#schContent").val(), 
    	            start: $("#startDate").val(), 
    	            end: $("#endDate").val(), 
    	            // address: $("#address").val(),
    	            // schImport:
    	            // color: $("color").val()
    	            //notifyYn: $("notifyYn").val,  
    	        };
    	        
    	        // db에 넣기 addEvent사용 캘린더일때,
    	        var color = null;
    	        if (schInsert.scheduleNo === '01') {
    	            color = '#358657c3'; 
    	        } else if (schInsert.scheduleNo === '02') {
    	            color = '#104fa1c3'; 
    	        } else if (schInsert.scheduleNo === '03') {
    	            color = '#a82626c3'; 
    	        }
    	            
    	        calendar.addEvent(schInsert);
    	        $("#schInsertModal").modal("hide");
    	        $("#schContent").val("");
    	        $("#startDate").val("");
    	        $("#endDate").val("");
    	        //$("#address").val("");
    	    });
    	});
 */
      
  //공유캘린더 더보기 클릭시 목록 조회 모달
      $(document).ready(function() {
         //더보기 클릭시
          $('.shareCalMoreBtn').click(function() {
            $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
            $('#shareCalMoreModal').modal('show');
          }); 

         //삭제버튼 클릭시
         $('.shareCalMoreModal_graybtn').click(function() {
          $('#shareCalMoreModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>공유된 캘린더를 삭제하시겠습니까?</div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');
        });

          // shareCalMoreModal 닫힐 때
          $('#shareCalMoreModal').on('hidden.bs.modal', function(e) {
              $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            });

          //삭제버튼 닫을 때
          $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
          });
        });

  //공유일정 조직도 모달 schShareModal
    $(document).ready(function(){
      //열기 
      $('.schShareBtn').click(function(){
        $('#schShareModal').modal('show');
        $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
      }); 
      //설정하기 버튼 클릭시
      //닫기 클릭시

  //공유캘린더 조직도 모달 shareCalModalBtn
      //열기 
      $('.shareCalModalBtn').click(function(){
        $('#shareCalModal').modal('show');
        $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
      }); 
      //설정하기 버튼 클릭시
      
      //닫기 클릭시
    });

// 캘린더 모달 end


//공유일정 조직도 script start
  $('#kt_docs_jstree_basic').jstree({
      "core" : {
          "themes" : {
              "responsive": false
          }
      },
      "types" : {
          "default" : {
              "icon" : "fa fa-folder"
          },
          "group" : {
              "icon" : "fa-solid fa-user-group"
          },
          "building" : {
              "icon" : "fa-solid fa-building"
          },
          "person" : {
              "icon" : "fa-solid fa-person"
          }
      },
      "plugins": ["types"]
  }).on('select_node.jstree', function (e, data) {
      var node = data.node;
      
      if (node.type === "person") {
          var personName = node.text;
          
          var isExistingName = $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').length > 0;
          
          if (!isExistingName) {
              var html = '<div class="NameArea">' + personName +'<input type="checkBox"></div>';
              
              $('.resultNameArea').append(html);
          } else {
              // 이미 존재하는 이름이면 해당 이름을 삭제합니다.
              $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').remove();
          }
      }
  });


      
        document.querySelector('.referenceIn').addEventListener('click', function() {
      var nameAreas = document.querySelectorAll('.NameArea');
      
      nameAreas.forEach(function(nameArea) {
          var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
          if (checkbox) {
              var nameValue = nameArea.textContent.trim();
              
            
              var existingElement = document.querySelector('.referenceArea .referenceName');
              if (existingElement && existingElement.textContent.trim() === nameValue) {
                  return; 
              }

              var referenceName = document.createElement('div');
              referenceName.className = 'referenceName';
              referenceName.textContent = nameValue;
              document.querySelector('.referenceArea').appendChild(referenceName);
              
              nameArea.remove();
              }
          });
      });

      document.querySelector('.referenceOut').addEventListener('click', function() {
            
            var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

            
            approvalNames.forEach(function(referenceName) {
                
                var nameValue = referenceName.textContent.trim();
                
                var resultNameArea = document.querySelector('.resultNameArea');
              
                var nameArea = document.createElement('div');
                nameArea.className = 'NameArea';
                nameArea.textContent = nameValue;
                
                var checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                nameArea.appendChild(checkbox);
                
                resultNameArea.appendChild(nameArea);
                
                referenceName.remove();
            });
        });

    
        document.getElementById('saveData').addEventListener('click', function() {
          var approvalName1Element = document.querySelector('.approvalName1');
          var approvalName2Element = document.querySelector('.approvalName2');

      
          var approvalName1Text = approvalName1Element ? approvalName1Element.textContent : '';
          var frtApprovalElement = document.querySelector('.frtApproval');
          frtApprovalElement.textContent = approvalName1Text;

          
          var approvalName2Text = approvalName2Element ? approvalName2Element.textContent : '';
          var scdApprovalElement = document.querySelector('.scdApproval');
          scdApprovalElement.textContent = approvalName2Text;

          var referenceNameElements = document.querySelectorAll('.referenceName');
          var textToInsert = '';

          referenceNameElements.forEach(function(referenceNameElement, index) {
              var text = referenceNameElement.textContent.trim();
              if (index > 0) {
                  textToInsert += ', ';
              }
              textToInsert += text;
          });

          document.getElementById('refMember').value = textToInsert;
     });

//공유캘린더 start
    $('#kt_docs_jstree_shareCal').jstree({
      "core" : {
          "themes" : {
              "responsive": false
          }
      },
      "types" : {
          "default" : {
              "icon" : "fa fa-folder"
          },
          "group" : {
              "icon" : "fa-solid fa-user-group"
          },
          "building" : {
              "icon" : "fa-solid fa-building"
          },
          "person" : {
              "icon" : "fa-solid fa-person"
          }
      },
      "plugins": ["types"]
  }).on('select_node.jstree', function (e, data) {
      var node = data.node;
      
      if (node.type === "person") {
          var personName = node.text;
          
          var isExistingName = $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').length > 0;
          
          if (!isExistingName) {
              var html = '<div class="NameArea">' + personName +'<input type="checkBox"></div>';
              
              $('.resultNameArea').append(html);
          } else {
              // 이미 존재하는 이름이면 해당 이름을 삭제합니다.
              $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').remove();
          }
      }
  });


      
        document.querySelector('.referenceIn').addEventListener('click', function() {
      var nameAreas = document.querySelectorAll('.NameArea');
      
      nameAreas.forEach(function(nameArea) {
          var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
          if (checkbox) {
              var nameValue = nameArea.textContent.trim();
              
            
              var existingElement = document.querySelector('.referenceArea .referenceName');
              if (existingElement && existingElement.textContent.trim() === nameValue) {
                  return; 
              }

              var referenceName = document.createElement('div');
              referenceName.className = 'referenceName';
              referenceName.textContent = nameValue;
              document.querySelector('.referenceArea').appendChild(referenceName);
              
              nameArea.remove();
              }
          });
      });

      document.querySelector('.referenceOut').addEventListener('click', function() {
            
            var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

            
            approvalNames.forEach(function(referenceName) {
                
                var nameValue = referenceName.textContent.trim();
                
                var resultNameArea = document.querySelector('.resultNameArea');
              
                var nameArea = document.createElement('div');
                nameArea.className = 'NameArea';
                nameArea.textContent = nameValue;
                
                var checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                nameArea.appendChild(checkbox);
                
                resultNameArea.appendChild(nameArea);
                
                referenceName.remove();
            });
        });

    
        document.getElementById('saveData').addEventListener('click', function() {
          var approvalName1Element = document.querySelector('.approvalName1');
          var approvalName2Element = document.querySelector('.approvalName2');

      
          var approvalName1Text = approvalName1Element ? approvalName1Element.textContent : '';
          var frtApprovalElement = document.querySelector('.frtApproval');
          frtApprovalElement.textContent = approvalName1Text;

          
          var approvalName2Text = approvalName2Element ? approvalName2Element.textContent : '';
          var scdApprovalElement = document.querySelector('.scdApproval');
          scdApprovalElement.textContent = approvalName2Text;

          var referenceNameElements = document.querySelectorAll('.referenceName');
          var textToInsert = '';

          referenceNameElements.forEach(function(referenceNameElement, index) {
              var text = referenceNameElement.textContent.trim();
              if (index > 0) {
                  textToInsert += ', ';
              }
              textToInsert += text;
          });

          document.getElementById('refMember').value = textToInsert;
     }); 
//공유캘린더 end
//공유캘린더 조직도 end



//네이버 지도 api start
      selectMapList();

  //검색한 주소의 정보를 insertAddress 함수로 넘겨준다
      function searchAddressToCoordinate(address) {
          naver.maps.Service.geocode({
              query: address
          }, function(status, response) {
              if (status === naver.maps.Service.Status.ERROR) {
                  return alert('Something Wrong!');
              }
              if (response.v2.meta.totalCount === 0) {
                  return alert('올바른 주소를 입력해주세요.');
              }
              var htmlAddresses = [],
                  item = response.v2.addresses[0],
                  point = new naver.maps.Point(item.x, item.y);
              if (item.roadAddress) {
                  htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
              }
              if (item.jibunAddress) {
                  htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
              }
              if (item.englishAddress) {
                  htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
              }

              insertAddress(item.roadAddress, item.x, item.y);
              
          });
        }

    //주소 검색의 이벤트
        $('#address').on('keydown', function(e) {
            var keyCode = e.which;
            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
            }
        });
        $('#submit').on('click', function(e) {
            e.preventDefault();
            searchAddressToCoordinate($('#address').val());
        });
        naver.maps.Event.once(map, 'init_stylemap', initGeocoder);


    //지도에 마커 찍기
      function insertAddress(latitude, longitude) {
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(longitude, latitude),
            zoom: 50,
            scaleControl: false,
            logoControl: false,
            mapDataControl: false,
            zoomControl: false,
            zoomControlOptions: {
              style: naver.maps.ZoomControlStyle.SMALL,
              position: naver.maps.Position.TOP_LEFT
            },
            mapTypeControl: false
        });
          var marker = new naver.maps.Marker({
              map: map,
              position: new naver.maps.LatLng(longitude, latitude),
          });
      }
    //지도를 그려주는 함수
      function selectMapList() {
        
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.3595704, 127.105399),
            zoom: 10
        });
      }


    // 지도를 이동하게 해주는 함수
      function moveMap(len, lat) {
        var mapOptions = {
              center: new naver.maps.LatLng(len, lat),
              zoom: 15
          };
          var map = new naver.maps.Map('map', mapOptions);
          var marker = new naver.maps.Marker({
              position: new naver.maps.LatLng(len, lat),
              map: map
          });
      }
//네이버 지도 api end
    </script>
</body>
</html>