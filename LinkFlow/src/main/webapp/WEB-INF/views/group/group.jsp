<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
	<style>
	   .groupArea{
	    
	   }
	
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

        <div class="LinkFlowSidebar">
           <!-- Main Sidebar Container -->
				   <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">
				
				   <!-- Sidebar -->
				   <div class="sidebar">
				
				   <!-- Sidebar Menu -->
				   <nav class="linkfoiwsideMenu">
				
				       <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				
				       <li class="sidebarName">조직도</li><br>
				   
				       
				     		</ul>
				   </nav>
				   <!-- /.sidebar-menu -->
				   </div>
				   <!-- /.sidebar -->
				</aside>
				<!--사이드바 끝-->
				</div>

        <div class="LinkFlowMainContent" style="padding: 30px;">
        
 				 <!-- Content Header (Page header) -->
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
                                      <div class="">
                                        <table class="table table-bordered">
                                          
                                          <thead style="text-align: center;" class="table-info">
                                              <th style="width: 200px;">부서</th>
                                              <th style="width: 100px;">인원</th>
                                              <th style="width: 150px;">부서 대표</th>
                                              <th>부서원</th>
                                              
                                          </thead>
                                          <tbody >
                                          <c:choose>
                                          <c:when test="${empty g}">
                                          	<tr> <td colspan="4">조회된 조직,부서가 없습니다. </td></tr>
                                          </c:when>
	                                          <c:otherwise>
	                                          <c:forEach var="g" items="${g}">
														                    <tr>
														                        <td style="text-align: center;">${g.deptName}</td>
														                        <td style="text-align: center;">${g.totalMember}</td>
														                        <td style="text-align: center;">${g.deptCapName}</td>
														                    
														                        <td data-toggle="modal" data-target="#modal-lg" style="cursor: pointer;">
														                           <c:forTokens var="nameuserId" items="${g.deptMember}" delims=",">
													                                	 <span class="groupName" data-userid="${fn:split(nameuserId, '|')[1]}">${fn:split(nameuserId, '|')[0]}</span>
											
												                           		 </c:forTokens>
														                        </td>
														                    </tr>
														                </c:forEach>
                                           	</c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>

                                      </div>
                                    
                                    
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
                </div>
                <!-- /.content-wrapper -->
            </div>
        </div>
        <div class="modal fade" id="modal-lg">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">부서원 정보 조회</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body" style="display: flex; justify-content: center;">
                <div class="card card-primary groupAddress">
                  <div class="card-body">
                    <div class="userInfoAera">
                      <div class="ImgInfoAera">
                      <img class="profile-user-img img-fluid img-circle"
                          src=""
                          alt="User profile picture" >
                      </div>  
                      <div class="userInfosmAera">
                          <ul>
                              <li>성함: </li>
                              <li>소속: </li>
                              <li>직책: </li>
                          </ul>
                      </div>

                     </div>
                     <div class="infoTableArea">
                         <table class="table" style="text-align: center;">
                              
                              <tr>
                                  <th>이메일</th>
                                  <td></td>
                              </tr>
                              <tr>
                                  <th>휴대전화</th>
                                  <td></td>
                              </tr>
                              <tr>
                                  <th>입사일</th>
                                  <td></td>
                              </tr>
                              <tr>
                                  <th>주소</th>
                                  <td></td>
                              </tr>

                      </table>
                     </div>
                     </div>
                     </div>
              </div>
              <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
					<script>
				    $(document).ready(function() {
				        $('.groupName').click(function() {
				            var userId = $(this).data('userid'); 
				            console.log(userId);
				            $.ajax({
				                url: '${contextPath}/group/groupPageInfo', 
				                type: 'POST',
				              
				                data: {
				                    userId: userId,
				                },    
				                success: function(response) {
					                	if (response.profileUrl === null) {
					                	    $('.modal-body .userInfoAera .ImgInfoAera img').attr('src', '${contextPath}/resources/images/common/defaultProfile.png');
					                	} else {
					                	    $('.modal-body .userInfoAera .ImgInfoAera img').attr('src', '${contextPath}'+response.profileUrl);
					                	}
				                    $('.modal-body .userInfoAera .userInfosmAera li:nth-child(1)').text('성함: ' + response.userName);
				                    $('.modal-body .userInfoAera .userInfosmAera li:nth-child(2)').text('소속: ' + response.deptName);
				                    $('.modal-body .userInfoAera .userInfosmAera li:nth-child(3)').text('직책: ' + response.position);
				                    $('.modal-body .infoTableArea tr:nth-child(1) td').text(response.userId + '@linkflow.com');
				                    $('.modal-body .infoTableArea tr:nth-child(2) td').text(response.phone);
				                    $('.modal-body .infoTableArea tr:nth-child(3) td').text(response.hireDate);
				                    $('.modal-body .infoTableArea tr:nth-child(4) td').text(response.address);			
				                },
				                error: function(xhr, status, error) {
				                    console.error('AJAX 오류');
				                }
				            });
				        });
				    });
				</script>

   
        

</body>
</html>