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
 <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">
  <div class="sidebar">
  	<nav class="linkfoiwsideMenu">
    	<div class="LinkFlowInsertBtnArea">
      	<a href="${contextPath }/board/registForm.page" class="btn btn-block bg-gradient-primary btn-lg" style="color:white">게시글 작성하기</a>
    	</div>
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
	      <li class="sidebarName">
	        <span>게시판</span>
	      </li><br>
	      <li class="nav-item">
	          <a href="${contextPath }/board/list.do" class="nav-link middleName">
	            <i class="nav-icon far-2xl fa-solid fa-check"></i>
	            <p>사내공지</p>
	          </a>
	      </li>
      	<li class="nav-item">
        	<a href="#" class="nav-link middleName">
          	<i class="nav-icon far fa-solid fa-user-group"></i>
          	<p>
              게시판
              <i class="fas fa-angle-left right" ></i>
          	</p>
        	</a>
        	<ul id="boardCategory" class="nav-item nav-treeview" style="padding-left: 20px;">
        		
        		<c:forEach var="c" items="${categoryList}">
        			<a href="${contextPath }/board/list.do?type=${c.boardCategory}" class="nav-link">
              	<i class="far fa-circle nav-icon"></i>
              	<p>${c.categoryName }게시판</p>
            	</a>
        		</c:forEach>
        		
        	</ul>
        </li>	
        <li class="nav-item">
          <a href="#" class="nav-link middleName">
            <i class="nav-icon far-2xl fa-solid fa-gear"></i>
            <p>
                게시판 관리
                <i class="fas fa-angle-left right" ></i>
            </p>
          </a>
         	<ul class="nav-item nav-treeview" style="padding-left: 20px;">
              <a href="${contextPath }/board/tempSave.page" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p style="padding-left: 5px;">임시저장</p>
              </a>
              <a href="${contextPath }/board/trash.page" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p style="padding-left: 5px;">휴지통</p>
              </a>
              <c:if test="${loginUser.superRight == 'Y' or loginUser.boardRight == 'Y' }">
	              <a href="${contextPath }/board/createBoard.page" class="nav-link">
	                <i class="far fa-circle nav-icon"></i>
	                <p style="padding-left: 5px;">게시판 만들기</p>
	              </a>
              </c:if>
       		</ul>
      	</li>
  		</nav>
	  </div>
	</aside>
</div>
</body>
</html>