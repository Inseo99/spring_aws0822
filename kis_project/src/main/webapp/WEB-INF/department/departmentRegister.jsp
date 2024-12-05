<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kis.management.domain.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 등록</title>
<link href="${pageContext.request.contextPath}/resources/css/save.css" rel="stylesheet">
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

function djoincheck() {
    const fm = document.frm;
	
    if (fm.department_id.value === "") {
        alert("부서번호를 입력해주세요.");
        fm.department_id.focus();
        return;
    }
    if (fm.department_name.value === "") {
        alert("부서이름을 입력해주세요.");
        fm.department_name.focus();
        return;
    }
    if (fm.contact.value === "") {
        alert("연락처를 입력해주세요.");
        fm.contact.focus();
        return;
    }
    if (fm.teamLeader.value === "") {
        alert("팀장 이름을 입력해주세요.");
        fm.teamLeader.focus();
        return;
    }
    if (fm.d_person.value === "") {
        alert("부서인원을 입력해주세요.");
        fm.d_person.focus();
        return;
    }
    if (fm.created_at.value === "") {
        alert("부서생성일을 입력해주세요.");
        fm.created_at.focus();
        return;
    }
    if (fm.d_notes.value === "") {
        alert("부서설명을 입력해주세요.");
        fm.d_notes.focus();
        return;
    }

    const ans = confirm("부서를 등록하겠습니까?");
    if (ans) {
        fm.action = "${pageContext.request.contextPath}/department/departmentRegisterAction.aws";
        fm.method = "post";
        fm.enctype = "multipart/form-data";
        fm.submit();
    }
}

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
		        <span id="username">사용자 이름</span>
		        <a href="../login.jsp">로그 아웃</a>
    		</div>
		</div>
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
			    <h3 class="title-left">부서 정보 등록</h3>
			    <form name = "frm">
			        <!-- 직원 정보 섹션 -->
			        <table class="info-table">
			           <tr>
						    <th>부서번호</th>
						    <td><input type="text" id="department_id" name="department_id" aria-labelledby="employee-id-label"></td>
						    <th>부서이름</th>
						    <td><input type="text" id=department_name name="department_name" aria-labelledby="name-label"></td>
						</tr>
			            <tr>
			                <th>연락처</th>
			                <td><input type="text" id="contact" name="contact"></td>
			                <th>긴급 연락처</th>
			                <td><input type="text" id="emergency-contact" name="emergency-contact"></td>
			            </tr>
			            <tr>
			                <th>팀장 이름</th>
			                <td><input type="text" id="teamLeader" name="teamLeader"></td>
			                <th>부서인원</th>
			                <td><input type="text" id="d_person" name="d_person"></td>
			            </tr>
			            <tr>
			                <th style="border-bottom:none;">부서생성일</th>
			                <td style="border-bottom:none;"><input type="date" id="created_at" name="created_at"></td>
			            </tr>
			        </table>
			        <table class="combined-info-table">
					    <tr>
					        <th>부서 설명</th>
					        <td colspan="3"><textarea id="d_notes" name="d_notes"></textarea></td>
					    </tr>
					</table>			
			        <!-- 저장/취소 버튼 -->
			        <div class="btnBox">
			            <button type="button" class="btn" onclick="djoincheck();">저장</button>
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