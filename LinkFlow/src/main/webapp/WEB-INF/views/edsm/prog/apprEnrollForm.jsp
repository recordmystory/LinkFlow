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
<script src="${contextPath}/resources/ckeditor5/build/ckeditor.js"></script>

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
	
	                    <div class="contentInElement">
	                        <div class="btnArea">
                            <button class="btn btn-primary btn-sm">기안하기</button>
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
                                      <select class="form-control documentType">
                                        <option value="letterOfApproval">품의서</option>
                                        <option value="certificateOfEmployment">재직증명서</option>
                                        <option value="dayoffForm">휴가신청서</option>
                                        <option value="expenseResolustion">지출결의서</option>
                                      </select>
                                    </td>
                                    <th class="table-active">작성자</th>
                                    <td>Linkflow 과장 김디디</td>
                                  </tr>
                                  <tr>
                                    <th class="table-active">보존 연한</th>
                                    <td>
                                      <select class="form-control">
                                        <option value="">1년</option>
                                        <option value="">3년</option>
                                        <option value="">5년</option>
                                        <option value="">10년</option>
                                        <option value="">영구</option>
                                      </select>
                                    </td>
                                    <th class="table-active">보안 등급</th>
                                    <td>
                                      <select class="form-control">
                                        <option value="">S등급</option>
                                        <option value="">A등급</option>
                                        <option value="">B등급</option>
                                        <option value="">C등급</option>
                                    </select>
                                    </td>
                                  </tr>
                                </tbody>
                              </table> 

                          <!-- 결재선 -->
                          <div class="approval-line">
                              <div class="approval-line-title">
                                <h6 style="margin-right: 10px;">결재선</h6>
                                <button class="btn btn-dark btn-sm" data-toggle="modal" data-target="#modal-xl">결재선 설정</button>
                              </div>
                              <table class="table table-bordered" style="margin-top: 10px;">
                                <tr>
                                  <th rowspan="2" class="table-active" style="text-align: center; vertical-align: middle;" width="100">결재</th>
                                  <!-- <th class="table-active" style="text-align: center; vertical-align: middle;"></th> -->
                                  <th class="table-active" style="text-align: center; vertical-align: middle;" id="approvalSelectedArea1"></th>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;" id="approvalSelectedArea2"></th>
                                </tr>
                                <tr>
                                  <!-- <td height="200" width="300"></td> -->
                                  <td height="200" width="300"></td>
                                  <td height="200" width="300"></td>
                                </tr>
                                <tr>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">참조</th>
                                  <td colspan="2" id="refSelectedArea"><!-- <input type="text" name="refMember" id="refMember" class="form-control" style="width: 300px;"> --></td>
                                </tr>
                              </table>

                          <!-- 별첨 -->
                          <div class="attachment" style="margin-bottom: 25px;">
                            <h6>별첨</h6>
                            <input class="form-control" type="file" id="formFileMultiple" multiple>
                          </div>

                          <!-- 제목 -->
                          <div class="drafting-title" style="margin-bottom: 25px;">
                            <h6>제목</h6>
                            <input type="text" name="" id="" class="form-control" style="width: 1000px;">
                          </div>

                          <!-- 휴가신청서 폼이 뿌려질 곳-->
                          <div class="dayoff-table">

                          </div>

                          <div class="drafting-content">
                            <h6>본문</h6>
                            <script src="../../../ckeditor5/build/ckeditor.js"></script>
                            <div id="editor">제목</div>
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
                         <div class="input-group">
                             <input type="search" class="form-control" placeholder="사원명을 입력하세요" value="" name="useName">
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
                                       <li data-jstree='{ "type" : "group" }'>
                                           경영지원부서
                                           <ul>
                                               <li data-jstree='{ "selected" : false }'>
                                                   경영지원팀
                                                   <ul>
                                                       <li data-jstree='{ "type" : "person" }'>
                                                           김경영 대리
                                                       </li>
                                                       <li data-jstree='{ "type" : "person" }'>
                                                           김가렌 사원
                                                       </li>
                                                       <li data-jstree='{ "type" : "person" }'>
                                                           김지우 사원
                                                       </li>
                                                   </ul>
                                               </li>
                                               <li data-jstree='{ "selected" : false }'>
                                                   개발부서
                                                   <ul>
                                                       <li data-jstree='{ "type" : "person" }'>
                                                           김개발 대리
                                                       </li>
                                                       
                                                   </ul>
                                               </li>
                                           </ul>
                                       </li>
                                   </ul>
                               </li>
                               
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
                         
                       </div>
                     </div>

                     <div class="card card-info" style="width: 400px;  height: 200px; margin-top: 100px;">
                       <div class="card-header">
                         <h5 class="card-title">참조</h5>
                         
                        
                       </div>
                       <div class="card-body referenceArea overflow-auto">

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
        $(function(){
              $('.documentType').change(function(){
              // 휴가신청서 폼 뿌려지게
                if($(this).val() == 'dayoffForm'){
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
                $('.dayoff-table').html('');
              }

              // 에디터 내에 문서 양식 뿌리기
              if($(this).val() == 'letterOfApproval'){

                editor.setData(`<h1>품의서</h1>
                                    <p>&nbsp;</p>
                                    <figure class="table" style="width:100%;">
                                        <table class="ck-table-resized" style="border-style:ridge;">
                                            <colgroup>
                                                <col style="width:10.15%;">
                                                <col style="width:43.98%;">
                                                <col style="width:10.03%;">
                                                <col style="width:35.84%;">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">소속</p></td>
                                                    <td>&nbsp;</td>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">직급</p></td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">성명</p></td>
                                                    <td>&nbsp;</td>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">작성일</p></td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">제목</p></td>
                                                    <td colspan="3">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">품의 사유 및 상세 내역</p></td>
                                                    <td colspan="3">
                                                        <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">예상 비용</p></td>
                                                    <td colspan="3">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">비고</p></td>
                                                    <td colspan="3">
                                                        <p>&nbsp;</p><p>&nbsp;</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <p>&nbsp;</p>
                                                        <p>위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다.</p>
                                                        <p>&nbsp;</p><p>&nbsp;</p><p style="text-align:right;">년 월 일</p>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </figure>
                                    <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>`);

              } else if($(this).val() == 'certificateOfEmployment'){

                editor.setData(`<h1>재직증명서</h1>
                          <p style="text-align:center;">&nbsp;</p>
                          <figure class="table" style="width:100%;">
                              <table class="ck-table-resized" style="background-color:hsl(0, 0%, 100%);">
                                  <colgroup>
                                      <col style="width:8.21%;">
                                      <col style="width:35.42%;">
                                      <col style="width:9.9%;">
                                      <col style="width:46.47%;">
                                  </colgroup>
                                  <tbody>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">성명</p></td>
                                          <td>&nbsp;</td>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">주민등록번호</p></td>
                                          <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">주소</p></td>
                                          <td colspan="3">&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">회사명</p></td>
                                          <td>&nbsp;</td>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">사업자번호</p></td>
                                          <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">소속</p></td>
                                          <td>&nbsp;</td>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">직위</p></td>
                                          <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">소재지</p></td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">재직기간</p></td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                          <td colspan="4">
                                              <p style="text-align:center;">&nbsp;</p>
                                              <p style="text-align:center;">상기와 같이 재직하고 있음을 증명함</p>
                                              <p style="text-align:center;">&nbsp;</p>
                                              <p style="text-align:center;">&nbsp;</p>
                                              <p style="text-align:center;">년 월 일</p>
                                              <p>&nbsp;</p>
                                              <p style="text-align:center;">주식회사 Linkflow</p>
                                              <p style="text-align:center;">&nbsp;</p>
                                          </td>
                                      </tr>
                                  </tbody>
                              </table>
                          </figure>
                          <p style="text-align:right;">&nbsp;</p>
                          <p>&nbsp;</p>`);

              } else if($(this).val() == 'expenseResolustion'){

                editor.setData(`<h1 style="text-align:center;">지출결의서</h1>
                                <figure class="table" style="width:100%;">
                                    <table class="ck-table-resized" style="background-color:hsl(0, 0%, 90%);">
                                        <colgroup>
                                          <col style="width:6.77%;">
                                          <col style="width:41.36%;">
                                          <col style="width:6.23%;">
                                          <col style="width:45.64%;">
                                          </colgroup>
                                          <tbody>
                                            <tr>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">지출 제목</p></td>
                                              <td>&nbsp;</td><td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">작성 일자</p></td>
                                              <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">결제 일자</p></td>
                                              <td>&nbsp;</td>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">부서 / 담당</p></td>
                                              <td>&nbsp;</td></tr><tr><td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">지출 금액</p></td>
                                              <td colspan="3">&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="background-color:hsl(0, 0%, 90%);" rowspan="14"><p style="text-align:center;">지출 내역</p></td>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">항목</p></td>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">금액(원)</p></td>
                                              <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">비고</p></td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td>&nbsp;</td>
                                            </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                        <tr>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                       <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">합계</p></td>
                                        <td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">입금 정보</p></td>
                                        <td colspan="3">&nbsp;</td></tr><tr><td colspan="4"><p><br>위 금액을 청구하오니 결제해 주시기 바랍니다</p><p>&nbsp;</p><p style="text-align:center;">년 월 일</p><p style="text-align:center;">주식회사 Linkflow</p></td>
                                      </tr>
                                  </tbody>
                                </table>
                              </figure>`);

              } else if($(this).val() == 'dayoffForm'){

                editor.setData(`<h1 style="text-align:center;">휴가신청서</h1>
                                <p style="text-align:center;">&nbsp;</p>
                                <figure class="table" style="width:100%;">
                                  <table class="ck-table-resized dayoffForm" style="background-color:hsl(0, 0%, 100%);">
                                    <colgroup>
                                      <col style="width:8.21%;">
                                      <col style="width:91.79%;">
                                    </colgroup>
                                    <tbody>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">소속</p></td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">성명</p></td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">직위</p></td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">휴가 종류</p></td>
                                        <td id="dayoffType">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">휴가 사유</p></td>
                                        <td>&nbsp;</td></tr><tr><td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">휴가 기간</p></td>
                                        <td>&nbsp;</td></tr><tr><td style="background-color:hsl(0, 0%, 90%);"><p style="text-align:center;">비상연락처</p></td>
                                        <td>&nbsp;</td></tr><tr><td colspan="2"><p style="text-align:center;">&nbsp;</p><p style="text-align:center;">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</p><p style="text-align:center;">&nbsp;</p><p style="text-align:center;">&nbsp;</p><p style="text-align:center;">년 월 일</p></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                              <p style="text-align:right;">&nbsp;</p><p>&nbsp;</p>`);
              }

            });
            
            // 결재선 설정 모달에서 저장 버튼을 누를 때 기안서 작성 페이지에 선택된 사람의 이름이 뿌려지는 function
            $('#saveData').click(function(){

              $('#approvalSelectedArea1').text($('.approvalName1').text());
              $('#approvalSelectedArea2').text($('.approvalName2').text());

              let $refUser = '';
              let refNameCount = $('.referenceName').length;

              if(refNameCount >= 2){
                $('.referenceName').each(function(index){
                  if(index > 0) {
                    $refUser += ' / ';
                  }

                  $refUser += $(this).text();

                });
              } else if (refNameCount == 1){
                $refUser = $('.referenceName').text();
              } else {
                $refUser = '';
              }

              $('#refSelectedArea').text($refUser);
                  
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
        "plugins": ["types"]
    }).on('select_node.jstree', function (e, data) {
        var node = data.node;
        
        if (node.type === "person") {
            var personName = node.text;
            
            var isExistingName = $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').length > 0;
            
            if (!isExistingName) {
                var html = '<div class="NameArea">' + personName +'<input type="checkBox"></div>';
                
                $('.resultNameArea').append(html);
            } else {
                // 이미 존재하는 이름이면 해당 이름을 삭제합니다.
                $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').remove();
            }
        }
    });


          document.querySelector('.approvalIn').addEventListener('click', function() {
                var nameAreas = document.querySelectorAll('.NameArea');
                var existingApprovalCount = document.querySelectorAll('.approvalArea .approvalName').length;
                var maxApprovalCount = 2;

            
                if (existingApprovalCount >= maxApprovalCount) return;

                var currentIndex = existingApprovalCount + 1;

                nameAreas.forEach(function(nameArea) {
                    var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
                    if (checkbox && existingApprovalCount < maxApprovalCount) {
                        var nameValue = nameArea.textContent.trim();

                    
                        var existingElement = document.querySelector('.approvalArea .approvalName' + currentIndex);
                        if (existingElement) return;

                        var className = 'approvalName' + currentIndex;

                        var newElement = document.createElement('div');
                        newElement.className = className;
                        newElement.textContent = `${nameValue}`;

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
                  var nameText = approvalName.textContent.trim();

                  var resultName = document.createElement('div');
                  resultName.className = 'NameArea';
                  resultName.textContent = nameText;

                  var newCheckbox = document.createElement('input');
                  newCheckbox.type = 'checkbox';
                  resultName.appendChild(newCheckbox);

                  document.querySelector('.resultNameArea').appendChild(resultName);

                  approvalName.remove();
              });
          }

          

        document.querySelector('.referenceIn').addEventListener('click', function() {
        var nameAreas = document.querySelectorAll('.NameArea');
        
        nameAreas.forEach(function(nameArea) {
            var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
            if (checkbox) {
                var nameValue = nameArea.textContent.trim();
                
               
                var existingElement = document.querySelector('.referenceArea .referenceName');
                if (existingElement && existingElement.textContent.trim() === nameValue) {
                    return; 
                }

                var referenceName = document.createElement('div');
                referenceName.className = 'referenceName';
                referenceName.textContent = nameValue;
                document.querySelector('.referenceArea').appendChild(referenceName);
                
                nameArea.remove();
                }
            });
        });

        document.querySelector('.referenceOut').addEventListener('click', function() {
              
              var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

              
              approvalNames.forEach(function(referenceName) {
                  
                  var nameValue = referenceName.textContent.trim();
                  
                  var resultNameArea = document.querySelector('.resultNameArea');
                 
                  var nameArea = document.createElement('div');
                  nameArea.className = 'NameArea';
                  nameArea.textContent = nameValue;
                  
                  var checkbox = document.createElement('input');
                  checkbox.type = 'checkbox';
                  nameArea.appendChild(checkbox);
                  
                  resultNameArea.appendChild(nameArea);
                  
                  referenceName.remove();
              });
          });

          document.querySelector('.approvalUpBtn').addEventListener('click', function() {
              var approvalName1 = document.querySelector('.approvalArea .approvalName1');
              var approvalName2 = document.querySelector('.approvalArea .approvalName2');

              if (approvalName1 && approvalName2) {
                  var tempText = approvalName1.textContent;
                  approvalName1.textContent = approvalName2.textContent;
                  approvalName2.textContent = tempText;
              }
          });
          document.querySelector('.approvalDownBtn').addEventListener('click', function() {
              var approvalName1 = document.querySelector('.approvalArea .approvalName1');
              var approvalName2 = document.querySelector('.approvalArea .approvalName2');

              if (approvalName1 && approvalName2) {
                  var tempText = approvalName1.textContent;
                  approvalName1.textContent = approvalName2.textContent;
                  approvalName2.textContent = tempText;
              }
          });
          document.getElementById('saveData').addEventListener('click', function() {
            var approvalName1Element = document.querySelector('.approvalName1');
            var approvalName2Element = document.querySelector('.approvalName2');

        
            var approvalName1Text = approvalName1Element ? approvalName1Element.textContent : '';
            var frtApprovalElement = document.querySelector('.frtApproval');
            frtApprovalElement.textContent = approvalName1Text;

            
            var approvalName2Text = approvalName2Element ? approvalName2Element.textContent : '';
            var scdApprovalElement = document.querySelector('.scdApproval');
            scdApprovalElement.textContent = approvalName2Text;

            var referenceNameElements = document.querySelectorAll('.referenceName');
            var textToInsert = '';

            referenceNameElements.forEach(function(referenceNameElement, index) {
                var text = referenceNameElement.textContent.trim();
                if (index > 0) {
                    textToInsert += ', ';
                }
                textToInsert += text;
            });

            document.getElementById('refMember').value = textToInsert;
        });
    </script>
</body>
</html>