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

        <jsp:include page="/WEB-INF/views/common/sidebar/hr/hrSidebar2.jsp"/>

        <div class="LinkFlowMainContent" style="padding: 30px;">
        	<!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">구성원 추가</h1>
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
                                     
                                        <div class="card card-info">
                                            <div class="card-header">
                                            <h3 class="card-title">사원 정보 등록</h3>
                                
                                            
                                            </div>
                                            <!-- /.card-header -->
                                            <form action="${contextPath}/hr/insertMember.do" method="post" id="insertMember">
                                            <div class="card-body">
                                            <div class="">
                                           		 <div class="col-md-6">
                                                <label>아이디</label>
                                                <div class="input-group input-group">
                                                    
                                                    <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="userId" id="userId">
                                                    <span class="input-group-append">
                                                      <button type="button" class="btn btn-primary btn-flat" onclick="checkId();">중복확인</button>
                                                    </span>
                                                </div>
                                                <div id="resultArea" style="font-size:15px"></div>
                                                <br>

                                                </div>
                                                <input type="hidden" name="userPwd" value="linkflow123@">
                                                <input type="hidden" name="regId" value="${loginUser.userId }">
                                                <input type="hidden" name="modId" value="${loginUser.userId }">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>성함</label>
                                                    <input type="text" class="form-control" required placeholder="성함을 입력하세요" name="userName">   
                                                    </div>   
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>연락처</label>
                                                    <input type="text"  name="phone" class="form-control" required placeholder="연락처를 입력하세요" >   
                                                    </div>   
                                                </div>
																								
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>입사일</label>
                                                    <input type="date" id="hireDateInput" name="hireDate" class="form-control" required >   
                                                    </div>   
                                                </div>
                                                <script>
                                                function setTodayDate() {
                                                    var today = new Date();
                                                    var dd = String(today.getDate()).padStart(2, '0');
                                                    var mm = String(today.getMonth() + 1).padStart(2, '0'); 
                                                    var yyyy = today.getFullYear();

                                                    today = yyyy + '-' + mm + '-' + dd;
                                                    return today;
                                                }


                                                window.onload = function() {
                                                   
                                                    document.getElementById('hireDateInput').value = setTodayDate();
                                                };
                                                </script>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    <label>생년월일</label>
                                                    <input type="date"  name="birthDate" class="form-control" required>   
                                                    </div>   
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>부서</label>
                                                        <select class="form-control select2" style="width: 100%;" required name="deptCode">
                                                         <c:forEach var="dList" items="${dList}">
																									        <option value="${dList.deptCode }">${dList.deptTitle}</option>
																									    	</c:forEach>
                                                        </select>
                                                </div>
                                                </div>
                                                

                                                <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>직책</label>
                                                    <select class="form-control select2" style="width: 100%;" required name="rankScode">
                                                      <c:forEach var="cList" items="${cList}">
																									        <option value="${cList.subCode }">${cList.subName}</option>
																									    </c:forEach>
	                                                    </select>
                                                </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>최종학력</label>
                                                        <select class="form-control select2" style="width: 100%;" required name="education">
                                                            <option value="박사">박사</option>
                                                            <option value="석사">석사</option>
                                                            <option value="대졸">대졸</option>
                                                            <option value="고졸">고졸</option>
                                                        </select>
                                                </div>
                                                </div>
                                                <!-- /.col -->
                                                <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>접근 권한</label>
                                                    <select class="select2" multiple data-placeholder="권한을 선택하세요" style="width: 100%;" name="right">
                                                        <option value="1">슈퍼관리자</option>
                                                        <option value="2">인사관리</option>
                                                        <option value="3">경영관리</option>
                                                        <option value="4">게시판관리</option>
                                                        <option value="5">부서관리</option>
                                                        
                                                    </select>
                                                </div>
                                               
                                                </div>
                                                
                                                <div class="col-md-6">
                                                  <div class="form-group">
                                                  <label>성별</label>
                                                   &nbsp;&nbsp;
                                                  <input type="radio" name="gender" id="Male" value="남">
                                                  <label for="Male">남자</label> &nbsp;&nbsp;
                                                  <input type="radio" name="gender" id="Female" value="여">
                                                  <label for="Female">여자</label><br>
                                                  </div>   
                                                </div>


                                                <div class="col-md-6">
                                                    <label>주소</label>
                                                    <div class="input-group input-group">
                                                        
                                                        <input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="zipCode" value="">
                                                        <span class="input-group-append">
                                                          <button type="button" class="btn btn-primary btn-flat" onclick="sample6_execDaumPostcode()">주소 찾기</button>
                                                        </span>
                                                    </div><br>
    
                                                    <input class="form-control" type="text" id="sample6_address" placeholder="주소" name="address" value="" required><br>
                                                    <input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목"><br>
                                                    <input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소"  name="detailAdd" value="" required>
                                                </div>
                                               
                                                <!-- /.col -->
                                            </div>
                                            <!-- /.row -->
                                
                                            
                                            
                                            </div>
                                            <!-- /.card-body -->
                                            <div class="card-footer">
                                                <button type="submit" class="btn btn-primary" disabled id="goPass">등록하기</button>
                                                <a href="${contextPath}/hr/hrPage" class="btn btn-default float-right" style="margin-left: 10px;">등록취소</a>
                                               
                                            </div>
                                            </form> 
                                        </div>
                                    	
                                        <!-- /.card -->
                                

                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                    	<div class="col-12">
	                                      <!-- Default box -->
	                                      <div class="card-info">
	                                        <div class="card-header">
	                                          <h3 class="card-title">사원 추가 도움말</h3>
	                          
	                                        
	                                        </div>
	                                        <div class="card-body">
	                                          사원 추가시 비밀번호 초기값은 'linkflow123@' 입니다. 사용자에게 전달 부탁드립니다. 
	                                          <br><br>
	                                          사원 등록후 연차는 기본적으로 12개 생성됩니다. 추후 협의를 통해 사원 변경페이지에서 추가 등록 부탁드립니다.
	                                          
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
      
   
		</div>
   </div><!--전체영역 끝-->
			<script>
				    
				       function checkId(){
				            var checkId = $('#userId').val(); 
				            
				           
				            
				            $.ajax({
				                url: '${contextPath}/hr/checkId', 
				                type: 'POST',
				              
				                data: {
				                	checkId: checkId,
				                   
				                },    
				                success: function(response) {
				                	
				                    if (response ==='YYYYY') {
				                        $('#resultArea').text('중복된 아이디가 없습니다'); 
				                        $('#goPass').prop('disabled', false); 
				                    } else if(response ==='NNNNN') {
				                        $('#resultArea').text('중복된 아이디가 있습니다. 다른 아이디로 시도해주세요'); 
				                        $('#goPass').prop('disabled', true); 
				                        
				                    }
				                },
				                error: function(xhr, status, error) {
				                    console.error('AJAX 오류');
				                }
				            });
				        };
				    
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