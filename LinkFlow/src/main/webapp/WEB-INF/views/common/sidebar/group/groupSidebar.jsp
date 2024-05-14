<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div class="LinkFlowSidebar">
           <!-- Main Sidebar Container -->
   <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">

   <!-- Sidebar -->
   <div class="sidebar">

   <!-- Sidebar Menu -->
   <nav class="linkfoiwsideMenu">

       <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

       <li class="sidebarName">조직도</li><br>
   
       <li class="nav-item menu-open">

         <a href="#" class="nav-link middleName">
         <i class="nav-icon far fa-solid fa-people-line"></i>
         
         <p>
             부서별 보기
             <i class="fas fa-angle-left right"></i>
         </p>
         </a>

         <ul class="nav nav-treeview" style="padding-left: 20px;">
         <li class="nav-item">
             <a href="#" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>부서 1</p>
             </a>
         </li>

         </ul>
     		</li>
     		</ul>
   </nav>
   <!-- /.sidebar-menu -->
   </div>
   <!-- /.sidebar -->
</aside>
<!--사이드바 끝-->
</div>
</body>
</html>