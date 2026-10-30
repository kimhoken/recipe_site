package com.project.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.recipe.common.Fileupload;
import com.project.recipe.common.Paging;
import com.project.recipe.dao.CommentDAO;
import com.project.recipe.dao.CommunityDAO;
import com.project.recipe.dao.ImgDAO;
import com.project.recipe.vo.CommentVO;
import com.project.recipe.vo.CommunityVO;
import com.project.recipe.vo.ImgVO;
import com.project.recipe.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor  
public class CommunityController {
    
    private final HttpSession httpSession;
    private final CommunityDAO communityDAO;
    private final Fileupload fileupload;
    private final ImgDAO imgDAO;
    private final CommentDAO commentDAO;
    

    // 커뮤니티 목록 조회
    @GetMapping ("/list.do")
    public String CommunityPage(Model model){

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        List<CommunityVO> communityList = communityDAO.CheckList();
        List<CommunityVO> noticeList = communityDAO.noticeList();

        model.addAttribute("user", user);
        model.addAttribute("community",communityList);
        model.addAttribute("notice", noticeList);

        return "community/community_list";

    }

    // 커뮤니티 작성 페이지 이동 함수
    @GetMapping ("/communityInsert")
    public String communityInsert(Model model){

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("user", user);
        model.addAttribute("mode","write");

        return "community/community_insertform";
    }

    //커뮤니티 작성 함수
    @PostMapping ("/community_insert")
    public String communityInsertFin( CommunityVO com ) throws Exception{

        String savePath = "community";
        List<MultipartFile> photos = com.getPhoto();

        String filename = fileupload.saveFiles(photos, savePath);

        ImgVO img = new ImgVO();

        communityDAO.communityInsert( com );        

        img.setImage_list(filename);
        img.setTarget_id(com.getCommunity_id());  
        img.setTarget_type("COMMUNITY");
        imgDAO.img_insert(img);
        
        return "redirect:/list.do";

    }

    //커뮤니티 조회 함수
    @GetMapping ("/community_view")
    public String communityView( 
            int community_id,
            @RequestParam(defaultValue = "1") int page,
            Model model ){

        CommunityVO community = communityDAO.communitySelect( community_id );

        if (community == null) {
            return "redirect:/list.do";
        }

        ImgVO img = imgDAO.img_select(community_id, "COMMUNITY");

        // 댓글 불러오기
        int count = commentDAO.commentCount(community_id, "COMMUNITY");
        Paging paging = new Paging(page, 5, count);

        Map<String, Object> map = new HashMap<>();
        map.put("target_id",community_id);
        map.put("target_type","COMMUNITY");
        map.put("size",paging.getSize());
        map.put("offset",paging.getOffset());
       
        List<CommentVO> list = commentDAO.getListPaging(map);

        model.addAttribute("community", community);
        model.addAttribute("img",img);
        model.addAttribute("list",list);
        model.addAttribute("count", count);
        model.addAttribute("paging", paging);

        return "community/community_view";

    }

    // 게시글 수정 페이지 이동 함수
    @GetMapping ("/community_modify")
    public String communityModify( Model model, int community_id){

        CommunityVO community = communityDAO.communitySelect( community_id );

        if (community == null) {
            return "redirect:/list.do";
        }

        ImgVO img = imgDAO.img_select(community_id, "COMMUNITY");

        model.addAttribute("community", community);
        model.addAttribute("img",img);
        model.addAttribute("mode","edit");

        return "community/community_insertform";

    }

    // 게시글 수정 함수
    @PostMapping ("/community_update")
    @ResponseBody 
    public  Map<String,Object> communityUpdateFin( CommunityVO community, 
        @RequestParam (value = "deletePhotos", required = false) List<String> delettePhotos) throws Exception{

        Map<String,Object> map = new HashMap<>();
      
        ImgVO img = imgDAO.img_select(community.getCommunity_id(), "COMMUNITY");

        String remainFiles = "";
        
        if (img != null){
            remainFiles = fileupload.deleteSelectFiles(img.getImage_list(), delettePhotos,"community");
        }

        String newFiles =
            fileupload.saveFiles(community.getPhoto(), "community");
        
        if (remainFiles == null) {
            remainFiles = "";
        }    

        if (newFiles != null && !newFiles.isEmpty()) {
            if(remainFiles.isEmpty()){
                remainFiles = newFiles;
            } else {
                remainFiles += "," + newFiles;
            }
        }

        if(img !=null){
            img.setImage_list(remainFiles);
            imgDAO.img_update(img);
        } else if( !remainFiles.isEmpty()) {
            img = new ImgVO();
            img.setTarget_id(community.getCommunity_id());
            img.setTarget_type("COMMUNITY");
            img.setImage_list(remainFiles);
            imgDAO.img_insert(img);
        }
        int result = communityDAO.communityUpdate( community );
        
        map.put("result", result);

        return map;

    }

    //커뮤니티 삭제
    @PostMapping("/community/delete")
    @ResponseBody 
    public Map<String, Object> communityDelete( int community_id ) {
        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        if (user == null) {
            return Map.of("result", 0);
        }

        CommunityVO community = new CommunityVO();
        community.setCommunity_id(community_id);
        community.setMember_id(user.getMember_id());

        int result = communityDAO.communityDelete(community);

        return Map.of("result", result);
    }


}

