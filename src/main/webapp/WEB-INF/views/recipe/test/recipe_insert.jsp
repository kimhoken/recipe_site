<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>오늘 뭐 먹지? - 레시피 등록</title>
    <script>
        // 조리 순서 추가 버튼 기능
        function addCookOrder() {
            let cookOrder = document.getElementById("cookOrder");
            let orders = document.querySelectorAll(".order");
            let orderCount = document.getElementById("orderCount");

            if (!cookOrder || (orders.length >= 5)) {
                return;
            }

            let order = document.createElement("div");
            order.classList.add("order");

            let orderImage = document.createElement("div");
            let orderImageInput = document.createElement("input");
            orderImageInput.type = "file";
            orderImageInput.name = "orderImageList";
            orderImage.appendChild(orderImageInput);

            let orderDesc = document.createElement("div");
            let orderDescInput = document.createElement("input");
            orderDescInput.name = "orderDescList";
            orderDesc.appendChild(orderDescInput);

            order.appendChild(orderImage);
            order.appendChild(orderDesc);

            cookOrder.appendChild(order);

            orders = document.querySelectorAll(".order");
            orderCount.innerHTML = "조리순서 " + orders.length + "개";
        }
    </script>
</head>
<body>
    <form method="post" action="recipe_insert_pro.do" enctype="multipart/form-data">
        <table border="1">
            <tr>
                <th>제목</th>
                <td>
                    <input name="title"/>
                </td>
            </tr>
            <tr>
                <th>썸네일</th>
                <td>
                    <input type="file" name="thumbnailFile"/>
                </td>
            </tr>
            <tr>
                <th>조리시간</th>
                <td>
                    <select name="cooking_time">
                        <option>조리시간</option>
                        <option value="5">5분</option>
                        <option value="10">10분</option>
                        <option value="20">20분</option>
                        <option value="30">30분</option>
                        <option value="60">1시간 이상</option>
                    </select>
                </td>
            </tr>
        </table>

        <div class="cook-order" id="cookOrder">
            <h3 id="orderCount">조리순서 1개</h1>
            <div class="order">
                <div class="orderImage"><input type="file" name="orderImageList"/></div>
                <div class="orderDesc"><input name="orderDescList"/></div>
            </div>
        </div>

        <div class="add-cook-order" onclick="addCookOrder()">
            +
        </div>

        <table>
            <tr>
                <td><input type="submit" value="등록"/></td>
                <td><input type="button" value="취소" onclick="history.back()"/></td>
            </tr>
        </table>
    </form>

</body>
</html>