<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 검색 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
</head>
<body style="text-align: center;margin: auto;">

	<jsp:include page="../main_menu.jsp"/>
	
	<%-- <!-- 잘못된 get 방식 접근 차단 코드 -->
	<c:choose>
		<c:when test="${login.userGrade ne 1}">
			<jsp:forward page="noadmin.jsp" />
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	<!-- 잘못된 get 방식 접근 차단 코드 --> --%>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>userId</th>
						<th>userGrade</th>
						<th>userName</th>
						<th>userBirthday</th>
						<th>userEmail</th>
						<th>userRegdate</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${to.list}" var="vo">
							<tr style="cursor:pointer;" 
								onmouseOver="this.style.background='#50bcdf'" 
								onMouseOut="this.style.backgroundColor=''"
								onclick="location.href='/member/readByAdmin/${vo.userId}'">
								
								<td>${vo.userId}</td>
								<td>${vo.userGrade}</td>
								<td>${vo.userName}</td>
								<td>${vo.userBirthday}</td>
								<td>${vo.userEmail}</td>
								<td>${vo.userRegdate}</td>
								
							</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="text-center">
				<jsp:include page="search_part.jsp"/>
				<jsp:include page="paging_part.jsp">
					<jsp:param value="search" name="list"/>
				</jsp:include>
			</div>
			
		</div>
	</div>
	
	
</body>
</html>