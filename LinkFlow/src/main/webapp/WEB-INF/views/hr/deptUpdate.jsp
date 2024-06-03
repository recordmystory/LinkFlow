<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 추가/변경</title>

 <!-- 다음 주소 API-->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
  <!-- daterange picker -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/daterangepicker/daterangepicker.css">
  <!-- iCheck for checkboxes and radio inputs -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Bootstrap Color Picker -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- Select2 -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <!-- Bootstrap4 Duallistbox -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
  <!-- BS Stepper -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bs-stepper/css/bs-stepper.min.css">
  <!-- dropzonejs -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/dropzone/min/dropzone.min.css">
	<style>

	
	   .AttendanceSmArea{
	     margin: auto;
	     padding: 20px;
	     min-width: 95%;
	     
	  }
	  .AttendanceSmBox{
	     width: 100%;
	  }
	  .oneBoxArea{
	     margin-bottom: 50px;
	     min-height: 800px;
	  }
	  
	  
	  .AttendanceSeachArea{
	     display: flex;
	  }
	  .groupName{
	   margin: 20px;
	   white-space: nowrap;
	   
	  }
	  .groupAddress{
	     width: 700px;
	     
	 }
	 .userInfoAera{
	     display: flex;
	     justify-content: space-around;
	 }
	 .userInfosmAera{
	     margin: auto;
	     margin-top: 20px;
	    
	 }
	 .userInfosmAera ul {
	 list-style: none;
	 } 
	 .ImgInfoAera{
    margin-left: 47px;
 
	 }
	 .ImgInfoAera>img{
   
    width: 100px;
	  height: 100px;
	 }    
	 .infoTableArea{
	     argin-top: 20px;
	 }
	</style>
	
</head>
<body>
	<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/hr/hrSidebar3.jsp"/>

        <div class="LinkFlowMainContent" style="padding: 30px;">
        	<section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">LinkFlow</h1>
                            </div>
                        
                        </div>
                    <!-- /.container-fluid -->
                    
                    </section>
                   
                    <!-- Main content -->
                    <section class="content">
                      
                      <div class="groupArea">
                        <div class="card card-default color-palette-box card-info oneBoxArea">
                            <div class="card-header">
                              <h3 class="card-title">
                                전체 조직도
                              </h3>
                            </div>
                          
                            <!-- /.col-12 -->
                            <div class="row">

                              <div class="col-3 AttendanceSmArea">
                                  <div class="card card-default AttendanceSmBox">
                                    
                                    <!-- /.card-header -->
                                    <div class="card-body">
                                      
                                        <table class="table table-bordered">
                                          
                                          <thead style="text-align: center;" class="table-info">
                                              <th style="width: 200px;">부서</th>
                                              <th style="width: 100px;">인원</th>
                                              <th style="width: 150px;">부서 대표</th>
                                              <th>부서원</th>
                                              <th style="width: 200px;">부서 상태</th>
                                              
                                          </thead>
                                          <tbody >
                                          <c:choose>
                                          <c:when test="${empty g}">
                                          	<tr> <td colspan="4">조회된 조직,부서가 없습니다. </td></tr>
                                          </c:when>
	                                          <c:otherwise>
	                                          <c:forEach var="g" items="${g}">
	                                     
														                    <tr>
														                        <td style="text-align: center;">${g.deptName} <input type="hidden" value="${g.deptCode}"></td>
														                        <td style="text-align: center;">${g.totalMember}</td>
														                        <td style="text-align: center;">${g.deptCapName}</td>
														                    
														                        <td data-toggle="modal" data-target="#modal-lg">
														                           <c:forTokens var="nameuserId" items="${g.deptMember}" delims=",">
													                                	 <span class="groupName" data-userid="${fn:split(nameuserId, '|')[1]}">${fn:split(nameuserId, '|')[0]}</span>
											
												                           		 </c:forTokens>
														                        </td>
														                        <td>
														                        <button class="btn btn-sm btn-warning" 
														                        			 style="margin-right: 15px"
																				                   data-target="#modal-goupdate"
																				                   data-toggle="modal"
																				                   data-deptname="${g.deptName}" 
																				                   data-deptcode="${g.deptCode}">부서 수정</button>
																				           <button class="btn btn-sm btn-danger"
																				           				 data-toggle="modal"
																								           data-target="#modal-godelete"
																								           data-deptcode="${g.deptCode}"
																								           															>부서 삭제</button>
														                        	
														                        </td>
														                    </tr>
														                </c:forEach>
                                           	</c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
																			
										                      <!-- 부서 수정 확인 모달 -->
																					<div class="modal fade" id="modal-goupdate">
																					    <div class="modal-dialog">
																					        <div class="modal-content">
																					            <div class="modal-header">
																					                <h4 class="modal-title">부서 수정</h4>
																					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
																					                    <span aria-hidden="true">&times;</span>
																					                </button>
																					            </div>
																					            <div class="modal-body">
																					                <div class="col-md-12">
																					                    <input type="hidden" id="deptCodeInput" value="" class="form-control"><br>
																					                    부서이름: <input type="text" id="deptNameInput" value="" class="form-control">
																					                </div>
																					            </div>
																					            <div class="modal-footer">
																					                <button type="button" onclick="" class="btn btn-warning left" data-dismiss="modal" id="goupdate">수정</button>
																					            </div>
																					        </div>
																					        <!-- /.modal-content -->
																					    </div>
																					    <!-- /.modal-dialog -->
																					</div>
																					<!-- /.modal -->
																					
																					<!-- 부서 수정 확인 모달 -->
																					<div class="modal fade" id="modal-godelete">
																					    <div class="modal-dialog">
																					        <div class="modal-content">
																					            <div class="modal-header">
																					                <h4 class="modal-title">부서 삭제</h4>
																					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
																					                    <span aria-hidden="true">&times;</span>
																					                </button>
																					            </div>
																					            <div class="modal-body">
																					                <div class="col-md-12">
																					                    <input type="hidden" id="deptCodeInput1" value="" class="form-control"><br>
																					                     해당 부서를 삭제하시겠습니까??
																					                </div>
																					            </div>
																					            <div class="modal-footer">
																					                <button type="button" onclick="" class="btn btn-danger left" data-dismiss="modal" id="godelete">삭제</button>
																					            </div>
																					        </div>
																					        <!-- /.modal-content -->
																					    </div>
																					    <!-- /.modal-dialog -->
																					</div>
																					<!-- /.modal -->
																					
																					
																					
																					
																					<!-- JavaScript -->
																					<script>
																					document.addEventListener('DOMContentLoaded', function() {
																					    document.querySelectorAll('button[data-target="#modal-goupdate"]').forEach(function(button) {
																					        button.addEventListener('click', function() {
																					            var deptName = button.getAttribute('data-deptname');
																					            var deptCode = button.getAttribute('data-deptcode');
																					            document.getElementById('deptNameInput').value = deptName;
																					            document.getElementById('deptCodeInput').value = deptCode;
																
																					            $('#modal-goupdate').modal('show');
																					        });
																					    });
																					});
																					
																				    document.querySelectorAll('button[data-target="#modal-godelete"]').forEach(function(button) {
																				        button.addEventListener('click', function() {
																				            var deptCode = button.getAttribute('data-deptcode');
																				            document.getElementById('deptCodeInput1').value = deptCode;

																				            $('#modal-godelete').modal('show');
																				        });
																				    });
																			
																					</script>
																					
																					
																					
										                      <script>
																					    $(document).ready(function() {
																					        $("#modal-goupdate").on("click", "#goupdate", function() {
																					        	var deptCode = $("#deptCodeInput").val();  
																					        	var deptTitle = $("#deptNameInput").val();
																					        	
																					            $.ajax({
																					                url: "${contextPath}/hr/UpdateDept",
																					                method: "POST", 
																					                data: { deptCode: deptCode 
																					                			 ,deptTitle: deptTitle	
																					                }, 
																					                success: function(result) {
																					                    if(result === "YYYYY") {
																					                        alert("부서 정보 수정이 성공적으로 되었습니다.");
																					                        location.reload();
																					                    } else if(result === "NNNNN") {
																					                        alert("서버 오류로 인해 정보 수정 처리에 실패했습니다.");
																					                    }
																					                },
																					                error: function(xhr, status, error) {
																					                    console.error(xhr.responseText);
																					                }
																					            });
																					        });
																					    });
																					</script>
                                      		<script>
																					    $(document).ready(function() {
																					        $("#modal-godelete").on("click", "#godelete", function() {
																					        	var deptCode = $("#deptCodeInput1").val();  
																					        	
																					        	
																					            $.ajax({
																					                url: "${contextPath}/hr/deleteDept",
																					                method: "POST", 
																					                data: { deptCode: deptCode 
																					                			 	
																					                }, 
																					                success: function(result) {
																					                    if(result === "YYYYY") {
																					                        alert("부서 삭제가 성공적으로 되었습니다.");
																					                        location.reload();
																					                    } else if(result === "NNNNN") {
																					                        alert("서버 오류로 인해 정보 수정 처리에 실패했습니다.");
																					                    }
																					                },
																					                error: function(xhr, status, error) {
																					                    console.error(xhr.responseText);
																					                }
																					            });
																					        });
																					    });
																					</script>
                                    
                                    
                                    <!-- /.card-body -->
                                  </div>
                                  <!-- /.card -->
                                </div>

                            </div>
                          </div>  
                                
                      
                      </div>
										</div>

                    </section>
                    <!-- /.content -->
                    
                     <div class="">
                                     
                       <div class="card card-info">
                           <div class="card-header">
                           <h3 class="card-title">부서 추가 등록</h3>
               
                           
                           </div>
                           <!-- /.card-header -->
                           <form action="${contextPath}/hr/deptinsert.do" method="post">
                           <div class="card-body">
                           
                          	
                               <input type="hidden" name="regId" value="${loginUser.userId }">
                               <input type="hidden" name="modId" value="${loginUser.userId }">
                               		 <div class="col-md-6">
                                     <label>부서코드</label>
                                     <div class="input-group input-group">
                                         
                                         <input type="text" class="form-control" placeholder="부서 코드를 확인하세요" name="deptCode" id="deptCode">
                                         <span class="input-group-append">
                                           <button type="button" class="btn btn-primary btn-flat" onclick="checkCode();">중복확인</button>
                                         </span>
                                     </div>
                                     <div id="resultArea" style="font-size:15px"></div>
                                     <br>

                                    </div>
																		<script>
													      		 function checkCode(){
																            var deptCode = $('#deptCode').val(); 
																            $.ajax({
																                url: '${contextPath}/hr/checkCode', 
																                type: 'POST',
																              
																                data: {
																                	deptCode: deptCode,
																                   
																                },    
																                success: function(response) {
																                    if (response ==='YYYYY') {
																                        $('#resultArea').text('중복된 부서코드가 없습니다'); 
																                        $('#goPass').prop('disabled', false); 
																                    } else if(response ==='NNNNN') {
																                        $('#resultArea').text('중복된 부서코드가 있습니다. 다른 코드이름으로 시도해주세요'); 
																                        $('#goPass').prop('disabled', true); 
																                    }
																                },
																                error: function(xhr, status, error) {
																                    console.error('AJAX 오류');
																                }
																            });
																        };
																    
																</script>
                               <div class="col-md-6">
                                   <div class="form-group">
                                   <label>부서 이름</label>
                                   <input type="text"  name="deptTitle" class="form-control" required placeholder="부서이름을 입력하세요" >   
                                   </div>   
                               </div>


                               <!-- /.col -->
                           
               
                           
                           
                           </div>
                           <!-- /.card-body -->
                           <div class="card-footer">
                               <button type="submit" class="btn btn-primary"  id="goPass" disabled="disabled">등록하기</button>
                               <a href="${contextPath}/hr/hrPage" class="btn btn-default float-right" style="margin-left: 10px;">등록취소</a>
                              
                           </div>
                           </form> 
                       </div>
                   	
                       <!-- /.card -->
               

                       </div>
                   </div>
                    
                </div>
                <!-- /.content-wrapper -->
                                  
                             
                                   
                    

                                
                        </div><!-- /.card -->     
                                
                        </div> <!-- /.content-wrapper -->
                        </section>
                
 				 
        </div>
      
   
		</div>
   </div><!--전체영역 끝-->
			
		




</body>
</html>