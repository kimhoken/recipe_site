<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>오늘 뭐 먹지? - 레시피 공유</title>
            
            <link rel="stylesheet" href="/css/main.css">          
            <script src="${pageContext.request.contextPath}/js/util.js"></script>
            <script>        
            </script>
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>

            <!-- 게시판 -->
            <div class="board-area" id="boardArea" style="display:none;">
                <c:if test="${not empty list}">
                    <table>
                        <thead>
                            <tr>
                                <th>게시글 번호</th>
                                <th>닉네임</th>
                                <th>제목</th>
                                <th>조회수</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="board" items="${list}">
                                <tr>
                                    <td>${board.board_id}</td>
                                    <td>${board.nickname}</td>
                                    <td>
                                        <a href="/view.do?board_id=${board.board_id}">
                                            ${board.title}
                                        </a>
                                    </td>
                                    <td>${board.view_count}</td>
                                    <td>${board.created_date}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty list}">
                    <h3 align="center">"${searchWord}"에 대한 검색 결과가 없습니다 :( </h3>
                </c:if>
                <%-- 로그인 한 경우만 버튼이 보이게 --%>
                    <c:if test="${!empty sessionScope.user}">
                        <div style="text-align:center; margin-top:20px;">
                            <input type="button" class="community-write-btn"
                                   value="나도 끄적끄적 ✍️" onclick="location.href='/community_form.do'"/>
                        </div>
                    </c:if>
                    <!-- 페이징 처리 -->
                    <div class="board-page-box">
                        <c:if test="${paging.prev}">
                            <a href="/list.do?page=${paging.startpage - 1}&btn=board">◀</a>
                        </c:if>

                        <c:forEach var="p" begin="${paging.startpage}" end="${paging.endpage}">
                            <a href="/list.do?page=${p}&btn=board"
                            class="${paging.page eq p ? 'active' : ''}">
                                ${p}
                            </a>
                        </c:forEach>

                        <c:if test="${paging.next}">
                            <a href="/list.do?page=${paging.endpage + 1}&btn=board">▶</a>
                        </c:if>

                    </div>
            </div>            
            
            </div>
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <!-- 챗봇 -->
            <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />

            <div id="imageModal" class="image-modal" onclick="closeImageModal()">
                <img id="imageModalImg" class="image-modal-img"/>
            </div>
        </body>
</html>
