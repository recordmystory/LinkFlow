<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Linkflow 시설/비품</title>

<style>

.LinkFlowMainSection {
    width: 100%;
    min-height: 100%;
    display: flex;
}
.LinkFlowMainContent {
    width: 100%;
    min-width: 1260px;
    background-color: #f4f6f9;
    min-height:900px;
    padding: 30px;
    border-radius: 5px;
}

/* 테이블 */
.card-title, .card-tools {
	padding: 10px;
}

.card-body {
	text-align: center;
}

.bk-table {
	width: 95%;
	justify-content: space-between;
}

.caldiv {
	justify-content: center;
}

.mb-2 {
	padding-left: 30px;
	padding-top: 10px;
}

.calsection {
	width: 95%;
	justify-content: center;
	border: 0.5px solid lightgray;
	border-radius: 5px;
	padding-bottom: 20px;
	padding-top: 10px;
}

</style>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="LinkFlowMainSection">
		<jsp:include page="/WEB-INF/views/common/sidebar/booking/bookingSidebar.jsp" />
			<div class="LinkFlowMainContent">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <!-- <h1 class="m-0">&nbsp;</h1> -->
                        </div>
                    </div>
                </section>
                <jsp:include page="/WEB-INF/views/booking/bookingCalendar.jsp" flush="true"/>
            </div>
            <!-- /maincontent -->
		</div>
	</div>

</body>
</html>