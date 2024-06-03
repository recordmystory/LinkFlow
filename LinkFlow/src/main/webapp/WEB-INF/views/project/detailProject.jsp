<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 프로젝트상세조회</title>
<!-- 네이버 지도 api -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=wfsx6d3wj7&submodules=geocoder"></script>
<style type="text/css">
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
}
.contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
.dmovePage {
   padding: .0rem 0rem;
 }
 /*여기까지 메인 영역 요소  공용 스타일임 */
 .projectDetail{

    height: 80%;
    min-width: 1500px;
}

.detailOne{
    margin-top: 50px;
}

.detailTwo{
    margin-top: 30px;
}

.detailThree{
    margin-top: 30px;
}

.detailFour{
    margin-top: 30px;
}

.detailTitle{
    color: white;
    width: 130px;
    background-color: #17a2b8;
}

.detailContent{
    background-color: white; 
    color: black;
}

#projectMember{
    text-align: center; 
    border: 1px solid black; 
    width: 1254px; 
    overflow-y: auto; 
    height: 300px;
    margin-top: 10px;
}

.selectMember{
    border: 1px solid lightgray; 
    width: 80%; 
    height: 300px; 
    text-align: left;   
}
.detailContent{
	color: black !important;
}
</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="LinkFlowMainSection">
			<jsp:include page="/WEB-INF/views/common/sidebar/project/projectSidebar.jsp"/>
			
			<div class="LinkFlowMainContent">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0">프로젝트 상세 조회</h1>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </section>

                <!-- Main content start -->
                <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;">
                        <div class="contentArea">
                            <div class="contentInElement">
                            	<c:if test="${not empty loginUser and loginUser.position eq '팀장' and pro.deptName eq loginUser.deptName}">
                                <div class="btnArea">
                                    <a href="${contextPath}/project/modifyForm.pj?no=${pro.proNo}" class="btn btn-primary btn-sm">프로젝트 수정</a>
                                    <a href="${contextPath}/project/delete.pj?no=${pro.proNo}" class="btn btn-danger btn-sm">프로젝트 삭제</a>
                                </div>
                                </c:if>
                            </div>
                            <div style="min-height: 500px;">
                                <div class="projectDetail card">
                                	<div class="card-header" style="background-color: #17a2b8;">
                                    	<h4 class="card-title" style="color: white;">프로젝트 정보</h4>
                                    </div>
                                    <div class="detailOne">
                                        <span class="btn detailTitle" style="margin-left: 130px; cursor: default; background-color: #17a2b8; color: white;" disabled>프로젝트명</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 400px; cursor: default;" disabled>${pro.proTitle}</button>
                                        <span class="btn detailTitle" style="margin-left: 150px; cursor: default; background-color: #17a2b8; color: white;" disabled>상태</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 150px; cursor: default;" disabled>${pro.proYn == 'N' ? '진행' : '완료'}</button>
                                        <span class="btn detailTitle" style="cursor: default; background-color: #17a2b8; color: white;" disabled>프로젝트번호</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 150px; cursor: default;" disabled>${pro.proNo}</button>
                                    </div>
                                    <div class="detailTwo">
                                        <span class="btn detailTitle" style="margin-left: 130px; cursor: default; background-color: #17a2b8; color: white;" disabled>고객사</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 307px; cursor: default;" disabled>${pro.client}</button>
                                        <a class="btn btn-outline-info" data-toggle="modal" href="#mapModal" onclick="mapCreate('${pro.address}')">위치보기</a>
                                        <span class="btn detailTitle" style="margin-left: 150px; cursor: default; background-color: #17a2b8; color: white;" disabled>담당부서</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 437px; cursor: default;" disabled>${pro.deptName}</button>
                                    </div>
                                    <div class="detailThree">
                                        <span class="btn detailTitle" style="margin-left: 130px; cursor: default; background-color: #17a2b8; color: white;" disabled>고객사 주소</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 400px; cursor: default;" disabled>${pro.address}</button>
                                        <span class="btn detailTitle" style="margin-left: 150px; cursor: default; background-color: #17a2b8; color: white;" disabled>상세 주소</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 437px; cursor: default;" disabled>${pro.detailAdd == null ? '　' : pro.detailAdd}</button>
                                    </div>
                                    <div class="detailFour">
                                        <span class="btn detailTitle" style="margin-left: 130px; cursor: default; background-color: #17a2b8; color: white;" disabled>계약일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 300px; cursor: default;" disabled>${pro.startDate} ~ ${pro.endDate}</button>
                                        <span class="btn detailTitle" style="margin-left: 100px; cursor: default; background-color: #17a2b8; color: white;" disabled>시작일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 200px; cursor: default;" disabled>${pro.startDate}</button>
                                        <span class="btn detailTitle" style="margin-left: 50px; cursor: default; background-color: #17a2b8; color: white;" disabled>종료일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 200px; cursor: default;" disabled>${pro.endDate}</button>
                                    </div>
	                                    <div class="card-header" style="background-color: #17a2b8; margin-top: 150px">
	                                    	<h4 class="card-title" style="color: white;">투입인원</h4>
	                                    </div>
                                    <div style="margin-top: 20px; margin-left: 130px;">
                                        <c:if test="${not empty loginUser and loginUser.position eq '팀장' and pro.deptName eq loginUser.deptName}">
                                        <div style="transform: translateX(1008px); width: 300px;">
	                                        <button class="btn btn-primary" style="width: 80px; color: white;" 
	                                                data-toggle="modal" data-target="#addMemberModal">추가</button>
	                                        <button class="btn btn-outline-dark" style="width: 80px;" id="modifyButton">수정</button>
	                                        <button class="btn btn-danger" style="width: 80px;" onclick="deleteDispatch();">삭제</button>
                                        </div>
                                        </c:if>
                                        <!-- 테이블 시작 -->
                                        <div id="projectMember" class="card-body">
                                            <table class="table table-hover text-nowrap">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 5%;"></th>
                                                        <th style="width: 15%;">이름</th>
                                                        <th style="width: 15%;">역할</th>
                                                        <th style="width: 25%;">담당업무</th>
                                                        <th style="width: 15%;">파견 시작일</th>
                                                        <th style="width: 15%;">파견 종료일</th>
                                                        <th style="width: 10%;">상태</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<c:forEach var="d" items="${dis}">
	                                                    <tr>
	                                                        <td>
	                                                            <input type="radio" name="selectRadio">
	                                                            <input type="hidden" name="userId" value="${d.userId}">
	                                                        </td>
	                                                        <td>${d.userName}</td>
	                                                        <td>${d.role}</td>
	                                                        <td>${d.task}</td>
	                                                        <td>${d.startDate}</td>
	                                                        <td>${d.endDate}</td>
	                                                        <td>${d.disYn == 'N' ? '투입' : '복귀'}</td>
	                                                    </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- 테이블 끝 -->
                                    </div>
                                    <div style="display: flex; justify-content: center; margin-top: 100px; margin-bottom: 50px;">
                                        <button class="btn" style="background-color: #d4d4d4; width: 200px;" onclick="location.href='${contextPath}/project/list.pj'">목록으로</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <!-- 메인 컨텐트 끝 -->
 
            <!-- 인원 추가 모달 시작 -->
            <div class="modal" id="addMemberModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                        <h4 class="modal-title">프로젝트 인원 등록</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                
                        <!-- Modal body -->
                        <form id="addMemberForm" action="${contextPath}/project/addMember.dis" method="post" onsubmit="return validateForm();">
                        	<input type="hidden" name="proNo" value="${pro.proNo}">
	                        <div class="modal-body" style="text-align: left;">
	                            <table class="table">
	                                <tr>
	                                    <td>
	                                        <h5>이름
	                                            <button type="button" class="btn btn-outline-secondary btn-sm" style="transform: translateY(-2.5px);"
	                                                    data-toggle="modal" data-target="#searchMemberModal">인원 찾기</button>
	                                        </h5>
	                                        <input type="text" id="chooseName1" class="form-control" style="background-color: white;" readonly required>
	                                        <input type="hidden" name="userId" id="chooseId1" required>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>역할</h5>
	                                        <input type="radio" name="role" value="개발자" required>&nbsp; 개발자
	                                        <input type="radio" style="margin-left: 20px;" name="role" value="PM" required>&nbsp; PM
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>상태</h5>
	                                        <input type="radio" name="disYn" value="N" checked required>&nbsp; 투입
	                                        <input type="radio" style="margin-left: 20px;" name="disYn" value="Y" disabled>&nbsp;    복귀
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>담당 업무</h5>
	                                        <input type="text" name="task" class="form-control" required>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>파견 시작일</h5>
	                                        <input type="date" id="addStartDate" name="startDate" class="form-control" required>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>파견 종료일</h5>
	                                        <input type="date" id="addEndDate" name="endDate" class="form-control">
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	                
	                        <!-- Modal footer -->
	                        <div class="modal-footer" style="display: flex; justify-content: center;">
		                        <button type="submit" class="btn btn-primary">등록</button>
		                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	                        </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 인원 추가 모달 끝 -->

            <!-- 인원 수정 모달 시작 -->
            <div class="modal fade" id="modMemberModal" tabindex="-1" role="dialog" aria-labelledby="modMemberModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                        <h4 class="modal-title">프로젝트 인원 수정</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                
                        <!-- Modal body -->
                        <form id="modMemberForm" action="${contextPath}/project/modify.dis" method="post">
                        	<input type="hidden" name="proNo" value="${pro.proNo}">
	                        <div class="modal-body" style="text-align: left;">
	                            <table class="table">
	                                <tr>
	                                    <td>
	                                        <h5>
	                                        	이름
	                                        </h5>
	                                        <input type="text" id="chooseName2" class="form-control" style="background-color: white;" readonly>
	                                        <input type="hidden" id="chooseId2" name="userId">
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>역할</h5>
	                                        <input type="radio" class="modifyRole" name="role" value="개발자">&nbsp; 개발자
	                                        <input type="radio" class="modifyRole" style="margin-left: 20px;" name="role" value="PM">&nbsp; PM
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>상태</h5>
	                                        <input type="radio" class="modifyDisYn" name="disYn" value="N" checked>&nbsp; 투입
	                                        <input type="radio" class="modifyDisYn" style="margin-left: 20px;" name="disYn" value="Y">&nbsp;    복귀
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>담당 업무</h5>
	                                        <input type="text" id="modifyTask" name="task" class="form-control">
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>파견 시작일</h5>
	                                        <input type="date" id="modifyStartDate" name="startDate" class="form-control">
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <h5>파견 종료일</h5>
	                                        <input type="date" id="modifyEndDate" name="endDate" class="form-control">
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	                
	                        <!-- Modal footer -->
	                        <div class="modal-footer" style="display: flex; justify-content: center;">
		                        <button type="submit" class="btn btn-primary">수정</button>
		                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	                        </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 인원 수정 모달 끝 -->

            <!-- 인원 찾기 모달 시작 -->
            <div class="modal" id="searchMemberModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        
                        <!-- Modal body -->
                        <div class="modal-body" style="text-align: center;">
                            <div style="display: flex;">
                                <div class="selectMember">
                                    <h5 style="margin-top: 10px; margin-left: 10px;">LinkFlow</h5>
                                    <p style="margin-left: 20px;">${loginUser.deptName}</p>
                                </div>
                                <div class="selectMember" style="overflow-y: auto;">
                                    <p style="margin-top: 10px;"></p>
                                    <c:forEach var="t" items="${teamMem}">
                                    	<table>
                                    		<tr>
                                    			<td style="cursor: pointer;" onclick="chooseMember(this);">
                                    				<p style="margin-left: 10px">${t.userName}</p>
                                    				<input type="hidden" value="${t.userId}">
                                    			</td>
                                    		</tr>
                                    	</table> 
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                
                        <!-- Modal footer -->
                        <div class="modal-footer" style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 인원찾기 모달 끝 -->
            
            <!-- 지도 모달 시작 -->
            <div class="modal" id="mapModal">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <!-- Modal Header -->
	                    <div class="modal-header" style="justify-content: center;">
	                    <h4 class="modal-title">위치보기</h4>
	                    </div>
	                    <!-- Modal body -->
	                    <div class="modal-body" style="display:flex; justify-content: center;">
	                    <div id="map" style="width:450px; height:300px; display: flex;"></div>
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer">
	                    <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <!-- 지도 모달 끝 -->
		</div>
	</div>
	<script>
		$(function() {
			$('#addMemberModal').on('shown.bs.modal', function () {
		        // 폼 초기화
		        $('#addMemberForm')[0].reset();
		        
		        // 추가로 readonly 필드 및 특정 필드 값도 초기화
		        $('#chooseName1').val('');
		        $('#chooseId1').val('');
		        
		        // 라디오 버튼 초기화
		        $('input[name="role"][value="개발자"]').prop('checked', false);
		        $('input[name="role"][value="PM"]').prop('checked', false);
		        $('input[name="disYn"][value="N"]').prop('checked', true);
		    });
			
			$('#modMemberForm').submit(function(event) {
		        // startDate와 endDate 값을 가져옵니다.
		        var startDate = new Date($('#modifyStartDate').val());
		        var endDate = new Date($('#modifyEndDate').val());

		        // startDate가 endDate보다 클 경우 폼 제출을 막습니다.
		        if (startDate > endDate) {
		            alert('파견 시작일이 파견 종료일보다 클 수 없습니다.');
		            event.preventDefault(); // 폼 제출 막기
		        }
		    });
		})
	
        function chooseMember(element){
        	var userName = element.querySelector('p').textContent;
        	var userId = element.querySelector('input').value;
            $("#chooseName1").val(userName);
            $("#chooseId1").val(userId);
            $('#searchMemberModal').modal('hide');
        };
        
        function validateForm() {
            var chooseMember = document.getElementById('chooseName1').value;
            var chooseMemberId = document.getElementById('chooseId1').value;
            var proNo = document.querySelector('input[name="proNo"]').value;
            var startDate = new Date($('#addStartDate').val());
	        var endDate = new Date($('#addEndDate').val());
            
            if (!chooseMember) {
                alert('인원을 선택해주세요.');
                return false;
            };
            
            if(startDate > endDate){
            	alert('파견 시작일이 파견 종료일보다 클 수 없습니다.');
	            return false;
            }
            
            $.ajax({
            	url: "${contextPath}/project/checkMember.dis",
            	type: "post",
            	data: {
            		userId : chooseMemberId,
            		proNo : proNo
            	},
            	success: function(result) {
                    if (result == 'YES') {
                        alert('해당 인원은 이미 투입되어 있습니다.');
                    } else {
                        document.getElementById("addMemberForm").submit();
                    }
                }
            });
            return false;
        };
        
        document.querySelector('#modifyButton').addEventListener('click', function() {
            // 선택된 라디오 버튼 가져오기
            var selectedRadio = document.querySelector('input[name="selectRadio"]:checked');
            
            // 선택된 라디오 버튼이 있을 경우에만 실행
            if (selectedRadio) {
                // 선택된 라디오 버튼의 부모 tr에서 데이터 가져오기
                var row = selectedRadio.closest('tr');
                var userId = row.querySelector('input[name="userId"]').value;
                var name = row.cells[1].innerText;
                var role = row.cells[2].innerText;
                var task = row.cells[3].innerText;
                var startDate = row.cells[4].innerText;
                var endDate = row.cells[5].innerText;
                var disYn = row.cells[6].innerText === '투입' ? 'N' : 'Y'; // 상태에 따라 'N' 또는 'Y'로 설정
                
                // 모달 내의 입력 요소에 데이터 채우기
                document.getElementById('chooseName2').value = name;
                document.getElementById('chooseId2').value = userId; // chooseId2가 어디서 오는지 알 수 없어서 값을 그대로 사용합니다.
                document.querySelector('input.modifyRole[value="' + role + '"]').checked = true;
                document.querySelector('input.modifyDisYn[value="' + disYn + '"]').checked = true;
                document.getElementById('modifyTask').value = task;
                document.getElementById('modifyStartDate').value = startDate;
                document.getElementById('modifyEndDate').value = endDate;
                
                $('#modMemberModal').modal('show');
            }else{
            	alert('수정할 인원을 선택해주세요.');
            }
        });
        
		function deleteDispatch() {
			
			var selectedRadio = document.querySelector('input[name="selectRadio"]:checked');
			
			if (selectedRadio) {
				var proNo = document.querySelector('input[name="proNo"]').value;
				var row = selectedRadio.closest('tr');
				var userId = row.querySelector('input[name="userId"]').value;
				
				$.ajax({
					url:"${contextPath}/project/delete.dis",
					type:"post",
					data: {
						proNo: proNo,
						userId: userId
					},
					success: function(result) {
						if(result == 'SUCCESS'){
							location.reload();
						}
					}
				});
			}
		};
		
		// 지도 api 시작
        //주소의 정보를 selectMapList 함수로 넘겨준다.
        function mapCreate(address){
        naver.maps.Service.geocode({
                query: address
            }, function(status, response) {
            
                var item = response.v2.addresses[0]
        
                selectMapList(item.x, item.y);
                
            });
        };

        //검색정보로 지도를 만들고, 지도에 마커를 찍어준다.
        function selectMapList(latitude, longitude) {

            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(longitude, latitude),
                zoom: 14
            });
            var marker = new naver.maps.Marker({
                map: map,
                position: new naver.maps.LatLng(longitude, latitude),
            });
        };
        // 지도 api 끝
    </script>
</body>
</html>