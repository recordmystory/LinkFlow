<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendarModal</title>
<!-- 지도 api -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dffz3x1msk&submodules=geocoder"></script>
	
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
  .contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
  .contentArea{ 
   width: 100%;
  }
  
  .dmovePage .slimMenu {
     padding: .0rem 0rem;
   }
    /*여기까지 메인 영역 요소  공용 스타일임 */
     .bin_list_table td, .bin_list_table th{
      text-align: center;
      vertical-align: middle;
      font-size: small;
    }
     .dataTables_filter {
      float: right;
      margin-bottom: 5px;
    }
    
    /*상세 모달 스타일 */
    .schDetailModal_content, .modal-content{
      display: flex;
      text-align: center;
      margin: 0px 0px 20px 10px;
    }

    .modal-title{
      margin-left: 20px;
      display: flex;
      text-align: center;
      justify-content: center;
    }
    
    #schDetailModal_content_text{
      max-width: 300px;
    
    }

    #detailBtn-modal-body, #schWasteDetail-modal-body, #schWasteRemoval-modal-body{
      font-size: large;
      font-weight: bolder;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      height: 350px;
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
</head>
<body>
	 <!-- 일정 상세 정보 모달 schDetailModal start -->
      <div class="modal fade" id="schDetailModal" tabindex="-1" aria-labelledby="schDetailModal" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
          <div class="modal-content">
              <div class="modal-header justify-content-center">                 
                <h5 class="modal-title font-weight-bolder" id="schDetailTitle"></h5>
              </div>
              <div class="modal-body">
                  <div>
                    <div class="schDetailModal_content justify-content-end mx-1">
                      중요일정&nbsp;
                      <input type="checkbox" class="weste-modal" id="schImport" style="pointer-events: none;">
                    </div>
                   </div>
                   <div class="schDetailModal_content font-weight-bolder">
                        <label for="recipient-name" class="col-form-label">캘린더</label>
                        <div style="padding-right: 35px;" id="schCalSubCode"></div> 
                    </div>
                    <div class="schDetailModal_content"> 
                      <label for="recipient-name" class="col-form-label">일정</label> 
                      <div>
	                      <spen id="startDate"></spen> 
	                      <spen id="endDate"></spen> 
	                     </div>
                      
                    </div>
                    <!--조건 걸어야함-->
                    <div class="schDetailModal_content">
                      <label for="recipient-name" class="col-form-label">장소</label>
                      <div class="search">
                        <div id="address"></div>
                        <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                      </div>                          
                    </div>
                    <!---->
                    <div class="schDetailModal_content">
                      <label for="recipient-name" class="col-form-label" >알림</label>
                      <div>
                       종료 30분 전 메일발송
                        <input type="checkbox" class="weste-modal" id="notifyYn" style="pointer-events: none; "> 
                      </div>
                    </div>
                    <div class="schDetailModal_content">
                      <label for="message-text" class="col-form-label">내용</label>
                      <div id="schDetailModal_content_text">                            
                      </div>
                    </div>
                </div>
                <input type="hidden" name="schNo" id="schNo">
            <div class="modal-footer justify-content-center">
                <button type="button" class="blue-button btn schDetailModal_blueBtn" data-toggle="modal" data-target="#schUpdateModal">수정</button>
								<button type="button" class="gray-button btn schDetailModal_grayBtn" data-toggle="modal" data-target="#detailBtn">삭제</button>
            </div>
        </div>
      </div>
  </div>
    <!--일정 상세 정보 모달 schDetailModal end-->
	
	<!--상세 정보 모달_버튼 모달 detailBtn start-->
    <div class="modal fade" id="detailBtn" style="color:#5f7ea6;" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-body" id="detailBtn-modal-body" > 
          </div>
          <div class="modal-checkBtn">
            <i class="fa-solid fa-check fa-xl mb-5 mr-4" id="schDeleteBtn"></i>
            <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" id="schDeleteCancelBtn" style="color: #bcbdbd;"></i>
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
    
	<!-- 일정 등록 모달 -->
		<div class="modal fade" id="schInsertModal" tabindex="-1" aria-labelledby="schInsertModal" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		        <div class="modal-content">
		            <div class="modal-body">
		                <form id="scheduleForm">
		                    <!-- 일정 제목 -->
		                    <div class="modal-header justify-content-center">
		                        <input type="text" class="form-control schInsertModalTitle ml-4" name="schTitle" placeholder="제목을 입력해주세요" required >
		                    		<div id="output-box"></div>
		                    		
		                    </div>
		                    <!-- 중요일정 체크박스 -->
		                    <div class="schDetailModal_content justify-content-end mx-1">
		                        중요일정&nbsp;
		                        <input type="checkbox" class="weste-modal" id="schImportInsertBtn" name="schImport">
		                    </div>
		                    <!-- 캘린더 선택 -->
		                    <div class="schDetailModal_content font-weight-bolder">
		                        <label for="calendarNo" class="col-form-label">캘린더</label>
		                        <div class="form-group mt-1">
		                          <select class="form-select" name="schCalSubCode">
                                <option value="03" selected>개인 캘린더</option>
                                <c:if test="${loginUser.deptRight == 'Y'}">
                                    <option value="02">부서 캘린더</option>
                                </c:if>
                                <c:if test="${loginUser.spRight == 'Y'}">
                                    <option value="01">전사 캘린더</option>
                                </c:if>
                            	</select>
		                        </div>    
		                    </div>
		                    <!-- 시작 날짜와 종료 날짜 -->
		                    <div class="schDetailModal_content">
												    <label for="startDate" class="col-form-label" style="width:32px;">일정 </label>
												    <div class="dateInput text-sm">
												        <label for="startDate" class="col-form-label" >시작</label>
												        <input type="datetime-local" class="form-select" name="startDate" style="width: 170px; text-align: center;" required><br>
												        <div id="output-box"></div>
												        
												        <label for="endDate" class="col-form-label">종료</label>
												        <input type="datetime-local" class="form-select" name="endDate" style="width: 170px; text-align: center;" required>
												        <div id="output-box"></div>
												        
												    </div>
												</div>
		                    <!-- 장소 -->
		                    <div class="schDetailModal_content">
		                        <label for="address" class="col-form-label">장소</label>
		                        <div class="search mt-1">
		                            <input type="text" name="address" class="form-select" style="width:320px; font-size: small; margin-left: 30px;">
   														  <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>		                        
   												  </div>
		                    </div>
		                    <!-- 알림 설정 -->
		                    <div class="schDetailModal_content">
		                        <label for="notifyYn" class="col-form-label" >알림</label> 
		                        <div>
		                           종료 30분 전 메일발송
		                            <input type="checkbox" class="weste-modal" name="notifyYn" id="notifyInsertBtn">
		                        </div>
		                    </div>
		                    <!-- 일정 내용 -->
		                    <div class="schDetailModal_content">
		                        <label for="schContent" class="col-form-label">내용</label>
		                        <textarea class="schInsertModal_content_text mt-2" name="schContent" style="margin-left:67px; " required ></textarea>
		                        <div id="output-box"></div>
		                    </div>
		                    <div class="schDetailModal_content justify-content-start text-sm">
                     		 <button type="button" class="btn schShareBtn" data-bs-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</button>
                       </div>
		                    <!-- 수정자 아이디 -->
		                   <input type="hidden" name="modId" id="modId">
		                </form>
		            </div>
		            <div class="modal-footer justify-content-center">
		                <button type="button" id="schInsertButton" class="btn blue-button" >등록</button>
		                <button type="button" class="btn gray-button" id="cencelBtn">취소</button>
		            </div>
		            
		        </div>
		    </div>
		</div>
		<!-- 일정 등록 모달 끝 -->

    
    <!--일정 수정 모달 start-->
    <div class="modal fade" id="schUpdateModal" tabindex="-1" aria-labelledby="schUpdateModal" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		        <div class="modal-content">
		            <div class="modal-body">
		                <form id="scheduleForm">
		                    <!-- 일정 제목 -->
		                    <div class="modal-header justify-content-center">
		                        <input type="text" class="form-control schInsertModalTitle ml-4" name="schTitle" id="schTitle" placeholder="제목을 입력해주세요" required >
		                    </div>
		                    <!-- 중요일정 체크박스 -->
		                    <div class="schDetailModal_content justify-content-end mx-1">
		                        중요일정&nbsp;
		                        <input type="checkbox" class="weste-modal" id="schImport" name="schImport">
		                    </div>
		                    <!-- 캘린더 선택 -->
		                    <div class="schDetailModal_content font-weight-bolder">
		                        <label for="calendarNo" class="col-form-label">캘린더</label>
		                        <div class="form-group mt-1">
		                           <select class="form-select" name="schCalSubCode">
                                <option value="03" selected>개인 캘린더</option>
                                <c:if test="${loginUser.deptRight == 'Y'}">
                                    <option value="02">부서 캘린더</option>
                                </c:if>
                                <c:if test="${loginUser.spRight == 'Y'}">
                                    <option value="01">전사 캘린더</option>
                                </c:if>
                            	</select>
		                        </div>    
		                    </div>
		                    <!-- 시작 날짜와 종료 날짜 -->
		                    <div class="schDetailModal_content">
												    <label for="startDate" class="col-form-label" style="width:32px;">일정 </label>
												    <div class="dateInput text-sm">
												        <label for="startDate" class="col-form-label" >시작</label>
												        <input type="datetime-local" class="form-select" name="startDate" id="startDate" style="width: 170px; text-align: center;" required><br>
												        <label for="endDate" class="col-form-label">종료</label>
												        <input type="datetime-local" class="form-select" name="endDate" id="endDate" style="width: 170px; text-align: center;" required>
												    </div>
												</div>
		                    <!-- 장소 -->
		                    <div class="schDetailModal_content">
		                        <label for="address" class="col-form-label">장소</label>
		                        <div class="search mt-1">
		                            <input type="text" name="address" id="address" class="form-select" style="width:320px; font-size: small; margin-left: 30px;">
   															<div id="map" style="width:300px; height:200px; margin-top:30px;"></div>		                       
		                    		</div>
		                    </div>
		                    <!-- 알림 설정 -->
		                    <div class="schDetailModal_content">
		                        <label for="notifyYn" class="col-form-label" >알림</label> 
		                        <div>
		                           종료 30분 전 메일발송
		                            <input type="checkbox" class="weste-modal" name="notifyYn" id="notifyYN">
		                        </div>
		                    </div>
		                    <!-- 일정 내용 -->
		                    <div class="schDetailModal_content">
		                        <label for="schContent" class="col-form-label">내용</label>
		                        <textarea class="schInsertModal_content_text mt-2" name="schContent" id="schContent" style="margin-left:67px; " required ></textarea>
		                    </div>
		                    <div class="schDetailModal_content justify-content-start text-sm">
                     		 <button type="button" class="btn schShareBtn" data-bs-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</button>
                       </div>
                       <input type="hidden" name="schNo" id="schNo">
                       <input type="hidden" name="calNo" id="calNo">                       
		                </form>
		            </div>
		            <div class="modal-footer justify-content-center">
		                <button type="button" id="schUpdateButton" class="btn blue-button">수정</button>
		                <button type="button" class="btn gray-button" id="schUpdateCancelBtn" >취소</button>

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
                                   <button type="button" class="btn btn-primary">
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
      <div class="modal fade" id="schWasteDetail" tabindex="-1" aria-labelledby="schDetailModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header justify-content-center">
                    <h5 class="modal-title font-weight-bolder" id="schWasteDetailTitle"></h5>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="schDetailModal_content justify-content-end mx-1">
                          중요일정&nbsp;
                          <input type="checkbox" class="weste-modal" id="schWasteImport" style="pointer-events: none;">
                        </div>
                        <div class="schDetailModal_content font-weight-bolder">
                            <label for="recipient-name" class="col-form-label" >캘린더</label>
                            <p style="padding-right: 30px;" id="wasteSubCode"></p> 
                        </div>
                        <div class="schDetailModal_content"> 
                          <label for="recipient-name" class="col-form-label" >일정</label> 
	                         <p class="wasteDate" >
			                      <span id="wasteStartDate"></span> 
			                      <span id="wasteEndDate"></span> 
		                     	 </p>
                   		  </div>
                        <!--조건 걸어야함-->
                        <div class="schDetailModal_content">
                          <label for="recipient-name" class="col-form-label">장소</label>
                         	<div class="search">
		                        <div id="wasteAddress"></div>
		                        <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                      		</div>                                                   
                        </div>
                        <!---->
                        <div class="schDetailModal_content">
                          <label for="recipient-name" class="col-form-label">알림</label>
                          <p>
                            30분 전 메일발송
                            <input type="checkbox" class="weste-modal" id="wasteNotifyYn" style="pointer-events: none; ">
                          </p>
                        </div>
                        <div class="schDetailModal_content">
                          <label for="message-text" class="col-form-label">내용</label>
                          <p id="schWasteDetail_content_text">    
                          </p>
                        </div>
                     </div>
                </div>
                 <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-primary btn-sm" id="restoreBtn" data-bs-target="#wasteDetailBtn" data-bs-toggle="modal" style="color: white; margin-left:30px;">복구</button>
                    <button type="button" class="btn btn-secondary btn-sm" id="removalBtn" data-bs-target="#wasteRemovalBtn" data-bs-toggle="modal" style="color: white;">삭제</button>
            		 </div>
            </div>
         </div>
      </div>
        
        <!--일정 상세 정보 모달 end-->
        <!--상세 정보 모달_버튼 모달 (복구) start-->
        <div class="modal fade" id="wasteDetailBtn" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
             	<div>	
             		<div class="modal-body" id="schWasteDetail-modal-body" > 
              	</div>
              </div>
              <div>         
	             	 <div class="modal-checkBtn">
	                <i class="fa-solid fa-check fa-xl mb-5 mr-4" id="schRestore" style="color: #055dd1;"></i>
	                <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" id="schCencelBtn" style="color: #bcbdbd;"></i>
	             	 </div>
           		 </div>
         		 </div>
        		</div>
        	</div>
        <!--상세 정보 모달_버튼 모달 ends-->
         <!--상세 정보 모달_버튼 모달 (삭제) start-->
        <div class="modal fade" id="wasteRemovalBtn" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
             	<div>	
             		<div class="modal-body" id="schWasteRemoval-modal-body" > 
              	</div>
              </div>
              <div>         
	             	 <div class="modal-checkBtn">
	                <i class="fa-solid fa-check fa-xl mb-5 mr-4" id="schComplete" style="color: #055dd1;"></i>
	                <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" id="schCencelBtn" style="color: #bcbdbd;"></i>
	             	 </div>
           		 </div>
         		 </div>
        		</div>
        	</div>
        <!--상세 정보 모달_버튼 모달 ends-->
        
    <script>

//공유일정 조직도 모달 schShareModal***********************************************
  $(document).ready(function(){
    //열기 
    $('.schShareBtn').click(function(){
      $('#schShareModal').modal('show');
      $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
    }); 
    //설정하기 버튼 클릭시
    //닫기 클릭시
  });

//캘린더 모달 end


//공유일정 조직도 script start***********************************************
$('#kt_docs_jstree_basic').jstree({
    "core" : {
        "themes" : {
            "responsive": false
        }
    },
    "types" : {
        "default" : {
            "icon" : "fa fa-folder"
        },
        "group" : {
            "icon" : "fa-solid fa-user-group"
        },
        "building" : {
            "icon" : "fa-solid fa-building"
        },
        "person" : {
            "icon" : "fa-solid fa-person"
        }
    },
    "plugins": ["types"]
}).on('select_node.jstree', function (e, data) {
    var node = data.node;
    
    if (node.type === "person") {
        var personName = node.text;
        
        var isExistingName = $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').length > 0;
        
        if (!isExistingName) {
            var html = '<div class="NameArea">' + personName +'<input type="checkBox"></div>';
            
            $('.resultNameArea').append(html);
        } else {
            $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').remove();
        }
    }
});


    
      document.querySelector('.referenceIn').addEventListener('click', function() {
    var nameAreas = document.querySelectorAll('.NameArea');
    
    nameAreas.forEach(function(nameArea) {
        var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
        if (checkbox) {
            var nameValue = nameArea.textContent.trim();
            
          
            var existingElement = document.querySelector('.referenceArea .referenceName');
            if (existingElement && existingElement.textContent.trim() === nameValue) {
                return; 
            }

            var referenceName = document.createElement('div');
            referenceName.className = 'referenceName';
            referenceName.textContent = nameValue;
            document.querySelector('.referenceArea').appendChild(referenceName);
            
            nameArea.remove();
            }
        });
    });

    document.querySelector('.referenceOut').addEventListener('click', function() {
          
          var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

          
          approvalNames.forEach(function(referenceName) {
              
              var nameValue = referenceName.textContent.trim();
              
              var resultNameArea = document.querySelector('.resultNameArea');
            
              var nameArea = document.createElement('div');
              nameArea.className = 'NameArea';
              nameArea.textContent = nameValue;
              
              var checkbox = document.createElement('input');
              checkbox.type = 'checkbox';
              nameArea.appendChild(checkbox);
              
              resultNameArea.appendChild(nameArea);
              
              referenceName.remove();
          });
      });

  
      document.getElementById('saveData').addEventListener('click', function() {
        var approvalName1Element = document.querySelector('.approvalName1');
        var approvalName2Element = document.querySelector('.approvalName2');

    
        var approvalName1Text = approvalName1Element ? approvalName1Element.textContent : '';
        var frtApprovalElement = document.querySelector('.frtApproval');
        frtApprovalElement.textContent = approvalName1Text;

        
        var approvalName2Text = approvalName2Element ? approvalName2Element.textContent : '';
        var scdApprovalElement = document.querySelector('.scdApproval');
        scdApprovalElement.textContent = approvalName2Text;

        var referenceNameElements = document.querySelectorAll('.referenceName');
        var textToInsert = '';

        referenceNameElements.forEach(function(referenceNameElement, index) {
            var text = referenceNameElement.textContent.trim();
            if (index > 0) {
                textToInsert += ', ';
            }
            textToInsert += text;
        });

        document.getElementById('refMember').value = textToInsert;
   });


//공유캘린더 조직도 end***********************************************
    
    
    //공유캘린더 사이드바 더보기 모달*******************************
      //공유캘린더 더보기 클릭시 목록 조회 모달
      $(document).ready(function() {
         //더보기 클릭시
          $('.shareCalMoreBtn').click(function() {
            $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
            $('#shareCalMoreModal').modal('show');
          }); 

         //삭제버튼 클릭시
         $('.shareCalMoreModal_graybtn').click(function() {
          $('#shareCalMoreModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>공유된 캘린더를 삭제하시겠습니까?</div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');
        });

          // shareCalMoreModal 닫힐 때
          $('#shareCalMoreModal').on('hidden.bs.modal', function(e) {
              $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            });

          //삭제버튼 닫을 때
          $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
          });
          
          //공유캘린더 조직도 모달 shareCalModalBtn
          //열기 
          $('.shareCalModalBtn').click(function(){
            $('#shareCalModal').modal('show');
            $('body').addClass('modal-open'); // 모달이 열릴 때 바디에 modal-open 클래스 추가
          }); 
          //설정하기 버튼 클릭시
          
          //닫기 클릭시
        });
     //공유캘린더 사이드바 더보기_조직도 script*******************************
//공유캘린더 start
    $('#kt_docs_jstree_shareCal').jstree({
      "core" : {
          "themes" : {
              "responsive": false
          }
      },
      "types" : {
          "default" : {
              "icon" : "fa fa-folder"
          },
          "group" : {
              "icon" : "fa-solid fa-user-group"
          },
          "building" : {
              "icon" : "fa-solid fa-building"
          },
          "person" : {
              "icon" : "fa-solid fa-person"
          }
      },
      "plugins": ["types"]
  }).on('select_node.jstree', function (e, data) {
      var node = data.node;
      
      if (node.type === "person") {
          var personName = node.text;
          
          var isExistingName = $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').length > 0;
          
          if (!isExistingName) {
              var html = '<div class="NameArea">' + personName +'<input type="checkBox"></div>';
              
              $('.resultNameArea').append(html);
          } else {
              $('.resultNameArea').find('.NameArea:contains("'+ personName +'")').remove();
          }
      }
  });

      
        document.querySelector('.referenceIn').addEventListener('click', function() {
      var nameAreas = document.querySelectorAll('.NameArea');
           
      nameAreas.forEach(function(nameArea) {
          var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
          if (checkbox) {
              var nameValue = nameArea.textContent.trim();
              
            
              var existingElement = document.querySelector('.referenceArea .referenceName');
              if (existingElement && existingElement.textContent.trim() === nameValue) {
                  return; 
              }

              var referenceName = document.createElement('div');
              referenceName.className = 'referenceName';
              referenceName.textContent = nameValue;
              document.querySelector('.referenceArea').appendChild(referenceName);
              
              nameArea.remove();
              }
          });
      });

      document.querySelector('.referenceOut').addEventListener('click', function() {
            
            var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

            
            approvalNames.forEach(function(referenceName) {
                
                var nameValue = referenceName.textContent.trim();
                
                var resultNameArea = document.querySelector('.resultNameArea');
              
                var nameArea = document.createElement('div');
                nameArea.className = 'NameArea';
                nameArea.textContent = nameValue;
                
                var checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                nameArea.appendChild(checkbox);
                
                resultNameArea.appendChild(nameArea);
                
                referenceName.remove();
            });
        });

    
        document.getElementById('saveData').addEventListener('click', function() {
          var approvalName1Element = document.querySelector('.approvalName1');
          var approvalName2Element = document.querySelector('.approvalName2');

      
          var approvalName1Text = approvalName1Element ? approvalName1Element.textContent : '';
          var frtApprovalElement = document.querySelector('.frtApproval');
          frtApprovalElement.textContent = approvalName1Text;

          
          var approvalName2Text = approvalName2Element ? approvalName2Element.textContent : '';
          var scdApprovalElement = document.querySelector('.scdApproval');
          scdApprovalElement.textContent = approvalName2Text;

          var referenceNameElements = document.querySelectorAll('.referenceName');
          var textToInsert = '';

          referenceNameElements.forEach(function(referenceNameElement, index) {
              var text = referenceNameElement.textContent.trim();
              if (index > 0) {
                  textToInsert += ', ';
              }
              textToInsert += text;
          });

          document.getElementById('refMember').value = textToInsert;
     }); 
//공유캘린더 end


 // 캘린더 등록하기 (schInsertModal)***********************************************
      //캘린더 일정등록 ajax
     			//일정등록 클릭시 모달 띄우기
     			 // 로그인 확인
    $(document).ready(function(){

     	    var mod = '${loginUser.userId}'; 
             $('input[name="modId"]').val(mod); 
     	
     	    // 일정 등록 버튼 클릭 시 모달 띄우기
     	    if (mod === '') {
     	        $('.schInsertModalBtn').click(function() {
     	            alert("일정을 등록하려면 로그인을 해 주세요.");
     	            window.location.href = "${contextPath }/member/loginout.me"; // 로그인 페이지 경로로 이동
     	        });
     	    } else {
     	        $('.schInsertModalBtn').click(function() {
     	            $('#schInsertModal').modal('show');
     	            $('body').addClass('modal-open'); 
     	        });
     	    }

     		  // 중요일정 체크박스 클릭 시 조건
     	    $('#schImportInsertBtn').click(function() {
     	        var important = $(this).is(':checked') ? 'Y' : 'N';
     	        $('input[name="schImport"]').val(important);
     	    });
     		  
     	    $('#notifyInsertBtn').click(function() {
     	        var notify = $(this).is(':checked') ? 'Y' : 'N';
     	        $('input[name="notifyYn"]').val(notify);
     	    });
     	    

         	//등록 ajax
        		 $('#schInsertButton').click(function() {
        		  // 날짜 비교 시간까지 비교
        		  var start = $('input[name="startDate"]').val();
             var end = $('input[name="endDate"]').val();
             if (start > end) {
                 alert("종료일이 시작일보다 작을 수 없습니다.");
                 return; 
             }
        	    	
             $.ajax({
                 type: "POST",
                 url: "${contextPath}/calendar/regist.do", 
                 data: $('#scheduleForm').serialize(),
                 success: function(result) {
                 	if (result === "success") {
                     // 성공-  모달 닫기
                     console.log("일정 등록이 성공했습니다.");
                     alert("일정 등록이 성공했습니다."); 
                     $("#schInsertModal").modal("hide");
                     
                     var calColor;
                     var schCalSubCode = $('select[name="schCalSubCode"]').val();
                     if (schCalSubCode === '03') {
                         calColor = '#358657c3';
                     } else if (schCalSubCode === '02') {
                         calColor = '#104fa1c3';
                     } else if (schCalSubCode === '01') {
                         calColor = '#a82626c3';
                     }
                     
                     var eventData = {
                         title: $('input[name="schTitle"]').val(),
                         start: $('input[name="startDate"]').val(),
                         end: $('input[name="endDate"]').val(),
                         color: calColor,
                         extendedProps: {
                             schTitle: $('input[name="schTitle"]').val(),
                             schImport: $('input[name="schImport"]').is(':checked') ? 'Y' : 'N',
                             schCalSubCode: schCalSubCode,
                             address: $('input[name="address"]').val(),
                             notifyYn: $('input[name="notifyYn"]').is(':checked') ? 'Y' : 'N',
                             schContent: $('textarea[name="schContent"]').val()
                         }
                     };
                     calendar.addEvent(eventData);
                     calendar.render();

                     $('#scheduleForm')[0].reset();
                 }
             },
                 error: function(result) {
                     // 요청이 실패했을 때 
                     console.error("일정 등록에 실패했습니다.");
                     alert("일정 등록에 실패했습니다.");

                 }
             });
         });
      //캘린더 일정등록 ajax end **************************************

   	    //schInsertModal 닫힐 때
   	    $('#schInsertModal').on('hidden.bs.modal', function(e) {
   	        $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
   	    }); 
   	    
   	  	//등록모달 -> 삭제버튼 클릭시
   	    $('#cencelBtn').click(function() {
          $('#schInsertModal').modal('hide');
      	}); 
    });
   	  	











 
  //네이버 지도 api start
    selectMapList();

//검색한 주소의 정보를 insertAddress 함수로 넘겨준다
      function searchAddressToCoordinate(address) {
        naver.maps.Service.geocode({
            query: address
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }
            if (response.v2.meta.totalCount === 0) {
                return alert('올바른 주소를 입력해주세요.');
            }
            var htmlAddresses = [],
                item = response.v2.addresses[0],
                point = new naver.maps.Point(item.x, item.y);
            if (item.roadAddress) {
                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
            }
            if (item.jibunAddress) {
                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
            }
            if (item.englishAddress) {
                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
            }

            insertAddress(item.roadAddress, item.x, item.y);
            
        });
      }

  //주소 검색의 이벤트
      $('#address').on('keydown', function(e) {
          var keyCode = e.which;
          if (keyCode === 13) { // Enter Key
              searchAddressToCoordinate($('#address').val());
          }
      });
      $('#submit').on('click', function(e) {
          e.preventDefault();
          searchAddressToCoordinate($('#address').val());
      });
      naver.maps.Event.once(map, 'init_stylemap', initGeocoder);


  //지도에 마커 찍기
      function insertAddress(latitude, longitude) {
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(longitude, latitude),
            zoom: 50,
            scaleControl: false,
            logoControl: false,
            mapDataControl: false,
            zoomControl: false,
            zoomControlOptions: {
              style: naver.maps.ZoomControlStyle.SMALL,
              position: naver.maps.Position.TOP_LEFT
            },
            mapTypeControl: false
        });
          var marker = new naver.maps.Marker({
              map: map,
              position: new naver.maps.LatLng(longitude, latitude),
          });
      }
  //지도를 그려주는 함수
      function selectMapList() {
        
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.3595704, 127.105399),
            zoom: 10
        });
      }


  // 지도를 이동하게 해주는 함수
      function moveMap(len, lat) {
        var mapOptions = {
              center: new naver.maps.LatLng(len, lat),
              zoom: 15
          };
          var map = new naver.maps.Map('map', mapOptions);
          var marker = new naver.maps.Marker({
              position: new naver.maps.LatLng(len, lat),
              map: map
          });
      }
//네이버 지도 api end
</script>
    
    
</body>
</html>