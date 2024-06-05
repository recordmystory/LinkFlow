<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 메인페이지</title>
<!-- fullCalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>
<c:if test="${ loginUser.superRight == 'Y' || loginUser.hrRight == 'Y' }">
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- echarts -->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
</c:if>
<style>
	.LinkFlowMainPageSection{	
		    width: 100%;
         min-height: 1500px;
        
         display: flex;
       
	}
	
	
	.mainContent_header {
		height: 200px;
		background-color: rgb(64, 64, 64);
	}
	
	.menuBar {
		justify-content: space-evenly;
		/* justify-content: center; */
		display: flex;
	}
	
	.menubar_category {
		background-color: white;
		border-radius: 50%;
		width: 65px;
		height: 65px;
		position: relative;
		margin-top: 50px;
	}
	
	.menubar_category i {
		color: black;
	}
	
	.category_content {
		color: white;
		font-size: 18px;
	}
	
	.mainContent_divisionOne {
		display: flex;
	}
	
	.divisionOne_one {
		margin-left: 300px;
		margin-top: 50px;
	}
	
	.divisionOne_one h4 {
		margin-left: 150px;
	}
	
	.divisionOne_two {
		margin-left: 220px;
		margin-top: 50px;
	}
	
	.mainContent_chart {
		width: 1320px;
		height: 400px;
		margin-left: 300px;
		margin-top: 100px;
		margin-bottom: 100px;
		display: flex;
		text-align: center;
	}
	
	.mainContent_chart h4 {
		margin-top: 10px;
	}
	
	.division {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.btn-outline-secondary {
		width: 150px;
		color: black;
	}
	
	.fc-day-sun a {
        color: red;
        text-decoration: none;
    }

    .fc-day-sat a {
        color: blue;
        text-decoration: none;
    }
    .fc-day-mon a {
        color: black;
        text-decoration: none;
    }
    .fc-day-tue a {
        color: black;
        text-decoration: none;
    }
    .fc-day-wed a {
        color: black;
        text-decoration: none;
    }
    .fc-day-thu a {
        color: black;
        text-decoration: none;
    }
    .fc-day-fri a {
        color: black;
        text-decoration: none;
    }
   	#calendar {
  		height: 501px !important;
	}
	.holiday{
      border-color: transparent; /*투명화*/
      font-size: smaller; 
    }
</style>
</head>
<body>
	<div class="wrapper">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="LinkFlowMainPageSection">
			<div class="LinkFlowMainContent">
				<!-- 상단 메뉴바 시작 -->
				<div class="mainContent_header">
					<div class="menuBar">
						<span style="margin-left: 150px;"></span> 
						<span class="menubar_category"> 
							<a href="${ contextPath }/mail/receiveList.do" class="category_link">
								<i class="fa-regular fa-envelope" style="font-size: 43px; padding-left: 11px; padding-top: 10px;"></i>
								<p class="category_content" style="padding-left: 13.5px; padding-top: 25px;">메일</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${ contextPath }/board/list.do"> 
								<i class="fa-regular fa-clipboard" style="font-size: 45px; padding-left: 15px; padding-top: 7px;"></i>
								<p class="category_content" style="width: 100px; padding-left: 6px; padding-top: 27px;">게시판</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${contextPath}/calendar/calMain.page"> 
								<i class="fa-regular fa-calendar" style="font-size: 43px; padding-left: 13px; padding-top: 9px;"></i>
								<p class="category_content" style="padding-left: 13px; padding-top: 26px;">일정</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${ contextPath }/group/group.page"> 
								<i class="fa-solid fa-user-group" style="font-size: 35px; padding-left: 10px; padding-top: 13px;"></i>
								<p class="category_content" style="width: 100px; padding-left: 5.5px; padding-top: 29px;">조직도</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${ contextPath }/booking/room.bk"> 
								<i class="fa-regular fa-clock" style="font-size: 45px; padding-left: 11px; padding-top: 9px;"></i>
								<p class="category_content" style="padding-left: 13.5px; padding-top: 23.5px;">예약</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${contextPath}/member/myAttendance.page"> 
								<i class="fa-solid fa-user-clock" style="font-size: 37px; padding-left: 13px; padding-top: 13px;"></i>
								<p class="category_content" style="padding-left: 13.5px; padding-top: 25px;">근태</p>
							</a>
						</span> 
						<span class="menubar_category"> 
							<a href="${ contextPath }/edsm/prog/listAll.prog"> 
								<i class="fa-solid fa-file-invoice" style="font-size: 42px; padding-left: 17px; padding-top: 11px;"></i>
								<p class="category_content" style="width: 100px; padding-top: 24px; transform: translateX(-3px);">전자결재</p>
							</a>
						</span> 
							<span class="menubar_category"> 
							<a href="${ contextPath }/project/list.pj"> 
								<i class="fa-solid fa-desktop" style="font-size: 38px; padding-left: 10.5px; padding-top: 15px;"></i>
								<p class="category_content" style="width: 100px; padding-top: 24px; transform: translateX(-2px);">프로젝트</p>
							</a>
						</span> 
						<span style="margin-left: 150px;"></span>
					</div>
				</div>
				<!-- 상단 메뉴바 끝 -->
	
				<!-- 메인 내용 시작 -->
				<div class="mainContent_divisionOne">
					<div>
						<!-- 근무체크 시작 -->
	                	<div class="divisionOne_one">
	                    	<h4>근무체크</h4>
	                        <div class="division card" style="width: 400px; height: 300px; align-items: center;">
	                            <div style="width: 80%; height: 90%;">
	                                <span id="toDay" style="font-size: 20px; margin-bottom: 0px;"></span>
	                                <button id="checkStatus" class="btn" style="background-color: rgb(219, 230, 245); color: #3a8cdf; cursor: default; transform: translateY(-2px);" disabled>근무중</button>
	                                <br>
	                                <span id="toDayTime" style="font-size: 35px;"></span>
	                                <div style="display: flex; justify-content: center;">
	                                    <div>
	                                        <button class="btn" id="checkOutbtn" style="width: 100px; margin-top: 30px; outline: none;" onclick="checkOutAtt('${loginUser.userId}');">
	                                            <i class="fa-solid fa-circle-check fa-4x"></i>
	                                            <p style="margin-top: 15px; margin-bottom: 5px;">퇴근하기</p>
	                                        </button>
	                                        <p id="checkOutTime" style="transform: translateX(15.5px) translateY(-7.5px);">00 : 00 : 00</p>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <!-- 근무체크 끝 -->
	
						<!-- 전자결재 시작 -->
						<div class="divisionOne_one">
                            <h4>전자결재</h4>
                            <div class="division card" style="width: 400px; height: 150px;"> 
                                <div style="width: 90%; height: 90%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
                                    <div style="display: flex; align-items: center; justify-content: center;">
                                        <a href="${ contextPath }/edsm/prog/listAll.prog" class="btn btn-outline-secondary" style="margin-right: 5px; width: 200px; height: 60px; display: flex; align-items: center; justify-content: center;">진행 중인 문서</a>
                                        <a href="${ contextPath }/edsm/docbox/listAll.docbox" class="btn btn-outline-secondary" style="height: 60px; display: flex; align-items: center; justify-content: center;">문서함</a>
                                    </div>
                                </div>
                            </div>
                        </div>
						<!-- 전자결재 끝 -->
					</div>
					<!-- 일정 시작 -->
					<div>
						<div class="divisionOne_two">
							<h4 style="margin-left: 330px;">캘린더</h4>
							<div class="division card" style="width: 700px; height: 535px;">
								<div style="width: 90%; height: 90%;">
									<div id="calendar" style="transform: translateY(-50px) translateX(13px); width: 600px; height: 80%;"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- 일정 끝 -->
				</div>
	
				<!-- 공지사항 시작 -->
				<div style="margin-left: 300px; margin-top: 100px;">
					<h4 style="margin-left: 610px;">공지사항</h4>
					<div class="division card" style="width: 1320px; height: 300px;">
						<div style="width: 95%; height: 95%;">
							<div class="card-body">
								<table id="example2" class="table table-bordered table-hover">
									<tbody style="text-align: center;">
										<c:forEach var="n" items="${list}">
										<tr>
											<td style="width: 10%;">${ n.boardNo }</td>
											<td style="width: 70%;"><a href="${contextPath}/board/detail.do?no=${n.boardNo}">${ n.boardTitle }</a></td>
											<td style="width: 20%;">${ n.modDate }</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 공지사항 끝 -->
				
				<c:if test="${ loginUser.superRight == 'Y' || loginUser.hrRight == 'Y' }">
				<!-- 사원현황 시작 -->
				<!-- 여기는 슈퍼관리자 / 인사담당자로 로그인시에만 표시 -->
				<div class="mainContent_chart card" style="margin-bottom: 200px">
					<div style="border-right: 1px solid black; width: 70%;">
						<h4>사원 현황</h4>
			    	<div class="division">
			            <div style="width: 90%; height: 90%;">
			              <div style="transform: translateX(-70px) translateY(-30px); width: 1000px; height: 350px;">
			                <div id="lineChart" style="width: 1000px;height:400px;"></div>
			                <!-- <canvas id="lineChart"></canvas> -->
			              </div>
			            </div>
			        </div>
					</div>
					<div style="width: 30%; transform: translateX(930px) translateY(-397px);">
						<h4>성별 현황</h4>
						<div class="division">
							<div>
								<canvas id="pieChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<!-- 사원현황 끝 -->
				</c:if>
				<!-- 메인 내용 끝 -->
			</div>
		</div>
		<script>
			
			// 페이지 로딩시 스크립트 시작(근무시간, 퇴근체크)
			$(document).ready(function() {
			    // 초기 시간 표시
			    updateTime();
		
			    // 1초마다 시간 업데이트
			    setInterval(updateTime, 1000);
			    
			    $.ajax({
			    	url:"${contextPath}/Attemdamce/selectCheckOut.do",
			    	type: "post",
			    	data: {userId: "${loginUser.userId}"},
			    	success: function(result) {
						if (result == 'success') {
							selectCheckOutTime('${loginUser.userId}');
						}
					}
			    })
			});
			// 페이지 로딩시 스크립트 끝
			
			// 근무시간 스크립트 시작
			function updateTime() {
			    var curDate = new Date();
			    var days = ['일', '월', '화', '수', '목', '금', '토'];
			    var dateString = curDate.getFullYear() + "년" + (curDate.getMonth() + 1) + "월" + curDate.getDate() + "일 (" + days[curDate.getDay()] + ") ";
			    var timeString = curDate.getHours().toString().padStart(2, '0') + ":" +
	           					 curDate.getMinutes().toString().padStart(2, '0') + ":" +
	            				 curDate.getSeconds().toString().padStart(2, '0');
			    $("#toDay").text(dateString);
			    $("#toDayTime").text(timeString);
			};
			// 근무시간 스크립트 끝
			
			// 퇴근 스크립트 시작
			function selectCheckOutTime(userId) {
				$.ajax({
					url:"${contextPath}/Attemdamce/selectCheckOutTime.do",
					type: "post",
					data: {userId: userId},
					success: function(checkOutTime) {
						$("#checkStatus").text("근무종료");
						$("#checkOutTime").text(checkOutTime);
						$("#checkOutbtn").css("opacity", "0.5");
						$("#checkOutbtn").css("cursor", "default");
						$("#checkOutbtn").attr("disabled", "true");
						$("#checkOutTime").css("opacity", "0.5");
					}
				})
			};
			
			function checkOutAtt(userId) {
				
				$.ajax({
					url: "${contextPath}/Attemdamce/checkOut.do",
					type: "post",
					data: {userId: userId},
					success: function(result) {
						if(result == 'success'){
							selectCheckOutTime(userId);
						}
					}
				})
			};
			// 퇴근 스크립트 끝
	
	        // 캘린더 시작
	        document.addEventListener('DOMContentLoaded', function() {
	            var calendarEl = document.getElementById('calendar');
	            var calendar = new FullCalendar.Calendar(calendarEl, {
	                googleCalendarApiKey: 'AIzaSyCu-1ogsBMhEzc8DWez4qvcZRRqiVlWKgU',
	                eventSources: {
	                    googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
	                    backgroundColor: 'red',
	                    classNames: 'holiday',
	                    textColor: 'white'
	                },
	                headerToolbar: {
	                    start: '', 
	                    center: '',
	                    end: ''
	                },
	                eventClick: function(info) {
	               		info.jsEvent.preventDefault(); 
	                }
	            
	            });
	            calendar.render();
	          
	        });
	        // 캘린더 끝
			
	        // 파이차트 시작
	        const pie = document.getElementById('pieChart');
	
	        var pieData = {
	            labels: ['남자','여자'],
	            datasets: [
	                {
	                    data: ['${male}','${female}'],
	                    backgroundColor : ['#1a66cc', '#d1180b'],
	                }
	            ]
	        }
	        var pieOptions = {
	            maintainAspectRatio : false,
	            responsive : true,
	        }
	
	        new Chart(pie, {
	            type: 'pie',
	            data: pieData,
	            options: pieOptions
	        });
	        // 파이차트 끝
	        
	
	         // echarts 버전
	        // 꺾은선 그래프 시작
	        var chartDom = document.getElementById('lineChart');
	        var myChart = echarts.init(chartDom);
	        var option;
	
	        option = {
	            tooltip: {
	                trigger: 'axis',
	                backgorundColor: 'black'
	            },
	            legend: {
	                data: ['Evaporation', 'Precipitation', 'Temperature']
	            },
	            xAxis: [
	                {
	                type: 'category',
	                data: ['${sixMonth}', '${fiveMonth}', '${fourMonth}', '${threeMonth}', '${twoMonth}', '${oneMonth}'],
	                }
	            ],
	            yAxis: {
	                type: 'value'
	            },
	            series: [
	                {
	                name: '전체 사원수',
	                type: 'line',
	                color: 'blue',
	                tooltip: {
	                    valueFormatter: function (value) {
	                    return value + '명';
	                    }
	                },
	                data: ['${sixMonthMember - sixMonthRetire}', '${fiveMonthMember - fiveMonthRetire}', '${fourMonthMember - fourMonthRetire}', 
	                	   '${threeMonthMember - threeMonthRetire}', '${twoMonthMember - twoMonthRetire}', '${oneMonthMember - oneMonthRetire}']
	                },
	                {
	                name: '입사자',
	                type: 'bar',
	                color: 'green',
	                tooltip: {
	                    valueFormatter: function (value) {
	                    return value + '명';
	                    }
	                },
	                data: ['${sixMonthHire}', '${fiveMonthHire}', '${fourMonthHire}', '${threeMonthHire}', '${twoMonthHire}', '${oneMonthHire}']
	                },
	                {
	                name: '퇴사자',
	                type: 'bar',
	                color: 'red',
	                tooltip: {
	                    valueFormatter: function (value) {
	                    return value + '명';
	                    }
	                },
	                data: ['${sixMonthRetire}', '${fiveMonthRetire}', '${fourMonthRetire}', '${threeMonthRetire}', '${twoMonthRetire}', '${oneMonthRetire}']
	                }
	            ]
	        };
	
	    	option && myChart.setOption(option);
	        // 꺾은선 그래프 끝
	        
	        
	    </script>
	</div>
</body>
</html>