<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
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
<title>커뮤니티</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/contents.css" rel="stylesheet">
<script>

document.addEventListener('DOMContentLoaded', function () {
    function updateTime() {
        var now = new Date();
        var hours = now.getHours().toString().padStart(2, '0');
        var minutes = now.getMinutes().toString().padStart(2, '0');
        var seconds = now.getSeconds().toString().padStart(2, '0');
        var day = now.getDate(); // 일
        var month = (now.getMonth() + 1).toString().padStart(2, '0'); // 월 (0부터 시작하므로 +1)
        var year = now.getFullYear(); // 연도
        var weekday = now.toLocaleString('default', { weekday: 'short' }); // 요일 (예: Mon, Tue)

        document.getElementById('current-time').textContent = hours + ":" + minutes + ":" + seconds;
        document.getElementById('current-date').textContent = year + "-" + month + "-" + day + " (" + weekday + ")";
    }

    // 매초마다 시간 갱신
    setInterval(updateTime, 1000);

    // 최초 실행
    updateTime();
});

function deletecheck() {
    const fm = document.form;
    const ans = confirm("글을 삭제하겠습니까?");
    
    if (ans) {
        fm.action = "${pageContext.request.contextPath}/board/communityDeleteAction.aws";
        fm.method = "post";
        fm.enctype="multipart/form-data";
        fm.submit();
    }
}

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
			url : "${pageContext.request.contextPath}/board/communityRecom.aws?bidx=${bv.bidx}",
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
	<div class="contents">
        <!-- 상단바 -->
        <div class="header">
		  <div class="logo">koreacompany</div>
          <div class="user-info">
              <span id="current-date"></span>
              <span id="current-time"></span>
              <span id="name">${name}</span>
              <a href="${pageContext.request.contextPath}/member/memberLogout.aws">로그아웃</a>
          </div>
		</div>

        <!-- 리스트 콘텐츠 -->
        <div class="contents-content">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/dashboard.aws">홈</a></li>
	                <li class="menu-item" id="work-report">업무 보고
	                    <ul class="submenu">
	                        <li><a href="${pageContext.request.contextPath}/board/weekWorkList.aws">주간 업무</a></li>
	                        <li><a href="${pageContext.request.contextPath}/board/monthWorkList.aws">월간 업무</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item" id="attendance-management">근태 관리
	                    <ul class="submenu">
	                        <li><a href="${pageContext.request.contextPath}/board/leaveWrite.aws">휴가 신청</a></li>
	                        <li><a href="${pageContext.request.contextPath}/board/businessTripWrite.aws">출장 신청</a></li>
	                        <li><a href="${pageContext.request.contextPath}/board/calendar.aws">일정 관리</a></li>
	                        <c:if test="${sessionScope.grade == 'admin'}">
	                        <li><a href="${pageContext.request.contextPath}/board/leaveList.aws">휴가 승인</a></li>
	                        <li><a href="${pageContext.request.contextPath}/board/businessTripList.aws">출장 승인</a></li>
	                        </c:if>
	                    </ul>
	                </li>
	                <c:if test="${sessionScope.grade == 'admin'}">
	                <li class="menu-item" id="employee-management">직원 관리
	                    <ul class="submenu">
	                        <li><a href="${pageContext.request.contextPath}/department/departmentList.aws">부서 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/memberList.aws">직원 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/employeeRegister.aws">직원 등록</a></li>
	                    </ul>
	                </li>
	                </c:if>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/noticeList.aws">공지사항</a></li>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/communityList.aws">커뮤니티</a></li>
	            </ul>
            </nav>
            <main class="main">
				<form name="form">
				<input type="hidden" name="bidx" value="${bv.bidx }">
					<div class="main-list">
		                <header>
							<h2 class="mainTitle">커뮤니티</h2>
						</header>
						<article class="detailContents">
							<h4 class="contentTitle">${bv.subject}
								(조회수:${bv.viewcnt}) <input type="button" id="btn"
									value="추천${bv.recom})">
							</h4>
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
							<c:if test="${sessionScope.grade == 'admin' || sessionScope.midx == bv.midx}">
							<a class="btn aBtn"
								href="${pageContext.request.contextPath}/board/communityModify.aws?bidx=${bv.bidx}">수정</a>
							</c:if>
							<c:if test="${sessionScope.grade == 'admin'}">
							<a class="btn aBtn" 
								onclick="deletecheck();" >삭제
							</a>
							</c:if>
							<a class="btn aBtn"
								href="${pageContext.request.contextPath}/board/communityReply.aws?bidx=${bv.bidx}">답변</a>
							<a class="btn aBtn"
								href="${pageContext.request.contextPath}/board/communityList.aws">목록</a>
						</div>
		            </div> 
	            </form>
	            <article class="commentContents">
					<form name="frm">
						<p class="commentWriter" style="width:100px;">
						<input type="text" id="cwriter" name="cwriter" value="${name}" readonly="readonly" style="width:100%;border:0px;">
						</p>	
						<input type="text" id="ccontents" name="ccontents"style="width:83%;height:25px;">		
						<button type="button" id="cmtbtn" class="replyBtn">댓글쓰기</button>
					</form>	
					<div id = "commentListView"></div>
					
					<div id = "morebtn" style = "text-align:center; line-height:50px">
						<button type = "button" id = "more" >더보기</button>
						<input type = "hidden" id = "block" value = "1">
					</div>
				</article>
	       	</main>         
        </div>
    </div>
    <script>
	 	// 모든 메뉴 항목을 선택
	    const menuItems = document.querySelectorAll('.menu-item');
	
	    // 각 메뉴 항목에 클릭 이벤트 등록
	    menuItems.forEach(menuItem => {
	        menuItem.addEventListener('click', (event) => {
	            const submenu = menuItem.querySelector('.submenu');
	            
	            if (submenu) {
	                submenu.classList.toggle('visible'); // 서브메뉴 토글
	            }
	        });
	    });
	</script>
</body>
</html>