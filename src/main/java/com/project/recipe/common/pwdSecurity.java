package com.project.recipe.common;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class pwdSecurity {
    
    private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    //비밀번호 암호화와 복호화
    public String pwdEncoding( String pwd ){
        String encodePwd = encoder.encode(pwd);
        return encodePwd;
    }

    public boolean pwdDecoding( String currPwd, String oriPwd ){

        boolean isVailed = BCrypt.checkpw(currPwd, oriPwd);
        return isVailed;
    }

}
