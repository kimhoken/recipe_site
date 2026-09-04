package com.project.recipe.common;

import org.springframework.stereotype.Component;

import com.project.recipe.dao.ViewCountDAO;
import com.project.recipe.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ViewCount {

    private final ViewCountDAO viewCountDao;
    private final HttpSession session;

    //  공지사항 조회수 중복 방지
    public void increaseNotice(int notice_id) {
        increase("NOTICE", notice_id, "viewedNotice");
    }

    //  레시피 조회수 중복 방지
    public void increaseRecipe(int recipe_id) {
        increase("RECIPE", recipe_id, "viewedRecipe");
    }

    //  게시판 조회수 중복 방지
    public void increaseBoard(int board_id) {
        increase("BOARD", board_id, "viewedBoard");
    }

    // 레시피 후기 조회수 중복 방지
    public void increaseReview(int review_id){
        increase("REVIEW",review_id,"viewedReview");
    }

    //  공지/레시피/게시판 공통 조회수 처리
    private void increase(String content_type, int content_id, String sessionName) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user != null) {
            int result = viewCountDao.viewHistory(content_type, content_id, user.getMember_id());

            if (result == 0) {
                increaseViewCount(content_type, content_id);
                viewCountDao.viewInsert(content_type, content_id, user.getMember_id());
            }

        } else {
            String viewedContent = (String) session.getAttribute(sessionName);

            if (viewedContent == null) {
                viewedContent = "";
            }

            String currentContent = "[" + content_id + "]";

            if (!viewedContent.contains(currentContent)) {
                increaseViewCount(content_type, content_id);
                viewedContent += currentContent;
                session.setAttribute(sessionName, viewedContent);
            }
        }
    }

    //  content_type에 따라 실제 테이블 조회수 증가
    private void increaseViewCount(String content_type, int content_id) {

        if ("NOTICE".equals(content_type)) {
            viewCountDao.increaseNoticeViewCount(content_id);

        } else if ("RECIPE".equals(content_type)) {
            viewCountDao.increaseRecipeViewCount(content_id);

        } else if ("BOARD".equals(content_type)) {
            viewCountDao.increaseBoardViewCount(content_id);

        } else if("REVIEW".equals(content_type)) {
            viewCountDao.increaseReviewViewCount(content_id);
        }
    }
}
