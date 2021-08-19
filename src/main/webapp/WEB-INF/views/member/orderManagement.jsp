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

.ing {
	color: orange;
}
</style>

</head>
<body style="text-align: center; margin: auto;">


	<c:choose>
		<c:when test="${login.userGrade ne 1}">
			<script type="text/javascript">
            alert("관리자 권한이 필요한 작업입니다.")
            location.href = "/member/loginGet"
         </script>

		</c:when>
		<c:otherwise>



		</c:otherwise>

	</c:choose>

	<jsp:include page="../main_menu.jsp" />

	<br>
	<br>
	<h3>주문 관리</h3>
	<br>
	<br>

	<span>주문번호</span>
	<input type="text" value="${vo.orderNum}" id="orderNum" readonly>
	<br>
	<br>
	<span>주문번호</span>
	<input type="text" value="${vo.orderUserId}" id="orderUserId" readonly>
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
	<input type="text" value="${vo.orderProdQuantity}" readonly>
	<br>
	<br>
	<span>총 가격</span>
	<input type="text" value="${vo.orderProdPrice * vo.orderProdQuantity}" readonly>
	<br>
	<br>
	<span>사 이 즈</span>
	<input type="text" value="${vo.orderProdSize}" readonly>
	<br>
	<br>
	<!--  -->
	<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"
		style="color: gray;">배송주소</span>
	<input type="text" value="${vo.orderUserAddress}" readonly="readonly">
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<span
		class="${vo.orderProdStatus eq 0? 'correct':'' || vo.orderProdStatus eq 1? 'correct':'' 
                        || vo.orderProdStatus eq 2? 'ing':'' || vo.orderProdStatus eq 3? 'incorrect':''}">배송상태</span>

	<input readonly type="text"
		value="${vo.orderProdStatus eq 0? '입금 확인 중':'' || vo.orderProdStatus eq 1? '배송 준비 중':'' 
                        || vo.orderProdStatus eq 2? '배송 중':'' || vo.orderProdStatus eq 3? '배송 완료':''}">
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>




	<%-- <input  type="text" id="orderTrackingNum" name="orderTrackingNum" placeholder="${vo.orderTrackingNum eq '0'? '운송장번호를 등록해 주세요':''}" 
      value="${vo.orderTrackingNum}"><br> --%>


	<form id="orderManagement">
		<span
			class="${vo.orderProdStatus eq 0? 'correct':'' || vo.orderProdStatus eq 1? 'correct':'' 
                        || vo.orderProdStatus eq 2? 'ing':'' || vo.orderProdStatus eq 3? 'incorrect':''}">운송장번호</span>
		<c:choose>
			<c:when test="${vo.orderTrackingNum eq 0}">
				<input type="text" id="orderTrackingNum" name="orderTrackingNum"
					placeholder="운송장번호를 등록해 주세요" disabled>
				<br>
			</c:when>
			<c:otherwise>
				<input type="text" id="orderTrackingNum" name="orderTrackingNum"
					value="${vo.orderTrackingNum}" required>
				<br>
			</c:otherwise>
		</c:choose>

		<br> <br> <select class="form-control" id="select"
			style="width: 400px; margin: auto; text-align: center;">
			<option value="0">입금 확인 중</option>
			<option value="1">배송 준비 중</option>
			<option value="2">배송 중</option>
			<option value="3">배송 완료</option>
		</select> <br> <br> <input class="btn btn-default" type="submit"
			value="진행상태 변경">

	</form>
	<br>
	<a class="btn btn-default" href="/member/managementlist">뒤로가기</a>
	<br>
	<!--  -->
	<br>
	<br>



	<script type="text/javascript">
$(document).ready(function() {
   var orderTrackingNum = $("#orderTrackingNum").val();
   $("#select").change(function(){
      var orderProdStatus = $("#select option:selected").val();
      
      
      
      
      if (orderProdStatus == '0') {
         $('#orderTrackingNum').attr('disabled', true);
          $("#orderTrackingNum").attr("required" , false);


      }else if (orderProdStatus == '1') {
         $('#orderTrackingNum').attr('disabled', true);
          $("#orderTrackingNum").attr("required" , false);
         
      }else if (orderProdStatus == '2') {
         
         $('#orderTrackingNum').attr('disabled', false);
          $("#orderTrackingNum").attr("required" , true);
         
      }else {
         $('#orderTrackingNum').attr('disabled', false);
          $("#orderTrackingNum").attr("required" , true);
      }
   });
   
   
   
   
   $("#orderManagement").submit(function(event) {
      event.preventDefault();
   var orderProdStatus = $("#select option:selected").val();
   var orderNum = $("#orderNum").val();
   
   var orderUserId = $("#orderUserId").val();

      var orderTrackingNum = $("#orderTrackingNum").val();
   

      
   
      $.ajax({
         type : 'post',
         url : '/member/orderManagement',
         data : {
            orderProdStatus : orderProdStatus,
            orderNum : orderNum,
            orderTrackingNum : orderTrackingNum,
            orderUserId : orderUserId
            
         },
         dataType : 'text',
         success : function(result) {
         
            
               
            alert("주문상태 변경 완료");
            location.reload();
            
            
            
         }
      });
      
   });
});
</script>

</body>
</html>