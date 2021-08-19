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
<script src="../resources/js/summernote-lite.js"></script>
<link rel="stylesheet" href="../resources/css/summernote-lite.css">

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
	
</style>

</head>
<body>
	<div class="container">
		<div>
			<h1 class="jumbotron">prodINSERT</h1>
		</div>
		<div class="thumb-div">
			<div id="thumbnail" class="thumb-basic">
			</div> <!-- end of thumbnial class -->
			
			<form id="thumbnail_insert" class="thumb-basic thumbnail_form form-control" action="/product/prodInsert" enctype="multipart/form-data" method="post">
				<input accept="image/*" class="thumbnail_insert" type="file" name="prodThumbnailFile" onchange="setThumbnail(event)"/>
			</form>
		</div>
		
		<br>
		<br>

		<div class="product_basic">
			<form class="form-group" id="product" action="/product/prodInsert" method="post">
				<div class="product-input">
					<label for="prodName">prodName</label>
					<input class="basic-input name_input form-control" type="text" name="prodName" dir="rtl" required> <br>
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
					<input class="basic-input title_input form-control" type="text" name="prodTitle" dir="rtl" required> <br>
					<c:if test="${not empty errors.prodTitle}"><div>${errors.prodTitle}</div></c:if> 
					<label for="prodPrice">prodPrice</label>
					<input class="basic-input price_input form-control" name="prodPrice" dir="rtl" min="1000" max="10000000"> <br>
					<c:if test="${not empty errors.prodPrice}"><div>${errors.prodPrice}</div></c:if>
					<label for="prodStockSSize">(S)SIZE</label>
					<input class="basic-input stockS_input form-control" name="prodStockSSize" dir="rtl" max="9999" required> <br>
					<label for="prodStockMSize">(M)SIZE</label>
					<input class="basic-input stockM_input form-control" name="prodStockMSize" dir="rtl" max="9999" required> <br>
					<label for="prodStockLSize">(L)SIZE</label>
					<input class="basic-input stockL_input form-control" name="prodStockLSize" dir="rtl" max="9999" required> <br>
					<c:if test="${not empty errors.prodStock}"><div>${errors.prodStock}</div></c:if>
				</div>
				<textarea id="summernote" class="content_input" name="prodContent" required></textarea>
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
					    sendFile(files[0], this);
					}
				} 
				
			}); /* end of summernote setting */
			
			$(".cancel_btn").click(function() {
				location.href="/home";
			});
			
			$(".prodInsert_btn").click(function(event) {
				event.preventDefault();
				
				var int1 = $(".stockS_input").val();
				var int2 = $(".stockM_input").val();
				var int3 = $(".stockL_input").val();
				var intCheck = parseInt(int1) + parseInt(int2) + parseInt(int3);
				
				if (!isNaN(intCheck)) {
				var $children = $("#product").children();
				$("#thumbnail_insert").append($children);

				$("#thumbnail_insert").submit();
				} else {
					alert('수량은 숫자만 입력 가능합니다.')
				};
			}); /* end of submit */
			
		}); /* end of document */
		
		/* after callbacks data work with controller */
		function sendFile(file, el) {
			var formData = new FormData();
			formData.append("file", file);
			$.ajax({
				data : formData,
				type: "POST",
				url: "/product/prodFile",
				processData : false,
				contentType : false,
				enctype: "multipart/form-data",
				success : function(data) {
						$(el).summernote("insertImage", data);
						/* $("#summernote").append('<img src='+data.url+'/>'); */
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