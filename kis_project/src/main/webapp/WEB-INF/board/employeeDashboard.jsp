<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 대시보드</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
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
    <div class="dashboard">
        <!-- 상단바 -->
        <div class="header">
          <div class="logo">koreacompany</div>
          <div class="user-info">
              <span id="current-date"></span>
              <span id="current-time"></span>
              <span id="username">사용자 이름</span>
              <a href="#">로그 아웃</a>
          </div>
      </div>

        <!-- 대시보드 콘텐츠 -->
        <div class="dashboard-content">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
                <li class="menu-item"><a href="${pageContext.request.contextPath}/board/employeeDashboard.aws">홈</a></li>
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
                        <p>내용 요약...</p>
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
                        <button>더보기</button>
                    </div>
                </section>
            </main>
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