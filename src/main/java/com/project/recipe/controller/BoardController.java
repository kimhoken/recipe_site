// package com.project.recipe.controller;

// import java.util.*;

// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestBody;
// import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.multipart.MultipartFile;

// import com.project.recipe.common.Fileupload;
// import com.project.recipe.common.Paging;
// import com.project.recipe.dao.BoardDAO;

// import com.project.recipe.dao.ReviewDAO;
// import com.project.recipe.vo.BoardVO;
// import com.project.recipe.vo.MemberVO;
// import com.project.recipe.vo.ReviewVO;

// import lombok.RequiredArgsConstructor;


// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpSession;
// import org.springframework.web.bind.annotation.ResponseBody;

// @Controller
// @RequiredArgsConstructor
// public class BoardController {

    
//     private final HttpSession session;
//     private final ReviewDAO reviewDao;
//     private final Fileupload fileupload;         
//     private final BoardDAO boardDAO;

//     // board list 조회
//     @GetMapping("/list.do")
//     public String boardList(
//             Model model,
//             String sort,
//             String period,
//             String btn,
//             @RequestParam(value = "page", defaultValue = "1") int page) {

//         // 레시피 후기 탭의 조회
//         if (sort == null || sort.isEmpty()) {
//             sort = "all";
//         }

//         Map<String, Object> reviewMap = new HashMap<>();
//         reviewMap.put("sort", sort);
//         reviewMap.put("period", period);

//         int reviewTotalcount = reviewDao.reviewCount(reviewMap);
//         Paging reviewPaging = new Paging(page, 6, reviewTotalcount);

//         reviewMap.put("offset", reviewPaging.getOffset());
//         reviewMap.put("size", reviewPaging.getSize());

//         List<ReviewVO> reviewList = reviewDao.reviewPage(reviewMap);

//         int totalcount = boardDao.communityBoardCount();
//         Paging paging = new Paging(page, 10, totalcount);

//         Map<String, Object> map = new HashMap<>();
//         map.put("offset", paging.getOffset());
//         map.put("size", paging.getSize());

//         model.addAttribute("list", boardDao.selectBoardPage(map));
//         model.addAttribute("paging", paging);       

//         model.addAttribute("sort", sort);
//         model.addAttribute("period", period);
//         model.addAttribute("btn", btn);
//         return "board/board_list";
//     }

//     // // board 검색
//     // @PostMapping("/search.do")
//     // public String boardSearch(Model model, String search) {
//     //     List<BoardVO> list = boardDao.search(search);

//     //     model.addAttribute("list", list);
//     //     model.addAttribute("searchWord", search); //검색어 보관
//     //     return "board/board_list";
//     // }
    
   
//     // 여기서 부터 커뮤니티 상세보기
//     @GetMapping("/view.do")
//     public String boardView(
//             int board_id,
//             Model model,
//             HttpServletRequest req,
//             @RequestParam(value = "commentPage", defaultValue = "1") int commentPage) {

//         // 조회수 처리
//         @SuppressWarnings("unchecked")
//         HashMap<String, List<Integer>> map = session.getAttribute("viewMap") == null ? new HashMap<>()
//                 : (HashMap<String, List<Integer>>) session.getAttribute("viewMap");

//         // 조회수 처리 코드 정리
//         String ip = req.getRemoteAddr();
//         List<Integer> viewedList = map.computeIfAbsent(ip, k -> new ArrayList<>());

//         // 같은 IP에서 같은 게시글은 한 번만 조회수 증가
//         if (!viewedList.contains(board_id)) {
//             viewedList.add(board_id);
//             boardDao.updateViewCount(board_id);
//             session.setAttribute("viewMap", map); 
//             session.setMaxInactiveInterval(3600);
//         }

//         // 게시글 조회
//         BoardVO board = boardDao.selectOne(board_id);

//         // 커뮤니티 댓글 페이징 처리
//         int commentSize = 5;
//         int commentTotalCount = commonCommentDAO.boardCommentCount(board_id);
//         Paging commentPaging = new Paging(commentPage, commentSize, commentTotalCount);

//         // 커뮤니티 댓글 페이징 조회용 map
//         Map<String, Object> commentMap = new HashMap<>();
//         commentMap.put("board_id", board_id);
//         commentMap.put("offset", commentPaging.getOffset());
//         commentMap.put("size", commentPaging.getSize());

//         model.addAttribute("board", board);

//         // 기존 getBoardList(board_id) 대신 페이징 조회
//         model.addAttribute("commentList", commonCommentDAO.getBoardListPaging(commentMap));

//         // JSP 페이징 출력용 객체
//         model.addAttribute("commentPaging", commentPaging);

//         return "board/board_view";
//     }

//     // 상세보기 수정 폼
//     @GetMapping("/update_form.do")
//     public String updateForm(int board_id, HttpSession session, Model model) {
//         BoardVO board = boardDao.selectOne(board_id);
//         model.addAttribute("board", board);
//         return "board/board_update";
//     }

//     // 상세보기 수정
//     @PostMapping("/update.do")
//     public String update(BoardVO vo) {
//         boardDao.update(vo);
//         return "redirect:/view.do?board_id=" + vo.getBoard_id();
//     }

//     // 상세보기 삭제
//     @GetMapping("/delete.do")
//     public String delete(int board_id, HttpSession session) {
//         boardDao.selectOne(board_id);
//         boardDao.delete(board_id);
//         return "redirect:/list.do";
//     }

//     // 커뮤니티 글쓰기 폼
//     @GetMapping("/community_form.do")
//     public String communityForm() {
//         return "board/community_form";
//     }

//     // 커뮤니티 글쓰기
//     @PostMapping("/community_write.do")
//     public String write(BoardVO vo, HttpSession session) {

//         MemberVO user = (MemberVO) session.getAttribute("user");

//         vo.setMember_id(user.getMember_id());

//         vo.setBoard_type("COMMUNITY");
//         vo.setRecipe_id(1);

//         boardDao.insertBoard(vo);

//         return "redirect:/list.do";
//     }
   

    
// }
