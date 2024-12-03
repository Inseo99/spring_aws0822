<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String msg = (String) session.getAttribute("msg");
if (msg != null) {
    session.removeAttribute("msg");
    out.println("<script>alert('" + msg + "');</script>");
}
%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<script>
document.addEventListener("DOMContentLoaded", () => {
    const adminTab = document.getElementById('admin-tab');
    const employeeTab = document.getElementById('employee-tab');
    const gradeInput = document.getElementById('grade');
    const loginForm = document.frm; // <form name="frm">에 접근

    adminTab.addEventListener('click', () => {
        adminTab.classList.add('active');
        employeeTab.classList.remove('active');
        loginForm.grade.value = 'admin'; // role 값을 admin으로 설정
    });

    employeeTab.addEventListener('click', () => {
        employeeTab.classList.add('active');
        adminTab.classList.remove('active');
        loginForm.grade.value = 'employee'; // role 값을 employee로 설정
    });

    // 로그인 버튼 클릭 시 폼 전송
    const submitButton = document.querySelector('.login-btn');
    
    submitButton.addEventListener('click', () => {
        if (validateForm(loginForm)) { // 유효성 검사 함수 호출
        	loginForm.action = "${pageContext.request.contextPath}/member/memberLoginAction.aws";
            loginForm.method = "post";
            loginForm.submit(); // 폼 전송
        }
    });
        
    function validateForm(loginForm) {
        if (!loginForm.member_id.value) {
            alert("아이디를 입력해주세요.");
            loginForm.member_id.focus();
            return false;
        }
        if (!loginForm.member_pwd.value) {
            alert("비밀번호를 입력해주세요.");
            loginForm.member_pwd.focus();
            return false;
        }
        
        return true;
    }
});
</script>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>
<body>
    <div class="container">
       <div class="tab-container">
           <button class="tab-btn active" id="admin-tab">관리자</button> 
           <button class="tab-btn" id="employee-tab">직원</button>
       </div>
       <div class="login-box" id="loginBox" data-role="admin">
           <h2>로그인</h2>
           <form name="frm">
               <input type="hidden" id="grade" name="grade" value="admin">
               <div class="form-group">
                   <label for="member_id">아이디</label>
                   <input type="text" id="member_id" name="member_id">
               </div>
               <div class="form-group">
                   <label for="member_pwd">비밀번호</label>
                   <input type="password" id="member_pwd" name="member_pwd">
               </div>
               <button type="button" class="login-btn">로그인</button>
           </form>
           <a class="find-link" href = "${pageContext.request.contextPath}/member/adminJoin.aws">회원가입</a>
           <a class="find-link">아이디/비밀번호찾기</a>
       </div>
   </div>
</body>
</html>
