<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 게시판</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
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
#enrollForm>table{width:100%;}
#enrollForm>table *{ margin:10px;}
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
  width: 1200px;
  border: black;
  vertical-align: middle;
}

#enrollForm span {
  text-align: center;
  align-self: center;
}    
</style>
</head>
<body>
<div class="wrapper">
 <jsp:include page="/WEB-INF/views/common/header.jsp" />
 <div class="LinkFlowMainSection">
  <jsp:include page="/WEB-INF/views/common/sidebar/board/boardSidebar.jsp" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
  <div class="LinkFlowMainContent">
	  <!-- Content Header (Page header) -->
	  <section class="content-header">
	      <div class="row mb-2">
	          <div class="col-sm-6">
	              <h1 class="m-0">게시판 만들기</h1>
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
 <%--                	<c:if test="${categoryMaster.userId == loginUser.userId }"> --%>
                    <button type="button" class="btn btn-danger btn-sm" style="margin-right: 6px;" onclick="sendRequest()">삭제</button>
<%--                    </c:if> --%>
                    <button type="button" class="btn btn-primary btn-sm" style="margin-right: 6px;" onclick="submitForm()">수정하기</button>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.go(-1);">취소</button>
                </div>
            </div>
            <div style="min-height: 500px; min-width: 100%;">
                <form id="enrollForm" method="post" action="${contextPath }/board/updateBoard.do?type=${boardType}">
                    <table>
                        <tr>
                            <th width="130"><label for="title">게시판 제목</label></th>
                            <td><input type="text" id="title" class="form-control" name="categoryTitle" value="${boardName }" required placeholder="게시판 제목을 입력해주세요"></td>
                        </tr>
                        <tr>
                            <th><label for="title">사용자 및 권한</label></th>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg">인원추가</button>
                            </td>
                        </tr>
                    </table>
                    <div style="min-height: 500px; min-width: 100%;">
                        <div class="card">
                            <div class="card-body table-responsive p-0">
                                <table id="createTable" class="table table-hover text-nowrap" style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th width="200">부서</th>
                                            <th width="200">직급</th>
                                            <th width="1200">이름</th>
                                            <th width="300">쓰기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                 			<tr>
                                       	<input type="hidden" name="AuthList[0].userId" value="${categoryMaster.userId}" id="masterUserId">
                                       	<input type="hidden" name="AuthList[0].writeYN" value="Y" >
                                       	<input type="hidden" name="AuthList[0].boardCategory" value="${boardType }" >
		                                    <th>${categoryMaster.deptName }</th>
		                                    <th>${categoryMaster.position }</th>
		                                    <th>${categoryMaster.userName }</th>
		                                    <th><i class="fa-solid fa-crown"></i></th>
		                                  </tr>
		                                  <c:if test="${categoryMaster.userId != loginUser.userId }">
		                                  	<tr>
	                                       	<input type="hidden" name="AuthList[1].userId" id="writeId" value="${loginUser.userId}">
			                                    <input type="hidden" name="AuthList[1].writeYN" value="Y" >
			                                    <input type="hidden" name="AuthList[1].boardCategory" value="${boardType }" >
			                                    <th>${loginUser.deptName }</th>
			                                    <th>${loginUser.position }</th>
			                                    <th>${loginUser.userName }</th>
			                                    <th><i class="fa-solid fa-check"></i></th>
		                                  	</tr>
		                                  </c:if>
                                    	<c:forEach var="n" items="${normalUserList}" varStatus="status">
                                    		<c:choose>
                                    			<c:when test="${n.boardRight == 'Y' }">
                                    				<tr>
			                                       	<input type="hidden" name="AuthList[${status.index + masterCount}].userId" id="userId" value="${n.userId}">
			                                       	<input type="hidden" name="AuthList[${status.index + masterCount}].writeYN" id="writeId" value="Y" >
					                                    <input type="hidden" name="AuthList[${status.index + masterCount}].boardCategory" value="${boardType }" >
					                                    <td>${n.deptTitle }</td>
					                                    <td>${n.subName }</td>
					                                    <td>${n.userName }</td>
					                                    <td><i class="fa-solid fa-check"></i></td>
				                                  	</tr>
                                    			</c:when>
                                    			<c:otherwise>
                                    				<tr>
			                                       	<input type="hidden" name="AuthList[${status.index + masterCount}].userId" id="userId" value="${n.userId}">
					                                    <input type="hidden" name="AuthList[${status.index + masterCount}].boardCategory" value="${boardType }" >
					                                    <td>${n.deptTitle }</td>
					                                    <td>${n.subName }</td>
					                                    <td>${n.userName }</td>
					                                    <td><input value="<c:if test="${ n.writeYN eq 'Y' }">Y</c:if>" type="checkbox" class="writeCheckBox" name="AuthList[${status.index + masterCount}].writeYN" onclick="toggleCheckbox(this)" <c:if test="${ n.writeYN eq 'Y' }"> checked </c:if>></td>
				                                  	</tr>
                                    			</c:otherwise>
                                    		</c:choose>
                                    		
																			</c:forEach>
                                    </tbody>
                                </table>
                                <hr style="margin-top: 0px;">
                            </div>
                        </div>
                        <br>
                        <br>
                    </div>
                </form>
                
                <!-- 모달 영역 -->
                <div class="modal fade" id="modal-lg">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content" style="min-width: 870px;">
                            <div class="modal-header">
                                <h4 class="modal-title">게시판 권한설정</h4>
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
                                                                           <input type="hidden" id="userId" value="${apprPerson.userId}" />
                                                                           <input type="hidden" id="userName" value="${apprPerson.userName}" />
                                                                           <input type="hidden" id="subName" value="${apprPerson.subName}" />
                                                                           <input type="hidden" id="deptTitle" value="${appr.deptTitle}" />
                                                                           <input type="hidden" id="boardRight" value="${apprPerson.boardRight}" />
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
                                                <div class="card-body text-nowrap overflow-auto resultNameArea">
                                                	<c:forEach var="n" items="${normalUserList}" varStatus="status">
                                    									<div class="NameArea ${n.userId }">
																												${n.userName } ${n.subName }
																												<input type="hidden" id="userId" value="${n.userId }">
																												<input type="hidden" id="userName" value="${n.userName }">
																												<input type="hidden" id="subName" value="${n.subName }">
																												<input type="hidden" id="deptTitle" value="${n.deptTitle }">
																												<input type="hidden" id="boardRight" value="${n.boardRight }">
																												<i class="fa-solid fa-xmark" onclick="removeParentElement(this)" aria-hidden="true"></i>
																											</div>
                                    						
																									</c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="button" class="btn btn-primary" id="saveData" data-dismiss="modal" onclick="executeScript()">확인</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="resetModal()">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal -->
                
            </div>
        </div>
    </div>
   </section>
   <script>
	   const initialRowCount = ${masterCount};
		 
	   function sendRequest() {
		    if (confirm('삭제시 복구가 안됩니다 정말로 삭제하시겠습니까?')) {
		    	window.location.href = '${contextPath}/board/deleteCategory.do?type=${boardType}';
		    }
		}
	   
	   function toggleCheckbox(checkbox) {
		   
		   checkbox.value = checkbox.checked ? "Y" : "";
		 }
	   function submitForm() {
	       const titleInput = document.getElementById('title');

	       if (!titleInput.value.trim()) {
	           alert('게시판 제목을 입력해주세요.');
	       }

	       const form = document.getElementById('enrollForm');
	       form.submit();
			 }
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
	   
	   function executeScript() {
			  const tableBody = document.querySelector('#createTable tbody');
		    const nameAreas = document.querySelectorAll('.resultNameArea .NameArea');
				
		    if(nameAreas.length === 0) {
		    	resetModal();
		    	return;
		    }else{
		    	
		    	while (tableBody.rows.length > initialRowCount) {
				     tableBody.deleteRow(initialRowCount);
					  }
		    	
		    	for (var i = 0; i < nameAreas.length; i++) {
				    const hiddenInputs = nameAreas[i].querySelectorAll('input[type="hidden"]');
			    	const newRow = document.createElement('tr');
			    	newRow.innerHTML = 
			    		'<input type="hidden" name="AuthList[' + (i + initialRowCount) + '].userId" value='+ hiddenInputs[0].value + '>' +
			    		'<input type="hidden" name="AuthList[' + (i + initialRowCount) + '].boardCategory" value="${boardType }">' +
			    		'<td>'+ hiddenInputs[3].value + '</td>' +
			    		'<td>'+ hiddenInputs[2].value + '</td>' +
			    		'<td style="padding:12px">'+ hiddenInputs[1].value + '</td>';
			    		if(hiddenInputs[4].value == 'Y'){
			    			newRow.innerHTML += '<th style="padding:12px 24px 12px 12px"><i class="fa-solid fa-check"></i></th>' +
			    			'<input value="Y" type="hidden" class="writeCheckBox" name="AuthList[' + (i + initialRowCount) +'].writeYN">';
			    		}else{
			    			newRow.innerHTML += '<td style="padding:12px 24px 12px 12px"><input value="" type="checkbox" class="writeCheckBox" name="AuthList[' + (i + initialRowCount) +'].writeYN" onclick="toggleCheckbox(this)"></td>';		    			
			    		}
			    			
			        
			    		document.querySelector('#createTable tbody').appendChild(newRow);
			    		resetModal();
			    }
		    }
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
								 var elements = $('.resultNameArea .NameArea.' + checkUserId);						 
								 var isExisting = elements.length > 0;
	
								 var writeUserId = $("#writeId").val();
								 var masterUserId = $("#masterUserId").val();

		             if ((!isExisting) && checkUserId != writeUserId && checkUserId != masterUserId) {
		                 var html = '<div class="NameArea ' + checkUserId + '">' + personName +'<i class="fa-solid fa-xmark" onclick="removeParentElement(this)"></i></div>';
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
  </div>
 </div>
</div>

</body>
</html>