<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기 · 커뮤니티</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community_form.css">
    <script>
        let newPhotos = [];
        // 게시글 작성 및 수정시 필요한 데이터 연동
        document.addEventListener('DOMContentLoaded', function() {
            
            const content = document.getElementById('content');
            const title = document.getElementById('title');
            const photo = document.getElementById('photo');
            const photoPreviews = document.getElementById('photo-previews');
            const category = document.getElementById('community-type');
            const saveCategory = '${community.community_type}';

           

            if ( saveCategory !== '' ){
                category.value = saveCategory;
            }
            
            document.getElementById('character-count').textContent =
                content.value.length;
    
            content.addEventListener('input', function(){
                document.getElementById('character-count').textContent =
                    content.value.length;
            });

            photo.addEventListener('change', function () {
                const selected = Array.from(photo.files);

                const existingCount = document.querySelectorAll(
                    '.existing-photo input[name="deletePhotos"]:disabled'
                ).length;
                const status = document.getElementById('photo-status');
    
                if ( existingCount + selected.length > 5) {
                    alert('사진은 최대 5장까지 선택 가능합니다.');                                       
                } else {
                    newPhotos = selected;
                }

                photo.value = '';
                renderPhotos();
                
            })
        })

        // 커뮤니티 작성 
        function commuity_send(f){

            if( f.title.value.trim() === ''){
                alert("제목을 입력하세요!!");
                f.title.focus();
                return;
            }

            if( f.content.value.trim() === ''){
                alert("내용 입력하세요!!!");
                f.content.focus();
                return;
            }

            const files = new DataTransfer();

            newPhotos.forEach(function (file) {
                files.items.add(file);
            });

            f.querySelector('#photo').files = files.files;

            f.submit();
        }

        // 게시글 미리보기 함수
        function preview(){
            document.getElementById('preview_title').textContent =
                document.getElementById('title').value;
            document.getElementById('preview_content').textContent =
                document.getElementById('content').value;

            const previewPhotos = document.getElementById('preview_photos');
            const photo = document.getElementById('photo');

            previewPhotos.replaceChildren();

            for (const file of newPhotos) {
                const image = document.createElement('img');

                image.src = URL.createObjectURL(file);
                image.alt = file.name;
                image.style.maxWidth = '100%';

                previewPhotos.append(image);

                image.onload = function () {
                    URL.revokeObjectURL(image.src);
                };
            }

            document.getElementById('preview_model').hidden = false;
        }

        // 사진 선택 삭제
        function removePhoto(btn){
            const photo = btn.closest('.existing-photo');

            photo.querySelector('input').disabled = false;
            photo.hidden = true;
        }

        // 게시글 수정 함수
        function modify(f){
            
            const formdata = new FormData(f);

            formdata.delete('photo');

            newPhotos.forEach(function (file) {
                formdata.append('photo', file);
            });

            fetch("/community_update", {
                method: 'post',
                body: formdata
            })
            .then(res => res.json())
            .then(data => {
                if(data.result > 0) {
                    alert("수정이 완료 되었습니다!");
                    location.href='/community_view?community_id=${community.community_id}';
                } else{
                    alert("오류 발생");
                }
            });
        }

        // 사진 새로 만드는 함수
        function renderPhotos() {
            const box = document.getElementById('photo-previews');
            box.replaceChildren();

            newPhotos.forEach(function (file, index) {
                const card = document.createElement('div');
                card.className = 'photo-card';

                const image = document.createElement('img');
                const url = URL.createObjectURL(file);

                image.src = url;
                image.alt = file.name;
                image.onload = function () {
                    URL.revokeObjectURL(url);
                };

                const button = document.createElement('button');
                button.type = 'button';
                button.textContent = '삭제';
                button.onclick = function () {
                    newPhotos.splice(index, 1);
                    renderPhotos();
                };

                card.append(image, button);
                box.append(card);
            });

            document.getElementById('photo-status').textContent =
                newPhotos.length === 0
                    ? '선택된 파일 없음'
                    : newPhotos.length + '장 선택됨';
        }
    </script>
</head>
<body class="community-write-body">

    <jsp:include page="/WEB-INF/views/common/is_login.jsp"/>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp">
        <jsp:param name="currentMenu" value="community"/>
    </jsp:include>

    <main class="community-write-page">
        <nav class="write-breadcrumb" aria-label="현재 위치">
            <a href="${pageContext.request.contextPath}/list.do">커뮤니티</a><span aria-hidden="true">/</span><span>글쓰기</span>
        </nav>

        <div class="write-intro">
            <h1>${mode eq 'edit' ? '글수정' : '글쓰기'}</h1>
            <p>나누고 싶은 이야기를 자유롭게 남겨주세요.</p>
        </div>

        <form id="community-form"
              method="post"
              action="${pageContext.request.contextPath}${mode eq 'edit' ? 'community_update' : '/community_insert'}"
              enctype="multipart/form-data">
            <input type="hidden" name="member_id" value="${user.member_id}"/>

            <c:if test="${mode eq 'edit'}">
                <input type="hidden" name="community_id" value="${community.community_id}"/>
            </c:if>

            <div class="write-field">
                <label for="community-type">카테고리</label>
                <select id="community-type" name="community_type" required>

                    <c:if test="${user.role eq 'ADMIN'}">
                        <option value="NOTICE">공지</option>
                    </c:if>

                    <option value="FREE">자유</option>
                    <option value="QUESTION">질문</option>
                    <option value="REVIEW">후기</option>
                </select>
            </div>

            <div class="write-field">
                <label for="title">제목</label>
                <input id="title" 
                       name="title"
                       value="<c:out value='${community.title}'/>"
                       placeholder="제목을 입력해주세요." 
                       required>
            </div>

            <div class="write-field">

                <label for="content">내용</label>

                <textarea id="content" 
                          name="content" 
                          placeholder="내용을 자유롭게 작성해주세요."
                          maxlength="5000" 
                          aria-describedby="content-count" 
                          required><c:out value='${community.content}'/>
                </textarea>
                
                <p class="write-count" id="content-count">
                    <span id="character-count">0</span> / 5,000
                </p>
            </div>

            <div class="write-field write-photos">

                <label for="photo">사진 첨부</label>
                <p class="write-help" id="photo-help">최대 5장까지 첨부할 수 있어요.</p>

                <div class="write-file-control">

                    <label class="write-button file-picker" for="photo">사진 선택</label>

                    <input class="write-file-input" 
                           id="photo" 
                           type="file" 
                           name="photo" 
                           accept="image/*" 
                           multiple 
                           aria-describedby="photo-help photo-status">

                    <span id="photo-status" aria-live="polite">선택된 파일 없음</span>
                </div>

                <p id="photo-error" class="write-error" role="alert"></p>

                <c:if test="${mode eq 'edit' and not empty img.image_list}">
                    <c:forEach var="fileName"
                               items="${fn:split(img.image_list, ',')}">
                        <c:url var="existingPhotoUrl"
                               value="/upload/commuity/${fn:trim(fileName)}"/>
                        
                        <div class="existing-photo">
                            <img src="${fn:escapeXml(existingPhotoUrl)}"
                                 alt="기존 첨부 사진"
                                 width="150"/>    
                        
                            <input type="hidden"
                                   name="deletePhotos"
                                   value="${fn:escapeXml(fn:trim(fileName))}" 
                                   disabled/>
                            <input type="button"
                                   onclick="removePhoto(this)"
                                   value="X"/>         
                        </div>
                             
                    </c:forEach>
                </c:if>

                <div id="photo-previews" class="photo-previews"></div>

            </div>

            <div class="write-actions">                

                <a class="write-button" 
                   href="${pageContext.request.contextPath}/list.do">
                   취소
                </a>

                <div class="write-submit-actions">

                    <button class="write-button" type="button"
                            onclick="preview()">
                            미리보기
                    </button>

                    <button class="write-button write-primary" 
                            type="button"
                            onclick="${mode eq 'edit' ? 'modify(this.form)' : 'commuity_send(this.form)'}">
                            ${mode eq 'edit' ? '수정하기' : '등록하기'}
                    </button>
                </div>
            </div>
        </form>
    </main>


    <div id="preview_model" class="post-preview" hidden>

        <div class="preview-top"><span>미리보기</span><button type="button" 
             onclick="this.closest('#preview_model').hidden=true">
             닫기
            </button>
        </div>

        <h2 id="preview_title"></h2>

        <p id="preview_content"></p>

        <div id="preview_photos"></div>
    </div>
</body>
</html>

