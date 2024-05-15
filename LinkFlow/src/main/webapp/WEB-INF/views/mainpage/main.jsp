<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- fullCalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- echarts -->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
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
	
	.divisionOne_one>div {
		border: 1px solid black;
	}
	
	.divisionOne_two {
		margin-left: 220px;
		margin-top: 50px;
	}
	
	.mainContent_chart {
		width: 1320px;
		height: 400px;
		border: 1px solid black;
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
	
	#calendar a {
		color: black;
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
						<a href="" class="category_link">
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
							<a href=""> 
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
						<div class="division" style="width: 400px; height: 300px; align-items: center;">
							<div style="width: 80%; height: 90%;">
								<p style="font-size: 20px; margin-bottom: 0px;">5월 8일 (수)</p>
								<p style="font-size: 35px;">
									00 : 00 : 00
									<button class="btn"
										      style="background-color: rgb(219, 230, 245); color: #3a8cdf; cursor: default; transform: translateY(-2px);"
										      disabled>
										출근전
								  </button>
								</p>
								<div style="display: flex; justify-content: center;">
									<div style="border-right: 1px solid lightgray; height: 150px;">
										<button class="btn"
											      style="width: 100px; height: 80px; transform: translateX(-50px); margin-top: 10px; outline: none;">
											<i class="fa-regular fa-circle-check fa-4x"></i>
											<p style="margin-top: 20px; margin-bottom: 5px;">출근하기</p>
										</button>
										<p style="transform: translateX(-33px) translateY(40px);">00 : 00 : 00</p>
									</div>
									<div>
										<button class="btn"
											      style="width: 100px; transform: translateX(50px); margin-top: 10px; outline: none; opacity: 0.5; cursor: default;"
											      disabled>
											<i class="fa-solid fa-circle-check fa-4x"></i>
											<p style="margin-top: 20px; margin-bottom: 5px;">퇴근하기</p>
										</button>
										<p style="transform: translateX(65px) translateY(-7.5px); opacity: 0.5;">00 : 00 : 00</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 근무체크 끝 -->

					<!-- 전자결재 시작 -->
					<div class="divisionOne_one">
						<h4>전자결재</h4>
						<div class="division" style="width: 400px; height: 150px;">
							<div
								style="width: 90%; height: 90%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
								<div style="margin-bottom: 10px;">
									<a class="btn btn-outline-secondary" href="${ contextPath }/edsm/prog/listWait.prog">대기</a> 
									<a class="btn btn-outline-secondary" href="${ contextPath }/edsm/prog/listCheck.prog">확인</a>
								</div>
								<div>
									<a class="btn btn-outline-secondary" href="${ contextPath }/edsm/prog/listPlan.prog">예정</a> 
									<a class="btn btn-outline-secondary" href="${ contextPath }/edsm/prog/listProg.prog">진행</a>
								</div>
							</div>
						</div>
					</div>
					<!-- 전자결재 끝 -->
				</div>
				<!-- 일정 시작 -->
				<div>
					<div class="divisionOne_two">
						<h4 style="margin-left: 330px;">일정</h4>
						<div class="division" style="width: 700px; height: 535px; border: 1px solid black;">
							<div style="width: 90%; height: 90%;">
								<div id="calendar" style="transform: translateY(-50px); width: 600px; height: 80%;"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- 일정 끝 -->
			</div>

			<!-- 공지사항 시작 -->
			<div style="margin-left: 300px; margin-top: 100px;">
				<h4 style="margin-left: 610px;">공지사항</h4>
				<div class="division" style="width: 1320px; height: 300px; border: 1px solid black;">
					<div style="width: 95%; height: 95%;">
						<div class="card-body">
							<table id="example2" class="table table-bordered table-hover">
								<tbody style="text-align: center;">
									<tr>
										<td style="width: 10%;">30</td>
										<td style="width: 70%;"><a href="dd">공지사항 30</a></td>
										<td style="width: 20%;">2024-05-08</td>
									</tr>
									<tr>
										<td>29</td>
										<td><a href="dd">공지사항 29</a></td>
										<td>2024-05-08</td>
									</tr>
									<tr>
										<td>28</td>
										<td><a href="dd">공지사항 28</a></td>
										<td>2024-05-08</td>
									</tr>
									<tr>
										<td>27</td>
										<td><a href="dd">공지사항 27</a></td>
										<td>2024-05-08</td>
									</tr>
									<tr>
										<td>26</td>
										<td><a href="dd">공지사항 26</a></td>
										<td>2024-05-08</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 공지사항 끝 -->

			<!-- 사원현황 시작 -->
			<!-- 여기는 슈퍼관리자 / 인사담당자로 로그인시에만 표시 -->
			<div class="mainContent_chart">
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
				<div style="width: 30%;">
					<h4>성별 현황</h4>
					<div class="division">
						<div>
							<canvas id="pieChart"></canvas>
						</div>
					</div>
				</div>
			</div>
			<!-- 사원현황 끝 -->
			<!-- 메인 내용 끝 -->
		</div>
	</div>
	<script>

        // 캘린더 시작
        document.addEventListener('DOMContentLoaded', function() {
          var calendarEl = document.getElementById('calendar');
          var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                start: '', 
                center: '',
                end: ''
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
                    data: [20,15],
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
                data: ['2023-11', '2023-12', '2024-01', '2024-02', '2024-03', '2024-04'],
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
                data: [30, 31, 32, 33, 34, 35]
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
                data: [1, 1, 1, 2, 2, 2]
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
                data: [0, 0, 0, 1, 1, 1]
                }
            ]
        };

        option && myChart.setOption(option);
        // 꺾은선 그래프 끝
    </script>
	
	</div>
</body>
</html>