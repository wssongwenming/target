package com.mmall.controller;

import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.model.Camera;
import com.mmall.model.Target;
import com.mmall.param.CameraParam;
import com.mmall.param.TargetParam;
import com.mmall.service.CameraService;
import com.mmall.service.TargetService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.ParseException;

@Controller
@RequestMapping("sys/target")
@Slf4j
public class TargetController {
    @Resource
    private TargetService targetService;
    @RequestMapping("target.page")
    public ModelAndView page() {
        return new ModelAndView("target");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveTarget(TargetParam param) throws ParseException {
        targetService.save(param);
        return JsonData.success();
    }
    @RequestMapping("/page.json")//
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Target> result = targetService.getPage(pageQuery);
        return JsonData.success(result);
    }
    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        targetService.delete(id);
        return JsonData.success();
    }
    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateTarget(TargetParam param) throws ParseException {
        targetService.update(param);
        return JsonData.success();
    }
    @RequestMapping("/target.json")//
    @ResponseBody
    public JsonData getAll() {
        PageResult<Target> result =targetService.getAll();
        return JsonData.success(result);
    }

}
