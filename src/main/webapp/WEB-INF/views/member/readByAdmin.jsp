<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>readByAdmin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	input {
		width: 400px;
	}
</style>
</head>

<body style="text-align: center;margin: auto;">
	<jsp:include page="../main_menu.jsp"/>
	
	<!-- 잘못된 get 방식 접근 차단 코드 -->
							<c:choose>
								<c:when test="${login.userGrade ne 1}">
									<jsp:forward page="noadmin.jsp" />
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<!-- 잘못된 get 방식 접근 차단 코드 -->
	
	
	<!-- 회원정보 영역 시작 -->
	<span class="glyphicon glyphicon-user" aria-hidden="true" style="font-weight: bold; font-size: 20px;"></span>
	<span style="font-weight: bold; font-size: 30px;">회원 관리 모드</span><br>
	<span style="color: green;">관리모드에서 회원등급 조정 및 강퇴처리가 가능합니다.</span>
						
	<form action="" id="readForm" >
		<h3 style="color: gray;">ID</h3>
		<br>
		<input type="text" id="userId" name="userId" readonly value="${dto.userId}" disabled="disabled">
		<br>
		
		
		<h3 style="color: gray;">이름</h3>
		<br>
		<input type="text" id="userName" name="userName" readonly value="${dto.userName}" disabled="disabled">
		<br>
						
						
		<h3 style="color: gray;">
			<span class="glyphicon glyphicon-envelope" aria-hidden="true" style="font-size: 20px;"></span>
			이메일
		</h3>
		<br>
		<input disabled="disabled" type="email" id="userEmail" name="userEmail" readonly value="${dto.userEmail}">
		<br>
						
						
		<h3 style="color: gray;">
			<span class="glyphicon glyphicon-calendar" aria-hidden="true" style="font-size: 20px;"></span>
			생년월일
		</h3>
		<br>
		<input type="date" id="userBirthday" name="userBirthday" readonly value="${dto.userBirthday}" disabled="disabled">
		<br>
						
						
		<!--  -->
		<h3 style="color: gray;">
			<span class="glyphicon glyphicon-home" aria-hidden="true" style="font-size: 20px;"></span>
			주소
		</h3>
		<br>
		<input type="text" id="userAddress" name="userAddress" readonly value="${dto.userAddress}" disabled="disabled">
		<br>
						

		<!-- <h3>주소</h3>
		<input type="text" id="sample4_postcode"  name="sample4_postcode" placeholder="우편번호" readonly required>
		<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample4_roadAddress"  name="sample4_roadAddress" placeholder="도로명주소" readonly required>
		<input type="text" id="sample4_detailAddress"  name="sample4_detailAddress" placeholder="상세주소" required><br> -->
		<!--  컨트롤러에서 DTO 작업시 adress 값은   우편번호 + 도로명주소+  상세주소 = useradress 로 처리 -->
					
						
		<h3 style="color: gray;">
			<span class="glyphicon glyphicon-time" aria-hidden="true" style="font-size: 20px;"></span>
			회원가입 날짜
		</h3>
		<br>
		<input type="text" id="userRegdate" name="userRegdate" readonly value="${dto.userRegdate}" disabled="disabled">
		<br>
						
						
		<h3>
			<span class="glyphicon glyphicon-lock" aria-hidden="true" style="font-size: 20px;"></span>
			회원등급
		</h3>
		<br>
		<input type="text" id="userGradeOro" name="userGradeOri" readonly value="${dto.userGrade eq 0? '사용자':'관리자'}">
		<br> <br>
		
		<!--  -->
		<br> <br> <br>
		회원등급&nbsp;
		<select name="userGrade" id="userGrade" class="form-control" style="width: 400px; text-align: center; margin: auto;">
			<option value="0">사용자</option>
			<option value="1">관리자</option>
		</select>
		<br><br>
		<!--  -->
					
		<a id="updateGrade" class="btn btn-warning">회원 등급 수정</a>
		<a id="deleteMember" class="btn btn-danger">회원탈퇴</a>
	</form>



	<script type="text/javascript">
	$(document).ready(function() {

		$("#updateGrade").click(function(){
			var userId = $("#userId").val();
			var userGrade = $("#userGrade").val();
			
			$.ajax({
			     type : 'post',
			     url : '/member/updateGrade',
			     data : {
			    	 userId :userId,
			    	 userGrade : userGrade
			     },
			     dataType : 'text',
			     success : function() {
					location.href = '/member/list';
					alert("등급 수정 완료");
				}
			});
		});
		
		
		
		$("#deleteMember").click(function(){
			var userId = $("#userId").val();
			var msg = confirm(userId + " 회원을 탈퇴 하시겠습니까?");
			
			if (msg) {
				$.ajax({
					type : 'post',
					url : '/member/delete',
					data : {
						userId : userId
					},
					dataType : 'text',
					success : function() {
						location.href = "/member/list";
						alert("회원 탈퇴 완료");
					}
				});
				
			} else {
				event.preventDefault();
			}
		});

		
	});
	</script>
</body>
</html>