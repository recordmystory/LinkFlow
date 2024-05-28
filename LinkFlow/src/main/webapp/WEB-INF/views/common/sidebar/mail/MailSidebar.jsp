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
        <a href="${contextPath }/mail/registForm.page" class="btn btn-block bg-primary btn-lg">메일 작성하기</a>
          </div>
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
    
            <li class="sidebarName">
              <span>메일 </span>
            </li><br>
        
            <li class="nav-item">
                <a href="${ contextPath }/mail/receiveList.do" class="nav-link middleName">
                  <i class="nav-icon far-2xl fa-solid fa-inbox"></i>
                  <p>받은메일 <c:if test="${countMap.readCount != 0 }">(${ countMap.readCount})</c:if></p>
                </a>
            </li>

            <li class="nav-item">
              <a href="${ contextPath }/mail/sendList.do" class="nav-link middleName">
                <i class="nav-icon far-2xl fa-solid fa-paper-plane"></i>
                <p>보낸메일</p>
              </a>
            </li>

          <li class="nav-item">
            <a href="${ contextPath }/mail/tempSave.page" class="nav-link middleName">
              <i class="nav-icon far-2xl fa-solid fa-file"></i>
              <p>임시저장</p>
            </a>
          </li>

          <li class="nav-item">
            <a href="${ contextPath }/mail/trash.page" class="nav-link middleName">
              <i class="nav-icon far-2xl fa-solid fa-trash"></i>
              <p>휴지통 <c:if test="${countMap.trashCount != 0 }">(${ countMap.trashCount})</c:if></p>
            </a>
          </li>

    </nav>
   </div>
	</aside>
</div>
</body>
</html>