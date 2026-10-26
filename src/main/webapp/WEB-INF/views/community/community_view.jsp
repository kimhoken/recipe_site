<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>
        <h2>${community.title}</h2>

        <p>
            ${community.content}
        </p>

        <p>이미지</p>

        <div>
            <input type="button" value="수정" onclick="modify()"/>
            <input type="button" value="삭제" onclick="del()"/>
        </div>
    </div>

</body>
</html>