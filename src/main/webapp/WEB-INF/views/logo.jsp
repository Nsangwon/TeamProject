<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>​
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
body{
font-family: 'Noto Sans KR', sans-serif;
}

*{
	margin: 0;
	padding: 0;
}
ui , li {
	list-style: none;
}
a {
	text-decoration: none;
	color: inherit;
}
.menu_wrap .dep1 > li {
	display: inline-block;
	width: 100px;
	vertical-align : top;
	text-align: center;
	font-size: 13px;
}
.menu_wrap .dep1 > li:hover > .dep2{
	display: block;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}
.menu_wrap .dep1 > li > a {
	display: block;
	padding: 10px 0;
}
.menu_wrap .dep2{
	display: none;
	padding: 10px 0;
} 
.menu_wrap .dep2 a:hover{
	text-decoration: initial;
}
.menu_wrap .dep1 > li {
	display: inline-block;
	width: 100px;
	vertical-align : top;
	text-align: center;
	font-size: 16px;
	position:relative;
}
.logo > a > img {
  width: 300px;
  height: 150px;
  display : block;
  margin : auto;
}
.dep2{
	position: absolute;
	left:0;
	top:40px;
	z-index: 10000;
	width: 100%;
	background : rgba(255,255,255,0.7);
	}

.dep1{
	text-align:center;
}
.prodOrder .dep3 > li {
	display: inline-block;
	width: 100px;
	vertical-align : top;
	text-align: center;
	font-size: 13px;
}
.prodOrder .dep3 > li:hover > .dep4{
	display: block;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}
.prodOrder .dep3 > li > a {
	display: block;
	padding: 10px 0;
}
.prodOrder .dep4{
	display: none;
	padding: 10px 0;
} 
.prodOrder .dep4 a:hover{
	text-decoration: initial;
}
.prodOrder .dep3 > li {
	display: inline-block;
	width: 100px;
	vertical-align : top;
	text-align: center;
	font-size: 16px;
	position:relative;
}

.dep4{
	position: absolute;
	left:0;
	top:40px;
	z-index: 10000;
	width: 100%;
	background : rgba(255,255,255,0.7);
	}

.dep3{
	text-align:right;
}
.row > img{
	width: 900px;
	display: block;
	margin-left: 150px;
	margin-top: 50px;
}
</style>
</head>
<body>
<div class="container">
<div class="logo">
<a href="/product/prodList"><img src="/resources/img/3.jpg" height="16px;"/></a>
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
					<c:choose>
					<c:when test="${empty login}">
						<li><a href="/member/loginGet">LogIn</a></li>
						<li><a class="empty_login" href="/member/loginGet">ORDER</a></li>
						<li><a class="empty_login" href="/member/loginGet">CART</a></li>
						<script>
						$("a.empty_login").click(function() {
							alert("로그인이 필요한 작업입니다.")
						});
						</script>
					</c:when>
					<c:otherwise>
						<li><a href="/member/logout">LogOut</a></li>
						<li><a id="orderTracking"
							href="/member/orderTracking/${login.userId}">ORDER</a></li>
						<li><a href="/member/cartlist/${login.userId}">CART</a></li>
					</c:otherwise>
				</c:choose>
					<li><a href="#" id="moveReadSelf">mypage</a></li>
					
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
	</div><!--menu wrap end  -->
	<div class="row">
		<img  src="/resources/img/new_main.jpg">
	</div>
	<form action="/member/readSelf" method="post" hidden="" id="readSelf">
	<input type="hidden" id="readuserId" name="readuserId"
		value="${login.userId}"> <input type="submit" value="회원정보 수정1">
	</form>
</div><!--container end  -->
<script type="text/javascript">
	$(document).ready(function() {
		
		var userId = $("#readuserId").val();

		$("#moveReadSelf").click(function() {

			$("#readSelf").submit();

		})
		
		
	});

</script>
</body>
</html>