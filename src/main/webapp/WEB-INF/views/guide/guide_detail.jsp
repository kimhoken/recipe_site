<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/navibar.jsp">
    <jsp:param name="currentMenu" value="guide" />
</jsp:include>

        <!DOCTYPE html>
        <html>

        <head>
            <title>키친가이드 상세페이지</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide.css">
            <link rel="stylesheet" href="/css/chatbot.css" />
            <script src="/js/chatbot.js"></script>
            <style>
                /* 배경 흰색 고정 */
                body{
                    background-color: #ffffff !important;
                }
               
            </style>
        </head>

        <body>
            
            <div class="detail-container">

                    <div class="detail-img-box">
                        <img src="${pageContext.request.contextPath}/guide_img/${guide.image}" alt="상세/가이드이미지">
                    </div>

                <div class="detail-info">
                    <div class="detail-subtitle">${guide.sub_title}</div>
                        <h2 class="detail-title">${guide.title}</h2>   
                </div>
                <br/>
                <hr class="detail-line">
                <br/>
                <br/>
                <div class="step-container">
                    <c:forEach var="step" items="${stepList}">
                        <div class="step-item">
                            
                            <div class="step-text-box">
                                <span class="step-number">Step ${step.step_num}</span>
                                <p class="step-content">${step.step_content}</p>
                            </div>


                            <c:if test="${not empty step.step_image}">
                                <div class="step-img-box">
                                    <img src="${pageContext.request.contextPath}/guide_img/${step.step_image}" alt="단계별 이미지">
                                </div>
                            </c:if>
                            
                        </div>
                    </c:forEach>
                </div>
                &nbsp;



            </div>



            <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />
        </body>

        </html>