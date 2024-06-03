<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 프로젝트목록조회</title>
<!-- 네이버 지도 api -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=wfsx6d3wj7&submodules=geocoder"></script>
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
                            <h1 class="m-0">프로젝트 목록 조회</h1>
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
                                    <!--
                                    <button class="btn btn-primary btn-sm">기안하기</button>
                                    <button class="btn btn-primary btn-sm">임시저장</button>
                                    -->
                                </div>
                                <div class="form-inline" style="display: flex; flex-direction: column;">
                                	<form action="${contextPath}/project/search.pj" method="post" id="searchForm">
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
                                        <table id="example2" class="table table-hover text-nowrap" style="text-align: center;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 10%;">NO</th>
                                                    <th style="width: 10%;">고객사</th>
                                                    <th style="width: 25%;">프로젝트명</th>
                                                    <th style="width: 10%;">담당부서</th>
                                                    <th style="width: 25%;">계약기간</th>
                                                    <th style="width: 10%;">위치</th>
                                                    <th style="width: 10%;">상태</th>
                                                </tr>
                                            </thead>
                                            <tbody id="project-list">
                                            	<c:forEach var="p" items="${list}"> 
                                                <tr>
                                                    <td>${p.proNo}</td>
                                                    <td>${p.client}</td>
                                                    <td>
                                                        <a href="${contextPath}/project/detail.pj?no=${p.proNo}&title=${loginUser.deptName}">${p.proTitle}</a>
                                                    </td>
                                                    <td>${p.deptName}</td>
                                                    <td>${p.startDate} ~ ${p.endDate}</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a data-toggle="modal" href="#mapModal" onclick="mapCreate('${p.address}')">위치보기</a>
                                                    </td>
                                                    <td>${p.proYn eq 'N' ? '진행' : '완료'}</td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="pagingArea">
										<div class="pagination" style="display: flex; justify-content: center;">
											<ul class="pagination">
												<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/list.pj?page=${pi.currentPage -1}">&laquo;</a>
												</li>
												<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
													<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }">
														<a class="page-link" href="${contextPath}/project/list.pj?page=${p}">${p}</a>
													</li>
												</c:forEach>
												<li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }">
													<a class="page-link" href="${contextPath}/project/list.pj?page=${pi.currentPage +1}">&raquo;</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
                                <!-- The Modal -->
                                <div class="modal" id="mapModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <!-- Modal Header -->
                                            <div class="modal-header" style="justify-content: center;">
                                            <h4 class="modal-title">위치보기</h4>
                                            </div>
                                            <!-- Modal body -->
                                            <div class="modal-body" style="display:flex; justify-content: center;">
                                            <div id="map" style="width:450px; height:300px; display: flex;"></div>
                                            </div>
                                            <!-- Modal footer -->
                                            <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                                            </div>
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

		// 지도 api 시작
        //주소의 정보를 selectMapList 함수로 넘겨준다.
        function mapCreate(address){
        naver.maps.Service.geocode({
                query: address
            }, function(status, response) {
            
                var item = response.v2.addresses[0]
        
                selectMapList(item.x, item.y);
                
            });
        };

        //검색정보로 지도를 만들고, 지도에 마커를 찍어준다.
        function selectMapList(latitude, longitude) {

            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(longitude, latitude),
                zoom: 14
            });
            var marker = new naver.maps.Marker({
                map: map,
                position: new naver.maps.LatLng(longitude, latitude),
            });
        };
        // 지도 api 끝

    </script>
</body>
</html>