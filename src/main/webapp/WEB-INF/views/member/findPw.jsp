<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FindPw</title>
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
			<h1 class="jumbotron">비밀번호 재설정</h1>
		</div>
		
		<div class="row">
			<form class="form-horizontal" id="form_findPw" action="/member/findPw" method="post">
				<div class="form-group">
					<div class="userId_wrap">
						<label for="userId" class="col-sm-2 control-label">아이디</label>

						<div class="col-sm-9">
							<input type="text" class="form-control" id="userId" name="userId" maxlength="30">
						</div>
					</div>
					
					<div class="userEmail_wrap">
						<label for="userEmail" class="col-sm-2 control-label">이메일</label>
						<div class="col-sm-9">
							<input type="email" class="form-control" id="userEmail" name="userEmail" maxlength="55">
						</div>	
						
						<div class="col-sm-9">
							<br><span id="send_findPw_msg" class="hide" style="color: red;"></span>
						</div>
					</div>
					
					<div class="col-sm-offset-2 col-sm-10">
						<button type="button" class="btn btn-primary" id="userEmail_send_btn">임시 비밀번호 전송</button>
					</div>
				</div>
			</form>
		</div>	<!-- class = row end tag -->
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// 인증번호 버튼 클릭 시 이메일 인증번호 전송
			var code = "";
			
			$('#userEmail_send_btn').click(function() {	
				$("#send_findPw_msg").attr("class", "hide");
				$("#send_findPw_msg").text("");
				
				var userId = $("#userId").val();
				var userEmail = $("#userEmail").val();
				
				var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				
				if (userId == '') {
					alert('아이디를 입력해주세요');
					event.preventDefault();

				} else if (userEmail == '' || !emailRegExp.test(userEmail)) {
					alert('올바른 이메일 형식으로 입력하세요.');
					event.preventDefault();
					
				} else {
					$.ajax({
						type : "post",
						url : "/member/findPwResult",
						data : {
							userId : userId,
							userEmail : userEmail
						},
						dataType : "text",
						success : function(result) {
							if (result == "X") {
								alert("아이디 혹은 이메일이 다르거나 등록되지 않은 회원입니다.");
								$("#send_findPw_msg").removeClass("hide");
								$("#send_findPw_msg").text("아이디 혹은 이메일이 다르거나 등록되지 않은 회원입니다.");
								
							} else {
								alert("임시 비밀번호를 등록된 이메일 주소로 전송하였습니다. \n 비밀번호를 수정해 주세요");
								$("#send_findPw_msg").removeClass("hide");
								$("#send_findPw_msg").text("임시 비밀번호를 등록된 이메일 주소로 전송하였습니다.  비밀번호를 수정해 주세요 ");
							}
						}
					});
				}
			});
		

		});
		
	</script>
</body>
</html>