<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FindId</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	#mail_check_input_box_false{
	    background-color:#ebebe4;
	} 
	#mail_check_input_box_true{
	    background-color:white;
	}
	.correct{
	    color : green;
	}
	.incorrect{
	    color : red;
	}
	
	input {
		width: 410px;
		height: 30px;
		
	}
	
	.container a{
	 font-size: 10px;
	 color: black;
	}
</style>
</head>
<body style="text-align: center;margin: auto;">

	<div class="container">
		<div class="row">
			<h1 class="jumbotron">아이디 찾기</h1>
		</div>
		
		<div class="row">
			<label class="control-label">가입시 인증받은 이메일을 입력해주세요.</label>
			<form class="form-horizontal" id="form_findId" action="/member/findId" method="post">
				<div class="form-group">
					<div class="userEmail_wrap">
						<label for="userEmail" class="col-sm-2 control-label">이메일</label>
						<div class="col-sm-9">
							<input type="email" class="form-control" id="userEmail" name="userEmail" maxlength="55">
						</div>
					</div>
					
					<div class="find_userId_wrap">
						<div class="col-sm-offset-2 col-sm-9">
							<input type="text" id="find_userId_msg" class="form-control hide" readonly>
						</div>
					</div>
					
					<div class="col-sm-offset-2 col-sm-10">
						<button type="button" class="btn btn-success" id="find_userId_btn">찾기</button>
					</div>
				</div>
			</form>
		</div>	<!-- class = row end tag -->
		
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// 이메일 인증번호 확인
			$("#find_userId_btn").click(function() {
				
				// 이메일 유효성 정규식
				var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				
				var userEmail = $("#userEmail").val();
				
				if (userEmail == '' || !emailRegExp.test(userEmail)) {
					alert('올바른 이메일 형식으로 입력하세요.');
					event.preventDefault();
					
				} else{
					$.ajax({
						type : "post",
						url : "/member/findIdResult",
						data : {
							userEmail : userEmail
						},
						dataType : "text",
						success : function(result) {
							if (result == "X") {
								alert("아이디 혹은 이메일이 다르거나 등록되지 않은 회원입니다.");
								
							} else {
								alert("확인되었습니다.");
								$('#find_userId_msg').val("입력한 이메일로 등록된 아이디 : " + result);
								$("#find_userId_msg").removeClass("hide");
							}
						}
					}); // ajax 종료
				}
					
			});
			
		});
	</script>
</body>
</html>