<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <script>
            function setRating(event){

                const stars = [...event.currentTarget.children];
                const score = stars.indexOf(event.target) + 1;
                if(!score) return;

                const rating = event.currentTarget.parentElement;
                stars.forEach((star, i) => star.textContent = i < score ? '★' : '☆');
                rating.querySelector('output').textContent = score + '점';
                rating.querySelector('input').value = score;

            }
        </script>

    </head>

    <body>

        <div>
            평점
            <span onclick="setRating(event)">
                <button type="button">☆</button>
                <button type="button">☆</button>
                <button type="button">☆</button>
                <button type="button">☆</button>
                <button type="button">☆</button>
            </span>

            <output>0점</output>
            <input type="hidden" name="rating" value="0"/>
        
        </div>



    </body>
</html>