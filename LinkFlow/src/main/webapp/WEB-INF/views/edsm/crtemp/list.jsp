<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 목록</title>
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
                  <h1 class="m-0" id="header-title">양식 생성 목록</h1>
              </div>
            </div>
            <div class="search d-flex justify-content-end">
              <div class="input-group col-4" style="height: 100%;">
                <input type="search" class="form-control" placeholder="문서 제목을 입력해주세요">
                <div class="input-group-append">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
              </div>
            </div>
          </section>
               
          <!-- Main content -->
          <section class="content">
           <div class="container-fluid" style="display: flex; justify-content: center;"> 
             <div class="contentArea">

               <div class="contentInElement">
                 <div style="min-height: 500px; min-width: 100%;">
	                  <table class="table table-bordered table-hover document-list">
	                    <thead class="table table-active">
	                      <tr>
	                        <th>양식명</th>
	                        <th>작성자</th>
	                        <th>작성일</th>
	                        <th>보안등급</th>
	                      </tr>
	                    </thead>
	                    <tbody>
	                      <tr>
	                        <td>품의서</td>
	                        <td>김과장</td>
	                        <td>2024-04-29</td>
	                        <td>A등급</td>
	                      </tr>
	                      <tr>
	                          <td>품의서</td>
	                          <td>김과장</td>
	                          <td>2024-04-29</td>
	                          <td>A등급</td>
	                      </tr>
	                      <tr>
	                          <td>품의서</td>
	                          <td>김과장</td>
	                          <td>2024-04-29</td>
	                          <td>A등급</td>
	                        </tr>
	                    </tbody>
	                  </table>
	
	                  <ul class="pagination justify-content-center">
	                    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
	                    <li class="page-item"><a class="page-link" href="#">1</a></li>
	                    <li class="page-item active"><a class="page-link" href="#">2</a></li>
	                    <li class="page-item"><a class="page-link" href="#">3</a></li>
	                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
	                  </ul>
	                </div> 
           </div>
         </div>
       </div>
     </section>
   	</div>
	</div>
</body>
</html>