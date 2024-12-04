<%@page import="java.util.*"%>
<%@page import="com.kis.management.domain.*"%>
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
<title>직원 목록</title>
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

        <!--콘텐츠 -->
        <div class="list-content">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/adminDashboard.aws">홈</a></li>
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
	                        <li><a href="${pageContext.request.contextPath}/board/leaveList.aws">휴가 승인</a></li>
	                        <li><a href="${pageContext.request.contextPath}/board/businessTripList.aws">출장 승인</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item" id="employee-management">직원 관리
	                    <ul class="submenu">
	                        <li><a href="${pageContext.request.contextPath}/board/departmentList.aws">부서 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/memberList.aws">직원 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/employeeRegister.aws">직원 등록</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/noticeList.aws">공지사항</a></li>
	                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/communityList.aws">커뮤니티</a></li>
	            </ul>
            </nav>
            <!-- 목록 콘텐츠 -->
            <div class="main-list">
                <header>
                    <h2 class="mainTitle">직원 목록</h2>
                    <form class="search" name="frm" action="${pageContext.request.contextPath}/member/memberList.aws">
                        <select name="searchType">
                            <option value="name">이름</option>
                            <option value="department_name">부서</option>
                        </select>
                        <input type="text" name="keyword">
                        <button type="submit" class="btn">검색</button>
                    </form>
                </header>
                <table class="main-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>이름</th>
                            <th>출퇴근</th>
                            <th>연락처</th>
                            <th>입사 날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items = "${mlist}" var = "mv" varStatus="status"> 
                        <tr>
                            <td>${pm.totalCount - (status.index + (pm.scri.page-1) * pm.scri.perPageNum) }</td>
                            <td>${mv.department_name}</td>
                            <td>${mv.position}</td>
                            <td><a href="${pageContext.request.contextPath}/member/employeeM odify.aws?midx=${mv.midx}">${mv.name}</a></td>
                            <td>${mv.attendance_status}</td>
                            <td>${mv.contact}</td>
                            <td>${mv.join_date}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="btnBox">
                    <a class="btn aBtn" href="${pageContext.request.contextPath}/member/employeeRegister.aws">직원등록</a>
                </div>
                <c:set var = "queryParam" value = "keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}"></c:set>
				<div class="page">
					<ul>
						<c:if test="${pm.prev == true}">
							<li><a href = "${pageContext.request.contextPath}/member/memberList.aws?page=${pm.startPage - 1}&${queryParam}">◀</a></li>
						</c:if>		
						<c:forEach var = "i" begin = "${pm.startPage}" end = "${pm.endPage}" step = "1">
							<li <c:if test="${i == pm.scri.page}"> class = 'on'</c:if>>
								<a href = "${pageContext.request.contextPath}/member/memberList.aws?page=${i}&${queryParam}">
								${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pm.next && pm.endPage > 0 }">
							<li><a href = "${pageContext.request.contextPath}/member/memberList.aws?page=${pm.endPage + 1}&${queryParam}">▶</a></li>
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
