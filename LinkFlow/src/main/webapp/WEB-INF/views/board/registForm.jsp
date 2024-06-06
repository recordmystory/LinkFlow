<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 게시판</title>
<script src="${ contextPath}/resources/ckeditor5/board/build/ckeditor.js"></script>
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
	.LinkFlowMainContent section{
    padding-left: 4%;
    padding-right: 4%;
  }
  .registTitle{
    padding-right: 10px; 
    font-size: larger;
    align-items: center;
  }
  table{width:100%;}
  table *{ margin:10px;}
  #enrollForm input[type="text"]{
    width: 500px;
    display: inline-block;
    vertical-align: middle;
  }
  .form-check-inline{ vertical-align: middle;}
  #enrollForm input[type="checkbox"]{
    height: 20px; 
    width: 20px;
  }
  #enrollForm input[type="file"]{
    display: none;
    vertical-align: middle;
  }
  
  #enrollForm span {
    text-align: center;
    align-self: center;
  }
  .ck-editor{ 
  	margin:10px;
  }
  .ck-editor__editable{
    min-height: 600px;
  }
  .ck-editor__main{
  	margin:0;
  }
  .ck-content {
  	margin:0;
  }
  
  .drop-area {
    border: 1px dotted gray;
    display: flex; 
    flex-direction: column;
    min-height: 200px;
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
                        <h1 class="m-0">게시물 작성</h1>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                        <form id="enrollForm" method="post" action="${contextPath }/board/regist.do" enctype="multipart/form-data">
                            <div class="contentInElement">
                                <div class="btnArea">
                                    <button type="submit" class="btn btn-primary btn-sm" style="margin-right: 6px;" id="enrollForm-submit">작성하기</button>
                                    <button type="button" class="btn btn-primary btn-sm" style="margin-right: 6px;" onclick="tempSave();">임시저장</button>
                                    <button type="button" class="btn btn-primary btn-sm" onclick="javascript:history.go(-1);">취소</button>
                                </div>
                            </div>
                            <div style="min-height: 500px; min-width: 100%;">
                                <table align="center">
                                    <tr>
                                        <th style="text-align: center;" width=111>게시판</th>
                                        <td>
                                            <select id="select" class="custom-select" name="boardCategory" style="width: 200px;">
                                                <c:if test="${loginUser.superRight == 'Y' or loginUser.boardRight == 'Y' }">
                                                    <option value="CATEGORY-8">사내공지</option>
                                                </c:if>
                                                <c:forEach var="w" items="${writeList}">
                                                    <option value="${w.boardCategory }">${w.categoryName }게시판</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;"><label for="title">제목</label></th>
                                        <td>
                                            <input type="text" id="title" class="form-control" name="boardTitle" required>
                                            <c:if test="${loginUser.superRight == 'Y' or loginUser.boardRight == 'Y' }">
                                                <label class="form-check-label form-check-inline" for="noticeCheckbox" style="margin:0; margin-left:10px">
                                                    <input type="checkbox" name="noticeYN" value="N" class="form-check-input" id="noticeCheckbox">
                                                    <b>공지로 등록</b>
                                                </label>
                                             <script src="${contextPath }/resources/js/board/BoardNoticeCheckBox.js"></script>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="vertical-align: center;">
                                            <div class="drop-area" style="margin:0; margin-bottom:10px; margin-top:10px">
                                                <div class="file-header" style="width: 100%;">
                                                    <label for="file-upload" style=" width: 15%;">
                                                        <div class="fileSection">
                                                            <span>파일첨부</span>
                                                        </div>
                                                        <input name="uploadFiles" type="file" id="file-upload" multiple>
                                                    </label>
                                                    <span class="fileSize" id="totalFileSize" style=" width: 80%; display: inline-block; text-align: right;">0.00 KB / 200MB</span>
                                                </div>
                                                <div class="fileFooter" style="margin: 0;">
                                                    <span class="drop-message" style="display: inline-block; width:100%; text-align: center;">여기로 파일을 끓어 놓으세요</span>
                                                </div>	
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td colspan="3">
                                    		<textarea name="boardContent" id="editor"></textarea>
                                    	</td>
                                    </tr>
                                </table>
                                <br>
                           		</div>
                        
                        <script src="${contextPath }/resources/js/board/DragAndDrop.js"></script>
                        <!-- ckeditor 함수-->
                        <script>
                            let editor;

                            ClassicEditor
                                .create(document.querySelector('#editor'))
                                .then(newEditor => {
                                    editor = newEditor;
                                })
                                .catch(error => {
                                    console.error(error);
                                });
                        </script>
                        </form>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
</body>
</html>