<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Latest compiled and minified CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  
  <script type="text/javascript">
  	$(document).ready(function(){ // 문서가 시작되면 가장먼저  loadList()를 호출한다. 
  		loadBoardList();
  		loadNewsList();
  		
  	});
  	
  	function loadBoardList(){ // 호출 내용은 바로바로
  		
  		$.ajax({ // (비동기 전송)서버와 통신 : 게시판 리스트 가져오기 
  			url : "boardList.do", // == @GetMapping("/boardList.do")
  			type : "GET",
  			dataType : "json",
  			success : makeView, // boardList.do가 실행되고 처리된 값, return을 받아서 처리하는 함수 -> 콜백함수  
  			error : function(xhr, status, error){ alert('에러 : ' + error ); }
  			
  		});
  	}
  	
  	function loadNewsList(){
  		$.ajax({
  			url : "getNewsList.do",
  			type : "GET",
  			dateType : "json",
  			success : makeNewsView,
  			error : function(xhr, status, error){ alert('에러 : ' + error ); }
  			
  		});
  	}
  	
  	function makeView(data){ // boardList.do의 return값 list가 data 변수에 들어가있다.
  		//받은 데이터로 게시판 리스트를 동적으로 만들자!
  		
  		let htmlList = "<table class='table table-bordered'>";
  		htmlList += "<tr>";
  		htmlList += "<th> 번호 </th>";
  		htmlList += "<th> 제목 </th>";
  		htmlList += "<th> 내용 </th>";
  		htmlList += "<th> 작성자 </th>";
  		htmlList += "<th> 작성일 </th>";
  		htmlList += "<th> 조회수 </th>";
  		htmlList += "</tr>";
  		
  		$.each(data, function(index, obj){
  	  		htmlList += "<tr>";
  	  		htmlList += "<td>"+obj.idx+"</td>";
  	  		htmlList += "<td>"+obj.title+"</td>";
  	  		htmlList += "<td>"+obj.content+"</td>";
  	  		htmlList += "<td>"+obj.writer+"</td>";
  	  			let objDate = obj.indate.split(' ')[0];
  	  		htmlList += "<td >"+objDate+"</td>";
  	  		htmlList += "<td>"+obj.count+"</td>";
  	  		htmlList += "</tr>";
  		});
  		
  		htmlList += "</table>";
  		
  		$("#view").html(htmlList);
  	}
  	
  	function makeNewsView(news){
  		
  		let htmlList = "<table class='table table-bordered'>";
  		htmlList += "<tr>";
  		htmlList += "<th> 번호 </th>";
  		htmlList += "<th> 제목 </th>";
  		htmlList += "<th> 내용 </th>";
  		htmlList += "<th> 신문사 </th>";
  		htmlList += "<th> 작성일 </th>";
  		htmlList += "<th> 조회수 </th>";
  		htmlList += "</tr>";
  		
  		$.each(news, function(index, obj){
  	  		htmlList += "<tr>";
  	  		htmlList += "<td>"+obj.idx+"</td>";
  	  		htmlList += "<td>"+obj.title+"</td>";
  	  		htmlList += "<td>"+obj.content+"</td>";
  	  		htmlList += "<td>"+obj.brand+"</td>";
  	  			let objDate = obj.indate.split(' ')[0];
  	  		htmlList += "<td >"+objDate+"</td>";
  	  		htmlList += "<td>"+obj.count+"</td>";
  	  		htmlList += "</tr>";
  			
  		});
  		
  		htmlList += "</table>";
  		
  		$("#news").html(htmlList);
  	}
  	
  </script>
</head>
<body>
 
<div class="container mt-3">
  <h2>Spring MVC02</h2>
  <div class="card card-default">
    <div class="card-header">BOARD</div>
    <div class="card-body" id="view">card Content</div>
    <div class="card-body" id="news">card Content</div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>