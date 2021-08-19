<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="UTF-8">
<title>prodList</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/list.css">
</head>
<body>
<div class="container" style="padding:0px;">

<div class="logo">
<a href="/"><img src="/resources/img/3.jpg" height="16px;"/></a>
</div>

<div class="menu_wrap">
		<ul class="dep1">
			<li>
				<a href="/product/prodList?prodCategory=&prodOrder=${prodOrder}">shop</a>
				<ul class="dep2">
					<li><a href="/product/prodList?prodCategory=top&prodOrder=${prodOrder}">top</a></li>
					<li><a href="/product/prodList?prodCategory=bottom&prodOrder=${prodOrder}">bottom</a></li>
					<li><a href="/product/prodList?prodCategory=outer&prodOrder=${prodOrder}">outer</a></li>
					<li><a href="/product/prodList?prodCategory=acc&prodOrder=${prodOrder}">acc</a></li>			            		
				</ul>
			</li>
			<li>
				<a href="#">lookbook</a>
				<ul class="dep2">
					<li><a href="#">21ss</a></li>
					<li><a href="#">20fw</a></li>
					<li><a href="#">20ss</a></li>
					<li><a href="#">19fw</a></li>			            		
				</ul>
			</li>
			<li>
				<a href="#">community</a>
				<ul class="dep2">
					<li><a href="#">notice</a></li>
					<li><a href="#">Q/A</a></li>
					<li><a href="#">review</a></li>
					<li><a href="#">event</a></li>			            		
				</ul>
			</li>
			<li>
				<a href="#">account</a>
				<ul class="dep2">
					<li><a href="/member/loginGet">login</a></li>
					<c:choose>
					<c:when test="${empty login}">
						<li><a id="orderTracking" href="/member/loginGet">ORDER</a></li>
						<script>
						$("a#orderTracking").click(function() {
							alert("로그인이 필요한 작업입니다.")
						});
						</script>
					</c:when>
					<c:otherwise>
						<li><a id="orderTracking"
							href="/member/orderTracking/${login.userId}">ORDER</a></li>
					</c:otherwise>
				</c:choose>
					<li><a href="#" id="moveReadSelf">mypage</a></li>
					<li><a href="/member/cartlist/${login.userId}">cart</a></li>
				</ul>
			</li>
			<li>
			<c:choose>
					<c:when test="${login.userGrade ==1}">
				<a href="#">admin</a>
				<ul class="dep2">
					
						<li><a href="/member/list">member list</a></li>
						<li><a href="/member/managementlist">order list</a></li>
						<li><a href="/product/prodInsert">register product</a></li>
				</ul>
				</c:when>
			<c:otherwise>

			</c:otherwise>

			</c:choose>
			</li>
		</ul>  
	</div>
	<div class="loading">
			<img src="/resources/img/loading.gif">
	</div>

	<div class="prodOrder">
		<ul class="dep3">
			<li>
				<a href="/product/prodList?prodCategory=&prodOrder=${prodOrder}">카테고리</a>
				<ul class="dep4">
					<li role="presentation"><a href="/product/prodList?prodCategory=${prodCategory}&prodOrder=prodSalesCount">판매순</a></li>
  			<li role="presentation"><a href="/product/prodList?prodCategory=${prodCategory}&prodOrder=prodRegdate">신상품</a></li>
  			<li role="presentation"><a href="/product/prodList?prodCategory=${prodCategory}&prodOrder=prodPrice">가격순</a></li>
				</ul>
			</li>
			</ul>
			</div>
	<div class="prodOrder">
		<ul class="nav nav-pills">

		</ul>
	</div>
	<div class="search-wrapper">
  	<div class="input-holder">
  	<form action="/product/prodList?prodCategory=${prodCategory}?prodOrder=${prodOrder}">
    <input type="text" class="search-input" placeholder="Type to search" name="keyword"  />
    <button  value="search" type="submit" class="search-icon search-toggle"><span></span></button>
  	</form>
  	</div>
 	 <span class="close search-toggle"></span>
	</div>
	
	
	<div class="row">
		<c:forEach items="${to.list}" var="item">
			<div class="col-md-3 thumb_list" style="margin: 1px 0; padding;">
				<div class="list_thumbnail">
					<a href="/product/prodRead/${item.prodName}"><img src="${item.prodThumbnail}" style="height:200px;width:200px;" id="scrollImg"></a>
					<p><a href="/product/prodRead/${item.prodName}">${item.prodName}</a></p>
					<p>${item.prodTitle}</p>
					<p>${item.prodPrice}</p>
				</div>
			</div>
		</c:forEach>
		
		</div>
	<br>
    <div class="scroll_paging"></div>
	<div class="scroll_paging"></div>
	</div><!--container end-->
	<form action="/member/readSelf" method="post" hidden="" id="readSelf">
	<input type="hidden" id="readuserId" name="readuserId"
		value="${login.userId}"> <input type="submit" value="회원정보 수정1">
	</form>
	
<a class="scrollToTop"><img src="/resources/img/images.png"></a>
<script type="text/javascript">
	$(document).ready(function() {
		
		var userId = $("#readuserId").val();

		$("#moveReadSelf").click(function() {

			$("#readSelf").submit();

		})
		
		var $searchToggle = $('.search-toggle');

		$searchToggle.on('click', function (e) {
		  var $target = $(this);
		  var $container = $target.closest('.search-wrapper');
		  
		  if (!$container.hasClass('active')) {
		    $container.addClass('active');
		    e.preventDefault();
		  } else if ($container.hasClass('active') && $target.closest('.input-holder').length == 0) {
		    $container.removeClass('active');
		    $container.find('.search-input').val('');
		    
		  }
		});
		
		
		
		var mybutton = document.getElementById("gotoBtn");
    $(".loading").hide();


	$(".scrollToTop").click(function() {
		$("html , body").animate({scrollTop : 0} , 500);

		return false;
	});
	
		$(".loading").hide();
	});
	
	var curPage = 2;
	
	window.onscroll = function(ev) {
	    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
	    	$(".loading").show();
			$.ajax({
				type: "post",
				url: "/product/prodListScroll",
				data: JSON.stringify({
					"curPage" : curPage,
					"prodCategory" : "${prodCategory}",
					"prodOrder" : "${prodOrder}",
					"keyword" : "${keyword}"
				}),
				dataType: "json",
				contentType: "application/json;charset=utf-8",
				success: function(result) {
						for (var i = 0; i <= result.length; i++) {
							var str = 
							'<div class="col-md-3 thumb_list" style="margin:0px;">'+
								'<div class="list_thumbnail">'+
									'<a href="/product/prodRead/'+ (result[i].prodName) +'"> <img src="' +(result[i].prodThumbnail) +  '"style="height:200px;width:200px;"></a>'+
									'<p><a href="/product/prodRead/' + (result[i].prodName) + '">' + (result[i].prodName) + '</a></p>'+
									'<p>' + (result[i].prodPrice) + '</p>'+
								'</div>'+
							'</div>'
								$(".scroll_paging").append(str);
							}
				}
			});
			$(".loading").hide();
			curPage += 1;
		}
			
	};
	
	
</script>


</body>
</html>
