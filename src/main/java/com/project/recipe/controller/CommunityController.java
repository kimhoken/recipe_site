package com.project.recipe.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.recipe.common.Fileupload;
import com.project.recipe.dao.CommunityDAO;
import com.project.recipe.dao.ImgDAO;
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

        return "community/community_insertform";
    }

    //커뮤니티 작성 함수
    @PostMapping ("/community_insert")
    public String communityInsertFin( CommunityVO com ) throws Exception{

        String savePath = "commuity";
        List<MultipartFile> photos = com.getPhoto();

        String filename = fileupload.saveFiles(photos, savePath);

        ImgVO img = new ImgVO();

        communityDAO.communityInsert( com );        

        img.setImage_list(filename);
        img.setTarget_id(com.getCommunity_id());  
        img.setTarget_type("COMMUITY");
        imgDAO.img_insert(img);
        
        return "redirect:/list.do";

    }

    //커뮤니티 조회 함수
    @GetMapping ("/community_view")
    public String communityView( int community_id, Model model ){

        CommunityVO community = communityDAO.communitySelect( community_id);

        model.addAttribute("community", community);

        return "community/community_view";

    }

}
