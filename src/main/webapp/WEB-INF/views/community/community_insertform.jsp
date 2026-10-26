<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/WEB-INF/views/common/is_login.jsp"/>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>커뮤니티 등록</title>

        <script>
            
            // 커뮤니티 작성 함수
            function commuity_send(f){
                f.submit();
            }

            //게시글 미리보기 함수
            function preview(){
                document.getElementById('preview_title').textContent=
                 document.getElementById('title').value;

                document.getElementById('preview_content').textContent= 
                 document.getElementById('content').value;

                document.getElementById('preview_model').hidden=false; 
            }


        </script>
    </head>
    <body>
        <div class="com_insert_sector">
            <p>커뮤니티 글쓰기</p>
            <p>자유롭게 작성해 보세요</p>

            <form method="post" action="/community_insert" enctype="multipart/form-data" >
                <input type="hidden" name="member_id" value="${user.member_id}">

                <select name="community_type">
                    <option value=""></option>
                    <c:if test="${user.role eq 'ADMIN'}">
                        <option value="NOTICE">공지</option>
                    </c:if>
                    <option value="FREE">자유</option>
                    <option value="QUESTION">질문</option>
                    <option value="REVIEW">후기</option>
                </select>

                <div>
                    <input id="title" name="title" placeholder="제목을 입력하세요"/>
                </div>
 
                <div>
                    <textarea id="content" name="content"></textarea>
                </div>

                <div>
                    <input type="file" name="photo" multiple/>
                </div>

                <div>
                    <input type="button" value="작성" onclick="commuity_send(this.form)" />
                    <input type="button" value="취소" onclick="history.back()"/>
                    <input type="button" value="미리보기" onclick="preview()"/>
                </div>

            </form>

            <!-- 미리보기 -->
            <div id="preview_model" hidden>
                
                <h2 id="preview_title"></h2>

                <p id="preview_content"></p>
                
                <input type="button" value="닫기" onclick="this.closest('#preview_model').hidden=true"/>

            </div>
        </div>
    </body>
</html>