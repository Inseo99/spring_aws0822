<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet"> <!-- 동일한 스타일 적용 -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,}$/i;
            const submitButton = document.querySelector('.signup-btn');
            const form = document.forms['frm'];

            // 회원가입 버튼 클릭 시 폼 전송
            submitButton.addEventListener('click', () => {
                if (validateForm(form)) { // 유효성 검사 함수 호출
                    form.action = "${pageContext.request.contextPath}/member/adminJoinAction.aws";
                    form.method = "post";
                    form.submit(); // 폼 전송
                }
            });

            function validateForm(form) {
                if (!form.member_id.value) {
                    alert("아이디를 입력해주세요.");
                    form.member_id.focus();
                    return false;
                }
                if (!form.member_pwd.value || !form.member_pwd2.value) {
                    alert("비밀번호를 입력해주세요.");
                    form.member_pwd.focus();
                    return false;
                }
                if (form.member_pwd.value !== form.member_pwd2.value) {
                    alert("비밀번호가 일치하지 않습니다.");
                    form.member_pwd2.focus();
                    return false;
                }
                if (!form.name.value) {
                    alert("이름을 입력해주세요.");
                    form.name.focus();
                    return false;
                }
                if (!form.position.value) {
                    alert("직급을 입력해주세요.");
                    form.position.focus();
                    return false;
                }
                if (!form.email.value) {
                    alert("이메일을 입력해주세요.");
                    form.email.focus();
                    return false;
                }
                if (!emailRegex.test(form.email.value)) {
                    alert("이메일 형식이 올바르지 않습니다.");
                    form.email.value = "";
                    form.email.focus();
                    return false;
                }
                if (!form.contact.value) {
                    alert("연락처를 입력해주세요.");
                    form.contact.focus();
                    return false;
                }
                if (!form.birth.value) {
                    alert("생일을 입력해주세요.");
                    form.birth.focus();
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
                <input type="hidden" name="grade" value="admin">
                <div class="form-group">
                    <label for="member_id">아이디</label>
                    <input type="text" id="member_id" name="member_id" placeholder="아이디를 입력하세요">
                </div>
                <div class="form-group">
                    <label for="member_pwd">비밀번호</label>
                    <input type="password" id="member_pwd" name="member_pwd" placeholder="비밀번호를 입력하세요">
                </div>
                <div class="form-group">
                    <label for="member_pwd2">비밀번호 확인</label>
                    <input type="password" id="member_pwd2" name="member_pwd2" placeholder="비밀번호를 다시 입력하세요">
                </div>
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" placeholder="이름을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="position">직급</label>
                    <input type="text" id="position" name="position" placeholder="직급을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="contact">연락처</label>
                    <input type="tel" id="contact" name="contact" placeholder="연락처를 입력하세요">
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
