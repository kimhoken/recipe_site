<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
    <!-- 최근 레시피 후기 -->
            <div class="review-area" id="reviewArea" style="display:none;">
                <div class="review-filter-wrap">
                    <div class="filter-controls">
                        <div id="popularSubTabs" class="sub-tabs">
                            <button type="button" class="sub-tab-btn active"
                                onclick="changePeriod('all', event)">전체기간</button>
                            <button type="button" class="sub-tab-btn"
                                onclick="changePeriod('weekly', event)">주간</button>
                            <button type="button" class="sub-tab-btn"
                                onclick="changePeriod('monthly', event)">월간</button>
                        </div>
                        <select id="mainSortSelect" class="sort-dropdown" onchange="handleMainSort(this.value)">
                            <option value="all">정렬기준</option>
                            <option value="latest">최신순</option>
                            <option value="popular">조회수 순</option>
                            <option value="rating">별점</option>
                        </select>
                    </div>
                </div>
            </div>
            <!-- 후기 리스트들 -->
            <div id="reviewFeedList" class="review-feed-list">
                <c:forEach var="review" items="${reviewList}">
                    <div class="review-card" onclick="toggleReviewModal(this, '${review.review_id}')">

                        <div class="review-card-main">

                            <div class="review-card-image">
                                <c:choose>
                                    <c:when test="${not empty review.thumbnail}">
                                        <img src="/upload/review/${review.thumbnail}" alt="후기 이미지">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/upload/recipe/${review.recipe_thumbnail}" alt="레시피 이미지">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="review-card-content">
                                <div class="review-info-top">
                                    <h3 class="review-title">
                                        ${review.title}
                                    </h3>
                                    <span class="review-rating">[★ ${review.rating}]</span>
                                </div>
                                <div class="review-info-meta">
                                    <span class="review-nickname">${review.nickname}</span>
                                    <span class="review-divider">•</span>
                                    <span class="review-views">조회수 ${review.view_count}</span>
                                </div>
                                <p class="review-body">
                                    ${review.content}
                                </p>
                            </div>
                        </div>

                        <div class="review-expand-box" onclick="event.stopPropagation()">
                            <a id="model-tag" href="#">
                                <div>
                                    <img id ='model-img' class="model-img"/>
                                </div>
                                <h4 id="model-recipetitle">레시피 이름</h4>
                            </a>
                            <div id="model-rating" class="model-rating">평점</div>
                            
                            <p id="model-content" class="model-content"></p>
                            <div id="model-imgs" class="model-imgs">이미지 나열</div>
                                                       
                            <div class="review-model-btn">
                               
                                <div class="owner-btn" style="display: none;">
                                    <input type="button" 
                                           value="수정" 
                                           onclick="location.href='/review/modify?review_id=${review.review_id}'" />
                                    <input type="button" value="삭제" onclick="deleteReview('${review.review_id}')" />
                                </div>

                                <div class="guest-btn" style="display: none;">
                                    <input type="button" 
                                           value="신고" 
                                           onclick="location.href='/report/form.do?review_id=${review.review_id}'" />
                                </div>
                        
                               

                            </div>

                        </div>

                    </div>
                </c:forEach>
                
                <div class="review-page-box">

                    <c:if test="${reviewPaging.prev}">
                        <a href="/list.do?page=${reviewPaging.startpage - 1}&btn=review&sort=${sort}&period=${period}">◀</a>
                    </c:if>

                    <c:forEach var="p" begin="${reviewPaging.startpage}" end="${reviewPaging.endpage}">
                        <a href="/list.do?page=${p}&btn=review&sort=${sort}&period=${period}"
                        class="${reviewPaging.page eq p ? 'active' : ''}">
                            ${p}
                        </a>
                    </c:forEach>

                    <c:if test="${reviewPaging.next}">
                        <a href="/list.do?page=${reviewPaging.endpage + 1}&btn=review&sort=${sort}&period=${period}">▶</a>
                    </c:if>

                </div>

</body>
</html>