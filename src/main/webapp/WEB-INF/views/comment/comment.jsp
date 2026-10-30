<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
    [댓글 공통 화면 사용 방법]

    1. 상세 페이지에서 포함하기 (한 페이지에 한 번만 포함)

       <jsp:include page="/WEB-INF/views/comment/comment.jsp">
           <jsp:param name="targetType" value="COMMUNITY"/>
       </jsp:include>

       레시피에서는 targetType을 RECIPE로 전달한다.
       RECIPE일 때만 별점 입력과 등록된 별점을 표시한다.

    2. 상세 조회 컨트롤러에서 준비할 데이터

       target_id   : 현재 글 번호 (community_id 또는 recipe_id)
       target_type : COMMUNITY 또는 RECIPE (댓글 조회와 등록에 같은 값 사용)
       page        : 요청 페이지, 기본값 1

       count = commentDAO.commentCount(target_id, target_type)
       paging = new Paging(page, 5, count)

       조회용 Map에 target_id, target_type, size, offset을 담는다.
       size와 offset은 paging.getSize(), paging.getOffset()을 사용한다.
       list = commentDAO.getListPaging(map)

       Model 이름은 아래와 동일하게 전달해야 한다.
       - list   : 현재 페이지 댓글 목록 (List<CommentVO>)
       - count  : ACTIVE 댓글 전체 개수
       - paging : 댓글 Paging 객체

       부모 화면의 다른 목록에 list/paging을 쓰는 경우 이름 충돌에 주의한다.
       로그인 회원 정보는 sessionScope.user를 사용하며,
       작성자 ID는 서버에서 로그인 세션 값으로 설정한다.

    3. 레시피 연결 전에 반드시 바꿀 부분 (현재는 커뮤니티 기준)

       - 등록 폼의 target_id가 community.community_id로 고정되어 있다.
         레시피에서는 recipe.recipe_id를 넘기도록 대상 ID를 공통화해야 한다.
         targetType만 RECIPE로 바꾸는 것으로는 등록 대상 ID가 연결되지 않는다.

       - 하단 pageUrl은 /community_view?community_id=... 로 고정되어 있다.
         레시피에서는 /recipe_detail.do?recipe_id=... 로 연결해야 한다.
         common/paging.jsp가 page 파라미터를 붙이므로 기본 URL에 page는 넣지 않는다.

       - 제목의 comment-count가 비어 있으므로 전체 개수는 count로 출력한다.

    4. 등록 / 수정 / 삭제

       등록: POST /comment/insert, FormData -> CommentVO
             target_id, target_type, content, rating(레시피일 때)
       수정: POST /comment/update, FormData -> CommentVO
             comment_id, content (평점 수정은 현재 구현되어 있지 않음)
       삭제: POST /comment/delete, 폼 인코딩으로 comment_id 전달
             실제 행 삭제가 아니라 status를 DELETE로 변경

       성공 후 새로고침하여 컨트롤러에서 댓글을 다시 조회한다.
       등록은 form의 submit 이벤트로 버튼 클릭과 Enter를 함께 처리한다.
--%>

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

<%-- 댓글 작성 폼과 현재 페이지 댓글 목록 --%>
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
