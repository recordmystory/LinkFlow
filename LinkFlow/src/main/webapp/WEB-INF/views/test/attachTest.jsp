<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${ contextPath }/attachTest/insert.test" method="post" enctype="multipart/form-data">	
	<table>
		<tr>
			<td>
				<input type="file" name="uploadFiles" multiple>
			</td>
		</tr>
	</table>
	<button type="submit">등록</button>
	</form>
</body>
</html>