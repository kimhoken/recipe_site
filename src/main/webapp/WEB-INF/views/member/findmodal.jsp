<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    let email_authnumer;
    let email_valid = false;
    let id_valid = false;

    function status(val) {
        if (val == "id") {
            id_valid = false;
        } else if (val == "email") {
            email_valid = false;
        }
    }

    function mailcheck(f) {
        let email = f.email.value;
        let authNumber = document.getElementById("authNumber");

        fetch("/mail_check.do", {
            method: "post",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "email=" + encodeURIComponent(email)
        })
            .then(res => res.json())
            .then(data => {
                alert("인증번호가 발송되었습니다.");
                authNumber.style.display = "block";
                email_authnumer = data.authNumber;
            })
    }

    function change_input() {
        let authnumber = document.getElementById("authnumber").value;
        let email_msg = document.getElementById("id_email_msg");

        if (authnumber == email_authnumer) {
            email_msg.innerHTML = "인증되었습니다.";
            email_valid = true;
        } else if (authnumber != email_authnumer) {
            email_msg.innerHTML = "인증번호가 틀렸습니다.";
        } else {
            email_msg.innerHTML = "오류발생";
        }
    }

    function findid(f) {
        if (!email_valid) {
            alert("이메일 인증을 진행하세요!");
            return;
        }

        let formdata = new FormData(f);

        fetch("/findid.do", {
            method: "post",
            body: formdata
        })
            .then(res => res.text())
            .then(data => {
                alert("아이디는 " + data);
            })
    }

    function check() {
        let email = document.getElementById("id_email").value;
        let email_msg = document.getElementById("msg");
        let email_send = document.getElementById("email_send");

        if (email == "") {
            email_msg.innerHTML = "이메일을 입력하세요.";
            email_send.style.visibility = "hidden";
            return;
        }

        fetch("/emailfind.do", {
            method: "post",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "email=" + encodeURIComponent(email)
        })
            .then(res => res.json())
            .then(data => {
                if (data.result == "no") {
                    email_msg.innerHTML = data.email + "은 등록되지 않은 이메일입니다.";
                    email_send.style.visibility = "hidden";
                } else {
                    email_msg.innerHTML = "";
                    email_send.style.visibility = "visible";
                }
            })
    }

    function check_id() {
        let id = document.getElementById("find_login_id").value;
        let id_msg = document.getElementById("id_msg");

        if (id == "") {
            id_msg.innerHTML = "아이디를 입력하세요!";
            return;
        }

        fetch("/check_id.do", {
            method: "post",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "login_id=" + encodeURIComponent(id)
        })
            .then(res => res.json())
            .then(data => {
                if (data.id_msg == "no") {
                    id_msg.innerHTML = "";
                    id_valid = true;
                } else {
                    id_msg.innerHTML = "등록되지 않은 아이디입니다.";
                }
            })
    }

    function resetpwd(f) {
        let email = f.email.value;
        let login_id = f.login_id.value;

        if (!id_valid) {
            alert("아이디를 입력하세요!");
            return;
        }

        if (email == "") {
            alert("이메일을 입력하세요!");
            return;
        }

        fetch("/resetpwd.do", {
            method: "post",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "email=" + encodeURIComponent(email) + "&login_id=" + encodeURIComponent(login_id)
        })
            .then(res => res.json())
            .then(data => {
                if (data.result == "success") {
                    alert("이메일로 전송했습니다!");
                    location.href = "login.do";
                } else {
                    alert("이메일주소가 잘못되었습니다.");
                }
            })
    }

    function openModal(val, btn) {
        document.getElementById("findModal").style.display = "block";
        document.getElementById("id_find").style.display = "none";
        document.getElementById("pwd_find").style.display = "none";

        if (val == "id") {
            document.getElementById("id_find").style.display = "block";
        } else {
            document.getElementById("pwd_find").style.display = "block";
        }
    }

    function closeModal() {
        document.getElementById("findModal").style.display = "none";
    }
</script>

<div id="findModal" class="modal-wrap">
    <div id="modal-box">
        <input type="button" class="modal-class" value="X" onclick="closeModal()" />

        <div id="id_find">
            <form class="find-form">
                <img src="/images/identity-card.png" class="find-img" />

                <h3 class="find-title">아이디 찾기</h3>

                <div class="row">
                    <div class="find-row">
                        <span class="find-label">이메일</span>

                        <div class="find-control">
                            <input name="email" id="id_email" class="find-input" oninput="status('email'); check()">
                            <input id="email_send" class="find-sub-btn" type="button" value="인증번호 전송"
                                onclick="mailcheck(this.form)" style="visibility: hidden;" />
                        </div>

                        <div id="msg">Ex) sample@naver.com</div>
                    </div>

                    <div id="authNumber" class="find-row" style="display: none;">
                        <span class="find-label">인증번호</span>

                        <div class="find-control">
                            <input id="authnumber" class="find-input" type="number" placeholder="인증번호 6자리"
                                maxlength="6" />
                            <input type="button" class="find-check-btn" value="인증번호 확인"
                                onclick="change_input()" />
                        </div>

                        <div class="find-msg" id="id_email_msg"></div>
                    </div>
                </div>

                <input id="find_id_btn" class="find-main-btn" type="button" onclick="findid(this.form)"
                    value="아이디 찾기" />
            </form>
        </div>

        <div id="pwd_find">
            <form class="find-form">
                <img src="/images/padlock.png" class="find-img" />

                <h3 class="find-title">비밀번호 찾기</h3>

                <div class="row">
                    <div class="find-row">
                        <span class="find-label">아이디</span>

                        <div class="find-control">
                            <input class="find-input" name="login_id" id="find_login_id"
                                oninput="status('id'); check_id()" placeholder="아이디 입력하세요" />
                        </div>

                        <div class="find-msg" id="id_msg"></div>
                    </div>

                    <div class="find-row">
                        <span class="find-label">이메일</span>

                        <div class="find-control">
                            <input class="find-input" placeholder="이메일 입력" name="email" id="pwd_email" />
                        </div>

                        <div class="find-msg" id="pwd_email_msg"></div>
                    </div>
                </div>

                <input id="find_pwd_btn" class="find-main-btn" type="button" value="비밀번호 찾기"
                    onclick="resetpwd(this.form)" />
            </form>
        </div>
    </div>
</div>
