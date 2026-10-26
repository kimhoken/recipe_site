<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community_list.css">
<script src="${pageContext.request.contextPath}/js/community_list.js" defer></script>
</head>
<body class="community-body">
<jsp:include page="/WEB-INF/views/common/navibar.jsp"><jsp:param name="currentMenu" value="community"/></jsp:include>
<main class="community-page">
<section class="community-intro">
<h1>커뮤니티</h1>
<p class="community-lead">좋은 맛은, 좋은 이야기에서 시작돼요.</p>
<p>요리, 식재료, 일상의 식탁까지. 함께 이야기하는 공간입니다.</p>
</section>
<section class="community-notices" aria-label="공지사항">
<div class="community-notice-label"><h2>공지사항</h2><p>꼭 확인해주세요!</p></div>
<div class="community-notice-list">
<c:forEach var="item" items="${notice}">
<article class="community-notice-row"><h3><c:out value="${item.title}"/></h3><time><c:out value="${item.created_date}"/></time></article>
</c:forEach>
<c:if test="${empty notice}"><p class="community-notice-empty">등록된 공지사항이 없습니다.</p></c:if>
</div>
<button class="community-notice-toggle" type="button" aria-expanded="false">전체보기</button>
</section>
<div class="community-toolbar">
<div class="community-filters" role="group" aria-label="게시글 분류">
<button type="button" class="is-active" data-category="ALL" aria-pressed="true">전체</button>
<button type="button" data-category="FREE" aria-pressed="false">자유</button>
<button type="button" data-category="QUESTION" aria-pressed="false">질문</button>
<button type="button" data-category="REVIEW" aria-pressed="false">후기</button>
</div>
<div class="community-actions">
<input type="search" id="community-search" aria-label="게시글 제목 검색" placeholder="게시글 검색">
<c:if test="${not empty user}"><a class="community-write" href="${pageContext.request.contextPath}/communityInsert">글쓰기</a></c:if>
</div>
</div>
<section class="community-posts" aria-label="게시글 목록">
<c:forEach var="post" items="${community}">
<article class="community-post" data-category="<c:out value='${post.community_type}'/>">
<span class="community-post-category"><c:choose><c:when test="${post.community_type eq 'FREE'}">자유</c:when><c:when test="${post.community_type eq 'QUESTION'}">질문</c:when><c:when test="${post.community_type eq 'REVIEW'}">후기</c:when><c:otherwise>일반</c:otherwise></c:choose></span>
<h2 class="community-post-title"><c:out value="${post.title}"/></h2>
<div class="community-post-meta"><span>작성자 <c:out value="${post.member_id}"/></span><time><c:out value="${post.created_date}"/></time><span>조회 <c:out value="${post.view_count}"/></span></div>
</article>
</c:forEach>
<p class="community-empty" id="community-empty" hidden>조건에 맞는 게시글이 없습니다.</p>
</section>
<nav class="community-pagination" aria-label="게시글 페이지"></nav>
<p class="community-sr-only" id="community-result" aria-live="polite"></p>
</main>
</body>
</html>
