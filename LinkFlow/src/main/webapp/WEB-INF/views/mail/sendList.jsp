<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 메일</title>
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
input[type="checkbox"] {
  height: 20px;
  width: 20px;
  vertical-align: middle;
}
</style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">
        <jsp:include page="/WEB-INF/views/common/sidebar/mail/MailSidebar.jsp"/>
        <div class="LinkFlowMainContent">

            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">보낸편지함</h1>
                    </div>
                </div>
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                        <div class="contentInElement">
                            <div class="btnArea">
                                <button type="button" class="btn btn-primary btn-lg" style="margin-right: 6px;" onclick="confirmDelete();">삭제하기</button>
                            </div>
                            <div class="form-inline">
                                <form id="searchForm" action="${contextPath }/mail/sendSearch.do" method="get" align="center">
                                <div class="input-group">
                                		<input type="hidden" name="page" value="">
                                    <div class="select" style="margin-right: 15px;">
                                        <select name="condition" id="bottom-menu" class="form-control bottom-menu" style="width: 120px;">
                                            <option value="mail_title">제목</option>
                                            <option value="mail_content">내용</option>
                                        </select>
                                    </div>
                                    <input name="keyword" class="form-control form-control-sidebar" type="search" placeholder="검색하기" aria-label="Search" value="${search.keyword }">
                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search fa-fw"></i>
                                        </button>
                                    </div>
                                </div>
                               </form>
                            </div>
                        </div>
	                    	<form id="deleteForm" action="${contextPath}/mail/delete.do" method="get">
                        <div style="min-height: 500px; min-width: 100%;">
                            <div class="card">
                                <div class="card-body table-responsive p-0">
                                    <table class="table table-hover text-nowrap" style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th width="100"><input type="checkbox" id="checkAll" onclick="checkAllBoxes()"></th>
                                                <th width="150">읽기</th>
                                                <th width="150">작성자</th>
                                                <th>제목</th>
                                                <th width="200">작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                        		<c:when test="${empty sendMailList }">
                                        			<tr>
											                					<td colspan="5"> 조회된 메일이 없습니다 </td>
											                				<tr>
                                        		</c:when>
                                        		<c:otherwise>
                                            <c:forEach var="m" items="${sendMailList}">
                                     					<tr onclick="location.href='${contextPath}/mail/detail.page?&no=${ m.mailNo }';">
                                                <td><input name="no" value="${ m.mailNo }"  type="checkbox" class="checkBox" onclick="event.stopPropagation();"></td>
                                                <td><i class="fa-solid fa-envelope-open fa-xl"></i></td>
                                                <td>${m.userName }</td>
                                                <td>${m.mailTitle }</td>
                                                <td>${m.transTime }</td>
                                            	</tr>
                                        			</c:forEach>
                                    				</c:otherwise>
                                      		</c:choose>
                                        </tbody>
                                    </table>
                                    <hr style="margin-top: 0px;">
                                    <div class="pagination" style="display: flex; justify-content: center;">
                                        <ul class="pagination">
                                        		<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/mail/sendList.do?page=${pi.currentPage -1}">&laquo;</a></li>
                    
														                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
														                	<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/mail/sendList.do?page=${p}">${p}</a></li>
														                </c:forEach>
														                
														                <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/mail/sendList.do?page=${pi.currentPage +1}">&raquo;</a></li>

                                        </ul>
                                    </div>
                                </div>
                            </div>
                        	</div>
                        </form>
                    </div>
                </div>
            </section>
            <c:if test="${not empty search }">
						  <script>
						  	$(document).ready(function(){
						  		$("#searchForm select").val("${search.condition}");
						  		
						  		// 검색후 페이지일 경우 페이징바의 페이지 클릭시
						  		$("#pagingArea a").on("click", function(){
						  			$("#searchForm input[name=page]").val($(this).text());
						  			$("#searchForm").submit();
						  			//
						  			return false; // 기본이벤트 제거(즉, a태그에 작성되어있는 href="/list.do" 실행안되도록)
						  		})
						  	})
						  </script>
						 </c:if>
            <script>
                function checkAllBoxes() {
                    var checkAll = document.getElementById('checkAll');
                    var checkBoxes = document.getElementsByClassName('checkBox');

                    for (var i = 0; i < checkBoxes.length; i++) {
                        checkBoxes[i].checked = checkAll.checked;
                    }
                }
                
                function confirmDelete() {
                    var checkBoxes = document.getElementsByClassName('checkBox');
                    var selected = false;

                    for (var i = 0; i < checkBoxes.length; i++) {
                        if (checkBoxes[i].checked) {
                            selected = true;
                            break;
                        }
                    }

                    if (selected) {
                        if (confirm('정말 삭제하시겠습니까?')) {
                            document.getElementById('deleteForm').submit();
                        }else{
                        	 return false;
                        }
                    } else {
                        alert('삭제할 항목을 선택하세요.');
                        return false;
                    }
                }
            </script>
        </div>
    </div>
</div>
</body>
</html>