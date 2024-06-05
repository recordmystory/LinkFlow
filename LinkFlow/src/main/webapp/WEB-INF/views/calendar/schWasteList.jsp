<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 캘린더</title>

<style>

    /*휴지통 상세 정보 모달 스타일*/
  .schDetailModal_content > p, .search {
   margin:auto;
  }
   
   #schWasteDetail_content_text{
      max-width: 300px;
    
    }
   
	.table-striped tbody tr {
	 background-color: white !important;

</style>
</head>
<body>
<div class="wrapper">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="LinkFlowMainSection">
	            
	   <jsp:include page="/WEB-INF/views/common/sidebar/calendar/calendarSidebar.jsp"/>
	               
            <!-- 휴지통 header start -->
            <div class="LinkFlowMainContent">
              <!-- Content Header (Page header) -->
              <section class="content-header">
                <p style="text-align: end;">삭제 일정은 <spen style="color: red;">30</spen>일 후  영구  삭제됩니다.</p>
                <div class="row mb-2">
                  <div class="col-sm-6">
                      <h1 class="m-0 mx-4">휴지통</h1>
                  </div>
                </div>
              <!-- /.container-fluid -->
              </section>
               
              <!-- 휴지통 Main content start -->
              
              <section class="content">
                <div class="container-fluid"> 
                  <div class="contentArea">
                    <div class="form-group mx-4">
   									 <select id="schCalSubCode" class="custom-select col-sm-2 text-sm" name="schCalSubCode" onchange="subCodeSubmit()">
                        <option value="03" selected>개인 캘린더</option>
                        <c:if test="${loginUser.deptRight == 'Y'}">
                            <option value="02">부서 캘린더</option>
                        </c:if>
                        <c:if test="${loginUser.spRight == 'Y'}">
                            <option value="01">전사 캘린더</option>
                        </c:if>
                      </select>
                    </div> 
                      
                   <!-- /.card-header -->
                    <div class="card-body">
                      <table id="example1" class="table table-bordered table-striped bin_list_table">
                        <thead>
                        <tr>
                          <th>No.</th>
                          <th>일정명</th>
                          <th>삭제일</th>
                          <th>캘린더 종류</th>
                          <th>복구/삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                          <!-- <tr>
                            <td>1</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal"></a></td>
                            <td>2024/04/11</td>
                            <td>개인 캘린더</td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button> </td>
                          </tr> -->
                        </tbody>
                      </table>
                    </div>
                    <!-- /.card-body -->
                  </div>
                  <!-- /.card -->
                </div>
                <!-- /.col -->
            <!-- /.container-fluid -->
          </section>
          <!-- /.content -->
        </div>
      <!-- /.content-wrapper -->
     </div>
   </div>
       <jsp:include page="/WEB-INF/views/calendar/include/calendarModal.jsp"/>

        
		<!-- DataTables  & Plugins -->
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    
<script>
//페이징 기능
$(document).ready(function() {
    // DataTable 초기화
    var table = $("#example1").DataTable({
        "responsive": true,
        "lengthChange": false,
        "autoWidth": false
    });

    // 휴지통 일정 조회 ****************************************
    function subCodeSubmit() {
        var selectedSubCode = $('#schCalSubCode').val();
        $.ajax({
            url: "${contextPath}/calendar/schWasteList.do",
            type: "get",
            data: { schCalSubCode: selectedSubCode },
            success: function(schWaste) {
                table.clear().draw();
   
                for (var i = 0; i < schWaste.length; i++) {
                	var schedule = schWaste[i];
                    

                    var wasteSubCode;
                    if (schedule.schCalSubCode === '01') {
                        wasteSubCode = '전사 캘린더';
                    } else if (schedule.schCalSubCode === '02') {
                        wasteSubCode = '부서 캘린더';
                    } else if (schedule.schCalSubCode === '03') {
                        wasteSubCode = '개인 캘린더';
                    }
                    var listTr = '<tr>' +
                        '<td>' + (i + 1) + '</td>' +
                        '<td><a href="#" class="wasteTitle" data-sch-no="' + schedule.schNo + '">' + schedule.schTitle + '</a></td>' +
                        '<td>' + new Date(schedule.modDate).toLocaleDateString().slice(0, 10) + '</td>' +
                        '<td>' + wasteSubCode + '</td>' +
                        '<td>' +
                        '<button type="button" class="btn btn-primary btn-sm restoreBtn" id="restoreBtn" data-sch-no="' + schedule.schNo + '">복구</button>&nbsp' +
                        '<button type="button" class="btn btn-secondary btn-sm removalBtn" id="removalBtn" data-sch-no="' + schedule.schNo + '">삭제</button>' +
                        '</td>' +
                        '<input type="hidden" name="schNo" id="schNo">' +
                        '</tr>';
                        
  		      		  	$('input[name="schNo"]').val(schedule.schNo);
                    table.row.add($(listTr)).draw(); //데이터 테이블을 사용하므로 append로 직접 행 추가 x 다시 테이블 그리기로 로드
                }
            },
            error: function() {}
        });
    }

      subCodeSubmit();
    $('#schCalSubCode').change(function() {
        subCodeSubmit();
    });
    
    
    //일정상세 *********************************************************** 
     $(document).on('click', '.wasteTitle', function() {
        var schNo = $(this).data('sch-no'); 
        wasteSchDetail(schNo);

    });
    
    function wasteSchDetail(schNo) {
	    $.ajax({
	        url: "${contextPath}/calendar/schSelect.do",
	        type: "get",
	        data: { schNo: schNo },
	        success: function(schedule) {	            
		            $('#schWasteDetailTitle').text(schedule.schTitle); 
				        //날짜 텍스트로 형식 맞춰넣기 위한 처리
				        console.log(schedule.schTitle);
				        
						    var startDateChange = new Date(schedule.startDate);
						    var startDate = startDateChange.toLocaleString('ko-KR', {
						        year: 'numeric',
						        month: '2-digit',
						        day: '2-digit',
						        hour: '2-digit',
						        minute: '2-digit'
						    });
						    
						    $('#wasteStartDate').text(startDate);
						
						    var endDateChange = new Date(schedule.endDate);
						    var endDate = endDateChange.toLocaleString('ko-KR', {
						        year: 'numeric',
						        month: '2-digit',
						        day: '2-digit',
						        hour: '2-digit',
						        minute: '2-digit'
						    });
						    $('#wasteEndDate').text(endDate === startDate ? '' : '~  ' + endDate);
						
						    $('#wasteAddress').text(schedule.address);
						    $('#schWasteDetail_content_text').text(schedule.schContent);
						
						    $('#schWasteImport').prop('checked', schedule.schImport === 'Y');
						    $('#wasteNotifyYn').prop('checked', schedule.notifyYn === 'Y');
						
						    //캘린더명 처리
						    var calCode = schedule.schCalSubCode;
						    if (calCode == '03') {
						    	 $('#wasteSubCode').text('개인 캘린더');
						    } else if (calCode == '02') {
						    	 $('#wasteSubCode').text('부서 캘린더');
						    } else if (calCode == '01') {
						    	 $('#wasteSubCode').text('전사 캘린더');
						    }
						    

				        $('#schWasteDetail').modal('show');

			       },
	        error: function() {
	        	console.log("오류");
	        
	        }
   		 });
    }
   
    //일정 복구************************************
			//복구 버튼 클릭시 복구 모달 
		    $(document).on('click', '#restoreBtn', function() {
		    	$('#schWasteDetail').modal('hide'); 
		      $('#schWasteDetail-modal-body').html('<div>일정을 복구하시겠습니까?</div>');
		      $('#wasteDetailBtn').modal('show');
		      $('body').addClass('overflow-hidden');   
		    		
		      var schNo = $(this).data('sch-no');
		      wasteSchRestore(schNo);
		     });
			    
 
    	//복구 버튼 클릭시 
     function wasteSchRestore(schNo) {
    	  $('#schRestore').off('click').on('click', function() { //off('click') - 이전에 바인딩된 클릭 이벤트 핸들러 제거
    	       
    	        $(this).prop('disabled', true);

    	        $.ajax({
    	            url: "${contextPath}/calendar/wasteSchRestore.do",
    	            type: "get",
    	            data: {
    	                schNo: schNo
    	            },
    	            success: function(result) {
    	                console.log("success:", result);

    	                if (result === "success") {
    	                    alert("일정 복구 성공");
    	                    $('#wasteDetailBtn').modal('hide');
    	                    subCodeSubmit();
    	                }
    	            },
    	            error: function(result) {
    	                if (result === "fail") {
    	                    alert("일정 복구 실패.");
    	                    $('#wasteDetailBtn').modal('hide');
    	                }
    	            },
    	            complete: function() {
    	                $('#schRestore').prop('disabled', false); //요청이 끝나고 다시 활성화해서 중복방지
    	            }
    	        });
    	    });
    	}
        	

    
   	 
    //일정 삭제 ************************************
    	//삭제 버튼 클릭시 삭제 모달 
		    $(document).on('click', '#removalBtn', function() {
		    	$('#schWasteDetail').modal('hide'); 
		      $('#schWasteRemoval-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 복구할 수 없습니다.</p></div>');
		      $('#wasteRemovalBtn').modal('show');
		      $('body').addClass('overflow-hidden');   
		    		
		      var schNo = $(this).data('sch-no');
		      wasteSchremoval(schNo);
		     });
   
			//삭제 버튼 클릭시 (완전삭제)
		     function wasteSchremoval(schNo) {
		        $('#schComplete').click(function() {
		           $.ajax({
		               url: "${contextPath}/calendar/wasteSchRemoval.do",
		               type: "get",
		               data: {
		                   schNo: schNo
		               },
		               success: function(result) {
		                   console.log("success:", result);

		                   if (result === "success") {
		                       alert("일정 삭제 성공");
		                       $('#wasteRemovalBtn').modal('hide');
		                       subCodeSubmit();
		                   }
		               },
		               error: function(result) {
		               	if (result === "fail") {
		               	 		alert("일정 삭제 실패.");
		                  	$('#wasteRemovalBtn').modal('hide');
		                   } 
		               }
		           });
		       });
		        	
		   }
 		// x클릭시 닫기
    $(document).on('click', '#schCencelBtn', function() {
        $('#wasteDetailBtn').modal('hide');
        $('#wasteRemovalBtn').modal('hide');
    });
});




  /*   // schDetailModal : 휴지통 스케쥴 상세 모달
      $(document).ready(function() {

        $('#schDetailModal').on('show.bs.modal', function(e) {
            $('body').addClass('modal-open'); // 바디에 modal-open 클래스 추가
            $('.modal-backdrop').addClass('show'); // 모달 백드롭에 show 클래스 추가
        });

        // schDetailModal이 닫힐 때
        $('#schDetailModal').on('hidden.bs.modal', function(e) {
            $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            $('.modal-backdrop').removeClass('show'); // 모달 백드롭에서 show 클래스 제거
        });

        $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
        });
    }); */

	</script>
</body>
</html>

</body>
</html>