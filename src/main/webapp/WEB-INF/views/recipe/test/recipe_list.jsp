<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>오늘 뭐 먹지? - 레시피 목록</title>
</head>
<body>
    <input type="button" value="메인으로" onclick="location.href='/'"/>
    <input type="button" value="레시피 추가" onclick="location.href='recipe_insert.do'"/>
    <table border="1">
        <thead>
            <tr>
                <th>레시피ID</th>
                <th>제목</hr>
                <th>썸네일</th>
                <th>조리시간</th>
                <th>조회수</th>
                <th>좋아요수</th>
                <th>작성자ID</th>
                <th>상태</th>
                <th>작성일</th>
                <th>수정일</th>
                <th>추천수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="recipe" items="${recipeList}">
                <tr>
                    <td>${recipe.recipe_id}</td>
                    <td><a href="recipe_detail.do?recipe_id=${recipe.recipe_id}">${recipe.title}</a></td>
                    <td>
                        <img src="/upload/${recipe.thumbnail}" width="100px"/>
                    </td>
                    <td>${recipe.cooking_time}</td>
                    <td>${recipe.view_count}</td>
                    <td>${recipe.like_count}</td>
                    <td>${recipe.member_id}</td>
                    <td>${recipe.status}</td>
                    <td>${recipe.created_date}</td>
                    <td>${recipe.updated_date}</td>
                    <td>${recipe.recommend}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
