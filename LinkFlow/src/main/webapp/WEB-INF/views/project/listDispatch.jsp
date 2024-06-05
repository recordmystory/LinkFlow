<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 프로젝트인원조회</title>
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
                            <h1 class="m-0">프로젝트 인원 조회</h1>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid" style="display: flex;">
                        <div class="contentArea">
                            <div class="contentInElement">
                                <div class="btnArea">
                                	<div style="transform: translateX(10px) translateY(80px); display: flex; justify-content: center;">
                                		<input type="checkbox" id="myProject" style="width: 20px; height: 20px;">
                                		<p style="margin-left: 10px; font-size: 20px; transform: translateY(-4px);">본인 프로젝트만 조회</p>
                                	</div>
                                </div>
                                <div class="form-inline" style="display: flex; flex-direction: column;">
                                	<form action="${contextPath}/project/search.dis" method="post" id="searchForm">
                                		<input name="page" type="hidden" value="1">
		                                <div style="margin-bottom: 10px;">
		                                    <input class="form-control form-control-sidebar" name="startDate" type="date" style="width: 150px;" value="${search.startDate}">&nbsp;&nbsp; ~ &nbsp;&nbsp;<input class="form-control form-control-sidebar" name="endDate" type="date" value="${search.endDate}">
		                                </div>
		                                <div class="input-group">
		                                    <div class="select" style="margin-right: 15px;">
		                                        <select name="category" id="bottom-menu" class="form-control bottom-menu" style="width: 150px;">
		                                            <option value="proName">프로젝트명</option>
		                                            <option value="client">고객사명</option>
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
                                        <table id="dispatchList" class="table table-hover text-nowrap" style="text-align: center;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 10%;">프로젝트 번호</th>
                                                    <th style="width: 20%;">고객사</th>
                                                    <th style="width: 25%;">프로젝트명</th>
                                                    <th style="width: 10%;">투입인원</th>
                                                    <th style="width: 15%;">담당부서</th>
                                                    <th style="width: 20%;">투입기간</th>
                                                    <th style="width: 10%;">상태</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach var="d" items="${list}"> 
                                                <tr>
                                                    <td>${d.proNo}</td>
                                                    <td>${d.client}</td>
                                                    <td>
                                                        <a href="${contextPath}/project/detail.pj?no=${d.proNo}">${d.proTitle}</a>
                                                    </td>
                                                    <td>${d.userName}</td>
                                                    <td>${d.deptTitle}</td>
                                                    <td>${d.startDate} ~ ${d.endDate}</td>
                                                    <td>투입</td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="pagingArea">
										<div class="pagination" style="display: flex; justify-content: center;">
											<ul class="pagination">
												<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/list.dis?page=${pi.currentPage -1}">&laquo;</a>
												</li>
												<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
													<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }">
														<a class="page-link" href="${contextPath}/project/list.dis?page=${p}">${p}</a>
													</li>
												</c:forEach>
												<li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/list.dis?page=${pi.currentPage +1}">&raquo;</a>
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
	<script>
	   	
		// 내 프로젝트 페이징 처리용
		var userId = '${loginUser.userId}'
		
    	function myList(page) {
			$.ajax({
            	url: '${contextPath}/project/myList.dis',
               	type: 'GET',
               	data: {
               		userId: userId,
               		page: page
               	},
               	success: function(map) {
               		updateTableAndPaging(map);
               	}
           	});
		};
		// 내 프로젝트 페이징 처리용
			
		// 테이블 페이징 새로 처리
		function updateTableAndPaging(data) {
			
			var tableBody = $('#dispatchList tbody');
		    var pagingArea = $('#pagingArea');

		    tableBody.empty();

		    $.each(data.list, function(index, item) {
		    	var row = 
			    	'<tr>'
			        +   '<td>' + item.proNo + '</td>'
			        +   '<td>' + item.client + '</td>'
			        +   '<td>'
			        +       '<a href="' + '${contextPath}/project/detail.pj?no=' + item.proNo + '">' + item.proTitle + '</a>'
			        +   '</td>'
			        +   '<td>' + item.userName + '</td>'
			        +   '<td>' + item.deptTitle + '</td>'
			        +   '<td>' + item.startDate + ' ~ ' + (item.endDate == null ? '' : item.endDate) + '</td>'
			        +   '<td>' + '투입' + '</td>'
			        + '</tr>';
		        tableBody.append(row);
		    });

		    pagingArea.empty();

		    var pagination = 
		    	'<div class="pagination" style="display: flex; justify-content: center;">'
		        +   '<ul class="pagination">'
		        +       '<li class="page-item ' + (data.pi.currentPage == 1 ? 'disabled' : '') + '">'
		        +           '<a class="page-link" onclick="myList(' + (data.pi.currentPage - 1) + ');">&laquo;</a>'
		        +       '</li>';

		    for (var p = data.pi.startPage; p <= data.pi.endPage; p++) {
		        pagination += 
		        	'<li class="page-item ' + (data.pi.currentPage == p ? 'disabled' : '') + '">'
		            +   '<a class="page-link" onclick="myList(' + p + ');">' + p + '</a>'
		            + '</li>';
		    }

		    pagination += 
		        '<li class="page-item ' + (data.pi.currentPage == data.pi.maxPage ? 'disabled' : '') + '">'
		        +   '<a class="page-link" onclick="myList(' + (data.pi.currentPage + 1) + ');">&raquo;</a>'
		        + '</li>'
		        + '</ul>'
		        + '</div>';

		    $("#pagingArea").html(pagination);
		};
		// 테이플 페이징 새로 처리
		
		$(document).ready(function() {
			
	        // 내 프로젝트만 보기
			$('#myProject').change(function() {
		        if(this.checked) {
		        	myList(1);
		        }else{
		        	location.href="${contextPath}/project/list.dis";
		        }
		    });
	     	// 내 프로젝트만 보기
			
		});
	</script>
</body>
</html>