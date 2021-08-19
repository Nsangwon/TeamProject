<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
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
</style>
</head>

<body style="text-align: center;margin: auto;">
	<jsp:include page="../main_menu.jsp"/>

	<script type="text/javascript">
		alert("회원 가입 화면");
	</script>

	<h5 style="color: black; font-weight: bold;">SIGN</h5>
	<br><br><br>


	<div class="container">
		<div class="row">
			<form id="form_insert" action="/member/sign" method="post" style="text-align: left; margin:auto; padding-left: 200px;">
				<div class="form-group">
					<label>아이디</label>&emsp;&emsp;
					
					<input type="text" id="userId" class="underline" maxlength="20" name="userId"
						style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" required placeholder="사용할 ID를 입력해 주세요">
					&emsp;
					
					<span class="userId_check" style="color: red;">아이디를 입력해 주세요.</span>
				</div>
				
				<div class="form-group">
					<label>비밀번호</label>&emsp;
					<input type="password" class="underline" maxlength="20" name="userPw" id="userPw"
						style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" required placeholder="비밀번호를 입력해 주세요">
						
						<br> <br>
				</div>
				
				<div class="form-group">
					<label>비밀번호 확인</label>&emsp;
					<input type="password" class="underline" maxlength="20" name="userPw2" id="userPw2"
						style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" required placeholder="비밀번호 확인을 위해 같은 내용을 입력해 주세요"> 
				</div>
			
				<div class="form-group">
					<label>이름</label>&emsp;&emsp;&emsp;
					<input type="text" class="underline" maxlength="25" name="userName" id="userName"
						style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" required placeholder="회원님의 이름을 입력해 주세요."> <br>
					<br><br>
					<span class="hide userName_bytes">0</span>
				</div>
				
				
				<div class="form-group">
					<label>생년월일</label>&emsp;
					<input type="date" class="underline" maxlength="20" name="userBirthday" id="userBirthday"
						style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" required> <br>
					<br><br>
				</div>
			
				<div class="form-group">
					<label>주소</label>&emsp;&emsp;&emsp;
					<input style="border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" type="text" id="sample4_postcode"  name="sample4_postcode" placeholder="우편번호" readonly required>
                    &emsp;
                    
                    <input type="button" onclick="sample4_execDaumPostcode()"  class="btn btn-default" value="우편번호 찾기"><br>
                    &emsp;&emsp;&emsp;&emsp;&emsp;
                    
                    <input style="border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" type="text" id="sample4_roadAddress"  name="sample4_roadAddress" placeholder="도로명주소" readonly required>
                    
                    <input style="border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" type="text" id="sample4_detailAddress"  name="sample4_detailAddress" placeholder="상세주소" maxlength="60" disabled="disabled" required><br>
                    <input type="hidden" id="userAddress" name="userAddress">
                    <!-- 컨트롤러에서 DTO 작업시 adress 값은   우편번호 + 도로명주소+  상세주소 = userAdress 로 처리 -->
					<br><br>
				</div>

				   
				<div class="mail_wrap">
					<div class="mail_input_box">
						<label>e-mail</label> &emsp;&emsp;
						<input type="text" class="mail_input" name="userEmail" id="userEmail" style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" placeholder="본인확인을 위한 이메일을 입력해 주세요.">
						&emsp;
						<button class="mail_check_button btn btn-default" >인증 번호 전송</button>
                   </div>
                   
                   <div class="mail_check_wrap">
						<div class="mail_check_input_box" id="mail_check_input_box_false">
							<label>인증번호</label> &emsp;
							<input id="mail_check_input" class="mail_check_input" disabled="disabled" style="width: 400px;border-left-width:0; border-right-width:0; border-top-width:0;border-bottom-width:1;" placeholder="이메일로 전송된 본인확인 코드를 입력해주세요.">
							&emsp;
							<a id="mail_check_result" class="btn btn-default disabled" >인증 일치 확인</a>
							<button type="button" class="btn btn-danger hide" id="mail_reset_btn">인증 초기화</button>
							<br>
								
							<label>E-mail 인증 완료 여부</label>
							&emsp;
							<input type="checkbox" required onclick="return false;" id="mailCheckBox">
						</div> 
						<div class="clearfix"></div>
						<span id="mail_check_input_box_warn"></span>
						<br>
					</div>
				</div>
					
				<!--  -->
				<br> <br>
				
				<div class="form-group">
					<label>회원등급</label>&emsp;
					<select name="userGrade" id="userGrade" class="form-control" style="width: 400px; ">
						<option value="0">사용자</option>
						<option value="1">관리자</option>
					</select>
					<br><br>
				</div>
			</form>
		</div>	<!-- class = row end tag -->
		
		<button type="submit" class="btn btn-success member_insert_btn">가입하기</button>
	</div>	<!-- class = container end tag -->
	
	<script type="text/javascript">	
		$(document).ready(function() {			
			// 인증번호 버튼 클릭 시 이메일 인증번호 전송
			var code = "";	// 이메일 인증번호

			$("#mail_check_result").click(function(){
				event.preventDefault();
				var inputCode = $(".mail_check_input").val();        // 입력코드    
			    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과
			    
			    
			    if(inputCode == code){                            // 일치할 경우
			        checkResult.html("인증번호가 일치합니다.");
			        checkResult.attr("class", "correct");
			        $('#mailCheckBox').prop("checked", true);
			        $('#userEmail').attr("readonly", true);
			        $('#mail_check_input').attr("disabled", true);
			        $('#mail_check_result').addClass("hide");
			        $('#mail_reset_btn').removeClass("hide");
			        $('.mail_check_button').addClass("hide");
			        
			        
			    } else {                                            // 일치하지 않을 경우
			        checkResult.html("인증번호를 다시 확인해주세요.");
			        checkResult.attr("class", "incorrect");
			    }   
			    
			    
			});
			
			
			$("#mail_reset_btn").click(function() {
				var msg = confirm("인증된 이메일을 변경하시겠습니까?");
				
				if (msg) {
					$("#mail_check_input_box_warn").html("");
					$("#mail_check_input_box_warn").attr("class", "incorrect");
					$("#userEmail").val('');
					$('#userEmail').attr("readonly", false);
					$("#mail_check_input").val('');
			        $('#mail_check_input').attr("disabled", true);
			        $('#mail_check_result').removeClass("hide");
			        $('#mail_check_result').attr('class','btn btn-default disabled');
			        $('#mailCheckBox').prop("checked", false);
			        $('#mail_reset_btn').addClass("hide");
			        $(".mail_check_input_box").attr("id", "mail_check_input_box_false");
			        $('.mail_check_button').removeClass("hide");
			        
				} else {
					event.preventDefault();
				}
			});
			
			
			
			$(".mail_check_button").click(function(event){
				
				event.preventDefault();

				var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

			    var userEmail = $("#userEmail").val();        // 입력한 이메일
			    var cehckBox = $(".mail_check_input");        // 인증번호 입력란
			    var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
				
			    if (userEmail == '' || !emailRegExp.test(userEmail)) {
					alert('올바른 이메일 형식으로 입력하세요.');
					event.preventDefault();
					
				} else {
					userEmailCheck();
					
					if (checkUserEmail == 1) {
						$.ajax({
					        type : "get",
					        url : "/member/mailCheck?userEmail=" + userEmail,
					        success : function(result){
					        	alert("인증 번호가 전송되었습니다. \n입력한 이메일을 확인하세요.")
					        	code = result;
					        	cehckBox.attr("disabled",false); //입력불가창 해제
					        	boxWrap.attr("id", "mail_check_input_box_true");
					        	$('#mail_check_result').attr('class','btn btn-info'); //입력불가창 해제
					        }      
					    });
						
					} else {
						alert("이미 사용중인 이메일입니다.");
						event.preventDefault();
					}
					

				}
			});
			

			// 이름 bytes 구하기 (한/영 혼용 시 글자 수 바이트 초과 방지)
			$('#userName').keyup(function(){
				var textByte = $("#userName").val();
				var len = 0;	// 글자 바이트

				for (var i = 0; i < textByte.length; i++) {
					if (escape(textByte.charAt(i)).length == 6) {
						len+=2;	// 오라클 UTF-8 한글 1글자당 3byte
					}
					len++;	// 영문 1byte
				}		
				$('span.userName_bytes').text(len);
			});

			
			// 회원가입 버튼 클릭 이벤트
			$(".member_insert_btn").click(function() {
				event.preventDefault();
				
				var msg = confirm("회원 가입 하시겠습니까?");
				
				if (msg) {
					checkInfo();
				} else {
					event.preventDefault();
				}
			});
			
			// 실시간 아이디 입력 중복 체크
			$("#userId").change(function(){
				userIdCheck();
			});
			
		}); // (document).ready 종료 구간
		
		// 아이디 중복여부 체크 (0 = 중복, 1 = 가능)
		var checkUserId = 0;
		
		// 이메일 중복여부 체크 (0 = 중복, 1 = 가능)
		var checkUserEmail = 0;
		
		// 아이디, 비밀번호, 이름 정규표현식 유효성 검사 변수
		var idRegExp = /^[a-zA-Z0-9]{4,30}$/;
		
		var pwRegExp = /^[a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]{4,50}$/;
		
		// 한글, 영어 띄어쓰기 가능(\s)
		var nameRegExp = /^[가-힣a-zA-Z\s]{1,25}$/;
		
		// 이메일 정규표현식 유효성 검사
		var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		
		// 유효성 검사 함수
		var checkInfo = function() {
			if (userId == '' || !idRegExp.test($("#userId").val())) {
				alert('아이디는 최소 4자 이상의 영문 대소문자/숫자로 입력하세요.');
				event.preventDefault();

			} else if (checkUserId == 0) {
				alert('아이디 중복 여부를 확인해주세요.');
				event.preventDefault();

			} else if ($("#userPw").val() == '' || !pwRegExp.test($("#userPw").val())) {
				alert('비밀번호는 최소 4자 이상 입력하세요.');
				event.preventDefault();

			} else if ($("#userPw").val() != $("#userPw2").val()) {
				alert('비밀번호 혹은 재확인 부분이 서로 같지 않습니다');
				event.preventDefault();

			} else if ($("#userName").val() == '' || !nameRegExp.test($("#userName").val())) {
				alert('이름은 띄어쓰기 포함하여 \n한글 또는 영문으로 입력하세요.');
				event.preventDefault();
				
			} else if ($(".span.userName_bytes").text() > 25) {
				alert('이름은 총 25Byte 이내로 입력해야 합니다. \n(글자당 영문 1Byte, 한글 3Bytes)');
				// 오라클 utf-8 한글 글자당 3byte
				event.preventDefault();
				
			} else if ($("#userBirthday").val() == '') {
				alert('생일을 입력하세요.');
				event.preventDefault();
				
			} else if ($("#sample4_detailAddress").val() == '') {
				alert('주소를 입력하세요.');
				event.preventDefault();
				
			} else if ($("#userEmail").val() == '' || !emailRegExp.test($("#userEmail").val())) {
				alert('올바른 이메일 형식으로 입력하세요.');
				event.preventDefault();
				
			} else if ($("#mailCheckBox").is(":checked") == false) {
				alert('이메일 인증을 다시 확인해주세요');
				event.preventDefault();
				
			} else {
				$("#form_insert").submit();
				alert('회원 가입을 완료하였습니다.');
			}
			
		}; // checkInfo() 종료

		
		// ajax 실시간 아이디 중복 체크 함수
		function userIdCheck() {
			$.ajax({
				type : "post",
				url : "/member/idcheck",
				data : {
					userId : $("#userId").val()
				},
				dataType : "text",
				success : function(result) {
					if (result == "1") {
						$('span.userId_check').attr("style", "color: red;");
						$('span.userId_check').text("이미 사용중인 아이디입니다.");
						checkUserId = 0;
						
					} else if (userId == '' || !idRegExp.test($("#userId").val())){
						$('span.userId_check').attr("style", "color: red;");
						$('span.userId_check').text("아이디는 최소 4자의 영문 대소문자/숫자로만 입력하세요.");
						checkUserId = 0;
						
					} else {
						$('span.userId_check').attr("style", "color: blue;");
						$('span.userId_check').text("사용가능한 아이디입니다.");
						checkUserId = 1;
					}
				}
				
			}); // ajax 종료
			
		} // idcheck() 종료
		
		
		// ajax 실시간 이메일 중복 체크 함수
		function userEmailCheck() {
			$.ajax({
				type : "post",
				url : "/member/emailcheck",
				data : {
					userEmail : $("#userEmail").val()
				},
				async: false,
				dataType : "text",
				success : function(result) {
					if (result == "1") {
						checkUserEmail = 0;
						
					} else {
						checkUserEmail = 1;
					}
				}
				
			}); // ajax 종료
			
		} // emailcheck() 종료

	</script>
	
		

<!-- 프로젝트용 수정판 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.

		//주소 adress값은 DB에 varckar 200의 문자 값으로 해당
		//주소값은 도로명 +상패주소 str()임시

		// 다음 주소 API
		function sample4_execDaumPostcode() {
	        new daum.Postcode({
	        	oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== ''
							&& /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== ''
							&& data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('sample4_postcode').value = "";
					//도로명 주소 값을 공백 칸에 삽입
					document.getElementById("sample4_roadAddress").value = "";

					var sample4_roadAddress = document
							.getElementById("sample4_roadAddress").value;
					if (sample4_roadAddress == "") {

						document.getElementById("sample4_roadAddress").value = data.jibunAddress;
					}
					
					if (sample4_roadAddress == "") {

						document.getElementById("sample4_roadAddress").value = roadAddr;
					}
					//우편주소 값을 공백 칸에 삽입
					document.getElementById('sample4_postcode').value = data.zonecode;
					//도로명 주소 값을 공백 칸에 삽입
				
					$('#sample4_detailAddress').attr("disabled", false);
				}
	        }).open();
	    } // 주소 API 종료
	</script>
</body>
</html>