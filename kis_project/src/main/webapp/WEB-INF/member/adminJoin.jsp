<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<title>회원가입</title>
<link href="/resources/css/login.css" type="text/css" rel="stylesheet"> <!-- 동일한 스타일 적용 -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const submitButton = document.querySelector('.signup-btn');
        const form = document.frm;

        // 회원가입 버튼 클릭 시 폼 전송
        submitButton.addEventListener('click', () => {
            if (validateForm(form)) { // 유효성 검사 함수 호출
                form.action = "/signupAction"; // 처리할 URL로 설정
                form.method = "post";
                form.submit(); // 폼 전송
            }
        });

        function validateForm(form) {
            // 기본적인 유효성 검사 (추가 가능)
            if (!form.userid.value) {
                alert("아이디를 입력해주세요.");
                form.userid.focus();
                return false;
            }
            if (!form.userpassword.value || !form.userpassword2.value) {
                alert("비밀번호를 입력해주세요.");
                form.userpassword.focus();
                return false;
            }
            if (form.userpassword.value !== form.userpassword2.value) {
                alert("비밀번호가 일치하지 않습니다.");
                form.userpassword2.focus();
                return false;
            }
            if (!form.username.value) {
                alert("이름을 입력해주세요.");
                form.username.focus();
                return false;
            }
            if (!form.email.value) {
                alert("이메일을 입력해주세요.");
                form.email.focus();
                return false;
            }
            return true;
        }
    });
</script>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>회원가입</h2>
            <form name="frm">
                <div class="form-group">
                    <label for="userid">아이디</label>
                    <input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="userpassword">비밀번호</label>
                    <input type="password" id="userpassword" name="userpassword" placeholder="비밀번호를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="userpassword2">비밀번호 확인</label>
                    <input type="password" id="userpassword2" name="userpassword2" placeholder="비밀번호를 다시 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="username">이름</label>
                    <input type="text" id="username" name="username" placeholder="이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="position">직급</label>
                    <input type="text" id="position" name="position" placeholder="직급을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="phone">연락처</label>
                    <input type="tel" id="phone" name="phone" placeholder="연락처를 입력하세요">
                </div>
                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="date" id="birth" name="birth">
                </div>
                <button type="button" class="signup-btn">회원가입</button>
            </form>
        </div>
    </div>
</body>
</html>
