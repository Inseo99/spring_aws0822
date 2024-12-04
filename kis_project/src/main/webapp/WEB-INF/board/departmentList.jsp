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
<title>부서 목록</title>
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
				    <li class="menu-item"><a href="${pageContext.request.contextPath}/board/adminDashboard.aws">홈</a></li>
	                <li class="menu-item" id="work-report">업무 보고
	                    <ul class="submenu">
	                        <li><a href="../public/weekWorkList.html">주간 업무</a></li>
	                        <li><a href="../public/monthWorkList.html">월간 업무</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item" id="attendance-management">근태 관리
	                    <ul class="submenu">
	                        <li><a href="#">휴가 신청</a></li>
	                        <li><a href="#">출장 신청</a></li>
	                        <li><a href="../public/calendar.html">일정 관리</a></li>
	                        <li><a href="./leaveList.html">휴가 승인</a></li>
	                        <li><a href="./businessTripList.html">출장 승인</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item" id="employee-management">직원 관리
	                    <ul class="submenu">
	                        <li><a href="${pageContext.request.contextPath}/board/departmentList.aws">부서 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/memberList.aws">직원 목록</a></li>
	                        <li><a href="${pageContext.request.contextPath}/member/employeeRegister.aws">직원 등록</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item"><a href="../public/noticeList.html">공지사항</a></li>
	                <li class="menu-item"><a href="../public/communityList.html">커뮤니티</a></li>
				</ul>
            </nav>
            <!-- 목록 콘텐츠 -->
            <div class="main-list">
                <header>
					<h2 class="mainTitle">부서 목록</h2>
					<form class="search" name="frm" action="./employeeList.html">
						<select name="searchType">
							<option value="leaderName">팀장 이름</option>
							<option value="department">부서</option>
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
                            <th>인원</th>
                            <th>팀장 이름</th>
                            <th>부서 연락처</th>
                            <th>최근 수정 날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td><a href="./employeeList.html">개발팀</a></td>
                            <td>7</td>
                            <td>홍길동</td>
                            <td>010-1234-5678</td>
                            <td>2022-01-15</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>디자인팀</td>
                            <td>5</td>
                            <td>김철수</td>
                            <td>010-2345-6789</td>
                            <td>2021-11-10</td>
                        </tr>
                        <!-- 추가 직원들 -->
                    </tbody>
                </table>
                <div class="btnBox">
					<a class="btn" href="${pageContext.request.contextPath}/board/departmentRegister.aws">부서 등록</a>
				</div>
            </div>
        </div>
    </div>
    <script>
	 	// 모든 메뉴 항목 선택
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
