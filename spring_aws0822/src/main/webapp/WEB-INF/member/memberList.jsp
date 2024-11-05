<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="com.myaws.myapp.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// Arraylist객체를 화면까지 가져왔다.
ArrayList<MemberVo> alist = (ArrayList<MemberVo>)request.getAttribute("alist");

// System.out.println(alist.get(0).getMemberid());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록보기</title>
<style>
table {
	border : 1px solid blue;
	border-collapse : collapse;
}

th,td {
	border : 1px dotted green;
	padding : 10px;
}

th {
	width : 100px;
	height : 40px;
}
td {
	width : 100px;
	height : 20px;
	text-align : right;
}
thead {
	background : violet;
	color : white;
}
tfoot {
	border-bottom : 1px solid gray;
}
tbody tr:nth-child(even){
	background : aliceblue;
}
tbody tr:hover{
	background : pink;
}


</style>
</head>
<body>
<h3>회원목록</h3>
<hr>
<table>
	<thead>
		<tr>
			<th>회원번호</th>
			<th>회원아이디</th>
			<th>회원이름</th>
			<th>성별</th>
			<th>가입일</th>
		</tr>
	</thead>
	<tbody>
<%-- 	  <% for(int i = 0; i < alist.size(); i++) { %>
		<tr>
			<td><%=alist.get(i).getMidx() %></td>
			<td><%=alist.get(i).getMemberid() %></td>
			<td><%=alist.get(i).getMembername() %></td>
			<td><%=alist.get(i).getMembergender() %></td>
			<td><%=alist.get(i).getWriteday() %></td>
		</tr>
	  <% }%> --%>
	   <% 
	   int num = 1;
	   for(MemberVo mv : alist) { %>
		<tr>
			<td><%=mv.getMidx() %></td>
			<td><%=mv.getMemberid() %></td>
			<td><%=mv.getMembername() %></td>
			<td><%=mv.getMembergender() %></td>
			<td><%=mv.getWriteday().substring(0, 10) %></td>
		</tr>
	  <% 
	  num++;
	   }%>
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan = "5">총 <%=num %>명 입니다.</td>
		</tr>
	</tfoot>
</table>
</body>
</html>