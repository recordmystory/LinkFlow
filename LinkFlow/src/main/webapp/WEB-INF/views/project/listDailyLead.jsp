<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 직원별일일작업조회</title>
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
 /*여기까지 메인 영역 요소  공용 스타일임 */


</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		
		<div class="LinkFlowMainSection">
			<jsp:include page="/WEB-INF/views/common/sidebar/project/projectSidebar.jsp"/>
			
			<div class="LinkFlowMainContent">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0">직원별 일일작업 조회</h1>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;">
                        <div class="contentArea">
                            <div class="contentInElement">
                                <div class="btnArea">
                                </div>
                                <div class="form-inline" style="display: flex; flex-direction: column;">
                                    <form action="${contextPath}/project/searchLead.dai" method="post" id="searchForm">
                                		<input name="page" type="hidden" value="1">
                                		<input name="deptCode" type="hidden" value="${loginUser.deptCode}">
		                                <div style="margin-bottom: 10px;">
		                                    <input class="form-control form-control-sidebar" name="startDate" type="date" style="width: 150px;" value="${search.startDate}">&nbsp;&nbsp; ~ &nbsp;&nbsp;<input class="form-control form-control-sidebar" name="endDate" type="date" value="${search.endDate}">
		                                </div>
		                                <div class="input-group">
		                                    <div class="select" style="margin-right: 15px;">
		                                        <select name="category" id="bottom-menu" class="form-control bottom-menu" style="width: 150px;">
		                                            <option value="proName">프로젝트명</option>
		                                            <option value="userName">이름</option>
		                                        </select>
		                                    </div>
		                                    <input class="form-control form-control-sidebar" name="keyword" type="search" placeholder="Search" aria-label="Search" value="${search.keyword}">
		                                    <div class="input-group-append">
		                                        <button type="submit" class="btn btn-primary">
		                                            <i class="fas fa-search fa-fw"></i>
		                                        </button>
		                                    </div>
		                                </div>
	                                </form>
                                </div>
                            </div>
                            <div style="min-height: 500px; min-width: 100%;">
                                <div class="card">
                                    <div class="card-body">
                                        <table id="example2" class="table table-hover text-nowrap" style="text-align: center;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 10%;">NO</th>
                                                    <th style="width: 30%;">프로젝트명</th>
                                                    <th style="width: 10%;">이름</th>
                                                    <th style="width: 15%;">작성일</th>
                                                    <th style="width: 15%;">답변일</th>
                                                    <th style="width: 10%;">피드백</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach var="d" items="${list}"> 
	                                                <tr>
	                                                    <td>${d.daiNo}</td>
	                                                    <td>
	                                                        <a href="${contextPath}/project/detailLead.dai?no=${d.daiNo}">${d.proTitle}(${d.client})</a>
	                                                    </td>
	                                                    <td>${d.userName}</td>
	                                                    <td>${d.regDate}</td>
	                                                    <td>${d.ansDate}</td>
	                                                    <td>
	                                                    	<c:if test="${d.daiAns != null }">
	                                                    	<i class="fa-solid fa-check"></i>
	                                                    	</c:if>
                                                    	</td>
	                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="pagingArea">
										<div class="pagination" style="display: flex; justify-content: center;">
											<ul class="pagination">
												<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/listLead.dai?page=${pi.currentPage -1}&deptCode=${loginUser.deptCode}">&laquo;</a>
												</li>
												<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
													<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }">
														<a class="page-link" href="${contextPath}/project/listLead.dai?page=${p}&deptCode=${loginUser.deptCode}">${p}</a>
													</li>
												</c:forEach>
												<li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/listLead.dai?page=${pi.currentPage +1}&deptCode=${loginUser.deptCode}">&raquo;</a>
												</li>
											</ul>
										</div>
									</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
		</div>
	</div>
	<c:if test="${ not empty search }">
		<script>
		$(document).ready(function () {
	        $("#searchForm select").val("${search.category}");
			
	        $("#pagingArea a").on("click", function(){
	        	if($(this).text() == "«"){
	     			$("#searchForm input[name=page]").val(${pi.currentPage - 1});
	        	}else if($(this).text() == "»"){
	     			$("#searchForm input[name=page]").val(${pi.currentPage + 1});
	        	}else{
	     			$("#searchForm input[name=page]").val($(this).text());
	        	}
     			$("#searchForm").submit();
     			return false;
	   		});
		});
		</script>
	</c:if>
</body>
</html>