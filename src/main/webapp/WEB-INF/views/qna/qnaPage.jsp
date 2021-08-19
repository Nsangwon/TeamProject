<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.domain.QNABoardVO"%>
<link rel="stylesheet" href="/resources/css/qna/qnaPage.css?v5">
<body>
	<br>
	<div class="container qnaBoard" style="border: 2px solid grey; width: 750px; margin: auto">
		<br>
		<div class="row" style="width: 700px; margin: auto;">
			<h1
				style="float: left; margin-top: 15px; margin-left: 30px; font-size: 34px; font-weight: bold;">상품문의</h1>
			<a class="btn btn-primary insertBtn" data-toggle="modal"
				data-target="#questionModal"
				style="float: right; margin-top: 12px; margin-right: 30px; font-size: 16.5px; color: white;">문의하기</a>
			<br> <br> <br>
			<hr class="mainHorizental">
			<div class="qnaList" id="qnaList"></div>
			<br>
			<div class="qnaPage" id="qnaPage" style="text-align: center; margin-bottom: 0px;"></div>
			<button type="button" class="btn btn-primary btn-xs goFirst"
				style="height: 30px; margin-top: -52px;">처음으로</button>
		</div>
		<br>
	</div>
	<br>
	<!-- 팝업창 -->
	<div class="low">
		<!-- Modal -->
		<div class="modal fade" id="questionModal" tabindex="-1" role="dialog"
			aria-labelledby="questionModalLabel" data-backdrop="static" style="margin: auto; width: 598px;">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_rno" style="text-align: center;">문의
							작성</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="id" style="height: 20px; margin-left: 3px;">작성자
							<c:choose>
								<c:when test="${empty login }">
									<p style="margin-left: 160px; margin-top: -21px; font-weight: normal;">
										<span style="color: RoyalBlue;" class="nameTotalLength">0</span><span> / 30</span>
									</p>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
							</label>
							
							<label for="password" style="height: 20px; float: right; margin-right: 140px;">비밀번호
								<c:if test="true">
									<p style="float: right; margin-right: -135px; font-weight: normal;">
										<span style="color: RoyalBlue;" class="passwordTotalLength">0</span><span> / 30</span>
									</p>
								</c:if>
							</label>
							<c:choose>
								<c:when test="${empty login }">
									<input class="form-control" type="text" id="name"
										name="name" style="width: 200px;">
								</c:when>
								<c:otherwise>
									<input class="form-control" type="text" id="name"
										name="name" value="${login.userName }"
										style="width: 200px;" readonly>
								</c:otherwise>
							</c:choose>
							<input type="password" class="form-control" id="password"
								name="password"
								style="float: right; width: 200px; margin-top: -35px;" />
						</div>
						<div class="form-group">
							<label for="title">제목</label> <input type="text"
								class="form-control" id="title" name="title" />
						</div>
						<div class="form-group">
							<label for="contentText">본문</label>
							<textarea style="resize: horizontal; height: 150px;" class="form-control" rows="10"
								id="contentText" name="contentText" placeholder="300자 이내로 입력해주세요."></textarea>
							<p style="text-align: right;">
								<span style="color: RoyalBlue;" class="contentTotalLength">0</span><span> / 300</span>
							</p>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default cancelInsert" data-dismiss="modal">취소</button>
						<button id="question_insert_btn" type="button"
							class="btn btn-primary qInsert">작성 완료</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="answerModal" tabindex="-1" role="dialog"
			aria-labelledby="answerModalLabel" data-backdrop="static">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_rno" style="text-align: center;">답변
							작성</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="answerName" style="margin-left: 3px;">작성자</label>
							<input class="form-control" type="text" id="answerName"
								name="answerName" value="${login.userName }" style="width: 200px;" readonly>
						</div>
						<div class="form-group">
							<label for="answertitle">제목</label> <input type="text"
								class="form-control" id="answertitle" name="answertitle" />
						</div>
						<div class="form-group">
							<label for="answercontentText">본문</label>
							<textarea style="resize: horizontal; height: 150px;" class="form-control" rows="10"
								id="answercontentText" name="answercontentText" placeholder="300자 이내로 입력해주세요."></textarea>
							<p style="text-align: right;">
								<span style="color: RoyalBlue;" class="answercontentTotalLength">0</span><span> / 300</span>
							</p>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default answercancelInsert" data-dismiss="modal">취소</button>
						<button id="answer_insert_btn" type="button"
							class="btn btn-primary aInsert">작성 완료</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/resources/js/qna.js?ver=123123123123"></script>
	<script type="text/javascript">
	//< 로그인 정보
	var qUserId = "${login.userId}";
	var qUserName = "${login.userName}";
	var qUserGrade = "${login.userGrade}";
	
	//< 게시글 번호 변수
	var qBno = ${vo.prodBno};
	var qQno;
	
	//< pagination 변수
	var qCurPage = 1;
	var qBeginPageNum;
	var qFinishPageNum;
	var qTotalPage;
	
	//< 관리자 확인 및 기능 변경용 논리자료형
	var isAdministrator = false;
	var isUpdate = false;
	
	//< 관리자 답변 시 아이디 인식용
	var questionId;
	
	$(document).ready(function() {
		
		//< 관리자 권한 체크
		checkGrade(qUserGrade);
		
		//< 첫 화면 리스트 출력
		getPageList(qBno, qCurPage);
		
		//< (전체) 확장 기능
		$("#qnaList").on("click", ".toggleText", function() {

			//< 관리자 권한 체크
			checkGrade(qUserGrade);
			
			//< Qno 가져오기
			qQno = $(this).parent().next().next().next().children('div.qQno').text();
			
			//< 제목~본문 구분선
			var hr = $(this).parent().next().next().next().next("div");
			
			//< 작성자와 로그인 정보가 동일한지 id 체크용 논리자료형 / default: false;
			var isWriter = false;
			
			//< 작성자 정보
			var qWriterId = $(this).prev().text();
			
			//< 비밀번호입력, 본문 내용, 답글 내용
			var passwordBox = $(this).parent().next().next("div");
			var contentBox = $(this).parent().next().next().next("div");
			
			//< 본문과 답글 구분용 (들여쓰기 0 : 본문 / 1 : 답글)
			var checkRepRoot = $(this).parent().next().next().next("div").children('div.qRepindent').text();
			
			//< 버튼 좌표 저장용 (권한 혹은 작성자 본인인지 확인 후 버튼 생성 or 삭제)
			var optionBtns = $(this).parent().next().next().next().children('div.buttonDiv');
			
			//< 작성자 정보와 로그인 정보 비교 및 반환값(논리자료형, true/false)
			isWriter = checkId(qUserId, qWriterId);
			
			//< 본문 작성자의 ID 정보 저장
			questionId = qWriterId;
			
			//< 버튼 저장용 div 태그 초기화
			optionBtns.empty();
			
			//< 본문
			if(parseInt(checkRepRoot) != 1)
			{
				//< 관리자
				if(isAdministrator)
				{
					var questionMsg = `
						<button type="button" class="btn btn-outline-info btn-xs answer">
							Answer
						</button>
						&nbsp;
						<button type="button" class="btn btn-outline-dark btn-xs delete">
							Delete
						</button>
					`;
					
					optionBtns.html(questionMsg);
				}
				//< 작성자
				else if(isWriter)
				{
					var questionMsg = `
						<button type="button" class="btn btn-outline-dark btn-xs delete">
							Delete
						</button>
					`;
			
					optionBtns.html(questionMsg);
				}
				//< 비회원, text이므로 "null" 로 비교해야함, ===는 문자열 비교
				else if(qWriterId === "null")
				{
					var questionMsg = `
						<button type="button" class="btn btn-outline-dark btn-xs delete">
							Delete
						</button>
					  `;

					optionBtns.html(questionMsg);
				}
			}
			//< 답글
			else	
			{
				//< 관리자만 
				if(isAdministrator)
				{
					var answerMsg = `
						<button type="button" class="btn btn-outline-info btn-xs modify">
							Modify
						</button>
						&nbsp;
						<button type="button" class="btn btn-outline-dark btn-xs AnswerDelete">
							Delete
						</button>
					`;
					
					optionBtns.html(answerMsg);
				}
			}
			
			//< 관리자거나 작성자 본인일 경우
			if(isAdministrator || isWriter)
			{
				//< 비밀번호 입력창이 확장되어 있을 경우
				if( passwordBox.is(":visible") ){
					//< 축소
					passwordBox.slideUp();
				}
				//< 본문내용이 확장 되어있을 경우
				else if( contentBox.is(":visible") ){
					//< 축소
					contentBox.slideUp();
				}
				else{
					//< 축소된 본문내용 확장
					contentBox.slideDown();
				}
			}
			//< 일반회원 및 비회원일 때
			else
			{
				if( passwordBox.is(":visible") ){
					passwordBox.slideUp();
				}
				else{
					if(contentBox.is(":visible"))
					{
						contentBox.slideUp();
					}
					else
					{
						passwordBox.slideDown();
					}				
				}
			}
			
			//< 버튼 저장용 div 및 확장 오브젝트 구분선 접기/펼치기 설정
			if( optionBtns.is(":visible") ){
				//< 축소
				optionBtns.slideUp();
			}
			else{
				//< 축소된 본문내용 확장
				optionBtns.slideDown();
			}

			if( hr.is(":visible") ){
				hr.slideUp();
			}
			else{
				hr.slideDown();
			}
		});
		
		//< (본문) 비밀번호 입력
		$("#qnaList").on("click", ".enter", function() {
			
			var that = $(this).prev("input").val();
			var contentBox = $(this).parent().parent().next();
			var passwordBox = $(this).parent().parent();
			var inputPw = $(this).prev("input");
			
			$.ajax({
				type : "post",
				url : "/qnaPage/getPw",
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'post'
				},
				data : JSON.stringify({
					qQno : qQno
				}),
				dataType : 'text',
				success : function(pw) {

					//< 비밀번호 입력이 일치했을 경우
					//< login 아이디와 비교하는 경우도 추가해야함
					if(that.trim() === pw)
					{
						contentBox.show();
						passwordBox.hide();
						inputPw.val("");
					}
					else
					{
						alert("비밀번호가 일치하지 않습니다.");
						$(this).prev("input").val("");
					}
				}
			});
		});
		
		//< 문의하기 버튼
		$(".insertBtn").click(function(event){
			
			//< 내부 입력 상태 초기화
			$("#title").val("");
			$("#contentText").val("");
			$("#password").val("");
			$(".contentTotalLength").text(0);
			$(".passwordTotalLength").text(0);
			
			if(qUserName.length > 1)
			{
				//< 읽기 전용 설정
				$("#name").attr('readonly', 'readonly');
				
				$("#name").val(qUserName);
			}
			else
			{
				//< 읽기 전용 해제
				$("#name").removeAttr('readonly');
			}
		});

		//< 최대 글자 수 입력 제한, 확인하기 힘든 비밀번호, 본문만 체크
		$("#name").keyup(function(event){
			event.preventDefault();
			var contentText = $(this);
			var contentTextLength = stringLength(contentText.val());
			
			if(contentTextLength > 30)
			{
				$(".nameTotalLength").css("color", "red");
			}
			else
			{
				$(".nameTotalLength").css("color", "royalblue");
			}
			
			$(".nameTotalLength").text(contentTextLength);
		});
		
		$("#password").keyup(function(event){
			event.preventDefault();
			var contentText = $(this);
			var contentTextLength = stringLength(contentText.val());
			
			if(contentTextLength > 30)
			{
				$(".passwordTotalLength").css("color", "red");
			}
			else
			{
				$(".passwordTotalLength").css("color", "royalblue");
			}
			
			$(".passwordTotalLength").text(contentTextLength);
		});

		$("#contentText").keyup(function(event){
			event.preventDefault();
			var contentText = $(this);
			var contentTextLength = stringLength(contentText.val());
			
			if(contentTextLength > 300)
			{
				$(".contentTotalLength").css("color", "red");
			}
			else
			{
				$(".contentTotalLength").css("color", "royalblue");
			}
			
			$(".contentTotalLength").text(contentTextLength);
		});
		
		$("#answercontentText").keyup(function(event){
			event.preventDefault();
			var contentText = $(this);
			var contentTextLength = stringLength(contentText.val());
			
			if(contentTextLength > 300)
			{
				$(".answercontentTotalLength").css("color", "red");
			}
			else
			{
				$(".answercontentTotalLength").css("color", "royalblue");
			}
			
			$(".answercontentTotalLength").text(contentTextLength);
		});
		
		//< (본문) 입력 기능
		$("#question_insert_btn").click(function(event){
			event.preventDefault();
			
			console.log($("#contentText").val());
			
			var name = $("#name").val();
			var title = $("#title").val();
			var content = $("#contentText").val();
			var password = $("#password").val();
			
			if(stringLength($("#name").val()) > 30)
			{
				alert("닉네임은 30자 까지만 가능합니다.");
			}
			else if(stringLength($("#contentText").val()) > 300)
			{
				alert("본문은 300자 까지만 가능합니다.");
			}
			else if(stringLength($("#title").val()) > 50)
			{
				alert("제목은 50자 까지만 가능합니다.");
			}
			else if(stringLength($("#password").val()) > 30)
			{
				alert("비밀번호는 30자 까지만 가능합니다.");
			}
			else if(stringLength($("#name").val()) < 1
					|| stringLength($("#title").val()) < 1
					|| stringLength($("#password").val()) < 1
					|| stringLength($("#contentText").val()) < 1)
			{
				alert("빈 칸으로는 등록할 수 없습니다.");
			}
			else
			{
				$.ajax({
					type : "post",
					url : "/qnaPage/insert",
					headers : {
						'Content-Type' : 'application/json',
						'X-HTTP-Method-Override' : 'post'
					},
					data : JSON.stringify({
						qBno : qBno,
						qTitle : title,
						qWriter : name,
						qContent : content,
						qPassword : password,
						qUserId : qUserId
					}),
					dataType : 'text',
					success : function(result) {
						
						$("#name").val("");
						$("#title").val("");
						$("#contentText").val("");
						$("#password").val("");
						
						getPageList(qBno, 1);
					}
				});

				$("#questionModal .close").click();
				$("#questionModal .close").trigger("click");
			}
		});
		
		//< (본문) 답글 작성
		$("#qnaList").on("click", ".answer", function() {
			
			$("#answertitle").val("");
			$("#answercontentText").val("");
			$(".answercontentTotalLength").text(0);
			
			//< 관리자 권한 체크
			checkGrade(qUserGrade);
			
			var questionTitle = $(this).parent().parent().prev().prev().prev().children('a.toggleText').text().trim();

			if(isAdministrator)
			{
				$("#answerModal").modal("show");
				
				if(questionTitle.length > 40)
				{
					$("#answertitle").val("[답변] " + questionTitle.substring(0, 25) + "...");
				}
				else
				{
					$("#answertitle").val("[답변] " + questionTitle);
				}
				
				qQno = $(this).parent().next().text();
			}
		});
		
		//< (답글) 수정
		$("#qnaList").on("click", ".modify", function() {
			
			$("#answerName").val("");
			$("#answertitle").val("");
			$("#answercontentText").val("");
			$(".answercontentTotalLength").text(0);
			
			//< 관리자 권한 체크
			checkGrade(qUserGrade);
			
			var answerTitle = $(this).parent().parent().prev().prev().prev().children('a.toggleText').text().trim();
			
			answerTitle = answerTitle.replace("↪", "").trim();
			
			if(isAdministrator)
			{
				$("#answerModal").modal("show");
				
				$("#answerName").val(qUserName);
				$("#answertitle").val(answerTitle);
				$("#answercontentText").val($(this).parent().prev().prev().text());
				
				qQno = $(this).parent().next().text();
				isUpdate = true;
			}
		});
		
		//< (답글) 답변 입력 기능
		$("#answer_insert_btn").click(function(event){
			event.preventDefault();
			
			var name = $("#answerName").val();
			var title = $("#answertitle").val();
			var content = $("#answercontentText").val(); 
			
			if(stringLength($("#answerName").val()) > 30)
			{
				alert("닉네임은 30자 까지만 가능합니다.");
			}
			else if(stringLength($("#answertitle").val()) > 50)
			{
				alert("제목은 50자 까지만 가능합니다.");
			}
			else if(stringLength($("#answercontentText").val()) > 300)
			{
				alert("본문은 300자 까지만 가능합니다.");
			}
			else if(stringLength($("#answerName").val()) < 1
					|| stringLength($("#answertitle").val()) < 1
					|| stringLength($("#answercontentText").val()) < 1)
			{
				alert("수정 할 답변을 입력해주세요. 빈 칸으로는 등록할 수 없습니다.");
			}
			else
			{
				//< 수정 / 입력 전환
				//< 수정 중이라면
				if(isUpdate)
				{
					//< update 기능 활성
					$.ajax({
						type : "post",
						url : "/qnaPage/update",
						headers : {
							'Content-Type' : 'application/json',
							'X-HTTP-Method-Override' : 'post'
						},
						data : JSON.stringify({
							qQno: qQno,
							qTitle : title,
							qContent : content,
						}),
						dataType : 'text',
						success : function(result) {
							
							$("#answerName").val("");
							$("#answertitle").val("");
							$("#answercontentText").val("");
							
							getPageList(qBno, qCurPage);
						}
					});
					
					//< 기능 초기화
					isUpdate = false;
				}
				//< 입력 중이라면
				else
				{
					//< 비밀번호 가져오기
					$.ajax({
						type : "post",
						url : "/qnaPage/getPw",
						headers : {
							'Content-Type' : 'application/json',
							'X-HTTP-Method-Override' : 'post'
						},
						data : JSON.stringify({
							qQno : qQno
						}),
						dataType : 'text',
						success : function(pw) {
							
							//< answer(insert) 기능 활성
							$.ajax({
								type : "post",
								url : "/qnaPage/answer",
								headers : {
									'Content-Type' : 'application/json',
									'X-HTTP-Method-Override' : 'post'
								},
								data : JSON.stringify({
									qQno: qQno,
									qBno : qBno,
									qTitle : title,
									qWriter : name,
									qContent : content,
									qPassword : pw,
									qUserId : questionId
								}),
								dataType : 'text',
								success : function(result) {
									
									$("#answertitle").val("");
									$("#answercontentText").val("");
									
									getPageList(qBno, qCurPage);
								}
							});
						}
					});
				}
			}
			
			$("#answerModal .close").click();
			$("#answerModal .close").trigger("click");
		});
		
		//< (본문) 삭제 (연결된 답글도 같이 삭제)
		$("#qnaList").on("click", ".delete", function() {
			qQno = $(this).parent().next().text();
			
			$.ajax({
				type : "delete",
				url : "/qnaPage/deleteqReproot",
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'delete'
				},
				data : JSON.stringify({
					qQno : qQno
				}),
				dataType : 'text',
				success : function(result) {
					
					getPageList(qBno, qCurPage);
					
					alert("삭제 되었습니다.");
				}
			});
		});
		
		//< (답글) 삭제
		$("#qnaList").on("click", ".AnswerDelete", function() {
			qQno = $(this).parent().next().text();
			
			$.ajax({
				type : "delete",
				url : "/qnaPage/delete",
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'delete'
				},
				data : JSON.stringify({
					qQno : qQno
				}),
				dataType : 'text',
				success : function(result) {
					
					getPageList(qBno, qCurPage);
					
					alert("삭제 되었습니다.");
				}
			});
		});
		
		//< 첫 페이지으로 이동
		$(".goFirst").click(function(e){
			e.preventDefault();
			
			if(qCurPage != 1)
			{
				getPageList(qBno, 1);
			}
			else
			{
				alert("처음 페이지 입니다.");
			}
		});
		
		//< pagination 기능
		//< 숫자버튼
		$("#qnaPage").on("click", ".qPageNum", function(e) {
			e.preventDefault();
			
			if(qCurPage != $(this).text())
			{
				qCurPage = $(this).text();
				
				getPageList(qBno, $(this).text());
			}
		});
		
		//< 이전으로
		$("#qnaPage").on("click", ".qPrev", function(e) {
			e.preventDefault();
			
			if(qCurPage != qBeginPageNum)
			{
				getPageList(qBno, qBeginPageNum);
			}
			else
			{
				getPageList(qBno, qBeginPageNum - 5);
			}
			
		});
		
		//< 다음으로
		$("#qnaPage").on("click", ".qNext", function(e) {
			e.preventDefault();
			
			if(qCurPage != qFinishPageNum)
			{
				getPageList(qBno, qFinishPageNum);
			}
			else
			{
				getPageList(qBno, qBeginPageNum + 5);
			}
		});
	});
	
	function getPageList(qBno,pageIndex) {
		$("#qnaList").empty();
		
		//< qTitle, qWriter, qUpdatedate, qPassword, qContent
		$.getJSON("/qnaPage/list/" + qBno + "/" + pageIndex , function(data){
			
			qCurPage = data.curPage;
			qBeginPageNum = data.beginPageNum;
			qFinishPageNum = data.finishPageNum;
			qTotalPage = data.totalPage;
			
			var page =   makePage(qBeginPageNum, qFinishPageNum, qCurPage);
			$("#qnaPage").html(page);
			
			if(qCurPage == 1){
				$("#qPrev").hide();
			}
			else
			{
				$("#qPrev").show();
			}
			
			if(qCurPage == qTotalPage){
				$("#qNext").hide();
			}
			else
			{
				$("#qNext").show();
			}

			var qnaList = data.list;
			for(var i = 0; i < qnaList.length; i++)
			{
				var obj = qnaList[i];
				
				//< 답글일 경우
				if(obj['qRepindent'] != 0)
				{
					var list = getAnswerList(obj['qTitle'], obj['qWriter'], obj['qUpdatedate'], obj['qContent'], obj['qQno'], obj['qRepindent'], obj['qUserId']);
				}
				//< 본문일 경우
				else
				{
					var list = getList(obj['qTitle'], obj['qWriter'], obj['qUpdatedate'], obj['qContent'], obj['qQno'], obj['qRepindent'], obj['qUserId']);
				}
				
				list.replace(/\n/gi, "<br>");
				
				$("#qnaList").append(list);
			}
		});
	}
	
	//< 관리자 확인
	function checkGrade(grade)
	{
		if(parseInt(grade) == 1)   
		{
		   isAdministrator = true;
		   $(".insertBtn").hide();
		}
		else
		{
		   isAdministrator = false;
		}
	}
	
	//< 문자열 길이 (한글 포함)
	//< 한글은 3배
	function stringLength(str) {
    	var len = 0;
    	
    	for (var i = 0; i < str.length; i++) {
        	if (escape(str.charAt(i)).length == 6) {
        	    len+=2;
    	    }
    	    len++;
    	}
    	
    	return len;
	}
	
	function checkId(id, writer){
		
		if(id === writer)
		{
			return true;
		}
		
		return false;
	}
	
	</script>
</body>
</html>