<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>CartList</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="/resources/img/mycss.css" rel="stylesheet" type="text/css" />
<style>

#mail_check_input_box_false{
    background-color:#ebebe4;
} 
#mail_check_input_box_true{
    background-color:white;
}
.correct{
    color : green;
}
.incorrect{
    color : red;
}
</style>
</head>
<body style="text-align: center;margin: auto;">

	<jsp:include page="../main_menu.jsp"/>
	<br><br><br><br>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped">
				<thead>
					<tr>
						<th><input id="allCheck" type="checkbox"/> 전체선택</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>사이즈</th>
						<th>가격</th>
						<th>수량</th>
						<th>합계</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${list}" var="vo">
						<tr onmouseOver="this.style.background='#50bcdf'" 
							onMouseOut="this.style.backgroundColor=''">
							
							<td>
								<input class="rowCheck" type="checkbox" value="${vo.cartNo}"/>
							</td>
							
							<td>
								<img src="${vo.productVO.prodThumbnail}" style="width: 200px; height: 200px;">
							</td>
								
							<td>
								<input name="orderProdName" type="text" style="border:none;" value="${vo.productVO.prodName}" readonly>	
							</td>
							
							<td>
								<input name="orderProdSize" type="text" style="border:none;" value="${vo.prodSize}" readonly>
							</td>

							<td>
								<input name="orderProdPrice" type="hidden" style="border:none;" value="${vo.productVO.prodPrice}" readonly>
								<fmt:formatNumber value="${vo.productVO.prodPrice}" pattern="#,###"/>원
							</td>
							
							<td>
								<input name="orderProdQuantity" type="number" class="amount" value="${vo.amount}" style="text-align:center;" min="1"/>
							</td>
							
							<td class="total" id="total">	<!-- 원가*수량 합계 -->
								<fmt:formatNumber value="${vo.productVO.prodPrice * vo.amount}" pattern="#,###"/>원
							</td>
							
							<td class="hide">	<!-- 사이즈 별 수량 -->
								<c:if test="${vo.prodSize eq 'S'}">
									<span class="hide">${vo.prodStockDTO.prodStockSSize}</span>
								</c:if>
								<c:if test="${vo.prodSize eq 'M'}">
									<span class="hide">${vo.prodStockDTO.prodStockMSize}</span>
								</c:if>
								<c:if test="${vo.prodSize eq 'L'}">
									<span class="hide">${vo.prodStockDTO.prodStockLSize}</span>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<h3>장바구니 총 금액 : <span id="cartListTotal"></span></h3>
			<br>
			<button type="button" class="btn btn-danger btn-xs check_delete_btn">선택 삭제</button>
			<a class="btn btn-info btn-xs order" data-toggle="modal" data-target="#myModal">선택 주문</a>
		</div>
		
	</div>
	
	<!-- Modal esc키 먹히게 해주는 것: tabindex="-1"  -->
	<div data-backdrop="static" class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="overflow-y: scroll; max-height:85%; width:auto; display:table">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close modal_close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>	
					</button>					

					<h4 class="modal-title text-center" id="modal_rno"></h4>
				</div>
				
				<div class="modal-body">
					<table id="modal_table" class="table table-striped">
						<thead>
							<tr>
								<th>선택</th>
								<th>이미지</th>
								<th>상품명</th>
								<th>사이즈</th>
								<th>가격</th>
								<th>수량</th>
								<th>합계</th>
							</tr>
						</thead>
							
						<tbody>
						</tbody>
					</table>
					<h3>총 금액 : <span id="orderListTotal"></span></h3>
					<br>
					<br>
					<label>배송주소</label> <br>
					<input type="text" id="sample4_postcode" name="sample4_postcode" placeholder="우편번호" readonly required>
					<input type="button" onclick="sample4_execDaumPostcode()" class="btn btn-default" value="우편번호 찾기"><br>
					&emsp;
					
					<input type="text" id="sample4_roadAddress" name="sample4_roadAddress" placeholder="도로명주소" readonly required>
					<input type="text" id="sample4_detailAddress" name="sample4_detailAddress" placeholder="상세주소" maxlength="60" disabled="disabled" required>
					<br>
					<input type="hidden" id="userAddress" name="orderUserAddress">
					<!-- 컨트롤러에서 DTO 작업시 adress 값은   우편번호 + 도로명주소+  상세주소 = userAdress 로 처리 -->
					<br> <br>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default modal_close" data-dismiss="modal">취소</button>
					<button id="order_submit_btn" type="button" class="btn btn-primary" data-dismiss="modal">주문</button>
				</div>
			</div>
		</div>
	</div>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {			
			cartListTotal();	// 장바구니 리스트 총 합계
			
			// modal 창 주문 클릭
			$("#order_submit_btn").click(function() {
				var checkArr = new Array();
				var checkOrder = new Array();
				var rowCheck = $("#modal_table > tbody > tr > td > .modal_rowCheck");
				var userAddress = $("#userAddress").val();
				var sample4_postcode = $("#sample4_postcode").val();
				var sample4_roadAddress = $("#sample4_roadAddress").val();
				var sample4_detailAddress = $("#sample4_detailAddress").val();
				
				if ($("#sample4_detailAddress").val() == '') {
					alert('주소를 입력하세요.');
					return false;
				}
				
				for (var i = 0; i < rowCheck.length; i++) {
					if (rowCheck[i].checked) {
						checkArr.push(rowCheck[i].value);
					}
				}
				
				if (checkArr.length == 0) {
					alert("선택된 목록이 없습니다.");
					return false;
					
				} else {
					$("#modal_table").find('.modal_rowCheck:checked').each(function(idx){
						var that = $(this);
						var tr = that.parent().parent();
						var td = tr.children();
						
						var prodName = td.eq(2).children().val();
						var prodSize = td.eq(3).children().val();
						var prodPrice = td.eq(4).children().val();
						var prodQuantity = td.eq(5).children().val();
						
						var data = {
								prodName,
								prodSize,
								prodPrice,
								prodQuantity
						};
						
						checkOrder.push(data);
						console.log(checkOrder[idx]);
		            });
					
					
					$.ajax({
						type : 'post',
						url : '/member/order',
						traditional : true,
						data : {
							checkOrder : JSON.stringify(checkOrder),
							userAddress : userAddress,
							sample4_postcode : sample4_postcode,
							sample4_roadAddress : sample4_roadAddress,
							sample4_detailAddress : sample4_detailAddress
						},
						dataType : 'text',
						success : function(result) {
							if (result == "success") {
								alert("선택한 상품을 주문하였습니다. \n주문한 상품은 장바구니 목록에서 삭제됩니다.");
								checkDelete();
								location.href="/member/orderTracking/${login.userId}";
								
							} else {
								alert("주문에 실패하였습니다.");
							}
						}	
					});	// ajax End
				}
				
			});
			
			
			// modal창 x, 취소 클릭
			$(".modal_close").click(function() {
				$('#modal_table > tbody > tr').remove();
			});
			
			
			// 선택 삭제 클릭
			$(".check_delete_btn").click(function() {
				var msg = confirm("선택한 항목을 삭제하시겠습니까?");
				
				if (msg) {
					checkDelete();
					alert("장바구니에서 삭제되었습니다.");
					
				} else {
					return false;
				}
			});
			
			
			// 선택 주문 클릭
			$(".order").click(function() {
				$('#modal_table > tbody > tr').remove();
				var checkArr = new Array();
				var rowCheck = $(".rowCheck");
				
				for (var i = 0; i < rowCheck.length; i++) {
					if (rowCheck[i].checked) {
						checkArr.push(rowCheck[i].value);
					}
				}

				if (checkArr.length == 0) {
					alert("선택된 목록이 없습니다.");
					return false;
					
				} else {
					$(".rowCheck:checked").each(function(){
						var td = $(this);
						var tr = td.parent().parent();
						
						var modalTr = tr.clone();
						var modalTd = modalTr.children();
						modalTd.eq(0).children().attr('onclick', "return false;");
						modalTd.eq(0).children().attr('class', "modal_rowCheck");
						modalTd.eq(5).children().attr("readonly", true);
						modalTd.eq(5).children().attr("style", "border:none;");
						modalTd.eq(7).remove();
						modalTr = modalTd.parent();
						
						$('#modal_table > tbody:last').append(modalTr);
						
						var sum = 0;
						$("#modal_table > tbody > tr > .total").each(function(index){
							sum += Number($("#modal_table > tbody > tr > .total").eq(index).text().replace(/(,|원)/g, ""));
						});
						
						$("#orderListTotal").text(sum.toLocaleString() + "원");
		            });
				}
				
			});
			
			
			// 전체 선택
			$("#allCheck").click(function() {
				for (var i = 0; i < $(".rowCheck").length; i++) {
					$(".rowCheck")[i].checked = this.checked;
				}
			});
			
			// 수동으로 선택 시 allCheck 변화
			$(".rowCheck").click(function() {
				if ($(".rowCheck:checked").length == $(".rowCheck").length) {
					$("#allCheck")[0].checked = true;
					
				} else {
					$("#allCheck")[0].checked = false;
				}
			});
			
			
			// 수량 값이 변화 시 금액 변화
			$(".amount").on("change", function() {
				var that = $(this);
				var tr = that.parent().parent();
				var td = tr.children();
				var cartNo = td.eq(0).children();
				var prodName = td.eq(2).children();
				var prodSize = td.eq(3).children();
				var prodPrice = td.eq(4).text();
				var amount = td.eq(5).children();
				var total = td.eq(6);
				var prodStock = td.eq(7).children();
				
				// amount 값 양수, 최소 최대값 제한
				if (amount.val() > Number(prodStock.text())) {
					alert(prodName + " " + prodSize + "사이즈의 \n남은 수량은 " + Number(prodStock.text()) + "개 입니다.");
					amount.val(Number(prodStock.text()));
					
				} else if (amount.val() < 1) {
					alert("최소 1개 이상이어야 합니다");
					amount.val(1);
				}
				
				$.ajax({
					type : 'put',
					headers : {
						'Content-Type' : 'application/json',
						'X-HTTP-Method-Override' : 'PUT'
					},
					url : '/carts/cart',
					data : JSON.stringify({
						cartNo : cartNo.val(),
						userId : '${userId}',
						prodName : prodName.val(),
						prodSize : prodSize.val(),
						amount : amount.val()
					}),
					dataType : 'text',
					success : function(result) {
						if (result == "1") {
							// replace = 숫자에 ',' '원' 자르기
							// toLocaleString = 숫자에 ',' 추가
							total.text(Number(prodPrice.replace(/(,|원)/g, "") * amount.val()).toLocaleString() + "원");
							
							cartListTotal(); // 장바구니 리스트 총 합계
						} 
					}
				});	// ajax End
			});	// .amount End

		});	// document End
		
		
		// 장바구니 리스트 총 합계
		function cartListTotal() {
			var sum = 0;
			$(".total").each(function(index){
				sum += Number($(".total").eq(index).text().replace(/(,|원)/g, ""));
			});
			$("#cartListTotal").text(sum.toLocaleString() + "원");
			
		}	// cartListTotal() End
		
		
		// 선택한 행 삭제
		function checkDelete() {
			var checkArr = new Array();
			var rowCheck = $(".rowCheck");
			
			for (var i = 0; i < rowCheck.length; i++) {
				if (rowCheck[i].checked) {
					checkArr.push(rowCheck[i].value);
				}
			}

			if (checkArr.length == 0) {
				alert("선택된 목록이 없습니다.");
				return false;
				
			} else {
				$.ajax({
					type : 'delete',	// 삭제
					headers : {
						'Content-Type' : 'application/json',
						'X-HTTP-Method-Override' : 'DELETE'
					},
					url : '/carts/cart',
					data : JSON.stringify({
						cartNo : checkArr
					}),
					dataType : 'text',
					success : function(result) {
						if (result == "1") {
							$(".rowCheck:checked").each(function(){
								var td = $(this);
								var tr = td.parent().parent();
								tr.remove();
								cartListTotal();
				           	});
						} else {
							alert("삭제에 실패하였습니다.");
						}
					}	
				});	// ajax End

			}	// checkArr.length if else End

		}	// checkDelete() End
		
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