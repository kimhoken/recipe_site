<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.user}">
    <script>
        alert("로그인후 이용해주세요.")
        location.href="/login.do";
    </script>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘 뭐 먹지? - 재료 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fridge_form.css">
    <script src="/js/chatbot.js"></script>
    <script>
        // 추가한 재료들을 모아둘 빈 배열
        let ingredientList = [];

        // 1. 목록에 추가하는 함수
        const addToList = (f) => {
            const ingredient_name = f.ingredient_name.value;
            const quantity = f.quantity.value;
            const expire_date = f.expire_date.value;
            let freezer = f.freezer.value;
            
            // 유효성 검사
            if(!ingredient_name.trim()){
                alert("재료이름은 필수입력사항입니다."); 
                return; 
            }

            if(!quantity.trim()){ 
                alert("수량을 입력해주세요"); 
                return; 
            }
            
            if(expire_date == ''){ 
                alert("유통기한을 입력해주세요."); 
                return; 
            }
            
            // 객체 만들어서 배열에 쏙 넣기
            const data = {
                member_id: f.id.value,
                ingredient_name: ingredient_name,
                quantity: quantity,
                expire_date: expire_date,
                freezer: freezer == 'true' ? true : false
            };
            
            ingredientList.push(data);
            
            // 오른쪽 목록 UI 업데이트
            updateListUI();
            
            // 다음 입력을 위해 폼 비우기 (작성 편의성)
            f.ingredient_name.value = '';
            f.quantity.value = '';
            f.expire_date.value = '';
            f.ingredient_name.focus();
        }

        // 2. 화면에 추가된 목록을 그려주는 함수
        const updateListUI = () => {
            const listContainer = document.getElementById('added-list');
            listContainer.innerHTML = ''; // 일단 비우고 다시 그리기

            ingredientList.forEach((item, index) => {
                const li = document.createElement('li');
                const place = item.freezer ? "냉동" : "냉장";
                li.innerHTML = `
                    <div class="item-info">
                        <strong>` + item.ingredient_name +`</strong> (` + item.quantity + `) - ` + item.expire_date + `까지 [` + place + `]
                    </div>
                    <button type="button" class="btn-remove" onclick="removeItem(` + index + `)">삭제</button>`;
                listContainer.appendChild(li);
            });
        }

        // 3. 목록에서 빼고 싶을 때 쓰는 함수
        const removeItem = (index) => {
            ingredientList.splice(index, 1); // 배열에서 해당 인덱스 삭제
            updateListUI(); // 화면 다시 그리기
        }

        // 4. 마지막에 한 번에 서버로 전송하는 함수
        const submitAll = () => {
            if(ingredientList.length === 0){
                alert("등록할 재료를 먼저 목록에 추가해주세요!");
                return;
            }
            //여기 부분부터 백엔드에서 리스트로 받아서 처리하게 변경
            const url = "/food_insert.do";

            fetch(url, {
                method: "post",
                headers: { "Content-Type": "application/json" },
                // 배열을 통째로 JSON으로 바꿔서 전송 (List 파라미터로 감)
                body: JSON.stringify(ingredientList)
            })
            .then(res => res.json())
            .then(data => {
                if(data.res == "success"){
                    alert("등록 성공");
                    location.href="/fridge_list.do?member_id=${user.member_id}";
                } else {
                    alert("등록 실패");
                }
            })
            .catch(err => {
                alert("서버 통신 에러... 서버를 확인해주세요");
                console.log(err);
            });
        }

        //로그아웃에 사용하는 함수
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
    </script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navibar.jsp">
        <jsp:param name="currentMenu" value="fridge" />
    </jsp:include>

    <div class="container main-container">
        <div class="form-card-container">
            <h2 class="form-card-title">새로운 재료 입력</h2>
            <form>
                <input type="hidden" value="${user.member_id}" name="id">
                <div class="form-input-group">
                    <label for="ingredient_name">재료 이름</label>
                    <input type="text" id="ingredient_name" name="ingredient_name" placeholder="식재료 이름을 입력하세요 (예: 우유)">
                </div>
                <div class="form-input-group">
                    <label for="quantity">재료 수량</label>
                    <input type="text" id="quantity" name="quantity" placeholder="갯수나 용량을 입력하세요 (예: 2개, 500g)">
                </div>
                <div class="form-input-group">
                    <label for="expire_date">유통기한</label>
                    <input type="date" id="expire_date" name="expire_date">
                </div>
                <div class="form-input-group">
                    <label for="freezer">보관 장소(실외보관은 냉장으로 이용해주세요!!!)</label>
                    <select id="freezer" name="freezer">
                        <option value="false">냉장실</option>
                        <option value="true">냉동실</option>
                    </select>
                </div>
                <div class="form-button-group">
                    <input type="button" class="btn-submit" value=" 목록에 추가" onClick="addToList(this.form)">
                </div>
            </form>
        </div>

        <div class="list-card-container">
            <h2 class="form-card-title">등록 대기 목록</h2>
            
            <ul id="added-list" class="added-list-area">

            </ul>
            
            <div class="form-button-group">
                <input type="button" class="btn-submit final-submit" value="한 번에 등록하기" onClick="submitAll()">
                <input type="button" class="btn-cancel" value="취소" onClick="history.back()">
            </div>
        </div>

    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>