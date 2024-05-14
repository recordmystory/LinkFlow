<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
 #boardList{text-align: center;}
 #boardList>tbody>tr:hover{cursor:pointer;}
 #pagingArea{width:fit-content;margin:auto;}
 .readUser{
   border-radius: 10px;
 }

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
                                    <form action="dddddddddd">
                                        <div style="margin-bottom: 10px;">
                                            <input class="form-control form-control-sidebar" name="start_date" type="date" style="width: 150px;">&nbsp;&nbsp; ~ &nbsp;&nbsp;<input class="form-control form-control-sidebar" name="end_date" type="date">
                                        </div>
                                        <div class="input-group">
                                            <div class="select" style="margin-right: 15px;">
                                                <select name="category" id="bottom-menu" class="form-control bottom-menu" style="width: 150px;">
                                                    <option value="proName">프로젝트명</option>
                                                    <option value="client">고객사명</option>
                                                </select>
                                            </div>
                                            <input class="form-control form-control-sidebar" name="keyword" type="search" placeholder="Search" aria-label="Search">
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
                                            <tbody>
                                                <tr>
                                                    <td>3</td>
                                                    <td>한국은행</td>
                                                    <td>
                                                        <a href="dd">IT 통합 운영</a>
                                                    </td>
                                                    <td>개발 1팀</td>
                                                    <td>2024-01-01 ~ 2024-12-31</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a id="map1" data-toggle="modal" href="#mapModal">위치보기</a>
                                                    </td>
                                                    <td>진행</td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>한국은행</td>
                                                    <td>
                                                        <a href="dd">IT 통합 운영</a>
                                                    </td>
                                                    <td>개발 1팀</td>
                                                    <td>2024-01-01 ~ 2024-12-31</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a id="map2" data-toggle="modal" href="#mapModal">위치보기</a>
                                                    </td>
                                                    <td>진행</td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>한국은행</td>
                                                    <td>
                                                        <a href="dd">IT 통합 운영</a>
                                                    </td>
                                                    <td>개발 1팀</td>
                                                    <td>2024-01-01 ~ 2024-12-31</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a id="map3" data-toggle="modal" href="#mapModal">위치보기</a>
                                                    </td>
                                                    <td>진행</td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>한국은행</td>
                                                    <td>
                                                        <a href="dd">IT 통합 운영</a>
                                                    </td>
                                                    <td>개발 1팀</td>
                                                    <td>2024-01-01 ~ 2024-12-31</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a id="map4" data-toggle="modal" href="#mapModal">위치보기</a>
                                                    </td>
                                                    <td>진행</td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>한국은행</td>
                                                    <td>
                                                        <a href="dd">IT 통합 운영</a>
                                                    </td>
                                                    <td>개발 1팀</td>
                                                    <td>2024-01-01 ~ 2024-12-31</td>
                                                    <td>
                                                        <i class="fa-solid fa-location-dot" style="color: rgb(43, 120, 236);"></i>
                                                        <a id="map5" data-toggle="modal" href="#mapModal">위치보기</a>
                                                    </td>
                                                    <td>진행</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="pagination" style="display: flex; justify-content: center;">
                                        <ul class="pagination">
                                          <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                                          <li class="page-item"><a class="page-link" href="#">1</a></li>
                                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                                          <li class="page-item"><a class="page-link" href="#">3</a></li>
                                          <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- The Modal -->
                                <div class="modal" id="mapModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <!-- Modal Header -->
                                            <div class="modal-header">
                                            <h4 class="modal-title">위치보기</h4>
                                            </div>
                                            <!-- Modal body -->
                                            <div class="modal-body">
                                            <div id="map" style="width:400px;height:300px;"></div>
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
</body>
</html>