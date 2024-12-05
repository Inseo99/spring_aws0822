<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월간보고</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/save.css">
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
	<div class="save"> 
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

        <!-- 콘텐츠 -->
        <div class="save-content">
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
			<div class="info-form">
                <h3>월간보고</h3>
                <form>
                <input type="hidden" name="reportType" value="month">
                    <table class="combined-info-table">
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="subject" id= "subject" required></td>
                        </tr>
                        <tr>
							<th>첨부파일</th>
							<td><input type="file" name = "filename"></td>
						</tr>
                        <tr>
                            <th>이번주 한 일</th>
                            <td colspan="3">
                                <textarea name="contents" id="t-contents" rows="6" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>다음주 한 일</th>
                            <td colspan="3">
                                <textarea name="contents" id="n-contents" rows="6" required></textarea>
                            </td>
                        </tr>
                    </table>
                    <div class="btnBox">
			            <button type="button" class="btn">저장</button>
			            <a class="btn aBtn" onclick="history.back();">취소</a>
			        </div>
                </form>
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