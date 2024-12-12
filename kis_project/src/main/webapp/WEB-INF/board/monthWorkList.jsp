<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월간 보고</title>
<link href="${pageContext.request.contextPath}/resources/css/list.css" rel="stylesheet">
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

</script>
</head>
<body>
	<div class="List">
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
        <div class="list-content">
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
			<div class="main-list">
                <header>
					<h2 class="mainTitle">월간 보고</h2>
					<form class="search" name = "frm" action = "${pageContext.request.contextPath}/board/monthWorkList.aws">
					<input type="hidden" name="type" value="월간">
						<select name = "searchType">
							<option value = "name">작성자</option>
							<option value = "department">제목</option>
						</select>
						<input type="text" name = "keyword">
						<button type = "submit" class="btn">검색</button>
					</form>
				</header>
                <table class="main-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items = "${blist}" var = "wv" varStatus="status"> 
	                        <tr>
	                            <td>${pm.totalCount - (status.index + (pm.scri.page-1) * pm.scri.perPageNum) }</td>
	                            <td><a href="${pageContext.request.contextPath}/board/weekWorkContents.aws?bidx=${wv.wbidx}">${wv.subject }</a></td>
	                            <td>${wv.name }</td>
	                            <td>${wv.writeday.substring(0,10) }</td>
	                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>
                <div class="btnBox">
					<a class="btn" href="${pageContext.request.contextPath}/board/monthWorkWrite.aws">보고</a>
				</div>
				<div class="page">
					<ul>
						<c:if test="${pm.prev == true}">
							<li><a href = "${pageContext.request.contextPath}/board/noticeList.aws?page=${pm.startPage - 1}&${queryParam}">◀</a></li>
						</c:if>		
						<c:forEach var = "i" begin = "${pm.startPage}" end = "${pm.endPage}" step = "1">
							<li <c:if test="${i == pm.scri.page}"> class = 'on'</c:if>>
								<a href = "${pageContext.request.contextPath}/board/noticeList.aws?page=${i}&${queryParam}">
								${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pm.next && pm.endPage > 0 }">
							<li><a href = "${pageContext.request.contextPath}/board/noticeList.aws?page=${pm.endPage + 1}&${queryParam}">▶</a></li>
						</c:if>
					</ul>
				</div>
            </div>            
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