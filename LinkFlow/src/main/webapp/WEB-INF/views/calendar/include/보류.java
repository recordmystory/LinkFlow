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
	
	<!--공유 일정 모달 start-->
		<div class="modal fade" id="schShareModal" tabindex="-1" aria-labelledby="schShareModal" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
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
		                            </div>
		                        </form>
		                        <!--searchUser 끝-->
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
		                                        <div class="card-tools">
									                          
									                           <button type="button" class="btn btn-tool" >
									                             <i class="fa-solid fa-angles-down approvalDownBtn"></i>
									                           </button>
									                           <div class="card-body">
									                            <div class="referenceArea">
									                            
									                            </div>
									                           
									                           </div>
									                         </div>
		                                    </div>
		                                </div>
		                            </div>
		                           
		                        </div>
		                    </div>
		                </div>
		                <!-- /.card-body -->
		            </div>
		            <div class="modal-footer justify-content-between">
		                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		                <button type="button" class="btn btn-primary" id="saveData" data-dismiss="modal">설정하기</button>
		            </div>
		        </div>
		        <!-- /.modal-content -->
		    </div>
		    <!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<!--공유 일정 모달 end-->
    
   
    
    <!------휴지통 모달------------------------------------------------  -->
     
    <script>

 //공유일정 조직도 모달 schShareModal***********************************************
	//공유일정 조직도 조회
    $('.schShareBtn').click(function(){
      $('#schShareModal').modal('show');
      $('body').addClass('modal-open'); 
    });  
    


//공유일정 조직도 script start***********************************************
   //저장버튼 클릭시
    $('#saveData').click(function(){
    	approvalHiddenValues = [];
    	referenceHiddenValues = [];

    
    	var approvalName1Html = $('.approvalName1')
    	    .clone() 
    	    .find('input[type="checkbox"]') 
    	    .remove() 
    	    .end() 
    	    .find('.userId')
    	    .attr('name', 'edocHistList[1].userId') 
    	    .css('display', 'none') 
    	    .end() 
    	    .html(); 

    
    	$('#approvalSelectedArea1').html(approvalName1Html);

    	
    	var approvalName2Html = $('.approvalName2')
        .clone() 
        .find('.userId')
        .attr('name', 'edocHistList[2].userId') 
        .css('display', 'none') 
        .end() 
        .find('input[type="checkbox"]') 
        .remove() 
        .end() 
        .html(); 

    $('#approvalSelectedArea2').html(approvalName2Html);

    
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

    	
    	$('.approvalName1, .approvalName2, .referenceName').each(function() {
    	    var hiddenValue = $(this).attr('data-hidden-value');
    	    if (hiddenValue) {
    	        if ($(this).hasClass('approvalName1') || $(this).hasClass('approvalName2')) {
    	            approvalHiddenValues.push(hiddenValue);
    	        } else if ($(this).hasClass('referenceName')) {
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
		
	    $(document).ready(function(){
			$(".referenceIn").on("click", function(){
				debugger;
			      var nameAreas = document.querySelectorAll('.NameArea');
			      
			      nameAreas.forEach(function(nameArea) {
			          var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
			          if (checkbox) {
			              var nameValue = nameArea.innerHTML.trim();
			              
			            
			              var existingElement = document.querySelector('.referenceArea .referenceName');
			              if (existingElement && existingElement.textContent.trim() === nameValue) {
			                  return; 
			              }

			              var referenceName = document.createElement('div');
			              referenceName.className = 'referenceName';
			              referenceName.innerHTML = nameValue;
			              document.querySelector('.referenceArea').appendChild(referenceName);
			              
			              nameArea.remove();
			              }
			          });
			});
 });

  
	

//공유일정 조직도 end***********************************************
    
    /*
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
     */
//공유캘린더 start


 // 캘린더 등록하기 (schInsertModal)***********************************************
      //캘린더 일정등록 ajax
     			//일정등록 클릭시 모달 띄우기
     			 // 로그인 확인
    $(document).ready(function(){

     	    var mod = '${loginUser.userId}'; 
             $('input[name="modId"]').val(mod); 
     	
     	    // 일정 등록 버튼 클릭 시 모달 띄우기
     	    if (mod === '') {
     	            alert("일정을 등록하려면 로그인을 해 주세요.");
     	            window.location.href = "${contextPath }/member/loginout.me"; // 로그인 페이지 경로로 이동
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
	            var title = $('input[name="schTitle"]').val()
	            
	             if (title === '') {
	                 alert("제목을 입력하세요");
	                 event.preventDefault();
	                 return; 
	             } else if (start >= end) {
	                 alert("종료일이 시작일보다 같거나 작을 수 없습니다.");
	                 event.preventDefault();
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

</script>
    
    
</body>
</html>