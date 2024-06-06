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
  	$(document).ready(function(){ // 문서가 시작되면 가장먼저 동작할 함수 호출 
  		loadBoardList();
  		loadNewsList();
  		showBoard();
  		goInsert();
  		
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
  		htmlList += "<th> 작성자 </th>";
  		htmlList += "<th> 작성일 </th>";
  		htmlList += "<th> 조회수 </th>";
  		htmlList += "</tr>";
  		
  		$.each(data, function(index, obj){
  	  		htmlList += "<tr>";
  	  		htmlList += "<td>"+obj.idx+"</td>";
  	  		htmlList += "<td><a href='#'>"+obj.title+"</a></td>";
  	  		htmlList += "<td>"+obj.writer+"</td>";
  	  			let objDate = obj.indate.split(' ')[0];
  	  		htmlList += "<td >"+objDate+"</td>";
  	  		htmlList += "<td>"+obj.count+"</td>";
  	  		htmlList += "</tr>";
  		});
  		
  		htmlList += "</table>";
  		
  		$("#view").html(htmlList);
  		
  		$("#view").css("display", "block");  //글쓰기 완료후 리스트창 오픈
  		$("#news").css("display", "block");
  		$("#writeForm").css("display", "none"); //글쓰기 완료후 글쓰기 폼 닫기
  		
  	}
  	
  	function makeNewsView(news){
  		
  		let htmlList = "<table class='table table-bordered'>";
  		htmlList += "<tr>";
  		htmlList += "<th> 번호 </th>";
  		htmlList += "<th> 제목 </th>";
  		htmlList += "<th> 신문사 </th>";
  		htmlList += "<th> 작성일 </th>";
  		htmlList += "<th> 조회수 </th>";
  		htmlList += "</tr>";
  		
  		$.each(news, function(index, obj){
  	  		htmlList += "<tr>";
  	  		htmlList += "<td>"+obj.idx+"</td>";
  	  		htmlList += "<td>"+obj.title+"</td>";
  	  		htmlList += "<td>"+obj.brand+"</td>";
  	  			let objDate = obj.indate.split(' ')[0];
  	  		htmlList += "<td >"+objDate+"</td>";
  	  		htmlList += "<td>"+obj.count+"</td>";
  	  		htmlList += "</tr>";
  			
  		});
  		
  		
  		
  		htmlList += "</table>";
  		
  		$("#news").html(htmlList);
  		
  		$("#view").css("display", "block"); //글쓰기 완료후 리스트창 오픈
  		$("#news").css("display", "block");
  		$("#writeForm").css("display", "none"); //글쓰기 완료후 글쓰기 폼 닫기
  	}
  	
  	
  	/* 게시물 글쓰기 버튼 클릭시 이벤트 */
  	function showBoard(){
	  	let writeButton = document.getElementById('writeBoardButton');
	  	
	  	writeButton.addEventListener('click', showForm);
  	
  	
	  	function showForm(){
	  		$("#view").css("display", "none"); //감춰
	  		$("#news").css("display", "none");
	  		$("#writeForm").css("display", "block"); //보여줘
	  		
	  		document.getElementById('writeBoardButton').innerText = "목록으로";
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', showForm);
	  		document.getElementById('writeBoardButton').addEventListener('click', goBackMain);
	  		
	  	}
	  	
	  	function goBackMain(){ //재활용하기 위해서 전역메서드 화
	  		$("#view").css("display", "block"); 
	  		$("#news").css("display", "block");
	  		$("#writeForm").css("display", "none"); 
	  		
	  		document.getElementById('writeBoardButton').innerText = "글쓰기";
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', goBackMain);
	  		document.getElementById('writeBoardButton').addEventListener('click', showForm);
	  		
	  		/*목록 누를 떄 리스트 갱신!*/
	  		loadBoardList();
	  		loadNewsList();
	  	}
	  	
	  	window.goBackMain = goBackMain; //재활용하기 위해서 전역메서드 화
	  	
  	}
  	
  	/* 글 쓰기 */
   	function goInsert(){
  		
  		const insertButton = document.getElementById('insertBoard');
  		
  		insertButton.addEventListener('click', insertBoard);
  		
  		function insertBoard(){
  			
  			let fData = $("#frm").serialize(); //모든 파라미터 직렬화
  	  		
 	  		$.ajax({
 	  			url : "boardInsert.do",
 	  			type : "post",
 	  			data : fData,
 	  			success : function(response){
 	  				alert('게시물 작성에 성공');
 	  				
 	  				window.goBackMain(); //쓰고나면 리스트 갱신해
 	  			},
 	  			error : function(){alert('error');}
 	  		});
  			
  			// 폼 작성됐던 글 초기화
  			//$("#title").val("");
  			//$("#content").val("");
  			//$("#writer").val("");
  			$("#resetForm").trigger("click"); //trigger함수 : 이벤트 발생
  			
  			
  		}
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
    
    <div class="card-body"><button id="writeBoardButton" class='btn btn-primary btn-sm'>글쓰기</button></div>
    
    <div class="card-body" id="writeForm" style="display: none;">
    	<p align="center">게시판 글쓰기</p>
    	<form id="frm">
	      <table class="table">
	    		<tr>
	          <td>제목</td>
	        	<td><input type="text" id="title" name="title" class="form-control"/></td>
	        </tr>
	        <tr>
	       	  <td>내용</td>
	         	<td><textarea rows="7" id="content" name="content" class="form-control"></textarea> </td>
	        </tr>
	        <tr>
	          <td>작성자</td>
	          <td><input type="text" id="writer" name="writer" class="form-control"/></td>
	        </tr>
	        <tr>
	         	<td colspan="2" align="center">
	         		<button type="button" id="insertBoard" class="btn btn-success btn-sm" onclick=goInsert()>등록</button>
	         		<button type="reset" id="resetForm" class="btn btn-warning btn-sm">리셋</button>
	         	</td>
	        </tr>
	     	</table>
    	</form>
    </div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>