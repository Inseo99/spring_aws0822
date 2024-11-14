<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>스프링 학습하기</title>
</head>
<body>
<header>
<h3 style="display: flex; align-items: center;">
	<c:if test="${!empty sessionScope.midx}">
		<span>${memberName}</span>
		<form action="/member/memberLogout.aws" method="get" style="margin-left: 10px;">
		<button type="submit">로그아웃</button>
		</form>
	</c:if>
</h3>
<hr>
</header>



<a href="${pageContext.request.contextPath}/member/memberJoin.aws">회원가입 페이지</a><br>
<a href="${pageContext.request.contextPath}/member/memberLogin.aws">회원로그인 페이지</a><br>
<a href="${pageContext.request.contextPath}/member/memberList.aws">회원목록 페이지</a><br>
<a href="${pageContext.request.contextPath}/board/boardList.aws">게시판 페이지</a><br>

</body>
</html>