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
    
    tr > td { cursor: pointer; }
    
    .content-header { margin-bottom: 50px; }
    
    #pagingArea{ margin-top: 30px; }
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
            <form id="searchForm" action="${contextPath}/edsm/crtemp/search.crtp" method="get">
	             <input type="hidden" name="page" value="1">
	             <div class="search d-flex justify-content-end">
	              <div class="input-group col-4" style="height: 100%;">
	                <input type="search" name="keyword" class="form-control" placeholder="양식명을 입력해주세요">
	                <div class="input-group-append">
	                    <button type="submit" class="btn btn-primary">
	                        <i class="fa fa-search"></i>
	                    </button>
	                </div>
	              </div>
	            </div>
            </form>            
           
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
	                    	<c:choose>
	                    		<c:when test="${empty list}">
	                    			조회된 양식이 없습니다.
	                    		</c:when>
	                    		
	                    		<c:otherwise>
	                    			<c:forEach var="f" items="${list}">
	                    				<tr onclick="location.href='${contextPath}/edsm/crtemp/detail.crtp?no=${f.edFrCode}';">
	                    					<td>${f.edFrName}</td>
	                    					<td>${f.regId}</td>
	                    					<td>${f.regDate}</td>
	                    					<td>${f.secCode}등급</td>
	                    				</tr>
	                    			</c:forEach>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                  </table>
	                  
									<div id="pagingArea">
	                  <ul class="pagination justify-content-center">
	                    <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/crtemp/list.crtp?page=${pi.currentPage - 1}">&lt; &lt;</a></li>
	                    
	                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
	                    	<li class="page-item ${pi.currentPage == p ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/crtemp/list.crtp?page=${p}">${p}</a></li>
	                    </c:forEach>
	                    
	                    <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/crtemp/list.crtp?page=${pi.currentPage + 1}">&gt; &gt;</a></li>
                		</ul>
                	</div>
                	
	            </div> 
           </div>
         </div>
       </div>
     </section>
   	</div>
	</div>
	
	<c:if test="${not empty search}">
		<script>
			$(function(){
				$('#pagingArea a').on('click', function(){
					$('#searchForm input[name=page]').val($(this).text());
					$('#searchForm').submit();
					return false;
				});
			});
			
		</script>
	</c:if>
</body>
</html>