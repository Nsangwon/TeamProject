/**
 * 
 */
 function makePage(beginPageNum, finishPageNum, curPage){
	var str = '';      
	var checkActive; 
	for(var i = beginPageNum; i<=finishPageNum; i++){
		checkActive = (curPage == i ? 'active' : '');
		str += '<li><a class="qPageNum ' + checkActive + '" href="" id="' + i + '">' + i + '</a></li>';
	}
      
	var msg =`
				<nav aria-label="Page navigation">
  					<ul class="pagination qPagination">
    					<li style="float: left;">
      						<a href="#" aria-label="Previous" class="qPrev" id="qPrev">
        						<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						${str}
						<li style="float: right;">
							<a href="#" aria-label="Next" class="qNext" id="qNext">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</nav>
			`;
			
   return msg;
}

  function getList(qTitle, qWriter, qUpdatedate, qContent, qQno, qRepindent, qUserId)
 {
 	var msg = `
 				<div class="row" style="margin-top: 0px;">
 					<div class="userId" style="display: none;" id="qUserId">${qUserId}</div>
					<a style="float: left; margin-bottom: 0px; margin-left: 30px;" class="toggleText">
					${qTitle}
					</a>
					&nbsp;<img class="included" src="/resources/img/private.png">
					<div style="float: right; margin-right: 30px;">
						<b>${qWriter}</b>&nbsp;&nbsp;&nbsp;&nbsp; 
						${qUpdatedate}
					</div>
				</div>
				<hr class="subHorizental">
				<div class="collapse passwordBox" style="word-break: break-all; margin: auto; width:550px; height: 160px;">
					<br>
					<br>
					<div style="text-align: center; margin-left: -10px;">비밀번호를 입력해 주세요</div>
					<br>
					<div class="inputSet" style="text-align: center; margin-left: 45px; margin-top: 0px;">
						<input type="password" class="insertPw"/>
						<button type="button" class="btn btn-secondary enter" style="margin-left: 10px;  margin-top: -2.5px;">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
				</div>
				<div class="collapse contentBox" style="display: none; word-break: break-all; margin: auto; width:550px; position: relative;">
					<div style="white-space: pre-line;" class="questionContent">${qContent}</div>
					<br>
					<br>
					<div class="collapse buttonDiv" style="position: absolute; right:0px; bottom: 0px; margin-top: -20px;">
					</div>
					<div class="qQno" style="display: none" id="qQno">${qQno}</div>
					<div class="qRepindent" style="display: none" id="qRepindent">${qRepindent}</div>
				</div>
				<div class="collapse"><hr class="subHorizental"></div>
			`;
			
	return msg;
 }
 
   function getAnswerList(qTitle, qWriter, qUpdatedate, qContent, qQno, qRepindent, qUserId)
 {
 	var msg = `
 				<div class="row" style="margin-top: 0px;">
 					<div class="userId" style="display: none;" id="qUserId">${qUserId}</div>
					<a style="float: left; margin-bottom: 0px; margin-left: 30px;" class="toggleText">
					&nbsp;&nbsp;&nbsp;↪&nbsp;${qTitle}
					</a>
					&nbsp;<img class="included" src="/resources/img/private.png">
					<div style="float: right; margin-right: 30px;">
						<b>${qWriter}</b>&nbsp;&nbsp;&nbsp;&nbsp; 
						${qUpdatedate}
					</div>
				</div>
				<hr class="subHorizental">
				<div class="collapse passwordBox" style="word-break: break-all; margin: auto; width:550px; height: 160px;">
					<br>
					<br>
					<div style="text-align: center; margin-left: -10px;">비밀번호를 입력해 주세요</div>
					<br>
					<div class="inputSet" style="text-align: center; margin-left: 45px; margin-top: 0px;">
						<input type="password" class="insertPw"/>
						<button type="button" class="btn btn-secondary enter" style="margin-left: 10px;  margin-top: -2.5px;">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div> 
				</div>
				<div class="collapse contentBox" style="display: none;word-break: break-all; margin: auto; width:550px; position: relative;">
					<div style="white-space: pre-line;" class="questionContent">${qContent}</div>
					<br>
					<br>
					<div class="collapse buttonDiv" style="position: absolute; right:0px; bottom: 0px; margin-top: -20px;">
					</div>
					<div class="qQno" style="display: none" id="qQno">${qQno}</div>
					<div class="qRepindent" style="display: none" id="qRepindent">${qRepindent}</div>
				</div>
				<div class="collapse"><hr class="subHorizental"></div>
			`;
			
	return msg;
 }