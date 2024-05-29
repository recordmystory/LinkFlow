<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더 사이드바</title>
<!-- jstree JavaScript 파일 추가 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
  <!-- jstree CSS 파일 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
 
<style>
 /*캘린더 색지정 스타일*/
    
    .calCheckbox {
    display: none; /* 기본 체크박스 숨기기 */
    }

    .calCheckbox + label {
        display: inline-block; /* 레이블을 옆에 표시 */
        cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능하게 만듦 */
    }

    .calCheckbox + label::before {
        content: "";
        display: inline-block;
        width: 15px;
        height: 15px;
        border-radius: 30%;
        border: 2px solid rgba(211, 211, 211, 0.275) ;
        margin-right: 10px; /* 체크박스와 텍스트 사이의 간격 설정 */
        margin-bottom: 4px;
        vertical-align: middle; /* 수직 정렬을 위해 중앙에 위치 */
    }

    #personalCalCheckbox:checked + label::before {
        background-color: #358657c3 ;
    }
    #departCalCheckbox:checked + label::before {
        background-color: #104fa1c3 ;
    }
    #companyCalCheckbox:checked + label::before {
        background-color: #a82626c3 ;
    }

    /*공유캘린더 색상 지정 스타일 수정예정*/
    #shareCheckbox1:checked + label::before {
        background-color: #f7fbb6c3 ;
    }
    #shareCheckbox2:checked + label::before {
        background-color: #79bdeac3 ;
    }
    #shareCheckbox3:checked + label::before {
        background-color: #ea9979c3 ;
    }


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
	/*캘린더 사이드바*/
  .shareCalMoreBtn{
    font-size: small;
    font-weight: bold;
    color: rgba(245, 242, 242, 0.55);
  }
	.sideSmall{
	 padding-left: 20px;
	}
	
/*여기까지 공용스타일*/

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
        <div class="LinkFlowInsertBtnArea">
          <button class="btn btn-block bg-gradient-primary btn-lg schInsertModalBtn" id="scheduleInsertButton" data-bs-target="#schInsertModal" data-bs-toggle="modal">+ 일정 등록</button>
        </div>

        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

        <li class="sidebarName">
        		<a href="${contextPath}/calendar/calMain.page">캘린더</a>
        </li><br>
    
        <li class="nav-item">
            <a href="#" class="nav-link middleName">                         
            <p>
                내 캘린더
                <i class="fas fa-angle-left right"></i>
            </p>
            </a>

           <ul class="nav nav-treeview" style="padding-left: 20px;">
					    <li class="nav-item">
					        <a href="#" class="nav-link">
					            <input type="checkbox" id="personalCalCheckbox" class="calCheckbox personalCal-checkbox" value="03" >
					            <label for="personalCalCheckbox">개인 캘린더</label>
					        </a>
					    </li>
					    <li class="nav-item">
					        <a href="#" class="nav-link">
					            <input type="checkbox" id="departCalCheckbox" class="calCheckbox departCal-checkbox" value="02">
					            <label for="departCalCheckbox">부서 캘린더</label>
					        </a>
					    </li>
					    <li class="nav-item">
					        <a href="#" class="nav-link">
					            <input type="checkbox" id="companyCalCheckbox" class="calCheckbox companyCal-checkbox" value="01">
					            <label for="companyCalCheckbox">전사 캘린더</label>
					        </a>
					    </li>
					</ul>
        </li>
        

        <!-- <li class="nav-item">

          <a href="#" class="nav-link middleName">
          
          <p>
              공유 캘린더
              <i class="fas fa-angle-left right"></i>                                                
          </p>
         
          </a>

        <ul class="nav nav-treeview" style="padding-left: 20px;">
          <li class="nav-item">
              <a href="#" class="nav-link">
          
                <input type="checkbox" id="shareCheckbox1" class="calCheckbox shareCheckbox1">
                <label for="shareCheckbox1">홍지우 팀장&lt;개발1팀&gt;</label>
                    
              </a>
          </li>                       
          <li class="nav-item">
            <a href="#" class="nav-link">
          
              <input type="checkbox" id="shareCheckbox2" class="calCheckbox shareCheckbox2">
              <label for="shareCheckbox2">엄두강 사원&lt;개발2팀&gt;</label>
                  
            </a>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
          
              <input type="checkbox" id="shareCheckbox3" class="calCheckbox shareCheckbox2">
              <label for="shareCheckbox3">조성모 사원&lt;인사1팀&gt;</label>
                  
            </a>
          </li>
          <li class="nav-item d-flex justify-content-center">
            <button type="button" class="btn shareCalMoreBtn" data-bs-target="#shareCalMoreModal" data-bs-toggle="modal">더보기</button>
          </li>
        </ul>
      </li>-->
      <div class="nav-item">
        <a href="${contextPath}/calendar/wasteList.page" class="nav-link middleName">휴지통</a>
      </div>
    </nav> 
    <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
	</aside>
	<!--사이드바 끝-->
 </div>
 
<script>
/* document.addEventListener('DOMContentLoaded', function() {
    var scheduleInsertButton = document.getElementById('scheduleInsertButton');

    if (window.location.href.includes("${contextPath}/calendar/wasteList.page")) {
        scheduleInsertButton.style.display = 'none';
    }
}); */
</script>          
</body>
</html>