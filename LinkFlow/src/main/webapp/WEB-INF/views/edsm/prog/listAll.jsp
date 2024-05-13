<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진행중인 문서 목록 : 전체</title>
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
                      <h1 class="m-0" id="header-title">전체 </h1>
                  </div>
                </div>
                <div class="search d-flex justify-content-end">
                  <select name="" id="bottom-menu" class="form-control bottom-menu" style="width: 150px;">
                    <option value="all">전체</option>
                    <option value="wait">대기</option>
                    <option value="complete">완료</option>
                    <option value="progress">진행</option>
                    <option value="confirm">확인</option>
                  </select>
                  <div class="input-group col-4" style="height: 100%;">
                    <input type="search" class="form-control" placeholder="문서 제목을 입력해주세요">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                  </div>
                </div>
          <!-- /.container-fluid -->
          
          </section>
               
                <!-- Main content -->
                <section class="content">
	                <div class="container-fluid" style="display: flex; justify-content: center;"> 
	                  <div class="contentArea">
	
	                    <div class="contentInElement">
	                        <div style="min-height: 500px; min-width: 100%;">
	                        <table class="table table-bordered table-hover document-list">
	                          <thead class="table table-active">
	                            <tr>
	                              <th>문서번호</th>
	                              <th>제목</th>
	                              <th>기안자</th>
	                              <th>기안일</th>
	                              <th>구분</th>
	                              <th>상태</th>
	                            </tr>
	                          </thead>
	                          <tbody>
	                            <tr>
	                              <td>LI-품의-20240429-0003</td>
	                              <td>품의서 제출</td>
	                              <td>김과장</td>
	                              <td>2024-04-29</td>
	                              <td>품의서</td>
	                              <td>결재중</td>
	                            </tr>
	                            <tr>
	                                <td>LI-지출-20240429-0002</td>
	                                <td>지출결의서 제출</td>
	                                <td>안차장</td>
	                                <td>2024-04-29</td>
	                                <td>지출결의서</td>
	                                <td>결재완료</td>
	                            </tr>
	                            <tr>
	                                <td>LI-품의-20240429-0001</td>
	                                <td>품의서 제출</td>
	                                <td>김과장</td>
	                                <td>2024-04-29</td>
	                                <td>품의서</td>
	                                <td>대기</td>
	                            </tr>
	                          </tbody>
	                        </table>
	    
	                        <ul class="pagination justify-content-center">
	                          <li class="page-item"><a class="page-link" href="#">Previous</a></li>
	                          <li class="page-item"><a class="page-link" href="#">1</a></li>
	                          <li class="page-item active"><a class="page-link" href="#">2</a></li>
	                          <li class="page-item"><a class="page-link" href="#">3</a></li>
	                          <li class="page-item"><a class="page-link" href="#">Next</a></li>
	                        </ul>
	                        
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
		$(document).ready(function() {
		
		  let headOriginalValue = $('#header-title').text();
		  let trCount = $('table tr').length - 1;
		  
		    $('.dropdown-item').click(function() {
		        var selectedText = $(this).find('.spanCss').text();
		        $('.resultArea').text(selectedText);
		    });
		
		    // 추가
		    // 테이블 내에 있는 행 개수 count
		      $('#header-title').text(headOriginalValue + ' (' + trCount + ')');
		});
	</script>

</body>
</html>