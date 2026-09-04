package com.project.recipe.common;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class NicknameGenerater {

    public String createnickname() {
        String[] names = { "말랑포동푸딩", "단짠단짠솔트카라멜", "매콤바삭지코바", "치즈이불페페로니", "갓구운소금빵", "꾸덕초코브라우니",
                "얼죽아자바칩", "겉바속촉까눌레","시나몬폴폴츄러스", "명란마요삼각김밥", "뜨끈뜨끈콘스프", "바질토마토에이드", "말차샷라떼",
                "폭신폭신수플레", "찰떡아이스", "망고치즈설빙", "바삭달콤탕후루", "보글보글부대찌개", "와사비마요새우", "달콤쫀득까르보나라" };
        
        Random rand = new Random();
        
        String randonname = String.format("%s%d", names[rand.nextInt(names.length)], rand.nextInt(9999));

        
        return randonname;
    }

}
