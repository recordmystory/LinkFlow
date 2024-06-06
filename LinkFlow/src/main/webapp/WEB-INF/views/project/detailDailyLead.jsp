<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 직원별일일작업상세조회</title>
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
                            <h1 class="m-0">직원별 일일작업 상세 조회</h1>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid" style="display: flex; justify-content: center;">
                        <div class="contentArea">
                            <div class="contentInElement">
	                   			<c:choose>
	                   				<c:when test="${daily.daiAns == null}">
	                   					<div class="btnArea">
	                               			<a href="${contextPath}/project/ansModifyForm.dai?no=${daily.daiNo}" class="btn btn-primary btn-sm">피드백등록</a>
	                               			<a href="${contextPath}/project/deleteLead.dai?no=${daily.daiNo}" class="btn btn-danger btn-sm">삭제</a>
	                         			</div>
	                   				</c:when>
	                   				<c:otherwise>
	                   					<div class="btnArea">
	                               			<a href="${contextPath}/project/ansModifyForm.dai?no=${daily.daiNo}" class="btn btn-primary btn-sm">피드백수정</a>
	                               			<a href="${contextPath}/project/deleteLead.dai?no=${daily.daiNo}" class="btn btn-danger btn-sm">삭제</a>
	                         			</div>
	                   				</c:otherwise>
	                   			</c:choose>
                            </div>
                            <div class="card" style="min-height: 500px; min-width: 100%;">
                                <table class="table" style="text-align: center; font-size: 17px; margin-top: 20px; width: 1300px; margin-left: 100PX;">
                                    <tr>
                                        <td><b>성명</b></td>
                                        <td>${daily.userName}</td>
                                        <td><b>프로젝트명</b></td>
                                        <td>${daily.proTitle}(${daily.client})</td>
                                    </tr>
                                    <tr>
                                        <td><b>일자</b></td>
                                        <td>${daily.regDate}</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div style="transform: translateX(-550px);"><h5 style="font-weight: bold;">작업내용</h5></div>
                                            <textarea style="width: 1100px; height: 400px; margin-top: 20px; overflow: auto; border: none; resize: none;" readonly>${daily.daiContent}</textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div style="transform: translateX(-550px);"><h5 style="font-weight: bold;">피드백</h5></div>
                                            <textarea style="width: 1100px; height: 400px; margin-top: 20px; overflow: auto; border: none; resize: none;" readonly>${daily.daiAns}</textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <a href="${contextPath}/project/listLead.dai?deptCode=${loginUser.deptCode}" class="btn" style="background-color: #d4d4d4; width: 200px; margin-top: 50px; margin-bottom: 20px;">목록으로</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
		</div>
	</div>
</body>
</html>