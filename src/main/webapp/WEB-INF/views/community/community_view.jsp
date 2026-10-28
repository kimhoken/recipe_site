<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><c:out value="${community.title}"/> · 커뮤니티</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community_view.css">

        <script>
            function modify(){
                location.href = "/community_modify?community_id=${community.community_id}"
            }

            function del( id ){

                if(!confirm('게시글을 삭제할까요?')) {
                    return;
                }

                const formdata = new FormData();
                formdata.append("community_id", id);

                fetch("/community/delete",{
                    method: 'post',
                    body: formdata
                })
                .then(res=> res.json())
                .then(data => {
                    if (data.result > 0){
                        alert("게시글이 삭제 되었습니다!");
                        location.href="list.do";
                    } else {
                        alert("삭제에 실패 하였습니다.");
                    }
                })
                .catch(()=>{
                    alert("삭제에 실패 하였습니다.");
                })
            }
        </script>

    </head>
    <body class="community-detail-body">
        <jsp:include page="/WEB-INF/views/common/navibar.jsp">
            <jsp:param name="currentMenu" value="community"/>
        </jsp:include>

        <c:set var="category" value="${community.community_type}"/>
        <c:choose>
            <c:when test="${category eq 'FREE'}"><c:set var="categoryLabel" value="자유"/></c:when>
            <c:when test="${category eq 'QUESTION'}"><c:set var="categoryLabel" value="질문"/></c:when>
            <c:when test="${category eq 'REVIEW'}"><c:set var="categoryLabel" value="후기"/></c:when>
            <c:when test="${category eq 'NOTICE'}"><c:set var="categoryLabel" value="공지"/></c:when>
            <c:otherwise><c:set var="categoryLabel" value="커뮤니티"/></c:otherwise>
        </c:choose>

        <main class="community-detail">
            <nav class="detail-breadcrumb" aria-label="현재 위치">
                <a href="${pageContext.request.contextPath}/list.do">커뮤니티</a>
                <span aria-hidden="true">/</span>
                <span><c:out value="${categoryLabel}"/></span>
            </nav>
            <article aria-labelledby="post-title">
                <div class="detail-heading">
                    <span class="detail-category"><c:out value="${categoryLabel}"/></span>
                    <h1 id="post-title"><c:out value="${community.title}"/></h1>
                </div>
                <div class="detail-meta">
                    <div class="detail-author">
                        <span>작성자 <c:out value="${community.member_id}"/></span>
                        <time><c:out value="${community.created_date}"/></time>
                    </div>
                    <span>조회 <c:out value="${community.view_count}"/></span>
                </div>

                <div class="detail-content">
                    <p class="detail-text"><c:out value="${community.content}"/></p>
                    <c:if test="${not empty img and not empty img.image_list}">
                        <div class="detail-images">
                            <c:forEach var="item" items="${fn:split(img.image_list, ',')}" varStatus="imageStatus">
                                <c:url var="imageUrl" value="/upload/community/${fn:trim(item)}"/>
                                <img src="${fn:escapeXml(imageUrl)}" alt="게시글 첨부 사진 ${imageStatus.count}" loading="lazy">
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <div class="detail-actions">
                    <a class="detail-button" href="${pageContext.request.contextPath}/list.do">목록</a>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.member_id eq community.member_id}">
                        <div class="detail-owner-actions">
                            <button class="detail-button" type="button" onclick="modify()">수정</button>
                            <button class="detail-button" type="button" onclick="del('${community.community_id}')">삭제</button>
                        </div>
                    </c:if>
                </div>
            </article>
        </main>
    </body>
</html>
