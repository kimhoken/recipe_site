<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/navibar.jsp">
    <jsp:param name="currentMenu" value="guide" />
</jsp:include>

<!DOCTYPE html>
<html>
<head>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/main.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/guide/guide_update.css">

    <style>
        body {
            background-color: #ffffff !important;
        }

        .existing-image {
            margin-top: 12px;
        }

        .existing-image img {
            width: 130px;
            height: 130px;
            object-fit: cover;
            border: 1px solid #e0dad5;
            border-radius: 8px;
        }

        .delete-step-btn {
            padding: 7px 13px;
            border: none;
            border-radius: 5px;
            background-color: #ebe5e1;
            color: #614f42;
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 12px;
            cursor: pointer;
        }

        .delete-step-btn:hover {
            background-color: #d9cec6;
        }
    </style>
</head>

<body>

<div class="guide-write-container">

    <div class="write-header">
        <h1>키친 가이드</h1>
        <p>키친가이드를 수정해주세요.</p>
    </div>


    <form action="${pageContext.request.contextPath}/guide_update.do"
          method="post"
          enctype="multipart/form-data">

        <!-- guide_id -->
        <input type="hidden"
               name="guide_id"
               value="${guide.guide_id}">


        <!-- ========================= -->
        <!-- 기본 정보 -->
        <!-- ========================= -->

        <div class="write-section">

            <h2 class="guide-write-title">
                기본 정보
            </h2>


            <!-- 카테고리 -->
            <div class="write-group">

                <label for="tab">
                    카테고리
                </label>

                <select name="tab"
                        id="tab"
                        required>

                    <option value="storage"
                        ${guide.tab eq 'storage' ? 'selected' : ''}>
                        보관법
                    </option>

                    <option value="trim"
                        ${guide.tab eq 'trim' ? 'selected' : ''}>
                        손질법
                    </option>

                    <option value="tip"
                        ${guide.tab eq 'tip' ? 'selected' : ''}>
                        요리팁
                    </option>

                    <option value="etc"
                        ${guide.tab eq 'etc' ? 'selected' : ''}>
                        기타
                    </option>

                </select>

            </div>


            <!-- 소제목 -->
            <div class="write-group">

                <label for="sub_title">
                    소제목
                </label>

                <input type="text"
                       id="sub_title"
                       name="sub_title"
                       value="${guide.sub_title}"
                       required>

            </div>


            <!-- 제목 -->
            <div class="write-group">

                <label for="title">
                    제목
                </label>

                <input type="text"
                       id="title"
                       name="title"
                       value="${guide.title}"
                       required>

            </div>


            <!-- 대표 이미지 -->
            <div class="write-group">

                <label>
                    대표 이미지
                </label>

                <c:if test="${not empty guide.image}">
                    <div class="existing-image">

                        <img src="${pageContext.request.contextPath}/upload/guide/${guide.image}"
                             alt="기존 대표 이미지">

                    </div>
                </c:if>


                <input type="file"
                       name="mainImage"
                       accept="image/*"
                       onchange="previewMainImage(this)">

                <div class="image-preview"
                     id="mainImagePreview">
                </div>

            </div>

        </div>



        <!-- ========================= -->
        <!-- 단계 -->
        <!-- ========================= -->

        <div class="write-section">

            <div class="section-title-area">

                <h2 class="guide-write-title">
                    단계별 설명
                </h2>

                <button type="button"
                        class="step-add-btn"
                        onclick="addStep()">
                    + 단계 추가
                </button>

            </div>


            <div id="stepContainer">

                <!-- 기존 단계 -->
                <c:forEach var="step"
                           items="${stepList}"
                           varStatus="status">

                    <div class="write-step">

                        <!-- 기존 step_id -->
                        <input type="hidden"
                               name="step_id"
                               value="${step.step_id}">

                        <!-- 기존 이미지 -->
                        <input type="hidden"
                               name="existing_step_image"
                               value="${step.step_image}">


                        <div class="step-header">

                            <h3 class="step-title">
                                Step ${status.index + 1}
                            </h3>

                            <button type="button"
                                    class="delete-step-btn"
                                    onclick="removeExistingStep(this, '${step.step_id}')">
                                삭제
                            </button>

                        </div>


                        <!-- 설명 -->
                        <div class="write-group">

                            <label>
                                설명
                            </label>

                            <textarea name="step_content"
                                      required>${step.step_content}</textarea>

                        </div>


                        <!-- 기존 단계 이미지 -->
                        <div class="write-group">

                            <label>
                                단계 이미지
                            </label>

                            <c:if test="${not empty step.step_image}">

                                <div class="existing-image">

                                    <img src="${pageContext.request.contextPath}/upload/guide/${step.step_image}"
                                         alt="기존 단계 이미지">

                                </div>

                            </c:if>


                            <input type="file"
                                   name="step_image"
                                   accept="image/*"
                                   onchange="previewStepImage(this)">

                            <div class="image-preview">
                            </div>

                        </div>

                    </div>

                </c:forEach>

            </div>


            <!-- 삭제할 기존 step_id 저장 -->
            <div id="deleteStepContainer">
            </div>

        </div>



        <!-- ========================= -->
        <!-- 버튼 -->
        <!-- ========================= -->

        <div class="write-buttons">

            <a href="${pageContext.request.contextPath}/guide_detail.do?guide_id=${guide.guide_id}"
               class="cancel-btn">
                취소
            </a>

            <button type="submit"
                    class="submit-btn">
                수정
            </button>

        </div>

    </form>

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />


<script>

    // =========================
    // 대표 이미지 미리보기
    // =========================

    function previewMainImage(input) {

        const preview =
            document.getElementById("mainImagePreview");

        preview.innerHTML = "";

        if (!input.files ||
            !input.files[0]) {
            return;
        }

        const reader =
            new FileReader();

        reader.onload =
            function(e) {

                const img =
                    document.createElement("img");

                img.src =
                    e.target.result;

                img.className =
                    "preview-img";

                preview.appendChild(img);
            };

        reader.readAsDataURL(
            input.files[0]
        );
    }



    // =========================
    // 단계 이미지 미리보기
    // =========================

    function previewStepImage(input) {

        const preview =
            input.parentElement
                 .querySelector(".image-preview");

        preview.innerHTML = "";

        if (!input.files ||
            !input.files[0]) {
            return;
        }

        const reader =
            new FileReader();

        reader.onload =
            function(e) {

                const img =
                    document.createElement("img");

                img.src =
                    e.target.result;

                img.className =
                    "preview-img";

                preview.appendChild(img);
            };

        reader.readAsDataURL(
            input.files[0]
        );
    }



    // =========================
    // 새 단계 추가
    // =========================

    function addStep() {

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


        step.innerHTML = `

            <input type="hidden"
                   name="step_id"
                   value="0">

            <input type="hidden"
                   name="existing_step_image"
                   value="">


            <div class="step-header">

                <h3 class="step-title">
                    Step
                </h3>

                <button type="button"
                        class="step-remove-btn"
                        onclick="removeNewStep(this)">
                    삭제
                </button>

            </div>


            <div class="write-group">

                <label>
                    설명
                </label>

                <textarea name="step_content"
                          required></textarea>

            </div>


            <div class="write-group">

                <label>
                    단계 이미지
                </label>

                <input type="file"
                       name="step_image"
                       accept="image/*"
                       onchange="previewStepImage(this)">

                <div class="image-preview">
                </div>

            </div>
        `;


        container.appendChild(step);

        renumberSteps();
    }



    // =========================
    // 새로 추가한 단계 삭제
    // =========================

    function removeNewStep(button) {

        const step =
            button.closest(
                ".write-step"
            );

        step.remove();

        renumberSteps();
    }



    // =========================
    // 기존 단계 삭제
    // =========================

    function removeExistingStep(
        button,
        stepId
    ) {

        if (!confirm(
            "이 단계를 삭제하시겠습니까?"
        )) {
            return;
        }


        // 삭제할 step_id hidden 생성
        const deleteContainer =
            document.getElementById(
                "deleteStepContainer"
            );


        const input =
            document.createElement(
                "input"
            );

        input.type =
            "hidden";

        input.name =
            "delete_step_id";

        input.value =
            stepId;


        deleteContainer.appendChild(
            input
        );


        // 화면에서 단계 제거
        const step =
            button.closest(
                ".write-step"
            );

        step.remove();


        renumberSteps();
    }



    // =========================
    // Step 번호 다시 정렬
    // =========================

    function renumberSteps() {

        const steps =
            document.querySelectorAll(
                "#stepContainer .write-step"
            );


        steps.forEach(
            function(step, index) {

                const title =
                    step.querySelector(
                        ".step-title"
                    );

                title.textContent =
                    "Step " +
                    (index + 1);
            }
        );
    }


    // 처음 페이지 로딩 시 번호 정렬
    renumberSteps();

</script>

</body>
</html>

