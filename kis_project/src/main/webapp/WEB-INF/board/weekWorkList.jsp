<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주간 보고</title>
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
					<h2 class="mainTitle">주간 보고</h2>
					<form class="search" name = "frm" action = "#">
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
                            <th>이름</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>20241121~28일 주간 업무보고합니다.</td>
                            <td>홍길동</td>
                            <td>2022-01-15</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>2021110~17 개발 000 업무보고합니다.</td>
                            <td>이순신</td>
                            <td>2021-11-10</td>
                        </tr>
                    </tbody>
                </table>
                <div class="btnBox">
					<a class="btn" href="${pageContext.request.contextPath}/board/weekWorkWrite.aws">보고</a>
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