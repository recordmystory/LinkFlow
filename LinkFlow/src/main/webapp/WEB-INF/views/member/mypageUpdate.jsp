<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보 변경</title>
   <!--다음주소 API-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
.contentArea{ 
      width: 100%;
      display: contents;
}
 .myPageArea{
        width: 80%;
      }
</style>


</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="LinkFlowMainSection">

        <jsp:include page="/WEB-INF/views/common/sidebar/mypage/mypageSidebar2.jsp"/>

        <div class="LinkFlowMainContent">
        
 				  <!-- Content Header (Page header) -->
          <!-- Content Header (Page header) -->
                    <section class="content-header">
                            <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">사원 정보 변경</h1>
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
                            <div class="row">
                                <div class="col-12">
                                      
                              <!-- Profile Image -->
                              <form action="${contextPath}/member/updateInfo.do" method="post" enctype="multipart/form-data" id="profillArea">
                                <div class="card card-primary card-outline">
                                  <div class="card-body box-profile">
                                   <div class="text-center" style="margin-top: 50px;">
																		    <c:choose>
																		        <c:when test="${not empty loginUser.profileUrl}">
																		            <img class="profile-user-img img-fluid img-circle" id="profillArea"
																		                 src="${contextPath}${loginUser.profileUrl}"
																		                 alt="User profile picture" style="width: 300px; height: 300px;" onclick="$('#profileImgFile').click();">
																		                 <i class="fa-solid fa-circle-xmark fa-xl" id="deleteProfill"></i>
																		        </c:when>
																		        <c:otherwise>
																		            <img class="profile-user-img img-fluid img-circle" id="profillArea"
																		                 src="${contextPath}/resources/images/common/defaultProfile.png"
																		                 alt="User profile picture" style="width: 300px; height: 300px;" onclick="$('#profileImgFile').click();">
																		        </c:otherwise>
																		    </c:choose>
																		    <input type="file" class="file" id="profileImgFile" style="display:none;" accept="image/*" name="uploadFile">    
																		</div>
          
                                    <h3 class="profile-username text-center" style="margin-top: 30px;">${loginUser.userName}</h3>
          
                                    <p class="text-muted text-center">${loginUser.deptName}</p><br><br>
          
                                    
                                    <table class="table text-nowrap">
                                     
                                      <tbody>
                                        <tr> 
                                          <td>직책</td>
                                          <td class="text-right">${loginUser.position}</td>  
                                        </tr>
                                        <tr> 
                                          <td>휴대폰</td>
                                          <td class="text-right">
                                              <input type="text" class="form-control-border" value="${loginUser.phone}" class="text-right" id="phone" name="phone"><br>
                                              <span style="font-size: 15px; color: red;" id="alretArea"></span>
                                          
                                          </td>
                                          
                                        </tr>
                                        <tr> 
                                          <td>E-Mail</td>
                                          <td class="text-right">${loginUser.userId}@linkflow.com</td>  
                                        </tr>
                                        <tr> 
                                          <td>입사일</td>
                                          <td class="text-right">${loginUser.hireDate}</td>  
                               
                                        </tr>
                                        <tr> 
                                          <td>생년월일</td>
                                          <td class="text-right">${loginUser.birthDate}</td>  
                                        </tr>
                                        <tr> 
                                          <td>근속년수</td>
                                          <td class="text-right">${loginUser.serviceYear}년</td>  
                                        </tr>
                                        <tr> 
                                          <td>최종학력</td>
                                          <td class="text-right">${loginUser.education}</td>  
                                        </tr>
                                        <tr> 
                                          <td>주소</td>
                                          
                                          <td class="text-right">
                                           
                                              <div class="card card-primary">
                                              
                                                  <div class="card-body">
                                                    
                                                      <div class="col-12">
                                                  
                                                          <div class="input-group input-group">
                                                              <input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="zipCode" value="${loginUser.zipCode}">
                                                              <span class="input-group-append">
                                                                <button type="button" class="btn btn-primary btn-flat" onclick="sample6_execDaumPostcode()">주소 찾기</button>
                                                              </span>
                                                          </div><br>
          
                                                          <input class="form-control" type="text" id="sample6_address" placeholder="주소" name="address" value="${loginUser.address}"><br>
                                                          <input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목"><br>
                                                          <input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소" required name="detailAdd" value="${loginUser.detailAdd}">
                                                      </div>
                                                    			<input type="hidden" class="form-control-border" value="${loginUser.userId}" class="text-right" id="userId" name="userId">
                                                    			<input type="hidden" class="form-control-border" value="${loginUser.userPwd}" class="text-right" id="userId" name="userPwd">
                                                  </div>
                                          
                                          </td>
                                          
                                            
                                        </tr>
                                        <tr> 
                                          <td></td>
                                          <td class="text-right">
                                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">비밀번호 변경</button>
                                            <button type="submit" class="btn btn-primary">저장</button>
                                          
                                          </td>  
                                        </tr>
                                       </tbody> 
                                       </table>
                                       </form>
                                  </div>
                                  <!-- /.card-body -->
                                  </div>
                                </div>
                                <!-- /.card -->
          
          
          
          
          
                                  </div>




                        </div>


                      </div>
                        <!-- /.card-body -->
                        </div>
                      </div>
                      <!-- /.card -->
                      <div class="modal fade" id="modal-default">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h4 class="modal-title">비밀번호 확인</h4>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            
                            <div class="modal-body">
                              <p>본인 확인을 위해 비밀번호를 한번 더 입력해주세요.<p>
                                <input type="hidden" name="" value="${loginUser.userId}" id="userId">

                                
                                <input type="password" name="" class="form-control" id="userPwd"> 
                                <div id="resultArea"></div>
                              	
                            </div>
                            <div class="modal-footer">
                              <button type="button" onclick="location.href='${contextPath}/member/myPageUpdatePwd'" class="btn btn-primary left" data-dismiss="modal" id="goPass" disabled>변경하기</button>
                              
                            </div>
                         
                          </div>
                          <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                      </div>
                      <!-- /.modal -->
											



                        </div>
                        </div>
                    </div>
                    </section>
                    <!-- /.content -->
                </div>
                <!-- /.content-wrapper -->
            </div>
        </div>
		    <script>
				    $(document).ready(function() {
				        $('#userPwd').on('keyup', function() {
				            var userId = $('#userId').val(); 
				            var userPwd = $(this).val(); 
				           
				            
				            $.ajax({
				                url: '${contextPath}/member/checkPassword', 
				                type: 'POST',
				              
				                data: {
				                    userId: userId,
				                    userPwd: userPwd 
				                },    
				                success: function(response) {
				                    if (response ==='YYYYY') {
				                        $('#resultArea').text('비밀번호가 일치합니다.'); 
				                        $('#goPass').prop('disabled', false); 
				                    } else if(response ==='NNNNN') {
				                        $('#resultArea').text('비밀번호가 일치하지 않습니다.'); 
				                        $('#goPass').prop('disabled', true); 
				                    }
				                },
				                error: function(xhr, status, error) {
				                    console.error('AJAX 오류');
				                }
				            });
				        });
				    });
				</script>
				<script>
						$(document).ready(function() {
						    $("#deleteProfill").click(function() {
						        
						        var formData = new FormData();
						        formData.append("userId", "${loginUser.userId}");
						
						        $.ajax({
						            url: "${contextPath}/member/modifyProfile",
						            type: "POST",
						            data: formData,
						            processData: false,
						            contentType: false,
						            success: function(result) {
						            	if(result == "SUCCESS"){
						            		$("#profillArea img").attr('src', '${contextPath}/resources/images/common/defaultProfile.png');
				       						}else if(result == "FAIL") {
				       							alert("프로필변경에 실패했습니다.");
				       						}
						            },
						            error: function() {
						                console.log("프로필 이미지 삭제용 AJAX 통신 실패");
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
  		<script>
		    $(document).ready(function() {
		        $("#profileImgFile").change(function() {
		            var file = this.files[0];
		            if (file) {
		                var reader = new FileReader();
		                reader.onload = function(e) {
		                    $("#profillArea img").attr('src', e.target.result);
		                }
		                reader.readAsDataURL(file);
		            }
		        });
		    });
		</script>

    </div>
</body>
</html>