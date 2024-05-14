<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
	   padding: 10px;
	   
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
	 .infoTableArea{
	     argin-top: 20px;
	 }
	</style>



</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/group/groupSidebar.jsp"/>

        <div class="LinkFlowMainContent" style="padding: 30px;">
        
 				 <!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">LinkFlow (0)</h1>
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
                                          <tbody style="text-align: center;">
                                              <tr>
                                                  <td>CEO</td>
                                                  <td>1명</td>
                                                  <td data-toggle="modal" data-target="#modal-lg" style="cursor: pointer;">김사장</td>
                                                  <td>
                                                    <span class="groupName"></span>
                                                  </td>
                                              </tr>

                                              <tr>
                                                <td>개발팀</td>
                                                <td>4명</td>
                                                <td><span class="groupName">김개발</span></td>
                                                <td>
                                                  <span class="groupName">구성모</span>
                                                  <span class="groupName">엄희강</span>
                                                  <span class="groupName">이현아</span>
                                                </td>
                                                
                                              </tr>
                                              <tr>
                                                <td>영업부</td>
                                                <td>3명</td>
                                                <td><span class="groupName">김영업</span></td>
                                                <td>
                                                  <span class="groupName">김영업2</span>
                                                  <span class="groupName">김영업3</span>
                                                 
                                                </td>
                                                
                                              </tr>
                                              
                                            
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
                          src="../공용디자인/resouse/defaultProfile.png"
                          alt="User profile picture">
                      </div>  
                      <div class="userInfosmAera">
                          <ul>
                              <li>성함: 김대표</li>
                              <li>소속: CEO</li>
                              <li>직책: 대표이사</li>
                          </ul>
                      </div>

                     </div>
                     <div class="infoTableArea">
                         <table class="table" style="text-align: center;">
                              
                              <tr>
                                  <th>이메일</th>
                                  <td>heekang93@linkflow.com</td>
                              </tr>
                              <tr>
                                  <th>휴대전화</th>
                                  <td>010-1111-2222</td>
                              </tr>
                              <tr>
                                  <th>입사일</th>
                                  <td>1988-02-19</td>
                              </tr>
                              <tr>
                                  <th>주소</th>
                                  <td>서울 강서구 강서로 231</td>
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


   
        

</body>
</html>