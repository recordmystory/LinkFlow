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
#boardList{text-align: center;}
#boardList>tbody>tr:hover{cursor:pointer;}
.LinkFlowMainContent section{
      padding-left: 8%;
      padding-right: 8%;
    }
.reply_modifyinput {
  width: 80%;
  border: none;
  background-color: transparent;
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
                        <h1 class="m-0">게시글</h1>
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
                            <div class="form-inline">
                                <div class="input-group">
                                	<c:if test="${ board.regId == loginUser.userId or loginUser.superRight == 'Y' or loginUser.boardRight == 'Y'}">
                                    <a href="${ contextPath }/board/modifyForm.page?no=${board.boardNo}" style="padding-right: 20px;">수정</a>
                                    <a href="#" onclick="confirmDelete('${contextPath}/board/delete.do?no=${board.boardNo}')">삭제</a>
                                  </c:if>
                                </div>
                            </div>
                        </div>
                        <div style="min-height: 500px; min-width: 100%;">
                            <table id="contentArea" align="center" class="table">
                                <tr style="font-size: larger;">
                                <c:choose>
                                	<c:when test="${ board.noticeYN == 'Y'}">
                                		<th width="100">[공지]</th>
                                    <th colspan="3">${ board.boardTitle }</th>
                                	</c:when>
                                	<c:otherwise>
                                		<td width="100">[일반]</td>
                                    <td colspan="3">${ board.boardTitle }</td>
                                	</c:otherwise>
                                </c:choose>

                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td width="800">${board.regId }</td>
                                    <th width="150" style="text-align: center;">작성일</th>
                                    <td width="150" style="text-align: center;">${board.charDate }</td>
                                </tr>
                                <tr>
                                    <th>첨부파일</th>
                                    <td colspan="3">
                                        <c:forEach var="at" items="${board.attachList }">
									                       <a href="${ contextPath }${ at.filePath }/${ at.filesystemName }" download="${ at.originName }">${ at.originName }</a> <br>
									                      </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <td colspan="3"></td>
                                </tr>
                                <tr>
                                    <td colspan="4" >
                                    	<div class="boardContent"style="min-height:500px; margin:10px">
                                    		 ${board.boardContent }
                                    	</div>
                                    </td>
                                </tr>
                            </table>
                            <br>

                            <!-- 댓글 기능은 나중에 ajax 배우고 접목시킬예정! 우선은 화면구현만 해놓음 -->
                            <table id="replyArea" class="table" align="center">
                                <thead>
                                    <tr>
                                        <th colspan="4">댓글(3)</th>
                                    </tr>
                                    <tr>
                                        <th colspan="3">
                                            <textarea class="form-control" name="" id="content" cols="55" rows="2" style="resize:none; width:100%"></textarea>
                                        </th>
                                        <th style="vertical-align: middle">
                                            <button class="btn btn-secondary">등록하기</button>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th width="120" style="text-align: center;">user02</th>
                                        <td style="padding-left: 50px;">
                                            <span class="commentText">댓글입니다.너무웃</span>
                                            <i class="fa-solid fa-pen origin_modify" style="padding-left: 20px;"></i>
                                        </td>
                                        <td width="100" style="text-align: center;">2020-04-10</td>
                                        <td width="150">
                                            <i class="fa-solid fa-xmark fa-xl"></i>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th width="120" style="text-align: center;">user02</th>
                                        <td style="padding-left: 50px;">
                                            <span class="commentText">댓글입니다.너무웃기</span>
                                            <i class="fa-solid fa-pen origin_modify" style="padding-left: 20px;"></i>
                                        </td>
                                        <td width="100" style="text-align: center;">2020-04-10</td>
                                        <td width="150">
                                            <i class="fa-solid fa-xmark fa-xl"></i>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <th width="120" style="text-align: center;">user02</th>
                                        <td style="padding-left: 50px;">
                                            <span class="commentText">댓글입니다.너무웃기다</span>
                                            <i class="fa-solid fa-pen origin_modify" style="padding-left: 20px;"></i>
                                        </td>
                                        <td width="100" style="text-align: center;">2020-04-10</td>
                                        <td width="150">
                                            <i class="fa-solid fa-xmark fa-xl"></i>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
            
            <script>
                $(document).ready(function() {
                    $(document).on("click", ".origin_modify", function() {
                        const parentTd = $(this).closest("td");
                        const commentHtml = parentTd.html();
                        let inputEl = document.createElement("input");
                        
                        inputEl.type = 'text';
                        inputEl.classList.add("reply_modifyinput");
                        inputEl.value = parentTd.find(".commentText").text();

                        parentTd.find(".commentText, .origin_modify").remove();
                        parentTd.append(inputEl);

                        inputEl.focus();

                        $(document).on('blur', ".reply_modifyinput", function() {
                            parentTd.html(commentHtml);
                        });
                    });
                });
            </script>
            <script>
						    function confirmDelete(url) {
						        if (confirm('정말 삭제하시겠습니까?')) {
						            window.location.href = url;
						        }
						    }
						</script>
        </div>
    </div>
</div>
</body>
</html>