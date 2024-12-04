<%@page import="com.myaws.myapp.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
/* BoardVo bv = (BoardVo)request.getAttribute("bv"); // 강제형변환 양쪽형을 맞춰준다

String memberName = "";
int midx = 0;
if(session.getAttribute("memberName") != null) {
	memberName = (String)session.getAttribute("memberName");
}
if(session.getAttribute("midx") != null) {
	midx = Integer.parseInt(session.getAttribute("midx").toString());
} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글내용</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- jquery CDN주소 -->
<link href="/resources/css/boardStyle.css" rel="stylesheet">
<script> 

function checkImageType(fileName) {
	
	var pattern = /jpg$|gif$|png$|jpeg$/i;	// 자바스크립트 정규표현식
	
	return fileName.match(pattern);
}

function getOriginalFileName(fileName) {	// 원본 파일이름 추출
	
	var idx = fileName.lastIndexOf("_") + 1;	
	
	return fileName.substr(idx);
}

function getImageLink(fileName) {	// 이미지 링크 가져오기
	
	var front = fileName.substr(0, 12);
	var end = fileName.substr(14);
	
	return front + end;
}

// download();
function download() {
	// 주소사이에 s-는 빼고
	var downloadImage = getImageLink("${bv.filename}");
	// alert(downloadImage);
	var downLink = "${pageContext.request.contextPath}/board/displayFile.aws?fileName="+ downloadImage +"&down=1";	
	// alert(downLink);
	
	return downLink;
}

function commentDel(cidx) {
	
	let ans = confirm("삭제하시겠습니까?");
	
	if (ans == true) {
		
		$.ajax({
			type : "get",	
			url : "${pageContext.request.contextPath}/comment/"+ cidx +"/commentDeleteAction.aws",
			dataType : "json",		
			success : function(result) {	
				
				$.boardCommentList();
			},
			error : function() {		// 결과가 실패했을 때 받는 영역
				alert("전송실패");
			}			
		});
	}
	
	return;
}

//jquery로 만드는 함수
$.boardCommentList = function(){
	
	let block = $("#block").val();
	
	
	$.ajax({
		type : "get",	
		url : "${pageContext.request.contextPath}/comment/${bv.bidx}/"+ block +"/commentList.aws",
		dataType : "json",		
		success : function(result) {	
			// alert("전송성공");
			
			var strTr = "";
			$(result.clist).each(function(){
			
				var btnn = "";
				if (this.midx == "${midx}"){		
				if (this.delyn == 'N') {
					btnn = "<button class = 'btn' type = 'button' onclick = 'commentDel(" + this.cidx + ")'>삭제</button>";					
					}				
				}
			
				strTr = strTr + "<tr>"
				+ "<td>" + this.cidx + "</td>"
				+ "<td>" + this.cwriter + "</td>"
				+ "<td class='content'>" + this.ccontents + "</td>"
				+ "<td>" + this.writeday + "</td>"
				+ "<td>" + btnn + "</td>"
				+ "</tr>"
			
			});
		
			var str = "<table class='replyTable'>"
			+ "<tr>" 
			+ "<th>번호</th>"
			+ "<th>작성자</th>"
			+ "<th>내용</th>"
			+ "<th>날짜</th>"
			+ "<th>DEL</th>"
			+ "</tr>" + strTr + "</table>"
			
			$("#commentListView").html(str);
	
			if (result.moreView == "N") {
				$("#morebtn").css("display", "none");	// 감춘다.
			} else {
				$("#morebtn").css("display", "block");	// 보여준다.
			}
			
			$("#block").val(result.nextBlock);	
		
		},
		error : function() {		
			// alert("전송실패");
		}			
	});		
	
}

$(document).ready(function() {	// cdn주소 필요	
	
	$("#dUrl").html(getOriginalFileName("${bv.filename}"))

	$("#dUrl").click(function() {
		$("#dUrl").attr("href", download());
		return;
	});
		
	$.boardCommentList();
	
	$("#btn").click(function() {
		// alert("추천버튼 클릭")
		
		$.ajax({
			type : "get",
			url : "${pageContext.request.contextPath}/board/boardRecom.aws?bidx=${bv.bidx}",
			dataType : "json",	
			success : function(result) {	
				var str = "추천("+result.recom+")";
		
				$("#btn").val(str);
			},
			error : function() {		// 결과가 실패했을 때 받는 영역
				alert("전송실패");
			}			
		});
		
	});
	
	$("#cmtbtn").click(function() {
		
		let loginCheck = "${midx}";
		if (loginCheck == "" || loginCheck == "null" || loginCheck == null || loginCheck == 0) {
			alert("로그인을 해주세요.");
			return;
		}
		
		let cwriter = $("#cwriter").val();
		let ccontents = $("#ccontents").val();
		
		if (cwriter == "") {
			alert("작성자를 입력해주세요.");
			$("#cwriter").focus();
			return;
			
		} else if (ccontents == "") {
			alert("내용을 입력해주세요.");
			$("#ccontents").focus();
			return;
		}
		
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/comment/commentWriteAction.aws",
			data : {"cwriter" : cwriter, 
					"ccontents" : ccontents, 
					"bidx" : "${bv.bidx}", 
					"midx" : "${midx}"
					},
			dataType : "json",		
			success : function(result) {
		 		alert("댓글이 등록되었습니다.");
		 		if(result.value == 1) {
		 			$("#ccontents").val("");
		 			$("#block").val(1);
		 		}
		 		
		 		$.boardCommentList();
			},
			error : function() {
				alert("전송실패");
			}			
		});		
	});
	
	$("#more").click(function() {
		$.boardCommentList();
	});
	
});


</script>
</head>
<body>
	<header>
		<h2 class="mainTitle">글내용</h2>
	</header>

	<article class="detailContents">
		<h2 class="contentTitle">${bv.subject}
			(조회수:${bv.viewcnt} <input type="button" id="btn"
				value="추천${bv.recom})">
		</h2>
		<p class="write">${bv.writer}
			(${bv.writeday})
		</p>
		<hr>
		<div class="content">
			${bv.contents}
		</div>
		<c:if test="${!empty bv.filename}">
		<img src="${pageContext.request.contextPath}/board/displayFile.aws?fileName=${bv.filename}">
		<p>
		<a id="dUrl"  href="#"  class="fileDown">	
		첨부파일 다운로드</a>
		</p>
		</c:if>
	</article>

	<div class="btnBox">
		<!-- <a class="btn aBtn"
			id="dUrl" href="#">다운</a> -->
		<a class="btn aBtn"
			href="${pageContext.request.contextPath}/board/boardModify.aws?bidx=${bv.bidx}">수정</a>
		<a class="btn aBtn" 
			href="${pageContext.request.contextPath}/board/boardDelete.aws?bidx=${bv.bidx}">삭제</a> 
		<a class="btn aBtn"
			href="${pageContext.request.contextPath}/board/boardReply.aws?bidx=${bv.bidx}">답변</a>
		<a class="btn aBtn"
			href="${pageContext.request.contextPath}/board/boardList.aws">목록</a>
	</div>

	<article class="commentContents">
		<form name="frm">
			<p class="commentWriter" style="width:100px;">
			<input type="text" id="cwriter" name="cwriter" value="${memberName}" readonly="readonly" style="width:100%;border:0px;">
			</p>	
			<input type="text" id="ccontents" name="ccontents"style="width:75%;height:25px;">		
			<button type="button" id="cmtbtn" class="replyBtn">댓글쓰기</button>
	</form>	
		<div id = "commentListView"></div>
		
		<div id = "morebtn" style = "text-align:center; line-height:50px">
			<button type = "button" id = "more" >더보기</button>
			<input type = "hidden" id = "block" value = "1">
		</div>
	</article>
</body>
</html>