<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	color: black;
}
.btn-primary:hover {
	background: #007bff;
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
                                <div class="btnArea">
                                    
                                    <button class="btn btn-primary btn-sm">프로젝트 수정</button>
                                    <button class="btn btn-danger btn-sm">프로젝트 삭제</button>
                                    
                                </div>
                                <!--
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
                                -->
                            </div>
                            <div style="min-height: 500px;">
                                <div class="projectDetail card">
                                    <div class="detailOne">
                                        <span class="btn btn-primary detailTitle" style="margin-left: 130px; cursor: default;" disabled>프로젝트명</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 400px; cursor: default;" disabled>${pro.proTitle}</button>
                                        <span class="btn btn-primary detailTitle" style="margin-left: 150px; cursor: default;" disabled>상태</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 150px; cursor: default;" disabled>${pro.proYn == 'N' ? '진행' : '완료'}</button>
                                        <span class="btn btn-primary detailTitle" style="cursor: default;" disabled>프로젝트번호</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 150px; cursor: default;" disabled>${pro.proNo}</button>
                                    </div>
                                    <div class="detailTwo">
                                        <span class="btn btn-primary detailTitle" style="margin-left: 130px; cursor: default;" disabled>고객사</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 400px; cursor: default;" disabled>${pro.client}</button>
                                        <span class="btn btn-primary detailTitle" style="margin-left: 150px; cursor: default;" disabled>담당부서</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 437px; cursor: default;" disabled>${pro.deptName}</button>
                                    </div>
                                    <div class="detailThree">
                                        <span class="btn btn-primary detailTitle" style="margin-left: 130px; cursor: default;" disabled>고객사 주소</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 400px; cursor: default;" disabled>${pro.address}</button>
                                        <span class="btn btn-primary detailTitle" style="margin-left: 150px; cursor: default;" disabled>상세 주소</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 437px; cursor: default;" disabled>${pro.detailAdd == null ? '　' : pro.detailAdd}</button>
                                    </div>
                                    <div class="detailFour">
                                        <span class="btn btn-primary detailTitle" style="margin-left: 130px; cursor: default;" disabled>계약일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 300px; cursor: default;" disabled>${pro.startDate} ~ ${pro.endDate}</button>
                                        <span class="btn btn-primary detailTitle" style="margin-left: 100px; cursor: default;" disabled>시작일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 200px; cursor: default;" disabled>${pro.startDate}</button>
                                        <span class="btn btn-primary detailTitle" style="margin-left: 50px; cursor: default;" disabled>종료일</span>
                                        <button class="btn btn-outline-dark detailContent" style="width: 200px; cursor: default;" disabled>${pro.endDate}</button>
                                    </div>
                                    <div style="margin-top: 150px; margin-left: 130px;">
                                        <h4>투입인원</h4>
                                        <div style="transform: translateX(1008px); width: 300px;">
                                        <button class="btn btn-primary" style="width: 80px; color: white;" 
                                                data-toggle="modal" data-target="#addMemberModal">추가</button>
                                        <button class="btn btn-outline-dark" style="width: 80px;"
                                                data-toggle="modal" data-target="#modMemberModal">수정</button>
                                        <button class="btn btn-danger" style="width: 80px;">삭제</button>
                                        </div>
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
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" name="selectRadio" id="">
                                                        </td>
                                                        <td>김지민</td>
                                                        <td>개발자</td>
                                                        <td>기록관리 시스템</td>
                                                        <td>2024-01-01</td>
                                                        <td></td>
                                                        <td>투입</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- 테이블 끝 -->
                                    </div>
                                    <div style="display: flex; justify-content: center; margin-top: 100px; margin-bottom: 50px;">
                                        <button class="btn" style="background-color: #d4d4d4; width: 200px;">목록으로</button>
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
                        <div class="modal-body" style="text-align: left;">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h5>이름
                                            <button class="btn btn-outline-secondary btn-sm" style="transform: translateY(-2.5px);"
                                                    data-toggle="modal" data-target="#searchMemberModal">인원 찾기</button>
                                        </h5>
                                        <input type="text" id="chooseMember1" class="form-control" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>역할</h5>
                                        <input type="radio" name="role">&nbsp; 개발자
                                        <input type="radio" style="margin-left: 20px;" name="role">&nbsp; PM
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>상태</h5>
                                        <input type="radio" name="status" checked>&nbsp; 투입
                                        <input type="radio" style="margin-left: 20px;" name="status" disabled>&nbsp;    복귀
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>담당 업무</h5>
                                        <input type="text" class="form-control">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>파견 시작일</h5>
                                        <input type="date" class="form-control">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>파견 종료일</h5>
                                        <input type="date" class="form-control">
                                    </td>
                                </tr>
                            </table>
                        </div>
                
                        <!-- Modal footer -->
                        <div class="modal-footer" style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">등록</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 인원 추가 모달 끝 -->

            <!-- 인원 수정 모달 시작 -->
            <div class="modal" id="modMemberModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                        <h4 class="modal-title">프로젝트 인원 등록</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                
                        <!-- Modal body -->
                        <div class="modal-body" style="text-align: left;">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h5>이름
                                            <button class="btn btn-outline-secondary btn-sm" style="transform: translateY(-2.5px);"
                                                    data-toggle="modal" data-target="#searchMemberModal">인원 찾기</button>
                                        </h5>
                                        <input type="text" id="chooseMember1" class="form-control" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>역할</h5>
                                        <input type="radio" name="role">&nbsp; 개발자
                                        <input type="radio" style="margin-left: 20px;" name="role">&nbsp; PM
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>상태</h5>
                                        <input type="radio" name="status" checked>&nbsp; 투입
                                        <input type="radio" style="margin-left: 20px;" name="status">&nbsp;    복귀
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>담당 업무</h5>
                                        <input type="text" class="form-control">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>파견 시작일</h5>
                                        <input type="date" class="form-control">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>파견 종료일</h5>
                                        <input type="date" class="form-control">
                                    </td>
                                </tr>
                            </table>
                        </div>
                
                        <!-- Modal footer -->
                        <div class="modal-footer" style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">등록</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                        </div>
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
                                    <p style="margin-left: 20px;">개발 1팀</p>
                                </div>
                                <div class="selectMember" style="overflow-y: auto;">
                                    <p style="margin-top: 10px;"></p>
                                    <p style="margin-left: 10px; cursor: pointer;" onclick="chooseMember(this);">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
                                    <p style="margin-left: 10px;" onclick="">이개발</p>
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
		</div>
	</div>
	<script>
        function chooseMember(element){
            var memberName = $(element).text();
            $("#chooseMember1").val(memberName);
            $('#searchMemberModal').modal('hide');
        }

    </script>
</body>
</html>