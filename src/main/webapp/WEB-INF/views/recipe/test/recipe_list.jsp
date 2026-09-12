<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>오늘 뭐 먹지? - 레시피 목록</title>
    <style>
        .pagination {
            display: flex;
            gap: 5px;
        }
        .pagination a,
        .pagination .current,
        .pagination .disabled {
            display: flex;
            justify-content: center;
            width: 25px;
        }
        .pagination a {
            text-decoration: none;
            color: black;
        }
        .pagination .current {
            color: black;
            font-weight: 600;
        }
        .pagination .disabled {
            color: gray;
        }
    </style>
</head>
<body>
    <h1>레시피 목록</h1>

    <input type="button" value="메인으로" onclick="location.href='/'"/>
    <input type="button" value="레시피 등록" onclick="location.href='recipe_insert.do'"/>

    <div class="pagination">
        <c:choose>
            <c:when test="${paging.prev}">
                <a href="/recipe_list.do?page=${paging.startpage - 1}">&lt;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&lt;</span>
            </c:otherwise>
        </c:choose>
        <c:forEach var="page" begin="${paging.startpage}" end="${paging.endpage}" step="1">
            <c:choose>
                <c:when test="${page eq paging.page}">
                    <span class="current">${page}</span>
                </c:when>

                <c:otherwise>
                    <a href="/recipe_list.do?page=${page}">${page}</a>
                </c:otherwise>
            </c:choose>

        </c:forEach>
        <c:choose>
            <c:when test="${paging.next}">
                <a href="/recipe_list.do?page=${paging.endpage + 1}">&gt;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&gt;</span>
            </c:otherwise>
        </c:choose>
    </div>
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
