<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide/guide_add.css">

    </head>

    <body>

        <c:choose>

            <c:when test="${empty sessionScope.user}">

                <script>

                    console.log("비로그인 사용자 접근");

                    alert("로그인 후 이용해주세요.");

                    window.location.href =
                        "${pageContext.request.contextPath}/login.do";

                </script>

            </c:when>


            <c:when test="${sessionScope.user.role ne 'ADMIN'}">

                <script>

                    console.log("일반회원 접근");

                    alert("관리자만 접근 가능한 페이지입니다.");

                    window.location.href =
                        "${pageContext.request.contextPath}/";

                </script>

            </c:when>

            <c:otherwise>


                <jsp:include page="/WEB-INF/views/common/navibar.jsp">

                    <jsp:param name="currentMenu" value="guide" />

                </jsp:include>



                <div class="guide-write-container">


                    <div class="write-header">

                        <h1>
                            키친 가이드 작성
                        </h1>

                        <p>
                            유용한 주방 노하우를 새로운 가이드로 등록해보세요.
                        </p>

                    </div>



                    <form action="${pageContext.request.contextPath}/guide_add.do" method="post"
                        enctype="multipart/form-data">


                        <div class="write-section">


                            <h2 class="guide-write-title">
                                기본 정보
                            </h2>


                            <div class="write-group">

                                <label>
                                    카테고리
                                </label>

                                <select name="tab" required>

                                    <option value="">
                                        선택해주세요
                                    </option>

                                    <option value="storage">
                                        보관법
                                    </option>

                                    <option value="trim">
                                        손질법
                                    </option>

                                    <option value="tip">
                                        요리꿀팁
                                    </option>

                                    <option value="etc">
                                        기타정보
                                    </option>

                                </select>

                            </div>



                            <div class="write-group">

                                <label>
                                    소제목
                                </label>

                                <input type="text" name="sub_title" placeholder="소제목을 입력해주세요">

                            </div>



                            <div class="write-group">

                                <label>
                                    제목
                                </label>

                                <input type="text" name="title" placeholder="제목을 입력해주세요" required>

                            </div>



                            <div class="write-group">

                                <label>
                                    대표 이미지
                                </label>

                                <input type="file" name="mainImage" accept="image/*" onchange="previewImage(this)" required>

                                <div class="image-preview"></div>

                            </div>


                        </div>



                        <div class="write-section">


                            <div class="section-title-area">


                                <h2 class="guide-write-title">
                                    단계별 가이드
                                </h2>


                                <button type="button" class="step-add-btn" onclick="addStep()">

                                    + 단계 추가

                                </button>


                            </div>



                            <div id="stepContainer">


                                <div class="write-step">


                                    <div class="step-header">

                                        <h3>
                                            Step 1
                                        </h3>

                                    </div>



                                    <div class="write-group">

                                        <label>
                                            단계 설명
                                        </label>

                                        <textarea name="step_content" rows="5" placeholder="이 단계에 대한 설명을 입력해주세요."
                                            required></textarea>

                                    </div>



                                    <div class="write-group">

                                        <label>
                                            단계 이미지
                                        </label>

                                        <input type="file" name="step_image" accept="image/*" onchange="previewImage(this)">

                                        <div class="image-preview"></div>

                                    </div>


                                </div>


                            </div>


                        </div>



                        <div class="write-buttons">


                            <a href="${pageContext.request.contextPath}/guide_list.do" class="cancel-btn">

                                취소

                            </a>


                            <button type="submit" class="submit-btn">

                                작성

                            </button>


                        </div>


                    </form>


                </div>



                <jsp:include page="/WEB-INF/views/common/footer.jsp" />

                <script>

                    let stepCount = 1;

                    // 이미지 미리보기
                    function previewImage(input) {

                        const preview =
                            input.parentElement.querySelector(
                                ".image-preview"
                            );


                        preview.innerHTML = "";


                        if (input.files &&
                            input.files[0]) {


                            const reader =
                                new FileReader();


                            reader.onload =
                                function (e) {


                                    const img =
                                        document.createElement(
                                            "img"
                                        );


                                    img.src =
                                        e.target.result;


                                    img.className =
                                        "preview-img";


                                    preview.appendChild(
                                        img
                                    );

                                };


                            reader.readAsDataURL(
                                input.files[0]
                            );

                        }

                    }

                    // 단계 추가
                    function addStep() {

                        stepCount++;


                        const container =
                            document.getElementById(
                                "stepContainer"
                            );


                        const step =
                            document.createElement(
                                "div"
                            );


                        step.className =
                            "write-step";


                        step.innerHTML =

                            '<div class="step-header">' +

                            '<h3>Step ' +
                            stepCount +
                            '</h3>' +

                            '<button type="button" ' +
                            'class="step-remove-btn" ' +
                            'onclick="removeStep(this)">' +

                            '삭제' +

                            '</button>' +

                            '</div>' +


                            '<div class="write-group">' +

                            '<label>' +
                            '단계 설명' +
                            '</label>' +

                            '<textarea ' +
                            'name="step_content" ' +
                            'rows="5" ' +
                            'placeholder="이 단계에 대한 설명을 입력해주세요." ' +
                            'required>' +
                            '</textarea>' +

                            '</div>' +


                            '<div class="write-group">' +

                            '<label>' +
                            '단계 이미지' +
                            '</label>' +

                            '<input type="file" ' +
                            'name="step_image" ' +
                            'accept="image/*" ' +
                            'onchange="previewImage(this)">' +

                            '<div class="image-preview"></div>' +

                            '</div>';


                        container.appendChild(
                            step
                        );

                    }

                    // 단계 삭제
                    function removeStep(button) {

                        button
                            .closest(".write-step")
                            .remove();

                    }

                </script>


            </c:otherwise>

        </c:choose>

    </body>

</html>