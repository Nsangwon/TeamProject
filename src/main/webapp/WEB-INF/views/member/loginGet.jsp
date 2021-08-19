<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%	/* view에 로그인 실패 에러메세지가 계속 나와있지 않게 해주는 코드 */
	String errMsg = (String) session.getAttribute("errMsg");
	if(errMsg == null){
		errMsg = "";
	}
	pageContext.setAttribute("errMsg", errMsg);
	
	session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
<style type="text/css">


#id_save_check{
width: 12px;
height: 12px;

}


.checkbox{
 font-size: 12px;
 color: black;

}

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

	<jsp:include page="../main_menu.jsp"/>
	<br><br><br>
	<div class="container">
		<form class="form-horizontal" action="/member/loginPost" method="post" style="text-align:  center; padding-left: 180px;">
		
		<div class="form-group">
			<div class="col-sm-10">
				<input type="text"  id="userId" name="userId" placeholder="MEMBER ID">
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-10">
				<input type="password"  id="userPw" name="userPw"  placeholder="PASSWORD">
			</div>
		</div>
        
		<a href="/member/sign">JOIN</a>
		<a onclick="findId()">FORGET ID</a>
		<a onclick="findPw()">FORGET PW</a> 
		<button type="submit" id="login_btn" style="width: 60px; border: none; margin-left: 20px;">LOGIN</button>
		<br>
		<span style="color:red;">${errMsg}</span>
		<br>
        
		<div class="col-sm-10">
			<div class="checkbox">
				<label>
					<input type="checkbox" id="id_save_check" > Remember ID
				</label>
			</div>
		</div>
		
	</form>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			
			var userId = getCookie("userId");	// 저장된 쿠기값 가져오기
			$("#userId").val(userId);
			
			if ($("#userId").val() != '') {	// 그 전에 ID를 저장해서 처음 페이지 연결 시 아이디 저장하기가 체크되어있을 때,
				$("#id_save_check").attr("checked", true);	// ID 저장하기를 체크 상태로 두기
			}
			
			// 로그인 버튼 클릭 이벤트
			$("#login_btn").click(function() {
				event.preventDefault();
				var saveId = $("#id_save_check").is(":checked");
				
				if ($("#userId").val() == '') {
					alert('아이디를 입력해주세요.');
					event.preventDefault();
	
				} else if ($("#userPw").val() == '') {
					alert('비밀번호를 입력해주세요');
					event.preventDefault();
	
				} else if (saveId) {	// 아이디 저장 체크박스가 체크 된 경우
					var userId = $("#userId").val();
					setCookie("userId", userId, 7);	// 7일동안 쿠키에 저장하는 이벤트를 호출
					$("form").submit();
					
				} else {	// 아이디 저장 체크박스가 체크 해제 된 경우
					deleteCookie("userId");	// 쿠키 정보를 지우는 이벤트를 호출
					$("form").submit();
				}
			});
			
		});
	
	
		// 아이디 찾기 팝업창
		function findId() {
			var options = 'top=10, left=10, width=780, height=750, status=no, menubar=no, toolbar=no, resizable=no';
		    window.open("/member/findId", "_blank", options);
		}
		
		// 비밀번호 찾기 팝업창
		function findPw() {
			var options = 'top=10, left=10, width=780, height=750, status=no, menubar=no, toolbar=no, resizable=no';
			window.open("/member/findPw", "_blank", options);
		}
		
		// {쿠키를 이용한 아이디 저장
		function setCookie(cookieName, value, exdays){
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);	// 쿠키 저장 기간
			var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue;
		}
	    
		function deleteCookie(cookieName){
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);	// 어제날짜를 쿠키 소멸날짜로 설정
			document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
	     
		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			
			if(start != -1){
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if(end == -1)end = cookieData.length;
				cookieValue = cookieData.substring(start, end);
			}
			return unescape(cookieValue);
		}	// 쿠키를 이용한 아이디, 비밀번호 저장
	</script>

</body>
</html>