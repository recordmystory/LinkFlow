<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/9a369fce54.js" crossorigin="anonymous"></script>
<!-- icheck bootstrap -->
<link rel="stylesheet" href="${contextPath }/resources/css/htmlTemp/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${contextPath }/resources/css/htmlTemp/adminlte.min.css">
<!-- jQuery -->
<script src="${contextPath }/resources/js/htmlTemp/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${contextPath }/resources/js/htmlTemp/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${contextPath }/resources/js/htmlTemp/adminlte.min.js"></script>


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
 #boardList{text-align: center;}
 #boardList>tbody>tr:hover{cursor:pointer;}
 #pagingArea{width:fit-content;margin:auto;}
 .readUser{
   border-radius: 10px;
 }

</style>


</head>
<body>
    <div class="wrapper">
      <div class="LinkFlowheader">
        <nav class="navbar navbar-expand navbar-white navbar-light" style="border-bottom: 2px solid #b4bac0;">
            <!-- Left navbar links -->
            <a class="head_BannerImg" style="padding: 10px;"><img src="/공용디자인/resouse/KakaoTalk_20240426_153730164.png" alt="회사배너" style="height: 50px;"></a>
            <ul class="navbar-nav">
              <li class="nav-item dropdown"> 

                <a class="nav-link" data-toggle="dropdown" href="#">
                  
                  <span class="resultArea">게시판</span>
                  <i class="fa-solid fa-caret-down"></i>
                </a>

                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left movePage">
                  
                  <div class="row mainMenuSelect">
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-envelope fa-2xl"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">메일</span></div>
                      </a>
                    </div>
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-user-clock fa-xl"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">예약하기</span></div>
                      </a>
                    </div>
                  </div>

                  <div class="row mainMenuSelect">
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-calendar-days fa-2xl"style="margin-left: 3px;"></i></div>
                        <div class="box-icon-name"><span class="info-box-text spanCss">일정</span></div>
                      </a>
                    </div>
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-stopwatch fa-2xl" style="margin-left: 3px;"></i> </div>
                        <div class="box-text"><span class="info-box-text spanCss">근태관리</span></div>
                      </a>
                    </div>
                  </div>

                  <div class="row mainMenuSelect">

                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-chalkboard fa-2xl"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">게시판</span></div>
                      </a>
                    </div>

                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-clipboard fa-2xl" style="margin-left: 5px;"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">전자결재</span></div>
                      </a>
                    </div>
                  </div>

                  <div class="row mainMenuSelect">
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-people-line fa-2xl" style="width: 30px;"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">조직도</span></div>
                      </a>
                    </div>
                    <div class="info-box-content">
                      <a href="#" class="dropdown-item slimMenu">
                        <div class="box-icon slimMenuicon"><i class="fa-solid fa-computer fa-2xl"></i></div>
                        <div class="box-text"><span class="info-box-text spanCss">프로젝트</span></div>
                      </a>
                    </div>
                  </div>
                  
                </div>   
              </li>
            </ul>
        
            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
              
              <!-- 푸쉬 알람 영역 -->
              <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                  <i class="far fa-bell"></i><!--알람 아이콘-->
                  <span class="badge badge-warning navbar-badge">15</span>
                </a>
                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                  <span class="dropdown-item dropdown-header">15 Notifications</span>
                  <div class="dropdown-divider"></div>
                  <a href="#" class="dropdown-item">
                    <i class="fas fa-envelope mr-2"></i> 4 new messages
                    <span class="float-right text-muted text-sm">3 mins</span>
                  </a>
                  <div class="dropdown-divider"></div>
                  <a href="#" class="dropdown-item">
                    <i class="fas fa-users mr-2"></i> 8 friend requests
                    <span class="float-right text-muted text-sm">12 hours</span>
                  </a>
                  <div class="dropdown-divider"></div>
                  <a href="#" class="dropdown-item">
                    <i class="fas fa-file mr-2"></i> 3 new reports
                    <span class="float-right text-muted text-sm">2 days</span>
                  </a>
                  <div class="dropdown-divider"></div>
                  <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
                </div>
              </li>
              <!-- 푸쉬 알람 영역끝 -->

              <!-- 관리자 급 or 인사 관리자만 보여질 버튼-->
              <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                  <i class="fas fa-th-large"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                  <span class="dropdown-item dropdown-header">페이지 이동하기</span>
                  <div class="dropdown-divider"></div>

                  <a href="#" class="dropdown-item"><!--메인 페이지 부르는 contextpath 링크 거셈-->
                    <i class="fa-solid fa-briefcase mr-2"></i> Office
                  </a>
                  <div class="dropdown-divider"></div>
                  <a href="#" class="dropdown-item"><!--인사관리 페이지 링크 거셈-->
                    <i class="fas fa-users mr-2"></i> HR 
                    
                  </a>
                
                </div>  
               </li>
              <!--로그인 유저 프로필이 나오는곳-->
              <li class="nav-item">
                <a class="nav-link" href="#" role="button">
                  <i class="fa-solid fa-user"></i>
                </a>
              </li>
            </ul>
            
          </nav>
        </div>

        <div class="LinkFlowMainSection">
            <div class="LinkFlowSidebar">
                    <!-- Main Sidebar Container -->
                    <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">

                    <!-- Sidebar -->
                    <div class="sidebar">
                
                    <!-- Sidebar Menu -->
                    <nav class="linkfoiwsideMenu">

                      <!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-->
                      <div class="LinkFlowInsertBtnArea">
                        <a href="#" class="btn btn-block bg-gradient-primary btn-lg" style="color:white">게시글 작성하기</a>
                    
                      </div>
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                
                        <li class="sidebarName">
                          <span>게시판</span>
                        </li><br>
                    
                        <li class="nav-item">
                            <a href="#" class="nav-link middleName">
                              <i class="nav-icon far-2xl fa-solid fa-check"></i>
                              <p>사내공지</p>
                            </a>
                        </li>

                        <li class="nav-item">
                          <a href="#" class="nav-link middleName">
                            <i class="nav-icon far fa-solid fa-user-group"></i>
                            <p>
                                부서게시판
                                <i class="fas fa-angle-left right" ></i>
                            </p>
                          </a>

                          <ul class="nav nav-treeview" style="padding-left: 20px;">
                              <a href="#" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>개발1팀 게시판</p>
                              </a>
                              <a href="#" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>개발2팀 게시판</p>
                              </a>
                          </ul>

                          <li class="nav-item">
                            <a href="#" class="nav-link middleName">
                              <i class="nav-icon far-2xl fa-solid fa-gear"></i>
                              <p>
                                  게시판 관리
                                  <i class="fas fa-angle-left right" ></i>
                              </p>
                            </a>
  
                            <ul class="nav nav-treeview" style="padding-left: 20px;">
                                <a href="#" class="nav-link">
                                  <i class="far fa-circle nav-icon"></i>
                                  <p style="padding-left: 5px;">임시저장</p>
                                </a>
                                <a href="#" class="nav-link">
                                  <i class="far fa-circle nav-icon"></i>
                                  <p style="padding-left: 5px;">휴지통</p>
                                </a>
                                <a href="#" class="nav-link">
                                  <i class="far fa-circle nav-icon"></i>
                                  <p style="padding-left: 5px;">게시판 만들기</p>
                                </a>
                            </ul>
                        </li>
                      </li>  
                    </nav>
                    <!-- /.sidebar-menu -->
                    </div>
                    <!-- /.sidebar -->
                </aside>
                <!--사이드바 끝-->
            </div>
            <div class="LinkFlowMainContent">
                
                    <!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">게시판</h1>
                            </div>
                        
                        </div>
                    <!-- /.container-fluid -->
                    
                    </section>
                   
                    <!-- Main content -->
                    <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;"> 
                      <div class="contentArea">

                        <div class="contentInElement">
                          <div class="btnArea">
                            <ul class="navbar-nav">
                              <li class="nav-item dropdown" style="display: flex; flex-direction: row;"> 
                                <a class="nav-link btn btn-lg btn-secondary readUser" data-toggle="dropdown" href="#" style="width: 70px;"><i class="fa-solid fa-book fa-lg"></i></a>
                                <a href="" style="padding: 10px 0 0 10px;"><i class="fa-solid fa-gear fa-2xl"></i></a>

                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left movePage">
                                    <div class="bk-table">
                                      <div class="card">
                                          <div class="card-header">
                                              <h3 class="card-title">게시판 이용자</h3>
                                          </div>
                                          <!-- /.card-header -->
                                          <div class="card-body table-responsive p-0" style="height: 300px;">
                                              <table class="table table-head-fixed text-nowrap">
                                                  <thead>
                                                      <tr>
                                                          <th style="width:50px; text-align: center;">부서</th>
                                                          <th style="width:50px;">직급</th>
                                                          <th style="width:200px; text-align: center;">이름</th>
                                                      </tr>
                                                  </thead>
                                                  <tbody>
                                                      <tr>
                                                          <td>개발1부서</td>
                                                          <td>대리</td>
                                                          <td style="text-align: center;">조성모</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                      <tr>
                                                        <td>개발1부서</td>
                                                        <td>대리</td>
                                                        <td style="width:200px; text-align: center;">이름</td>
                                                      </tr>
                                                  </tbody>
                                              </table>
                                          </div>
                                    </div>
                                </div>
                              </li>
                            </ul>
                          </div>
                          <div class="form-inline">
                            <div class="input-group">
                              <div class="select" style="margin-right: 15px;">
                                <select name="" id="bottom-menu" class="form-control bottom-menu" style="width: 120px;">
                                  <option value="all">작성자</option>
                                  <option value="wait">제목</option>
                                  <option value="complete">내용</option>
                                </select>
                              </div>
                              <input class="form-control form-control-sidebar" type="search" placeholder="검색하기" aria-label="Search">
                              <div class="input-group-append">
                                <button class="btn btn-primary">
                                  <i class="fas fa-search fa-fw"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div style=" min-height: 500px; min-width: 100%;">
                          <div class="card">
                            <div class="card-body table-responsive p-0">
                                <table class="table table-hover text-nowrap" style="text-align: center;">
                                  <thead>
                                    <tr>
                                      <th>No</th>
                                      <th>분류</th>
                                      <th style="width: 450px;">제목</th>
                                      <th>작성자</th>
                                      <th>작성일</th>
                                      <th>조회수</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                    <tr>
                                      <th>1</th>
                                      <th>공지</th>
                                      <th>내부 고발합니다</th>
                                      <th>김과장</th>
                                      <th>2024-04-05</th>
                                      <th>0</th>
                                    </tr>
                                  </tbody>
                                </table>
                                <hr style="margin-top: 0px;">
                                <div class="pagination" style="display: flex; justify-content: center;">
                                  <ul class="pagination">
                                    <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
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
        </div>
    </div>
</body>
</html>