<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진행중인 문서 목록 : 전체</title>
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
	.contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
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
                      <h1 class="m-0" id="header-title">전체 (${listCnt})</h1>
                  </div>
                </div>
                <form id="searchForm" action="${contextPath}/edsm/prog/search.prog" method="get">
                <div class="search d-flex justify-content-end"> 
	                  <input type="hidden" name="page" value="1">
	                  <select name="condition" id="bottom-menu" class="form-control bottom-menu" style="width: 150px;">
	                    <!-- <option value="01">대기</option>
	                    <option value="02">예정</option>
	                    <option value="03">확인</option> -->
	                    <option value="04">진행</option>
	                  </select> 
	                  <div class="input-group col-4" style="height: 100%;">
	                    <input type="search" class="form-control" name="keyword" value="${search.keyword}" placeholder="제목을 입력해주세요">
	                    <div class="input-group-append">
	                        <button type="submit" class="btn btn-primary">
	                            <i class="fa fa-search"></i>
	                        </button>
	                    </div>
	                  </div>
                  </form>
                  
                </div>
          <!-- /.container-fluid -->
          
          </section>
          
         <c:if test="${ not empty search }">
	         <script>
	         	$(document).ready(function(){
	         		$("#searchForm select").val("${search.condition}");
	         		
	         		// 검색후 페이지일 경우 페이징바의 페이지 클릭시 
	         		$("#pagingArea a").on("click", function(){
	         			$("#searchForm input[name=page]").val($(this).text());
	         			$("#searchForm").submit();
	         		
	         			return false; // 기본이벤트 제거(즉, a태그에 작성되어있는 href="/list.do" 실행안되도록)
	         		})
	         	})
	         </script>
         </c:if>
         
                <!-- Main content -->
                <section class="content">
	                <div class="container-fluid" style="display: flex; justify-content: center;"> 
	                  <div class="contentArea">
	
	                    <div class="contentInElement">
	                        <div style="min-height: 500px; min-width: 100%;">
	                        <table class="table table-bordered table-hover document-list">
	                          <thead class="table table-active">
	                            <tr>
	                              <th>문서번호</th>
	                              <th>제목</th>
	                              <th>기안자</th>
	                              <th>기안일</th>
	                              <th>구분</th>
	                              <th>상태</th>
	                            </tr>
	                          </thead>
	                          <tbody>
	                          		
                      				
	                          	<c:choose>
	                          		<c:when test="${empty list}">
	                          			<tr><td colspan="10" style="text-align: center;">조회된 문서가 없습니다.</td></tr>
	                          		</c:when>
	                          		
	                          		<c:otherwise>
	                          			<c:forEach var="ed" items="${list}">
	                          			<!-- 로그인한 사용자 -->
	                          				<tr onclick="location.href='${contextPath}/edsm/prog/detail.prog?edNo=' + '${ed.edNo}'">
		                          					<td>${ed.edNo}</td>
		                          					<td>${ed.edTitle}</td>
		                          					<td>${ed.regId}</td>
		                          					<td>${ed.regDate}</td>
		                          					<td>${ed.edFormCode}</td>
		                          					<td>${ed.status}</td>
					                         </tr>
	                          			</c:forEach>
	                          		</c:otherwise>
	                          	</c:choose>
	                            <!-- <tr>
	                              <td>LI-품의-20240429-0003</td>
	                              <td>품의서 제출</td>
	                              <td>김과장</td>
	                              <td>2024-04-29</td>
	                              <td>품의서</td>
	                              <td>결재중</td>
	                            </tr> -->
	                            <!-- <tr>
	                                <td>LI-지출-20240429-0002</td>
	                                <td>지출결의서 제출</td>
	                                <td>안차장</td>
	                                <td>2024-04-29</td>
	                                <td>지출결의서</td>
	                                <td>결재완료</td>
	                            </tr>
	                            <tr>
	                                <td>LI-품의-20240429-0001</td>
	                                <td>품의서 제출</td>
	                                <td>김과장</td>
	                                <td>2024-04-29</td>
	                                <td>품의서</td>
	                                <td>대기</td>
	                            </tr> -->
	                          </tbody>
	                        </table>
	    
	                        <div id="pagingArea">
					                  <ul class="pagination justify-content-center">
					                    <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/prog/listAll.prog?page=${pi.currentPage - 1}">&lt; &lt;</a></li>
					                    
					                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
					                    	<li class="page-item ${pi.currentPage == p ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/prog/listAll.prog?page=${p}">${p}</a></li>
					                    </c:forEach>
					                    
					                    <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : ''}"><a class="page-link" href="${contextPath}/edsm/prog/listAll.prog?page=${pi.currentPage + 1}">&gt; &gt;</a></li>
				                		</ul>
				                	</div>
	                        
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
    </div>
            
	<script>
		$(document).ready(function() {
		
		/*   let headOriginalValue = $('#header-title').text();
		  let trCount = $('table tr').length - 1;
		  
		
		    // 추가
		    // 테이블 내에 있는 행 개수 count
		      $('#header-title').text(headOriginalValue + ' (' + trCount + ')'); */
		});
	</script>

</body>
</html>