<%@page import="com.fasterxml.jackson.core.sym.Name1"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />


<style type="text/css">


th {
	color: gray;
}

td {
	text-align: left;
}
</style>
</head>
<body style="text-align: center; margin: auto;">

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



    

	<div style="border: thin; width: 800px; margin: auto;">
		
		
		
		<span class="glyphicon glyphicon-gift
" aria-hidden="true" style="font-weight: bold; font-size: 20px;"> 주문조회</span>
		<br> <br>
		<table class="table table-condensed" style="border: 1px solid gray;">
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품명</th>
					<th>가격</th>
					<th>주문 수량</th>
					<th>상품 사이즈</th>
					<th>배송 주소</th>
					<th>배송 상태</th>
				</tr>
			</thead>

			<tbody>

				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<th style="text-align: center; margin-left: 300px;">주문 내역이
								없습니다.</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="vo">
							
						    <!-- 잘못된 get 방식 접근 차단 코드 -->
							<c:choose>
								<c:when test="${login.userId ne vo.orderUserId}">
									<jsp:forward page="warning.jsp" />
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<!-- 잘못된 get 방식 접근 차단 코드 -->
							
							<tr>

								<td><a style="font-weight: bold;" href="/member/readOrder/${vo.orderNum}"
									title="주문번호를 누르면 주문 상세 페이지로 이동" class="btn btn-default">${vo.orderNum}</a></td>

								<td><a style="font-weight: bold;" href="/member/readOrder/${vo.orderNum}"
									title="주문 상세 페이지로 이동">${vo.orderProdName}</a></td>
								<td>${vo.orderProdPrice}</td>
								<td>${vo.orderProdQuantity}</td>
								<td>${vo.orderProdSize}</td>
								<td>${vo.orderUserAddress}</td>
								<td class="pay-value">${vo.orderProdStatus eq 0? '입금 확인 중 <button type="button" class="kakaopay" style="border: none; background: none;"><img src="/resources/img/kakaopayimg.png" style="width: 50px; height: 30px;"></button>' :''
								|| vo.orderProdStatus eq 1? '배송 준비 중':'' 
								|| vo.orderProdStatus eq 2? '배송 중':'' || vo.orderProdStatus eq 3? '배송 완료':''}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>

		</table>


		<jsp:include page="paging_part.jsp">
			<jsp:param value="order" name="list"/>
		</jsp:include>
	</div>
	
	<script type="text/javascript">
		$(".kakaopay").click(function() {
			var orderNum = $(this).parent().prev().prev().prev().prev().prev().prev().text();
			var prodName = $(this).parent().prev().prev().prev().prev().prev().text();
			var prodPrice = $(this).parent().prev().prev().prev().prev().text();
			var prodQuantity =  $(this).parent().prev().prev().prev().text();
			var userId =  "${login.userId}"
			
			$.ajax({
				type: "post",
				url: "/kakaoPay/payReady",
				contentType: "application/json",
				data: JSON.stringify({
					"orderNum" : orderNum,
					"orderProdName" : prodName,
					"orderProdPrice" : prodPrice,
					"orderProdQuantity" : prodQuantity,
					"orderUserId" : userId
				}),
				success:function(result) {
					var json = JSON.parse(result);
					var url = json.next_redirect_pc_url;
					var tid = json.tid;
						$.ajax({
							type: "POST",
							url: "/kakaoPay/getTid",
							contentType: "application/json",
							data: JSON.stringify({
								"tid" : tid,
								"next_redirect_pc_url" : url
							})
						});
					
					window.open(url);
					
				}
			});
			
		});
	</script>
	
</body>
</html>