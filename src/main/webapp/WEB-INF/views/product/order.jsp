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
<link rel="stylesheet" href="/resources/css/order.css">
</head>
<body>
	<div class="container">

		<div class="logo">
			<a href="/product/prodList"><img src="/resources/img/3.jpg"
				height="16px;" /></a>
		</div>

		<div class="menu_wrap">
			<ul class="dep1">
				<li><a
					href="/product/prodList?prodCategory=&prodOrder=${prodOrder}">shop</a>
					<ul class="dep2">
						<li><a
							href="/product/prodList?prodCategory=top&prodOrder=${prodOrder}">top</a></li>
						<li><a
							href="/product/prodList?prodCategory=bottom&prodOrder=${prodOrder}">bottom</a></li>
						<li><a
							href="/product/prodList?prodCategory=outer&prodOrder=${prodOrder}">outer</a></li>
						<li><a
							href="/product/prodList?prodCategory=acc&prodOrder=${prodOrder}">acc</a></li>
					</ul></li>
				<li><a href="#">lookbook</a>
					<ul class="dep2">
						<li><a href="#">21ss</a></li>
						<li><a href="#">20fw</a></li>
						<li><a href="#">20ss</a></li>
						<li><a href="#">19fw</a></li>
					</ul></li>
				<li><a href="#">community</a>
					<ul class="dep2">
						<li><a href="#">notice</a></li>
						<li><a href="#">Q/A</a></li>
						<li><a href="#">review</a></li>
						<li><a href="#">event</a></li>
					</ul></li>
				<li><a href="#">account</a>
					<ul class="dep2">
						<li><a href="/member/loginGet">login</a></li>
						<c:choose>
							<c:when test="${empty login}">
								<li><a id="orderTracking" href="/member/loginGet">ORDER</a></li>
								<script>
						$("a#orderTracking").click(function() {
							alert("???????????? ????????? ???????????????.")
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
					</ul></li>
				<li><c:choose>
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

					</c:choose></li>
			</ul>
		</div>

		<div class="row">
			<form action="/product/order" method="post">
				<div class="form-group">
					<img src="${thumanail}"><br> <label>??????&emsp;</label> <input
						value="${vo.prodName}" name="orderProdName" readonly><br>
					<label>??????&emsp;</label> <input value="${vo.prodPrice}"
						name="orderProdPrice" readonly><br> <label>?????????</label>
					<input value="${vo.prodSize}" name="orderProdSize" readonly><br>
					<label>??????&emsp;</label> <input value="${vo.prodQuantity}"
						name="orderProdQuantity" readonly><br>
				</div>



				<div class="form-group">
					<label>??????</label>&emsp;&emsp;&emsp; <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_postcode" name="sample4_postcode"
						placeholder="????????????" readonly required> &emsp; <input
						type="button" onclick="sample4_execDaumPostcode()"
						class="btn btn-default" value="???????????? ??????"><br>
					&emsp;&emsp;&emsp;&emsp;&emsp; <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_roadAddress" name="sample4_roadAddress"
						placeholder="???????????????" readonly required> <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_detailAddress"
						name="sample4_detailAddress" placeholder="????????????" maxlength="60"
						disabled="disabled" required><br> <input
						type="hidden" id="userAddress" name="orderUserAddress">
					<!-- ?????????????????? DTO ????????? adress ??????   ???????????? + ???????????????+  ???????????? = userAdress ??? ?????? -->
					<br>
					<br>
				</div>
				<button type="submit">??????</button>


			</form>

		</div>
	</div>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
function sample4_execDaumPostcode() {
    new daum.Postcode({
    	oncomplete : function(data) {
			// ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.

			// ????????? ????????? ?????? ????????? ?????? ????????? ????????????.
			// ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
			var roadAddr = data.roadAddress; // ????????? ?????? ??????
			var extraRoadAddr = ''; // ?????? ?????? ??????

			// ??????????????? ?????? ?????? ????????????. (???????????? ??????)
			// ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
			if (data.bname !== ''
					&& /[???|???|???]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// ???????????? ??????, ??????????????? ?????? ????????????.
			if (data.buildingName !== ''
					&& data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
			}
			// ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}

			// ??????????????? ?????? ????????? ?????? ????????? ?????????.
			document.getElementById('sample4_postcode').value = "";
			//????????? ?????? ?????? ?????? ?????? ??????
			document.getElementById("sample4_roadAddress").value = "";

			var sample4_roadAddress = document
					.getElementById("sample4_roadAddress").value;
			if (sample4_roadAddress == "") {

				document.getElementById("sample4_roadAddress").value = data.jibunAddress;
			}
			
			if (sample4_roadAddress == "") {

				document.getElementById("sample4_roadAddress").value = roadAddr;
			}
			//???????????? ?????? ?????? ?????? ??????
			document.getElementById('sample4_postcode').value = data.zonecode;
			//????????? ?????? ?????? ?????? ?????? ??????
		
			$('#sample4_detailAddress').attr("disabled", false);
		}
    }).open();
} // ?????? API ??????
	
	
	

</script>

</body>
</html>