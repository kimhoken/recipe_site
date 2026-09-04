//로그아웃에 사용하는 함수
//html안에 넣어서 사용!!
const logout = () => {
    if (confirm("로그아웃 하시겠습니까?")) {
        fetch("/logout.do", {
            method: "post",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                id: "${user.member_id}"
            })
        })
            .then(res => res.json())
            .then(data => {
                if (data.result == "success") {
                    alert("로그아웃 되었습니다.")
                    location.href = "/main_list.do";
                }
            })
    }
}