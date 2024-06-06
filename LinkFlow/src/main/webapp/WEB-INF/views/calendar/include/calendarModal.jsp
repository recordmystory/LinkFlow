<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow캘린더</title>

	
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

    }
    
    .pagination{
      margin-top: 10px;
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
                       <!--  <div id="map" style="width:300px; height:200px; margin-top:30px;"></div> -->
                      </div>                          
                    </div>

                    <div class="schDetailModal_content">
                      <label for="message-text" class="col-form-label">내용</label>
                      <div id="schDetailModal_content_text">                            
                      </div>
                    </div>
                </div>
                <input type="hidden" name="schNo" id="schNo">
                <input type="hidden" name="modId" id="modId">
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
   														 <!--  <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>		             -->           
   												  </div>
		                    </div>

		                    <!-- 일정 내용 -->
		                    <div class="schDetailModal_content">
		                        <label for="schContent" class="col-form-label">내용</label>
		                        <textarea class="schInsertModal_content_text mt-2" name="schContent" style="margin-left:67px; " required ></textarea>
		                        <div id="output-box"></div>
		                    </div>
		                    <div class="schDetailModal_content justify-content-start text-sm">
                     		 <a class="btn schShareBtn" data-bs-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</a>
                       </div>
		                    <!-- 수정자 아이디 -->
		                   <input type="hidden" name="modId" id="modId">
		                   <input type="hidden" name="shareIds" id="shareIds">
		                   
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
   															<!-- <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>		                        -->
		                    		</div>
		                    </div>
		                 
		                    <!-- 일정 내용 -->
		                    <div class="schDetailModal_content">
		                        <label for="schContent" class="col-form-label">내용</label>
		                        <textarea class="schInsertModal_content_text mt-2" name="schContent" id="schContent" style="margin-left:67px; " required ></textarea>
		                    </div>
		                    <div class="schDetailModal_content justify-content-start text-sm">
                     		 <a class="btn schShareBtn" data-target="#schShareModal" data-bs-toggle="modal">+ 일정공유</a>
                       </div>
                       <input type="hidden" name="schNo" id="schNo">
                       <input type="hidden" name="calNo" id="calNo">                       
		                   <input type="hidden" name="shareIds" id="shareIds">
		                
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
    <div class="modal fade" id="schShareModal">
      <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content" style="min-width: 1400px; text-align: initial !important;">
          <div class="modal-header">
            <h4 class="modal-title">일정 공유</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="row" style="min-width: 1400px;">
              <div class="card-body">

                   <div class="searchUser">

                     <div class="col-md-3" style="margin-top: 15px;">
                       <div class="form-group">
                         <div class="input-group" style="width: 800px;">
                             <input type="search" class="form-control" id="searchInput" placeholder="사원명이나 조직명으로 검색하세요" value="" name="useName">
                             <div class="input-group-append">
                       
                             </div>
                         </div>
                       </div>
                     </div>

                   </div><!--searchUser 끝-->

                   <div class="row">
                     <div class="card card-default card-info" style="width: 300px; height: 500px; margin-right: 20px;">
                       <div class="card-header">
                         <h5 class="card-title">사원 설정</h5>
                       </div>
                       
                       <div class="card-body text-nowrap overflow-auto">
                       
                         <div id="kt_docs_jstree_basic">
                           <ul>
                               <li data-jstree='{ "type" : "buiding" }'>
                                   LinkFlow
                                   <ul>
	                                   <c:forEach var="appr" items="${apprList}">
		                                   <li data-jstree='{ "selected" : false }'>
		                                   		${appr.deptTitle}
		                                   			<ul>
	                                         		<c:forEach var="apprPerson" items="${appr.memberList}" varStatus="status">
	                                         			<li data-jstree='{ "type" : "person" }' data-userid="${apprPerson.userId}">
	                                                 ${apprPerson.userName} ${apprPerson.subName}
	                                                 <input type="text" class="userId" value="${apprPerson.userId}" style="display: none;"/>
	                                                
	                                             </li>
	                                         		</c:forEach>
	                                         </ul>
		                                   </li>
	                                   </c:forEach>
                                    </ul>
                           </ul>
                               
                          
                         </div><!--jstree 끝-->
                         
                         
                       </div>
                     </div>

                     <div class="card card-info" style="width: 500px; height: 500px;">
                       <div class="card-header">
                         <h3 class="card-title">
                            직원 선택
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

                     <div class="card card-info" style="width: 400px;  height: 200px; margin-top: 100px;">
                       <div class="card-header">
                         <h5 class="card-title">조회 권한</h5>
                         
                        
                       </div>
                       <div class="card-body referenceArea overflow-auto">
                         <input type="hidden" value="" id="approvalUserId">
                       </div>
                     </div>
                     </div>


                   </div>
               </div>
               <!-- /.card-body -->
          
            </div>
          </div>
          <div class="modal-footer justify-content-center">
            <button type="button" class="btn btn-primary" id="saveData" data-dismiss="modal">확인</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
    <!--공유 일정 모달 end-->
    	
   
    
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
                      		</div>                                                   
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
	//공유일정 조직도 조회
    $('.schShareBtn').click(function(){
      $('#schShareModal').modal('show');
      $('body').addClass('modal-open'); 
    });  
    


//공유일정 조직도 script start***********************************************
  
    $('#saveData').click(function(){
    	referenceHiddenValues = [];

    	var $referAreaContent = '';
    	$('.referenceName').each(function(index) {
    	    var referenceNameHtml = $(this)
            .clone() 
            .find('input[type="checkbox"]') 
            .remove() 
            .end() 
            .find('.userId')
            .attr('name', 'edocRefList[' + index + '].userId') 
            .css('display', 'none') 
            .end() 
            .html(); 

        $referAreaContent += '<div class="referArea">' + referenceNameHtml + '</div>';
    	});
    	$('#refSelectedArea').html($referAreaContent);

    	
    	$('.referenceName').each(function() {
    	    var hiddenValue = $(this).attr('data-hidden-value');
    	    if (hiddenValue) {
    	         if ($(this).hasClass('referenceName')) {
    	            referenceHiddenValues.push(hiddenValue);
    	        }
    	    }
    	});
        
    });



          // 결재선 설정 모달 스크립트
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
        "plugins": ["types", "search"],
        "search" : {
        	"show_only_matches" : true,
        	"show_only_matches_children" : true,
        }
        
    }).on('select_node.jstree', function (e, data) {
    	var node = data.node;

        if (node.type === "person") {
            var personName = node.text;
            var userId = node.li_attr['data-userid']; 
           
           
            var existNameArea = $('.resultNameArea [data-userid="' + userId + '"]');
					
            if (existNameArea.length >0) { 
                existNameArea.remove(); 
            }else{

            var html = '<div class="NameArea" data-userid="' + userId + '">' + personName + '<input type="checkBox"></div>';
            $('.resultNameArea').append(html);
            }
        }
    });
		
   var to = false;
   $('#searchInput').keyup(function () {
       if(to) { clearTimeout(to); }
       to = setTimeout(function () {
           var v = $('#searchInput').val();
           $('#kt_docs_jstree_basic').jstree(true).search(v);
       }, 250);
   });
          
   

   function moveApprovalNames(approvalNames) {
       approvalNames.forEach(function(approvalName) {
           var checkbox = approvalName.querySelector('input[type="checkbox"]:checked');
           if (checkbox) {
               var nameText = approvalName.innerHTML.trim();

               var resultName = document.createElement('div');
               resultName.className = 'NameArea';
               resultName.innerHTML = nameText;

               var newCheckbox = document.createElement('input');
              

               document.querySelector('.resultNameArea').appendChild(resultName);

               approvalName.remove();
           }
       });
   }

           

   document.querySelector('.referenceIn').addEventListener('click', function() {
	    var shareIds = [];
	    var nameAreas = document.querySelectorAll('.NameArea');

	    nameAreas.forEach(function(nameArea) {
	        var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
	        if (checkbox) {
	            var userId = nameArea.getAttribute('data-userid');
	            shareIds.push(userId);
	            // 중복 확인 이미 있으면 못 넘어가게
	            var duplicate = false;
	            document.querySelectorAll('.referenceArea .referenceName').forEach(function(referenceName) {
	              if (referenceName.getAttribute('data-userid') === userId) {
	            	  duplicate = true;
	              }
	            });

	            if (!duplicate) { // 중복 확인
	              shareIds.push(userId);

	              var nameValue = nameArea.innerHTML.trim();
	              var referenceName = document.createElement('div');
	              referenceName.className = 'referenceName';
	              referenceName.setAttribute('data-userid', userId); // 추가된 부분
	              referenceName.innerHTML = nameValue;
	              document.querySelector('.referenceArea').appendChild(referenceName);

	              nameArea.remove();
	            }
	          }
	        });

	    document.getElementById('shareIds').value = shareIds.join(',');
	});

    document.querySelector('.referenceOut').addEventListener('click', function() {
        var approvalNames = document.querySelectorAll('.referenceArea .referenceName');

        approvalNames.forEach(function(referenceName) {
            var checkbox = referenceName.querySelector('input[type="checkbox"]:checked');
            if (checkbox) {
                var nameValue = referenceName.innerHTML.trim();

                var resultNameArea = document.querySelector('.resultNameArea');

                var nameArea = document.createElement('div');
                nameArea.className = 'NameArea';
                nameArea.innerHTML = nameValue;

                resultNameArea.appendChild(nameArea);

                referenceName.remove();
            }
        });
    });

 
  //공유일정 조직도 script END***********************************************


</script>
    
    
</body>
</html>