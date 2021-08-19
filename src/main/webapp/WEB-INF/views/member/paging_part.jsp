<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String change = request.getParameter("list");
	pageContext.setAttribute("change", change);
%>

<%-- Previous 1개씩 움직이기 ${to.curPage-1 > 0 ? to.curPage-1 : 1 --%>
<%-- Next버튼 1개씩 움직이기 ${to.curPage+1 <= to.totalPage ? to.curPage+1 : to.curPage --%>


<nav aria-label="Page navigation">
	<ul class="pagination">
		<c:choose>
			<c:when test="${change eq 'list'}">	<!-- list.jsp -->
				<li>
					<a href="/member/list/${to.curPage-1>0?to.curPage-1:1}" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
		
				<c:forEach begin="${to.beginPageNum}" end="${to.finishPageNum}" var="i">
					<li class="${to.curPage == i? 'active' :''}">
						<a href="/member/list/${i}">${i}</a>
					</li>
				</c:forEach>

				<li>
					<a href="/member/list/${to.curPage+1<=to.totalPage?to.curPage+1:to.curPage}" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:when>
			
			<c:when test="${change eq 'search'}">	<!-- search.jsp -->
				<li>
					<a href="/member/search?selector=${param.selector}&keyword=${param.keyword}&curPage=${to.previousPageNum}" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
		
				<c:forEach begin="${to.beginPageNum}" end="${to.finishPageNum}" var="i">
					<li class="${to.curPage == i? 'active' :''}">
						<a href="/member/search?selector=${param.selector}&keyword=${param.keyword}&curPage=${i}">${i}</a>
					</li>
				</c:forEach>

				<li>
					<a href="/member/search?selector=${param.selector}&keyword=${param.keyword}&curPage=${to.nextPageNum}" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:when>
			
			<c:when test="${change eq 'order'}">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li>
							<a href="/member/orderTracking/${to.curPage-1>0?to.curPage-1:1}/${login.userId}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						    
						<c:forEach begin="${to.beginPageNum}" end="${to.finishPageNum}" var="i">
							<li class="${to.curPage == i?'active':''}">
								<a href="/member/orderTracking/${i}/${login.userId}">${i}</a>
							</li>
						</c:forEach>
						    
						<li>
							<a href="/member/orderTracking/${to.curPage+1<=to.totalPage?to.curPage+1:to.curPage}/${login.userId}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</nav>
			</c:when>
			
			<c:when test="${change eq 'management'}">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li>
							<a href="/member/managementlist/${to.curPage-1>0?to.curPage-1:1}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						    
						<c:forEach begin="${to.beginPageNum}" end="${to.finishPageNum}" var="i"> 
							<li class="${to.curPage == i?'active':''}">
								<a href="/member/managementlist/${i}">${i}</a>
							</li>
						</c:forEach>
						    
						<li>
							<a href="/member/managementlist/${to.curPage+1<=to.totalPage?to.curPage+1:to.curPage}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</nav>
			</c:when>
		
		</c:choose>
	</ul>
</nav>