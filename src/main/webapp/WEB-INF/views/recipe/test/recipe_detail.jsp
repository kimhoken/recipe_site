<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>오늘 뭐 먹지? - 레시피 상세 정보</title>
</head>
<body>
    <table border="1">
        <tr>
            <th>제목</th>
            <td>${recipe.title}</td>
        </tr>
        <tr>
            <th>썸네일</th>
            <td><img src="/upload/${recipe.thumbnail}"/></td>
        </tr>
        <tr>
            <th>조리시간</th>
            <td>${recipe.cooking_time}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td>${recipe.view_count}</td>
        </tr>
        <tr>
            <th>좋아요수</th>
            <td>${recipe.like_count}</td>
        </tr>
        <tr>
            <th>작성자ID</th>
            <td>${recipe.member_id}</td>
        </tr>
        <tr>
            <th>상태</th>
            <td>${recipe.status}</td>
        </tr>
        <tr>
            <th>작성일</th>
            <td>${recipe.created_date}</td>
        </tr>
        <tr>
            <th>수정일</th>
            <td>${recipe.updated_date}</td>
        </tr>
        <tr>
            <th>추천수</th>
            <td>${recipe.recommend}</td>
        </tr>
    </table>

    <table border="1">
        <c:forEach var="order" items="${cookOrder}">
            <tr>
                <td><img src="/upload/${order.cook_image}"/></td>
                <td>${order.description}</td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
