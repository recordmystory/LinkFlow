<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
                        <h1 class="m-0">게시판</h1>
                    </div>
                </div>
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                        <div class="contentInElement">
                            <div class="btnArea">
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
                                            <tr>
                                                <th>1</th>
                                                <th>공지</th>
                                                <th>내부 고발합니다</th>
                                                <th>김과장</th>
                                                <th>2024-04-05</th>
                                                <th>0</th>
                                            </tr>
                                            <!-- Additional rows here -->
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