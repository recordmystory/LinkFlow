<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서명 설정</title>
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
	}
	.contentInElement{justify-content: space-between; margin-bottom: 30px;}
	.dmovePage {
	   padding: .0rem 0rem;
	 }
	 
	  /* 항상 사용할 CSS 추가 */
    tbody{
      background-color: white;
    }
    
    /* 해당 페이지에서 사용할 CSS 추가 */
    .bottom-menu{
      width: 20%;
    }

    .search-keyword{
      width: 300px;
    }

    .search{
      display: flex;
    }

    .header-parent {
        display: flex;
        align-items: center; /* 모든 요소를 수직으로 중앙 정렬합니다. */
    }

    .sign-setting-area{
      height: 350px;
      background-color: lightgray;
      display: flex;
    }

    .sign-setting-area > div {
      margin-top: 50px;
      margin-left: 30px;
      margin-right: 20px;
    }
    
    canvas {
        border: 1px solid lightgray;
        border-radius: 10px;
    }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="LinkFlowMainSection">
		<jsp:include page="/WEB-INF/views/common/sidebar/edsm/edsmSidebar.jsp"/>
	
        <div class="LinkFlowMainContent">
            
          <!-- Content Header (Page header) -->
          <section class="content-header content">
            <div class="row mb-2">
              <div class="col-sm-6">
                  <h1 class="m-0">서명 설정</h1>
              </div>
            </div>
          </section>
               
          <!-- Main content -->
          <section class="content">
           <div class="container-fluid" style="display: flex; justify-content: center;"> 
             <div class="contentArea">

               <div class="contentInElement">
                 <div class="sign-setting-area">
                   <div>
                     <img src="${contextPath}/resources/images/common/default_sign_approval.png" id="signImg" alt="서명이미지" style="width: 250px; height: 250px;">
                   </div>
                   <div>
                     <input class="form-control" type="file" id="formFile" style="width: 600px;"><br>
                     파일 선택 : 46 * 46 / png, jpg, jpeg 가능<br>
                     <a href="">기본으로 재설정</a>
                   </div>
                   <div>
                     <button class="btn btn-info" data-toggle="modal" data-target="#signatureModal">직접 서명</button>
                   </div>
                 </div> 
               </div>

               <!-- 저장 버튼 영역 -->
               <div class="btnArea d-flex justify-content-center">
                 <button class="btn btn-primary">저장</button>
               </div>
               
             <!-- 직접 서명할 수 있는 modal -->
             <!-- The Modal -->
             <div class="modal" id="signatureModal" style="overflow: hidden;">
               <div class="modal-dialog">
                 <div class="modal-content">

                   <!-- Modal Header -->
                   <div class="modal-header">
                     <h4 class="modal-title">마우스로 서명</h4>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                   </div>

                   <!-- Modal body -->
                   <div class="modal-body" style="overflow: hidden;">
                     <div class="canvas-signature d-flex justify-content-center">
                       <canvas id="canvas" width="250" height="250"></canvas><br>
                     </div>
                   </div>

                   <!-- Modal footer -->
                   <div class="modal-footer d-flex justify-content-center">
                     <button type="button" id="saveBtn" class="btn btn-primary" data-dismiss="modal">서명</button>
                   </div>
                 </div>
               </div>
             </div>
             
           </div>
         </div>
       </section>
     </div>
   </div>
                        
	<script>
    document.addEventListener("DOMContentLoaded", function() {
    var canvas = document.getElementById('canvas');
    var context = canvas.getContext('2d');

    context.fillStyle = '#fff'; // 캔버스 배경을 흰색으로 설정
    context.fillRect(0, 0, canvas.width, canvas.height);

    var isDrawing = false;
    var lastX = 0;
    var lastY = 0;

    canvas.addEventListener('mousedown', function(e) {
        isDrawing = true;
        [lastX, lastY] = [e.offsetX, e.offsetY];
    });

    canvas.addEventListener('mousemove', function(e) {
        if (!isDrawing) return;

        context.beginPath();
        context.moveTo(lastX, lastY);
        context.lineTo(e.offsetX, e.offsetY);
        context.strokeStyle = '#000'; // 선 색상 설정
        context.lineWidth = 5; // 선 두께 설정
        context.lineCap = 'round'; // 선 끝 모양 설정
        context.stroke();

        [lastX, lastY] = [e.offsetX, e.offsetY];
    });

    canvas.addEventListener('mouseup', function() {
        isDrawing = false;
    });

    document.getElementById('saveBtn').addEventListener('click', function() {
        var dataURL = canvas.toDataURL('image/png'); // 캔버스 이미지를 데이터 URL로 변환
        var signImg = document.getElementById('signImg');
        signImg.src = dataURL; // 이미지 요소에 데이터 URL 설정
    });
	});
    
	</script>
                        
</body>
</html>