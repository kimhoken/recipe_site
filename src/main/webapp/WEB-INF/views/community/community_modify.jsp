<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기 · 커뮤니티</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community_form.css">
    <script>

        document.addEventListener('DOMContentLoaded', function() {
            
            const content = document.getElementById('content');
            const title = document.getElementById('title');
            const photo = document.getElementById('photo');
            const photoPreviews = document.getElementById('photo-previews');
    
            content.addEventListener('input', function(){
                document.getElementById('character-count').textContent =
                    content.value.length;
            });

            photo.addEventListener('change', function () {
                const status = document.getElementById('photo-status');

                photoPreviews.replaceChildren();

                if ( photo.files.length > 5) {
                    alert('사진은 최대 5장까지 선택 가능합니다.');
                    photo.value = '';
                    status.textContent = '선택된 파일 없음';
                    return;
                }

                if( photo.files.length === 0) {
                    status.textContent = '선택된 파일 없음';
                } else {
                    status.textContent = photo.files.length + '장 선택됨';
                }

                for (const file of photo.files){
                    const image = document.createElement('img');

                    image.src=URL.createObjectURL(file);
                    image.alt = file.name;
                    image.width = 150;

                    photoPreviews.append(image);

                    image.onload = function () {
                        URL.revokeObjectURL(image.src);
                    }
                }
            })
        })


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

            f.submit();
        }

        function preview(){
            document.getElementById('preview_title').textContent =
                document.getElementById('title').value;
            document.getElementById('preview_content').textContent =
                document.getElementById('content').value;

            const previewPhotos = document.getElementById('preview_photos');
            const photo = document.getElementById('photo');

            previewPhotos.replaceChildren();

            for (const file of photo.files) {
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
            <h1>글쓰기</h1>
            <p>나누고 싶은 이야기를 자유롭게 남겨주세요.</p>
        </div>
        <form id="community-form" method="post" action="${pageContext.request.contextPath}/community_update" enctype="multipart/form-data">
            <input type="hidden" name="member_id" value="${user.member_id}">
            <div class="write-field">
                <label for="community-type">카테고리</label>
                <select id="community-type" name="community_type" required>
                    <c:if test="${user.role eq 'ADMIN'}"><option value="NOTICE">공지</option></c:if>
                    <option value="FREE">자유</option>
                    <option value="QUESTION">질문</option>
                    <option value="REVIEW">후기</option>
                </select>
            </div>
            <div class="write-field">
                <label for="title">제목</label>
                <input id="title" name="title" placeholder="제목을 입력해주세요." required>
            </div>
            <div class="write-field">
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용을 자유롭게 작성해주세요." maxlength="5000" aria-describedby="content-count" required></textarea>
                <p class="write-count" id="content-count"><span id="character-count">0</span> / 5,000</p>
            </div>
            <div class="write-field write-photos">
                <label for="photo">사진 첨부</label>
                <p class="write-help" id="photo-help">최대 5장까지 첨부할 수 있어요.</p>
                <div class="write-file-control">
                    <label class="write-button file-picker" for="photo">사진 선택</label>
                    <input class="write-file-input" id="photo" type="file" name="photo" accept="image/*" multiple aria-describedby="photo-help photo-status">
                    <span id="photo-status" aria-live="polite">선택된 파일 없음</span>
                </div>
                <p id="photo-error" class="write-error" role="alert"></p>
                <div id="photo-previews" class="photo-previews"></div>
            </div>
            <div class="write-actions">
                <a class="write-button" href="${pageContext.request.contextPath}/list.do">취소</a>
                <div class="write-submit-actions">
                    <button class="write-button" type="button" onclick="preview()">미리보기</button>
                    <button class="write-button write-primary" type="button" onclick="commuity_send(this.form)">등록하기</button>
                </div>
            </div>
        </form>
    </main>
    <div id="preview_model" class="post-preview" hidden>
        <div class="preview-top"><span>미리보기</span><button type="button" onclick="this.closest('#preview_model').hidden=true">닫기</button></div>
        <h2 id="preview_title"></h2>
        <p id="preview_content"></p>

        <div id="preview_photos"></div>
    </div>
</body>
</html>
