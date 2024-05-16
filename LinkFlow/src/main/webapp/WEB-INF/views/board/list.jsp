<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>

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

        <jsp:include page="/WEB-INF/views/common/sidebar/board/boardSidebar.jsp"/>

        <div class="LinkFlowMainContent">
            <section class="content-header">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 id="boardName" class="m-0">${map.boardName}</h1>
                    </div>
                </div>
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                        <div class="contentInElement">
                            <div class="btnArea">
                           		<c:if test="${(loginUser.superRight == 'Y' or loginUser.boardRight == 'Y') and map.normalYN == 'NORMAL'}">
                                <ul class="navbar-nav">
                                    <li class="nav-item dropdown" style="display: flex; flex-direction: row;">
                                        <a class="nav-link btn btn-lg btn-secondary readUser" data-toggle="dropdown" href="#" style="width: 70px;"><i class="fa-solid fa-book fa-lg"></i></a>
                                        <a href="" style="padding: 10px 0 0 10px;"><i class="fa-solid fa-gear fa-2xl"></i></a>
                                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left movePage">
                                            <div class="bk-table">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h3 class="card-title">게시판 이용자</h3>
                                                    </div>
                                                    <!-- /.card-header -->
                                                    <div class="card-body table-responsive p-0" style="height: 300px;">
                                                        <table class="table table-head-fixed text-nowrap">
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:50px; text-align: center;">부서</th>
                                                                    <th style="width:50px;">직급</th>
                                                                    <th style="width:200px; text-align: center;">이름</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="text-align: center;">조성모</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>개발1부서</td>
                                                                    <td>대리</td>
                                                                    <td style="width:200px; text-align: center;">이름</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                           		</c:if>
                            </div>

                            <div class="form-inline">
                                <div class="input-group">
                                    <div class="select" style="margin-right: 15px;">
                                        <select name="" id="bottom-menu" class="form-control bottom-menu" style="width: 120px;">
                                            <option value="all">작성자</option>
                                            <option value="wait">제목</option>
                                            <option value="complete">내용</option>
                                        </select>
                                    </div>
                                    <input class="form-control form-control-sidebar" type="search" placeholder="검색하기" aria-label="Search">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">
                                            <i class="fas fa-search fa-fw"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style=" min-height: 500px; min-width: 100%;">
                            <div class="card">
                                <div class="card-body table-responsive p-0">
                                    <table class="table table-hover text-nowrap" style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>분류</th>
                                                <th style="width: 450px;">제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                                <th>조회수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:choose>
                                        		<c:when test="${empty boardList }">
                                        			<tr>
											                					<td colspan="6">조회된 게시글이 없습니다. </td>
											                				<tr>
                                        		</c:when>
                                        		<c:otherwise>
                                        			<c:forEach var="b" items="${boardList}">
	                                            	<tr onclick="location.href='${contextPath}/board/detail.do?type=${b.boardCategory}';">
	                                                <c:choose>
	                                                	<c:when test="${b.noticeYN == 'Y' }">
	                                                		<th>${b.boardNo }</th>
			                                                <th>공지</th>
			                                                <th>${b.boardTitle}</th>
			                                                <th>${b.regId }</th>
			                                                <th>${b.modDate }</th>
			                                                <th>${b.count }</th>
	                                                	</c:when>
			                                              <c:otherwise>
			                                              	<td>${b.boardNo }</td>
			                                                <td>일반</td>
			                                                <td>${b.boardTitle}</td>
			                                                <td>${b.regId }</td>
			                                                <td>${b.modDate }</td>
			                                                <td>${b.count }</td>
			                                              </c:otherwise>
	                                                </c:choose>
	                                            	</tr>
                                            	</c:forEach>
                                            </c:otherwise>
                                        	</c:choose>
                                        </tbody>
                                    </table>
                                    <hr style="margin-top: 0px;">
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