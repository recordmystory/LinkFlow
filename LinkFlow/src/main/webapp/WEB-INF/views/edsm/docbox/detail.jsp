<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서함 상세</title>

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

    /* 결재선 설정 모달 flex */
    .searchUser{ 
      display: flex;
    }

    .orginzation-approval{
      display: flex;
    }

    .orginzation-approval > div{
      border: 1px solid black;
    }

    .orginzation-tree, .orginzation-name, .approval-name{
      width: 30%;
    }

    .arrow-btn{
      width: 10%;
    }

    .direction-arrow{
      width: 10%;
    }

    
    h6 {
      margin-top: 10px;
    }

    /* 진행중문서 상세 페이지에서 사용할 css 추가 */
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
	
	.docContentArea{ border: 2px solid lightgray; padding: 25px 10px 25px 10px; margin: 40px 0px 40px 20px !important;}
	.docContentArea > .table { display: flex; flex-direction: column; align-items: center; }
	.docContentArea > h1 { text-align: center !important; margin: 30px; } 
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
                <h1 class="m-0">문서함 상세</h1>
              </div>
            </div>
          </section>
               
                <!-- Main content -->
                <section class="content">
	                <div class="container-fluid" style="display: flex; justify-content: center;"> 
	                  <div class="contentArea">
	
	                    <div class="contentInElement">
                       <div class="btnArea">  
                          <button class="btn btn-info btn-sm" onclick="docPrint();">인쇄</button>
                        </div>
                          
                        <!-- 기본 설정-->
                        <div class="default-setting" id="draft-inquiry-content">
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
                              <tr>
                                <th class="table-active">기안일시</th>
                                <td>
                                  ${edoc.regDate}
                                </td>
                                <th class="table-active">완료일시</th>
                                <td>
                                   ${edoc.modDate}
                                </td>
                              </tr>
                            </tbody>
                          </table> 

<!-- 
                      The Modal
                      <div class="modal" id="approvalModal">
                        <div class="modal-dialog modal-lg">
                          <div class="modal-content">

                            Modal Header
                            <div class="modal-header">
                              <h4 class="modal-title">결재</h4>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>

                            Modal body
                            <div class="modal-body">
                              <div class="approval-enable">
                                <div class="form-check form-check-radio">
                                  <input class="form-check-input" type="radio" name="radio=approval-radio" id="radio-approve1">
                                  <label class="form-check-label" for="radio-approve1">
                                    승인
                                  </label>
                                </div>
                                <div class="form-check form-check-radio">
                                  <input class="form-check-input" type="radio" name="radio=approval-radio" id="radio-approve2" checked>
                                  <label class="form-check-label" for="radio-approve2">
                                    반려
                                  </label>
                                </div>
                              </div>
                              <br>
                              <div class="approval-enable-comment">
                                <div class="approval-enable-comment-header">
                                  <b>승인 / 반려 의견</b><br>
                                  <textarea name="" id="" class="form-control" cols="30" rows="10" style="resize: none;" placeholder="의견 입력">
                                    
                                  </textarea>
                                </div>
                              </div>
                            </div>

                            Modal footer
                            <div class="modal-footer d-flex justify-content-center">
                              <button type="button" class="btn btn-primary">확인</button>
                            </div>

                          </div>
                        </div>
                      </div>
 -->
                      <!-- 별첨 -->
                      <!-- <div class="attachment" style="margin-bottom: 25px;">
                        <h6>별첨</h6>
                        <input class="form-control" type="file" id="formFileMultiple" multiple>
                      </div> -->

                      <!-- 제목 -->
                      <div class="document-title" style="margin-bottom: 25px;">
                        <div><span class="document-header">제목</span>${edoc.edTitle}</div>
                      </div>

                      <div class="document-content">
                        <span class="document-header">내용</span><br>
                        <div class="docContentArea">
						             	${edoc.edContent}      <!-- 에디터 영역 -->
						            </div>
                        <!-- 에디터 영역 -->
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
						                   		<span class="edHistCommentArea">의견 - ${edocHist.edHistComment}</span>
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
    /* $(document).ready(function() {
        $('.dropdown-item').click(function() {
            var selectedText = $(this).find('.spanCss').text();
            $('.resultArea').text(selectedText);
        });
    }); */
    
    // 인쇄
    function docPrint(){
          /* let initBody = document.body.innerHTML;
          window.onbeforeprint = function(){
              printSelectedOptionValue();
              document.body.innerHTML = document.getElementById("draft-inquiry-content").innerHTML;
          }
          window.onafterprint = function(){
              document.body.innerHTML = initBody;
          }
          window.print(); */
          
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