<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사관리</title>
	<style type="text/css">
   .HRArea{
        width: 50%;
        margin-top: 15px;
      }
 
	</style>
 <!-- 다음 주소 API-->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
  <!-- daterange picker -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/daterangepicker/daterangepicker.css">
  <!-- iCheck for checkboxes and radio inputs -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Bootstrap Color Picker -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- Select2 -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <!-- Bootstrap4 Duallistbox -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
  <!-- BS Stepper -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/bs-stepper/css/bs-stepper.min.css">
  <!-- dropzonejs -->
  <link rel="stylesheet" href="${contextPath }/resources/htmlTemplate/plugins/dropzone/min/dropzone.min.css">

	
</head>
<body>
	<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/hr/hrSidebar.jsp"/>

        <div class="LinkFlowMainContent" style="padding: 30px;">
        	<!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">구성원 정보 변경</h1>
                            </div>
                        
                        </div>
                    <!-- /.container-fluid -->
                    
                    </section>
                   
                    <!-- Main content -->
                    <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;"> 
                      <div class="contentArea">
                           

                            <div class="HRArea">
                              
                                  <div class="row">
                                    <div class="col-12">
                                     
                                        <div class="card card-primary">
                                            <div class="card-header">
                                            <h3 class="card-title">사원 정보 변경</h3>
                                
                                            
                                            </div>
                                            <!-- /.card-header -->
                                            <form action="${contextPath}/hr/updateInfoMember.do" method="post" id="insertMember">
                                            <div class="card-body">
                                            <div class="">
                                           		 <div class="col-md-6">
                                                <label>아이디</label>
                                                <div class="input-group">
                                                    
                                                    <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="userId" id="userId" value="${m.userId}" readonly="readonly">
                                                    
                                                </div>
                                                
                                                <br>

                                                </div>
                                                
                                                <input type="hidden" name="regId" value="${loginUser.userId }">
                                                <input type="hidden" name="modId" value="${loginUser.userId }">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>성함</label>
                                                    <input type="text" class="form-control" required placeholder="성함을 입력하세요" name="userName" value="${m.userName}">   
                                                    </div>   
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>연락처</label>
                                                    <input id="phone" type="text"  name="phone" class="form-control" required placeholder="연락처를 입력하세요" value="${m.phone}">   
                                                    <span style="font-size: 15px; color: red;" id="alretArea"></span>
                                                    </div>   
                                                </div>
																								<script>
																								$(document).ready(function(){
																					        	    $("#phone").on("input", function(e){
																					        	        let phoneVal = $("#phone").val().trim().replace(/-/g, ''); 
																					        	        let phonelength = phoneVal.length;
																					        	        console.log(phonelength);

																					        	        if(!/^[0-9]+$/.test(phoneVal)){
																					        	            $("#alretArea").text("숫자만 입력해주세요.");
																					        	        } else {
																					        	          
																					        	            if (phonelength >= 4 && phonelength <= 7) {
																					        	                phoneVal = phoneVal.substring(0, 3) + '-' + phoneVal.substring(3);
																					        	            } else if (phonelength > 7) {
																					        	                phoneVal = phoneVal.substring(0, 3) + '-' + phoneVal.substring(3, 7) + '-' + phoneVal.substring(7);
																					        	            }
																					        	            $("#phone").val(phoneVal);

																					        	            if (phonelength != 11){
																					        	                $("#alretArea").text("올바른 번호를 입력해주세요.");
																					        	            } else if(phonelength == 11) {
																					        	                $("#alretArea").text("");
																					        	            }
																					        	        }
																					        	    });
																					        	});
																								
																								</script>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>입사일</label>
                                                    <input type="date" name="hireDate" class="form-control" required value="${m.hireDate}">   
                                                    </div>   
                                                </div>
                                                

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>생년월일</label>
                                                    <input type="date"  name="birthDate" class="form-control" required value="${m.birthDate}">   
                                                    </div>   
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>연차</label>
                                                    <input type="number"  name="dayOff" class="form-control" required value="${m.dayOff}">   
                                                    </div>   
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>부서</label>
                                                        <select class="form-control select2" style="width: 100%;" required name="deptCode">
																													 <c:forEach var="dList" items="${dList}">
																													 <option value="${dList.deptCode}" ${dList.deptCode == m.deptCode ? 'selected' : ''}>
																														${dList.deptTitle}
																													</option> 
																													</c:forEach>
                                                        </select>
                                                </div>
                                                </div>
                                                

                                                <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>직책</label>
                                                    <select class="form-control select2" style="width: 100%;" required name="rankScode">
                                                      <c:forEach var="cList" items="${cList}">
																									        <option value="${cList.subCode }" ${cList.subCode == m.subCode ? 'selected':''}>
																									        ${cList.subName}
																									        </option>
																									    </c:forEach>
	                                                    </select>
                                                </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>최종학력</label>
                                                        <select class="form-control select2" style="width: 100%;" required name="education">
                                                            <option value="박사" ${m.education == '박사' ? 'selected' : ''}>박사</option>
																								            <option value="석사" ${m.education == '석사' ? 'selected' : ''}>석사</option>
																								            <option value="대졸" ${m.education == '대졸' ? 'selected' : ''}>대졸</option>
																								            <option value="고졸" ${m.education == '고졸' ? 'selected' : ''}>고졸</option>
                                                        </select>
                                                </div>
                                                </div>
                                                <!-- /.col -->
                                                <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>접근 권한</label>
                                                    <select class="select2" multiple data-placeholder="권한을 선택하세요" style="width: 100%;" name="right">
                                                        <option value="1" ${m.superRight == 'Y' ? 'selected' : ''}>슈퍼관리자</option>
                                                        <option value="2" ${m.hrRight == 'Y' ? 'selected' : ''}>인사관리</option>
                                                        <option value="3" ${m.spRight == 'Y' ? 'selected' : ''}>경영관리</option>
                                                        <option value="4" ${m.boardRight == 'Y' ? 'selected' : ''}>게시판관리</option>
                                                        <option value="5" ${m.deptRight == 'Y' ? 'selected' : ''}>부서관리</option>
                                                        
                                                    </select>
                                                </div>
                                               
                                                </div>
                                                
                                                <div class="col-md-6">
                                                  <div class="form-group">
                                                  <label>성별</label>
                                                   &nbsp;&nbsp;
                                                  
                                                  <input type="radio" name="gender" id="Male" value="남" ${m.gender == '남' ? 'checked' : ''}>
                                                  <label for="Male">남자</label> &nbsp;&nbsp;
                                                  <input type="radio" name="gender" id="Female" value="여" ${m.gender == '여' ? 'checked' : ''}>
                                                  <label for="Female">여자</label><br>
                                                  </div>   
                                                </div>


                                                <div class="col-md-6">
                                                    <label>주소</label>
                                                    <div class="input-group input-group">
                                                        
                                                        <input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="zipCode" value="${m.zipCode}">
                                                        <span class="input-group-append">
                                                          <button type="button" class="btn btn-primary btn-flat" onclick="sample6_execDaumPostcode()">주소 찾기</button>
                                                        </span>
                                                    </div><br>
    
                                                    <input class="form-control" type="text" id="sample6_address" placeholder="주소" name="address" value="${m.address}" required><br>
                                                    <input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목"><br>
                                                    <input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소"  name="detailAdd" value="${m.detailAdd}" required>
                                                </div>
                                               
                                                <!-- /.col -->
                                                <br>
                                                 <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>올해 지각횟수</label>
                                                    <input type="number"  name="" class="form-control" readonly="readonly" value="${m.yearlateCount}">   
                                                    </div>   
                                                </div>
                                                
                                                 <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>올해 결근횟수</label>
                                                    <input type="number"  name="" class="form-control" readonly="readonly" value="${m.yearAbsentCount}">   
                                                    </div>   
                                                </div>
                                                
                                                 <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>총 근무일수</label>
                                                    <input type="number"  name="" class="form-control" readonly="readonly" value="${m.yearWalktime}">   
                                                    </div>   
                                                </div>
                                                
                                            </div>
                                            <!-- /.row -->
                                
                                            
                                            
                                            </div>
                                            <!-- /.card-body -->
                                            <div class="card-footer">
                                                <button type="submit" class="btn btn-primary"  id="goPass">변경하기</button>
                                                
                                                <c:choose>
                                                	<c:when test="${m.delYN == 'N'}">
                                                	<a href="" class="btn btn-danger float-right" style="margin-left: 10px;" data-toggle="modal" data-target="#modal-goRetire" id="goButton">퇴사처리</a>
                                                	</c:when>
                                                	<c:otherwise>
                                                	<a href="" class="btn btn-info float-right" style="margin-left: 10px;" data-toggle="modal" data-target="#modal-goJoinPathy" id="goButton">재직처리</a>
                                                	</c:otherwise>
                                                </c:choose>
                                                
                                                
                                                
                                                <a href="" class="btn btn-warning float-right" style="margin-left: 10px;" data-toggle="modal" data-target="#modal-pass">비밀번호 초기화</a>
                                                <a href="${contextPath}/hr/hrPage" class="btn btn-default float-right" style="margin-left: 10px;">변경취소</a>
                                               
                                            </div>
                                            </form> 
                                        </div>
                                    		
                                        <!-- /.card -->
                                

                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                    	<div class="col-12">
	                                      <!-- Default box -->
	                                      <div class="card-primary">
	                                        <div class="card-header">
	                                          <h3 class="card-title">사원 변경 도움말</h3>
	                          
	                                        
	                                        </div>
	                                        <div class="card-body">
	                                          비밀번호 초기화 시 비밀번호 초기값은 'linkflow123@' 입니다. 사용자에게 전달 부탁드립니다. 
	                                          
	                                          
	                                        </div>
	                                        <!-- /.card-body -->
	                                    
	                                        <!-- /.card-footer-->
	                                      </div>
	                                      <!-- /.card -->
	                                    </div>
	                                  </div>
                                    

                                </div><!--HRArea 끝-->
                    

                                
                        </div><!-- /.card -->     
                                
                        </div> <!-- /.content-wrapper -->
                        </section>
					                
					 				 
					        </div>
					        
					        
					        		<!-- 퇴사처리 확인 모달 -->
											<div class="modal fade" id="modal-goRetire">
											    <div class="modal-dialog">
											        <div class="modal-content">
											            <div class="modal-header">
											                <h4 class="modal-title">사원 퇴사</h4>
											                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											                    <span aria-hidden="true">&times;</span>
											                </button>
											            </div>
											            
											            <div class="modal-body">
											                <p>${m.userName}님을 퇴사 처리 하시겠습니까?</p>
											                <p>해당 사원의 퇴사 처리를 원하시면 하단의 퇴사 버튼을 눌러주세요.</p> 
											            </div>
											            <div class="modal-footer">
											                <button type="button" class="btn btn-danger left" data-dismiss="modal" id="goRetire">퇴사</button>
											            </div>
											        </div>
											    </div>
											</div>

											<script>
											    $(document).ready(function() {
											        $("#modal-goRetire").on("click", "#goRetire", function() {
											            var userId = $("#userId").val();  
											            $.ajax({
											                url: "${contextPath}/hr/goRetire",
											                method: "POST", 
											                data: { userId: userId }, 
											                success: function(result) {
											                    if(result === "YYYYY") {
											                        alert("퇴사처리가 성공적으로 되었습니다.");
											                        $("#goButton")
											                            .text("재직처리")
											                            .removeClass("btn-danger")
											                            .addClass("btn-info")
											                            .attr("data-target", "#modal-goJoinPathy");
											                    } else if(result === "NNNNN") {
											                        alert("서버 오류로 인해 퇴사처리에 실패했습니다.");
											                    }
											                },
											                error: function(xhr, status, error) {
											                    console.error(xhr.responseText);
											                }
											            });
											        });
											    });
											</script>
                      
                      <!-- 재직처리 확인 모달 -->
                      <div class="modal fade" id="modal-goJoinPathy">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h4 class="modal-title">사원 재직</h4>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            
                            <div class="modal-body">
                              <p>${m.userName}님을 재직 처리 하시겠습니까?<p>
                              <P>해당 사원의 재직,재입사 처리를 원하시면 하단의 재직 버튼을 눌러주세요.</P> 
                               
                              	
                            </div>
                            <div class="modal-footer">
                              <button type="button" onclick="" class="btn btn-info left" data-dismiss="modal" id="goJoinPathy">재직</button>
                              
                            </div>
                         
                          </div>
                          <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                      </div>
                      <!-- /.modal -->
                      <script>
											    $(document).ready(function() {
											        $("#modal-goJoinPathy").on("click", "#goJoinPathy", function() {
											            var userId = $("#userId").val();  
											            $.ajax({
											                url: "${contextPath}/hr/goJoinPathy",
											                method: "POST", 
											                data: { userId: userId }, 
											                success: function(result) {
											                    if(result === "YYYYY") {
											                        alert("재입사 처리가 성공적으로 되었습니다.");
											                        $("#goButton")
											                            .text("퇴사처리")
											                            .removeClass("btn-info")
											                            .addClass("btn-danger")
											                            .attr("data-target", "#modal-goRetire");
											                    } else if(result === "NNNNN") {
											                        alert("서버 오류로 인해 재입사 처리에 실패했습니다.");
											                    }
											                },
											                error: function(xhr, status, error) {
											                    console.error(xhr.responseText);
											                }
											            });
											        });
											    });
											</script>
                      
                      
                      
                      <div class="modal fade" id="modal-pass">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h4 class="modal-title">비밀번호 초기화</h4>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            
                            <div class="modal-body">
                              <p>비밀번호를 초기화를 진행하면 초기 비밀번호'linkflow123@'으로 초기화 됩니다.<p>
                              <P>해당 사원의 비밀번호 초기화를 원하시면 하단의 변경하기 버튼을 눌러주세요.</P> 
                               
                              	
                            </div>
                            <div class="modal-footer">
                              <button type="button" onclick="" class="btn btn-warning left" data-dismiss="modal" id="goPassword">초기화 하기</button>
                              
                            </div>
                         
                          </div>
                          <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                      </div>
                      <!-- /.modal -->
                      
   
			</div>
   </div><!--전체영역 끝-->
	   
				
				
				
				
				
				<script>
			    $(document).ready(function(){
			      
			        $("#modal-pass").on("click", "#goPassword", function(){
			        		var userId = $("#userId").val();  
			        	
			            $.ajax({
			                url: "${contextPath}/hr/changePassword",
			                method: "POST", 
			                data: { userId : userId }, 
			                success: function(result){
			                	 
			                	if(result === "YYYYY"){
			                		 alert("초기화에 성공하였습니다!");
			                	}	 
			                	else if(result === "NNNNN"){
			                		 alert("서버 오류로 인해 비밀번호 초기화에 실패했습니다.");
			                	}
			                },
			                error: function(xhr, status, error){
			                    
			                   
			                    console.error(xhr.responseText);
			                }
			            });
			        });
			    });
			</script>
			<script>
    function sample6_execDaumPostcode() {
              new daum.Postcode({
                  oncomplete: function(data) {
                      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
      
                      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                      var addr = ''; // 주소 변수
                      var extraAddr = ''; // 참고항목 변수
      
                      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                          addr = data.roadAddress;
                      } else { // 사용자가 지번 주소를 선택했을 경우(J)
                          addr = data.jibunAddress;
                      }
      
                      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                      if(data.userSelectedType === 'R'){
                          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                              extraAddr += data.bname;
                          }
                          // 건물명이 있고, 공동주택일 경우 추가한다.
                          if(data.buildingName !== '' && data.apartment === 'Y'){
                              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                          }
                          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                          if(extraAddr !== ''){
                              extraAddr = ' (' + extraAddr + ')';
                          }
                          // 조합된 참고항목을 해당 필드에 넣는다.
                          document.getElementById("sample6_extraAddress").value = extraAddr;
                      
                      } else {
                          document.getElementById("sample6_extraAddress").value = '';
                      }
      
                      // 우편번호와 주소 정보를 해당 필드에 넣는다.
                      document.getElementById('sample6_postcode').value = data.zonecode;
                      document.getElementById("sample6_address").value = addr;
                      // 커서를 상세주소 필드로 이동한다.
                      document.getElementById("sample6_detailAddress").focus();
                  }
              }).open();
          }


</script>
   <!-- Select2 -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/select2/js/select2.full.min.js"></script>
	<!-- Bootstrap4 Duallistbox -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
	<!-- InputMask -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/moment/moment.min.js"></script>
	<script src="${contextPath }/resources/htmlTemplate/plugins/inputmask/jquery.inputmask.min.js"></script>
	<!-- date-range-picker -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap color picker -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Bootstrap Switch -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
	<!-- BS-Stepper -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/bs-stepper/js/bs-stepper.min.js"></script>
	<!-- dropzonejs -->
	<script src="${contextPath }/resources/htmlTemplate/plugins/dropzone/min/dropzone.min.js"></script>
	<!-- AdminLTE App -->


<script>
  $(function () {
    //Initialize Select2 Elements
    $('.select2').select2()

    //Initialize Select2 Elements
    $('.select2bs4').select2({
      theme: 'bootstrap4'
    })

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
    //Money Euro
    $('[data-mask]').inputmask()

    //Date picker
    $('#reservationdate').datetimepicker({
        format: 'L'
    });

    //Date and time picker
    $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });

    //Date range picker
    $('#reservation').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        format: 'MM/DD/YYYY hh:mm A'
      }
    })
    //Date range as a button
    $('#daterange-btn').daterangepicker(
      {
        ranges   : {
          'Today'       : [moment(), moment()],
          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment().subtract(29, 'days'),
        endDate  : moment()
      },
      function (start, end) {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
      }
    )

    //Timepicker
    $('#timepicker').datetimepicker({
      format: 'LT'
    })

    //Bootstrap Duallistbox
    $('.duallistbox').bootstrapDualListbox()

    //Colorpicker
    $('.my-colorpicker1').colorpicker()
    //color picker with addon
    $('.my-colorpicker2').colorpicker()

    $('.my-colorpicker2').on('colorpickerChange', function(event) {
      $('.my-colorpicker2 .fa-square').css('color', event.color.toString());
    })

    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    })

  })
  // BS-Stepper Init
  document.addEventListener('DOMContentLoaded', function () {
    window.stepper = new Stepper(document.querySelector('.bs-stepper'))
  })

  // DropzoneJS Demo Code Start
  Dropzone.autoDiscover = false

  // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
  var previewNode = document.querySelector("#template")
  previewNode.id = ""
  var previewTemplate = previewNode.parentNode.innerHTML
  previewNode.parentNode.removeChild(previewNode)

  var myDropzone = new Dropzone(document.body, { // Make the whole body a dropzone
    url: "/target-url", // Set the url
    thumbnailWidth: 80,
    thumbnailHeight: 80,
    parallelUploads: 20,
    previewTemplate: previewTemplate,
    autoQueue: false, // Make sure the files aren't queued until manually added
    previewsContainer: "#previews", // Define the container to display the previews
    clickable: ".fileinput-button" // Define the element that should be used as click trigger to select files.
  })

  myDropzone.on("addedfile", function(file) {
    // Hookup the start button
    file.previewElement.querySelector(".start").onclick = function() { myDropzone.enqueueFile(file) }
  })

  // Update the total progress bar
  myDropzone.on("totaluploadprogress", function(progress) {
    document.querySelector("#total-progress .progress-bar").style.width = progress + "%"
  })

  myDropzone.on("sending", function(file) {
    // Show the total progress bar when upload starts
    document.querySelector("#total-progress").style.opacity = "1"
    // And disable the start button
    file.previewElement.querySelector(".start").setAttribute("disabled", "disabled")
  })

  // Hide the total progress bar when nothing's uploading anymore
  myDropzone.on("queuecomplete", function(progress) {
    document.querySelector("#total-progress").style.opacity = "0"
  })

  // Setup the buttons for all transfers
  // The "add files" button doesn't need to be setup because the config
  // `clickable` has already been specified.
  document.querySelector("#actions .start").onclick = function() {
    myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED))
  }
  document.querySelector("#actions .cancel").onclick = function() {
    myDropzone.removeAllFiles(true)
  }
  // DropzoneJS Demo Code End


</script>

</body>
</html>