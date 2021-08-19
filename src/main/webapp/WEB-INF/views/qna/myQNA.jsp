<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="UTF-8">
<title>My QNA</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/resources/css/qna/qnaPage.css?ver=1">
<style type="text/css">
th {
	color: gray;
}

td {
	text-align: left;
}
</style>
</head>
<body style="text-align: center;margin: auto;">

	<c:choose>
		<c:when test="${empty login}">
			<script type="text/javascript">
				alert("로그인이 필요한 작업입니다.")
				location.href = "/member/loginGet"
			</script>

		</c:when>
		<c:otherwise>


		</c:otherwise>

	</c:choose>

	<jsp:include page="../main_menu.jsp" />

	<br><br><br><br>
	
	<div class="container qnaBoard" style="border: 2px solid grey; width: 750px; margin: auto">
		<br>
		<div class="row" style="width: 700px; margin: auto;">
			<h1
				style="float: left; margin-top: 15px; margin-left: 30px; font-size: 34px; font-weight: bold;">내
				문의</h1>
			<br> <br> <br>
			<hr class="mainHorizental">
			<div class="qnaList" id="qnaList"></div>
			<br>
			<div class="qnaPage" id="qnaPage" style="text-align: center; margin-bottom: 0px;">
				<nav aria-label="Page navigation">
  					<ul class="pagination qPagination">
						<c:forEach var="i" begin="${to.beginPageNum }" end="${to.finishPageNum }">
							<c:choose>
								<c:when test="${i == to.curPage }">
									<li><a class="qPageNum active" href="#" id="i">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="qPageNum" href="#" id="i">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${to.curPage != to.finishPageNum }">
								<li style="float: right;">
									<a href="#" aria-label="Next" class="qNext" id="qNext">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:when>
						</c:choose>
					</ul>
				</nav>
			</div>
			<c:choose>
				<c:when test="${to.finishPageNum != 1 }">
					<button type="button" class="btn btn-primary btn-xs goFirst"
					style="margin-left: -640px; height: 30px; margin-top: -52px;">처음으로</button>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</div>
		<br>
	</div>
	<br><br><br><br>
	<script type="text/javascript" src="/resources/js/myqna.js"></script>
	<script type="text/javascript">
	//< 로그인 정보
	var qUserId = "${login.userId}";
	
	//< 게시글 번호 변수
	var qQno;
	
	//< pagination 변수
	var qCurPage = 1;
	var qBeginPageNum;
	var qFinishPageNum;
	var qTotalPage;
	
	$(document).ready(function() {
		
		getPageList(qUserId,qCurPage);
		
		//< (전체) 확장 기능
		$("#qnaList").on("click", ".toggleText", function() {

			//< Qno 가져오기
			qQno = $(this).parent().next().next().children('div.qQno').text();
			
			//< 제목~본문 구분선
			var hr = $(this).parent().next().next().next("div");
			
			//< 본문 내용
			var contentBox = $(this).parent().next().next("div");
			
			//< 본문과 답글 구분용 (들여쓰기 0 : 본문 / 1 : 답글)
			var checkRepRoot = $(this).parent().next().next("div").children('div.qRepindent').text();
			
			//< 버튼 좌표 저장용 (본문 삭제)
			var optionBtns = $(this).parent().next().next().children('div.buttonDiv');
			
			//< 버튼 저장용 div 태그 초기화
			optionBtns.empty();
			
			//< 본문
			if(parseInt(checkRepRoot) != 1)
			{
				//< 작성자
				var questionMsg = `
					<button type="button" class="btn btn-outline-dark btn-xs delete">
						Delete
					</button>
				`;
		
				optionBtns.html(questionMsg);
			}
			
			//< 본문내용이 확장 되어있을 경우
			if( contentBox.is(":visible") ){
				//< 축소
				contentBox.slideUp();
			}
			else{
				//< 축소된 본문내용 확장
				contentBox.slideDown();
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
					
					getPageList(qUserId, qCurPage);
					
					alert("삭제 되었습니다.");
				}
			});
		});
		
		//< 첫 페이지으로 이동
		$(".goFirst").click(function(event){
			if(qCurPage != 1)
			{
				getPageList(qUserId, 1);
			}
			else
			{
				alert("처음 페이지 입니다.");
			}
		});
		
		//< pagination 기능
		//< 숫자버튼
		$("#qnaPage").on("click", ".qPageNum", function() {
			
			if(qCurPage != $(this).text())
			{
				qCurPage = $(this).text();
				
				getPageList(qUserId, $(this).text());
			}
		});
		
		//< 이전으로
		$("#qnaPage").on("click", ".qPrev", function() {
			
			if(qCurPage != qBeginPageNum)
			{
				getPageList(qUserId, qBeginPageNum);
			}
			else
			{
				getPageList(qUserId, qBeginPageNum - 5);
			}
			
		});
		
		//< 다음으로
		$("#qnaPage").on("click", ".qNext", function() {
			
			if(qCurPage != qFinishPageNum)
			{
				getPageList(qUserId, qFinishPageNum);
			}
			else
			{
				getPageList(qUserId, qBeginPageNum + 5);
			}
		});
	});
	
	function getPageList(userId,pageIndex) {
		$("#qnaList").empty();
		
		//< qTitle, qWriter, qUpdatedate, qPassword, qContent
		$.getJSON("/qnaPage/myList/" + userId + "/" + pageIndex , function(data){
			
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
			var prodNameList = data.prodNameList;
			
			for(var i = 0; i < qnaList.length; i++)
			{
				var obj = qnaList[i];
				var prodName = prodNameList[i];
				
				//< 답글일 경우
				if(obj['qRepindent'] != 0)
				{
					var list = getAnswerList(obj['qTitle'], obj['qWriter'], obj['qUpdatedate'], obj['qContent'], obj['qQno'], obj['qRepindent'], obj['qUserId'], prodName);
				}
				//< 본문일 경우
				else
				{
					var list = getList(obj['qTitle'], obj['qWriter'], obj['qUpdatedate'], obj['qContent'], obj['qQno'], obj['qRepindent'], obj['qUserId'], prodName);
				}
				
				list.replace(/\n/gi, "<br>");
				
				$("#qnaList").append(list);
			 }
		});
	}
	
	</script>
</body>
</html>