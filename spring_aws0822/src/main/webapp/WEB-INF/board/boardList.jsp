<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="com.myaws.myapp.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
/* ArrayList<BoardVo> blist = (ArrayList<BoardVo>)request.getAttribute("blist");
// 페이징과 검색
PageMaker pm = (PageMaker)request.getAttribute("pm");
int totalCount = pm.getTotalCount();
String keyword = pm.getScri().getKeyword();
String searchType = pm.getScri().getSearchType();
String param = "keyword=" + keyword + "%searcType=" + searchType + ""; */

// 메세지출력
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
<title>글목록</title>
<link href="/resources/css/boardStyle.css" rel="stylesheet">
</head>
<body>
<header>
	<h2 class="mainTitle">글목록</h2>
	<form class="search" name = "frm" action = "<%=request.getContextPath()%>/board/boardList.aws">
		<select name = "searchType">
			<option value = "subject">제목</option>
			<option value = "writer">작성자</option>
		</select>
		<input type="text" name = "keyword">
		<button type = "submit" class="btn">검색</button>
	</form>
</header>

<section>	
	<table class="listTable">
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회</th>
			<th>추천</th>
			<th>날짜</th>
		</tr>
	   <c:forEach items = "${blist}" var = "bv" varStatus="status"> 
		<tr>
			<td>${pm.totalCount - (status.index + (pm.scri.page-1) * pm.scri.perPageNum) }</td>			
			<td class="title">			
			<c:forEach var = "i" begin = "1" end = "${bv.level_ }" step = "1">
				&nbsp;&nbsp;
				<c:if test="${i == bv.level_}">
					ㄴ
				</c:if>				
			</c:forEach>			
			<a href="${pageContext.request.contextPath}/board/boardContents.aws?bidx=${bv.bidx}">${bv.subject}</a></td>
			<td>${bv.writer}</td>
			<td>${bv.viewcnt}</td>
			<td>${bv.recom}</td>
			<td>${bv.writeday.substring(0,10)}</td>
		</tr>
		</c:forEach>
	</table>
	
	<div class="btnBox">
		<a class="btn aBtn" href="<%=request.getContextPath()%>/board/boardWrite.aws">글쓰기</a>
	</div>
	
	<c:set var = "queryParam" value = "keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}"></c:set>
	<div class="page">
		<ul>
			<c:if test="${pm.prev == true}">
				<li><a href = "${pageContext.request.contextPath}/board/boardList.aws?page=${pm.startPage - 1}&${queryParam}">◀</a></li>
			</c:if>		
			<c:forEach var = "i" begin = "${pm.startPage}" end = "${pm.endPage}" step = "1">
				<li <c:if test="${i == pm.scri.page}"> class = 'on'</c:if>>
					<a href = "${pageContext.request.contextPath}/board/boardList.aws?page=${i}&${queryParam}">
					${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next && pm.endPage > 0 }">
				<li><a href = "${pageContext.request.contextPath}/board/boardList.aws?page=${pm.endPage + 1}&${queryParam}">▶</a></li>
			</c:if>
		</ul>
	</div>
</section>

</body>
</html>