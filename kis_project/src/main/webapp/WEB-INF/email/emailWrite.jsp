<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String msg = "";  
if (request.getAttribute("msg") != null) {
	msg = (String)request.getAttribute("msg");
}

if (msg != "") {
	out.println("<script>alert('" + msg + "');</script>");	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link href="/resources/css/boardStyle.css" rel="stylesheet">
<script> 

function check() {
	  
	  // 유효성 검사하기
	  let fm = document.frm;	// 문서객체안에 폼객체
	  
	  if (fm.subject.value == "") {
		  alert("제목을 입력해주세요");
		  fm.subject.focus();
		  return;
	  } else if (fm.contents.value == "") {
		  alert("내용을 입력해주세요");
		  fm.contents.focus();
		  return;
	  } else if (fm.senderemail.value == "") {
		  alert("보내는 메일 주소를 입력해주세요");
		  fm.senderemail.focus();
		  return;
	  } else if (fm.receiveremail.value == "") {
		  alert("받는 사람 메일 주소를 입력해 주세요");
		  fm.receiveremail.focus();
		  return;
	  }
	  
	  let ans = confirm("발송하시겠습니까?");
	  
	  if (ans == true) {
		  fm.action="${pageContext.request.contextPath}/email/emailWriteAction.aws";
		  fm.method="post";
		  fm.submit();
	  }	  	  
	  return;
}

</script>
</head>
<body>
<header>
	<h2 class="mainTitle">메일쓰기</h2>
</header>

<form name="frm">
	<table class="writeTable">
		<tr>
			<th>제목</th>
			<td><input type="text" name="subject"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="contents" rows="6"></textarea></td>
		</tr>
		<tr>
			<th>보내는 메일</th>
			<td><input type="text" name="senderemail"></td>
		</tr>
		<tr>
			<th>받는 메일</th>
			<td><input type="text" name ="receiveremail"></td>
		</tr>
	</table>
	
	<div class="btnBox">
		<button type="button" class="btn" onclick="check();">전송</button>
		<a class="btn aBtn" onclick = "history.back();">취소</a>
	</div>	
</form>

</body>
</html>