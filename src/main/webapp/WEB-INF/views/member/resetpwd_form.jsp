<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <jsp:include page="/WEB-INF/views/common/navibar.jsp" />
        <!DOCTYPE html>
        <html>

        <head>
            <link rel="stylesheet" href="/css/main.css" />
            <link rel="stylesheet" href="/css/resetpwdpage.css" />

            <script>
                let pwd_valid = false;

                function send(f) {

                    if (!pwd_valid) {
                        alert("비밀번호 입력하세요!!");
                        return;
                    }

                    let pwd = f.pwd.value;
                    let pwd_check = f.pwd_check.value;

                    fetch("/repwd.do", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: 'password=' + encodeURIComponent(pwd) + '&member_id=' + '${member.member_id}' + '&token_id=' + '${token.token_id}'
                    })
                        .then(res => res.text())
                        .then(data => {

                            if (data.trim() == "success") {

                                alert("비밀번호가 재설정되었습니다.");
                                location.href = "/login.do";

                            } else {

                                alert("비밀번호 재설정에 실패했습니다. 다시 시도해주세요.");

                            }
                        })

                }

                //비밀번호 유효성 검사
                function pwdchange() {

                    let pwd = document.getElementById("pwd").value;
                    let pwd_check = document.getElementById("pwd_check").value;
                    let pwd_msg = document.getElementById("pwd_msg");
                    let pwd_check_msg = document.getElementById("pwd_check_msg");

                    fetch("/pwd_check.do",
                        {
                            method: 'post',
                            headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                            body: 'pwd=' + encodeURIComponent(pwd) +
                                '&pwd_check=' + encodeURIComponent(pwd_check)
                        })
                        .then(res => res.json())
                        .then(data => {

                            if (data.pwd_msg == "no") {

                                pwd_msg.innerHTML = '영문 특수문자 포함 10자 이상 포함되야 합니다.';

                            } else if (data.pwd_msg == "yes") {

                                pwd_msg.innerHTML = '사용가능합니다.';
                                document.getElementById("pwd_check").focus();

                            } else {
                                pwd_msg.innerHTML = "오류 발생";
                            }

                            if (data.pwd_check_msg == "no") {

                                pwd_check_msg.innerHTML = '일치하지 않습니다.';

                            } else if (data.pwd_check_msg == "yes") {

                                pwd_check_msg.innerHTML = '일치합니다.';
                                pwd_valid = true;

                            } else {
                                pwd_check_msg.innerHTML = "오류 발생";
                            }


                        })

                }

            </script>

        </head>

        <body>
            <div class="contnet-wrap">

                <c:if test="${not empty msg}">

                    <div class="token-box">
                        <div class="token-icon">🔒</div>

                        <h2>${msg}</h2>
                        <p>비밀번호 재설정 시간이 지나<br>다시 요청이 필요합니다.</p>

                        <input type="button" value="메인으로 이동" class="token-btn" onclick="location.href='/main_list.do'">
                    </div>

                </c:if>
                <c:if test="${empty msg}">

                    <form class="find-form">


                        <h2 class="find-title">비밀번호 재설정</h2>
                        <div class="find-row">
                            <span class="find-label">비밀번호</span>
                            <div class="find-control">
                                <input type="password" class="find-input" id="pwd" name="pwd" placeholder="비밀번호 입력하세요"
                                    oninput="pwdchange()" />
                                <div class="find-msg" id="pwd_msg">영문 특수문자 10글자 이상</div>
                            </div>
                        </div>



                        <div class="find-row">
                            <span class="find-label">비밀번호 확인</span>
                            <div class="find-control">
                                <input type="password" id="pwd_check" name="pwd_check" placeholder="비밀번호 확인 입력하세요"
                                    oninput="pwdchange()" />
                                <div class="find-msg" id="pwd_check_msg"></div>
                            </div>
                        </div>


                        <input type="button" class="find-main-btn" value="비밀번호 재설정" onclick="send(this.form)" />

                    </form>

                </c:if>
            </div>
        </body>

        </html>