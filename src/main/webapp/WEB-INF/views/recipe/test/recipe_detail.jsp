<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>오늘 뭐 먹지? - 레시피 상세 정보</title>
</head>

<style>
    .cook-order {
        display: flex;
        flex-wrap: wrap;
        gap: 16px;
    }

    .order {
        border: 1px solid lightgray;
        overflow: hidden;
    }

    .order .orderStep {
        text-align: center;
        font-weight: 700;
    }

    .order .orderImage {
        position: relative;
        height: 200px;
        width: 200px;
    }

    .order .orderImage .preview-img {
        height: 100%;
        width: 100%;
        object-fit: cover;
    }

    .order .orderDesc input {
        width: 100%;
        box-sizing: border-box;
        border: none;
        outline: none;
    }
</style>

<body>
    <h1>레시피 상세 정보</h1>
    <table border="1">
        <tr>
            <th>제목</th>
            <td>${recipe.title}</td>
        </tr>
        <tr>
            <th>썸네일</th>
            <td><img src="/upload/${recipe.thumbnail}" width="100px"/></td>
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

    <div class="cook-order-container">
        <h3>조리순서</h1>
        <div class="cook-order" id="cookOrder">
        <c:forEach var="order" items="${cookOrder}" varStatus="status">
            <div class="order">
                <div class="orderStep">${status.count}</div>
                <div class="orderImage">
                    <label>
                        <img class="preview-img" src="/upload/${order.cook_image}"/>
                    </label>
                </div>
                <div class="orderDesc">
                    <input name="orderDescList" value="${order.description}" readonly/>
                </div>
            </div>
        </c:forEach>
        </div>
    </div>

    <input type="button" value="수정" onclick="location.href='/recipe_update.do?recipe_id=${recipe.recipe_id}'"/>
    <input type="button" value="삭제" onclick="location.href='/recipe_delete.do?recipe_id=${recipe.recipe_id}'"/>
    <input type="button" value="목록으로" onclick="location.href='/recipe_list.do'"/>
</body>
</html>
