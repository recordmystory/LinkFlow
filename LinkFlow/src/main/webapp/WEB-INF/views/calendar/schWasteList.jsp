<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>schWasteList</title>

<style>

    /*휴지통 상세 정보 모달 스타일*/
  .schDetailModal_content > p, .search {
   margin:auto;
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
                      <select class="custom-select col-sm-2 text-sm">
                        <option selected hidden>모든 캘린더</option>
                        <option>개인 캘린더</option>
                        <option>부서 캘린더</option>
                        <option>전사캘린더</option>
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
                          <tr>
                            <td>1</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">${schedule.schTitle}</a></td>
                            <td>2024/04/11</td>
                            <td>개인 캘린더</td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button> </td>
                          </tr>
                          <tr>
                            <td>2</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">생일</a></td>
                            <td>2024/04/21</td>
                            <td>
                              공유 캘린더<br>
                              <span style="font-size: 11px; white-space:nowrap;">홍지우 팀장&lt;개발1팀&gt;</span>
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button></td>
                          </tr>
                          <tr>
                            <td>3</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">개발2팀 회식</a></td>
                            <td>2024/04/23</td>
                            <td>
                              부서 캘린더
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button>
                            </td>
                          </tr>
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
		$(function () {
		    $("#example1").DataTable({
		      "responsive": true, "lengthChange": false, "autoWidth": false,
		    });
		  });


    // schDetailModal : 휴지통 스케쥴 상세 모달
      $(document).ready(function() {
        $('.open-modal').click(function(){
            $('#schDetailModal').modal('show');
            
        });

        $('#schDetailModal').on('show.bs.modal', function(e) {
            $('body').addClass('modal-open'); // 바디에 modal-open 클래스 추가
            $('.modal-backdrop').addClass('show'); // 모달 백드롭에 show 클래스 추가
        });

        // schDetailModal이 닫힐 때
        $('#schDetailModal').on('hidden.bs.modal', function(e) {
            $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            $('.modal-backdrop').removeClass('show'); // 모달 백드롭에서 show 클래스 제거
        });

      // schDetailModals에서 detailBtn 클릭시
        $('.btn-primary').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>일정을 복구하시겠습니까?</div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');   
        });

        $('.btn-secondary').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 복구할 수 없습니다.</p></div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');
        });

        $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
        });
    });

	</script>
</body>
</html>

</body>
</html>