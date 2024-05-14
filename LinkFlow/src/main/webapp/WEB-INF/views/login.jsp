<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LinkFlow 로그인</title>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/9a369fce54.js" crossorigin="anonymous"></script>
<!-- icheck bootstrap -->
<link rel="stylesheet" href="${contextPath }/resources/css/htmlTemp/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${contextPath }/resources/css/htmlTemp/adminlte.min.css">
<!-- jQuery -->
<script src="${contextPath }/resources/js/htmlTemp/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${contextPath }/resources/js/htmlTemp/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${contextPath }/resources/js/htmlTemp/adminlte.min.js"></script>

	 <style>
	
	.logoImg{
	    min-height: 300px;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    border: none;
	}
	</style>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center logoImg">
      <a href="../../index2.html" class="h1"><img src="${contextPath}/resources/images/common/logo.png" alt="회사배너"></a>
    </div>
    <div class="card-body">
      

      <form action="${contextPath}/main/mainpage" method="post">
        <div class="input-group mb-3">
          <input type="text" class="form-control" id="username" placeholder="아이디를 입력하세요" required oninput="checkIDs();" name="userId">
          <div class="input-group-append">
            <div class="input-group-text">
              <i class="fa-solid fa-user"></i>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" id="userPassword" placeholder="비밀번호를 입력하세요" required oninput="checkIDs();" name="userPwd" autocomplete="off">
          <div class="input-group-append">
            <div class="input-group-text">
              <i class="fa-solid fa-key"></i>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                아이디 저장
              </label>
              <br>
            </div>
          </div>
          <!-- /.col -->
         
          <!-- /.col -->
        </div>
      

      <div class="social-auth-links text-center mt-2 mb-3">
        <button type="submit" class="btn btn-block btn-primary" id="goPass" disabled>
           로그인
        </button>
      </div>
      </form>
      <!-- /.social-auth-links -->

      <p class="mb-1">
        <button type="button" class="btn btn-block btn-default" data-toggle="modal" data-target="#modal-default">
          비밀번호를 잊어버렸습니다.
        </button>
      </p>
      <div class="modal fade" id="modal-default">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">비밀번호 찾기</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>인사관리팀에 문의하여 비밀번호 초기화 후에 <br>새로운 비밀번호를 받아주세요.</p>
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
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->
<script>
$(document).ready(function(){
	var key = getCookie("idChk"); //user1
	if(key!=""){
		$("#username").val(key); 
	}
	 
	if($("#username").val() != ""){ 
		$("#idSaveCheck").attr("checked", true); 
	}
	 
	$("#idSaveCheck").change(function(){ 
		if($("#idSaveCheck").is(":checked")){ 
			setCookie("idChk", $("#username").val(), 7); 
		}else{ 
			deleteCookie("idChk");
		}
	});
	 
	$("#username").keyup(function(){ 
		if($("#idSaveCheck").is(":checked")){
			setCookie("idChk", $("#username").val(), 7); 
		}
	});
});
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
   
}
 
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
	 
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}
</script>
<script>
   function checkIDs() {
          
          var id1 = $("#username").val().trim();
          var id2 = $("#userPassword").val().trim();
          

          if (id1 !== "" && id2 !== "") {
            $("#goPass").prop("disabled", false);
          } else {
            $("#goPass").prop("disabled", true);
          }
        }


</script>

</body>
</html>