<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/> <!-- URI의 루트값을 contextPath 변수에 넣겠다는 의미 -->
<!-- 나중에 유지보수 쉽게 하기 위해서. -->

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
	  idDupliCheck(); //아이디 중복 체크 
	  passwordCheck(); //비밀번호 재확인 
	  
  });
  
  
  /* 아이디 중복 체크 함수  */
  function idDupliCheck(){ //실행해주기 위해서는 document.ready에 넣어줘야..
  	const pwDupliCheck = document.getElementById('IDDupliCheck');
	  
  	pwDupliCheck.addEventListener('click', registerCheck);
  	
  	function registerCheck(){
  		let memID = $("#memID").val();
  		$.ajax({
  			url : "${contextPath}/member/memRegisterCheck.do",
  			type : "get",
  			data : {"memID" : memID},
  			success : function(result){
  				//중복유무 출력 (result=0 : 이미존재, reuslt=1 : 양식오류, result=2 : 사용가능)
  				switch(result){
  					case 0 :
  						$("#dupliAlert").text("이미 존재하는 아이디 입니다.");
  						$("#checkType").attr("class", "modal-content panel-warning"); //색 바꾸기
  						break;
  					case 1 : 
  						$("#dupliAlert").text("아이디로 적합하지 않습니다. 다시 확인해 주세요.");
  						$("#checkType").attr("class", "modal-content panel-danger");
  						break;
  					case 2 :
  						$("#dupliAlert").text("사용가능한 아이디입니다.");
  						$("#checkType").attr("class", "modal-content panel-success");
  						break;
  				}
  				//$("#myModal").modal("show");
  			},
  			error : function(){
  				alert("error");
  			}
  			
  		});
  		
  	}
  	
  }
  
  /* 비밀번호 확인 체크  */
	function passwordCheck(){
	  const memPW1 = document.getElementById('memPW1');
	  const memPW2 = document.getElementById('memPW2');
	  
	  memPW1.addEventListener('keyup', passwordCheck2 ); //소문자 
	  memPW2.addEventListener('keyup', passwordCheck2 );
	  
	  function passwordCheck2(){
		  const pw1 = $('#memPW1').val();
		  const pw2 = $('#memPW2').val();
		  if(pw1 !== pw2){
			  $('#pwShow').text("비밀번호가 서로 일치하지 않습니다.");
		  } else {
			  $('#pwShow').text("비밀번호가 서로 일치합니다.");
			  $('#memPassword').val(memPassword1); //서로 일치할 때, 찐 PW값에 PW1넣어주기
		  }
	  }
  }
  
  </script>
  
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp" /> 
  <h2>스프링 MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
    
    	<form action="${contextPath }/member/memRegister.do" method="post">
    		<input type="hidden" id="memPassword" name="memPassword" value="" /> <!-- 조건식: PW1과 PW2가 같으면 찐 PW값 넣어줄거임 -->
				<table class="table table-bordered" style="text-align:center;  border: 1px solid #dddddd; ">
					<tr>
						<td style="width: 100px; vertical-align:middle; ">아이디</td>
						<td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력해 주세요. 최대20자"/></td>
						<td style="width: 100px; "><button type="button" id="IDDupliCheck" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">중복확인</button></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">비밀번호</td>
						<td colspan="2"><input id="memPW1" name="memPW1" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력해 주세요."/></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">비밀번호 확인</td>
						<td colspan="2"><input id="memPW2" name="memPW2" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 재입력해 주세요."/></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">사용자 이름</td>
						<td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요."/></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">나이</td>
						<td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요."/></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">핸드폰번호</td>
						<td colspan="2"><input id="memPhone" name="memPhone" class="form-control" type="text" maxlength="20" placeholder="핸드폰번호를 입력해 주세요('-' 하이픈 포함)"/></td>
					</tr>
					<tr>
						<td style="width: 100px; vertical-align:middle; ">이메일</td>
						<td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="text" maxlength="30" placeholder="이메일을 입력해 주세요."/></td>
					</tr>
					
					<tr>
						<td style="width: 100px; vertical-align:middle; ">성별</td>
						<td colspan="2">
							<div class="form-group" style="text-align: center; margin: 0 auto;">
								<div class="btn btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input id="memGenderM" name="memGender" type="radio" autocomplete="off" value="남자" checked="checked">남자
									</label>
									<label class="btn btn-primary">
										<input id="memGenderW" name="memGender" type="radio" autocomplete="off" value="여자" >여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="text-align: left;">
							<span id="pwShow" style="color: red"></span><button type="submit" class="btn btn-primary btn-sm pull-right" >등록</button>
						</td>
					</tr>
					
				</table>   		
    	</form>
    	
    </div>
    
    <!-- 다이얼로그창(모달창) -->
    <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog modal-sm">
		
		    <!-- Modal content-->
		    <div id="checkType" class="modal-content">
		      <div class="modal-header panel-heading">
		        <button type="button" class="close" data-dismiss="modal">&times;</button> <!-- 모달창 x버튼 -->
		        <h4 class="modal-title">메세지 확인</h4>
		      </div>
		      <div class="modal-body">
		        <p id="dupliAlert"></p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		
    <div class="panel-footer">스프링 1탄_인프런(신민기)</div>
  </div>
</div>

</body>
</html>
