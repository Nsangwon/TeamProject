<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	.h1 {
		text-align: center;
	}
</style>

</head>
<body>

<div class="container">
	<h1 class="h1">결제가 완료되었습니다.</h1>
	<img src="/resources/img/3.jpg" style="width:300px; height:300px;">
	
	<button class="home">홈으로 돌아가기</button>
</div>


<script type="text/javascript">
	$(".home").click(function() {
		$.ajax({
	         type : 'post',
	         url : '/member/orderManagement',
	         data : {
	            orderNum : ${orderNum},
				orderProdStatus : 1,
				orderTrackingNum : 0,
				orderUserId : "${orderUserId}"
	         },
	         dataType : 'text',
	         success: function() {
				location.href="/";
			}
		});
	});
</script>
</body>
</html>