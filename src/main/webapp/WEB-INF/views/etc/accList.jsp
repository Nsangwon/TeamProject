<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="UTF-8">
<title>prodList</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	.thumb_list {
		margin: 20px;
	}
</style>

</head>
<body>
<div class="container">
	<div class="row">
		<ul class="nav nav-pills">
  		<li role="presentation"><a href="/product/prodList">all</a></li>
  		<li role="presentation"><a href="/product/topList">top</a></li>
  		<li role="presentation"><a href="/product/bottomList">bottom</a></li>
  		<li role="presentation"><a href="/product/outerList">outer</a></li>
  		<li role="presentation" class="active"><a href="/product/accList">acc</a></li>
		</ul>
	
	</div>

	<div class="row">
	<c:forEach items="${to.list}" var="item">
		<div class="col-md-3 thumb_list">
			<div class="list_thumbnail">
				<img src="${item.prodThumbnail}" style="height:200px;width:200px;">
				<p><a href="/product/prodRead/${item.prodName}">${item.prodName}</a></p>
				<p>${item.prodPrice}</p>
			</div>		
		</div>
	</c:forEach>
</div><!--row end  -->
</div><!--container end-->
</body>
</html>