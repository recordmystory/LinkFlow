<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 시설/비품</title>

<style>
.LinkFlowMainSection {
	width: 100%;
	display: flex;
}

.LinkFlowMainContent {
	width: 100%;
	min-width: 1260px;
	background-color: #f4f6f9;
	min-height: 900px;
	padding: 30px;
	border-radius: 5px;
}

/* 예약 상세 */
.ymd {
	display: flex;
	justify-content: space-between;
	align-items: center;
	/* padding-top: 10px; */
	margin-left: 10px;
}

.ass-detail {
	display: flex;
	align-items: center;
	margin-left: 20px;
}

.bk-head {
	display: flex;
	justify-content: flex-end;
	width: 92%;
	padding-left: 40px;
	padding-right: 10px;
}

.bk-detail {
	width: 90%;
	min-height: 600px;
	margin: 20px;
}

.bk-detailArea {
	background-color: white;
	border: 1px solid rgb(163, 161, 161);
	border-radius: 10px;
	padding: 40px;
}

.bk-content{
	border:0;
}

.form-control {
	text-align: center;
}

.coment {
	border: 1px solid rgb(47, 46, 46);
	border-radius: 3px;
}

.can-coment {
	border: none;
	border-bottom: 1px solid steelblue;
	width: 80%;
	height: 50px;
	margin-left: 20px;
}

.modal-body {
	margin-left: 10px;
}

.modal-mod-body {
	text-align: center;
	margin: 10px;
	font-size: 15px;
	padding-top: 8px;
}
#bk-content{
	width:100%;
	min-height:80px;
	padding:10px;
	
}
</style>

</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="LinkFlowMainSection">
			<jsp:include
				page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp"/>

			<div class="LinkFlowMainContent">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">예약 상세</h1>
						</div>

					</div>
				</section>
					<!-- /.container-fluid -->
				<div class="" style="display: flex; flex-wrap: wrap;">
					<div class="bk-head">
						<div>
							<a class="btn bg-gradient-secondary" href="${ contextPath }/booking/mylist.bk">목록으로</a>
						</div>
					</div>
					
					<div class="bk-detail" id="detailArea">
						<input type="hidden" name="bookingNo" value="${bk.bookingNo }" id="bookingNo">
					
						<div class="bk-detailArea">
						    <div class="ymd" style="height:30px;">
						        <div class="ymd">
						        	
						            <c:set var="ymd" value="${bk.bkStartDate}" />
						            <c:set var="ymdArr" value="${fn:split(ymd, '/')}" />
						            <c:choose>
						                <c:when test="${empty bk.bkStartDate}">
						                    <h4>&nbsp;</h4>
						                </c:when>
						                <c:otherwise>
						                
							        	<select id="year" name="year" class="form-control" style="width: 100px;"></select>
							        	<select id="month" name="month" class="form-control" style="width: 80px;"></select>
							        	<select id="day" name="day" class="form-control" style="width: 80px;"></select>
						                

						                    <p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp;</p>
						
						                   <c:choose>
											    <c:when test="${bk.subName eq '회의실'}">
											        <select id="start" name="bkStartTime" class="form-control" style="width: 110px;">
											            <c:forEach var="hour" begin="9" end="17">
											                <c:forEach var="minute" begin="0" end="30" step="30">
											                    <c:if test="${hour != 17 || minute == 0}">
											                        <c:set var="time" value="${hour < 10 ? '0' : ''}${hour}:${minute == 0 ? '00' : minute}"/>
											                        <option value="${time}" ${time == bk.bkStartTime ? 'selected' : ''}>
											                            ${time}
											                        </option>
											                    </c:if>
											                </c:forEach>
											            </c:forEach>
											        </select>
											        &nbsp;&nbsp;<span>~</span>&nbsp;&nbsp;
											        <select id="end" name="bkEndTime" class="form-control" style="width: 110px;">
											            <!-- 기본적으로 끝나는 시간을 미리 생성 -->
											            <c:forEach var="hour" begin="10" end="18">
											                <c:forEach var="minute" begin="0" end="30" step="30">
											                    <c:set var="time" value="${hour}:${minute == 0 ? '00' : minute}"/>
											                    <option value="${time}" ${time == bk.bkEndTime ? 'selected' : ''}>
											                        ${time}
											                    </option>
											                </c:forEach>
											            </c:forEach>
											        </select>&nbsp;
											    </c:when>
						                         <c:when test="${bk.subName eq '차량'}">
											        <c:set var="ymdEnd" value="${bk.bkEndDate}" />
											        <c:set var="ymdEndArr" value="${fn:split(ymdEnd, '/')}"/>
											        <select id="yearEnd" name="yearEnd" class="form-control" style="width: 100px;">
											            <option value="${ymdEndArr[0]}">${ymdEndArr[0]}</option>
											            <c:if test="${ymdEndArr[0] == 12}">
											                <option value="${ymdEndArr[0] + 1}">${ymdEndArr[0] + 1}</option>
											            </c:if>
											        </select>&nbsp; 
											        <select id="monthEnd" name="monthEnd" class="form-control" style="width: 80px;">
											            <option value="${ymdEndArr[1]}">${ymdEndArr[1]}</option>
											            <c:choose>
											                <c:when test="${ymdEndArr[1] eq todayArr[1]}">
											                    <option value="0${ymdEndArr[1] + 1}">0${ymdEndArr[1] + 1}</option>
											                </c:when>
											                <c:otherwise>
											                    <option value="0${ymdEndArr[1] - 1}">0${ymdEndArr[1] - 1}</option>
											                </c:otherwise>
											            </c:choose>
											        </select>&nbsp; 
											        <select id="dayEnd" name="dayEnd" class="form-control" style="width: 80px;">
											            <option value="${ymdEndArr[2]}">${ymdEndArr[2]}</option>
											            <option value="${ymdEndArr[2] + 1}">${ymdEndArr[2] + 1}</option>
											        </select>&nbsp;
											    </c:when>
						                    </c:choose>
						                </c:otherwise>
						            </c:choose>
						        </div>
					        	<div>
						            <h5 style="margin-right: 20px;" id="status" name="status" value="${bk.status}">${bk.status}</h5>
							    </div>
					        </div>
							    <hr>
							    <div class="ass-detail">
							        <select id="assType" class="form-control" name="subName" style="width: 100px;" disabled>
							            <option value="${bk.subName}">${bk.subName}</option>
							        </select>&nbsp;
							        <p style="font-size: 30px; margin-top: 5px;">&nbsp;&nbsp;/&nbsp;&nbsp;</p>
							        <select id="assName" name="assetsName" class="form-control" style="min-width: 80px; max-width: 220px;">
								            <option value="${bk.assetsName }">${bk.assetsName }</option>
							            <c:forEach var="ass" items="${assList}">
									        <c:if test="${!ass.assetsName.equals(bk.assetsName)}">
									            <option value="${ass.assetsName}">${ass.assetsName}</option>
									        </c:if>
									    </c:forEach>
							        </select>
							    </div>

	
								<hr>
								<div style="margin: 40px;">
									<h4>사유</h4>
									<div class="coment" style="height: 150px;">
									<c:choose>
									<c:when test="${ bk.status eq '예약대기' }">
										<input type="text" id="bk-content" name="bkContent" value="${ bk.bkContent }" class="bk-content"></div>
									</c:when>
									<c:otherwise>
										<input type="text" id="bk-content" name="bkContent" value="${ bk.bkContent }" class="bk-content" disabled></div>
									</c:otherwise>
									</c:choose>
								</div>
								
								<hr>
								<c:if test="${ bk.status eq '반려' }">
									<div style="margin: 40px;">
										<h4>반려 사유</h4>
										<div class="coment" style="height: 100px;" disabled><p disabled>${ bk.rejContent }</p>
										</div>
									</div>
								</c:if>

							</div>
						<!-- /.card -->
						<div class="md-btn" style="padding-top: 30px; float: right;">
							<c:if test="${bk.status eq '예약대기' }">
								<!-- 상태가 예약 대기일 때 보여질 수 있도록-->
								<button class="btn bg-gradient-primary" data-toggle="modal" data-target="#bk-mod">예약 수정</button>
								<button class="btn btn-default" data-toggle="modal" data-target="#bk-can">예약 취소</button>
							</c:if>
						</div>
						
					</div>
					<!-- /.content-wrapper -->
				</div>
			</div>
			<!-- /.content-wrapper -->
		</div>
	</div>
	<!-- 예약 수정 -->
	<div class="modal fade" id="bk-mod">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예약 수정하기</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-mod-body">
					<p>예약 내용을 확인하였으며, 예약 상세 내용을 수정합니다.</p>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
					<button type="button" class="btn btn-outline-primary" onclick="bkUpdate();">&nbsp;OK&nbsp;</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- 예약 취소 모달-->
	<div class="modal fade" id="bk-can">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예약 취소하기</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="cancleBk" action="${contextPath }/booking/cancle.bk" method="post">
					<div class="modal-body">
						<h6>사유</h6>
						<input type="text" class="can-coment" name="bkContent" placeholder="취소 사유">
					</div>
						<input type="hidden" name="bookingNo" value="${ bk.bookingNo }">
					<div class="modal-footer justify-content-between">
						<button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
						<button type="submit" class="btn btn-outline-primary">&nbsp;OK&nbsp;</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<script>
		
		$(document).ready(function(){
			let status = document.getElementById('status').textContent;
		    if(status !== "예약대기"){
		        $("#detailArea select").prop("disabled", true);
		    }
			
		   var now = new Date();
		    
		    /***************************** 날짜 초기화 ***********************************/
		    $("#year").empty();
		    $("#month").empty();
		    $("#day").empty();
		    
		    var detailYear = "${ymdArr[0]}"; // DB에서 조회한 상세 년도
		    var detailMonth = "${ymdArr[1]}"; // DB에서 조회한 상세 월
		    var detailDay = "${ymdArr[2]}"; // DB에서 조회한 상세 일

		    //년도 셋팅
		    $("#year").append("<option value='"+detailYear+"'>"+detailYear+"</option>");
		 	if(detailMonth == "12") {
		 		var nextYear = Number(detailYear)+1;
		 		$("#year").append("<option value='"+nextYear+"'>"+nextYear+"</option>");
		    }
		 	
		 	 // 월 셋팅
		     $("#month").append("<option value='" + detailMonth + "'>" + detailMonth + "</option>");
		     var currentMonth = (now.getMonth() + 1 < 10 ? '0'+(Number(now.getMonth()) + 1) : (Number(now.getMonth()) + 1));
		     
		     if (detailMonth == currentMonth) {
		         var nextMonth = currentMonth < 12 ? Number(currentMonth) + 1 : 1;
		         $("#month").append("<option value='" + (nextMonth <10 ? '0'+nextMonth : nextMonth) + "'>" + (nextMonth <10 ? '0'+nextMonth : nextMonth) + "</option>");
		     	
		     } else {
		         $("#month").append("<option value='" + currentMonth + "'>" + currentMonth + "</option>");
		     }
		 	
		 	//일 셋팅
		 	var detailDate = new Date(detailYear, detailMonth, 0);
		 	$("#day").append("<option value='"+detailDay+"'>"+detailDay+"</option>");
		 	
		 	for(var i=now.getDate(); i<=detailDate.getDate(); i++){
		 		if( i != detailDay){
		 			$("#day").append("<option value='"+(i < 10 ? '0'+i : i )+"'>"+(i < 10 ? '0'+i : i )+"</option>");
		 		}
		 	}
		 	/***************************** 날짜 초기화 ***********************************/
		 
		    $("#year").change(function(){
		    	$("#day").empty();
				var tempDate = new Date($(this).val(), $("#month").val()-1, 0);
				for(var i=1; i<=tempDate.getDate(); i++){
			 		$("#day").append("<option value='"+i+"'>"+i+"</option>");
			 	}
		    });
		    
		    $("#month").change(function(){
				$("#day").empty();
				var tempDate = new Date($("#year").val(), $(this).val(), 0);
				if(tempDate.getMonth() != now.getMonth()){
					for(var i=1; i<=tempDate.getDate(); i++){
				 		$("#day").append("<option value='"+(i < 10 ? '0'+i : i )+"'>"+(i < 10 ? '0'+i : i )+"</option>");
				 	}
				}else{
					$("#day").append("<option value='"+(now.getDate() < 10 ? '0'+(now.getDate()) : now.getDate())+"'>"
													  +(now.getDate() < 10 ? '0'+(now.getDate()) : now.getDate())+"</option>");
				 	
				 	for(var i=now.getDate(); i<=detailDate.getDate(); i++){
				 		if( i != detailDay){
				 			$("#day").append("<option value='"+(i < 10 ? '0'+i : i )+"'>"+(i < 10 ? '0'+i : i )+"</option>");
				 		}
				 	}
				}
		    });
		})
		
		function bkUpdate(){
			let year = document.getElementById('year').value;
			let month = document.getElementById('month').value;
			let day = document.getElementById('day').value;
			
			let subName = document.getElementById('assType').value;
			
			let bkStartDate = year +'/' +month+ '/'+ day;
			let bkStartTime = document.getElementById('start').value;
			let bkEndTime = document.getElementById('end').value;
			
			let bkEndDate;
			
			if(subName == '회의실'){
				bkEndDate = year +'/' +month+ '/'+ day;
			}else if(subName == '차량'){
				let dayE = document.getElementById('dayEnd').value;
				let yearE = document.getElementById('yearEnd').value;
				let monthE = document.getElementById('monthEnd').value;
				bkEndDate = yearE +'/' +monthE + '/'+ dayE;
			}
			
			let assetsName = document.getElementById('assName').value;
			let bkContent = document.getElementById('bk-content').value;
			let bookingNo = document.getElementById('bookingNo').value;
			
			$.ajax({
				url:'${contextPath}/booking/modify.bk',
				type:'post',
				data:{
					bkStartDate:bkStartDate,
					bkStartTime:bkStartTime,
					bkEndDate:bkEndDate,
					bkEndTime:bkEndTime,
					subName:subName,
					assetsName:assetsName,
					bkContent:bkContent,
					bookingNo:bookingNo
				},success:function(bk){
					if(bk != null){
						window.location.href = '${contextPath}/booking/mylist.bk'
					}
				},error:function(){
					
				}
				
			})
		}
		
		document.addEventListener("DOMContentLoaded", function() {
		    var startSelect = document.getElementById("start");
		    var endSelect = document.getElementById("end");

		    if (startSelect && endSelect) {
		        startSelect.addEventListener("change", function() {
		            var selectedStartTime = this.value.trim();
		            var startTimeParts = selectedStartTime.split(':');
		            var startHour = parseInt(startTimeParts[0]);
		            var startMinute = parseInt(startTimeParts[1]);

		            endSelect.innerHTML = ""; // 종료시간 비우기

		            // 시작시간 + 1 = 종료시간
		            var initialHour = startHour + 1;
		            var initialMinute = startMinute;

		            // 종료시간이 18일 때 분 0 처리
		            if (initialHour >= 18) {
		                initialHour = 18;
		                initialMinute = 0;
		            }

		            // 반복문으로 시작시간 변경할 때마다 종료시간 바꿔주기
		            for (var hour = initialHour; hour <= 18; hour++) {
		                for (var minute = (hour === initialHour ? initialMinute : 0); minute <= 30; minute += 30) {
		                    if (hour === 18 && minute > 0) continue; // 18시 까지
		                    var optionHour = hour < 10 ? '0' + hour : hour;
		                    var optionMinute = minute === 0 ? '00' : minute;
		                    var optionValue = optionHour + ':' + optionMinute;
		                    var option = document.createElement("option");
		                    option.value = optionValue;
		                    option.textContent = optionValue;
		                    endSelect.appendChild(option);
		                }
		            }
		        });
		    }
		});
	</script>


</body>
</html>