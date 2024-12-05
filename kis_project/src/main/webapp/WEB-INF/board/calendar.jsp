<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calender.css">
<script>

function updateTime() {
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    const seconds = now.getSeconds().toString().padStart(2, '0');
    const day = now.getDate(); // 일
    const month = now.getMonth() + 1; // 월 (0부터 시작하므로 +1)
    const year = now.getFullYear(); // 연도
    const weekday = now.toLocaleString('default', { weekday: 'short' }); // 요일 (예: Mon, Tue)

    document.getElementById('current-time').textContent = `${hours}:${minutes}:${seconds}`;
    document.getElementById('current-date').textContent = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')} (${weekday})`; // 날짜 형식 (YYYY-MM-DD)
}

// 매초마다 시간 갱신
setInterval(updateTime, 1000);

// 최초 실행
updateTime();

</script>
</head>
<body>
	<div class="calendar">
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

        <!-- 대시보드 콘텐츠 -->
        <div class="dashboard-content">
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
			<div class="calendar-container">
		        <!-- 달력 헤더 -->
		        <div class="calendar-header">
		            <button id="prev-month">◀</button>
		            <h2 id="current-month">2024년 11월</h2>
		            <button id="next-month">▶</button>
		        </div>
		
		        <!-- 달력 본문 -->
		        <div class="calendar">
		            <!-- 요일 -->
		            <div class="day-name">일</div>
		            <div class="day-name">월</div>
		            <div class="day-name">화</div>
		            <div class="day-name">수</div>
		            <div class="day-name">목</div>
		            <div class="day-name">금</div>
		            <div class="day-name">토</div>
		
		            <!-- 날짜 -->
		            <!-- 날짜는 JavaScript로 채워질 공간 -->
		            <div class="day"></div>
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