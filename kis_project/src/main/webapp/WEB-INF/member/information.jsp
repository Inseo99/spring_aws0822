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
<title>개인 정보</title>
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

function modifycheck() {
    const fm = document.frm;
    const ans = confirm("정보를 수정하겠습니까?");
    
    if (ans) {
        fm.action = "${pageContext.request.contextPath}/member/informationAction.aws";
        fm.method = "post";
        fm.enctype="multipart/form-data";
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
	              <span id="name">${name}</span>
	              <a href="${pageContext.request.contextPath}/member/memberLogout.aws">로그아웃</a>
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
			    <h3 class="title-left">개인 정보</h3>
			    <form name="frm">
			    <input type="hidden" name="grade" value="${mv.grade }">
			    <input type="hidden" name="midx" value="${mv.midx }">
			        <!-- 직원 정보 섹션 -->
			        <table class="info-table">
			           <tr>
						    <td class="photo-cell" rowspan="4">
						        <div class="photo-box">
						            <c:if test="${!empty mv.photo}"> 
						            <div class="photo-preview">
						            <img src="${pageContext.request.contextPath}/member/displayFile.aws?fileName=${mv.photo}">
						            </div>
						            </c:if>
						        </div>
						    </td>
						    <th>직원번호</th>
						    <td><input type="text" id="employee_id" name="employee_id" value="${mv.employee_id}"  aria-labelledby="employee_id-label" readonly></td>
						    <th>이름</th>
						    <td><input type="text" id="name" name="name" value="${mv.name}" aria-labelledby="name-label"></td>
						</tr>
			            <tr>
			                <th>연락처</th>
			                <td><input type="text" id="contact" name="contact" value="${mv.contact}"></td>
			                <th>긴급 연락처</th>
			                <td><input type="text" id="emergency_contact" name="emergency_contact" value="${mv.emergency_contact}"></td>
			            </tr>
			            <tr>
			                <th>부서</th>
			                <td><input type="text" id="department_name" name="department_name" value="${mv.department_name}" readonly></td>
			                <th>직급</th>
			                <td><input type="text" id="position" name="position" value="${mv.position}" readonly></td> 
			            </tr>
			            <tr>
			                <th>입사일</th>
			                <td><input type="date" id="join_date" name="join_date" value="${mv.join_date}" readonly></td>
			                <th>퇴사일</th>
			                <td><input type="date" id="leave_date" name="leave_date" value="${mv.leave_date}" readonly></td>
			            </tr>
			        </table>
			        <table class="combined-info-table">
					    <tr>
					        <th style="border-top: none;">근무 상태</th>
					        <td colspan="3" class="status-options">
					            <input type="radio" name="work_status" value="재직" disabled
						            <c:if test="${mv.work_status == '재직'}">checked</c:if>> 재직
						        <input type="radio" name="work_status" value="휴직" disabled
						            <c:if test="${mv.work_status == '휴직'}">checked</c:if>> 휴직
						        <input type="radio" name="work_status" value="퇴직" disabled
						            <c:if test="${mv.work_status == '퇴직'}">checked</c:if>> 퇴직
					        </td>
					    </tr>
					    <tr>
					        <th>한자명</th>
					        <td><input type="text" id="h_name" name="h_name" value="${mv.h_name}"></td>
					        <th>영문명</th>
					        <td><input type="text" id="e_name" name="e_name" value="${mv.e_name}"></td>
					    </tr>
					    <tr>
					        <th>이메일</th>
					        <td><input type="email" id="email" name="email" value="${mv.email}"></td>
					        <th>생년월일</th>
					        <td><input type="date" id="birth" name="birth" value="${mv.birth}"></td>
					    </tr>
					    <tr>
					        <th>주소</th>
					        <td colspan="3"><input type="text" id="address" name="address" value="${mv.address}"></td>
					    </tr>
					    <tr>
					        <th>특이사항</th>
					        <td colspan="3"><textarea id="notes" name="notes">${mv.notes}</textarea></td>
					    </tr>
					    <tr>
					        <th>남은 연차</th>
					        <td><input type="number" id="remaining_leave" name="remaining_leave" min="0" value="${mv.remaining_leave}" onblur="setDefault(this)" readonly></td>
					    </tr>
					</table>			
			        <!-- 저장/취소 버튼 -->
			        <div class="btnBox">
			            <button type="button" class="btn" onclick = "modifycheck();">저장</button>
			            <a class="btn aBtn" href="${pageContext.request.contextPath}/board/dashboard.aws">취소</a>
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
