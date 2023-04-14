package com.kh3.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class UploadFile {

    public static List<String> fileUpload(MultipartHttpServletRequest mRequest, String thisFolder, String saveName) {
        int count = 1;
        List<String> uploadList = new ArrayList<String>();


        // 저장 폴더 경로
        String saveFolder = mRequest.getSession().getServletContext().getRealPath(thisFolder);


        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if (!dirChk.exists()) {
            dirChk.mkdir();
        }


        // 업로드 파일 목록 처리
        Iterator<String> fileList = mRequest.getFileNames();
        while(fileList.hasNext()) {
            MultipartFile thisFile = mRequest.getFile(fileList.next());
            if(thisFile.isEmpty() == false){
                try {
                    // 파일 이름 정리
                    String uploadFileExt = FilenameUtils.getExtension(thisFile.getOriginalFilename());
                    String uploadFileName = saveName + "_" + count + "_" + System.currentTimeMillis() + "." + uploadFileExt;
                    File completeFilePath = new File(saveFolder + uploadFileName);
    
                    // 실제 파일 이동
                    thisFile.transferTo(completeFilePath);
    
                    // 업로드 완료 리스트에 추가
                    uploadList.add(thisFolder + uploadFileName);
    
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }else{
                uploadList.add("");
            }

            count++;
        }

        return uploadList;
    }

}