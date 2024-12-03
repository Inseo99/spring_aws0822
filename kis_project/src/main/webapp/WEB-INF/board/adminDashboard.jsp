<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
              <a href="../login.jsp">로그아웃</a>
          </div>
      </div>

        <!-- 대시보드 콘텐츠 -->
        <div class="dashboard-content">
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
                        <li><a href="./departmentList.html">부서 목록</a></li>
                        <li><a href="./employeeList.html">직원 목록</a></li>
                        <li><a href="./employeeRegister.html">직원 등록</a></li>
                    </ul>
                </li>
                <li class="menu-item"><a href="../public/noticeList.html">공지사항</a></li>
                <li class="menu-item"><a href="../public/communityList.html">커뮤니티</a></li>
            </ul>
            </nav>
            <!-- 메인 콘텐츠 -->
            <main class="main">
                <!-- 직원 정보 -->
                <section class="profile">
                    <div class="photo"></div>
                    <div class="details">
                        <p><strong>이름:</strong> 홍길동</p>
                        <p><strong>부서:</strong> 개발팀</p>
                        <p><strong>직급:</strong> 사원</p>
                        <p><strong>이메일:</strong> hong@company.com</p>
                        <p><strong>전화번호:</strong> 010-1234-5678</p>
                    </div>
                </section>

                <!-- 위젯 -->
                <section class="widgets">
                    <div class="widget">
                        <h3>알림</h3>
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
                  </table>
                        <button>더보기</button>
                    </div>
                    <div class="widget">
                        <h3>커뮤니티</h3>
                        <table class="listTable">
                     <tr>
                        <td>No</td>
                        <td>제목</td>
                        <td>날짜</td>
                     </tr>
                  </table>
                        <button>더보기</button>
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
                              <div class="calendar-day empty"></div>
                              <div class="calendar-day">1</div>
                              <div class="calendar-day">2</div>
                              <div class="calendar-day today">3</div> <!-- 오늘 -->
                              <div class="calendar-day">4</div>
                          </div>
                      </div>
                  </div>
                        <button>더보기</button>
                    </div>
                    <div class="widget">
                        <h3>공지사항</h3>
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
                  </table>
                        <button>더보기</button>
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