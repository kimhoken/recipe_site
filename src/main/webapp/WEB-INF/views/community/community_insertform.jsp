<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/WEB-INF/views/common/is_login.jsp"/>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>커뮤니티 등록</title>

        <script>

        </script>
    </head>
    <body>
        <div class="com_insert_sector">
            <p>커뮤니티 글쓰기</p>
            <p>자유롭게 작성해 보세요</p>

            <form enctype="multipart/form-data" >
                <select>
                    <option value=""></option>
                    <c:if test="${user.role eq 'ADMIN'}">
                        <option value="NOTICE">공지</option>
                    </c:if>
                    <option value="FREE">자유</option>
                    <option value="QUESTION">질문</option>
                    <option value="REVIEW">후기</option>
                </select>
            </form>
        </div>
    </body>
</html>