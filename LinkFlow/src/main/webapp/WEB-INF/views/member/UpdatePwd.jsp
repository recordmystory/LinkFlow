<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

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
.PwdCheckArea, .PwdreCheckArea{
      margin-left: 5px;
      font-size: 13px;
      padding: 3px;
      color: red;
      }      
</style>


</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/mypage/mypageSidebar2.jsp"/>

        <div class="LinkFlowMainContent">
        
 				  <!-- Content Header (Page header) -->
          <section class="content-header">
                  <div class="row mb-2">
                  <div class="col-sm-6">
                      <h1 class="m-0">비밀번호 변경</h1>
                  </div>
              
              </div>
          <!-- /.container-fluid -->
          
          </section>
                   
          <!-- Main content -->
          <section class="content">
          <div class="container-fluid" style="display: flex; justify-content: center;"> 
            <div class="contentArea">
                  
                <div class="myPageArea">
                    <!-- general form elements -->
			            <div class="card card-primary">
			              <div class="card-header">
			                <h3 class="card-title">새로운 비밀번호 설정</h3>
			              </div>
			              <!-- /.card-header -->
			              <!-- form start -->
			              <form action="${contextPath}/member/updateUserPassWord" method="post">
			                <div class="card-body">
			                    <div class="ExArea">
			                        <ul>
			                            <li>10~16자리 영문 소문자,숫자,특수문자 조합으로 설정하세요</li>
			                            <li>이전에 사용한 비밀번호를 재사용하면 도용의 우려가 있으니 가급적 새로운 비밀번호를 사용해주세요</li>
			                        </ul>
			
			                    </div>
			
			                   
			
			                    <div class="form-group col-5">
			                				<input type="hidden" name="userId" value="${loginUser.userId}">
			                        <label for="exampleInputEmail1">새로운 비밀번호</label>
			                        <input type="password" class="form-control" id="exampleInputEmail1" placeholder="새로운 비밀번호를 입력하세요" oninput="checkIDs();" name="userPwd">
			                        <span class="PwdCheckArea"></span>
			                    </div>
			
			                    <div class="form-group col-5">
			                
			                        <label for="exampleInputEmail2">새로운 비밀번호 확인</label>
			                        <input type="password" class="form-control" id="exampleInputEmail2" placeholder="새로운 비밀번호 확인" oninput="checkIDs();">
			                        <span class="PwdreCheckArea"></span>
			                    </div>
			                 
			                
			                </div>
			                <!-- /.card-body -->
			
			                <div class="card-footer">
			                  <button type="submit" class="btn btn-primary" disabled id="goPass">저장</button>
			                </div>
			              </form>
			            </div>
			            <!-- /.card -->        
			                </div>
			                <!-- /.content-wrapper -->
			            </div>
			        </div>
			        </section>
        </div>

      <script>
      $(document).ready(function(){
    	    var RegExpPassword = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+])[a-z0-9!@#$%^&*()_+]{10,16}$/;

    	    $("#exampleInputEmail1, #exampleInputEmail2").on("keyup", function(){
    	        var newPwd = $("#exampleInputEmail1").val().trim(); 
    	        var newPwdcheck = $("#exampleInputEmail2").val().trim(); 

    	   
    	        var isPasswordValue = RegExpPassword.test(newPwd);
    	       
    	       
    	        var isMatch = newPwd === newPwdcheck;
    	        
    	        if (!isPasswordValue) {
	                $(".PwdCheckArea").text("비밀번호 형식에 맞게 입력하세요 (영문, 숫자, 특수문자 조합, 10-16자)");
	            }else{
	            	$(".PwdCheckArea").text("");
	            } 
    	        if (!isMatch) {
	                $(".PwdreCheckArea").text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
	            }else{
	            	$(".PwdreCheckArea").text("");
	            }			
    	        
    	        if (isPasswordValue && isMatch) {
    	            $("#goPass").prop("disabled", false);
    	            $(".PwdCheckArea, .PwdreCheckArea").text("");  
    	        } else {
    	            $("#goPass").prop("disabled", true);
    	        }
    	    });
    	});
      </script>
   

    </div>
    </div>
</body>
</html>