<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>스프링 학습하기</title>
</head>
<body>
<header>
<h3>
<% if(session.getAttribute("midx") != null) {
	out.print(session.getAttribute("memberName") + " 로그아웃");
}
%>
</h3>
<hr>
</header>

<a href="<%=request.getContextPath()%>/member/memberJoin.aws">회원가입 페이지</a><br>
<a href="<%=request.getContextPath()%>/member/memberLogin.aws">회원로그인 페이지</a><br>


</body>
</html>