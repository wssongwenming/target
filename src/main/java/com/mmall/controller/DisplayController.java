package com.mmall.controller;

import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.model.Camera;
import com.mmall.model.Display;
import com.mmall.param.DisplayParam;
import com.mmall.service.DisplayService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.ParseException;
@Controller
@RequestMapping("sys/display")
@Slf4j
public class DisplayController {
    @Resource
    private DisplayService displayService;
    @RequestMapping("display.page")
    public ModelAndView page() {
        return new ModelAndView("display");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveDisplay(DisplayParam param) throws ParseException {
        displayService.save(param);
        return JsonData.success();
    }
    @RequestMapping("/page.json")//
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Display> result = displayService.getPage(pageQuery);
        return JsonData.success(result);
    }
    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        displayService.delete(id);
        return JsonData.success();
    }

    @RequestMapping("/display.json")//
    @ResponseBody
    public JsonData getAll() {
        PageResult<Display> result = displayService.getAll();
        return JsonData.success(result);
    }
    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateDisplay(DisplayParam param) throws ParseException {
        displayService.update(param);
        return JsonData.success();
    }
}
