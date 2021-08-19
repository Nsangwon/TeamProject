<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="/resources/js/product.js?ver=123" type="text/javascript"></script>
<link href="/resources/css/star.css" type="text/css"  rel="stylesheet">

 <!-- !important 우선권으로 적용 -->
</head>
<body>
   <div class="container reviewBody" >
      <div class="row">
         <h1 class="jumbotron text-center"><span class="glyphicon glyphicon-gift">상품평<span class="glyphicon glyphicon-edit"></h1>   
            
      <a class="btn btn-default review" style="margin: 0px 723px;">작성&nbsp<span class="glyphicon glyphicon-pencil"></a>   
      </div>
      
   
   <div class="row">
      <div class="collapse" id="review_reply">
           <div class="well">
             <div class="form-group">
                <c:choose>
                  <c:when test="${!empty login }">
                      <label for="reWriter">&nbsp<span class="glyphicon glyphicon-user">&nbsp작성자</label>
                     <input name="reWriter" id="reWriter" class="form-control"
                     value="${login.userName}" readonly>
                  </c:when>
                  <c:otherwise>
                     <label for="reWriter">작성자</label>
                     <input name="reWriter" id="reWriter" class="form-control"
                     placeholder="비회원은 댓글을 수정하실수 없습니다.">
                  </c:otherwise>
               </c:choose>
             </div>
             
             <div class="form-group">
                <label for="reContent">&nbsp<span class="glyphicon glyphicon-comment">&nbsp글내용</label> 
                <textarea  style="resize:horizontal; width:760px; height:200px; " rows="10" name="reContent" id="reContent" class="form-control reContent" placeholder="500자 이내로 입력해주세요."></textarea>
                <p style="text-align: right;">
                <span class="badge reContentLength">0</span><span>/500</span>
                </p>
             </div>
             
             <div class="form-group stars" id="reStar"> 
                
             </div>
                          
             <div class="form-group" style="text-align: right;">
             
                <button  class="btn btn-default review_insert_btn ">등록&nbsp<span class="glyphicon glyphicon-ok"></button>
             </div>
           </div>
      </div>
   </div>   
   
   

   
   
   
   <div id="reviewList" class="row" style="margin: 10px -15px; width: 797px;"></div>
   <div id="reviewList_page" class="reviewList_page" style="text-align: center;"> </div>
   	<a type="button" class="btn btn-default btn reGoFirst"
				style="height: 32px; margin: -52px -13px;">첫 페이지</a>
				
	<button type="button" class="btn btn-default btn reGoLast"
				style="height: 32px; margin: -52px 694px;">끝 페이지</button>
  
   </div>

<!--리뷰 댓글 수정 글내용이 최대 값을 넘무가면 등록 버튼 비활성화하게 해야 한다.  -->
   <div class="row">
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            
              <h4 class="modal-title" style="text-align: center;">댓글수정</h4>
              <h4 class="modal-title" id="modal_reRno">reRno</h4>
            </div>
            <div class="modal-body">
            
            <div class="form-group">
               <c:choose>
                  <c:when test="${!empty login}">
                  <label for="reWriter_update">&nbsp<span class="glyphicon glyphicon-user"></label>
                     <input name="reWriter" id="reWriter_update" class="form-control"
                     value="${login.userName}" readonly>
                  </c:when>
                  <c:otherwise>
                     <label for="reWriter_update">작성자</label>
                     <input  name="reWriter" id="reWriter_update" class="form-control">
                  </c:otherwise>
               </c:choose>
                  </div>
              <div class="form-group">
                     <label for="reContent_update">&nbsp<span class="glyphicon glyphicon-comment"></label>
                     <textarea   style="resize:vertical; width:570px; height:120px; " 
                     id="reContent_update" name="reContent" class="form-cotrol reContent_update"></textarea>
                     <p style="text-align: right;">
                <span class="badge reContent_updateLength">0</span><span>/500</span>
                </p><br>
            <div>
               <input id="reStar_update" name="reStar" value="1">
            </div>
            </div>
            
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default review_update_btn" data-dismiss="modal" id="review_update_btn"><span class="glyphicon glyphicon-ok"></button>
              <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></button>
            </div>
          </div>
        </div>
      </div>
   </div>
   
   
   <script type="text/javascript">
   var reBno = ${vo.prodBno};   //상품게시판에서 게시판 번호 가져오기
   var reviewCurPage = 1;
   var reviewBeginPageNum;
   var reviewFinishPageNum;
   var reviewTotalPage;
   
   var page = 1;   //페이지 값은 1로 정의
   

   var reUserGrade  = "${login.userGrade}";
   var reUserName = "${login.userName}";
   
   
   $(document).ready(function(){
         getReviewList(reBno,page);
         
         //수정시 별점 및 댓글번호 수정하지 못하게 제한
         $("#reStar_update").hide();
         $("#modal_reRno").hide();
         
         
         
         //리뷰 댓글의 수정
         $("#review_update_btn").click(function(event) {
            event.preventDefault();
            var reRno = $("#modal_reRno").text();
            var reWriter = $("#reWriter_update").val();
            var reContent = $("#reContent_update").val();
            var reStar= $("#reStar_update").val();
            
            
            
            $.ajax({
               type : 'put',
               url : '/review/reply',
               headers : {
                  'Content-Type' : 'application/json',
                  'X-HTTP-Method-Override' : 'PUT'
               },
               data : JSON.stringify({
                  reRno : reRno,
                  reWriter : reWriter,
                  reContent : reContent,
                  reStar : reStar
               }),
               dataType : 'text',
               success : function(result) {
                  if(result == "1"){
                	  
                     alert("수정되었습니다.");
                     $("#reviewList").text("");
                     getReviewList(reBno,page);
                  }else{
                     alert("수정되지 않았습니다.");
                  }
               }
            });
         });
         //수정 창에 값 불러오기(모달)
         $("#reviewList").on("click", ".review_btn_update_form", function(event) {
            event.preventDefault();
            var that = $(this);
            var reRno = that.parent().attr("data-reRno");
            
            var reWriter = that.parent().attr("data-reWriter");
            
            var reContent = that.parent().prev("p").text();
            var reStar = that.parent().attr("data-reStar");
            
            
            $("#modal_reRno").text(reRno);
            $("#reWriter_update").val(reWriter);
            $("#reContent_update").val(reContent);
            $("#reStar_update").val(reStar);
         });
         //삭제
         $("#reviewList").on("click", ".review_btn_delete", function(event) {
            event.preventDefault();
            var that = $(this)
            var reRno = that.parent().attr("data-reRno");
            
            $.ajax({
               type : 'delete',
               url : '/review/reply',
               headers : {
                  'Content-Type' : 'application/json',
                  'X-HTTP-Method-Override' : 'DELETE'
               },
               data : JSON.stringify({
                  reRno : reRno
               }),
               dataType : 'text',
               success : function(result) {
                  if(result == "1"){
                     alert("삭제되었습니다.");
                     that.parent().parent().remove();
                  }else{
                     alert("삭제되지 않았습니다.");
                  }
                  $("#reviewList").html("");
                  getReviewList(reBno,page);
               }
            });
         });
         
         //리뷰 생성 태그 숨기기 및 보이기
         $(".review").click(function() {
            $("#review_reply").toggle();  
            
         });
         
         //별점
         star(".stars");
         
         //리뷰댓글 생성시 - 현재 글내의 글자 수 만큼 값 표시 
         $("#reContent") .keyup(function(event){
               event.preventDefault();
               var reContent = $(this);
               var reContentLength = reContent.val().length;
               $(".reContentLength").text(reContentLength);
                   
               if(reContentLength > 500){               
                  reContent.attr("class","alert-danger");
                  $(".review_insert_btn").attr("disabled","disabled");
               }else{
                  reContent.removeClass("alert-danger");
                  $(".review_insert_btn").removeAttr("disabled");
                  
               }
            });
         
         //리뷰댓글 수정시 - 현재 글내의 글자 수 만큼 값 표시
         $("#reContent_update") .keyup(function(event){
               event.preventDefault();
               var reContent_update = $(this);
               var reContent_updateLength = reContent_update.val().length;
               $(".reContent_updateLength").text(reContent_updateLength);
                   
               if(reContent_updateLength > 500){               
            	   reContent_update.attr("class","alert-danger");
                  $(".review_update_btn").attr("disabled","disabled");
               }else{
            	   reContent_update.removeClass("alert-danger");
                  $(".review_update_btn").removeAttr("disabled");
                  
               }
            });
         
         //리뷰 생성
         $(".review_insert_btn").click(function(event) {
            event.preventDefault();
            
            var reWriter = $('#reWriter').val();
            var reContent = $('#reContent').val();
            var reStar = $(".stars").attr("data-val");
         
         
            
            $.ajax({
            type : 'post',
            url : '/review/reply',
            headers : {
               'Content-Type' : 'application/json',
                  'X-HTTP-Method-Override' : 'POST'
            },
            data: JSON.stringify({
               reBno : reBno,
               reWriter : reWriter,
               reContent : reContent,
               reStar : reStar
            }),
            dataType : 'text',
            success : function(result) {
               alert(result);
               $("#reContent").val("");
               $("#reviewList").html("");
               $(".reContentLength").text(" ");
               getReviewList(reBno,page);
               }
            });
         });
         
     	//< 처음 페이지
 		$(".reGoFirst").click(function(event){
 			event.preventDefault();

 			if(reviewCurPage != 1)
 			{
 				getReviewList(reBno, 1);
 			}
 			else
 			{
 				alert("처음 페이지 입니다.");
 			}
 		});
         
 		//< 끝 페이지
 		$(".reGoLast").click(function(event){
 			event.preventDefault();
 
 			if(reviewCurPage != reviewTotalPage)
 			{
 				getReviewList(reBno, reviewTotalPage);
 			}
 			else
 			{
 				alert("끝 페이지 입니다.");
 			}
 		});
 		
     	
         //페이지 값 가져오기
         $("#reviewList_page").on("click", ".pageNum", function() {

            var page = $(this).text();
            
            if(page != reviewCurPage)
            {
               getReviewList(reBno,page);
            }
         });
         //이전 페이지 기능
         $("#reviewList_page").on("click", ".rePrev", function() {

               if(reviewCurPage != reviewBeginPageNum)
               {
                  var page = reviewBeginPageNum;   
                  getReviewList(reBno, page);
               }
               else
               {
                  var page = reviewBeginPageNum-5;
                  getReviewList(reBno, page);
               }
               
            });
         //다음 페이지 기능
         $("#reviewList_page").on("click", ".reNext", function() {

                if(reviewCurPage != reviewFinishPageNum)
             {
                 reviewCurPage = reviewFinishPageNum;
                   getReviewList(reBno, reviewCurPage);
             }
             else
             {
                reviewCurPage = reviewBeginPageNum+5;
               getReviewList(reBno, reviewCurPage);
             }
               
            });
         //
         
      
   });
      
      //리뷰 목록 리스트에 별점기능은 리스트가 여러가지이며 동적으로 기능되어 클래스 값으로 배열을 이용
      function getReviewList(reBno,page) {
         $("#reviewList").empty();
         
         
         var url = "/review/reply/"+reBno+"/"+page;
         $.getJSON(url, function(data) {
            
            reviewCurPage = data.curPage;
            reviewBeginPageNum = data.beginPageNum;
            reviewFinishPageNum = data.finishPageNum;
            reviewTotalPage = data.totalPage;
            
            //페이지 목록 이전/숫자/다음   조건식으로는 첫 페이지일 경우 이전을 숨기고 마지막 페이지일 경우 다음을 숨긴다.
            var rePage = makeReviewPage(reviewBeginPageNum, reviewFinishPageNum, reviewCurPage);            
            $("#reviewList_page").html(rePage);   
            
            if(reviewCurPage == 1){ 
               $("#rePrev").hide();
            }else{
               $("#rePrev").show();
            }
            
            if(reviewCurPage == reviewTotalPage){
               $("#reNext").hide();
            }else{
               $("#reNext").show();
            }
            
          //댓글이 적어 페이지가 존재 하지않는다면 첫,끝페이지 이동 버튼 숨기기 없으면 너무 휑하다.
     	/*	console.log(reviewTotalPage);
     		  if(reviewTotalPage==1){
              	$(".reGoFirst").hide();
              	$(".reGoLast").hide();
              }else{
            	$(".reGoFirst").show();
                $(".reGoLast").show();
              }*/
            
            var dummyData = data.list;
            reviewList(dummyData);      
            
            $(".reRnoHide").hide();
            
            
            //비화원(결제 불가)은 다른이의 글의 삭제 및 수정,생성 제한
            $(".review_btn_update_form").hide();
            $(".review_btn_delete").hide();
            $(".review").hide();
            
            
            //회원만 리뷰작성을 할수 있게 했습니다.
            if(reUserName){
            $(".review").show();            	
            }
            
            //관리자 로그인시 삭제만 가능 및 생성 제한
             if(reUserGrade == 1){   		
            	$(".review_btn_delete").show();
            	 $(".review").hide();
            }

             
             //일반회원이 로그인시 자신의 글만 수정및 삭제
             for(var i=0;i<dummyData.length;i++){
               var reUserNameArr = dummyData[i];
               var review_btn_update_formArr = $(".review_btn_update_form");
                var review_btn_deleteArr = $(".review_btn_delete");
               
                 if(reUserName == reUserNameArr.reWriter){
                    review_btn_update_formArr[i].style.display="inline";
                    review_btn_deleteArr[i].style.display="inline";
                 } 
               }
            
         });
      }
   
   </script>
</body>
</html>