<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

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
.contentArea{ 
      width: 100%;
      display: contents;
}
.myPageArea{
  width: 80%;
}
</style>


</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/mypage/mypageSidebar1.jsp"/>

        <div class="LinkFlowMainContent">
        
 				  <!-- Content Header (Page header) -->
          <section class="content-header">
                  <div class="row mb-2">
                  <div class="col-sm-6">
                      <h1 class="m-0">사원 정보</h1>
                  </div>
              
              </div>
          <!-- /.container-fluid -->
          </section>

					<section class="content">
              <div class="container-fluid" style="display: flex; justify-content: center;"> 
                <div class="contentArea">
              
                  <div class="myPageArea">
                      <div class="row">
                      <div class="col-12">
                              
                      <!-- Profile Image -->
                        <div class="card card-primary card-outline">
                          <div class="card-body box-profile" id="profillArea">
                            <div class="text-center" style="margin-top: 50px;">
                              <c:choose>
												        <c:when test="${not empty loginUser.profileUrl}">
												            <img class="profile-user-img img-fluid img-circle"
												                 src="${contextPath}${loginUser.profileUrl}"
												                 alt="" style="width: 300px; height: 300px;">
												        </c:when>
												        <c:otherwise>
												            <img class="profile-user-img img-fluid img-circle"
												                 src="${contextPath}/resources/images/common/defaultProfile.png"
												                 alt="" style="width: 300px; height: 300px;">
												        </c:otherwise>
											   			 </c:choose>
            
                            </div>
  
                            <h3 class="profile-username text-center" style="margin-top: 30px;">${loginUser.userName}</h3>
  
                            <p class="text-muted text-center">${loginUser.deptName}</p><br><br>
  
                            <table class="table text-nowrap">
                             
                              <tbody>
                                <tr> 
                                  <td>직책</td>
                                  <td class="text-right">${loginUser.position}</td>  
                                </tr>
                                <tr> 
                                  <td>휴대폰</td>
                                  <td class="text-right">${loginUser.phone}</td>  
                                </tr>
                                <tr> 
                                  <td>E-Mail</td>
                                  <td class="text-right">${loginUser.userId}@linkflow.com</td>  
                                </tr>
                                <tr> 
                                  <td>입사일</td>
                                  <td class="text-right">${loginUser.hireDate}</td>  
                                </tr>
                                <tr> 
                                  <td>생년월일</td>
                                  <td class="text-right">${loginUser.birthDate}</td>  
                                </tr>
                                <tr> 
                                  <td>근속년수</td>
                                  <td class="text-right">${loginUser.serviceYear}년</td>  
                                </tr>
                                <tr> 
                                  <td>최종학력</td>
                                  <td class="text-right">${loginUser.education}</td>  
                                </tr>
                                <tr> 
                                  <td>주소</td>
                                  <td class="text-right">${loginUser.address} ${loginUser.detailAdd}</td>  
                                </tr>
                               </tbody> 
                               </table>
                          </div>
                          <!-- /.card-body -->
                          </div>
                        </div>
                        <!-- /.card -->
  
  
  
  
  
                          </div>




                  </div>


                </div>
                  <!-- /.card-body -->
                  </div>
                </div>
                <!-- /.card -->





                  </div>
                  </div>
              </div>
            </section>
            
        </div>
    </div>
</div>
  
</body>
</html>