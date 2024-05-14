<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진행중인 문서 수정</title>

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
	.contentInElement{justify-content: space-between; margin-bottom: 30px;}
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
    
    /* 항상 사용할 CSS 추가 */
    tbody{
      background-color: white !important;
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

    .searchUser{
        display: flex;
        flex-direction: row;
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

    .modal-body{
      padding: 0px 0px 0px 0px;
    }
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
              <h1 class="m-0">진행중인문서 수정</h1>
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
                                        <option value="">품의서</option>
                                        <option value="">재직증명서</option>
                                        <option value="dayoffForm">휴가신청서</option>
                                        <option value="">지출결의서</option>
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
                                <!-- <button class="btn btn-dark btn-sm" data-toggle="modal" data-target="#modal-xl">결재선 설정</button> -->
                              </div>
                              <table class="table table-bordered" style="margin-top: 10px;">
                                <tr>
                                  <th rowspan="2" class="table-active" style="text-align: center; vertical-align: middle;" width="100">결재</th>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">김과장</th>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">이대표</th>
                                </tr>
                                <tr>
                                  <td height="200" width="300"></td>
                                  <td height="200" width="300"></td>
                                </tr>
                                <tr>
                                  <th class="table-active" style="text-align: center; vertical-align: middle;">참조</th>
                                  <td colspan="2"><input type="text" name="refMember" id="refMember" class="form-control" style="width: 300px;"></td>
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
                            <input type="text" name="" id="" class="form-control" style="width: 1000px;" value="내가 작성했던 제목">
                          </div>

                          <!-- 휴가신청서 폼이 뿌려질 곳-->
                          <div class="dayoff-table">

                          </div>

                          <div class="drafting-content">
                            <h6>본문</h6>
                            <script src="../../../ckeditor5/build/ckeditor.js"></script>
                            <div id="editor">이 페이지에서는 내가 작성했던 양식이 그대로 보여져야함</div>
                          </div>
                        </div>
                        
                      </div>
                        <!-- /.card-body -->
               </div>
             </div>
           </div>
           
          </section>
          <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->
	</div>
	
	<script>
	 // CKEditor
    let editor;
    
    ClassicEditor
      .create(document.querySelector('#editor'))
      .then(newEditor => {
          editor = newEditor;
      })
      .catch(error => {
          console.error(error);
      });
    
			$(function(){
			  $('.dropdown-item').click(function() {
			      var selectedText = $(this).find('.spanCss').text();
			      $('.resultArea').text(selectedText);
			  });
			
			
			  // 휴가신청서 폼 뿌려지게
			  $('.documentType').change(function(){
			    if($(this).val() == 'dayoffForm'){
			      $('.dayoff-table').append(`<h6>신청</h6>
			                      <table class="table table-bordered dayoff-table">
			                        <tbody>
			                          <tr>
			                            <th class="table-active dayoff-table-title">휴가종류</th>
			                            <td>
			                              <select class="form-control dayoff-table-type">
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
			  });
			
			});

	</script>
</body>
</html>