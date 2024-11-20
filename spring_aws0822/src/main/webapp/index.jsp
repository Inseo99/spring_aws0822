<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 학습하기 - 메인</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f5;
        margin: 0;
        padding: 0;
        text-align: center;
    }
    header {
        background-color: #333;
        color: #fff;
        padding: 15px;
        font-size: 1.2em;
    }
    .container {
        display: grid;
        gap: 15px;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        padding: 20px;
        max-width: 900px;
        margin: 20px auto;
    }
    .card {
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    .card a {
        text-decoration: none;
        color: #333;
        font-weight: bold;
    }
    .card a:hover {
        color: #007bff;
    }
    .card h4 {
        margin-bottom: 10px;
        color: #555;
    }
    .card button {
        padding: 8px 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .card button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
<header>
    <h3>스프링 학습하기 메인</h3>
    <c:if test="${!empty sessionScope.midx}">
        <div>
            <span>환영합니다, ${memberName}님!</span>
            <form action="/member/memberLogout.aws" method="get" style="display: inline;">
                <button type="submit">로그아웃</button>
            </form>
        </div>
    </c:if>
</header>

<div class="container">
    <div class="card">
        <h4>회원가입</h4>
        <p>새로운 계정을 만들어주세요.</p>
        <a href="${pageContext.request.contextPath}/member/memberJoin.aws">
            <button>회원가입 페이지</button>
        </a>
    </div>
    
    <div class="card">
        <h4>로그인</h4>
        <p>로그인하고 다양한 기능을 이용해보세요.</p>
        <a href="${pageContext.request.contextPath}/member/memberLogin.aws">
            <button>로그인 페이지</button>
        </a>
    </div>
    
    <div class="card">
        <h4>회원 목록</h4>
        <p>등록된 모든 회원을 확인할 수 있습니다.</p>
        <a href="${pageContext.request.contextPath}/member/memberList.aws">
            <button>회원목록 페이지</button>
        </a>
    </div>
    
    <div class="card">
        <h4>게시판</h4>
        <p>다양한 게시글을 확인하고 작성해보세요.</p>
        <a href="${pageContext.request.contextPath}/board/boardList.aws">
            <button>게시판 페이지</button>
        </a>
    </div>
</div>
</body>
</html>
