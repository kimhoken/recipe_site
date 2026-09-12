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
        
        <p>커뮤니티 페이지 입니다.</p>

        <p>게시글 조회 목록 출력</p>

        
        <div class="com_main_sector">
            <p>커뮤니티</p>
            
            <div class="notice_box">
                <p>공지사항</p>
                <p>목록 출력될 예정</p>
            </div>
        </div>
        <c:choose>
            <c:when test="${ empty list }">
                <p> 등록된 커뮤니티가 없습니다.</p>
            </c:when>

            <c:otherwise>
                <c:forEach var="community" items="${list}">
                    <p> ${community.title} </p>
                    <p> ${community.member_id} </p>
                    <p> ${community.created_date} </p>                    
                </c:forEach>
            </c:otherwise>
        </c:choose>



    </body>
</html>