<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <section>
            <div class="inquiry-box">
                <div class="inquiry-title">
                    <h3>문의 내역</h3>
                    <input type="button" value="문의 작성" onclick="location.href='/inquiry'"/>
                </div>
                <div class="inquiry-main">
                    <small>전체 건수</small>
                    <select>
                        <option value="recently">최신순</option>
                        <option value="asc">오름차순</option>
                        <option value="desc">내림차순</option>
                    </select>
                    <!-- foreach로 문의 사항 출력 -->
                    <div class="inquiry-card">
                        <span>답변 상태</span>
                        <strong>문의 제목</strong>
                        <small>문의 날짜</small>
                        <div class="inquiry-card-context">
                            문의 내용
                            <div class="inquiry-card-admin">
                                관리자 답변 내용
                            </div>  
                        </div>
                    </div>
                    <!--  -->

                </div>
                <div> 페이징 처리 &lt 1 &gt</div>
            </div>
        </section>