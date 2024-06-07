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
.contentInElement{display: flex; justify-content: space-between; margin-bottom: 20px;}
.dmovePage {
   padding: .0rem 0rem;
 }
#boardList{text-align: center;}
#boardList>tbody>tr:hover{cursor:pointer;}
.LinkFlowMainContent section{
      padding-left: 4%;
      padding-right: 4%;
    }
.reply_modifyinput {
  width: 80%;
  border: none;
  background-color: transparent;
}

i {
    cursor: pointer;
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
                <div style="text-align:right; padding-right:24px;">
                	<button class="btn btn-primary" onclick="javascript:history.go(-1);">목록으로</button>
                </div>
                <!-- /.container-fluid -->
            </section>
           
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                   	 <div style="min-height: 500px; min-width: 100%; background-color:white; border : 1px solid rgb(163, 161, 161); border-radius : 10px; padding : 40px">
                        <div class="contentInElement">
                            <div class="btnArea">
                              	<c:if test="${ board.regId == loginUser.userId or loginUser.superRight == 'Y' or loginUser.boardRight == 'Y'}">
                                  <a href="${ contextPath }/board/modifyForm.page?no=${board.boardNo}" style="padding-right: 20px;">수정</a>
                                  <a href="#" onclick="confirmDelete('${contextPath}/board/delete.do?no=${board.boardNo}&type=${ board.boardCategory}')">삭제</a>
                                </c:if>
                            </div>
                            <div class="form-inline">
                                <div class="input-group"></div>
                            </div>
                        </div>
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
                                    <td width="800">${board.userName } ${board.position }</td>
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
														
														<c:if test="${ board.noticeYN != 'Y'}">
                            <table id="replyArea" class="table" align="center">
                                <thead>
                                    <tr>
                                        <th colspan="4">댓글(<span id="rcount">0</span>) </th>
                                    </tr>
                                    <tr>
                                        <th colspan="3">
                                            <textarea class="form-control" name="" id="replyContent" cols="55" rows="2" style="resize:none; width:100%"></textarea>
                                        </th>
                                        <th width="150px" style="vertical-align: middle">
                                            <button class="btn btn-secondary" onclick="ajaxInsertReply();">등록하기</button>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </section>
            
            <script>
            		let commentHtml = "";
            		let parentTd = "";
                $(document).ready(function() {
                	$(document).on('blur', ".reply_modifyinput", function() {
                        setTimeout(function() {
                            parentTd.html(commentHtml);
                        }, 100); // 200ms 지연 추가
                    });

                    $(document).on("click", ".cancleReply", function() {
                    	parentTd.html(commentHtml);
                    });
  
                    ajaxReplyList();
                });
                
                function changeReplyContent(no, element) {

            				const clickParentTd = $(element).closest("td");
                    parentTd = clickParentTd;
          					commentHtml = parentTd.html();
                    let inputEl = document.createElement("input");
                    
                    
                    inputEl.type = 'text';
                    inputEl.classList.add("reply_modifyinput");
                    inputEl.value = parentTd.find(".commentText").text();

                    let editIcon = $('<i class="fa-solid fa-check" onclick="ajaxUpdateReply('+ no +')" style="padding: 0px 15px 0px 15px"></i>');
                    let resetIcon = $('<i class="fa-solid fa-rotate-left cancleReply" ></i>');

                    parentTd.find(".commentText, .origin_modify").remove();
                    parentTd.append(inputEl).append(editIcon).append(resetIcon);

                    inputEl.focus();     
            		}
                
                function ajaxUpdateReply(no) {
		            		if($(".reply_modifyinput").val().trim().length != 0) {
		            			$.ajax({
		            				url:"${contextPath}/board/updateReply.do",
		            				type:"post",
		            				data:{
		            					replyContent:$(".reply_modifyinput").val(),
		            					replyNo:no,
		            				} ,
		            				success:function(result){
		            					if(result == "SUCCESS") {
		            						ajaxReplyList();
		            					}else if(result == "FAIL") {
		            						alert("댓글 작성 서비스", "다시 입력해주세요.");
		            						ajaxReplyList();
		            					}
		            				},error:function(){
		            					console.log("댓글 작성용 ajax 통신 실패");
		            				}
		            			})
		            		}else {
		            			alert("댓글 작성 서비스 ", "빈문자");
		            		}
		        	 }
                
                function ajaxInsertReply() {
	            		if($("#replyContent").val().trim().length != 0) {
	            			$.ajax({
	            				url:"${contextPath}/board/registReply.do",
	            				type:"post",
	            				data:{
	            					replyContent:$("#replyContent").val(),
	            					refNo:${board.boardNo}
	            				} ,
	            				success:function(result){
	            					if(result == "SUCCESS") {
	            						$("#replyContent").val("");
	            						ajaxReplyList();
	            					}else if(result == "FAIL") {
	            						alert("댓글 작성 서비스", "다시 입력해주세요.");
	            					}
	            				},error:function(){
	            					console.log("댓글 작성용 ajax 통신 실패");
	            				}
	            			})
	            		}else {
	            			alert("댓글 작성 서비스 ", "빈문자");
	            		}
            	 }
                
               function ajaxReplyList(){
            		$.ajax({
            			url:"${contextPath}/board/replyList.do",
            			type:"get",
            			data:"no=${board.boardNo}",
            			success:function(resData){ // [{}, {}, {}, ..]
            				$("#rcount").text(resData.length);
            				
            				let tr = "";
            				for(let i=0; i<resData.length; i++) {

            					tr += "<tr>"
            							+ '<th width="150" style="text-align: center;">' + resData[i].userName + " " + resData[i].position +'</th>'
            							+ '<td style="padding-left: 50px;"><span class="commentText">' 
            							+ resData[i].replyContent;
            							
            					// 현재로그인한 회원이 해당 댓글의 작성일 경우
         							if(resData[i].regId == "${loginUser.userId}") {
         								tr += '</span><i class="fa-solid fa-pen origin_modify" style="padding-left: 20px;" onclick="changeReplyContent('+ resData[i].replyNo +', this)"></i></td>' 
         								 +'<td width="100" style="text-align: center;">'
         								 + resData[i].modCharDate
         								 + '</td><td width="150"><i class="fa-solid fa-xmark fa-xl" onclick="confirmReplyDelete(' + resData[i].replyNo +')"></i></td>';
         							}else{
         								tr += '<td width="100" style="text-align: center;">'
            								 + resData[i].modCharDate
            								 + '</td>' + '<td width="150"></td>';
         							}
           						tr += "</tr>";	
            				}
            				
            				$("#replyArea tbody").html(tr);
            				
            			},error:function(){
            				console.log("댓글 목록 조회용 ajax통신 실패");
            			}
            		})
            	}
              
              function confirmReplyDelete(no) {
				        if (confirm('댓글을 삭제하시겠습니까? 삭제하시면 복구가 안됩니다')) {
            			$.ajax({
            				url:"${contextPath}/board/deleteReply.do",
            				type:"post",
            				data:{
            					replyNo:no,
            				} ,
            				success:function(result){
            					if(result == "SUCCESS") {
            						alert("댓글 삭제했습니다");
            						ajaxReplyList();
            					}else if(result == "FAIL") {
            						alert("댓글 삭제에 실패했습니다");
            					}
            				},error:function(){
            					console.log("댓글 작성용 ajax 통신 실패");
            				}
            			})
				        }
					    }
            </script>
            <script>
						    function confirmDelete(url) {
						        if (confirm('게시글을 삭제하시겠습니까?')) {
						            window.location.href = url;
						        }
						    }
						</script>
        </div>
    </div>
</div>
</body>
</html>