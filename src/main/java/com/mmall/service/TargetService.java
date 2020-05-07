package com.mmall.service;

import com.google.common.base.Preconditions;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.dao.TargetMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.Camera;
import com.mmall.model.Display;
import com.mmall.model.Target;
import com.mmall.param.CameraParam;
import com.mmall.param.TargetParam;
import com.mmall.util.BeanValidator;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.List;

@Service
public class TargetService {
    @Resource
    private TargetMapper targetMapper;
    public void save(TargetParam param) throws ParseException {

        BeanValidator.check(param);
        if (checkExistByIp(param.getIp(),param.getId())) {
            throw new ParamException("设备IP地址已经存在");
        }
        if (checkExistByMac(param.getMac(),param.getId())) {
            throw new ParamException("设备MAC地址已经存在");
        }
        if (checkExistByNumber(param.getNumber(),param.getId())) {
            throw new ParamException("设备IP地址已经存在");
        }
        Target target = Target.builder().name(param.getName()).mac(param.getMac()).ip(param.getIp())
                .status(param.getStatus()).number(param.getNumber()).device_index(param.getDevice_index()).memo(param.getMemo()).build();
        targetMapper.insertSelective(target);
    }
    public PageResult<Target> getPage(PageQuery page) {
        BeanValidator.check(page);
        int count = targetMapper.count();
        if (count > 0) {
            List<Target> list = targetMapper.getPage(page);
            return PageResult.<Target>builder().total(count).data(list).build();
        }
        return PageResult.<Target>builder().build();
    }

    public Target getTargetById(Integer id){
        return targetMapper.selectByPrimaryKey(id);
    }

    public Target getTargetByIndex(Integer index){
        return targetMapper.selectByIndex(index);
    }
    public void delete(int targetId) {
        Target target = targetMapper.selectByPrimaryKey(targetId);
        Preconditions.checkNotNull(target, "待删除的训练计划不存在，无法删除");

        //TODO 删除时判断有没有依赖数据,比如打靶成绩
        targetMapper.deleteByPrimaryKey(targetId);
    }
    public void update(TargetParam param) throws ParseException {
        BeanValidator.check(param);
        if (checkExistByIp(param.getIp(),param.getId())) {
            throw new ParamException("设备IP地址已经存在");
        }
        if (checkExistByMac(param.getMac(),param.getId())) {
            throw new ParamException("设备MAC地址已经存在");
        }
        if (checkExistByNumber(param.getNumber(),param.getId())) {
            throw new ParamException("设备IP地址已经存在");
        }
        if (checkExistByIndex(param.getDevice_index(),param.getId())) {
            throw new ParamException("设备编号已经存在");
        }
        Target before = targetMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before, "待更新的设备不存在");

        Target after = Target.builder().id(param.getId()).name(param.getName()).ip(param.getIp())
                .mac(param.getMac()).status(param.getStatus()).device_index(param.getDevice_index()).number(param.getNumber()).memo(param.getMemo()).build();
        targetMapper.updateByPrimaryKeySelective(after);

    }
    public PageResult<Target> getAll() {
        int count = targetMapper.count();
        if (count > 0) {
            List<Target> list = targetMapper.getAll();
            return PageResult.<Target>builder().total(count).data(list).build();
        }
        return PageResult.<Target>builder().build();
    }
    private boolean checkExistByIp(String ip,Integer id) {
        return targetMapper.countByIp(ip,id) > 0;
    }
    private boolean checkExistByMac(String mac,Integer id) {
        return targetMapper.countByMac(mac,id) > 0;
    }
    private boolean checkExistByNumber(Integer number,Integer id) {
        return targetMapper.countByNumber(number,id) > 0;
    }
    private boolean checkExistByIndex(Integer device_index,Integer id) {//设备编号
        return targetMapper.countByDeviceIndex(device_index,id) > 0;
    }
}
