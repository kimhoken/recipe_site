package com.project.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.recipe.common.AdminUtil;
import com.project.recipe.common.Paging;
import com.project.recipe.dao.CommunityDAO;
import com.project.recipe.dto.AdminBoardDTO;
import com.project.recipe.vo.MemberVO;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller 
@RequiredArgsConstructor 
public class AdminCommunityController {

    private final HttpSession httpSession;
    private final CommunityDAO communityDAO;
    private final AdminUtil adminUtil;

    private MemberVO requireAdmin() {
        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }

        return user;
    }

    private AdminBoardDTO findCommunity(int community_id) {
        AdminBoardDTO community = communityDAO.adminBoardDetail(community_id);

        if (community == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }

        return community;
    }

    // 게시글 페이징
    private void BoardPaging(Model model, AdminBoardDTO Board ){
        
        int totalcount = communityDAO.boardCount(Board);

        Paging paging = new Paging(Board.getPage(), 5, totalcount);

        Board.setPage(paging.getPage());
        Board.setOffset(paging.getOffset());
        Board.setSize(paging.getSize());

        List<AdminBoardDTO> list = communityDAO.BoardSearch(Board);
        
        model.addAttribute("list", list);
        model.addAttribute("totalcount", totalcount );
        model.addAttribute("paging", paging);
        model.addAttribute("adminboard", Board);

    }


    // 관리자 게시글 페이지
    @GetMapping("/admin/board")
    public String boardpage(Model model, AdminBoardDTO Board){
        
        MemberVO user = requireAdmin();
        
        model.addAttribute("profileuser", user);        

        adminUtil.setContentPage(model, "board");

        BoardPaging(model, Board);

        return "member/adminpage";
    }

    // 게시글 상세 조회
    @PostMapping("/admin/board/view")
    @ResponseBody
    public AdminBoardDTO board_view(int community_id){
        requireAdmin();

        return findCommunity(community_id);
    }

    // 게시글 공개/비공개 설정
    @PostMapping("/admin/board/hidden")
    @ResponseBody
    public Map<String,Object> boardHidden( int community_id ) {

        requireAdmin();

        AdminBoardDTO Board = findCommunity(community_id);

        if (!"ACTIVE".equals(Board.getStatus()) && !"HIDDEN".equals(Board.getStatus())) {
            return Map.of("result", 0, "status", Board.getStatus());
        }

        if (Board.getStatus().equals("ACTIVE") ){
            Board.setStatus("HIDDEN");
        } else if ( Board.getStatus().equals("HIDDEN")  ){
            Board.setStatus("ACTIVE");
        }

        int res = communityDAO.boardStatus(Board);

        Map<String,Object> map = new HashMap<>();

        map.put("result", res);
        map.put("status", Board.getStatus());

        return map;

    }

    // 게시글 삭제/ 복원
    @PostMapping("/admin/board/delete")
    @ResponseBody
    public Map<String,Object> boardDelete(int community_id){

        requireAdmin();

        AdminBoardDTO Board = findCommunity(community_id);

        if (Board.getStatus().equals("DELETE") ){
            Board.setStatus("ACTIVE");
        } else if ( Board.getStatus().equals("ACTIVE") || Board.getStatus().equals("HIDDEN") ){
            Board.setStatus("DELETE");
        }

        int res = communityDAO.boardStatus(Board);

        Map<String,Object> map = new HashMap<>();

        map.put("result", res);
        map.put("status", Board.getStatus());

        return map;

    }


}
