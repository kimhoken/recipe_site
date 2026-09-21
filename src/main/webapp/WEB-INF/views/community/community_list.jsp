<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/navibar.jsp"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>커뮤니티 페이지</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">


    </head>

    <body>
               
        <div class="com_main_sector">
            <p>커뮤니티</p>
            
            <div class="notice_box">
                <p>공지사항</p>
                <c:choose>
                    <c:when test="${ empty notice }">
                        <p> 등록된 공지가 없습니다.</p>
                    </c:when>
        
                    <c:otherwise>
                        <c:forEach var="notice" items="${notice}">
                            <p> ${notice.title} </p>
                            <p> ${notice.member_id} </p>
                            <span> ${notice.created_date} </span>                    
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="com_content_secter">
            <c:choose>
                <c:when test="${ empty community }">
                    <p> 등록된 커뮤니티가 없습니다.</p>
                </c:when>
    
                <c:otherwise>
                    <c:forEach var="community" items="${community}">
                        <p> ${community.title} </p>
                        <p> ${community.member_id} </p>
                        <p> ${community.created_date} </p>                    
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <c:if test="${!empty user}">
                <input type="button" value="글 등록하기" onclick="location.href='communityInsert'">
            </c:if>
        </div>

        

    </body>
</html>