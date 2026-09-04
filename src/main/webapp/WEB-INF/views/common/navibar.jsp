<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css">
        <script>
            window.onload = () => {
                const sort = '${sort}';
                let select = document.getElementById("sort");
                let arr = ["latest", "name", "view", "like" ];

                for(let i=0 ; i<arr.length ; i++){
                    if(arr[i] == sort){
                        select.options[i].selected = true;
                    }
                }
            }
            // 삭제보류__1
            const logout = ()=>{
                if(confirm("로그아웃 하시겠습니까?")){
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
                            location.reload();
                        }
                    })
                }
            }
            // 삭제보류__1
           
            
            
        </script>
    </head>
    <body>
        <header>
            <div class="header-top">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고"/>
                    </a>
                </div>
                

                <div class="user-menu">
                    <%-- 로그인/로그아웃으로 session에 값에 따라 변경 --%>
                    <c:if test="${empty sessionScope.user}">
                        <a href="/login.do" class="menu-item" id="login">
                            <span class="menu-icon">
                                <img src="${pageContext.request.contextPath}/images/login.png">
                            </span>
                            <div>로그인</div>
                        </a>
                    </c:if>
                    <c:if test="${!empty sessionScope.user}">
                        <a href="#" class="menu-item" id="login" onClick="logout(); return false;" >
                            <span class="menu-icon">
                                <img src="${pageContext.request.contextPath}/images/login.png">
                            </span>
                            <div>로그아웃</div>
                        </a>
                    </c:if>
                    <%-- ------------------------------------------ --%>
                    <c:if test="${empty sessionScope.user}">
                        <a href="/register_form.do" class="menu-item">
                            <span class="menu-icon">
                                <img src="${pageContext.request.contextPath}/images/login.png">
                            </span>
                            <div>회원가입</div>
                        </a>
                    </c:if>
                    <c:if test="${!empty sessionScope.user}">
                        <c:choose>
                            <c:when test="${user.role eq 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin" class="menu-item">
                                    <span class="menu-icon">
                                        <img src="${pageContext.request.contextPath}/images/mypage.png">
                                    </span>
                                    <div>마이페이지</div>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/mypage.do" class="menu-item">
                                    <span class="menu-icon">
                                        <img src="${pageContext.request.contextPath}/images/mypage.png">
                                    </span>
                                    <div>마이페이지</div>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
            </div>

            <ul class="nav-bar">
                <li class="${param.currentMenu eq 'home' ? 'active' : ''}"><a href="/">홈</a></li>
                <li class="${param.currentMenu eq 'recipe' ? 'active' : ''}"><a href="/recipe_list.do"> 레시피</a></li>
                <li class="${param.currentMenu eq 'community' ? 'active' : ''}"><a href="/list.do">커뮤니티</a></li>
                <li class="${param.currentMenu eq 'fridge' ? 'active' : ''}"><a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a></li>
                <li class="${param.currentMenu eq 'guide' ? 'active' : ''}"><a href="/guide_list.do">키친가이드</a></li>
            </ul>
        </header>
    </body>
</html>