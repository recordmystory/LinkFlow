<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 프로젝트수정</title>
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
	}
	.contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
	.dmovePage {
	   padding: .0rem 0rem;
	 }
	 /*여기까지 메인 영역 요소  공용 스타일임 */


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
                            <h1 class="m-0">프로젝트 수정</h1>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <form action="${contextPath}/project/modify.pj" method="post">
                        	<input type="hidden" name="proNo" value="${pro.proNo}">
                            <div class="contentArea">
                                <div class="contentInElement">
                                    <div class="btnArea">
                                        <button type="submit" class="btn btn-primary btn-sm">수정하기</button>
                                        <a href="${contextPath}/project/detail.pj?no=${pro.proNo}" class="btn btn-danger btn-sm">수정취소</a>
                                    </div>
                                </div>
                                <div style="display: flex;">
                                    <div class="card" style="min-height: 500px; min-width: 500px; width: 700px; text-align: left;">
                                        <div class="card-header" style="background-color: #007bff;">
                                            <h4>　</h4>
                                        </div>
                                        <table class="table" style="margin-top: 50px; width: 80%; margin-left: 80px;">
                                            <tr>
                                                <td style="margin-left: 200px; padding-top: 30px;">
                                                    <div>
                                                        <h4>프로젝트명</h4>
                                                        <input type="text" name="proTitle" class="form-control" required value="${pro.proTitle}">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="margin-left: 200px;">
                                                    <div>
                                                        <h4>담당부서</h4>
                                                        <input type="hidden" name="deptCode" value="${loginUser.deptCode}">
                                                        <input type="text" value="${loginUser.deptName}" class="form-control" readonly>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="margin-left: 200px;">
                                                    <div >
                                                        <h4>상태</h4>
                                                        <input class="radioBtn" type="radio" name="proYn" value="N" checked required>&nbsp;&nbsp;&nbsp;&nbsp;진행
                                                        <input class="radioBtn" type="radio" name="proYn" value="Y" style="margin-left: 20px;" required>&nbsp;&nbsp;&nbsp;&nbsp;완료
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div>
                                                        <h4>시작일</h4>
                                                        <input type="date" name="startDate" class="form-control" value="${pro.startDate}" required>
                                                    </div>
                                                    <div style="padding-bottom: 100px; padding-top: 70px;">
                                                        <h4>종료일</h4>
                                                        <input type="date" name="endDate" class="form-control" value="${pro.endDate}" required>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="card" style="height: 500px; width: 700px; text-align: left;">
                                        <div class="card-header" style="background-color: #007bff;">
                                            <h4 style="color: white;">　</h4>
                                        </div>
                                        <table class="table" style="margin-top: 50px; width: 80%; margin-left: 80px;">
                                            <tr>
                                                <td style="margin-left: 200px;">
                                                    <div>
                                                        <h4>고객사</h4>
                                                        <input type="text" name="client" class="form-control" value="${pro.client}" required>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="margin-left: 200px;">
                                                    <div>
                                                        <h4>
                                                            고객사 주소
                                                            <button type="button" class="btn btn-outline-dark" style="margin-left: 10px;" onclick="addressSearch()">주소 찾기</button>
                                                        </h4>
                                                        <input type="text" class="form-control" name="address" id="clientAddress" 
                                                               style="background-color: white; margin-bottom: 10px;" placeholder="도로명 주소" value="${pro.address}" readonly>
                                                        <input type="text" class="form-control" name="detailAdd" value="${pro.detailAdd}" placeholder="세부 주소">
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- /.card-body -->
                    </div>
                </section>
            </div>
            <!-- /.card -->
        </div>
    </div>

    <script>
        
       
        function addressSearch() {
            new daum.Postcode({
                oncomplete: function(data) {
                    
                    var roadAddr = data.roadAddress; 
                    var extraRoadAddr = '';
                   
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraRoadAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraRoadAddr !== ''){
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
    
                    document.getElementById("clientAddress").value = roadAddr;
                }
            }).open();
        }
    </script>
</body>
</html>