<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 게시판</title>

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
                           		<c:if test="${map.normalYN == 'NORMAL'}">
                                <ul class="navbar-nav">
                                    <li class="nav-item dropdown" style="display: flex; flex-direction: row;">
                                        <a class="nav-link btn btn-lg btn-secondary readUser" data-toggle="dropdown" href="#" style="width: 70px;"><i class="fa-solid fa-book fa-lg"></i></a>
                                        <c:if test="${loginUser.superRight == 'Y' or loginUser.boardRight == 'Y'}">
                                        	<a href="${contextPath }/board/updateBoard.page?type=${map.currentType}" style="padding: 10px 0 0 10px;"><i class="fa-solid fa-gear fa-2xl"></i></a>
                                        </c:if>
                                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left movePage">
                                            <div class="bk-table">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h3 class="card-title">게시판 이용자</h3>
                                                    </div>
                                                    <!-- /.card-header -->
                                                    <div class="card-body table-responsive p-0" style="height: 300px;">
                                                        <table class="table table-head-fixed text-nowrap" style="text-align:center;">
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:50px;">부서</th>
                                                                    <th style="width:50px;">직급</th>
                                                                    <th style="width:150px;">이름</th>
                                                                    <th>쓰기여부</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            	<c:forEach var="u" items="${normalUserList}">
										                                            	<tr>
										                                              	<th>${u.deptTitle }</th>
										                                                <th>${u.subName}</th>
										                                                <th>${u.userName }</th>
										                                                <c:choose>
										                                                	<c:when test="${u.writeYN == 'Y'}">
										                                                		<th><i class="fa-solid fa-check"></i></th>
										                                                	</c:when>
										                                                	<c:otherwise>
										                                                		<th><i class="fa-solid fa-xmark"></i></th>
										                                                	</c:otherwise>
										                                                </c:choose>
										                                            	</tr>
										                                           </c:forEach>
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
                            	<form id="searchForm" action="${contextPath }/board/search.do" method="get" align="center">
                                <div class="input-group">
                                    <input type="hidden" name="page" value="1">
                                    <input type="hidden" name="type" value="${search.boardType == null ? map.currentType : search.boardType  }">
                                    <div class="select" style="margin-right: 15px;">
                                        <select name="condition" id="bottom-menu" class="form-control bottom-menu" style="width: 120px;">
                                            <option value="user_id">작성자</option>
										                        <option value="board_title">제목</option>
										                        <option value="board_content">내용</option>
                                        </select>
                                    </div>
                                    <input name="keyword" class="form-control form-control-sidebar" type="search" placeholder="검색하기" aria-label="Search" value="${search.keyword }">
                                    <div class="input-group-append">
                                        <button type="submit"class="btn btn-primary">
                                            <i class="fas fa-search fa-fw"></i>
                                        </button>
                                    </div>
                                	</div>
                                </form>
                            </div>
                        </div>

                        <div style=" min-height: 500px; min-width: 100%;">
                            <div class="card">
                                <div class="card-body table-responsive p-0">
                                    <table class="table table-hover text-nowrap" style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th width="150">No</th>
                                                <th width="150">분류</th>
                                                <th>제목</th>
                                                <th width="200">작성자</th>
                                                <th width="250">작성일</th>
                                                <th width="150">조회수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach var="n" items="${noticeList}">
                                            	<tr onclick="location.href='${contextPath}/board/${loginUser.userId == n.regId ? 'detail.do' : 'increase.do' }?&no=${ n.boardNo }';">
                                              	<th>${n.boardNo }</th>
                                                <th>공지</th>
                                                <th>${n.boardTitle}</th>
                                                <th>${n.userName } ${n.position }</th>
                                                <th>${n.modDate }</th>
                                                <th>${n.count }</th>
                                            	</tr>
                                           </c:forEach>
                                        	<c:choose>
                                        		<c:when test="${empty boardList }">
                                        			<tr>
											                					<td colspan="6">조회된 게시글이 없습니다. </td>
											                				<tr>
                                        		</c:when>
                                        		<c:otherwise>
                                        			<c:forEach var="b" items="${boardList}">
                                        				<c:choose>
                                        					<c:when test="${ b.boardCategory != 'CATEGORY-8' }">
                                        						<tr onclick="location.href='${contextPath}/board/${loginUser.userId == b.regId ? 'detail.do' : 'increase.do' }?&no=${ b.boardNo }';">
			                                              	<td>${b.boardNo }</td>
			                                                <td>일반</td>
			                                                <td>${b.boardTitle}</td>
			                                                <td>${b.userName } ${b.position }</td>
			                                                <td>${b.modDate }</td>
			                                                <td>${b.count }</td>
			                                            	</tr>
                                        					</c:when>
                                        					<c:otherwise>
                                        						<tr onclick="location.href='${contextPath}/board/${loginUser.userId == b.regId ? 'detail.do' : 'increase.do' }?&no=${ b.boardNo }';">
			                                              	<th>${b.boardNo }</th>
			                                                <th>공지</th>
			                                                <th>${b.boardTitle}</th>
			                                                <th>${b.userName } ${b.position }</th>
			                                                <th>${b.modDate }</th>
			                                                <th>${b.count }</th>
			                                            	</tr>
                                        					</c:otherwise>
                                        				</c:choose>
	                                            	
                                            	</c:forEach>
                                            </c:otherwise>
                                        	</c:choose>
                                        </tbody>
                                    </table>
                                    <hr style="margin-top: 0px;">
                                    <div class="pagingArea" id="pagingArea" style="display: flex; justify-content: center;">
                                        <ul class="pagination">
                                        		<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/list.do?type=${map.currentType}&page=${pi.currentPage -1}">&laquo;</a></li>
                    
														                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
														                	<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/list.do?type=${map.currentType}&page=${p}">${p}</a></li>
														                </c:forEach>
														                
														                <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/list.do?type=${map.currentType}&page=${pi.currentPage +1}">&raquo;</a></li>

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
<c:if test="${not empty search }">
  <script>
  	$(document).ready(function(){
  		$("#searchForm select").val("${search.condition}");
  		
  		$("#pagingArea a").on("click", function(){
  			console.log()
  			$("#searchForm input[name=page]").val($(this).text());
  			$("#searchForm").submit();
  			return false;
  		})
  	})
  </script>
 </c:if>
</body>
</html>