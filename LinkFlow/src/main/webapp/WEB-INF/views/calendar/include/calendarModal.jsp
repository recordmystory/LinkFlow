<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendarModal</title>
<style>
 /*휴지통 상세 정보 모달 스타일*/
 
    /*휴지통 스타일*/
    
   .blue-button{
    background-color: rgba(5, 93, 209, 0.903) !important; 
    border: rgba(5, 93, 209, 0.903); 
    
   }
   
   .gray-button{
    background-color: gray !important; 
    border: gray;
    
   }
   
   .blue-button, .gray-button{
    display: flex;
    text-align: center;
    justify-content: center;
    color:white !important; 
   }
     .bin_list_table td, .bin_list_table th{
      text-align: center;
      vertical-align: middle;
      font-size: small;
    }
     .dataTables_filter {
      float: right;
      margin-bottom: 5px;
    }


    /*공유캘린더 목록 모달창 스타일*/
    #shareCalMoreModal-body{
      margin: 30px;
      max-width: 500px;
      max-height: 500px;
    }

    .dataTables_info{
      font-size: small;
      justify-content: center;
      text-align: center;

    }
    
    .pagination{
      margin-top: 10px;
      justify-content: center;
      text-align: center;
      display: flex;
    }

    .schInsertModal_content_text{
      width: 320px;
      height: 100px;
      min-width: auto;
      min-height: auto;
      border: 2px solid rgba(201, 203, 212, 0.722);
      border-radius: 5px;
    }
    

    .form-select{
      border: 2px solid rgba(201, 203, 212, 0.722);
      border-radius: 5px;
      color: rgb(89, 88, 88);
      width: 120px;
      height: 28px;
      margin-left: 13px;
    }

    .schInsertModalTitle {
      border: none;
      text-align: center;
      outline: none; 
      font-size: large;
    }

    .schInsertModalTitle:hover {
      border: none; /* 호버 시 테두리 제거 */
    }

    /*일정공유 스타일*/
    .schShareBtn{
      margin-top: 10px;
      font-size: small;
      font-weight: bold;
      color:  rgba(89, 88, 88, 0.774);
    }

    /*공유 일정, 공유 캘린더 스타일 */
    /*결제선 설정 모달 내에 스타일 */
     .btnArea{
    
    margin-left: 20px;
    width: 50px;
    height: 500px;

    }
    .downArea i{
    cursor: pointer;
    margin: 15px;
    }
    .downArea{
    display: flex;
    flex-direction: column;
    margin: auto;
    margin-top: 150px;
    }
    .singArea{
    margin-left: 20px;
    
    }
    .searchUser{
        display: flex;
        margin: auto;
    }

    .modal-title{
      font-size:120%;
    }



   </style>

</style>
</head>
<body>
	 <!-- 일정 상세 정보 모달 schDetailModal start -->
      <div class="modal fade" id="schDetailModal" tabindex="-1" aria-labelledby="schDetailModal" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
          <div class="modal-content">
              <div class="modal-header justify-content-center">                 
                <h5 class="modal-title font-weight-bolder" id="schDetailTitle">개발2팀 회식</h5>
              </div>
              <div class="modal-body">
                  <div>
                    <div class="schDetailModal_content justify-content-end mx-1">
                      중요일정&nbsp;
                      <input type="checkbox" class="weste-modal" id="recipient-name">
                    </div>
                   </div>
                   <div class="schDetailModal_content font-weight-bolder">
                        <label for="recipient-name" class="col-form-label">캘린더</label>
                        <div style="padding-right: 35px;">부서 캘린더</div> 
                    </div>
                    <div class="schDetailModal_content"> 
                      <label for="recipient-name" class="col-form-label">일정</label> 
                      <div>2024/04/26&nbsp; 오전 9:30 ~ 오전 10:00</div> 
                    </div>
                    <!--조건 걸어야함-->
                    <div class="schDetailModal_content">
                      <label for="recipient-name" class="col-form-label">장소</label>
                      <div class="search">
                        <div>서울시 서초구 방배동 939-949</div>
                        <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                      </div>                          
                    </div>
                    <!---->
                    <div class="schDetailModal_content">
                      <label for="recipient-name" class="col-form-label">알림</label>
                      <div>
                        30분 전 메일발송
                        <input type="checkbox" class="weste-modal" id="recipient-name" style="display: none;"> 
                      </div>
                    </div>
                    <div class="schDetailModal_content">
                      <label for="message-text" class="col-form-label">내용</label>
                      <div id="schDetailModal_content_text"> 
                            서울시 서초구 방배동 939-949에 있는
                          '떡봉솥뚜껑닭볶음탕찾아주셔서서감사
                            합니다' 에서 부서 전체 회식
                      </div>
                    </div>
                </div>
            <div class="modal-footer justify-content-center">
                <button type="button" class="blue-button btn schDetailModal_blueBtn" data-toggle="modal" data-target="#schUpdateModal">수정</button>
								<button type="button" class="gray-button btn schDetailModal_grayBtn" data-toggle="modal" data-target="#detailBtn">삭제</button>
            </div>
        </div>
      </div>
  </div>
    <!--일정 상세 정보 모달 schDetailModal end-->
	
	<!--상세 정보 모달_버튼 모달 detailBtn start-->
    <div class="modal fade" id="detailBtn" style="color: #5f7ea6;" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-body" id="detailBtn-modal-body" > 
          </div>
          <div class="modal-checkBtn">
            <i class="fa-solid fa-check fa-xl mb-5 mr-4"></i>
            <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" style="color: #bcbdbd;"></i>
          </div>
        </div>
      </div>
    </div>
    <!--상세 정보 모달_버튼 모달 detailBtn end-->
    
    <!--공유캘린더 더보기 클릭시 모달 shareCalMoreModal start-->
    <div class="modal fade" id="shareCalMoreModal" style="color: #5f7ea6;" aria-hidden="true" aria-labelledby="shareCalMoreModalLabel" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header ml-4" style="color: rgba(21, 21, 22, 0.658); font-weight: bold; font-size: medium;">
            <div>
              공유 캘린더
            </div>
            <button type="button" class="btn btn-primary btn-sm shareCalModalBtn" style="border-radius: 15px;" data-bs-target="#shareCalModal" data-bs-toggle="modal">
              <i class="fa-solid fa-plus fa-sm"></i>
            </button>
          </div>
          <div class="modal-body" id="shareCalMoreModal-body" > 
            <table id="example1" class="table table-bordered table-striped bin_list_table">
              <thead>
                <tr>
                  <th>No.</th>
                  <th>색상</th>
                  <th>공유자</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td style="width: 70px; padding: 15px 0px 0px 5px;">
                    <input type="checkbox" id="shareCheckbox1" class="calCheckbox shareCheckbox1" checked>
                    <label for="shareCheckbox1"></label>
                  </td>
                  <td>홍지우 팀장&lt;개발1팀&gt;</td>
                  <td class="shareCalMoreModal_btn d-flex justify-content-center">
                    <button type="button" class="btn btn-primary btn-sm gray-button shareCalMoreModal_graybtn">삭제</button>
                  </td>
                </tr>
               <tr>
                <td>2</td>
                <td style="width: 70px; padding: 15px 0px 0px 5px;">
                  <input type="checkbox" id="shareCheckbox2" class="calCheckbox shareCheckbox1" checked>
                  <label for="shareCheckbox2"></label>
                </td>
                <td>엄두강 사원&lt;개발2팀&gt;</td>
                <td class="shareCalMoreModal_btn d-flex justify-content-center">
                  <button type="button" class="btn btn-primary btn-sm gray-button shareCalMoreModal_graybtn" >삭제</button>
                </td>
              </tr>
              <tr>
                <td>3</td>
                <td style="width: 70px; padding: 15px 0px 0px 5px;">
                  <input type="checkbox" id="shareCheckbox3" class="calCheckbox shareCheckbox1" checked>
                  <label for="shareCheckbox3"></label>
                </td>
                <td>조성모 사원&lt;인사1팀&gt;</td>
                <td class="shareCalMoreModal_btn d-flex justify-content-center">
                  <button type="button" class="btn btn-primary btn-sm gray-button shareCalMoreModal_graybtn" >삭제</button>
                </td>
              </tr>
              <tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <!--공유캘린더 더보기 클릭시 모달 shareCalMoreModal end-->
    
    <!--일정 등록 모달-->
      <div class="modal fade" id="schInsertModal" tabindex="-1" aria-labelledby="schInsertModal" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
          <div class="modal-content">
              <div class="modal-header justify-content-center">                 
                <input type="text" class="schInsertModalTitle ml-4" placeholder="제목을 입력해주세요">
              </div>
               <div class="modal-body">
                    <div>
                      <div class="schDetailModal_content justify-content-end mx-1">
                        중요일정&nbsp;
                        <input type="checkbox" class="weste-modal" id="schImport">
                      </div>
                      <div class="schDetailModal_content font-weight-bolder">
                          <label for="recipient-name" class="col-form-label">캘린더</label>
                          <form method="" >
                            <div class="form-group mt-1">
                              <select class="form-select" id="calendarNo" name="calendar">
                                <option value="01" selected>개인 캘린더</option>
                                <option value="02">부서 캘린더</option>
                                <option value="03">회사 캘린더</option>
                              </select>
                            </div>
                      </div>
                      <div class="schDetailModal_content"> 
                        <label for="recipient-name" class="col-form-label">일정</label> 
                          <div class="dateInput col-sm-5 text-sm">
                            <label for="taskId" class="col-form-label">시작 날짜</label>
                            <input type="date" class="form-select" id="startDate" name="calendar_start_date">
                        
                            <label for="taskId" class="col-form-label">종료 날짜</label>
                            <input type="date" class="form-select" id="endDate" name="calendar_end_date">
                          </div>
                      </div>
                      <!--조건 걸어야함-->
                      <div class="schDetailModal_content">
                        <label for="recipient-name" class="col-form-label">장소</label>
                        <div class="search mt-1">
                          <input id="address" type="text" >
                      	  <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                   		  </div>                          
                      </div>
                      <!---->
                      <div class="schDetailModal_content">
                        <label for="recipient-name" class="col-form-label">알림</label>
                        <div>
                          30분 전 메일발송
                          <input type="checkbox" class="weste-modal" id="notifyYn">
                        </div>
                      </div>
                      <div class="schDetailModal_content">
                        <label for="message-text" class="col-form-label">내용</label>
                        <textarea id="schContent" class="schInsertModal_content_text mt-2"></textarea>
                      </div>
                    </div>
                    <div class="schDetailModal_content justify-content-start text-sm">
                      <button type="button" class="btn schShareBtn" data-bs-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</button>
                    </div>
              </div>
              <div class="modal-footer justify-content-center">
                  <button type="button" id="schInsertButton" class="btn blue-button">등록</button>
                  <button type="button" class="btn gray-button">취소</button>
              </div>
          </div>
        </div>
    </div>
    <!--일정 등록 모달 end-->
    
    <!--일정 수정 모달 start-->
    <div class="modal fade" id="schUpdateModal" tabindex="-1" aria-labelledby="schUpdateModal" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
          <div class="modal-content">
              <div class="modal-header justify-content-center">                 
                <input type="text" class="schInsertModalTitle ml-4" placeholder="제목을 입력해주세요">
              </div>
               <div class="modal-body">
                    <div>
                      <div class="schDetailModal_content justify-content-end mx-1">
                        중요일정&nbsp;
                        <input type="checkbox" class="weste-modal" id="recipient-name">
                      </div>
                      <div class="schDetailModal_content font-weight-bolder">
                          <label for="recipient-name" class="col-form-label">캘린더</label>
                          <form method="" >
                            <div class="form-group mt-1">
                              <select class="form-select" id="calendar" name="calendar">
                                <option value="" selected>개인 캘린더</option>
                                <option value="">부서 캘린더</option>
                                <option value="">회사 캘린더</option>
                              </select>
                            </div>
                      </div>
                      <div class="schDetailModal_content"> 
                        <label for="recipient-name" class="col-form-label">일정</label> 
                          <div class="dateInput col-sm-5 text-sm">
                            <label for="taskId" class="col-form-label ">시작 날짜</label>
                            <input type="date" class="form-select" id="calendar_start_date" name="calendar_start_date">
                        
                            <label for="taskId" class="col-form-label">종료 날짜</label>
                            <input type="date" class="form-select" id="calendar_end_date" name="calendar_end_date">
                          </div>
                      </div>
                      <!--조건 걸어야함-->
                      <div class="schDetailModal_content">
                        <label for="recipient-name" class="col-form-label">장소</label>
                        <div class="search mt-1">
                          <div>서울시 서초구 방배동 939-949</div>
                          <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                        </div>                          
                      </div>
                      <!---->
                      <div class="schDetailModal_content">
                        <label for="recipient-name" class="col-form-label">알림</label>
                        <div>
                          30분 전 메일발송
                          <input type="checkbox" class="weste-modal" id="recipient-name">
                        </div>
                      </div>
                      <div class="schDetailModal_content">
                        <label for="message-text" class="col-form-label">내용</label>
                        <textarea class="schInsertModal_content_text mt-2"></textarea>
                      </div>
                    </div>
                    <div class="schDetailModal_content justify-content-start text-sm">
                      <button type="button" class="btn schShareBtn" data-bs-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</button>
                    </div>
              </div>
              <div class="modal-footer justify-content-center">
                  <button type="button" class="btn blue-button">등록</button>
                  <button type="button" class="btn gray-button"">취소</button>
              </div>
          </div>
        </div>
    </div>
    <!--일정 수정 모달 end-->
    
    <!--공유 일정 모달 start-->
    <div class="modal fade" id="schShareModal" tabindex="-1" aria-labelledby="schShareModal" aria-hidden="true">
      <div class="modal-dialog  modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content" style="min-width: 850px;">
          <div class="modal-header">
            <h4 class="modal-title">일정 공유</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="row" style="min-width: 850px;">
                <div class="card-body">
  
                    <form action="xxxxxxx" method="post">
                     <div class="searchUser">
                       
                      <div class="form-check form-check-inline text-align-center ml-5">
                         <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                         <label class="form-check-label" for="inlineRadio1">이름, 아이디</label>
                     </div>
                     <div class="form-check form-check-inline">
                         <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                         <label class="form-check-label" for="inlineRadio2">조직</label>
                     </div>

                       <div class="col-md-3" style="margin-top: 15px;">
                         <div class="form-group">
                           <div class="input-group">
                            <input type="search" class="form-control" value="" name="useName">
                              <div class="input-group-append">
                                   <button type="submit" class="btn btn-primary">
                                       <i class="fa fa-search"></i>
                                   </button>
                               </div>
                           </div>
                         </div>
                       </div>
                     </form>

                     </div><!--searchUser 끝-->

                     <div class="row">
                      <div class="card card-default card-info" style="width: 250px; height: 400px; margin-left: 45px; margin-right: 20px;">
                        <div class="card-header">
                          <h5 class="card-title">사원설정</h5>
                        </div>
                         
                         <div class="card-body text-nowrap overflow-auto">
                         
                           <div id="kt_docs_jstree_basic">
                             <ul>
                                 <li data-jstree='{ "type" : "buiding" }'>
                                     LinkFlow
                                     <ul>
                                         <li data-jstree='{ "type" : "group" }'>
                                             경영지원부서
                                             <ul>
                                                 <li data-jstree='{ "selected" : false }'>
                                                     경영지원팀
                                                     <ul>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김경영 대리
                                                         </li>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김가렌 사원
                                                         </li>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김지우 사원
                                                         </li>
                                                     </ul>
                                                 </li>
                                                 <li data-jstree='{ "selected" : false }'>
                                                     개발부서
                                                     <ul>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김개발 대리
                                                         </li>
                                                         
                                                     </ul>
                                                 </li>
                                             </ul>
                                         </li>
                                     </ul>
                                 </li>
                                 
                             </ul>
                            
                           </div><!--jstree 끝-->
                           
                         </div>
                       </div>

                       <div class="card card-info" style="width: 180px; height: 400px;">
                        <div class="card-header">
                           <h3 class="card-title">
                              결재자 선택
                           </h3>

                         </div>
                         <div class="card-body text-nowrap overflow-auto resultNameArea">
                          
                         
                         </div>
                       </div>
                       
                       <div class="btnArea">
                        <div class="downArea" >
                           <i class="fa-solid fa-angles-right referenceIn"></i>
                           <i class="fa-solid fa-angles-left referenceOut"></i>
                         </div>
                       </div>
                       
                       <div class="column singArea">
                       

                       <div class="card card-info mr-3" style="width: 180px; height: 200px; margin-top: 100px;">
                        <div class="card-header">
                          <h5 class="card-title">조회 권한</h5>
                          
                         </div>
                         <div class="card-body referenceArea overflow-auto">

                         </div>
                       </div>
                       </div>


                     </div>
                 </div>
                 <!-- /.card-body -->
            
              </div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
              <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveData">설정하기</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
    <!-- /.modal -->
    <!--공유 일정 모달 end-->
    
    <!--공유 캘린더 모달 start-->
    <div class="modal fade" id="shareCalModal" tabindex="-1" aria-labelledby="schShareModal" aria-hidden="true">
      <div class="modal-dialog  modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content" style="min-width: 850px;">
          <div class="modal-header">
            <h4 class="modal-title">캘린더 공유</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="row" style="min-width: 850px;">
                <div class="card-body">
  
                    <form action="xxxxxxx" method="post">
                      <div class="selectCal" style="margin-right: 550px;">
                        <label for="recipient-name" class="col-form-label mx-1">캘린더</label>
                          <select class="form-select" id="calendar" name="calendar">
                              <option value="" selected>개인 캘린더</option>
                              <option value="">부서 캘린더</option>
                              <option value="">회사 캘린더</option>
                          </select>
                      </div>
                      <div class="selectCal" style="margin-right: 550px;">
                        <label for="recipient-name" class="col-form-label mx-1">색상</label>
                          <select class="form-select" id="calendar" name="calendar">
                              <option value="" selected>개인 캘린더</option>
                              <option value="">부서 캘린더</option>
                              <option value="">회사 캘린더</option>
                          </select>
                      </div>
                     <div class="searchUser">
                      <div class="form-check form-check-inline text-align-center ml-5">
                         <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                         <label class="form-check-label" for="inlineRadio1">이름, 아이디</label>
                     </div>
                     <div class="form-check form-check-inline">
                         <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                         <label class="form-check-label" for="inlineRadio2">조직</label>
                     </div>

                       <div class="col-md-3" style="margin-top: 15px;">
                         <div class="form-group">
                           <div class="input-group">
                            <input type="search" class="form-control" value="" name="useName">
                              <div class="input-group-append">
                                   <button type="submit" class="btn btn-primary">
                                       <i class="fa fa-search"></i>
                                   </button>
                               </div>
                           </div>
                         </div>
                       </div>
                     </form>

                     </div><!--searchUser 끝-->

                     <div class="row">
                      <div class="card card-default card-info" style="width: 250px; height: 400px; margin-left: 45px; margin-right: 20px;">
                        <div class="card-header">
                          <h5 class="card-title">사원설정</h5>
                        </div>
                         
                         <div class="card-body text-nowrap overflow-auto">
                         
                           <div id="kt_docs_jstree_shareCal">
                             <ul>
                                 <li data-jstree='{ "type" : "buiding" }'>
                                     LinkFlow
                                     <ul>
                                         <li data-jstree='{ "type" : "group" }'>
                                             경영지원부서
                                             <ul>
                                                 <li data-jstree='{ "selected" : false }'>
                                                     경영지원팀
                                                     <ul>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김경영 대리
                                                         </li>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김가렌 사원
                                                         </li>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김지우 사원
                                                         </li>
                                                     </ul>
                                                 </li>
                                                 <li data-jstree='{ "selected" : false }'>
                                                     개발부서
                                                     <ul>
                                                         <li data-jstree='{ "type" : "person" }'>
                                                             김개발 대리
                                                         </li>
                                                         
                                                     </ul>
                                                 </li>
                                             </ul>
                                         </li>
                                     </ul>
                                 </li>
                                 
                             </ul>
                            
                           </div><!--jstree 끝-->
                           
                         </div>
                       </div>

                       <div class="card card-info" style="width: 180px; height: 400px;">
                        <div class="card-header">
                           <h3 class="card-title">
                              결재자 선택
                           </h3>

                         </div>
                         <div class="card-body text-nowrap overflow-auto resultNameArea">
                          
                         
                         </div>
                       </div>
                       
                       <div class="btnArea">
                        <div class="downArea" >
                           <i class="fa-solid fa-angles-right referenceIn"></i>
                           <i class="fa-solid fa-angles-left referenceOut"></i>
                         </div>
                       </div>
                       
                       <div class="column singArea">
                       

                       <div class="card card-info mr-3" style="width: 180px; height: 200px; margin-top: 100px;">
                        <div class="card-header">
                          <h5 class="card-title">조회 권한</h5>
                          
                         </div>
                         <div class="card-body referenceArea overflow-auto">

                         </div>
                       </div>
                       </div>


                     </div>
                 </div>
                 <!-- /.card-body -->
            
              </div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
              <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveData">설정하기</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
    <!-- /.modal -->
    <!--공유 캘린더 모달 end-->
    
    <!------휴지통 모달------------------------------------------------  -->
              <!-- 일정 상세 정보 모달 start -->
        <div class="modal fade" id="schDetailModal" tabindex="-1" aria-labelledby="schDetailModal" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
              <div class="modal-content">
                  <div class="modal-header justify-content-center">
                      <h5 class="modal-title font-weight-bolder" id="schDetailTitle">개발2팀 회식</h5>
                  </div>
                  <div class="modal-body">
                      <div>
                          <div class="schDetailModal_content justify-content-end mx-1">
                            중요일정&nbsp;
                            <input type="checkbox" class="weste-modal" id="recipient-name">
                          </div>
                          <div class="schDetailModal_content font-weight-bolder">
                              <label for="recipient-name" class="col-form-label">캘린더</label>
                              <p style="padding-right: 30px;">부서 캘린더</p> 
                          </div>
                          <div class="schDetailModal_content"> 
                            <label for="recipient-name" class="col-form-label">일정</label> 
                            <p>2024/04/26&nbsp; 오전 9:30 ~ 오전 10:00</p> 
                          </div>
                          <!--조건 걸어야함-->
                          <div class="schDetailModal_content">
                            <label for="recipient-name" class="col-form-label">장소</label>
                            <div class="search">
                              <div>서울시 서초구 방배동 939-949</div>
                              <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                            </div>                          
                          </div>
                          <!---->
                          <div class="schDetailModal_content">
                            <label for="recipient-name" class="col-form-label">알림</label>
                            <p>
                              30분 전 메일발송
                              <input type="checkbox" class="weste-modal" id="recipient-name">
                            </p>
                          </div>
                          <div class="schDetailModal_content">
                            <label for="message-text" class="col-form-label">내용</label>
                            <p id="schDetailModal_content_text"> 
                                 서울시 서초구 방배동 939-949에 있는
                                '떡봉솥뚜껑닭볶음탕찾아주셔서서감사
                                 합니다' 에서 부서 전체 회식
                            </p>
                          </div>
                       </div>
                  </div>
                  <div class="modal-footer justify-content-center">
                      <button type="button" class="btn blue-button" data-bs-target="#detailBtn" data-bs-toggle="modal" style="color: white;">복구</button>
                      <button type="button" class="btn gray-button" data-bs-target="#detailBtn" data-bs-toggle="modal" style="color: white;">삭제</button>
                  </div>
              </div>
            </div>
        </div>
        <!--일정 상세 정보 모달 end-->
        <!--상세 정보 모달_버튼 모달 start-->
        <div class="modal fade" id="detailBtn" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
              <div class="modal-body" id="detailBtn-modal-body" > 
              </div>
              <div class="modal-checkBtn">
                <i class="fa-solid fa-check fa-xl mb-5 mr-4" style="color: #055dd1;"></i>
                <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" style="color: #bcbdbd;"></i>
              </div>
            </div>
          </div>
        </div>
        <!--상세 정보 모달_버튼 모달 ends-->
    
</body>
</html>