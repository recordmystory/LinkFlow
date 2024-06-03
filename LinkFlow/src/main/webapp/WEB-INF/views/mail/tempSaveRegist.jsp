<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 메일</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
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
    width: 800px;
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
        <jsp:include page="/WEB-INF/views/common/sidebar/mail/MailSidebar.jsp"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
        <div class="LinkFlowMainContent">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">메일 작성</h1>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid" style="display: flex; justify-content: center;">
                    <div class="contentArea">
                        <form id="enrollForm" method="post" action="${contextPath }/mail/registTempSave.do" enctype="multipart/form-data">
                            <input type="hidden" id="mailNo" name="mailNo" value="${mail.mailNo }"> 
                            <div class="contentInElement">
                                <div class="btnArea">
                                    <button type="submit" class="btn btn-primary btn-sm" style="margin-right: 6px;" id="enrollForm-submit">작성하기</button>
                                    <button type="button" class="btn btn-primary btn-sm" style="margin-right: 6px;" onclick="mailTempUpdate();">임시저장</button>
                                    <button class="btn btn-primary btn-sm" onclick="javascript:history.go(-1);">취소</button>
                                </div>
                            </div>
                            <div style="min-height: 500px; min-width: 100%;">
                                <table align="center">
                                    <tr>
                                        <th width="120" style="text-align: center;"><label for="sendUser">받는 사람</label></th>
                                        <td width="830"><input type="text" id="sendUser" class="form-control" name="receiveUser" required placeholder="메일 주소 사이에 ,(콤마)으로 구분하여 입력하세요."></td>
                                        <td>
						                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg">인원추가</button>
						                            </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;"><label for="title">제목</label></th>
                                        <td><input type="text" id="title" class="form-control" name="mailTitle" required value="${mail.mailTitle }"></td>
                                    </tr>
                                    
                                    <c:if test="${ not empty mail.attachList[0].originName  }">
	                                    <tr id="oringFileTr">
	                                    	<th style="text-align: center; vertical-align: top; padding-top : 15px;">기존 첨부파일</th>
	                                    	<td>
	                                    			<c:forEach var="at" items="${mail.attachList }">
			                                    		<div>
											                       		<a href="${ contextPath }${ at.filePath }/${ at.filesystemName }" download="${ at.originName }">${ at.originName }</a>
											                      		<i class="fa-solid fa-xmark fa-lg origin_del" data-fileno="${ at.fileNo }"></i>
	                                    				</div>
										                      	</c:forEach>
	                                    	</td>
	                                    </tr>
                                    </c:if>
                                    
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
                                    		<textarea name="mailContent" id="editor"></textarea>
                                    	</td>
                                    </tr>
                                </table>
                                <br>
                           		</div>
                           		
                           		<div class="modal fade" id="modal-lg">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content" style="min-width: 870px;">
                            <div class="modal-header">
                                <h4 class="modal-title">보내는 사람 추가</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetModal()">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="card-body">
                                        <form action="xxxxxxx" method="post">
                                            <div class="searchUser">
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                                                    <label class="form-check-label" for="inlineRadio1">이름, 아이디</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                                    <label class="form-check-label" for="inlineRadio2">조직</label>
                                                </div>
                                                <div class="col-md-3" style="margin-top: 15px;">
                                                    <div class="form-group">
                                                        <div class="input-group" style="width:300px">
                                                            <input type="search" id="searchInput"  class="form-control" placeholder="사원명을 입력하세요" value="" name="useName">
                                                            <div class="input-group-append">
                                                                <button type="submit" class="btn btn-primary">
                                                                    <i class="fa fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <div class="row">
                                            <div class="card card-default card-info" style="width: 300px; height: 500px; margin-right: 20px;">
                                                <div class="card-header">
                                                    <h5 class="card-title">사원설정</h5>
                                                    <input type="hidden" id="writeId" value="${loginUser.userId }">
                                                </div>
                                                <div class="card-body text-nowrap overflow-auto">
                                                 <div id="kt_docs_jstree_basic">
                                                     <ul>
                                                       <li data-jstree='{ "type" : "buiding" }'>
                                                           LinkFlow
                                                           <ul>
                                                           <c:forEach var="appr" items="${apprList}">
                                                               <li data-jstree='{ "selected" : false }'>
                                                                   ${appr.deptTitle}
                                                                   <ul>
                                                                   <c:forEach var="apprPerson" items="${appr.memberList}" varStatus="status">
                                                                       <li data-jstree='{ "type" : "person" }' data-userId="${apprPerson.userId}">
                                                                           ${apprPerson.userName} ${apprPerson.subName}
                                                                           <input type="hidden" id="${apprPerson.userId}" value="${apprPerson.userId}@linkflow.com" />
                                                                       </li>
                                                                   </c:forEach>
                                                                   </ul>
                                                               </li>
                                                           </c:forEach>
                                                           </ul>
                                                         </li>
                                                     </ul>
                                                 </div>
                                                </div>
                                            </div>
                                            <div class="card card-info" style="width: 500px; height: 500px;">
                                                <div class="card-header">
                                                    <h3 class="card-title">인원추가</h3>
                                                </div>
                                                <div class="card-body text-nowrap overflow-auto resultNameArea"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="button" class="btn btn-primary" id="saveData" data-dismiss="modal">확인</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="resetModal()">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                        
                        <script src="${contextPath }/resources/js/board/DragAndDrop.js"></script>
                        <!-- ckeditor 함수-->
                        <script>
                            let editor;

                            ClassicEditor
                                .create(document.querySelector('#editor'))
                                .then(newEditor => {
                                  editor = newEditor;
                                	editor.setData('${mail.mailContent}');
                                })
                                .catch(error => {
                                    console.error(error);
                                });
												
                            
                            document.getElementById('enrollForm-submit').addEventListener('click', function() {
                                document.getElementById('loadingScreen').style.display = 'flex';
                                
                            });
                            
                            document.getElementById('saveData').addEventListener('click', function() {
                                const nameAreas = document.querySelectorAll('.resultNameArea .NameArea input[type="hidden"]');
                                const emailAddresses = Array.from(nameAreas).map(input => input.value).join(', ');
                                
                                if (nameAreas.length === 0) {
                                		resetModal();
                                    return;
                                }
                                
                                document.getElementById('sendUser').value = emailAddresses;
                                resetModal();
                            });
                            
                           function removeParentElement(button) {
        	            		    let parentElement = button.parentNode; // 클릭된 요소의 바로 부모 요소를 선택합니다.
        	            		    if (parentElement) {
        	            		        parentElement.remove();
        	            		    }
        	            			}
                           function resetModal() {
                               $('.resultNameArea').empty();
                               $('#kt_docs_jstree_basic').jstree("close_all");
                           }
                           
                           function resetModalOnButton() {
                               resetModal();
                           }
                           
                           $(function(){
                     		   $('#kt_docs_jstree_basic').jstree({
                     		         "core" : {
                     		             "themes" : {
                     		                 "responsive": false
                     		             }
                     		         },
                     		         "types" : {
                     		             "default" : {
                     		                 "icon" : "fa fa-folder"
                     		             },
                     		             "group" : {
                     		                 "icon" : "fa-solid fa-user-group"
                     		             },
                     		             "building" : {
                     		                 "icon" : "fa-solid fa-building"
                     		             },
                     		             "person" : {
                     		                 "icon" : "fa-solid fa-person"
                     		             }
                     		         },
                     		        "plugins": ["types", "search"],
	                   		         "search" : {
	                   		         	"show_only_matches" : true,
	                   		         	"show_only_matches_children" : true,
	                   		         }
                     		     }).on('select_node.jstree', function (e, data) {
                     		         var node = data.node;
                     		         
                     		         if (node.type === "person") {
                     		             var personName = node.text;
                     		             var targetClass = node.id;
                     		             var checkUserId = node.data.userid;
                     								 var elements = $('.resultNameArea .NameArea.' + targetClass);
                     																	 
                     								 var isExisting = elements.length > 0;
                     	
                     								 var checkUserId = node.data.userid;
                     								 var writeUserId = $("#writeId").val();

                     								 
                     		             if ((!isExisting) && checkUserId != writeUserId) {
                     		                 var html = '<div class="NameArea ' + node.id + '">' + personName + '"&lt;' + checkUserId  +'@linkflow.com &gt;"  '+'<i class="fa-solid fa-xmark" onclick="removeParentElement(this)"></i></div>';
                     		                 
                     		                 $('.resultNameArea').append(html);
                     		             } else {
                     		            	 	elements.remove();
                     		             }
                     		         }
                     		     });
                     		 })
                         var to = false;
											   $('#searchInput').keyup(function () {
											       if(to) { clearTimeout(to); }
											       to = setTimeout(function () {
											           var v = $('#searchInput').val();
											           $('#kt_docs_jstree_basic').jstree(true).search(v);
											       }, 250);
											   });
                        </script>
                        <script>
					                	$(document).ready(function(){
					                		$(".origin_del").on("click", function(){
					                			// 삭제하고자 하는 해당 첨부파일 번호를 form submit시 넘기기 위한 작업
					                			// => 해당 form요소내에 input type="hidden" 만들어서 append
					                			let inputEl = document.createElement("input");
					                			inputEl.type = "hidden";
					                			inputEl.name = "delFileNo";
					                			inputEl.value = $(this).data("fileno")
					                			
					                			document.getElementById("enrollForm").append(inputEl);
					                			
					                			// 화면으로부터 사라지도록 작업
					                			$(this).parent().remove();
					                			
					                			if ($('#oringFileTr td').children().length === 0) {
					                	            $('#oringFileTr').remove();
					                	    }
					                		})
					                	})
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