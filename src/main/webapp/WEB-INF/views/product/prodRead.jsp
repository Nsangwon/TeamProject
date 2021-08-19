<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="UTF-8">
<title>prodRead</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/read.css">

<style type="text/css">
	.content {
		border: solid 1px;
		width: 800px;
		min-height: 600px;
		text-align: center;
		margin: 0 auto;
	}
	
	.content-contatiner {
		text-align: center;
	}
	
	.thumb-part {
		margin-left: 100px;
		display: inline-block;
	}
	
	#content {
		display: inline-block;
	}
	
	.top-part {
		text-align: center;
	}
	
	#info {
	text-align: left;
	padding-top: 30px;
	}
	.scrollToTop > img{
	
	
	width:40px;
	float: right;
	position: fixed; /* 포지션 고정 */ 
	right: 2%; /* 오른쪽에서 2% - %도 할수 있음*/ 
	bottom: 50px; /* 밑에서 5px */ 

}
</style>

</head>
<body>
	<div class="container">
	
		
	
<div class="menu_wrap">
		<jsp:include page="../main_menu.jsp"/>  
	</div>
		<div class="top-part">
		<div class="row" id="info">
   	   	    <p style="font-size: 30px;">${vo.prodName}</p>
			<p style="font-size: 20px;">${vo.prodTitle}</p>
			<p style="font-size: 15px;">PRICE : &nbsp;&nbsp;&nbsp; ${vo.prodPrice}</p>
			<select class="select" name="prodSize" id="prodSize">
					<option value="${dto.prodStockSSize}">S</option>
					<option value="${dto.prodStockMSize}">M</option>
					<option value="${dto.prodStockLSize}">L</option>
			</select>
   	   	    <form id="orderForm" action="/product/order" method="get">
			<input type="hidden" value="${vo.prodName}" name="prodName">
			<input type="hidden" value="${vo.prodPrice}" name="prodPrice">
			<span style="font-size: 15px;">SIZE &nbsp;:&nbsp;&nbsp;&nbsp;</span>
				<select class="form-select" name="prodSize" id="prodSizeForm">
					<option value="prodStockSSize">S</option>
					<option value="prodStockMSize">M</option>
					<option value="prodStockLSize">L</option>
				</select><br>
				<br>
				<button type ="button" onclick="amountCount('p')">+</button>
				<input type="number" id="amount" name="prodQuantity" value="1" min="1" style="text-align:center;" readonly/>
				<button type="button" onclick="amountCount('m')">-</button>
				</form>
				<br>
				<a class="cart_insert_btn">CART&nbsp;</a>|<a class="order">&nbsp;ORDER</a>
				
		</div> <!-- end of row -->
		
		
		<div class="row" id="content">
		</div>
		<div class="row thumb-part" id="button">
			<img src="${vo.prodThumbnail}" style="height: 300px; width: 300px;"> <br>
			<c:choose>
			<c:when test="${login.userGrade == 1}">
			<a class="update">&nbsp;&nbsp;UPDATE&nbsp;&nbsp;</a>|
			<a class="list">&nbsp;&nbsp;LIST&nbsp;&nbsp;</a>|
			<a class="delete">&nbsp;&nbsp;DELETE</a>
			</c:when>
			</c:choose>
		</div>
		</div>
		<form id="deleteForm" action="/product/prodDelete/${vo.prodName}?prodBno=${vo.prodBno}" method="post"></form>
		</div> <!-- end of container -->
		<form action="/member/readSelf" method="post" hidden="" id="readSelf">
		<input type="hidden" id="readuserId" name="readuserId"
		value="${login.userId}"> <input type="submit" value="회원정보 수정1">
		</form>
		<div class="content-container">
			<div class="content">
				<div>
					<br>
					${vo.prodContent}
					<br>
				</div>
			</div>
		</div>
		
		
	<jsp:include page="/WEB-INF/views/qna/qnaPage.jsp" />
	<a class="scrollToTop"><img id="scrollToTopbtn" src="/resources/img/images.png"></a>
	<jsp:include page="/WEB-INF/views/prodBoard/review.jsp"/>
	
	
<script type="text/javascript">
	$(document).ready(function() {
		
		$(window).scroll(function() { 
			
			if ($(this).scrollTop() > 250) { //250 넘으면 버튼이 보여짐니다.
			
				$('.scrollToTopbtn').fadeIn(); 
			
			} else { 
				
				$('.scrollToTopbtn').fadeOut(); 
			
			} 
			});

			

			
		
		
		
		$(".scrollToTop").click(function() {
			$("html , body").animate({scrollTop : 0} , 500);

			return false;
		});
		
		$(".order").click(function() {
			$("#orderForm").submit();
		});
		
		
		$(".select").hide();
		
		var userId = $("#readuserId").val();

		$("#moveReadSelf").click(function() {

			$("#readSelf").submit();

		})
		
		$("#sizes").hide();
		$("#sizem").hide();
		$("#sizel").hide();
		
		
		 $(".cart_insert_btn").click(function() {
	    		event.preventDefault();

	    		if (${empty login}) {
	                alert("로그인이 필요한 작업입니다.");
	                return false;
	                
	             } else {
	                $.ajax({
	                   type : 'post',
	                   headers : {
	                      'Content-Type' : 'application/json',
	                      'X-HTTP-Method-Override' : 'POST'
	                   },
	                   url : '/carts/cart',
	                   data : JSON.stringify({
	                      userId : '${login.userId}',
	                      prodName : '${vo.prodName}',
	                      prodSize : $("#prodSizeForm option:selected").text(),
	                      amount : $("#amount").val()
	                   }),
	                   dataType : 'text',
	                   success : function(result) {
	                      if (result == "1") {
	                         alert("저장하였습니다. \n(중복된 상품이면 상품 개수만 추가됩니다.)");
	                      } else {
	                         alert("장바구니 저장에 실패하였습니다.");
	                      }
	                   }
	                });
	             }
	          });
	      
	  
		
		$(".list").click(function() {
			location.assign("/product/prodList");
		});
		
		
		$(".update").click(function() {
			location.assign("/product/prodUpdate/${vo.prodName}");
		});
		
		$(".delete").click(function() {
			$("#deleteForm").submit();
		});
		
	});
	
	function amountCount(type){
		   var amount = Number($("#amount").val());
		   
		    if(type == 'p') {
		    	if (amount < $('#prodSize option:selected').val()) {
		    		$("#amount").val(Number(amount)+1);
				}
		        
		    } else {
		        if(amount > 1) {
		        	$("#amount").val(Number(amount)-1);
		        }
		    }
		}

</script>
	

</body>
</html>