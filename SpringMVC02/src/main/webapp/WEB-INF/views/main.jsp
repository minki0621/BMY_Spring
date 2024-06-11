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
  		//showBoard();
		//goInsert();  
		
		
  	});
  	
  	function loadBoardList(){ // 호출 내용은 바로바로
  		$.ajax({ // (비동기 전송)서버와 통신 : 게시판 리스트 가져오기 
  			url : "board/all", // == @GetMapping("/boardList.do")
  			type : "GET",
  			dataType : "json",
  			success : makeView, // boardList.do가 실행되고 처리된 값, return을 받아서 처리하는 함수 -> 콜백함수  
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
  	  		htmlList += "<td id='ti"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
  	  		htmlList += "<td>"+obj.writer+"</td>";
  	  		htmlList += "<td >"+obj.indate.split(' ')[0]+"</td>";
  	  		htmlList += "<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
  	  		htmlList += "</tr>";
  	  		
  	  		htmlList += "<tr id='c"+obj.idx+"' style='display:none'>";
  	  		htmlList += "<th>내용</th>";
  	  		htmlList += "<td colspan='4'>";
  	  		htmlList += "<textarea id='con"+obj.idx+"' rows='7' class='form-control' readonly ></textarea>";
  	  		htmlList += "<br>"
  	  		htmlList += "<a href='javascript:goUpdateForm("+obj.idx+")' id='m"+obj.idx+"' class='btn btn-warning btn-sm'> 수정 </a> &nbsp;"
  	  		htmlList += "<a href='javascript:goDelete("+obj.idx+")' id='d"+obj.idx+"' class='btn btn-danger btn-sm'> 삭제 </a> &nbsp;"
  	  		htmlList += "</td>";
  	  		htmlList += "</tr>";
  	  		
  		});
  		
  		htmlList += "</table>";
  		
  		$("#view").html(htmlList);
  		
  		$("#view").css("display", "block");  // 글쓰기 완료후 리스트창 오픈
  		$("#writeForm").css("display", "none"); // 글쓰기 완료후 글쓰기 폼 닫기
  		
  	}
  	
  	/* 게시물 글쓰기 버튼 클릭시 이벤트 */
  	function showBoard(){
	  	let writeButton = document.getElementById('writeBoardButton');
	  	
	  	writeButton.addEventListener('click', showForm);
  	
  	
	  	function showForm(){
	  		$("#view").css("display", "none"); //감춰
	  		$("#writeForm").css("display", "block"); //보여줘
	  		
	  		document.getElementById('writeBoardButton').innerText = "목록으로"; // 버튼 텍스트 수정 
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', showForm);
	  		document.getElementById('writeBoardButton').addEventListener('click', goBackMain);
	  		
	  	}
	  	
	  	function goBackMain(){  
	  		$("#view").css("display", "block"); 
	  		$("#writeForm").css("display", "none"); 
	  		
	  		document.getElementById('writeBoardButton').innerText = "글쓰기";
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', goBackMain);
	  		document.getElementById('writeBoardButton').addEventListener('click', showForm);
	  		
	  		/*목록 누를 떄 리스트 갱신!*/
	  		loadBoardList();
	  	}
	  	
	  	window.goBackMain = goBackMain; //재활용하기 위해서 전역메서드화 ()
	  	
  	}
  	
  	/* 글 쓰기 */
   	function goInsert(){
  		
  		const insertButton = document.getElementById('insertBoard');
  		insertButton.addEventListener('click', insertBoard);
  		
  		function insertBoard(){
  			let fData = $("#frm").serialize(); //폼의 모든 파라미터 직렬화
  	  		
 	  		$.ajax({
 	  			url : "board/new",
 	  			type : "post",
 	  			data : fData,
 	  			success : function(response){
 	  				alert('게시물 작성에 성공');
 	  				
 	  				window.goBackMain(); //쓰고나면 리스트 갱신해, 목록으로 텍스트를 글쓰기로 다시 바꿔. 
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
  	
  	/* 상세보기 : content 보이기_숨기기 */
  	function goContent(idx){ //1, 2, 3 ...
  		if($("#c"+idx).css("display") == "none"){
  			
  			// 서버에서 content가져와서 붙여넣기 
  			$.ajax({
  				url : "board/"+idx,
  				type : "GET",
  				//data : {"idx" : idx},
  				datatype: "JSON",
  				success : function(voData){
  					$("#con"+idx).val(voData.content);
  					
  					$("#cnt"+idx).text(voData.count);
  				},
  				error : function(){alert("error");}
  				
  			});
  			
  	
  			
	  		$("#c"+idx).css("display", "table-row"); // block이 아니라 table-row 
  		}else{
	  		$("#c"+idx).css("display", "none"); // block이 아니라 table-row 
  		}

  	}
  	
  	/* 글 수정 (폼 생성) */
  	function goUpdateForm(idx){  		
  		$("#c"+idx+" textarea").prop("readonly", false); //or textarea에 id값을 주고 $().attr("readonly", false)로 수정 
  		$("#c"+idx+" textarea").css("border-color", "blue"); //그냥 강조의미 
  		
  		let titleValueOrin = $("#ti"+idx).text(); //원래제목 
  		let newTitle = "<input type='text' id='newTi"+idx+"' class='form-control' value='"+titleValueOrin+"' style='border-color:blue'> </input>"; //제목창 form
  		$("#ti"+idx).html(newTitle); //제목창 호출 
  		
  		let updateButton = "<a href='javascript:boardUpdate("+idx+")' id='up"+idx+"' class='btn btn-primary btn-sm'> 등록 </a> &nbsp;"
  		// $("#m"+idx).html(updateButton);
  		$("#m"+idx).replaceWith(updateButton);
  		
  		let cancelButton = "<a href='javascript:loadBoardList()' class='btn btn-warning btn-sm'>취소</a>";
  		$("#d"+idx).replaceWith(cancelButton);
  		
  	}
  	/* 글 수정 (폼 업로드_Ajax) */
	function boardUpdate(idx){
  		
  		let newContent = $("#c"+idx+" textarea").val(); //일반적으로 textarea의 값은 val()로 가져온다. 
  		let newTitle = $("#newTi"+idx).val();
  		
  		$.ajax({
  			url : "board/update",
  			method : "PUT",
  			contentType : 'application/json;charset=utf-8', // 넘기는 data의 타입 제정 
  			data : JSON.stringify({ // data를 JSON으로 바꿔주기 
  				"idx" : idx,
  				"title" : newTitle,
  				"content" : newContent,
  			}),
  			success : function(){
  				alert('수정 성공');
  				loadBoardList();
  			}, 
  			error : function(){alert('error : ' + idx);}
  		});
	}
  	
  	/* 글 삭제 */
  	function goDelete(idx){
  		if(confirm(idx + '번 글을 삭제하시겠습니까?')){
  			deleteBoard(idx);
  		} else {
  			alert('삭제가 취소되었습니다.');
  		}
  		
  		function deleteBoard(idx){
  			
	  		$.ajax({
	  			url : "board/" + idx, // PathVariable 값 
	  			type : "DELETE",
	  			//data : { "idx" : idx }, //주의 : data값은 객체형식이어야 한다. RESTful방식에선 생략 
	  			success : function(response){
	 	  				alert( idx+'번 게시물을 삭제하였습니다.');
	 	  				loadBoardList(); //쓰고나면 리스트 갱신해
	 	  				
	 	  				},
	 	  		error : function(){alert('error : ' + idx);}
	  		});
  		}
  	}
  </script>
</head>
<body>
<div class="container mt-3">
  <h2>Spring MVC02</h2>
  <div class="card card-default">
    <div class="card-header">BOARD
    	<!-- <span><button popovertarget="myPopover" popovertargetaction="show">popover모달창 show</button> <button popovertarget="myPopover" popovertargetaction="hide">popover모달창 hide</button></span>
    	<div id="myPopover" popover>아이디 : <input type="text" >  비밀번호 : <input type="text"></div> -->
    </div>
    <div class="card-body" id="view">card Content</div>
    
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
	         		<button type="button" id="insertBoard" class="btn btn-success btn-sm">등록</button>
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