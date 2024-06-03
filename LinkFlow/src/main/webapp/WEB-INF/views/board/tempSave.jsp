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
.registTitle{
  padding-right: 10px; 
  font-size: larger;
  align-items: center;
}
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
        <jsp:include page="/WEB-INF/views/common/sidebar/board/boardSidebar.jsp"/>
        <div class="LinkFlowMainContent">          
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">임시저장</h1>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;"> 
                    <div class="contentArea">
                    <form id="deleteForm" action="${contextPath}/board/remove.do" method="get">
                        <div class="contentInElement">
                            <div class="btnArea">
                                <button type="button" class="btn btn-primary btn-lg" style="margin-right: 6px;" onclick="confirmDelete();">삭제하기</button>
                            </div>
                            <div class="form-inline">
                                <div class="input-group">
                                </div>
                            </div>
                        </div>
                        <div style="min-height: 500px; min-width: 100%;">
                            <div class="card">
                                <div class="card-body table-responsive p-0">
                                    <table class="table table-hover text-nowrap" style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th width="150"><input type="checkbox" id="checkAll" onclick="checkAllBoxes()"></th>
                                                <th width="200">분류</th>
                                                <th width="1000">제목</th>
                                                <th width="300">작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                        		<c:when test="${empty tempSaveList }">
                                        			<tr>
											                					<td colspan="6">조회된 게시글이 없습니다. </td>
											                				<tr>
                                        		</c:when>
                                        		<c:otherwise>
                                        			<c:forEach var="t" items="${tempSaveList}">
                                      						<tr>
		                                               	<th style="padding:12px 12px 12px 24px;"><input name="no" type="checkbox" class="checkBox" value="${t.boardNo }" onclick="event.stopPropagation();"></th>
		                                                <td>${t.categoryName }</td>
		                                                <td onclick="location.href='${contextPath}/board/tempSaveDetail.page?&no=${ t.boardNo }';">${t.boardTitle}</td>
		                                                <td>${t.modDate }</td>
		                                            	</tr>
                                            		</c:forEach>
                                     					</c:otherwise>
                                     				</c:choose>
                                        </tbody>
                                    </table>
                                    <hr style="margin-top: 0px;">
                                    <div class="pagination" style="display: flex; justify-content: center;">
                                        <ul class="pagination">
                                        		<li class="page-item ${pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/tempSave.page?page=${pi.currentPage -1}">&laquo;</a></li>
                    
														                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
														                	<li class="page-item ${pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/tempSave.page?page=${p}">${p}</a></li>
														                </c:forEach>
														                
														                <li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${contextPath}/board/tempSave.page?page=${pi.currentPage +1}">&raquo;</a></li>

                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                      </form>
                    </div>
                </div>
            </section>
             <!-- <script>
               	$(document).ready(function(){
               		$(".origin_del").on("click", function(){
               			// 삭제하고자 하는 해당 첨부파일 번호를 form submit시 넘기기 위한 작업
               			// => 해당 form요소내에 input type="hidden" 만들어서 append
               			let inputEl = document.createElement("input");
               			inputEl.type = "hidden";
               			inputEl.name = "delFileNo";
               			inputEl.value = $(this).data("fileno")
               			
               			document.getElementById("updateForm").append(inputEl);
               			
               			// 화면으로부터 사라지도록 작업
               			$(this).parent().remove();
               			
               			if ($('#oringFileTr td').children().length === 0) {
               	            $('#oringFileTr').remove();
               	    }
               		})
               	})
               </script> -->
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
                        }else {
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