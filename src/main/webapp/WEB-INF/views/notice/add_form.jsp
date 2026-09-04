<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/css/main.css">
        <link rel="stylesheet" href="/css/notice_add.css">

        <script>
            let selectedFiles = []; 

            function noticeSend(f) {
                if (f.title.value.trim() === "") {
                    alert("공지사항 제목을 입력하세요.");
                    f.title.focus();
                    return false;
                }

                if (f.content.value.trim() === "") {
                    alert("공지사항 내용을 입력하세요.");
                    f.content.focus();
                    return false;
                }

                return true;
            }

            //  이미지 선택 시 파일 목록 저장
            function changeImages(input) {
                selectedFiles = Array.from(input.files);
                renderPreview();
                updateFileInput();
            }

            //  선택한 이미지 미리보기 출력
            function renderPreview() {
                const previewList = document.getElementById("preview-list");
                previewList.innerHTML = "";

                selectedFiles.forEach(function(file, index) {
                    const item = document.createElement("div");
                    item.className = "preview-item";

                    const img = document.createElement("img");
                    img.src = URL.createObjectURL(file);
                    img.alt = "첨부 이미지";

                    const btn = document.createElement("button");
                    btn.type = "button";
                    btn.innerText = "×";
                    btn.onclick = function() {
                        removeFile(index);
                    };

                    item.appendChild(img);
                    item.appendChild(btn);
                    previewList.appendChild(item);
                });
            }

            //  X 버튼 클릭 시 선택 파일 제거
            function removeFile(index) {
                selectedFiles.splice(index, 1);
                renderPreview();
                updateFileInput();
            }

            //  실제 input 파일 목록 갱신
            function updateFileInput() {
                const input = document.getElementById("images");
                const dataTransfer = new DataTransfer();

                selectedFiles.forEach(function(file) {
                    dataTransfer.items.add(file);
                });

                input.files = dataTransfer.files;
            }
        </script>
    </head>

    <body>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp" />

        <main class="notice-write-page">

            <section class="write-layout">

                <aside class="write-side">
                    <span>NOTICE</span>
                    <h2>공지사항<br>등록하기</h2>
                    <p>중요한 소식과 안내사항을<br>사용자에게 전달해보세요.</p>
                </aside>

                <section class="write-card">
                    <form action="notice_add.do" method="post" enctype="multipart/form-data" onsubmit="return noticeSend(this)">

                        <label>제목</label>
                        <input type="text" name="title" placeholder="제목을 입력해 주세요.">

                        <label>내용</label>
                        <textarea name="content" placeholder="내용을 입력해 주세요."></textarea>

                        <label>이미지</label>

                        <div id="preview-list"></div>

                        <input type="file" name="images" id="images" multiple accept="image/*" onchange="changeImages(this)"> 

                        <div class="btn-area">
                            <button type="submit">등록하기</button>
                            <button type="button" onclick="location.href='notice.do'">취소</button>
                        </div>

                    </form>
                </section>

            </section>

        </main>
    </body>
</html>