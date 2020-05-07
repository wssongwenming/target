package com.mmall.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;

import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

public class ResponseFileUtil {
	public static void response(File file, HttpServletResponse response) throws IOException {
        String mimeType= URLConnection.guessContentTypeFromName(file.getName());
        if(mimeType==null){
            //mimetype is not detectable, will take default
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        
        String encodedFilename = new String(file.getName().getBytes("UTF-8"),"ISO8859-1") ;
        // "Content-Disposition : inline" will show viewable types [like images/text/pdf/anything viewable by browser] 
        // right on browser while others(zip e.g) will be directly downloaded 
        // [may provide save as popup, based on your browser setting.]
        response.setHeader("Content-Disposition", String.format("inline; filename=\"" + encodedFilename +"\""));
         
        /* "Content-Disposition : attachment" will be directly download, may provide save as popup, based on your browser setting*/
        //response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
         
        response.setContentLength((int)file.length());
 
        InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
 
        //Copy bytes from source to destination(outputstream in this example), closes both streams.
        FileCopyUtils.copy(inputStream, response.getOutputStream());		
	}
}
