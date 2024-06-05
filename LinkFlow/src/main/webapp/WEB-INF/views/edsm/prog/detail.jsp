<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진행중인 문서 상세</title>
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

    h6 {
      margin-top: 10px;
    }

    .sign-img-area{
      text-align: center;
      width: 200px;
      vertical-align: middle !important;
    }

    .document-header{
      font-weight: bold;
      font-size: x-large;
      margin-right: 15px;
    }

    .attachment{
      margin-bottom: 30px;
    }
    .document-title {
      position: relative;
      margin-bottom: 20px;
    }

  .attachment-content {
    display: flex;
    align-items: center;
  }

  .document-comment > span{
    margin-right: 20px;
  }
  .document-comment-title{
    background-color: lightgray;
    width: 100px;
    height: 32px;
    text-align: center;
  }
  
  .document-comment-content{
    display: flex;
    flex-direction: column;
    background-color: lightgray;
    height: 300px;
  }

  .document-comment-content{
    padding: 20px 0px 0px 20px;
  }

  .document-approval-user-name{
    margin-right: 25px;
    font-weight: bold;
  }

  #hoverfile{
    cursor: pointer;
  }
	
	tbody{
      background-color: white !important;
  }
    
  /* 버튼 간격 조절 */
  button{
    margin-right: 6px !important;
  }

  .form-check-radio{
    display: inline-block; /* 인라인 요소로 표시 */
    margin-right: 10px; /* 요소들 사이의 간격 조절 */
  }

  .btnArea{
      margin-bottom: 30px;
    }
	
	.docContentArea{ padding: 25px 10px 25px 10px; border: 2px solid lightgray; margin: 40px 0px 40px 20px !important; }
	.docContentArea > .table { display: flex; flex-direction: column; align-items: center; }
	.docContentArea > h1 { margin: 30px; text-align: center !important; } 
	.ck-table-resized { min-width: 1500px; }
	
    /* 인쇄  */
    @media print {
      .LinkFlowSidebar, .btnArea, .draft-inquiry > h6, .document-header, .sign-img-area button, .security-level, .attachment-content > svg{
          display: none;
        }
    }
    
    .edHistCommentArea { margin-left: 10px; font-weight: bold; font-size: 19px;}
    
    .document-comment-content{ height: auto; }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="LinkFlowMainSection">
		<jsp:include page="/WEB-INF/views/common/sidebar/edsm/edsmSidebar.jsp"/>
	
        <div class="LinkFlowMainContent">
            
          <!-- Content Header (Page header) -->
          <section class="content-header content">
            <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0">진행중인문서 상세</h1>
            </div>
          </div>
          </section>
               
          <!-- Main content -->
          <section class="content">
           <div class="container-fluid" style="display: flex; justify-content: center;"> 
             <div class="contentArea">

               <div class="contentInElement">
               	<div class="btnArea">
               	<c:forEach var="edocHist" items="${edoc.docHistList}">
               	<c:if test="${edocHist.userId == loginUser.userId}">
                 <!-- <button class="btn btn-primary btn-sm" onclick="modifySecCode();">수정</button> -->
                 <!-- <button class="btn btn-danger btn-sm" onclick="modifyDelYn();">기안취소</button> -->
               	</c:if>
               	</c:forEach>
                 <button class="btn btn-info btn-sm" onclick="docPrint();">인쇄</button>
               </div>
               
             <!-- 기본 설정-->
             <div class="draft-inquiry" id="draft-inquiry-content">
               <h6>기본 설정</h6>
               <table class="table table-bordered setting-table">
                 <tbody>
                   <tr>
                     <th class="table-active">문서 종류</th>
                     <td>
                       ${edoc.edFrName}
                     </td>
                     <th class="table-active">문서번호</th>
                     <td>${edoc.edNo}</td>
                   </tr>
                   <tr>
                     <th class="table-active">기안 부서</th>
                     <td>
                       ${edoc.deptTitle}
                     </td>
                     <th class="table-active">기안자</th>
                     <td>
                       ${edoc.regId}
                     </td>
                   </tr>
                   <tr>
                     <th class="table-active">보존 연한</th>
                     <td>
                       <c:choose>
		                    <c:when test="${edoc.presDate == 0}">
		                        영구
		                    </c:when>
		                    <c:otherwise>
		                        ${edoc.presDate}년
		                    </c:otherwise>
		                	</c:choose>
                     </td>
                     <th class="table-active">보안 등급</th>
                     <td>
                     	 ${edoc.secCode}등급
                       <%-- <select name="secCode" id="selectedSecCode" class="form-control security-level">
                         <option value="S" <c:if test="${edoc.secCode == 'S'}">selected</c:if>>S등급</option>
                         <option value="A" <c:if test="${edoc.secCode == 'A'}">selected</c:if>>A등급</option>
                         <option value="B" <c:if test="${edoc.secCode == 'B'}">selected</c:if>>B등급</option>
                         <option value="C" <c:if test="${edoc.secCode == 'C'}">selected</c:if>>C등급</option>
                     </select> --%>

                     <!-- <div class="hidden-on-print-securityLevel">
                       <span id="selectedSecurityLevel"></span>
                     </div> -->
                     </td>
                   </tr>
                 </tbody>
               </table> 

           <!-- 결재란 -->
           <div class="approval-line">
               <table class="table table-bordered" style="margin-top: 10px;">
	                 <tr>
	                   <th rowspan="2" class="table-active" style="text-align: center; vertical-align: middle;" width="100">결재</th>
		                 <c:forEach var="edocHist" items="${edoc.docHistList}">
			                <th class="table-active" style="text-align: center; vertical-align: middle;">${edocHist.userName}</th>
			               </c:forEach>
	                 </tr>
                 <tr>
	                <c:forEach var="edocHist" items="${edoc.docHistList}">
		                 <c:choose>
		                 	<c:when test="${edocHist.edHistSubCode != null}">
		                 		<%-- <td class="sign-img-area">
			                     <img src="${contextPath}<c:out value='${edocHist.signUrl}'/>" style="width: 150px; height: 150px;">
			                   </td> --%>
			                   
			                   <c:choose>
			                   	<c:when test="${edocHist.edHistSubCode == '01'}">
			                   		<td class="sign-img-area">
			                     		<c:choose>
			                     			<c:when test="${edocHist.signUrl == null}">
			                     				<img src="${contextPath}/resources/images/common/default_sign_approval.png" style="width: 150px; height: 150px;">
			                     			</c:when>
			                     			<c:otherwise>
					                     		<img src="${contextPath}<c:out value='${edocHist.signUrl}'/>" style="width: 150px; height: 150px;">
			                     			</c:otherwise>
			                     		</c:choose>
			                   		</td>
			                   	</c:when>
			                   	
			                   	<c:otherwise>
			                   		<td class="sign-img-area">
			                     		<img src="${contextPath}/resources/images/common/default_sign_cancel.png" style="width: 150px; height: 150px;">
			                   		</td>
			                   	</c:otherwise>
			                   </c:choose>
			                   
		                 	</c:when>
		                 	
		                 	<c:otherwise>
			                	<td class="sign-img-area">	
			                		<c:if test="${edocHist.userId == loginUser.userId}">	                   		
				                     <button class="btn btn-primary" data-toggle="modal" data-target="#approvalModal">결재</button>
				                 	</c:if>
				                 </td>
		                 	</c:otherwise>
		                 	
		                 </c:choose>
	                 </c:forEach>
                 </tr>
                 <!-- 참조자가 있을 때만 보일 영역 -->
                 <c:if test="${edoc.docRefList != null}">
	                 <tr>
	                   <th class="table-active" style="text-align: center; vertical-align: middle;">참조</th>
	                   <td colspan="3">
	                     <c:forEach var="edocRef" items="${edoc.docRefList}" varStatus="status">
	                     	${edocRef.userName}
	                     	<c:if test="${!status.last}">
													/	                     	
	                     	</c:if>
	                     </c:forEach>
	                     <!-- <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#refConfirmModal">확인</button> -->
	                   </td>
	                 </tr>
                 </c:if>
               </table>
           </div>
           
           <!-- 참조 확인 모달 -->
           <!-- The Modal -->
           <div class="modal" id="refConfirmModal">
             <div class="modal-dialog">
               <div class="modal-content">

                 <!-- Modal Header -->
                 <div class="modal-header">
                   <h4 class="modal-title">참조</h4>
                   <button type="button" class="close" data-dismiss="modal">&times;</button>
                 </div>

                 <!-- Modal body -->
                 <div class="modal-body">
                   참조 확인하시겠습니까?
                 </div>

                 <!-- Modal footer -->
                 <div class="modal-footer d-flex justify-content-center">
                   <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">확인</button>
                   <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">취소</button>
                 </div>

               </div>
             </div>
           </div>

           <!-- 결재 모달 -->
           <!-- The Modal -->
           <form action="${contextPath}/edsm/prog/approval.prog" method="post">
           <div class="modal" id="approvalModal">
             <div class="modal-dialog modal-lg">
               <div class="modal-content">

                 <!-- Modal Header -->
                 <div class="modal-header">
                   <h4 class="modal-title">결재</h4>
                   <button type="button" class="close" data-dismiss="modal">&times;</button>
                 </div>

                 <!-- Modal body -->
                 <div class="modal-body">
                   <div class="approval-enable">
                     <div class="form-check form-check-radio">
                     	 <input type="hidden" name="edNo" value="${edoc.edNo}">
                       <input class="form-check-input" type="radio" name="edHistSubCode" value="01" id="radio-approve1" checked>
                       <label class="form-check-label" for="radio-approve1">
                         승인
                       </label>
                     </div>
                     <div class="form-check form-check-radio">
                       <input class="form-check-input" type="radio" name="edHistSubCode" value="02" id="radio-approve2">
                       <label class="form-check-label" for="radio-approve2">
                         반려
                       </label>
                     </div>
                   </div>
                   <br>
                   <div class="approval-enable-comment">
                     <div class="approval-enable-comment-header">
                       <b>승인 / 반려 의견</b><br>
                       <textarea name="edHistComment" id="" class="form-control" cols="30" rows="10" style="resize: none;" placeholder="의견 입력" required="required"></textarea>
                     </div>
                   </div>
                 </div>

                 <!-- Modal footer -->
                 <div class="modal-footer d-flex justify-content-center">
                   <button type="submit" class="btn btn-primary">확인</button>
                 </div>

               </div>
             </div>
           </div>
				 </form>

           <!-- 제목 -->
           <div class="document-title" style="margin-bottom: 25px;">
             <div><span class="document-header">제목</span>${edoc.edTitle}</div>
           </div>

           <div class="document-content">
             <span class="document-header">내용</span><br>
             <div class="docContentArea">
             	${edoc.edContent}      <!-- 에디터 영역 -->
             </div>
             <!-- <script src="../../../ckeditor5/build/ckeditor.js"></script>
             <div id="editor">에디터 영역</div>
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
             </script> -->
             <hr>
						
						<%-- <c:if test="${edoc.attachList != null}">
							<c:forEach var="at" items="${edoc.attachList}">
		             <div class="attachment">
		               <div class="attachment-title" style="margin-bottom: 10px;">
		                 <b style="margin-right: 10px;">별첨</b>
		                 <span id="hoverfile" onclick="$('#file-input').click();">파일 및 관련문서 첨부</span>
		                 <input id="file-input" type="file" style="display: none;">
		               </div>
		               <div class="attachment-content">
		                 <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originName}" style="margin-right: 5px;">${at.originName}</a>
		                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-circle-fill" viewBox="0 0 16 16">
		                   <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293z"/>
		                 </svg>
		               </div>
		             </div>
	             </c:forEach>
             </c:if> --%>
             
             <div class="document-comment">
               <div class="document-comment-title">
                 이력
               </div>
               <div class="document-comment-content">
                 <c:forEach var="edocHist" items="${edoc.docHistList}">
                 	<c:if test="${edocHist.edHistSubCode != null}">
		                 <div>
		                   <span class="document-approval-user-name">${edocHist.userName}</span>
		                   <c:choose>
		                   	<c:when test="${edocHist.edHistSubCode == '01'}">
		                   		<span>결재</span>
		                   	</c:when>
		                   	<c:otherwise>		                   	
		                   		<span>반려</span>
		                   	</c:otherwise>
		                   </c:choose>
		                   <c:choose>
		                   	<c:when test="${edocHist.edHistComment != null}">
		                   		<br><br>
		                   		<span class="edHistCommentArea">의견 : ${edocHist.edHistComment}</span>
		                   	</c:when>
		                   </c:choose>
			                 <hr>
		                 </div>
	                 </c:if>
                </c:forEach>
               </div>
             </div>
   					</div>
             
           </div>
               </div>
             </div>
           </div>
           
          </section>
          <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->
	</div>
	
	<script>
				
				// 보안등급 수정
				function modifySecCode(){
					location.href = '${contextPath}/edsm/prog/modifySecCode.prog?edNo=' + '${edoc.edNo}' + '&secCode=' + $('#selectedSecCode').val();
					
				};
				
				function modifyDelYn(){
					location.href = '${contextPath}/edsm/prog/modifyDelYn.prog?edNo=' + '${edoc.edNo}';	
				};
				
        // 인쇄
        function docPrint(){
          /*let initBody = document.body.innerHTML;
          window.onbeforeprint = function(){
              printSelectedOptionValue();
              document.body.innerHTML = document.getElementById("draft-inquiry-content").innerHTML;
          }
          window.onafterprint = function(){
              document.body.innerHTML = initBody;
          }
          window.print();*/
          
          const html = $('html');
          const printContents =  $('#draft-inquiry-content').html();
          const printDiv = $("<div class='print-page';></div>");

          html.append(printDiv);
          printDiv.html(printContents);
          $('body').css('display','none');
          window.print();
          $('body').css('display','block');
          printDiv.css('display','none');
        };

        // 선택된 옵션의 값을 출력하는 함수
        function printSelectedOptionValue() {
            let selectElement = document.querySelector('.security-level');
            let selectedOption = selectElement.options[selectElement.selectedIndex];
            let selectedValue = selectedOption.text;

            // 인쇄 시에만 보이는 영역에 선택된 옵션의 값 출력
            document.getElementById('selectedSecurityLevel').textContent = selectedValue;
        };
	</script>
</body>
</html>