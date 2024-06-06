<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
	                <!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-->
	                <c:if test="${not empty loginUser and loginUser.position eq '팀장' and fn:contains(loginUser.deptName, '개발')}">
		                <div class="LinkFlowInsertBtnArea">
		                    <a href="${contextPath}/project/addForm.pj" class="btn btn-block bg-primary btn-lg" style="color: white;">+ 프로젝트 등록</a>
		                </div>
	                </c:if>
	                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
	                    data-accordion="false">
	                    <li class="sidebarName">프로젝트 관리</li><br>
	                    <li class="nav-item">
	                        <a href="#" class="nav-link middleName">
	                            <i class="nav-icon far fa-solid fa-desktop"></i>
	                            <p>
	                                프로젝트 현황
	                                <i class="fas fa-angle-left right"></i>
	                            </p>
	                        </a>
	                        <ul class="nav nav-treeview" style="padding-left: 20px;">
	                            <li class="nav-item">
	                                <a href="${contextPath}/project/list.pj" class="nav-link">
	                                    <i class="far fa-circle nav-icon"></i>
	                                    <p>프로젝트 목록 조회</p>
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a href="${contextPath}/project/list.dis" class="nav-link">
	                                    <i class="far fa-circle nav-icon"></i>
	                                    <p>프로젝트 인원 조회</p>
	                                </a>
	                            </li>
	                        </ul>
	                    </li>
	                    <c:if test="${not empty loginUser and fn:contains(loginUser.deptName, '개발')}">
		                    <li class="nav-item">
		                        <a href="#" class="nav-link middleName">
		                            <i class="nav-icon far fa-solid fa-pen"></i>
		                            <p>
		                                일일작업 관리
		                                <i class="fas fa-angle-left right"></i>
		                            </p>
		                        </a>
		                        <ul class="nav nav-treeview" style="padding-left: 20px;">
		                        	<c:if test="${not empty loginUser and loginUser.position ne '팀장' and fn:contains(loginUser.deptName, '개발')}">
			                            <li class="nav-item">
			                                <a href="${contextPath}/project/list.dai" class="nav-link">
			                                    <i class="far fa-circle nav-icon"></i>
			                                    <p>일일작업 조회</p>
			                                </a>
			                            </li>
		                            </c:if>
		                            <c:if test="${not empty loginUser and loginUser.position eq '팀장' and fn:contains(loginUser.deptName, '개발') or loginUser.userName eq '조미연'}">
			                            <li class="nav-item">
			                                <a href="${contextPath}/project/listLead.dai?deptCode=${loginUser.deptCode}" class="nav-link">
			                                    <i class="far fa-circle nav-icon"></i>
			                                    <p>직원별 일일작업 조회</p>
			                                </a>
			                            </li>
		                            </c:if>
		                        </ul>
		                    </li>
	                    </c:if>
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