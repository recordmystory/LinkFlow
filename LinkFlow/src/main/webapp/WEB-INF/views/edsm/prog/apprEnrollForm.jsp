<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안서 작성</title>

<!-- ckedtior -->
<script src="${contextPath}/resources/ckeditor5/edsm/build/ckeditor.js"></script>

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
	.contentInElement{display: block !important; justify-content: space-between; margin-bottom: 30px;}
	.dmovePage {
	   padding: .0rem 0rem;
	 }
	 
	  .dmovePage .slimMenu {
        padding: .0rem 0rem;
      }

     .slimMenu {
        display: flex; /* 아이템들을 수평으로 정렬하기 위해 Flexbox를 사용합니다. */
        align-items: center; /* 수직 가운데 정렬을 위해 Flexbox를 사용합니다. */
        width: 150px;
      } 

      .slimMenu i {
        margin-right: 10px; /* 아이콘과 텍스트 사이의 간격을 조정합니다. */
        font-size: 28px; /* 아이콘 크기를 20px로 설정합니다. */
      }

      .slimMenu .spanCss {
        display: inline-block; /* 텍스트를 인라인 블록 요소로 변경하여 왼쪽 정렬을 할 수 있게 합니다. */
      }
      .slimMenuicon{
        width: 32px;
      }
    /*여기까지 메인 영역 요소  공용 스타일임 */
    
    /* 항상 사용할 CSS 추가 */
    tbody{
      background-color: white;
    }
    
    /* 해당 페이지에서 사용할 CSS 추가 */
    .bottom-menu{
      width: 20%;
    }

    .search-keyword{
      width: 300px;
    }

    .search{
      display: flex;
    }

    .header-parent {
        display: flex;
        align-items: center; /* 모든 요소를 수직으로 중앙 정렬합니다. */
    }

    .approval-line-title {
      display: flex;
      align-items: center;
    }

    /* 이 페이지내에서만 쓸 CSS 추가 */
    .setting-table > th {
      width: 5px;
    }

    .content-element{
      padding: 15px 0px 15px 0px;
    }

    .approval-line-title h6 {
      display: inline; 
    }

    .approval-line-title button {
      margin-left: 10px; 
    }

    .content-area > div:not(.drafting-content) > div  {
      margin-top: 30px;
    }

    .btnArea{
      margin-bottom: 30px;
    }

    .ck-editor__editable{
      min-height: 600px;
    }

    /* 결재선 설정 모달  */
    .orginazation-tree input[type="checkbox"]{
            display: none;
        }

    .orginazation-tree input[type="checkbox"]:checked~ul{ 
    /* 체크가 된 태그 이후에 등장하는 ul 태그 선택 */
        display: none;
    }

    .orginazation-tree input[type="checkbox"]:checked+label::before{
        content: '\f0fe';
        font-family: "Font Awesome 5 Free";   
        font-weight: 400;
    }

    .approval-line-tree ul{
        list-style: none;
        padding-left: 17px;
    }

    .orginazation-tree label::before{
        content: '\f146';   
        font-family: "Font Awesome 5 Free";   
        font-weight: 400;
    }

    .orginazation-tree *::before{
        width: 27px;
        display: inline-block;
    }

    /* 결재선 설정 modal */
    .aprroval-line-content{
        display: flex;
    }


    .approval-line-content{
        display: flex;
        flex-direction: row;
    }

    .approval-line-tree, .name-list {
        border: 1px solid lightgray;
    }

    .approval-line-content > div {
        margin-right: 10px;
    }

    .name-list{
        border: 2px solid lightgray;
        display: flex;
        flex-direction: column;
    }

    .name-select{
        background-color: lightgray;
        margin-top: auto;
    }

    .user-name-list{
        border: 1px solid lightgray;
    }

    /* 모달 높이 설정 */
    .modal-content{
        height: 700px;
    }

    /* 버튼 간격 조절 */
    button {
      margin-right: 6px !important;
    }

    /* 버튼 밑 간격 조절 */
    .btnArea{
      margin-bottom: 40px;
    }

    /* 휴가신청 양식 CSS */
    #dayoffReason{
      resize: none;
      height: 200px;
    }

    .date{
      width: 300px;
      display: inline-block;
    }

    .dayoff-table-title{
      width: 150px;
    }

    .dayoff-table-type{
      width: 200px;
    }

    /* 결재선 설정 modal */
    .modal-btnArea{
    
    margin-left: 20px;
    width: 50px;
    height: 500px;

    }
    .upArea{
    display: flex;
    flex-direction: column;
    margin: auto;
    padding: 20px;
    margin-top: 50px;
    }
    .upArea i{
    cursor: pointer;
    margin: 15px;
    }
    .downArea i{
    cursor: pointer;
    margin: 15px;
    }
    .downArea{
    display: flex;
    flex-direction: column;
    margin: auto;
    padding: 20px;
    margin-top: 150px;
    }
    .singArea{
    margin-left: 50px;
    
    
    }
    .searchUser{
        display: flex;
        margin: auto;
    }

    .modal-footer {
      background-color: white;
    }

    .modal-body {
      padding: 0px 0px 0px 0px !important;
    }

    
</style>


</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="LinkFlowMainSection">
	<jsp:include page="/WEB-INF/views/common/sidebar/edsm/edsmSidebar.jsp"/>
	<!-- 이 위치에 script 태그가 꼭 위치해야함 다른곳에 넣으면 제대로 작동 안함 -->

	
        <div class="LinkFlowMainContent">
            
          <!-- Content Header (Page header) -->
          <section class="content-header content">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h1 class="m-0">기안서 작성</h1>
              </div>
            </div>
          </section>
               
                <!-- Main content -->
                <section class="content">
	                <div class="container-fluid" style="display: flex; justify-content: center;"> 
	                  <div class="contentArea">
	
	                   <form id="draftingForm" action="${contextPath}/edsm/prog/draftingDoc.prog" method="post">
	                    <div class="contentInElement">
	                        <div class="btnArea">
                            <button type="submit" id="draftingBtn" class="btn btn-primary btn-sm">기안하기</button>
                            <button class="btn btn-secondary btn-sm">임시저장</button>  
                          </div>

                          <!-- 기본 설정-->
                          <div class="default-setting">
                              <h6>기본 설정</h6>
                              <table class="table table-bordered setting-table">
                                <tbody>
                                  <tr>
                                    <th class="table-active">문서 종류</th>
                                    <td>
                                      <select class="form-control documentTypeSelect" name="edFormCode" id="documentTypeSelect">
                                        <c:forEach var="fr" items="${list}" varStatus="num">
																	       <option value="${fr.edFrCode}">${fr.edFrName}</option>
																	    	</c:forEach>
                                      </select>
                                    </td>
                                    <th class="table-active">작성자</th>
                                    <td>Linkflow ${loginUser.position} ${loginUser.userName}</td>
                                  </tr>
                                  <tr>
                                    <th class="table-active">보존 연한</th>
                                    <td>
                                      <select class="form-control" name="presDate">
                                        <option value="1">1년</option>
                                        <option value="3">3년</option>
                                        <option value="5">5년</option>
                                        <option value="10">10년</option>
                                        <option value="0" selected>영구</option>
                                      </select>
                                    </td>
                                    <th class="table-active">보안 등급</th>
                                    <td>
                                      <select class="form-control" name="secCode">
                                        <option value="S">S등급</option>
                                        <option value="A">A등급</option>
                                        <option value="B">B등급</option>
                                        <option value="C" selected>C등급</option>
                                    </select>
                                    </td>
                                  </tr>
                                </tbody>
                              </table> 

                          <!-- 결재선 -->
                          <div class="approval-line">
                              <div class="approval-line-title">
                                <h6 style="margin-right: 10px;">결재선</h6>
                                <button type="button" class="btn btn-dark btn-sm" data-toggle="modal" data-target="#modal-xl">결재선 설정</button>
                              </div>
                              <table class="table table-bordered" style="margin-top: 10px;">
                                <tr>
                                  <th rowspan="2" class="table-active" style="text-align: center; vertical-align: middle;" width="100">결재</th>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">
                                  <div><input type="hidden" name="edocHistList[0].userId" value="${loginUser.userId}">${loginUser.userName}</div>
                                  </th>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;" id="approvalSelectedArea1"></th>
                                
                                  <th class="table-active" style="text-align: center; vertical-align: middle;" id="approvalSelectedArea2"></th>
                               
                                </tr>
                                <tr>
                                  <td height="200" width="300"></td>
                                  <td height="200" width="300"></td>
                                  <td height="200" width="300"></td>
                                </tr>
                                <tr>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">참조</th>
                                  <td colspan="3" id="refSelectedArea"><!-- <input type="text" name="refMember" id="refMember" class="form-control" style="width: 300px;"> --></td>
                                	
                                </tr>
                              </table>

                          
                          <!-- 제목 -->
                          <div class="drafting-title" style="margin-bottom: 25px;">
                            <h6>제목</h6>
                            <input type="text" name="edTitle" id="" class="form-control" style="width: 1000px;" required="required">
                          </div>

                          <!-- 휴가신청서 폼이 뿌려질 곳-->
                          <div class="dayoff-table">

                          </div>

                          <div class="drafting-content">
                            <h6>본문</h6>
                            <div id="editor">제목</div>
                          	<input type="hidden" id="editorContent" name="edContent">
                          </div>
                        </div>
                        
                      </div>
	                    </div>
	                  </form>
	                  </div>
	                </div>
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
    </div>
  
      
    <!-- 모달 영역 -->
    <div class="modal fade" id="modal-xl">
      <div class="modal-dialog modal-xl">
        <div class="modal-content" style="min-width: 1400px;">
          <div class="modal-header">
            <h4 class="modal-title">결재선 설정하기</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="row" style="min-width: 1400px;">
              <div class="card-body">

                  <form action="xxxxxxx" method="post">
                   <div class="searchUser">

                     <div class="col-md-3" style="margin-top: 15px;">
                       <div class="form-group">
                         <div class="input-group" style="width: 800px;">
                             <input type="search" class="form-control" id="searchInput" placeholder="사원명이나 조직명으로 검색하세요" value="" name="useName">
                             <div class="input-group-append">
                                 <button type="submit" class="btn  btn-primary">
                                     <i class="fa fa-search"></i>
                                 </button>
                             </div>
                         </div>
                       </div>
                     </div>
                   </form>

                   </div><!--searchUser 끝-->

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
	                                         			<li data-jstree='{ "type" : "person" }' data-userid="${apprPerson.userId}">
	                                                 ${apprPerson.userName} ${apprPerson.subName}
	                                                 <input type="text" class="userId" value="${apprPerson.userId}" style="display: none;"/>
	                                                
	                                             </li>
	                                         		</c:forEach>
	                                         </ul>
		                                   </li>
	                                   </c:forEach>
                                    </ul>
                           </ul>
                               
                          
                         </div><!--jstree 끝-->
                         
                         
                       </div>
                     </div>

                     <div class="card card-info" style="width: 500px; height: 500px;">
                       <div class="card-header">
                         <h3 class="card-title">
                            결재자 선택
                         </h3>

                       </div>
                       <div class="card-body text-nowrap overflow-auto resultNameArea">
                        
                       
                       </div>
                     </div>
                     
                     <div class="btnArea">
                       <div class="upArea">
                         <i class="fa-solid fa-angles-right approvalIn"></i>
                         <i class="fa-solid fa-angles-left approvalOut"></i>
                       </div>

                       <div class="downArea" >
                         <i class="fa-solid fa-angles-right referenceIn"></i>
                         <i class="fa-solid fa-angles-left referenceOut"></i>
                       </div>
                     </div>
                     
                     <div class="column singArea">
                     <div class="card card-info" style="width: 400px;  height: 200px;">
                       <div class="card-header">
                         <h5 class="card-title">결재</h5>
                         <div class="card-tools">
                           <button type="button" class="btn btn-tool" >
                             <i class="fa-solid fa-angles-up approvalUpBtn"></i>
                           </button>
                           <button type="button" class="btn btn-tool" >
                             <i class="fa-solid fa-angles-down approvalDownBtn"></i>
                           </button>
                         </div>
                        

                       </div>
                       <div class="card-body approvalArea">
                         <input type="hidden" value="" id="approvalUserId">
                       </div>
                     </div>

                     <div class="card card-info" style="width: 400px;  height: 200px; margin-top: 100px;">
                       <div class="card-header">
                         <h5 class="card-title">참조</h5>
                         
                        
                       </div>
                       <div class="card-body referenceArea overflow-auto">
                         <input type="hidden" value="" id="approvalUserId">
                       </div>
                     </div>
                     </div>


                   </div>
               </div>
               <!-- /.card-body -->
          
            </div>
          </div>
          <div class="modal-footer justify-content-center">
            <button type="button" class="btn btn-primary" id="saveData" data-dismiss="modal">확인</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    	
 <script>
 var editor;

 ClassicEditor
     .create(document.querySelector('#editor'))
     .then(newEditor => {
         editor = newEditor;
         
         
         $('#documentTypeSelect').change(function(){
     		
     		$.ajax({
     			url: '${contextPath}/edsm/prog/edFrContentList.prog',
     			type: 'post',
     			data: {docType: $(this).val()},
     			success: function(result){
     				editor.setData(result[0].edFrContent);
     			},
     			error: function(){
     				console.log('ajax 통신 실패');
     			}
     		});
     		
     	});
     })
     .catch(error => {
         console.error(error);
         
     });
 		
    $(function(){
    	 let approvalHiddenValues = [];
 	     let referenceHiddenValues = [];
    	
    	$('#draftingForm').on('submit', function(event) {
	          // 폼이 실제로 제출되지 않도록 기본 동작을 막음
	          event.preventDefault();
						
	          // 에디터 내용 담기
		    		let edFrContent = editor.getData();
		    		$('#editorContent').val(edFrContent);
    		    
	          // 폼을 실제로 제출
	          this.submit();
        });
    	
    	$('.documentTypeSelect').change(function(){
            // 휴가신청서 폼 뿌려지게
              if($(this).val() == '3'){
              	$('.drafting-content').hide();
               $('.dayoff-table').append(`<h6>신청</h6>
                                          <table class="table table-bordered dayoff-table">
                                            <tbody>
                                              <tr>
                                                <th class="table-active dayoff-table-title">휴가종류</th>
                                                <td>
                                                  <select class="form-control" id="dayoff-table-type">
                                                    <option value="">오전반차</option>
                                                    <option value="">오후반차</option>
                                                    <option value="">연차</option>
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr>
                                                <th class="table-active dayoff-table-title">휴가일자</th>
                                                <td>
                                                  <input type="date" name="startDate" id="startDate" class="form-control date">        
                                                  <span style="margin: 0px 50px 0px 50px; font-weight: bold;">~</span>
                                                  <input type="date" name="endDate" id="endDate" class="form-control date">
                                                </td>
                                                <tr>
                                                  <th class="table-active dayoff-table-title">휴가사유</th>
                                                  <td>
                                                    <textarea name="dayoffReason" id="dayoffReason" placeholder="휴가사유 입력" class="form-control"></textarea>
                                                  </td>
                                                </tr>
                                            </tbody>`);
              
            } else {
            	$('.drafting-content').show();
              $('.dayoff-table').html('');
            }

    	});
    	
    });
    
    $('#saveData').click(function(){
    	approvalHiddenValues = [];
    	referenceHiddenValues = [];

    
    	var approvalName1Html = $('.approvalName1')
    	    .clone() 
    	    .find('input[type="checkbox"]') 
    	    .remove() 
    	    .end() 
    	    .find('.userId')
    	    .attr('name', 'edocHistList[1].userId') 
    	    .css('display', 'none') 
    	    .end() 
    	    .html(); 

    
    	$('#approvalSelectedArea1').html(approvalName1Html);

    	
    	var approvalName2Html = $('.approvalName2')
        .clone() 
        .find('.userId')
        .attr('name', 'edocHistList[2].userId') 
        .css('display', 'none') 
        .end() 
        .find('input[type="checkbox"]') 
        .remove() 
        .end() 
        .html(); 

    $('#approvalSelectedArea2').html(approvalName2Html);

    
    	var $referAreaContent = '';
    	$('.referenceName').each(function(index) {
    	    var referenceNameHtml = $(this)
            .clone() 
            .find('input[type="checkbox"]') 
            .remove() 
            .end() 
            .find('.userId')
            .attr('name', 'edocRefList[' + index + '].userId') 
            .css('display', 'none') 
            .end() 
            .html(); 

        $referAreaContent += '<div class="referArea">' + referenceNameHtml + '</div>';
    	});
    	$('#refSelectedArea').html($referAreaContent);

    	
    	$('.approvalName1, .approvalName2, .referenceName').each(function() {
    	    var hiddenValue = $(this).attr('data-hidden-value');
    	    if (hiddenValue) {
    	        if ($(this).hasClass('approvalName1') || $(this).hasClass('approvalName2')) {
    	            approvalHiddenValues.push(hiddenValue);
    	        } else if ($(this).hasClass('referenceName')) {
    	            referenceHiddenValues.push(hiddenValue);
    	        }
    	    }
    	});
        
    });



          // 결재선 설정 모달 스크립트
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
            var userId = node.li_attr['data-userid']; 
           
           
            var existNameArea = $('.resultNameArea [data-userid="' + userId + '"]');
					
            if (existNameArea.length >0) { 
                existNameArea.remove(); 
            }else{

            var html = '<div class="NameArea" data-userid="' + userId + '">' + personName + '<input type="checkBox"></div>';
            $('.resultNameArea').append(html);
            }
        }
    });
		
   var to = false;
   $('#searchInput').keyup(function () {
       if(to) { clearTimeout(to); }
       to = setTimeout(function () {
           var v = $('#searchInput').val();
           $('#kt_docs_jstree_basic').jstree(true).search(v);
       }, 250);
   });
          
   document.querySelector('.approvalIn').addEventListener('click', function() {
       var nameAreas = document.querySelectorAll('.NameArea');
       var existingApprovalCount = document.querySelectorAll('.approvalArea .approvalName').length;
       var maxApprovalCount = 2;

       var currentIndex = existingApprovalCount + 1;

       nameAreas.forEach(function(nameArea) {
           if (existingApprovalCount >= maxApprovalCount) return;

           var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
           if (checkbox) {
               
               var nameValue = nameArea.innerHTML.trim();

               if (currentIndex > maxApprovalCount) return;

               var className = 'approvalName' + currentIndex;

               var newElement = document.createElement('div');
               newElement.className = className;
               newElement.innerHTML = nameValue; 

               document.querySelector('.approvalArea').appendChild(newElement);

               nameArea.remove();

               existingApprovalCount++;
               currentIndex++;
           }
       });
   });

   document.querySelector('.approvalOut').addEventListener('click', function() {
       var approvalNames1 = document.querySelectorAll('.approvalArea .approvalName1');
       var approvalNames2 = document.querySelectorAll('.approvalArea .approvalName2');

       moveApprovalNames(approvalNames1);
       moveApprovalNames(approvalNames2);
   });

   function moveApprovalNames(approvalNames) {
       approvalNames.forEach(function(approvalName) {
           var checkbox = approvalName.querySelector('input[type="checkbox"]:checked');
           if (checkbox) {
               var nameText = approvalName.innerHTML.trim();

               var resultName = document.createElement('div');
               resultName.className = 'NameArea';
               resultName.innerHTML = nameText;

               var newCheckbox = document.createElement('input');
              

               document.querySelector('.resultNameArea').appendChild(resultName);

               approvalName.remove();
           }
       });
   }

           

      document.querySelector('.referenceIn').addEventListener('click', function() {
        
        var nameAreas = document.querySelectorAll('.NameArea');

       
        nameAreas.forEach(function(nameArea) {
            
            var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
            
            if (checkbox) {
                
                var nameValue = nameArea.innerHTML.trim();
                
                var referenceName = document.createElement('div');
                referenceName.className = 'referenceName';
                referenceName.innerHTML = nameValue;
                document.querySelector('.referenceArea').appendChild(referenceName);
                
                nameArea.remove();
            }
        });
    });

    document.querySelector('.referenceOut').addEventListener('click', function() {
        var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

        approvalNames.forEach(function(referenceName) {
            var checkbox = referenceName.querySelector('input[type="checkbox"]:checked');
            if (checkbox) {
                var nameValue = referenceName.innerHTML.trim();

                var resultNameArea = document.querySelector('.resultNameArea');

                var nameArea = document.createElement('div');
                nameArea.className = 'NameArea';
                nameArea.innerHTML = nameValue;

                resultNameArea.appendChild(nameArea);

                referenceName.remove();
            }
        });
    });

    document.querySelector('.approvalUpBtn').addEventListener('click', function() {
        var approvalName1 = document.querySelector('.approvalArea .approvalName1');
        var approvalName2 = document.querySelector('.approvalArea .approvalName2');

        if (approvalName1 && approvalName2) {
            var tempHTML = approvalName1.innerHTML;  // textContent 대신 innerHTML 사용
            approvalName1.innerHTML = approvalName2.innerHTML;
            approvalName2.innerHTML = tempHTML;
        }
    });

    document.querySelector('.approvalDownBtn').addEventListener('click', function() {
        var approvalName1 = document.querySelector('.approvalArea .approvalName1');
        var approvalName2 = document.querySelector('.approvalArea .approvalName2');

        if (approvalName1 && approvalName2) {
            var tempHTML = approvalName1.innerHTML;  // textContent 대신 innerHTML 사용
            approvalName1.innerHTML = approvalName2.innerHTML;
            approvalName2.innerHTML = tempHTML;
        }
    });

    
</script>
</body>
</html>