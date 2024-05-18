<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
</head>
<body>
	<script>
	    
	    if("${alertMsg}" !== "") {
	        
	        alert("${alertMsg}");
	        if("${historyBackYN}" === "Y") {
	            history.back();
	        }
	    }
	</script>
	<div class="LinkFlowheader">
    <nav class="navbar navbar-expand navbar-white navbar-light" style="border-bottom: 2px solid #b4bac0;">
      <!-- Left navbar links -->
      <a href="${contextPath}/main" class="head_BannerImg" style="padding: 10px;"><img src="${contextPath }/resources/images/common/logo.png" alt="회사배너" style="height: 50px;"></a>
      <ul class="navbar-nav">
        <li class="nav-item dropdown"> 

          <a class="nav-link" data-toggle="dropdown" href="#">
            
            <span class="resultArea"></span>
            <i class="fa-solid fa-caret-down"></i>
          </a>

          <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left movePage">
            
            <div class="row mainMenuSelect">
              <div class="info-box-content">
                <a href="#" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-envelope fa-2xl"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">메일</span></div>
                </a>
              </div>
              <div class="info-box-content">
                <a href="${ contextPath }/booking/room.bk" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-user-clock fa-xl"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">예약하기</span></div>
                </a>
              </div>
            </div>

            <div class="row mainMenuSelect">
              <div class="info-box-content">
                <a href="#" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-calendar-days fa-2xl"style="margin-left: 3px;"></i></div>
                  <div class="box-icon-name"><span class="info-box-text spanCss">일정</span></div>
                </a>
              </div>
              <div class="info-box-content">
                <a href="${contextPath}/member/myAttendance.page" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-stopwatch fa-2xl" style="margin-left: 3px;"></i> </div>
                  <div class="box-text"><span class="info-box-text spanCss">근태관리</span></div>
                </a>
              </div>
            </div>

            <div class="row mainMenuSelect">

              <div class="info-box-content">
                <a href="${ contextPath }/board/list.do" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-chalkboard fa-2xl"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">게시판</span></div>
                </a>
              </div>

              <div class="info-box-content">
                <a href="${ contextPath }/edsm/prog/listAll.prog" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-clipboard fa-2xl" style="margin-left: 5px;"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">전자결재</span></div>
                </a>
              </div>
            </div>

            <div class="row mainMenuSelect">
              <div class="info-box-content">
                <a href="${ contextPath }/group/group.page" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-people-line fa-2xl" style="width: 30px;"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">조직도</span></div>
                </a>
              </div>
              <div class="info-box-content">
                <a href="#" class="dropdown-item slimMenu">
                  <div class="box-icon slimMenuicon"><i class="fa-solid fa-computer fa-2xl"></i></div>
                  <div class="box-text"><span class="info-box-text spanCss">프로젝트</span></div>
                </a>
              </div>
            </div>
            
          </div>   
        </li>
      </ul>
  
      <!-- Right navbar links -->
      <ul class="navbar-nav ml-auto">
        
        <!-- 푸쉬 알람 영역 -->
        <li class="nav-item dropdown">
          <a class="nav-link" data-toggle="dropdown" href="#">
            <i class="far fa-bell"></i><!--알람 아이콘-->
            <span class="badge badge-warning navbar-badge">15</span>
          </a>
          <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
            <span class="dropdown-item dropdown-header">15 Notifications</span>
            <div class="dropdown-divider"></div>
            <a href="#" class="dropdown-item">
              <i class="fas fa-envelope mr-2"></i> 4 new messages
              <span class="float-right text-muted text-sm">3 mins</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="#" class="dropdown-item">
              <i class="fas fa-users mr-2"></i> 8 friend requests
              <span class="float-right text-muted text-sm">12 hours</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="#" class="dropdown-item">
              <i class="fas fa-file mr-2"></i> 3 new reports
              <span class="float-right text-muted text-sm">2 days</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
          </div>
        </li>
        <!-- 푸쉬 알람 영역끝 -->

       <c:if test="${loginUser.superRight == 'Y' || loginUser.hrRight == 'Y'}">
				  <li class="nav-item dropdown">
				    <a class="nav-link" data-toggle="dropdown" href="#">
				      <i class="fas fa-th-large"></i>
				    </a>
				    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
				      <span class="dropdown-item dropdown-header">페이지 이동하기</span>
				      <div class="dropdown-divider"></div>
				      <a href="${contextPath}/main" class="dropdown-item">
				        <i class="fa-solid fa-briefcase mr-2"></i> Office
				      </a>
				      <div class="dropdown-divider"></div>
				      <a href="${contextPath}/hr/hrPage" class="dropdown-item">
				        <i class="fas fa-users mr-2"></i> HR 
				      </a>
				    </div>
				  </li>
				</c:if>
        
        
         
       <!--로그인 유저 프로필이 나오는곳-->
         <li class="nav-item dropdown">
           <a class="nav-link" data-toggle="dropdown" href="#">
           
               <c:choose>
					        <c:when test="${not empty loginUser.profileUrl}">
					            <img class="profile-user-img img-fluid img-circle"
					                 src="${contextPath}${loginUser.profileUrl}"
					                 alt="" style="width: 30px; height: 30px;">
					        </c:when>
					        <c:otherwise>
					            <img class="profile-user-img img-fluid img-circle"
					                 src="${contextPath}/resources/images/common/defaultProfile.png"
					                 alt="" style="width: 30px; height: 30px;">
					        </c:otherwise>
					    </c:choose>
            
           </a>
           <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
             
             <div class="dropdown-divider"></div>
             

             <a href="${contextPath }/member/myinfo.page" class="dropdown-item">
               <i class="fa-solid fa-image-portrait mr-2"></i> 마이페이지
               
             </a>
             <div class="dropdown-divider"></div>
             <a href="${contextPath }/member/loginout.me" class="dropdown-item">
               <i class="fas fa-solid fa-right-from-bracket"></i> 로그아웃 
               
             </a>
           
           </div>  
          </li>
        
        
      </ul>
    </nav>
	</div>
</body>
</html>