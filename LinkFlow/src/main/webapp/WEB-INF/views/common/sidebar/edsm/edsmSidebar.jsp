<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재 사이드바</title>

<!-- jstree CSS 파일 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<!-- jstree JavaScript 파일 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>

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

     <!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-->
     <div class="LinkFlowInsertBtnArea">
       <a href="${ contextPath }/edsm/prog/apprEnrollForm.prog" class="btn btn-block bg-primary btn-lg">+ 작성하기</a>
   
     </div>

     
       <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

       <li class="sidebarName">전자결재</li><br>
   
       <li class="nav-item">

           <a href="${ contextPath }/edsm/prog/listAll.prog" class="nav-link middleName">
             <i class="fa-solid fa-clipboard-check fa-lg"></i>&nbsp;&nbsp;
             진행 중인 문서
           <p>
               
               <!-- <i class="fas fa-angle-left right"></i> -->
           </p>
           </a>

           <%-- <ul class="nav nav-treeview" style="padding-left: 20px;">
           <li class="nav-item">
               <a href="${ contextPath }/edsm/prog/listAll.prog" class="nav-link">
               <i class="far fa-circle nav-icon"></i>
               <p>전체</p>
               </a>
           </li>
           <li class="nav-item">
               <a href="${ contextPath }/edsm/prog/listWait.prog" class="nav-link">
               <i class="far fa-circle nav-icon"></i>
               <p>대기</p>
               </a>
           </li>
           <li class="nav-item">
             <a href="${ contextPath }/edsm/prog/listPlan.prog" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>예정</p>
             </a>
         </li>
         <li class="nav-item">
           <a href="${ contextPath }/edsm/prog/listProg.prog" class="nav-link">
           <i class="far fa-circle nav-icon"></i>
           <p>진행</p>
           </a>
       </li>
       <li class="nav-item">
         <a href="${ contextPath }/edsm/prog/listCheck.prog" class="nav-link">
         <i class="far fa-circle nav-icon"></i>
         <p>확인</p>
         </a>
     </li>
         

           </ul> --%>
       </li>


       <li class="nav-item">

         <a href="${ contextPath }/edsm/docbox/listAll.docbox" class="nav-link middleName">
         <i class="fa-solid fa-box-archive fa-lg"></i>&nbsp;&nbsp;
         
         <p>
             문서함
             <!-- <i class="fas fa-angle-left right"></i> -->
             
         </p>
         </a>

         <%-- <ul class="nav nav-treeview" style="padding-left: 20px;">
           <li class="nav-item">
             <a href="${ contextPath }/edsm/docbox/listAll.docbox" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>전체</p>
             </a>
           </li>

           <li class="nav-item">
             <a href="${ contextPath }/edsm/docbox/listDraft.docbox" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>기안</p>
             </a>
           </li>

           <li class="nav-item">
             <a href="${ contextPath }/edsm/docbox/listAppr.docbox" class="nav-link active">
             <i class="far fa-circle nav-icon"></i>
             <p>결재</p>
             </a>
           </li>

           <li class="nav-item">
             <a href="${ contextPath }/edsm/docbox/listRef.docbox" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>참조</p>
             </a>
           </li>

           <li class="nav-item">
             <a href="${ contextPath }/edsm/docbox/listReject.docbox" class="nav-link">
             <i class="far fa-circle nav-icon"></i>
             <p>반려</p>
             </a>
           </li>
         </ul> --%>
     </li>

     <%-- <li class="nav-item">

       <a href="${ contextPath }/edsm/tmpsave/list.tpsv" class="nav-link middleName">
       <i class="fa-solid fa-file-circle-check fa-lg"></i>&nbsp;&nbsp;
       
      
       <p>
           임시저장
          
       </p>
       </a>
     
     </li> --%>
      
     <li class="nav-item">

       <a href="${ contextPath }/edsm/sign/setting.sg" class="nav-link middleName">
         <i class="fa-solid fa-gear fa-lg"></i>&nbsp;&nbsp;
       
      
       <p>
           서명설정
          
       </p>
       </a>
     
     </li>
		
		<c:if test="${loginUser.superRight == 'Y' or loginUser.hrRight == 'Y'}">
     <li class="nav-item">

       <a href="#" class="nav-link middleName">
         <i class="fa-solid fa-gear fa-lg"></i>&nbsp;&nbsp;
       
      
       <p>
           양식 생성
           <i class="fas fa-angle-left right"></i>
       </p>
       </a>
       
       <ul class="nav nav-treeview" style="padding-left: 20px;">
         <li class="nav-item">
           <a href="${ contextPath }/edsm/crtemp/list.crtp" class="nav-link">
           <i class="far fa-circle nav-icon"></i>
           <p>양식 목록</p>
           </a>
         </li>

         <li class="nav-item">
           <a href="${ contextPath }/edsm/crtemp/enrollForm.crtp" class="nav-link">
           <i class="far fa-circle nav-icon"></i>
           <p>양식 생성</p>
           </a>
         </li>

       </ul>
     </li>
    </c:if>
     
   </nav>
   <!-- /.sidebar-menu -->
   </div>
   <!-- /.sidebar -->
</aside>
<!--사이드바 끝-->
</div>

</body>
</html>