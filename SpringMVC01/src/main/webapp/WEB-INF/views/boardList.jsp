<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- 반응형 웹 코드 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-3">
  <h2>Spring MVC01</h2>
  <div class="card">
    <div class="card-header">Board</div>
    <div class="card-body">
    	<table class="table table-bordered table-hover">
	    	<tr>
	    		<th>번호</th>
	    		<th>제목</th>
	    		<th>내용</th>
	    		<th>작성자</th>
	    		<th>작성일</th>
	    		<th>조회수</th>
	    	</tr>
<%-- 	    	
				<c:if test="${not empty list}">
		    	<c:forEach var="vo" items="${list}">
			    	<tr>
			    		<td>${vo.idx }</td>
			    		<td>${vo.title }</td>
			    		<td>${vo.context }</td>
			    		<td>${vo.writer }</td>
			    		<td>${vo.indate }</td>
			    		<td>${vo.count }</td>
			    	</tr>
		    	</c:forEach>
	    	</c:if> 
--%>
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="vo" items="${list}">
			    	<tr>
			    		<td>${vo.idx }</td>
			    		<td>${vo.title }</td>
			    		<td>${vo.context }</td>
			    		<td>${vo.writer }</td>
			    		<td>${vo.indate }</td>
			    		<td>${vo.count }</td>
			    	</tr>
		    	</c:forEach>
			</c:when>
			
			<c:otherwise>
				<tr>
					<td colspan="6" style="text-align: center;">조회되는 자료가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
    	</table>	
    	
    </div> 
    <div class="card-footer">Footer</div>
  </div>
</div>

</body>
</html>
