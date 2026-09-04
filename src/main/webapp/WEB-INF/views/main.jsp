<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/common/navibar.jsp">
    <jsp:param name="currentMenu" value="home" />
</jsp:include>
<!DOCTYPE html>
<html>
    <head>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

        <script>
            document.addEventListener("DOMContentLoaded", function () {

            // 실제 슬라이드는 3장, 앞뒤로 복제본 1장씩 붙어서 총 5개
            const totalSlides = 3;
            let currentIndex = 1;
            let isAnimating = false; // 애니메이션 중 클릭 방지 플래그

            const bannerWrap = document.querySelector(".banner-wrap");
            const slideWrap = document.getElementById("bannerSlide");
            const slideItems = document.querySelectorAll(".slide-item");
            const dots = document.querySelectorAll(".dot");
            const prevBtn = document.querySelector(".prev-btn");
            const nextBtn = document.querySelector(".next-btn");
            let autoSlideInterval;

            // 슬라이드 1개의 너비는 전체 감싸고 있는 wrap의 너비를 기준으로 계산
            function getSlideWidth() {
                return bannerWrap.offsetWidth;
            }

            function moveSlide(index, withTransition) {
                if (withTransition && isAnimating) return;
                if (withTransition) isAnimating = true;

                slideWrap.style.transition = withTransition ? "transform 0.5s ease-in-out" : "none";

                const offset = -index * getSlideWidth();
                slideWrap.style.transform = "translateX(" + offset + "px)";

                if (!withTransition) {
                    void slideWrap.offsetWidth; // 리플로우 강제 트리거
                    isAnimating = false;
                }
            }

            function updateDots(realIndex) {
                for (let i = 0; i < dots.length; i++) {
                    dots[i].classList.remove("active");
                }
                if (dots[realIndex]) {
                    dots[realIndex].classList.add("active");
                }
            }

            function getRealIndex() {
                if (currentIndex === 0) return totalSlides - 1;
                if (currentIndex === totalSlides + 1) return 0;
                return currentIndex - 1;
            }

            nextBtn.addEventListener("click", function () {
                if (isAnimating) return;
                currentIndex++;
                moveSlide(currentIndex, true);
                updateDots(getRealIndex());
                resetAutoSlide();
            });

            prevBtn.addEventListener("click", function () {
                if (isAnimating) return;
                currentIndex--;
                moveSlide(currentIndex, true);
                updateDots(getRealIndex());
                resetAutoSlide();
            });

            for (let i = 0; i < dots.length; i++) {
                dots[i].addEventListener("click", function () {
                    if (isAnimating) return;
                    currentIndex = parseInt(this.getAttribute("data-index")) + 1;
                    moveSlide(currentIndex, true);
                    updateDots(getRealIndex());
                    resetAutoSlide();
                });
            }

            slideWrap.addEventListener("transitionend", function () {
                isAnimating = false;

                if (currentIndex === 0) {
                    currentIndex = totalSlides;
                    moveSlide(currentIndex, false);
                } else if (currentIndex === totalSlides + 1) {
                    currentIndex = 1;
                    moveSlide(currentIndex, false);
                }
            });

            function startAutoSlide() {
                autoSlideInterval = setInterval(function () {
                    if (isAnimating) return;
                    currentIndex++;
                    moveSlide(currentIndex, true);
                    updateDots(getRealIndex());
                }, 5000);
            }

            function resetAutoSlide() {
                clearInterval(autoSlideInterval);
                startAutoSlide();
            }

            window.addEventListener("resize", function () {
                moveSlide(currentIndex, false);
            });

            // 초기 구동
            moveSlide(currentIndex, false);
            startAutoSlide();

            /*============================ 여기까지 메인배너 슬라이드 관련 함수 =============================*/

            // 오늘의 추천 레시피 자동 변경
            let current = 0;
            const recSlides = document.querySelectorAll(".recommend-slide");

            if (recSlides.length !== 0) {
                setInterval(() => {
                    recSlides[current].classList.remove('active');
                    current = (current + 1) % recSlides.length;
                    recSlides[current].classList.add('active');
                }, 3000);
            }  

        });



        </script>


    </head>
    <body>
        
        <!-- 메인 배너 슬라이드 -->
        <div class="banner-wrap">
            <div class="banner-slide" id="bannerSlide">
                <!-- 마지막 슬라이드 복제 (맨 앞에 배치) -->
                <div class="slide-item">
                    <div class="slide-inner">
                        <img src="${pageContext.request.contextPath}/images/mainbanner3.png" alt="배너3-clone">
                    </div>
                </div>

                <div class="slide-item">
                    <div class="slide-inner">
                        <img src="${pageContext.request.contextPath}/images/mainbanner1.png" alt="배너1">
                        <div class="slide-caption">
                            <span class="slide-badge">메인</span>
                            <h2>냉장고 속 재료로,<br>오늘 한 끼 만들어볼까?</h2>
                            <p>가진 재료를 입력하면 딱 맞는 레시피를 추천해드려요.</p>
                            <a href="/fridge_list.do?member_id=${user.member_id}" class="slide-btn">재료로 레시피 찾기</a>
                        </div>
                    </div>
                </div>

                <div class="slide-item">
                    <div class="slide-inner">
                        <img src="${pageContext.request.contextPath}/images/mainbanner2.png" alt="배너2">
                        <div class="slide-caption">
                            <span class="slide-badge2">추천</span>
                            <h2>오늘의 추천 레시피</h2>
                            <p>상황별, 카테고리별로 원하는 레시피를 찾아보세요</p>
                            <a href="/recipe_list.do" class="slide-btn">레시피 보기</a>
                        </div>
                    </div>
                </div>

                <div class="slide-item">
                    <div class="slide-inner">
                        <img src="${pageContext.request.contextPath}/images/mainbanner3.png" alt="배너3">
                        <div class="slide-caption">
                            <span class="slide-badge3">키친 가이드</span>
                            <h2>요리의 기본,<br>손질부터 보관까지</h2>
                            <p>재료 손질법, 보관법, 요리 꿀팁을 한 눈에 모았어요</p>
                            <a href="/guide_list.do" class="slide-btn">가이드 보러가기</a>
                        </div>
                    </div>
                </div>

                <!-- 첫 번째 슬라이드 복제 (맨 뒤에 배치) -->
                <div class="slide-item">
                    <div class="slide-inner">
                        <img src="${pageContext.request.contextPath}/images/mainbanner1.png" alt="배너1-clone">
                    </div>
                </div>
            </div>

            <button type="button" class="banner-btn prev-btn">&#10094;</button>
            <button type="button" class="banner-btn next-btn">&#10095;</button>

            <div class="banner-indicator">
                <span class="dot active" data-index="0"></span>
                <span class="dot" data-index="1"></span>
                <span class="dot" data-index="2"></span>
            </div>
        </div>

        <div class="container main-page">
            <div class="category-list">
                <button type="button" class="category-item" data-category="korean" onclick="selectCategory('한식')">
                    <div class="category-icon">🍚</div>한식
                </button>
                <button type="button" class="category-item" data-category="western" onclick="selectCategory('양식')">
                    <div class="category-icon">🍝</div>양식
                </button>
                <button type="button" class="category-item" data-category="chinese" onclick="selectCategory('중식')">
                    <div class="category-icon">🍳</div>중식
                </button>
                <button type="button" class="category-item" data-category="japanese" onclick="selectCategory('일식')">
                    <div class="category-icon">🍣</div>일식
                </button>
                <button type="button" class="category-item" data-category="asian" onclick="selectCategory('아시안')">
                    <div class="category-icon">🌏</div>아시안
                </button>
                <button type="button" class="category-item" data-category="diet" onclick="selectCategory('건강식/다이어트')">
                    <div class="category-icon">🌿</div>건강식/다이어트
                </button>
                <button type="button" class="category-item" data-category="easy" onclick="selectCategory('초간단요리')">
                    <div class="category-icon">⏱️</div>초간단요리
                </button>
                <button type="button" class="category-item" data-category="dessert" onclick="selectCategory('디저트')">
                    <div class="category-icon">🍰</div>디저트
                </button>
                <button type="button" class="category-item" data-category="baking" onclick="selectCategory('베이킹')">
                    <div class="category-icon">🍞</div>베이킹
                </button>
                <button type="button" class="category-item" id="btnAllCategory" onclick="openModal()">
                    <div class="category-icon">☰</div>전체보기
                </button>
            </div>
        </div>

        <div class="container main-page">
            <div class="seasonal-header">
                <span class="seasonal-badge">조회수 TOP5</span>
                <h2 class="seasonal-title">이달의 TOP 5 인기 요리</h2>
                <p class="seasonal-subtitle">조회수로 검증된 베스트 레시피를 확인해보세요</p>
            </div>

            <div class="recipe-grid">
                <c:forEach var="recipe" items="${view_recipes}" varStatus="status">
                    <div class="recipe-card">
                        <a href="/recipe_detail.do?recipe_id=${recipe.recipe_id}">
                            <div class="recipe-img">
                                <img src="${pageContext.request.contextPath}/images/${recipe.thumbnail}"/>
                            </div>
                            <div class="rank-badge">${status.index + 1}</div>
                            <div class="recipe-info">
                                <div class="recipe-name">${recipe.title}</div>
                                <div class="recipe-author">👤 ${recipe.nickname}</div>
                                <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 <fmt:formatNumber value="${recipe.view_count}"/> </span></div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="container main-page mid-sections">
        <div class="mid-box refrigerator-box">
            <div>
                <br/>
                <h3>냉장고 재료로<br>레시피 추천받기</h3>
                <p>집에 있는 재료를 선택하면<br>만들 수 있는 요리를 추천해드려요!</p>
            </div>
            <button class="ref-btn" onClick="location.href='/fridge_list.do?member_id=${sessionScope.user.member_id}'">재료 선택하기 &rarr;</button>
        </div>

        <div class="mid-box">
            <h3 class="box-title">오늘의 추천 레시피</h3>
            <div class="today-main">
                <c:forEach var="recipe" items="${recommend}" varStatus="status">
                    <div class="recommend-slide ${status.first ? 'active' : ''}" onclick="location.href='/recipe_detail.do?recipe_id=${recipe.recipe_id}'">
                        <div class="today-main-img">
                            <img src="/upload/recipe/${recipe.thumbnail}"/>
                        </div>
                        <div class="today-main-info">
                            <h4>${recipe.title}</h4>
                            <p>이런 메뉴는 어떠신가요?</p>
                            <span class="author">👤 ${recipe.nickname}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
        </div>
    </div>

    
    <div class="info-bar">
        <a href="/recipe_list.do"> 
            <div class="info-item">🍳 <span>쉽고 간단한 레시피<br><small>누구나 따라할 수 있어요</small></span></div>
        </a>
        <a href="#" onclick="openModal(); return false;">
            <div class="info-item">🍱 <span>다양한 카테고리<br><small>원하는 메뉴를 쉽게 찾아보세요</small></span></div>
        </a>
        <a href="/fridge_list.do?member_id=${user.member_id}">
            <div class="info-item">🥕 <span>냉장고 재료 활용<br><small>남은 재료로 알뜰하게 요리해요</small></span></div>
        </a>
        <a href="/list.do">
            <div class="info-item">💬 <span>요리로 소통해요<br><small>후기와 팁을 공유해보세요</small></span></div>
        </a>
    </div>

    <!-- footer 회사 정보 jsp 파일 include -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    

    </body>
</html>