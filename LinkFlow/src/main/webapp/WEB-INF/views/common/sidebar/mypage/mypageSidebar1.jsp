<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.LinkFlowSidebar{
    width: 15%;
    min-width: 300px;
    min-height: 400px;
}
.sidebarName{
 font-size: 32px;
 font-weight: bold;
 color: #d0d4db;
}
.middleName{
 font-size: 20px;
 font-weight: bold;
}
.linkfoiwsideMenu{
 padding: 0px 20px 0px 20px;

 margin-top: 38px;

}
.LinkFlowInsertBtnArea{
  margin-bottom: 20%;
 
}
.sideSmall{
 padding-left: 20px;
}
</style>
</head>
<body>

<div class="LinkFlowSidebar">
                    <!-- Main Sidebar Container -->
            <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">

            <!-- Sidebar -->
            <div class="sidebar">

            <!-- Sidebar Menu -->
            <nav class="linkfoiwsideMenu">

              <!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-
              <div class="LinkFlowInsertBtnArea">
                <a href="#" class="btn btn-block bg-gradient-primary btn-lg">+ 작성하기</a>
            
              </div>
              -->
              
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <li class="sidebarName">My Page</li><br>
            
                <li class="nav-item menu-open">

                    <a href="#" class="nav-link middleName">
                    <i class="nav-icon far fa-solid fa-user"></i>
                  
                    <p>
                        프로필 설정
                        <i class="fas fa-angle-left right"></i>
                    </p>
                    </a>

                    <ul class="nav nav-treeview" style="padding-left: 20px;">
                    <li class="nav-item">
                        <a href="${contextPath}/member/myinfo.page" class="nav-link active">
                        <i class="far fa-circle nav-icon"></i>
                        <p>사원정보 조회</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${contextPath}/member/myinfoUpdate.page" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>사원정보 변경</p>
                        </a>
                    </li>

                  

                    </ul>
                </li>

                <!--
                <li class="nav-item">

                  <a href="#" class="nav-link middleName">
                  <i class="nav-icon far fa-solid fa-key"></i>
                  
                  <p>
                      보안 설정
                      <i class="fas fa-angle-left right"></i>
                      
                  </p>
                  </a>

                  <ul class="nav nav-treeview" style="padding-left: 20px;">
                  <li class="nav-item">
                      <a href="#" class="nav-link">
                      <i class="far fa-circle nav-icon"></i>
                      <p>2차인증 설정</p>
                      </a>
                  </li>
                  </ul>
              </li>
            -->
              <li class="nav-item">

                <a href="#" class="nav-link middleName">
                <i class="nav-icon fa-solid fa-clock"></i>
                
              
                <p>
                    근태 관리
                    <i class="fas fa-angle-left right"></i>
                  
                </p>
                </a>

                <ul class="nav nav-treeview" style="padding-left: 20px;">
                <li class="nav-item">
                    <a href="${contextPath }/member/myAttendance.page" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>나의 근태</p>
                    </a>
                </li>
              
              

                </ul>
              
              </li>
              
                
            </nav>

            

            <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>
        <!--사이드바 끝-->
        </div>
</body>
</html>