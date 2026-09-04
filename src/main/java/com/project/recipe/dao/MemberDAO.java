package com.project.recipe.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.recipe.dto.AdminMemberDTO;
import com.project.recipe.dto.MemberDTO;
import com.project.recipe.vo.MemberVO;

@Mapper 
public interface MemberDAO {
    
    int userInsert(MemberVO vo);
        
    MemberVO getUser( MemberDTO member );

    MemberVO getUserByMemberId(int member_id);

    int userPwdUpdate(MemberVO vo);

    int userUpdate(MemberVO vo);

    MemberVO getSocialUser(String provider,String provider_id);

    int secessionUser( MemberVO vo);

    int memberCount();

    List<MemberVO> MemberSearch( AdminMemberDTO admin );

    AdminMemberDTO memberDetail( int member_id );

    int relaseSuspend( int member_id );
    
} 