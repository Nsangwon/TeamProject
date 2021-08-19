<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>readSelf</title>
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

<body style="text-align: center; margin: auto;">

	<c:choose>
		<c:when test="${empty login}">
			<script type="text/javascript">
				alert("로그인이 필요한 작업입니다.")
				location.href = "/member/loginGet";
			</script>
		</c:when>
		
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>

	<jsp:include page="../main_menu.jsp" />

	<!--  -->
	<span class="glyphicon glyphicon-user" aria-hidden="true"style="font-weight: bold; font-size: 20px;"></span>
	<span style="font-weight: bold; font-size: 35px;">회원정보 수정하기</span>
	
	<br><br>
	
	<span style="color: green;">아이디와 회원등급을 제외한 정보 수정이 가능합니다.</span>
	
	<form action="" id="checkPwForm">
		<h3>
			<label>${login.userName} 님</label>
		</h3>
		<br>

		<h5>
			<label>본인확인을 위해 비밀번호를 입력해 주세요.</label>
		</h5>

		<span class="box int_userPw" style="width: 400px;">
			<input type="password" class="int" maxlength="20" name="loginuserPw" id="loginuserPw" style="width: 400px;" required placeholder="비밀번호를 입력해 주세요">
			<br>
		</span> 
		
		<div class="pw_check_result_box" id="pw_check_result_box_false">
			<input type="submit" id="pw_check_result" class="btn btn-info" style="width: 400px;" value="비밀번호확인">
		</div>

		<div class="clearfix"></div>
		<span id="pw_check_input_box_warn"></span>
	</form>
	<!-- 인증 끝 -->
	<!-- 회원정보 영역 시작 -->


	<form action="" id="readForm" hidden="">
		<h3 style="color: gray;">ID</h3>
		<span style="color: gray;">수정불가 항목입니다.</span>
		<br>
		<input type="text" id="userId" name="userId" readonly value="${dto.userId}"  disabled="disabled" style="color: gray;">
		<br>
			
			
		<h3>PW</h3>
		<br> <input type="password" id="userPw" name="userPw">
		<br>
		<br> <input type="password" id="userPw2" name="userPw2" placeholder="비밀번호 확인을 위해 같은 내용을 입력해 주세요">
		<br>
		
		<h3>이름</h3> <br>
		<input type="text" id="userName" name="userName" value="${dto.userName}">
		<br>
		<span class="hide userName_bytes">0</span>
			
			
		<h3>
			<span class="glyphicon glyphicon-envelope" aria-hidden="true" style="font-size: 20px;"></span>
			이메일
		</h3> <br>
		
		<div class="mail_wrap">
			<div class="mail_input_box">
				<input type="email" class="mail_input" name="userEmail" id="userEmail" value="${dto.userEmail}" readonly>
				<br>
			
				<button type="button" class="btn btn-danger" id="mail_reset_btn">인증 초기화</button>  
				<button class="mail_check_button btn btn-default hide" >인증 번호 전송</button>
			</div>
                   
			<div class="mail_check_wrap hide">
				<div class="mail_check_input_box" id="mail_check_input_box_false">
					<label>인증번호</label>
					&emsp;
					
					<input id="mail_check_input" class="mail_check_input" disabled="disabled" placeholder="이메일로 전송된 본인확인 코드를 입력해주세요.">
					&emsp;
					
					<a id="mail_check_result" class="btn btn-default disabled" >인증 일치 확인</a>
					<br>
                      
					<label>E-mail 인증 완료 여부</label>&emsp;
					<input type="checkbox" required onclick="return false;" id="mailCheckBox" checked>
				</div>
				
				<div class="clearfix"></div>
				<span id="mail_check_input_box_warn"></span>
				<br>
			</div>
		</div>
			
			
			
		<h3>
			<span class="glyphicon glyphicon-calendar" aria-hidden="true" style="font-size: 20px;"></span>
			생년월일
		</h3>
		<br>
		<br> <input type="date" id="userBirthday" name="userBirthday" value="${dto.userBirthday}">
		<br>


		<!--  -->
		<h3>
			<span class="glyphicon glyphicon-home" aria-hidden="true" style="font-size: 20px;"></span>
			주소
		</h3>
		<br>
		
		<h5>현재주소</h5>
		<input type="text" id="userAddress" name="userAddress" value="${dto.userAddress}" readonly disabled="disabled">
		<br>

		<!--  -->
	    <h3>주소 수정</h3>
			<input type="text" id="sample4_postcode"  name="sample4_postcode" placeholder="우편번호" readonly  style="width: 200px;">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="width: 200px;">
			<br>
			<input type="text" id="sample4_roadAddress"  name="sample4_roadAddress" placeholder="도로명주소" readonly  style="width: 200px;">
			<input type="text" id="sample4_detailAddress"  name="sample4_detailAddress" placeholder="상세주소"   style="width: 200px;">
			<br>
		<!--  컨트롤러에서 DTO 작업시 address 값은   우편번호 + 도로명주소+  상세주소 = useradress 로 처리 -->
		

		<h3>
			<span class="glyphicon glyphicon-time" aria-hidden="true" style="font-size: 20px;"></span>
			회원가입 날짜
		</h3>
		<br>
		<br> <input type="text" id="userRegdate" name="userRegdate" readonly value="${dto.userRegdate}">
		<br>
			
			
		<h3 style="color: gray;">
			<span class="glyphicon glyphicon-lock" aria-hidden="true" style="font-size: 20px;"></span>
			회원등급
		</h3>
		<br>
		<span style="color: gray;">수정불가 항목입니다.</span>
		<br>
		
		<input type="text" id="userGradeOro" name="userGradeOri" readonly value="${dto.userGrade eq 0? '사용자':'관리자'}" disabled="disabled" style="color: gray;">
		<br>
		<br> 
		
		<a id="updateMyself" class="btn btn-warning">회원 정보 수정</a>
		<a id="deleteMyself" class="btn btn-danger">회원탈퇴</a>
			
	</form>



	<script type="text/javascript">
		$(document).ready(function() {
			
			// 인증번호 버튼 클릭 시 이메일 인증번호 전송
			var code = "";
			
			// 이메일 인증 일치 확인 버튼
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
			        $('.mail_check_button').addClass("hide");
			        $('#mail_reset_btn').removeClass("hide");
			    } else {                                            // 일치하지 않을 경우
			        checkResult.html("인증번호를 다시 확인해주세요.");
			        checkResult.attr("class", "incorrect");
			    }   
			    
			    
			});
			
			
			// 이메일 인증 초기화 버튼
			$("#mail_reset_btn").click(function() {
				var msg = confirm("인증된 이메일을 변경하시겠습니까?");
				
				if (msg) {
					$("#mail_check_input_box_warn").html("");
					$("#mail_check_input_box_warn").attr("class", "incorrect");
					$("#userEmail").val('');
					$('#userEmail').attr("readonly", false);
					$("#mail_check_input").val('');
			        $('#mail_check_input').attr("disabled", true);
			        $('.mail_check_wrap').removeClass("hide");
			        $('.mail_check_button').removeClass("hide");
			        $('#mailCheckBox').prop("checked", false);
			        $('#mail_reset_btn').addClass("hide");
			        $(".mail_check_input_box").attr("id", "mail_check_input_box_false");
				} else {
					event.preventDefault();
				}
			});
			
			
			// 이메일 인증번호 전송 버튼
			$(".mail_check_button").click(function(){
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
						alert("다른 이메일로 인증해주세요.");
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

			
			$("#updateMyself").click(function() {
				var userId = $("#userId").val();
				var userPw = $("#userPw").val();
				var userName = $("#userName").val();
				var userEmail = $("#userEmail").val();
				var userBirthday = $("#userBirthday").val();
				var userAddress = $("#userAddress").val();
				var sample4_postcode = $("#sample4_postcode").val();
				var sample4_roadAddress = $("#sample4_roadAddress").val();
				var sample4_detailAddress = $("#sample4_detailAddress").val();
				
				// 비밀번호 제한
				var pwRegExp = /^[a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]{4,50}$/;
				
				// 한글, 영어 띄어쓰기 가능(\s)
				var nameRegExp = /^[가-힣a-zA-Z\s]{1,25}$/;
				
				// 이메일 정규표현식 유효성 검사
				var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

				if (userPw == '' || !pwRegExp.test(userPw)) {
					alert('비밀번호는 최소 4자 이상 입력하세요.');
					event.preventDefault();

				} else if (userPw != $("#userPw2").val()) {
					alert('비밀번호 혹은 확인 부분이 서로 같지 않습니다');
					event.preventDefault();

				} else if (userName == '' || !nameRegExp.test($("userName").val())) {
					alert('이름은 띄어쓰기 포함하여 \n한글 또는 영문으로 입력하세요.');
					event.preventDefault();
					
				} else if ($(".span.userName_bytes").text() > 25) {
					alert('이름은 총 25Byte 이내로 입력해야 합니다. \n(글자당 영문 1Byte, 한글 3Bytes)');
					// 오라클 utf-8 한글 글자당 3byte
					event.preventDefault();
					
				} else if (userBirthday == '') {
					alert('생일을 입력하세요.');
					event.preventDefault();
					
				} else if (userAddress == '') {
					alert('주소를 입력하세요.');
					event.preventDefault();
					
				} else if (userEmail == '' || !emailRegExp.test(userEmail)) {
					alert('올바른 이메일 형식으로 입력하세요.');
					event.preventDefault();
					
				} else if ($("#mailCheckBox").is(":checked") == false) {
					alert('이메일 인증을 다시 확인해주세요');
					event.preventDefault();
					
				} else {
					$.ajax({
						type : 'post',
						url : '/member/updateMyself',
						data : {
							userId : userId,
							userPw : userPw,
							userName : userName,
							userEmail : userEmail,
							userBirthday : userBirthday,
							userAddress : userAddress,
							sample4_postcode : sample4_postcode,
							sample4_roadAddress : sample4_roadAddress,
							sample4_detailAddress :sample4_detailAddress
						},
						dataType : 'text',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(userAddressTrue) {
							alert("회원 업데이트 완료");
							document.getElementById('userPw').value = "";
							document.getElementById('userPw2').value = "";
							document.getElementById('userName').value = userName;
							document.getElementById('userEmail').value = userEmail;
							document.getElementById('userBirthday').value = userBirthday;
							document.getElementById('userAddress').value = userAddressTrue;
						}

					});
				}

			});

			
			$("#deleteMyself").click(function() {
				var userId = $("#userId").val();
				var msg = confirm("회원을 탈퇴 하시겠습니까?");
				
				if (msg) {
					$.ajax({
						type : 'post',
						url : '/member/delete',
						data : {
							userId : userId
						},
						dataType : 'text',
						success : function() {
							alert("회원 탈퇴 완료");
							location.href = "/member/loginGet";
						}

					});
					
				} else {
					event.preventDefault();
				}
			});

			
			$("#pw_check_result").click(function(event) {
				event.preventDefault();

				var inputCode = $("#loginuserPw").val(); // 입력코드    
				
				$.ajax({
					type : 'get',
					url : '/member/readInfoCheck',
					data : {
						userId : "${login.userId}",
						userPw : inputCode
					},
					dataType : 'text',

					success : function(result) {
						if (result == "1") {	// 일치할 경우
							/*  $('form[id="readForm"]').is("hidden") == false; */
							alert("인증되었습니다.");
							$('form[id="readForm"]').attr("hidden", false); //성공시 감춰둔 정보창을 보여줌
							$('form[id="checkPwForm"]').attr("hidden", true);
							
						} else {
							alert("비밀번호가 일치하지 않습니다.");
						}
					}

				});
			});
		});
		
		// 이메일 중복여부 체크 (0 = 중복, 1 = 가능)
		var checkUserEmail = 0;
		
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


	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    
	    //주소 adress값은 DB에 varckar 200의 문자 값으로 해당
	    //주소값은 도로명 +상패주소 str()임시
	    
	    
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                
	                //우편주소 값을 공백 칸에 삽입
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                //도로명 주소 값을 공백 칸에 삽입
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	               /*  //지번 주소 값을 공백 칸에 삽입
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress; */
	
	                /*  */
	
	            }
	        }).open();
	    }
	</script>
</body>
</html>