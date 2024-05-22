<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 등록</title>

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
 	
 	/* 항상 사용할 CSS 추가 */
    tbody{
      background-color: white;
    }
    
    /* 이 페이지내에서만 쓸 CSS 추가 */
    .setting-table > th {
      width: 5px;
    }

    .content-element{
      padding: 15px 0px 15px 0px;
    }

    .content-area > div:not(.drafting-content) > div  {
      margin-top: 30px;
    }
    
    .ck-editor__editable{
      min-height: 600px;
    }

    /* 버튼 간격 조절 */
    button {
      margin-right: 6px !important;
    }

    /* 버튼 밑 간격 조절 */
    .btnArea{
      margin-bottom: 40px;
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
                <h1 class="m-0">양식 등록</h1>
              </div>
            </div>
          </section>
               
          <!-- Main content -->
          <section class="content">
           <div class="container-fluid" style="display: flex; justify-content: center;"> 
             <div class="contentArea">

               <div class="contentInElement">
               	<form method="post" action="${contextPath}/edsm/crtemp/registTemplate.crtp">
               
                 <div class="btnArea">
                          <button type="submit" id="crtTmplBtn" class="btn btn-primary btn-sm">양식 생성</button>    
                        </div>

                        <!-- 기본 설정-->
                        <div class="default-setting">
                            <h6>기본 설정</h6>
                            <table class="table table-bordered setting-table">
                              <tbody>
                                <tr>
                                  <th class="table-active">양식명</th>
                                  <td colspan="4">
                                    <input type="text" name="edFrName" class="form-control" placeholder="양식명을 입력해주세요" style="width: 300px;" required>
                                  </td>
                                </tr>
                                <tr>
                                  <th class="table-active">보존 
                                  연한</th>
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
													</form>
                        <!-- 결재선 -->
                        <div class="approval-line">

                        <div class="drafting-content">
                          <h6>본문</h6>
                          <input type="hidden" id="editorContent" name="edFrContent">
                          <div id="editor" name="frContent"></div>
                        </div>
                      </div>
                      </div>
                    </div>
                      <!-- /.card-body -->
               </div>
             </div>
           </div>
          <!-- /.content -->
      <!-- /.content-wrapper -->
	
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
    
    // 컨트롤러로 넘기기 전에 히든 요소에 값 담아서 넘기기
    $(function() {
    	
	    $('#crtTmplBtn').click(function(){
	    	// 기본 설정 필드 확인
	        let edFrName = $('input[name="edFrName"]').val(); // 양식명 필드
	        let edFrContent = editor.getData(); // 에디터 내용 필드
	
	        // 필수 입력 필드가 비어 있는지 확인
	         if (edFrName == '') {
		        alert('양식명을 입력해주세요.');
		        event.preventDefault();
			    } else if (edFrContent.length == 0) {
			        alert('에디터 내용을 입력해주세요.');
			        event.preventDefault();
			    } else {
			        $('#editorContent').val(edFrContent); // 에디터 내용을 hidden input에 설정
			        $('#templateForm').submit(); // form 제출
			      }
	    });
    	
    });
    
	</script>
</body>
</html>