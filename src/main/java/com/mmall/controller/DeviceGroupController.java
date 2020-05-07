package com.mmall.controller;

import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.model.Device_Group;
import com.mmall.model.Display;
import com.mmall.param.DeviceGroupParam;
import com.mmall.param.DisplayParam;
import com.mmall.service.DeviceGroupService;
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
@RequestMapping("/sys/devicegroup")
@Slf4j
public class DeviceGroupController {
    @Resource
    private DeviceGroupService deviceGroupService;
    @RequestMapping("/devicegroup.page")
    public ModelAndView page() {
        return new ModelAndView("devicegroup");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveDeviceGroup(DeviceGroupParam param) throws ParseException {
        deviceGroupService.save(param);
        return JsonData.success();
    }
    @RequestMapping("/page.json")//
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Device_Group> result = deviceGroupService.getPage(pageQuery);
        return JsonData.success(result);
    }
    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        deviceGroupService.delete(id);
        return JsonData.success();
    }

    @RequestMapping("/devicegroup.json")//
    @ResponseBody
    public JsonData getAll() {
        PageResult<Device_Group> result = deviceGroupService.getAll();
        return JsonData.success(result);
    }
    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateDisplay(DeviceGroupParam param) throws ParseException {
        deviceGroupService.update(param);
        return JsonData.success();
    }
}
