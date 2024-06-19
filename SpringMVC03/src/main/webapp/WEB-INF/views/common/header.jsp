<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/> <!-- URI의 루트값을 contextPath 변수에 넣겠다는 의미 -->
<!-- 나중에 유지보수 쉽게 하기 위해서. -->

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span> <!--겉으로 보이는 줄 개수 -->
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath}/">스프1탄</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath}/">Home</a></li>
        <li><a href="boardMain.do">게시판</a></li>
        <li><a href="#">Page 2</a></li>
      </ul>
      
      <!--로그인 안된 상태-->
      <c:if test="${empty user}"> <!-- HttpSession값 확인 -->
	      <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
	          <a class="dropdown-toggle" data-toggle="dropdown" href="#">접속하기<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="${contextPath}/member/memJoin.do"> 회원가입 </a></li>
	            <li><a href="#"> 로그인 </a></li>
	          </ul>
	        </li>
	      </ul>
      </c:if>
      
      <!--로그인 된 상태-->
      <c:if test="${!empty user}">
	      <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
	          <a class="dropdown-toggle" data-toggle="dropdown" href="#">접속하기<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="#"> 회원정보수정 </a></li>
	            <li><a href="#"> 프로필사진등록 </a></li>
	            <li><a href="#"> 로그아웃 </a></li>
	          </ul>
	        </li>
	      </ul>
      </c:if>
      
    </div>
  </div>
</nav>