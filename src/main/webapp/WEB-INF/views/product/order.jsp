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
					<img src="${thumanail}"><br> <label>상품&emsp;</label> <input
						value="${vo.prodName}" name="orderProdName" readonly><br>
					<label>가격&emsp;</label> <input value="${vo.prodPrice}"
						name="orderProdPrice" readonly><br> <label>사이즈</label>
					<input value="${vo.prodSize}" name="orderProdSize" readonly><br>
					<label>수량&emsp;</label> <input value="${vo.prodQuantity}"
						name="orderProdQuantity" readonly><br>
				</div>



				<div class="form-group">
					<label>주소</label>&emsp;&emsp;&emsp; <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_postcode" name="sample4_postcode"
						placeholder="우편번호" readonly required> &emsp; <input
						type="button" onclick="sample4_execDaumPostcode()"
						class="btn btn-default" value="우편번호 찾기"><br>
					&emsp;&emsp;&emsp;&emsp;&emsp; <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_roadAddress" name="sample4_roadAddress"
						placeholder="도로명주소" readonly required> <input
						style="border-left-width: 0; border-right-width: 0; border-top-width: 0; border-bottom-width: 1;"
						type="text" id="sample4_detailAddress"
						name="sample4_detailAddress" placeholder="상세주소" maxlength="60"
						disabled="disabled" required><br> <input
						type="hidden" id="userAddress" name="orderUserAddress">
					<!-- 컨트롤러에서 DTO 작업시 adress 값은   우편번호 + 도로명주소+  상세주소 = userAdress 로 처리 -->
					<br>
					<br>
				</div>
				<button type="submit">주문</button>


			</form>

		</div>
	</div>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
function sample4_execDaumPostcode() {
    new daum.Postcode({
    	oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== ''
					&& /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== ''
					&& data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
			}
			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('sample4_postcode').value = "";
			//도로명 주소 값을 공백 칸에 삽입
			document.getElementById("sample4_roadAddress").value = "";

			var sample4_roadAddress = document
					.getElementById("sample4_roadAddress").value;
			if (sample4_roadAddress == "") {

				document.getElementById("sample4_roadAddress").value = data.jibunAddress;
			}
			
			if (sample4_roadAddress == "") {

				document.getElementById("sample4_roadAddress").value = roadAddr;
			}
			//우편주소 값을 공백 칸에 삽입
			document.getElementById('sample4_postcode').value = data.zonecode;
			//도로명 주소 값을 공백 칸에 삽입
		
			$('#sample4_detailAddress').attr("disabled", false);
		}
    }).open();
} // 주소 API 종료
	
	
	

</script>

</body>
</html>