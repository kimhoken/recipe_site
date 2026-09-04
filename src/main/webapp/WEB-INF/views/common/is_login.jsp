<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${empty sessionScope.user}">
    <script>
        console.log('${user.member_id}')
        alert("로그인후 이용해주세요.")
        location.href="/login.do";
    </script>
</c:if>

