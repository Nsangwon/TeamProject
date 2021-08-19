<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

	<form action="/member/search" method="get" class="form-inline">
		<div class="form-group">
			<select class="form-select" name="selector">
				<option selected value="userId">아이디</option>
				<option value="userName">이름</option>
				<option value="userEmail">이메일</option>
				<option value="userAddress">주소</option>
			</select>
			
			<input type="search" name="keyword" class="form-control">
			<input type="hidden" name="curPage" value="1">
			<input type="submit" class="btn btn-success" value="검색">
		</div>		
	</form>