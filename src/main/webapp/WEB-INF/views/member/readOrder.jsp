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
input {
	width: 400px;
	border-left-width: 0;
	border-right-width: 0;
	border-top-width: 0;
	border-bottom-width: 1;
	text-align: center;
}

h3 {
	font-weight: bold;
}

span {
	font-weight: bold;
	margin-right: 40px;
}

.correct {
	color: green;
}

.incorrect {
	color: red;
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

	<br>
	<br>
	<h3>주문조회 및 배송주소 수정</h3>
	<br>
	<br>

	<span>주문번호</span>
	<input type="text" value="${vo.orderNum}" readonly>
	<br>
	<br>
	<span>상 품 명</span>
	<input type="text" value="${vo.orderProdName}" readonly>
	<br>
	<br>
	<span>개당가격</span>
	<input type="text" value="${vo.orderProdPrice}" readonly>
	<br>
	<br>
	<span>주문수량</span>
	<input type="text" value="${vo.orderProdQuantity }" readonly>
	<br>
	<br>
	<span>총 가격</span>
	<input type="text" value="${vo.orderProdPrice * vo.orderProdQuantity}" readonly>
	<br>
	<br>
	<span>사 이 즈</span>
	<input type="text" value="${vo.orderProdSize}" readonly>
	<input type="hidden" value="${vo.orderUserId}" id="orderUserId"
		readonly>
	<br>
	<br>
	<br>
	<br>



	<!--  -->
	<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"
		style="color: gray;">현재주소</span>
	<input type="text" value="${vo.orderUserAddress}" readonly="readonly">
	<br>
	<br>
	<br>
	<!--  -->

	<form action="" id="updateOrderAddress">

		<%--  <input type="hidden" value="${vo.orderUserId}" readonly id="userId"
			name="userId"> --%>

		<input type="hidden" value="${vo.orderNum}" readonly id="orderNum"
			name="orderNum"> <span
			class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"
			style="${vo.orderProdStatus eq 0? 'color: green;':'' || vo.orderProdStatus eq 1? 'color: green;':'' 
								|| vo.orderProdStatus eq 2? 'color: red;':'' || vo.orderProdStatus eq 3? 'color: red':''}">변경할
			주소</span> <input style="width: 170px" type="text" id="sample4_postcode"
			name="sample4_postcode" placeholder="우편번호" readonly required>




		<input style="width: 200px"
			type="${vo.orderProdStatus eq 0? 'button':'' || vo.orderProdStatus eq 1? 'button':'' 
								|| vo.orderProdStatus eq 2? 'hidden':'' || vo.orderProdStatus eq 3? 'hidden':''}"
			onclick="sample4_execDaumPostcode()" class="btn btn-default"
			value="우편번호 찾기"><br> <input style="width: 260px"
			type="text" id="sample4_roadAddress" name="sample4_roadAddress"
			placeholder="도로명주소" readonly required> <input
			style="width: 260px"
			type="${vo.orderProdStatus eq 0? 'text':'' || vo.orderProdStatus eq 1? 'text':'' 
								|| vo.orderProdStatus eq 2? 'hidden':'' || vo.orderProdStatus eq 3? 'hidden':''}"
			id="sample4_detailAddress" name="sample4_detailAddress"
			placeholder="상세주소" required><br>
		<!--  컨트롤러에서 DTO 작업시 adress 값은   우편번호 + 도로명주소+  상세주소 = useradress 로 처리 -->

		<!--  -->







		<span id="mail_check_input_box_warn"
			class="${vo.orderProdStatus eq 0? 'correct':'' || vo.orderProdStatus eq 1? 'correct':'' 
								|| vo.orderProdStatus eq 2? 'incorrect':'' || vo.orderProdStatus eq 3? 'incorrect':''}">

			${vo.orderProdStatus eq 0? '배송 시작 전까지 주소 수정이 가능합니다.':'' || vo.orderProdStatus eq 1? '배송 시작 전까지 주소 수정이 가능합니다.':'' 
								|| vo.orderProdStatus eq 2? '상품 배송이 시작되어 주소 수정이 불가합니다.':'' || vo.orderProdStatus eq 3? '상품 배송이 시작되어 주소수정 및 주문 취소가 불가합니다.':''}

		</span><br> <br> <br> <br>


		<div title="운송장번호를 클릭하면 배송조회가 가능합니다." id="connectPostForm">
			<span>운송장번호</span> <input type="text" id="orderTrackingNum"
				name="orderTrackingNum"
				placeholder="${vo.orderTrackingNum eq 0? '아직 운송장이 등록되지 않았습니다.': vo.orderTrackingNum}"
				readonly><br> <span
				class="${vo.orderProdStatus eq 2? 'correct':'' || vo.orderProdStatus eq 3? 'correct':''}">

				${vo.orderProdStatus eq 2? '운송장번호를 클릭하면 배송조회가 가능합니다.':'' || vo.orderProdStatus eq 3? '운송장번호를 클릭하면 배송조회가 가능합니다.':''}

			</span> <br>
		</div>



		<span>배송상태</span> <input readonly type="text"
			value="${vo.orderProdStatus eq 0? '입금 확인 중':'' || vo.orderProdStatus eq 1? '배송 준비 중':'' 
								|| vo.orderProdStatus eq 2? '배송 중':'' || vo.orderProdStatus eq 3? '배송 완료':''}"><br>
		<br> <br> <br> <br> <br> <input
			type="${vo.orderProdStatus eq 0? 'submit':'' || vo.orderProdStatus eq 1? 'submit':'' 
								|| vo.orderProdStatus eq 2? 'hidden':'' || vo.orderProdStatus eq 3? 'hidden':''}"
			class="btn btn-default" value="주소 수정" style="width: 100px;">


		<a id="deleteOrder" class="btn btn-default"
			style="${vo.orderProdStatus eq 0? 'correct':'' || vo.orderProdStatus eq 1? 'correct':'' 
								|| vo.orderProdStatus eq 2? 'display: none;':'' || vo.orderProdStatus eq 3? 'display: none;':''}">주문
			취소</a>


	</form>





	<form action="javascript:popup()" method="post" id="connectPost">
		<div class="form-group">
			<input type="hidden" class="form-control" id="t_key" name="t_key" >
		</div>
		<div class="form-group">
			<input type="hidden" class="form-control" name="t_code" id="t_code"
				value="01" >
		</div>
		<div class="form-group">
			<input type="hidden" class="form-control" name="t_invoice"
				id="t_invoice" value="${vo.orderTrackingNum}">
		</div>
		
	</form>

	<script type="text/javascript">
		function popup() {
			var num = document.getElementById("t_invoice").value;
			var url = "https://tracker.delivery/#/kr.epost/" + num;
			var name = "배송조회";
			var option = "width = 500, height = 500, top = 100, left = 200, location = no"
			window.open(url, name, option);
		}
	</script>





	<script type="text/javascript">
		$(document).ready(function() {
			
			
			var orderUserId = $("#orderUserId").val();
			var orderNum = $("#orderNum").val();
			
			$("#connectPostForm").click(function() {
				
				$("form#connectPost").submit();
				
			});
			
			$("#deleteOrder").click(function() {
				$.ajax({
					type : 'post',
					url : '/member/deleteOrder',
					data : {
						orderNum : orderNum
					},
					dataType : 'text',
					success : function() {

						alert("주문취소 완료");

						location.href = "/member/orderTracking/" + orderUserId;

					}

				});

			});

			$("form#updateOrderAddress").submit(function(event) {
				var sample4_postcode = $("#sample4_postcode").val();
				var sample4_roadAddress = $("#sample4_roadAddress").val();
				var sample4_detailAddress = $("#sample4_detailAddress").val();
				var orderNum = $("#orderNum").val();

				if ($("#sample4_postcode").val() == '') {
					alert('우편번호 찾기를 사용해 주소를 입력해 주세요.');
					event.preventDefault();

				} else if ($("#sample4_roadAddress").val() == '') {
					alert('우편번호 찾기를 사용해 주소를 입력해 주세요.');
					event.preventDefault();

				} else if ($("#sample4_detailAddress").val() == '') {
					alert('상세주소를 입력해주세요.');
					event.preventDefault();

				} else {
					event.preventDefault();
					alert('배송주소가 변경되었습니다.');
					$.ajax({
						type : 'post',
						url : '/member/updateOrderAddress',
						data : {
							orderNum : orderNum,
							sample4_postcode : sample4_postcode,
							sample4_roadAddress : sample4_roadAddress,
							sample4_detailAddress : sample4_detailAddress
						},
						dataType : 'text',
						success : function(result) {
							console.log(result);
							location.reload();
						}

					});
				}

			});

		});
	</script>


	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.

		//주소 adress값은 DB에 varckar 200의 문자 값으로 해당
		//주소값은 도로명 +상패주소 str()임시

		function sample4_execDaumPostcode() {

			new daum.Postcode(
					{
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

							//지번 주소 값을 공백 칸에 삽입

						}
					}).open();
		}
	</script>
</body>
</html>