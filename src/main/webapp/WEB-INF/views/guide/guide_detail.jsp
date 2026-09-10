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

            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide/guide.css">

            <style>
                /* 배경 흰색 고정 */

                body {

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


                <!-- 수정 / 삭제 메뉴 -->
                <div class="guide-menu-wrap">

                    <button type="button" class="guide-menu-btn" onclick="toggleGuideMenu()">
                        ☰
                    </button>

                    <div class="guide-menu" id="guideMenu">

                        <a href="${pageContext.request.contextPath}/guide_update.do?guide_id=${guide.guide_id}">
                            수정
                        </a>

                        <form action="${pageContext.request.contextPath}/guide_delete.do" method="post"
                            onsubmit="return confirm('정말 삭제하시겠습니까?');">

                            <input type="hidden" name="guide_id" value="${guide.guide_id}">

                            <button type="submit">
                                삭제
                            </button>

                        </form>

                        <a href="${pageContext.request.contextPath}/report/form.do?guide_id=${guide.guide_id}"> 
                            신고 
                        </a>

                    </div>

                </div>

                <br />
                <hr class="detail-line">
                <br />
                <br />

                <div class="step-container">

                    <c:forEach var="step" items="${stepList}">

                        <div class="step-item">

                            <div class="step-text-box">

                                <span class="step-number">Step ${step.step_num}</span>

                                <p class="step-content">${step.step_content}</p>

                            </div>


                            <c:if test="${not empty step.step_image}">

                                <div class="step-img-box">

                                    <img src="${pageContext.request.contextPath}/guide_img/${step.step_image}"
                                        alt="단계별 이미지">

                                </div>

                            </c:if>

                        </div>

                    </c:forEach>

                </div>

                &nbsp;

            </div>


            <jsp:include page="/WEB-INF/views/common/footer.jsp" />


            <script>

                function toggleGuideMenu() {

                    const menu = document.getElementById("guideMenu");

                    menu.classList.toggle("show");

                }


                document.addEventListener("click", function (event) {

                    const menuWrap = document.querySelector(".guide-menu-wrap");

                    if (menuWrap && !menuWrap.contains(event.target)) {

                        document.getElementById("guideMenu").classList.remove("show");

                    }

                });

            </script>

        </body>

    </html>