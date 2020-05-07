package com.mmall.controller;

import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.model.Camera;
import com.mmall.model.SysUser;
import com.mmall.param.CameraParam;
import com.mmall.param.TraineeParam;
import com.mmall.service.CameraService;
import com.mmall.service.SysUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.ParseException;

@Controller
@RequestMapping("sys/camera")
@Slf4j
public class CameraController {
    @Resource
    private CameraService cameraService;
    @RequestMapping("/camera.page")
    public ModelAndView page() {
        return new ModelAndView("camera");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveCamera(CameraParam param) throws ParseException {
        cameraService.save(param);
        return JsonData.success();
    }
    @RequestMapping("/page.json")//
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Camera> result = cameraService.getPage(pageQuery);
        return JsonData.success(result);
    }

    @RequestMapping("/camera.json")//
    @ResponseBody
    public JsonData getAll() {
        PageResult<Camera> result = cameraService.getAll();
        return JsonData.success(result);
    }
    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        cameraService.delete(id);
        return JsonData.success();
    }
    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateCamera(CameraParam param) throws ParseException {
        cameraService.update(param);
        return JsonData.success();
    }

}
