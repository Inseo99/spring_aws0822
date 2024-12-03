<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet"> <!-- 동일한 스타일 적용 -->
<script>
const email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,}$/i;

function check() {
    const fm = document.frm;

    if (fm.member_id.value === "") {
        alert("아이디를 입력해주세요.");
        fm.member_id.focus();
        return;
    }
    if (!$("#btn").data("idChecked")) {
        alert("아이디 중복 체크를 해주세요.");
        fm.member_id.focus();
        return;
    }
    if (fm.member_pwd.value === "" || fm.member_pwd2.value === "") {
        alert("비밀번호를 입력해주세요.");
        fm.member_pwd.focus();
        return;
    }
    if (fm.member_pwd.value !== fm.member_pwd2.value) {
        alert("비밀번호가 일치하지 않습니다.");
        fm.member_pwd2.focus();
        return;
    }
    if (fm.name.value === "") {
        alert("이름을 입력해주세요.");
        fm.name.focus();
        return;
    }
    if (fm.position.value === "") {
        alert("직급을 입력해주세요.");
        fm.position.focus();
        return;
    }
    if (fm.email.value === "") {
        alert("이메일을 입력해주세요.");
        fm.email.focus();
        return;
    }
    if (!email.test(fm.email.value)) {
        alert("이메일 형식이 올바르지 않습니다.");
        fm.email.focus();
        return;
    }
    if (fm.contact.value === "") {
        alert("연락처를 입력해주세요.");
        fm.contact.focus();
        return;
    }
    if (fm.birth.value === "") {
        alert("생일을 입력해주세요.");
        fm.birth.focus();
        return;
    }

    const ans = confirm("회원가입 하겠습니까?");
    if (ans) {
        fm.action = "${pageContext.request.contextPath}/member/adminJoinAction.aws";
        fm.method = "post";
        fm.submit();
    }
}

$(document).ready(function () {
    $("#btn").click(function () {
        const member_id = $("#member_id").val();
        if (member_id === "") {
            alert("아이디를 입력해주세요.");
            return;
        }

        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/member/memberIdCheck.aws",
            dataType: "json",
            data: { member_id: member_id },
            success: function (result) {
            	console.log("AJAX 요청 성공:", result);
                if (result.cnt === 0) {
                    alert("사용할 수 있는 아이디입니다.");
                    $("#btn").data("idChecked", true);
                } else {
                    alert("사용할 수 없는 아이디입니다.");
                    $("#btn").data("idChecked", false);
                }
            },
            error: function () {
                alert("아이디 중복 확인 중 오류가 발생했습니다.");
                $("#member_id").val("");
            },
        });
    });
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
                    <button type="button" id="btn">중복 확인</button>
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
                <button type="button" class="signup-btn" onclick="check();">회원가입</button>
            </form>
        </div>
    </div>
</body>
</html>
