/*
package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.service.ResourceService;
import com.mmall.service.TraineeService;
import com.mmall.util.MD5Util;
import com.mmall.util.ResponseFileUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

@Controller
@RequestMapping("/sys/file1")
@Slf4j
public class FileUploadController1 {

    @Resource
    private TraineeService traineeService;

    @Resource
    private ResourceService resourceService;

    @RequestMapping(path="/upload",method = RequestMethod.POST, consumes = { "multipart/form-data","multipart/mixed" })
    @ResponseBody
    public JsonData UploadPhoto(@RequestPart("photo_file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws ParseException {
        String fileName=file.getOriginalFilename();//获取文件名加后缀
        File targetFile=null;
        if(fileName!=null&&fileName!=""){
            //String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/upload/imgs/";//存储路径
            //String path = request.getSession().getServletContext().getRealPath("upload/imgs"); //文件存储位置
            //String path="d:/upload/";
            String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
            fileName=new Date().getTime()+"_"+new Random().nextInt(10000)+suffix;//新的文件名

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String fileAddDate = sdf.format(new Date());

            //获取文件夹路径
            File file1 =new File("d:/upload/photo"+"/"+fileAddDate);
            //如果文件夹不存在则创建
            if(!file1 .exists()  && !file1 .isDirectory()){
                file1 .mkdirs();
            }
            //将图片存入文件夹
            targetFile = new File(file1, fileName);
            try {

                //将上传的文件写到服务器上指定的文件。
                file.transferTo(targetFile);

                System.out.println("path="+targetFile.getPath());
                System.out.println("abpath="+targetFile.getAbsolutePath());

            } catch (Exception e) {
                e.printStackTrace();

            }
        }
        String photoPath=targetFile.getPath();
        photoPath=photoPath.replace("\\upload\\photo", "");
        photoPath="\\sys\\file\\"+photoPath;
        photoPath=photoPath.replace(".","\\");
        return JsonData.success(photoPath);
    }

    @RequestMapping(path="/uploadExcel/{trainingId}",method = RequestMethod.POST, consumes = { "multipart/form-data","multipart/mixed" })
    @ResponseBody
    public JsonData UploadExcel(@RequestPart("excel_file") MultipartFile file,@PathVariable("trainingId") int trainingId, HttpServletRequest request, HttpServletResponse response) throws ParseException {
        // 判断文件是否为空
        String flag = "02";//上传标志
        if (!file.isEmpty()) {
            try {
                InputStream inputStream=file.getInputStream();
                ArrayList<Object> arrayList = new ArrayList<Object>();
                String originalFilename = file.getOriginalFilename();//原文件名字
                String suffix = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
                if (!"xlsx".equals(suffix) && !"xls".equals(suffix)) {
                    System.out.println("请传入excel文件");
                }
                if ("xlsx".equals(suffix)) {
                    xlsxImp(inputStream, arrayList,trainingId);
                }
                if ("xls".equals(suffix)) {
                    xlsImp(inputStream, arrayList,trainingId);
                }
                flag = traineeService.writeExelData(arrayList);

            } catch (Exception e) {

                flag="03";//上传出错

                e.printStackTrace();

            }

        }
        return JsonData.success(flag);
    }

    private void xlsImp(InputStream inputStream, ArrayList<Object> arrayList,Integer trainingId) throws IOException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy\\MM\\dd");
        String fileAddDate = sdf.format(new Date());
        // 初始整个Excel
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        // 获取第一个sheet表
        HSSFSheet sheet = workbook.getSheetAt(0);
        for (int rowIndex = 1; rowIndex < sheet.getLastRowNum(); rowIndex++) {
            HashMap<String, Object> hashMap = new HashMap<String, Object>();
            HSSFRow row = sheet.getRow(rowIndex);
            //整行都为空去掉
            if(row==null) {
                continue;
            }
            for (int cellIndex = 0; cellIndex < row.getLastCellNum(); cellIndex++) {
                HSSFCell cell = row.getCell(cellIndex);
                if(cell==null) {
                    hashMap.put(getKey(cellIndex), " ");
                    continue;
                }else{
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    String cellValue=cell.getStringCellValue();
                    hashMap.put(getKey(cellIndex), cellValue);
                }
             }
            hashMap.put("status","1");
            hashMap.put("password",MD5Util.encrypt("1234"));
            hashMap.put("trainingid",trainingId);
            hashMap.put("photo","\\sys\\file\\"+fileAddDate+"\\"+hashMap.get("name")+"\\jpg");
            arrayList.add(hashMap);
        }
    }

    private void xlsxImp(InputStream inputStream, ArrayList<Object> arrayList,Integer trainingId) throws IOException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy\\MM\\dd");
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String fileAddDate = sdf.format(new Date());

        //获取文件夹路径
        File file1 =new File("d:/upload/photo"+"/"+fileAddDate);
        //如果文件夹不存在则创建
        if(!file1 .exists()  && !file1 .isDirectory()){
            file1 .mkdirs();
        }
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(inputStream);
        XSSFSheet sheet = xssfWorkbook.getSheetAt(0);
        for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
            HashMap<String, Object> hashMap = new HashMap<String, Object>();
            XSSFRow row = sheet.getRow(rowIndex);
            //整行都为空去掉
            if(row==null) {
                continue;
            }
            for (int cellIndex = 0; cellIndex < row.getLastCellNum(); cellIndex++) {
                XSSFCell cell = row.getCell(cellIndex);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                 hashMap.put(getKey(cellIndex), cell.getStringCellValue());
            }
            hashMap.put("status","1");
            hashMap.put("password",MD5Util.encrypt("1234"));
            hashMap.put("trainingid",trainingId);
            hashMap.put("photo","\\sys\\file\\"+"d:\\"+fileAddDate+"\\"+hashMap.get("name")+"\\jpg");
            arrayList.add(hashMap);
        }
    }
    public static String getKey(int cell) {
        String result = null;
        switch (cell) {
            case 0:
                result="name";
                break;
            case 1:
                result="workunit";
                break;
            case 2:
                result="phone";
                break;
            case 3:
                result="memo";
                break;
            default:
                break;
        }
        return result;
    }

    @RequestMapping(value = "/{driver}/{year}/{month}/{day}/{imagename}/{suffix}")
    public void downloadFile(HttpServletResponse response,@PathVariable("driver") String driver,@PathVariable("year") String year,@PathVariable("month") String month,@PathVariable("day") String day, @PathVariable("imagename") String imagename,@PathVariable("suffix") String suffix) throws IOException {

        String path=driver+"/upload/photo/"+year+"/"+month+"/"+day+"/"+imagename+"."+suffix;
        System.out.print(path);
        File file = resourceService.findFile(path);
        if (file == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } else {
            ResponseFileUtil.response(file, response);
        }
    }


 */
/*   @RequestMapping(path="/upload",method = RequestMethod.POST, consumes = { "multipart/form-data","multipart/mixed" })
    @ResponseBody*//*

   */
/* public JsonData UploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("UTF-8");

        Map<String, Object> json = new HashMap<String, Object>();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        *//*
*/
/** 页面控件的文件流* *//*
*/
/*
        MultipartFile multipartFile = null;
        Map map =multipartRequest.getFileMap();
        for (Iterator i = map.keySet().iterator(); i.hasNext();) {
            Object obj = i.next();
            multipartFile=(MultipartFile) map.get(obj);
        }
        *//*
*/
/** 获取文件的后缀* *//*
*/
/*
        String filename = multipartFile.getOriginalFilename();
        InputStream inputStream;
        String path = "";
        String newVersionName = "";
        String fileMd5 = "";
        try {

            inputStream = multipartFile.getInputStream();
            File tmpFile = File.createTempFile(filename,
                    filename.substring(filename.lastIndexOf(".")));
            fileMd5 = Files.hash(tmpFile, Hashing.md5()).toString();
            FileUtils.copyInputStreamToFile(inputStream, tmpFile);

            tmpFile.delete();

        } catch (Exception e) {
            e.printStackTrace();
        }
        json.put("newVersionName", newVersionName);
        json.put("fileMd5", fileMd5);
        json.put("message", "应用上传成功");
        json.put("status", true);
        json.put("filePath", path);

        return JsonData.success(json);
    }*//*


}
*/
