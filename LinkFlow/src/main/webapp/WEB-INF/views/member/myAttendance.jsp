<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 근태</title>
   <!--다음주소 API-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
     .wrapper{
         min-height: 100%;
         width: 100%;
      }
      .LinkFlowheader{
         width: 100%;
        min-width: 1560px;
      }
     .LinkFlowMainSection{
         width: 100%;
         min-height: 1500px;
        
         display: flex;
       
     }
     .LinkFlowSidebar{
         width: 15%;
         min-width: 300px;
         min-height: 400px;
     }
     .LinkFlowMainContent{
         width: 100%;
         min-width: 1260px;
         background-color: #f4f6f9;
         min-height: 400px;
         padding: 30px;
     }
     .userProfileIMG{
       width: 25px;
       margin-left: 20px;
     }
     .spanCss{
      margin: 10px;
     }
     .mainMenuSelect{
      width: 90%;
      display: flex;
      justify-content: space-between;
      margin: auto;
      padding: 1%;
     }
     .movePage{
      min-width: 400px;
     }
     .resultArea{
      margin-left: 10px;
      font-weight: bold;
      font-size: large;
      color: black;
     }
     .sidebarName{
      font-size: 32px;
      font-weight: bold;
      color: #d0d4db;
     }
     .middleName{
      font-size: 20px;
      font-weight: bold;
     }
     .linkfoiwsideMenu{
      padding: 0px 20px 0px 20px;
     
      margin-top: 38px;

     }
     .LinkFlowInsertBtnArea{
       margin-bottom: 20%;
      
     }
     .sideSmall{
      padding-left: 20px;
     }
     .contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
     .contentArea{ 
      width: 100%;
      
     }
     .ExArea{
        margin: auto;
        padding: 20px;
        font-size: 15px;
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

      .myPageArea{
        margin-top: 20px;
        width: 100%;
      }
     .AttendanceSmArea{
        margin: auto;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        
     }
     .AttendanceSmBox{
        width: 500px;
     }
     .oneBoxArea{
        margin-bottom: 50px;
     }
     .AttendanceSmBox1{
        width: 100%;
     }
     .AttendanceSmArea1{
        margin: auto;
        padding: 20px;
        min-width: 100%;
     }
     .AttendanceSeachArea{
        display: flex;

     }
</style>


</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/mypage/mypageSidebar3.jsp"/>

        <div class="LinkFlowMainContent">
        
 				  <!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">나의 근태</h1>
                            </div>
                        
                        </div>
                    <!-- /.container-fluid -->
                    
                    </section>
                   
                    <!-- Main content -->
                    <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;"> 
                      <div class="contentArea">
                        <!--
                        <div class="contentInElement">
                          <div class="btnArea">
                            <button class="btn btn-primary btn-sm">기안하기</button>
                            <button class="btn btn-primary btn-sm">임시저장</button>  
                          </div>
                          <div class="form-inline">
                            <div class="input-group" data-widget="sidebar-search">
                              <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                              <div class="input-group-append">
                                <button class="btn btn-primary">
                                  <i class="fas fa-search fa-fw"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                    -->

                    <div class="myPageArea">
                        <div class="card card-default color-palette-box card-primary oneBoxArea">
                            <div class="card-header">
                              <h3 class="card-title">
                                
                                
                                올해 근무 현황
                              </h3>
                            </div>
                            
                              <!-- /.col-12 -->
                              <div class="row">

                                <div class="col-3 AttendanceSmArea">
                                    <div class="card card-default AttendanceSmBox">
                                      <div class="card-header">
                                        <h3 class="card-title">
                                          <i class="fas fa-bullhorn"></i>
                                          근태 현황
                                        </h3>
                                      </div>
                                      <!-- /.card-header -->
                                      <div class="card-body">
                                        <div class="">
                                          <table class="table table-bordered">
                                            <thead style="text-align: center;">
                                                <th>지각</th>
                                                <th>결근</th>
                                            </thead>
                                            <tbody style="text-align: center;">
                                                <tr>
                                                    <td>${att.yearlateCount}회</td><!--여따가 지각 값 뿌리자-->
                                                    <td>${att.yearAbsentCount}회</td><!--여따가 결근 값 뿌리자-->
                                                </tr>
                                            </tbody>
                                          </table>

                                        </div>
                                      
                                      </div>
                                      <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                  </div>


                                  <div class="col-3 AttendanceSmArea">
                                    <div class="card card-default AttendanceSmBox">
                                      <div class="card-header">
                                        <h3 class="card-title">
                                          <i class="fas fa-bullhorn"></i>
                                          연차현황
                                        </h3>
                                      </div>
                                      <!-- /.card-header -->
                                      <div class="card-body">
                                        <div class="">
                                          <table class="table table-bordered">
                                            <thead style="text-align: center;">
                                                <th>잔여휴가</th>
                                                <td><a href ="" class="btn btn-sm btn-info">휴가 현황</a></td>
                                            </thead>
                                            <tbody style="text-align: center;">
                                                <tr>
                                                    <td>${loginUser.dayOff}</td><!--여따가 휴가 값 뿌리자-->
                                                    <td><a href ="" class="btn btn-sm btn-warning">연차 신청</a></td>
                                                </tr>
                                            </tbody>
                                          </table>

                                        </div>
                                      
                                      </div>
                                      <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                  </div>

                                  <div class="col-3 AttendanceSmArea">
                                    <div class="card card-default AttendanceSmBox">
                                      <div class="card-header">
                                        <h3 class="card-title">
                                          <i class="fas fa-bullhorn"></i>
                                          근무시간
                                        </h3>
                                      </div>
                                      <!-- /.card-header -->
                                      <div class="card-body">
                                        <div class="">
                                          <table class="table table-bordered">
                                            <thead style="text-align: center;">
                                                <th>근무일수</th>
                                                <td>총 근무시간</td>
                                            </thead>
                                            <tbody style="text-align: center;">
                                                <tr>
                                                    <td>${att.yearWalkDay}회</td><!--여따가 휴가 값 뿌리자-->
                                                    <td>${att.yearWalktime}시간</td>
                                                </tr>
                                            </tbody>
                                          </table>

                                        </div>
                                      
                                      </div>
                                      <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                  </div>

                                  
                              
                              </div><!-- /.row -->
                            
                        </div><!-- /.card-body -->
                       


                        <div class="card card-default color-palette-box card-primary oneBoxArea">
                            <div class="card-header">
                              <h3 class="card-title">
                               
                                이번달 근무 현황
                              </h3>
                            </div>
                            
                              <!-- /.col-12 -->
                              <div class="row">

                                <div class="col-3 AttendanceSmArea1">
                                    <div class="card card-default AttendanceSmBox1">
                                        <div class="card-header" style="display: flex;">
                                            <h4 class="yearArea">
                                              
                                                
                                            </h4>
                                            <h4 style="margin-right: 20px;">년</h4>
                                            <h4 class="monthArea">
                                              
                                                
                                            </h4>
                                            <h4>월</h4>

                                            
                                          </div>
                                      <!-- /.card-header -->
                                      <div class="card-body">
                                        <div class="">
                                          <table class="table table-bordered">
                                            <thead style="text-align: center;">
                                                <th>지각</th>
                                                <th>결근</th>
                                                <th>근무일수</th>
                                                <th>총 근무시간</th>
                                            </thead>
                                            <tbody style="text-align: center;">
                                                <tr>
                                                    <td>${att.monthlateCount}회</td><!--여따가 지각 값 뿌리자-->
                                                    <td>${att.monthAbsentCount}회</td><!--여따가 결근 값 뿌리자-->
                                                    <td>${att.monthWalkDay}일</td><!--여따가 지각 값 뿌리자-->
                                                    <td>${att.monthWalktime}시간</td><!--여따가 결근 값 뿌리자-->
                                                </tr>
                                            </tbody>
                                          </table>

                                        </div>
                                      
                                      </div>
                                      <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                  </div>

                                  

                                  
                                      
                                      </div>
                                      <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                  </div>
                                  <div class="card card-default color-palette-box card-primary oneBoxArea">
                                    <div class="card-header">
                                      <h3 class="card-title">
                                       
                                        연차 사용 조회
                                      </h3>
                                    </div>
                                    
                                      <!-- /.col-12 -->
                                      <div class="row">
        
                                        <div class="col-3 AttendanceSmArea1">
                                            <div class="card card-default AttendanceSmBox1">
                                                <div class="card-header" style="display: flex;">
                                                    
                                                        <div class="AttendanceSeachArea">
                                                            <div class="col-sm-6">
                                                              <!-- text input -->
                                                              <div class="form-group">
                                                                <label>시작</label>
                                                                <input type="date" class="form-control" id="startDay">
                                                              </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                              <div class="form-group">
                                                                <label>종료</label>
                                                                <input type="date" class="form-control" id="endDay">
                                                                
                                                              </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                	<input type="hidden" name="" value="${loginUser.userId}" id="userId">
                                                                  <button class="btn btn-sm btn-primary col-8" type="button" style="margin-top: 35px;" id="searchDo">검색</button>
                                                                </div>
                                                            </div>
                                                            
                                                          </div>  
                                                    

                                                  </div>
                                              <!-- /.card-header -->
                                              <div class="card-body">
                                                <div class="">
                                                  <table class="table table-bordered">
                                                    <thead style="text-align: center;">
                                                        <th>휴가일자</th>
                                                        <th>휴가구분</th>
                                                        <th>휴가일수</th>
                                                        
                                                    </thead>
                                                    <tbody style="text-align: center;" id="anwArea">
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            
                                                        </tr>
                                                    </tbody>
                                                  </table>
        
                                                </div>
                                              
                                              </div>
                                              <!-- /.card-body -->
                                            </div>
                                            <!-- /.card -->
                                          </div>
        
                                          
        
                                          
                                              
                                              </div>
                                              <!-- /.card-body -->
                                            </div>
                                            <!-- /.card -->
                                  
                              
                              </div><!-- /.row -->
                            
                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                    <!-- /.content-wrapper -->


                </div>
        </div>
        <script>
				    $(document).ready(function() {
				        $('#searchDo').click(function() {
				            var userId = $("#userId").val(); 
				            var dayoffStartsearch = $("#startDay").val(); 
				            var dayoffendsearch = $("#endDay").val(); 
				            
				            $.ajax({
				                url: '${contextPath}/member/serchDayoff', 
				                type: 'POST',
				                data: {
				                    userId: userId,
				                    dayoffStartsearch: dayoffStartsearch,
				                    dayoffendsearch: dayoffendsearch
				                },    
				                success: function(response) {
				                		let tbody = $("#anwArea");
				                		tbody.empty(); 
				                    if(response.length == 0){
				                    	let tr = "<tr><td colspan='3'>조회된 결과가 없습니다.</td></tr>";
				                        tbody.append(tr);
				                        
				                    } else {
				                        let tbody = $("#anwArea");
				                        tbody.empty(); 
				                        for(let i=0; i<response.length; i++) {
				                            let tr = "<tr>"
				                                    + "<td>" + response[i].dayoffStartsearch + " ~ " + response[i].dayoffendsearch + "</td>"
				                                    + "<td>" + response[i].position + "</td>"
				                                    + "<td>" + response[i].dayOffCount + "</td>"
				                                    + "</tr>";
				                            tbody.append(tr);
				                        }
				                    }
				                },
				                error: function() {
				                    console.error('AJAX 오류');
				                }
				            });
				        });
				    });
				</script>
        
        <script>
            
            $(document).ready(function(){
                const today = new Date();
                const currentYear = today.getFullYear();
                const currentMonth = today.getMonth() + 1; 
            $(".yearArea").text(currentYear);    
            $(".monthArea").text(currentMonth);
            });
        </script>
      
   

    </div>
</body>
</html>