package com.mmall.controller;

import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.dto.DeptLevelDto;
import com.mmall.model.SysUser;
import com.mmall.model.Training;
import com.mmall.param.DeptParam;
import com.mmall.param.TrainingParam;
import com.mmall.service.SysDeptService;
import com.mmall.service.TrainingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.ParseException;

@Controller
@RequestMapping("/sys/training")
@Slf4j
public class TrainingController {

    @Resource
    private TrainingService trainingService;

    @RequestMapping("training.page")
    public ModelAndView page() {
        return new ModelAndView("training");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveTraining(TrainingParam param) throws ParseException {
        trainingService.save(param);
        return JsonData.success();
    }

    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateTraining(TrainingParam param) throws ParseException {
        trainingService.update(param);
        return JsonData.success();
    }

    @RequestMapping("/page.json")
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Training> result = trainingService.getPage(pageQuery);
        return JsonData.success(result);
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        trainingService.delete(id);
        System.out.print("aaaaaa="+JsonData.success().toMap());
        return JsonData.success();
    }
}
