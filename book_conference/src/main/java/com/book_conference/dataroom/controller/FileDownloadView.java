package com.book_conference.dataroom.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView{

    public FileDownloadView(){
        setContentType("apllication/download; charset=utf-8");
    }
    @Override
	protected void renderMergedOutputModel(Map<String, Object> model,
    		HttpServletRequest request, HttpServletResponse response) throws Exception {
        // TODO Auto-generated method stub
        File file = (File) model.get("downloadFile");
        File downloadFilename = (File) model.get("downloadFilename");
        String fileName="";
		try{
		 fileName = URLEncoder.encode(downloadFilename.getName(),"UTF-8");
		}
		catch(Exception e){
		  fileName = URLEncoder.encode(file.getName(),"UTF-8");
		}finally{
		}
        response.setContentType(getContentType());
        response.setContentLength((int) file.length());
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";"); 
        response.setHeader("Content-Transfer-Encoding", "binary");
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(fis != null) {
                try { 
                    fis.close(); 
                }catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        out.flush();
    }
}