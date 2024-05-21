<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my booking list</title>

<style>
.LinkFlowMainSection {
	width: 100%;
	min-height: 1500px;
	display: flex;
}

.LinkFlowMainContent {
	width: 100%;
	min-width: 1260px;
	background-color: #f4f6f9;
	min-height: 400px;
	padding: 30px;
}

/* 게시판 */
.card-title, .card-tools {
	padding: 10px;
}

.card-body {
	text-align: center;
}

.bk-table {
	width: 95%;
	justify-content: space-between;
}

/* 모달 */
.md-header {
	padding-top: 20px;
	padding-left: 40px;
	display: flex;
	align-items: center;
}

.md-header p {
	padding: 10px;
	margin-top: 10px;
	font-size: larger;
}

.md-type {
	width: 70px;
	padding-left: 12px;
	height: 40px;
}

.md-list {
	color: rgb(203, 200, 200);
	padding-left: 25px;
	font-size: small;
	padding-top: 15px;
}

.md-select {
	text-align: center;
	height: 30px;
	width: 60px;
}

.md-div {
	display: flex;
	padding-left: 40px;
	padding-top: 13px;
}

.can-coment {
	border: none;
	border-bottom: 1px solid steelblue;
	width: 80%;
	height: 50px;
	margin-left: 20px;
}

.modal-body {
	margin-left: 13px;
	padding-bottom: 20px;
}

.modal-body h6 {
	padding-top: 12px;
}

.modal-content {
	width: 400px;
}

.bk-modal {
	padding-left: 30px;
	display: flex;
	/* align-items: center; */
}

.bk-content {
	padding: 15px;
	padding-bottom: 22px;
	/* width: 90%; */
	text-align: center;
}

.rej-coment {
	border: none;
	border: 1px solid steelblue;
	width: 90%;
	height: 50px;
	margin-left: 20px;
}

.bk-time {
	display: flex;
	flex-direction: column;
}

.bk-time p {
	margin-bottom: 20px;
	/* 아래쪽 간격 조절 */
}

.bk-time p:first-child {
	margin-bottom: 2px;
	/* 마지막 p 요소의 아래쪽 간격을 0으로 설정하여 두 요소 사이의 간격을 없앰 */
}

.ass-drop {
	padding-top: 15px;
	padding-bottom: 15px;
}

.ass-drop p {
	margin-top: 10px;
	width: 70px;
}

.ass-drop select {
	text-align: center;
}
/* 체크박스 
input[type="checkbox"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 15px;
	height: 15px;
	border-radius: 50%;
	border: 2px solid #ccc;
}

input[type="checkbox"]:checked {
	background-color: #007bff;
}*/
</style>

</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="LinkFlowMainSection">
			<jsp:include
				page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />

			<div class="LinkFlowMainContent">
					<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">&nbsp;</h1>
						</div>
					</div>
				</section>
				<!-- /.container-fluid -->
				<div class="bk-table">
					<div class="card">
						<div class="card-header">
		                    <div class="card-tools">
		                        <div class="input-group input-group-sm">
		                            <select id="dropdownOptions" class="form-control main-cate">
		                                <option value="">시설</option>
		                                <option value="">비품</option>
		                            </select> &nbsp;
		                            <select id="dropdownOptions" class="form-control middle-cate">
		                                <option value="">회의실</option>
		                            </select> &nbsp;
		                            <input type="text" name="table_search" class="form-control float-right"
		                                placeholder="Search">
		                            <div class="input-group-append">
		                                <button type="submit" class="btn btn-default">
		                                    <i class="fas fa-search"></i>
		                                </button>
		                            </div>
		                        </div>
		                    </div>
		             
						<!-- /.card-header -->
						<div class="card-body table-responsive p-0">
		                  <table class="table table-hover text-nowrap">
		                      <thead>
		                          <tr>
		                              <th style="width: 170px;">카테고리</th>
		                              <th style="width: 170px;">자원</th>
		                              <th>상품명</th>
		                              <th style="width: 250px;">상태</th>
		                          </tr>
		                      </thead>
		                      <tbody>
		                          <tr>
		                              <td>시설</td>
		                              <td>회의실</td>
		                              <td>A</td>
		                              <td>
		                                  <span data-toggle="modal" data-target="#acc-update">수정</span>
		                                  |
		                                  <span>삭제</span>
		                              </td>
		                          </tr>
		                          <tr>
		                              <td>시설</td>
		                              <td>회의실</td>
		                              <td>A</td>
		                              <td>
		                                  <span>수정</span>
		                                  |
		                                  <span onclick="assDel();">삭제</span>
		                              </td>
		                          </tr>
		                      </tbody>
		                  </table>
						</div>
					</div>
  			<!-- /.card-body -->
  				</div>

				<div class="text-right">
	            	<button class="btn bg-gradient-secondary" data-toggle="modal" data-target="#acc-update">자산 추가</button>
	            </div>
			</div>
             <!-- 자산 추가/수정 모달 -->
             <div class="modal fade" id="acc-update">
                 <div class="modal-dialog">
                     <div class="modal-content">
                         <div class="bk-modal" style="padding-top: 40px;">
                             <h4>자산 추가 </h4>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>카테고리</p>&nbsp;&nbsp;
                             <select id="" style="width: 80px;">
                                 <option value="">시설</option>
                                 <option value="">비품</option>
                             </select>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>자원 종류</p>&nbsp;&nbsp;
                             <select id="" style="width: 100px;">
                                 <option value="">회의실</option>
                                 <!-- 비품일때 -->
                                 <option value="">노트북</option>
                                 <option value="">마우스</option>
                                 <option value="">차량</option>
                             </select>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>상품명 </p>&nbsp;&nbsp;
                             <input type="text">
                         </div>
 
                         <div class="modal-footer justify-content-between">
                             <button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
                             <button type="button" class="btn btn-outline-primary">SUBMIT</button>
                         </div>
                     </div>
                     <!-- /.modal-content -->
                 </div>
                 <!-- /.modal-dialog -->
             </div>
             <!-- /.modal -->

		<div class="pagination" id="pageArea"
			style="display: flex; justify-content: center;">
			<ul class="pagination">
				<li class="page-item" ${pi.currentPage ==1 ? 'disabled' : '' }>
					<a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage -1}">&laquo;</a>
				</li>
				<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
					<li class="page-item" ${ pi.currentPage == p ? 'disabled' : '' }>
						<a class="page-link" href="${contextPath }/booking/mylist.bk?page=${p}">${p }</a>
					</li>
				</c:forEach>
				<li class="page-item" ${pi.currentPage == pi.maxPage ? 'disabled' : '' }>
					<a class="page-link" href="${contetxtPath }/booking/mylist.bk?page=${pi.currentPage +1}">&raquo;</a>
				</li>
			</ul>
		</div>
		</div>
	</div>
	   </div>
	<!-- /.card -->

	<!-- /.content-wrapper -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
			
		$(document).ready(function () {
	        $('.dropdown-item').click(function () {
	            var selectedText = $(this).find('.spanCss').text();
	            $('.resultArea').text(selectedText);
	        });
	    });
	
	    function assDel(seq) {
	        Swal.fire({
	            //   title: '글을 삭제하시겠습니까???',
	            text: "자원 삭제 시, 자원에 대한 모든 예약 기록이 삭제되어 복구할 수 없습니다.",
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#d33',
	            cancelButtonColor: '#C0C0C0',
	            cancelButtonText: '취소',
	            confirmButtonText: '삭제'
	        }).then((result) => {
	            if (result.value) {
	                //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	            }
	        })
	    }

	</script>
	

</body>
</html>