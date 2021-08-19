<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prodInsert</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- <script src="../resources/js/summernote-ko-KR.js"></script> -->
<script src="/resources/js/summernote-lite.js"></script>
<script type="text/javascript" src="/resources/js/script.js"></script>
<link rel="stylesheet" href="/resources/css/summernote-lite.css">

<style type="text/css">
	#thumbnail {
		width: 200px;
		height: 200px;
		border: solid 1px;
	}
	
	.basic-input {
		width: 300px;
		margin-right: 0px;
		display: inline-block;
		right: 0px;
		
	}
	
	.thumb-basic {
		width: 200px;
		position: float;
	}
	
	.thumb-div {
		float: left;
		display: inline-block;
		margin-top: 45px;
	}
	
	.btn-btn{
		text-align: center;
	}
	
	.product-input {
		text-align: right;
		padding-bottom: 20px;
	}
	
	#oriThumnail {
		height: 200px;
		width: 200px;
	}
	
</style>

</head>
<body>

	<div class="container">
		<div>
			<h1 class="jumbotron">prodUPDATE</h1>
		</div>
	
		<div class="thumb-div">
			<div id="thumbnail" class="thumb-basic">
				<img id="oriThumnail" src="${vo.prodThumbnail}">
			</div> <!-- end of thumbnial class -->
			<form id="thumbnail_insert" class="thumb-basic thumbnail_form form-control" action="/product/prodUpdate" enctype="multipart/form-data" method="post">
				<input type="hidden" value="${vo.prodBno}" name="prodBno">
				<input accept="image/*" class="thumbnail_insert" type="file" name="prodThumbnailFile" onchange="setThumbnail(event)" />
			</form>
			<c:if test="${not empty errors.prodThumb}"><div>${errors.prodThumb}</div></c:if>
		</div>
		<br>
		<br>
		
		<div class="product_basic">
			<form class="form-group" id="product" action="/product/prodInsert" method="post">
				<div class="product-input">
					<label for="prodName">prodName</label>
					<input class="basic-input name_input form-control" type="text" name="prodName" dir="rtl" value="${vo.prodName}" required> <br>
					<c:if test="${not empty errors.prodName}"><div>${errors.prodName}</div></c:if>
					<br>
					<label for="prodCategory">prodCategory</label>
					<select class="basic-input form-control" name="prodCategory">
						<option value="top">TOP</option>
						<option value="bottom">BOTTOM</option>
						<option value="outer">OUTER</option>
						<option value="acc">ACC</option>
					</select>
					<br>
					<label for="prodTitle">prodTitle</label>
					<input class="basic-input title_input form-control" type="text" name="prodTitle" dir="rtl" value="${vo.prodTitle}" required> <br>
					<c:if test="${not empty errors.prodTitle}"><div>${errors.prodTitle}</div></c:if> 
					<label for="prodPrice">prodPrice</label>
					<input class="basic-input price_input form-control" name="prodPrice" dir="rtl" min="1000" max="10000000" value="${vo.prodPrice}"> <br>
					<c:if test="${not empty errors.prodPrice}"><div>${errors.prodPrice}</div></c:if>
					<label for="prodStockSSize">(S)SIZE</label>
					<input class="basic-input stockS_input form-control" name="prodStockSSize" dir="rtl" max="9999" required value="${dto.prodStockSSize }"> <br>
					<label for="prodStockMSize">(M)SIZE</label>
					<input class="basic-input stockM_input form-control" name="prodStockMSize" dir="rtl" max="9999" required value="${dto.prodStockMSize }"> <br>
					<label for="prodStockLSize">(L)SIZE</label>
					<input class="basic-input stockL_input form-control" name="prodStockLSize" dir="rtl" max="9999" required value="${dto.prodStockLSize }"> <br>
					<c:if test="${not empty errors.prodStock}"><div>${errors.prodStock}</div></c:if>
				</div>
				<textarea id="summernote" class="content_input" name="prodContent" required>${vo.prodContent}</textarea>
				<c:if test="${not empty errors.prodContent}"><div>${errors.prodContent}</div></c:if>
			</form>
		</div> <!-- end to the row class -->
	</div> <!-- end of the container class -->
	<div class="btn-btn">
		<button class="prodInsert_btn btn-default btn">SAVE</button>
		<button class="cancel_btn btn-default btn">CANCEL</button>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#summernote").summernote({
				
				placeholder: "content",
				minHeight: 500,
				maxHeight: null,
				focus: true,
				
				/* image upload*/
				callbacks : {
					
					onImageUpload: function(files, editor, welEditable) {
					sendFile(files[0], this );
					}
				} 
				
			}); /* end of summernote setting */
			
			
			$(".cancel_btn").click(function(event) {
				event.preventDefault();
				history.back();
			});
			
			
			
			$(".prodInsert_btn").click(function(event) {
				event.preventDefault();
				 
		
				
				
				
				var int1 = $(".stockS_input").val();
				var int2 = $(".stockM_input").val();
				var int3 = $(".stockL_input").val();
				var intCheck = parseInt(int1) + parseInt(int2) + parseInt(int3);
				
				if (!isNaN(intCheck)) {
				var $children = $("#product").children();
			
				$("#oriThumnail").remove();
				$("#thumbnail_insert").append($children);
				$("#thumbnail_insert").submit();
				} else {
					alert('수량은 숫자만 입력 가능합니다.')
				};
				
			}); /* end of submit */
			
			
		}); /* end of document */
		
		/* after callbacks data work with controller */
		function sendFile(file, el) {
			var str = '';
			var formData = new FormData();
			formData.append("file", file);
			$.ajax({
				data : formData,
				type: "POST",
				url: "/product/prodFileUpdate/${vo.prodBno}",
				processData : false,
				contentType : false,
				enctype: "multipart/form-data",
				success : function(data) {
						console.log(data);
						$(el).summernote("insertImage", data);
						str += fileUploadInput(data);
						/* $("#summernote").append('<img src='+data.url+'/>'); */
						/* console.log(str);
						$("#thumbnail_insert").append(str); */
				}
				
			});
			
		} /* end of sendFile function */
		
		$(".thumbnail").on("dragenter dragover drop", function(event) {
			event.preventDefault();
		});
		
		/* thumbnail preview */
		function setThumbnail(event) {
			var reader = new FileReader();
			$("#thumbnail").empty();
			reader.onload = function(event) {
				var img = document.createElement("img");
				console.log(img);
				img.setAttribute("src", event.target.result);
				img.setAttribute("width", 200);
				img.setAttribute("height", 200);
				document.querySelector("div#thumbnail").appendChild(img);
			};
			reader.readAsDataURL(event.target.files[0]);
		}
	</script>



</body>
</html>