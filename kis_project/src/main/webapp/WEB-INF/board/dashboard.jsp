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

MemberVo mv = (MemberVo)session.getAttribute("mv");
%>
<c:if test="${empty mv}">
    <script>
        alert('세션이 만료되었습니다. 로그인 페이지로 이동합니다.');
        window.location.href = '${pageContext.request.contextPath}/index.jsp';
    </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
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
    <div class="dashboard">
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
            <!-- 메인 콘텐츠 -->
            <main class="main">
                <!-- 직원 정보 -->
                <section class="profile">
                    <div class="photo">
                	<c:if test="${!empty mv.photo}">
                    <img src="${pageContext.request.contextPath}/member/displayFile.aws?fileName=${mv.photo}">
                    </c:if>
                    </div>
                    <div class="details">
                        <p><strong>이 름 : </strong> ${mv.name}</p>
                        <p><strong>부 서 : </strong> ${mv.department_name}</p>
                        <p><strong>직 급 : </strong> ${mv.position}</p>
                        <p><strong>이 메 일 : </strong> ${mv.email}</p>
                        <p><strong>연 락 처 : </strong> ${mv.contact}</p>
                        <a class="more-button" href="${pageContext.request.contextPath}/member/information.aws?midx=${mv.midx}">더보기</a>
                    </div>
                </section>

                <!-- 위젯 -->
                <section class="widgets">
                    <div class="widget">
                        <h3>업무 보고</h3>
                        <table class="listTable">
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                  </table>
                        <a class="more-button" href="${pageContext.request.contextPath}/board/weekWorkList.aws">더보기</a>
                    </div>
                    <div class="widget">
                        <h3>커뮤니티</h3>
                        <table class="listTable">
		                     <tr>
		                        <td>No</td>
		                        <td>제목</td>
		                        <td>날짜</td>
		                     </tr>
		                     <c:forEach items = "${clist}" var = "bv" varStatus="status"> 
		                     <tr>
		                        <td>${bv.bidx }</td>
		                        <td class="title"><a href="${pageContext.request.contextPath}/board/communityContents.aws?bidx=${bv.bidx}">${bv.subject }</a></td>
		                        <td>${bv.writeday.substring(0,10) }</td>
		                     </tr>
		                     </c:forEach>
		                  </table>
                        <a class="more-button" href="${pageContext.request.contextPath}/board/communityList.aws">더보기</a>
                    </div>
                    <div class="widget">
                        <h3>일정관리</h3>
                        <!-- 달력 위젯 -->
		                  <div class="widget widget-calendar">
		                      <div class="calendar">
		                          <div class="calendar-header">
		                              <div>일</div>
		                              <div>월</div>
		                              <div>화</div>
		                              <div>수</div>
		                              <div>목</div>
		                              <div>금</div>
		                              <div>토</div>
		                          </div>
		                          <div class="calendar-days">
		                              <!-- 날짜 예시 -->
		                              <div class="calendar-day">1</div>
		                              <div class="calendar-day">2</div>
		                              <div class="calendar-day">3</div> <!-- 오늘 -->
		                              <div class="calendar-day">4</div>
		                              <div class="calendar-day">5</div>
		                              <div class="calendar-day">6</div>
		                              <div class="calendar-day">7</div>
		                              <div class="calendar-day">8</div>
		                              <div class="calendar-day">9</div>
		                              <div class="calendar-day">10</div>
		                              <div class="calendar-day">11</div>
		                              <div class="calendar-day today">12</div>
		                              <div class="calendar-day">13</div>
		                              <div class="calendar-day">14</div>
		                              <div class="calendar-day">15</div>
		                              <div class="calendar-day">16</div>
		                              <div class="calendar-day">17</div>
		                              <div class="calendar-day">18</div>
		                              <div class="calendar-day">19</div>
		                              <div class="calendar-day">20</div>
		                              <div class="calendar-day">21</div>
		                              <div class="calendar-day">22</div>
		                              <div class="calendar-day">23</div>
		                              <div class="calendar-day">24</div>
		                              <div class="calendar-day">25</div>
		                              <div class="calendar-day">26</div>
		                              <div class="calendar-day">27</div>
		                              <div class="calendar-day">28</div>
		                              <div class="calendar-day">29</div>
		                              <div class="calendar-day">30</div>
		                              <div class="calendar-day">31</div>
		                              <div class="calendar-day empty"></div>
		                              <div class="calendar-day empty"></div>
		                              <div class="calendar-day empty"></div>
		                              <div class="calendar-day empty"></div>
		                              
		                          </div>
		                      </div>
		                  </div>
	                        <a class="more-button" href="${pageContext.request.contextPath}/board/calendar.aws">더보기</a>
                    </div>
                    <div class="widget">
                        <h3>공지사항</h3>
                        <table class="listTable">
                     <tr>
                        <td>No</td>
                        <td>제목</td>
                        <td>날짜</td>
                     </tr>
                     <c:forEach items = "${nlist}" var = "bv" varStatus="status"> 
                     <tr>
                        <td>${bv.bidx }</td>
                        <td class="title"><a href="${pageContext.request.contextPath}/board/noticeContents.aws?bidx=${bv.bidx}">${bv.subject }</a></td>
                        <td>${bv.writeday.substring(0,10) }</td>
                     </tr>
                     </c:forEach>
                  </table>
                        <a class="more-button" href="${pageContext.request.contextPath}/board/noticeList.aws">더보기</a>
                    </div>
                </section>
            </main>
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
