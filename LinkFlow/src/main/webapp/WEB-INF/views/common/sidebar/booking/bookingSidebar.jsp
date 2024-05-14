<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>booking sidebar</title>

<style>
.LinkFlowSidebar {
	width: 15%;
	min-width: 300px;
	min-height: 400px;
}

.sidebarName {
	font-size: 32px;
	font-weight: bold;
	color: #d0d4db;
}

.middleName {
	font-size: 20px;
	font-weight: bold;
}

.linkfoiwsideMenu {
	padding: 0px 20px 0px 20px;
	margin-top: 38px;
}

.LinkFlowInsertBtnArea {
	margin-bottom: 20%;
}

.sideSmall {
	padding-left: 20px;
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

.bk-coment {
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


</style>
</head>
<body>

	<div class="LinkFlowSidebar">
		<!-- Main Sidebar Container -->
		<aside class="sidebar-mini sidebar-dark-primary elevation-4 "
			style="height: 100%;">

			<!-- Sidebar -->
			<div class="sidebar">

				<!-- Sidebar Menu -->
				<nav class="linkfoiwsideMenu">

					<!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-->
					<div class="LinkFlowInsertBtnArea">
						<button type="button" class="btn btn-block bg-primary btn-lg"
							data-toggle="modal" data-target="#booking">+ 예약하기</button>
					</div>

					<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
						<li class="sidebarName">시설/비품 예약</li>
						<br>

						<li class="nav-item">
							<a href="${contextPath }/booking/room.bk" class="nav-link middleName"> 
								<i class="nav-icon far-2xl fa-solid fa-book"></i>
								<p>시설 예약</p>
							</a>
						</li>

						<li class="nav-item">
							<a href="${contextPath }/booking/supplies.bk" class="nav-link middleName"> 
								<i class="nav-icon fa-2xl fa-solid fa-book"></i>
								<p>비품 예약</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${contextPath }/booking/mylist.bk" class="nav-link middleName"> 
								<i class="nav-icon far-2xl fa-solid fa-book-bookmark"></i>
								<p>나의 예약 목록</p>
							</a>
						</li>

						<br>
						<br>
						<c:if test="${ loginUser.spRight eq 'Y' }">
						<li class="nav-item"><a href="#" class="nav-link middleName">
								<i class="nav-icon far-2xl fa-solid fa-gear"></i>
								<p>
									예약 관리 <i class="fas fa-angle-left right"></i>
								</p>
						</a>

							<ul class="nav nav-treeview" style="padding-left: 20px;">
								<li class="nav-item"><a
									href="/facility-reservation-management" class="nav-link"> <i
										class="far far-2xs fa-circle nav-icon"></i>
										<p>시설 예약 관리</p>
								</a></li>
								<li class="nav-item">
									<a href="/equipment-reservation-management" class="nav-link">
										<i class="far far-2xs fa-circle nav-icon"></i>
										<p>비품 예약 관리</p>
									</a>
								</li>
							</ul>
						</li>
						<li class="nav-item">
							<a href="/asset-management" class="nav-link middleName"> 
								<iclass="nav-icon far-2xl fa-solid fa-wallet"></i>
								<p>자산 관리</p>
							</a>
						</li>
						</c:if>
					</ul>
				</nav>
				<!-- /.sidebar-menu -->
			</div>
			<!-- /.sidebar -->
		</aside>

		<!-- 예약하기 -->
		<div class="modal fade" id="booking">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="md-header">
						<select name="bk-name" id="bk-name" class="md-type">
							<option value="room">시설</option>
							<option value="supplies">비품</option>
						</select> &nbsp;&nbsp;
						<p style="float: left;">예약하기</p>
					</div>
					<%-- <c:choose>
					<c:when test=${bk-name eq room}>
						<span class="md-list">예약 날짜</span>
                            <div class="md-div">
                                <select name="bk-year" id="bk-year" style="width:70px;" class="md-select">
                                    <option value="">2024</option>
                                    <option value="">2025</option>
                                </select> &nbsp;&nbsp;
                                <select name="bk-month" id="bk-month" class="md-select">
                                    <option value="">04</option>
                                    <option value="">5</option>
                                </select> &nbsp;&nbsp;
                                <select name="bk-date" id="bk-date" class="md-select">
                                    <option value="">15</option>
                                    <option value="">16</option>
                                    <option value="">17</option>
                                    <option value="">18</option>
                                    <option value="">19</option>
                                </select> &nbsp;&nbsp;
                            </div>
                            <span class="md-list">이용 시간</span>
                            <div class="md-div">
                                <select name="bk-sTime" id="bk-sTime" style="width:90px;" class="md-select">
                                    <option value="">09 : 00</option>
                                    <option value="">10 : 00</option>
                                </select> &nbsp;&nbsp;
                                <span>~</span>&nbsp;&nbsp;
                                <select name="bk-eTime" id="bk-eTime" style="width:90px;" class="md-select">
                                    <option value="">09 : 00</option>
                                    <option value="">10:00</option>
                                </select> &nbsp;&nbsp;
                            </div>
                            <span class="md-list">이용 시설</span>
                            <div class="md-div">
                                <select name="bk-room" id="bk-room" style="width:100px;" class="md-select">
                                    <option value="">회의실A</option>
                                    <option value="">회의실B</option>
                                    <option value="">회의실C</option>
                                </select>
                            </div>
                    </c:when>

					<c:when test=${bk-name eq supplies }>
						<span class="md-list">상품 명</span>
						<div class="md-div">
							<select name="supplies" id="supplies" style="width: 100px;"
								class="md-select">
								<option value="notebook">노트북</option>
								<option value="car">차량</option>
								<option value="keyboard">키보드</option>
								<option value="mouse">마우스</option>
							</select> &nbsp;&nbsp;&nbsp; <select name="bk-name" id="bk-name"
								style="width: 110px;" class="md-select">
								<option value="">맥북</option>
								<option value="">LG그램</option>
							</select>
						</div>
						<span class="md-list">이용 시간</span>
						<c:if test=${supplies eq car }>
							<div class="md-div">
								<select name="bk-name" id="bk-name" style="width: 120px;"
									class="md-select">
									<option value="">2024/04/22</option>
									<option value="">2024/04/23</option>
								</select> &nbsp;&nbsp; <span>~</span>&nbsp;&nbsp; <select name="bk-name"
									id="bk-name" style="width: 120px;" class="md-select">
									<option value="">2024/04/23</option>
									<option value="">10:00</option>
								</select> &nbsp;&nbsp;
							</div>
						</c:if>
					</c:when>
					</c:choose> --%>
 
					<div class="modal-body">
						<h6>사유</h6>
						<input type="text" class="bk-coment" placeholder="예약 사유">
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
		<!--사이드바 끝-->
	</div>
	<script>
	    $(document).ready(function () {
	      $('.dropdown-item').click(function () {
	        var selectedText = $(this).find('.spanCss').text();
	        $('.resultArea').text(selectedText);
	      });
	    });
	    
	    /* $function(){
	    	$.ajax({
	    		
	    	})
	    } */
	
	  </script>
</body>
</html>