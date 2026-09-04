package com.project.recipe.common;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;



@Component
public class Fileupload {

    // 업로드 주소 불러오기 
    // 윈도우 경로 C:/Users/사용자명/foodsite
    // 
    @Value("${file.upload.path}")
    private String uploadPath;
    
    // 파일 저장 함수
    public String saveFile(MultipartFile file, String folder) throws Exception{

        if(file == null || file.isEmpty()){
            return null;
        }

        //예) C:/upload/recipe/
        File dir = new File(uploadPath, folder);

        if(!dir.exists()){
            dir.mkdirs();
        }

        String filename = file.getOriginalFilename();
        File saveFile = new File(dir, filename);

        if(saveFile.exists()){
            filename = System.currentTimeMillis() + "_" + filename;
            saveFile = new File(dir, filename);            
        }

        file.transferTo(saveFile);

        return filename;

    }


    // 파일 제거 함수
    public void deleteFile(String filename, String folder){
        
        if (filename == null || filename.equals("no_file.png")){
            return;
        }

        File file = new File(uploadPath + "/" + folder, filename);

        if(file.exists()){
            file.delete();
        }

    }
    
    // 여러 이미지 파일 저장 함수 
    public String saveFiles(List<MultipartFile> files, String folder) throws Exception{

        List<String> filenames = new ArrayList<>();


        if( files == null || files.isEmpty()){
            return null;
        } 

        for(MultipartFile file : files){

            if(file == null || file.isEmpty()){
                continue;
            }

            filenames.add(saveFile(file, folder));

        }
        return String.join(",", filenames);

    }

    // 여러 이미지 파일 제거 함수
    public void deleteFiles(String filenames, String folder){

        if(filenames == null || filenames.isEmpty()){
            return;
        }

        List<String> fileList = Arrays.asList(filenames.split(","));

        for( String filename : fileList){
            deleteFile(filename.trim(), folder);
        }

    }

    // 파일 선택 삭제
    public String deleteSelectFiles(String image_list, List<String> deleteList, String folder){

        if(image_list == null || image_list.isEmpty()){
            return null;
        }

        if(deleteList == null || deleteList.isEmpty()){
            return null;
        }

        List<String> currentList = new ArrayList<>( Arrays.asList(image_list.split(",")) );

        for( String deletename : deleteList ){

            if(deletename == null || deletename.isEmpty()){
                continue;
            }

            String target = deletename.trim();
            
            deleteFile(deletename, folder);
            currentList.remove(target);
        }

        if ( currentList.isEmpty() ){
            return null;
        }

        return String.join(",", currentList );

    } 


}
