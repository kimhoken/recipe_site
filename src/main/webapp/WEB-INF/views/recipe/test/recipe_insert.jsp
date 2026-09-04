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

            if (!cookOrder || orders.length >= 5) {
                return;
            }

            let order = document.createElement("div");
            order.classList.add("order");

            order.innerHTML = `
                <div class="orderStep">\${orders.length + 1}</div>
                <div class="orderImage">
                    <label style="cursor: pointer;">
                        <input type="file" name="orderImageList" accept="image/*" onchange="previewFile(this)" style="display: none;"/>
                        <div class="image-box">
                            <img class="preview-img"/>
                            <div class="preview-overlay">+</div>
                        </div>
                    </label>
                </div>
                <div class="orderDesc">
                    <input name="orderDescList"/>
                </div>
            `;

            // let orderImage = document.createElement("div");
            // let orderImageInput = document.createElement("input");
            // orderImageInput.type = "file";
            // orderImageInput.name = "orderImageList";
            // orderImageInput.accept = "image/*";
            // orderImageInput.onchange = function() { previewFile(this); };
            // let br = document.createElement("br");
            // let previewImg = document.createElement("img");
            // previewImg.classList.add("preview-img");
            // previewImg.style = "display:none; width: 100px;";
            // orderImage.appendChild(orderImageInput);
            // orderImage.appendChild(br);
            // orderImage.appendChild(previewImg);

            // let orderDesc = document.createElement("div");
            // let orderDescInput = document.createElement("input");
            // orderDescInput.name = "orderDescList";
            // orderDesc.appendChild(orderDescInput);

            // order.appendChild(orderImage);
            // order.appendChild(orderDesc);

            cookOrder.appendChild(order);

            orders = document.querySelectorAll(".order");
        }

        function previewFile(input) {
            let file = input.files[0];
            let img = input.parentElement.querySelector(".preview-img");
            let overlay = input.parentElement.querySelector(".preview-overlay");

            if (file) {
                img.src = URL.createObjectURL(file);
                img.style.display = "block";
                overlay.style.display = "none";
                
                // 조리순서 파일 태그들 중 방금 선택한 게 '마지막 칸'이면 +버튼 실행
                let orderImageList = document.querySelectorAll("input[name='orderImageList']");
                if (input === orderImageList[orderImageList.length - 1]) {
                    addCookOrder();
                }
            }
        }

        function addRecipe() {
            let title = document.getElementById("title");
            let thumbnailFile = document.getElementById("thumbnailFile");
            let cooking_time = document.getElementById("cooking_time");

            if (!title.value.trim()) {
                alert("레시피 제목을 입력해주세요.");
                title.focus();
                return false;
            }

            if (thumbnailFile.files.length === 0) {
                alert("썸네일 이미지를 등록해주세요.");
                return false;
            }

            if (!cooking_time.value) {
                alert("조리시간을 선택해주세요.");
                cooking_time.focus();
                return false;
            }

            let orderImageList = document.querySelectorAll("input[name='orderImageList']");
            let hasOrderImage = Array.from(orderImageList).some(orderImage => orderImage.files.length > 0);
            if (!hasOrderImage) {
                alert("조리 순서를 등록해주세요.");
                return false;
            }

            return true;
        }
    </script>

    <style>
        .thumbImage .image-box {
            position: relative;
            height: 100px;
            width: 100px;
        }
        
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

        .order .orderImage .image-box {
            position: relative;
            height: 200px;
            width: 200px;
        }

        .thumbImage .image-box .preview-img,
        .order .orderImage .image-box .preview-img {
            height: 100%;
            width: 100%;
            object-fit: cover;
        }
        
        .thumbImage .image-box .preview-overlay,
        .order .orderImage .image-box .preview-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            
            background-color: rgba(0, 0, 0, 0.1); 

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 32px;
            color: gray;

            pointer-events: none; 
        }

        .order .orderDesc input {
            width: 100%;
            box-sizing: border-box;
        }
    </style>

</head>
<body>
    <form method="post" action="recipe_insert_pro.do" enctype="multipart/form-data" onsubmit="return addRecipe()">
        <h1>레시피 등록</h1>
        <table border="1">
            <tr>
                <th>제목</th>
                <td>
                    <input id="title" name="title"/>
                </td>
            </tr>
            <tr>
                <th>썸네일</th>
                <td>
                    <div class="thumbImage">
                        <label style="cursor: pointer;">
                            <input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*" onchange="previewFile(this)" style="display: none;"/>
                            <div class="image-box">
                                <img class="preview-img"/>
                                <div class="preview-overlay">+</div>
                            </div>
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <th>조리시간</th>
                <td>
                    <select id="cooking_time" name="cooking_time">
                        <option value="">조리시간</option>
                        <option value="5">5분</option>
                        <option value="10">10분</option>
                        <option value="20">20분</option>
                        <option value="30">30분</option>
                        <option value="60">1시간 이상</option>
                    </select>
                </td>
            </tr>
        </table>

        <div class="cook-order-container">
            <h3>조리순서</h3>
            <div class="cook-order" id="cookOrder">
                <div class="order">
                    <div class="orderStep">1</div>
                    <div class="orderImage">
                        <label style="cursor: pointer;">
                            <input type="file" name="orderImageList" accept="image/*" onchange="previewFile(this)" style="display: none;"/>
                            <div class="image-box">
                                <img class="preview-img"/>
                                <div class="preview-overlay">+</div>
                            </div>
                        </label>
                    </div>
                    <div class="orderDesc">
                        <input name="orderDescList"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- <div class="add-cook-order" onclick="addCookOrder()">
            +
        </div> -->

        <table>
            <tr>
                <td><input type="submit" value="등록"/></td>
                <td><input type="button" value="취소" onclick="history.back()"/></td>
            </tr>
        </table>
    </form>

</body>
</html>