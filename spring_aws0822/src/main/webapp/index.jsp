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
<% if(session.getAttribute("midx") != null) { %>
    <h3 style="display: flex; align-items: center;">
        <span><%= session.getAttribute("memberName") %></span>
        <form action="/member/memberLogout.aws" method="get" style="margin-left: 10px;">
            <button type="submit">로그아웃</button>
        </form>
    </h3>
<% } %>
<hr>
</header>

<a href="<%=request.getContextPath()%>/member/memberJoin.aws">회원가입 페이지</a><br>
<a href="<%=request.getContextPath()%>/member/memberLogin.aws">회원로그인 페이지</a><br>
<a href="<%=request.getContextPath()%>/member/memberList.aws">회원목록 페이지</a><br>

</body>
</html>