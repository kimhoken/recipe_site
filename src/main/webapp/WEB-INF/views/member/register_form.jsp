<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/login/register_from.css"/>
        
        
        <script>
            const nickname = '${nickname}';
            const name = '${socialUser.name}';
            const email = '${socialUser.email}';
            const provider = '${socialUser.provider}';            

        </script>
        <script src="/js/register.js"></script>
    </head>

    <body>        
       <form class = "join-form">   
            <c:if test="${not empty socialUser}">
                <input type="hidden" value="${socialUser.provider}" name="provider"/>
                <input type="hidden" value="${socialUser.provider_id}" name="provider_id"/>
                <input type="hidden" value="${socialUser.login_type}" name="login_type"/>
                <input type="hidden" value="${socialUser.filename}" name="filename"/>
            </c:if> 
            <div class="join-wrap">

                <!-- 왼쪽 이미지 영역 -->
                <div class="join-left">
                    
                        <div class="join-icon">
                            <img src="/images/lid_bowl.png">
                        </div>
                        
                        <p class="join-font">
                            오늘의 한 끼,<br>
                            <span>맛있게 시작하세요!</span>
                        </p>
    
                        <div class="join-line"></div>
    
                        <p>
                            다양한 레시피와 함께<br>
                            더 맛있는 하루를 만들어보세요.
                        </p>
                    

                    <div class="join-bottom">
                        <img src="/images/fork.png"/>   
                        <img src="/images/cooking-pot2.png"/>                     
                        <img src="/images/bowl.png"/>
                    </div>
                </div>

                <!-- 오른쪽 회원가입 영역 -->
                <div class="join-right">
                    <h2 class="join-title">회원가입</h2>
                    <table class="join-table">
                        <tr>
                            <th>이름</th>
                            <td>
                                <input name="name" id="name" class="input-box" placeholder="이름입력하세요 Ex) 홍길동"/>
                                <div class="msg-space"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>닉네임</th>
                            <td>
                                <input name="nickname" id="nickname" onchange="nick()" class="input-box"/>
                                <div id="nick_msg" class="msg-space"></div>
                            </td>
                        </tr>
                        <c:if test="${ empty socialUser }">
                            <tr>
                                <th>아이디</th>
                                <td>
                                    <input name="login_id" id="id" 
                                           placeholder="아이디 입력하세요" onchange="status(); id_check()"
                                           class="input-box"/>
                                    <div id="id_msg" class="msg-space"></div>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td>
                                    
                                    <div class="pwd-warp">
                                        <input name="password" type="password" id="pwd" 
                                        placeholder="비밀번호 입력하세요" onchange="pwd_checks()"
                                        class="input-box"/>
    
                                        <button type="button" id="visual" class="toggle" onclick="viewpwd()">
                                                <img src="/images/visibility.png"/>
                                            </button>
    
                                        <button type="button" id="unvisual" class="toggle" onclick="viewpwd()">
                                                <img src="/images/unvisibility.png"/>
                                            </button>
                                    </div>

                                    <div id="pwd_msg" class="msg-space"></div>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호 확인</th>
                                <td>
                                    <input id="pwd_check" type="password" 
                                    placeholder="비밀번호 입력하세요" onchange="pwd_checks()"
                                    class="input-box"/>
                                    <div id="pwd_check_msg" class="msg-space"></div>
                                </td>
                            </tr>
                        </c:if>
        
                        <tr>
                            <th>이메일</th>
                                <form class="email-form">
                                    <td>
                                        <div class="email-row">
                                            <input name="email" id="email" class="input-box email-input" placeholder="이메일 입력하세요 Ex) example@sample.com"/>
                                            <input type="button" id="soical_button" value="본인인증" class="sub-btn" onclick="mailcheck(this.form)"/>
                                        </div>
                                        <div class="msg-space"></div>
                                        <div id="soical_row" class="email-row">

                                            <input id="authnumber" type="number" placeholder="인증번호 6자리" maxlength="6" class="input-box email-input"/>
                                            <input type="button" value="인증번호 확인" class="sub-btn" onclick="change_input()"/>
                                        </div>
                                        <div id="email_msg" class="msg-space"></div>
                                    </td>
                                </form>
                        </tr>
                        
                        <tr>
                            <td colspan="2" class="btn-area">
                                <input type="button" value="회원 가입" class="join-btn" onclick="send(this.form)" />
                                <input type="button" value="취소" class="cancel-btn" onclick="history.back()" />
                            </td>
                        </tr>
        
                    </table>
                </div>

            </div> 
        </form>
       
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        
       
    </body>

</html>
