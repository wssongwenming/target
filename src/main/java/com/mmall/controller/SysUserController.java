package com.mmall.controller;

import com.google.common.collect.Maps;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.JsonData;
import com.mmall.model.SysUser;
import com.mmall.param.UserParam;
import com.mmall.service.SysRoleService;
import com.mmall.service.SysTreeService;
import com.mmall.service.SysUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/sys/user")
public class SysUserController {

    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysTreeService sysTreeService;
    @Resource
    private SysRoleService sysRoleService;

    @RequestMapping("/noAuth.page")
    public ModelAndView noAuth() {
        return new ModelAndView("noAuth");
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveUser(UserParam param) {
        sysUserService.save(param);
        return JsonData.success();
    }

    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateUser(UserParam param) {
        sysUserService.update(param);
        return JsonData.success();
    }

    @RequestMapping("/page.json")//以部门过滤用户
    @ResponseBody
    public JsonData page(@RequestParam("deptId") int deptId, PageQuery pageQuery) {
        PageResult<SysUser> result = sysUserService.getPageByDeptId(deptId, pageQuery);
        return JsonData.success(result);
    }


    @RequestMapping("/pageByAll.json")//以训练计划和部门两个条件过滤用户
    @ResponseBody
    public JsonData pageByAll(@RequestParam("deptId") int deptId,@RequestParam("trainingId") int trainingId, PageQuery pageQuery) {
        PageResult<SysUser> result = sysUserService.getPageByDeptandTrainingId(deptId,trainingId, pageQuery);
        return JsonData.success(result);
    }


    @RequestMapping("/pageByTrainingId.json")//以训练计划过滤用户
    @ResponseBody
    public JsonData pageByTrainingId(@RequestParam("trainingId") int trainingId, PageQuery pageQuery) {
        PageResult<SysUser> result = sysUserService.getPageByTrainingId(trainingId, pageQuery);
        return JsonData.success(result);
    }


    @RequestMapping("/acls.json")
    @ResponseBody
    public JsonData acls(@RequestParam("userId") int userId) {
        Map<String, Object> map = Maps.newHashMap();
        map.put("acls", sysTreeService.userAclTree(userId));
        map.put("roles", sysRoleService.getRoleListByUserId(userId));
        return JsonData.success(map);
    }
    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        sysUserService.deleteById(id);
        return JsonData.success();
    }
}
