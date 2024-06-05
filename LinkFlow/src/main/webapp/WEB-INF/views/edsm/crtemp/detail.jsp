<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 상세</title>

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
	.contentInElement{display: block !important; justify-content: space-between; margin-bottom: 30px;}
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

    /* 이 페이지내에서만 쓸 CSS 추가 */
    .setting-table > th {
      width: 5px;
    }

    .content-element{
      padding: 15px 0px 15px 0px;
    }


    .content-area > div:not(.drafting-content) > div  {
      margin-top: 30px;
    }

    .btnArea{
      margin-bottom: 30px;
    }

    .ck-editor__editable{
      min-height: 600px;
    }

    .table-bordered td, .table-bordered th {
      width: 5px;
    }

    /* 모달 높이 설정 */
    .modal-content{
        height: 700px;
    }

    /* 버튼 간격 조절 */
    button {
      margin-right: 6px;
    }

    /* 버튼 밑 간격 조절 */
    .btnArea{
      margin-bottom: 40px;
    }
    
    /* 문서 영역 스타일 */
    .drafting-content-document 
    { 
	    border: 2px solid lightgray; 
	    padding: 25px 10px 25px 10px; 
	    margin: 40px 0px 0px 0px !important; 
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center; 
    }
		.drafting-content-document > h1 { text-align: center !important; margin: 30px; } 
		.drafting-content-document > .table { display: flex; flex-direction: column; align-items: center; }
	  .ck-table-resized { min-width: 1500px; }
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
                <h1 class="m-0">양식 상세</h1>
              </div>
            </div>
          </section>
               
          <!-- Main content -->
          <section class="content">
           <div class="container-fluid" style="display: flex; justify-content: center;"> 
             <div class="contentArea">

               <div class="contentInElement">
               	<c:if test="${loginUser.userId eq crtp.regId}">
	                 <form id="fr" action="" method="post">
	                 	 <input type="hidden" name="edFrCode" value="${crtp.edFrCode}">
		                 <div class="btnArea"> 
		                   <button type="submit" class="btn btn-primary btn-sm" onclick="frSubmit(1);">수정</button>
		                   <button type="submit" class="btn btn-danger btn-sm" onclick="frSubmit(2);">삭제</button>
		                 </div>
	                 </form>
                 </c:if>

                 <!-- 기본 설정-->
                 <div class="default-setting">
                     <h6>기본 설정</h6>
                     <table class="table table-bordered setting-table">
                       <tbody>
                         <tr>
                           <th class="table-active">양식명</th>
                           <td colspan="4">
                             ${crtp.edFrName} 
                           </td>
                         </tr>
                         <tr>
                           <th class="table-active">보존 연한</th>
                           <td>
                               <c:choose>
						                    <c:when test="${crtp.presDate == 0}">
						                        영구
						                    </c:when>
						                    <c:otherwise>
						                        ${crtp.presDate}년
						                    </c:otherwise>
						                	</c:choose>
                           </td>
                           <th class="table-active">보안 등급</th>
                           <td>
                             ${crtp.secCode}등급
                           </td>
                         </tr>
                       </tbody>
                     </table> 


                 <!-- 별첨 -->
                 <!-- <div class="attachment" style="margin-bottom: 25px;">
                   <h6>별첨</h6>
                   <input class="form-control" type="file" id="formFileMultiple" multiple>
                 </div> -->

                 <div class="drafting-content">
                   <h6>본문</h6>
                   <div class="drafting-content-document">
                   	${crtp.edFrContent}
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
		function frSubmit(num){
			$('#fr').attr("action", num == 1 ? "${contextPath}/edsm/crtemp/modifyForm.crtp" 
						: "${contextPath}/edsm/crtemp/remove.crtp");
		}
	</script>
</body>
</html>