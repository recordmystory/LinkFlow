<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 시설/비품</title>

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
.wrapper{
 min-height: 100%;
 width: 100%;
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
	padding-left:45px;
}

.ass-drop p {
	margin-top: 10px;
	width: 70px;
}

.ass-drop select {
	text-align: center;
}
#modalTitle{
	padding-bottom:5px;
}

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
		                            <select id="mainName" class="form-control main-cate" name="mainCode" onchange="changeSub();">
		                                <option value="002-">시설</option>
		                                <option value="003-">비품</option>
		                            </select> &nbsp;
		                            
		                            <select id="room-sub" class="form-control middle-cate room-sub" name="subName">
		                                <option value="회의실">회의실</option>
		                            </select> 
		                            
		                            <select id="sup-sub" class="form-control middle-cate" name="subName" style="display: none;">
		                                <option value="노트북">노트북</option>
		                                <option value="차량">차량</option>
		                                <option value="키보드">키보드</option>
		                                <option value="마우스">마우스</option>
		                            </select> &nbsp;
		                            
		                            <input type="text" id="keyword" class="form-control float-right" name="keyword" placeholder="Search">
		                            <div class="input-group-append">
		                                <button type="submit" class="btn btn-default" onclick="searchAssets(1);">
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
		                              <th style="width: 200px;">카테고리</th>
		                              <th style="width: 200px;">자원</th>
		                              <th>상품명</th>
		                              <th style="width: 250px;">상태</th>
		                          </tr>
		                      </thead>
		                      <tbody id="listTable">
		                      <c:choose>
			                      <c:when test="${empty assList }">
			                      	<tr><th>조회된 내역이 없습니다. </th></tr>
			                      </c:when>
			                      <c:otherwise>
				                      <c:forEach var="ass" items="${ assList }">
				                          <tr>
				                              <td>${ ass.mainName }</td>
				                              <td>${ ass.subName }</td>
				                              <td>${ ass.assetsName }</td>
				                              <td>
				                                  <a data-toggle="modal" data-target="#ass-update" id="assModify" 
				                                  		onclick="modalType('${ass.assetsNo }','${ ass.mainName }','${ ass.subName }','${ ass.assetsName }');">수정</a>
				                                  |
				                                  <a data-assNo="${ass.assetsNo}" onclick="assDel('${ass.assetsNo}');">삭제</a>
				                              </td>
				                          </tr>
			                          </c:forEach>
		                          </c:otherwise>
	                          </c:choose>
		                      </tbody>
		                  </table>
						</div>
					</div>
  				<!-- /.card-body -->
  				</div>

				<div class="text-right">
	            	<button class="btn bg-gradient-secondary" data-toggle="modal" data-target="#ass-update" id="assInsert" onclick="modalType();">자산 추가</button>
	            </div>
			</div>
             <!-- 자산 추가/수정 모달 -->
             <div class="modal fade" id="ass-update">
                 <div class="modal-dialog">
                     <div class="modal-content">
                     <form id="updateAss" action="" method="post">
                         <div class="bk-modal" style="padding-top: 40px;">
                             <h4 id="modalTitle"></h4>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>카테고리</p>&nbsp;&nbsp;
                             <select id="assMain" style="width: 80px;" name="updateMainCode" onchange="changeMod();" class="form-control">
                                 <option id="ass-inRoom" value="002-">시설</option>
                                 <option id="ass-inSup" value="003-">비품</option>
                             </select>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>자원 종류</p>&nbsp;&nbsp;
                             <select id="roomSub" name="roomSubName" style="width: 100px;" class="form-control">
                                 <option id="회의실" value="회의실">회의실</option>
                                 <!-- 비품일때 -->
                             </select>
                             <select id="supSub" name="subName" style="width: 100px; display:none;" class="form-control">
                                 <option id="노트북" value="노트북">노트북</option>
                                 <option id="차량" value="차량">차량</option>
                                 <option id="키보드" value="키보드">키보드</option>
                                 <option id="마우스" value="마우스">마우스</option>
                             </select>
                         </div>
                         <div class="bk-modal ass-drop">
                             <p>상품명 </p>&nbsp;&nbsp;
                             <input id="assName" type="text" name="assetsName" class="form-control" style="width: 190px;">
                         </div>
 
                         <div class="modal-footer justify-content-between">
                             <button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
                             <button type="submit" class="btn btn-outline-primary" id="submitButton">SUBMIT</button>
                         </div>
                         </form>
                     </div>
                     <!-- /.modal-content -->
                 </div>
                 <!-- /.modal-dialog -->
             </div>
             <!-- /.modal -->

		<div class="pagination" id="pageArea" style="display: flex; justify-content: center;">
			<ul class="pagination">
				<li class="page-item ${pi.currentPage ==1 ? 'disabled' : '' }">
					<a class="page-link" href="${contextPath }/booking/ass.list?page=${pi.currentPage -1}">&laquo;</a>
				</li>
				<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
					<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }">
						<a class="page-link" href="${contextPath }/booking/ass.list?page=${p}">${p }</a>
					</li>
				</c:forEach>
				<li class="page-item ${pi.currentPage == pi.maxPage ? 'disabled' : '' }">
					<a class="page-link" href="${contextPath }/booking/ass.list?page=${pi.currentPage +1}">&raquo;</a>
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
		    // URL에서 success 파라미터를 확인하고 알림 표시
		    const urlParams = new URLSearchParams(window.location.search);
		    const ain = urlParams.get('ain');
		    const amod = urlParams.get('amod');
		    if (ain === 'true') {
		        Swal.fire('성공', '추가되었습니다.', 'success');
		    } 
		    if (amod && amod === 'true'){ 
		        Swal.fire('성공', '수정되었습니다.', 'success');
		    } 
		});
		
		function searchAssets(num) { // 검색
		    let mainName = document.getElementById('mainName').value;
		    let subName = '';

		    if (mainName === '002-') {
		        let roomSub = document.getElementById('room-sub');
		        if (roomSub) {
		            subName = roomSub.value;
		        }
		    } else if (mainName === '003-') {
		        let supSub = document.getElementById('sup-sub');
		        if (supSub) {
		            subName = supSub.value;
		        }
		    }

		    let keyword = document.getElementById('keyword').value;

		    $.ajax({
		        url: '${contextPath}/booking/ass.search',
		        type: 'get',
		        data: {
		            mainName: mainName,
		            subName: subName,
		            keyword: keyword,
		            page:num
		        },
		        success: function (searchResult) {
		            let table = "";
		            let list = searchResult.assList;
		            let page = "";
				  	let pi = searchResult.pi;

		            for (let i = 0; i < list.length; i++) {
		                table += "<tr>"
		                       + "<td>" + list[i].mainName + "</td>"
		                       + "<td>" + list[i].subName + "</td>"
		                       + "<td>" + list[i].assetsName + "</td>"
		                       + "<td>"
		                       + "<a data-toggle=\"modal\" data-target=\"#ass-update\" id=\"assModify\" onclick=\"modalType('"
		                       + list[i].assetsNo +"','"+ list[i].mainName+"','"+ list[i].subName+"','"+ list[i].assetsName+ "')\">수정</a>"
		                       + " | "
		                       +  "<a data-assNo=\"" + list[i].assetsNo + "\" onclick='assDel(\"" + list[i].assetsNo + "\");'>삭제</a>"
		                       + "</td></tr>";
		                       console.log(list[i].assetsNo);
		            }
		            
		            
		            page += "<li class=\"page-item " + (pi.currentPage == 1 ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchAssets(" + (pi.currentPage - 1) + ");\">&laquo;</a></li>";

					for (let i = pi.startPage; i <= pi.endPage; i++) {
					    page += "<li class=\"page-item " + (pi.currentPage == i ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchAssets(" + i + ");\"> "+ i + "</a></li>";
					}

					page += "<li class=\"page-item " + (pi.currentPage == pi.maxPage ? 'disabled' : '') + "\"><a class=\"page-link\" onclick=\"searchAssets(" + (pi.currentPage + 1) + ");\">&raquo;</a></li>";
				
		            $("#listTable").html(table);
		            $("#pageArea ul").html(page);
		        }
		    });
		}
	
		function modalType(no, main, sub, ass) {
		    
		    if (no != null) {
		        document.getElementById('modalTitle').innerText = "자산 수정";
		        var room = document.getElementById('roomSub');
		        var supplies = document.getElementById('supSub');

		        if (main === "비품") {
		            document.getElementById('ass-inRoom').selected = false;
		            document.getElementById('ass-inSup').selected = true;
		            room.style.display = 'none';
		            supplies.style.display = 'block';
		        } else if (main === "시설") {
		            document.getElementById('ass-inSup').selected = false;
		            document.getElementById('ass-inRoom').selected = true;

		            room.style.display = 'block';
		            supplies.style.display = 'none';

		        }
		        document.getElementById(sub).selected = true;
		        document.getElementById('assName').value = ass;
		        // hidden input 추가
		        var hiddenInput = document.createElement("input");
		        hiddenInput.setAttribute("type", "hidden");
		        hiddenInput.setAttribute("name", "assetsNo");
		        hiddenInput.setAttribute("value", no);
		        document.getElementById("updateAss").appendChild(hiddenInput);
		        document.getElementById('updateAss').action = "${contextPath}/booking/ass.mod";

		    } else {
		        // assName 비우기
		        document.getElementById('assName').value = '';
		        // modalTitle 초기화
		        document.getElementById('modalTitle').innerText = "자산 추가";
		        document.getElementById("updateAss").action = " ";

		        document.getElementById('ass-inRoom').selected = false;
		        document.getElementById('ass-inSup').selected = false;

		        document.getElementById('roomSub').style.display = 'block';
		        document.getElementById('supSub').style.display = 'none';
		        // hidden input 제거
		        var hiddenInput = document.getElementById("updateAss").querySelector("input[name='assetsNo']");
		        if (hiddenInput) {
		            hiddenInput.parentNode.removeChild(hiddenInput);
		        }
		        document.getElementById('updateAss').action = "${contextPath}/booking/ass.in";

		    }
		}
		
	    function assDel(assNo) { // 삭제 
	    	let assetsNo= assNo;
	    
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
	                $.ajax({
	                    url: '${contextPath}/booking/ass.del',
	                    type: 'get',
	                    data: {
	                        assetsNo: assNo
	                    },
	                    success: function(result) {
	                       
                        	if (result > 0) {
                                Swal.fire({
                                    title: '성공',
                                    text: '삭제되었습니다.',
                                    icon: 'success',
                                    confirmButtonText: '확인'
                                }).then((result) => {
                                    if (result.isConfirmed) {
	                       			 window.location.replace('${contextPath}/booking/ass.list');
                                    }
                                });
	                           
	                        }
	                    }
	            	})
	            }
	        })
	    }
	    
	    function changeMod() { // 모달창 드롭박스 체인지 
	        var selectMain = document.getElementById('assMain').value;
	        var room = document.getElementById('roomSub');
	        var supplies = document.getElementById('supSub');
	     
	        if (selectMain === '002-') {
	            room.style.display = 'block';
	            supplies.style.display = 'none';
	            
	        } else if (selectMain === '003-') {
	            room.style.display = 'none';
	            supplies.style.display = 'block';
	           
	        }
	    }
	    
	    function changeSub() { // 검색 폼 드롭박스 체인지 
	        var selectedValue = document.getElementById('mainName').value;
	        var room = document.getElementById('room-sub');
	        var supplies = document.getElementById('sup-sub');

	        if (selectedValue === '002-') {
	            room.style.display = 'block';
	            supplies.style.display = 'none';
	        } else if (selectedValue === '003-') {
	            room.style.display = 'none';
	            supplies.style.display = 'block';
	        }
	    }

	</script>
	

</body>
</html>