<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/comment.css">
<script>
    function insert(f){
        const content = f.content.value;

        if( content === '' ) {
            alert("댓글 내용 입력하세요!!");
            return;            
        }
        let formdata = new FormData(f);
        fetch("/comment/insert", {
            method:'post',
            body:formdata
        })
        .then(res => res.json())
        .then( data => {
            if( data.result === 'loginRequired' ) {
                alert("로그인이 필요합니다.");                
            } else if( data.result === 'success') {
                alert("댓글 작성 성공");
                location.reload();
            } else {
                alert("댓글 작성 실패했습니다.");               
            }
        })

    }

    function comModify(id) {
        document.getElementById('comment-content-' + id).hidden = true;
        document.getElementById('comment-edit-btn-' + id).hidden = true;

        const form = document.getElementById('comment-edit-' + id);

        form.hidden = false;
        form.elements.content.focus();
    }

    function cancelCommentEdit(id) {
        const form = document.getElementById('comment-edit-' + id);

        form.reset();
        form.hidden = true;

        document.getElementById('comment-content-' + id).hidden = false;
        document.getElementById('comment-edit-btn-' + id).hidden = false;
    }

    function saveComment(form) {
        const content = form.elements.content.value.trim();

        if (!content) {
            alert('댓글 내용을 입력하세요.');
            return;
        }
        const button = form.querySelector('[data-save]');
        button.disabled = true;

        const formdata = new FormData(form);
        formdata.set('content', content);

        fetch('${pageContext.request.contextPath}/comment/update', {
            method: 'POST',
            body: formdata
        })
        .then(response => {

            if (!response.ok) {
                throw new Error('수정 요청 실패');
            }

            return response.json();
        })
        .then(data => {
            if (data.result === 'success') {
                location.reload();
            } else if (data.result === 'loginRequired') {
                alert('로그인이 필요합니다.');
            } else {
                alert('댓글 수정에 실패했습니다.');
            }
        })
        .catch(error => {
            alert('댓글 수정 중 오류가 발생했습니다.');
        })
        .finally(() => {
            button.disabled = false;
        });
    }

    function comDel( id ){
        if(!confirm("댓글 삭제 하시겠습니까?")){
            return;
        }

        fetch("/comment/delete", {
            method:'post',
            headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'},
            body:'comment_id=' + id
        })
        .then(res => res.json())
        .then(data => {
            if( data.result > 0 ){
                alert("댓글 삭제 완료 되었습니다!");
                location.reload();
            } else {
                alert("댓글 삭제 실패 하였습니다");
            }
        });        

    }

</script>

<%-- 화면 확인용 예시. 데이터 연결과 버튼 기능은 추후 구현 --%>
<section class="comment-section" aria-label="댓글">
    <h2 class="comment-title">댓글 <span class="comment-count"></span></h2>

    <div class="comment-write">
        <form onsubmit="event.preventDefault(); insert(this)">
            <input type="hidden" name="member_id" value="${user.member_id}"/>
            <input type="hidden" name="target_id" value="${community.community_id}"/>
            <input type="hidden" name="target_type" value="${param.targetType}"/>

            <c:if test="${param.targetType eq 'RECIPE'}">
                <jsp:include page="/WEB-INF/views/common/rating.jsp"/>
            </c:if>
            
            <input class="comment-input" type="text" name="content"
            placeholder="댓글을 입력해주세요." aria-label="댓글 입력"/>
            
            <button class="comment-register" type="submit">등록</button>
            
        </form>
    </div>

    <ul class="comment-list">
        <c:if test="${ not empty list }">

            <c:forEach var="item" items="${list}">

                <li class="comment-item">
                    <div class="comment-header">
                        <strong class="comment-author">${item.nickname}</strong>
                        <c:if test="${param.targetType eq 'RECIPE'}">
                            <span class="comment-rating">
                                <c:forEach begin="1" end="5" var="star">
                                    <span>${star le item.rating ? '★' : '☆'}</span>
                                </c:forEach> 
                            </span>
                             ${item.rating}                            
                        </c:if>
                        <time class="comment-date" datetime="2026-10-28T19:05">${item.created_date}</time>
                        
                        <c:if test="${not empty sessionScope.user and sessionScope.user.member_id eq item.member_id}">
                            <button class="comment-reply"
                                    type="button"
                                    id="comment-edit-btn-${item.comment_id}"
                                    onclick="comModify(${item.comment_id})">
                                수정
                            </button>

                            <button class="comment-reply" 
                                    type="button" 
                                    onclick="comDel(${item.comment_id})">
                                삭제
                            </button>
                        </c:if>
                    </div>

                    <p class="comment-content" id="comment-content-${item.comment_id}">
                        <c:out value="${item.content}"/>
                    </p>

                    <c:if test="${not empty sessionScope.user and sessionScope.user.member_id eq item.member_id}">
                        
                    <form id="comment-edit-${item.comment_id}"
                              hidden
                              onsubmit="event.preventDefault(); saveComment(this);">

                            <input type="hidden"
                                   name="comment_id"
                                   value="${item.comment_id}"/>

                            <textarea class="comment-input"
                                      name="content"
                                      aria-label="댓글 수정"
                                      required><c:out value="${item.content}"/></textarea>

                            <button class="comment-register" type="submit" data-save>
                                저장
                            </button>

                            <button class="comment-reply"
                                    type="button"
                                    onclick="cancelCommentEdit(${item.comment_id})">
                                취소
                            </button>
                        </form>
                    </c:if>
                </li>

            </c:forEach>

        </c:if>
        
        
    </ul>

    <c:if test="${count gt 0 }">
        <c:set var="pageUrl"
               value="/community_view?community_id=${community.community_id}"
               scope="request"/>
        <jsp:include page="/WEB-INF/views/common/paging.jsp"/>       
    </c:if>
</section>
