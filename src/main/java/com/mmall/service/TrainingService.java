package com.mmall.service;

import com.google.common.base.Preconditions;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.RequestHolder;
import com.mmall.dao.SysUserMapper;
import com.mmall.dao.TraineeMapper;
import com.mmall.dao.TrainingMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.*;
import com.mmall.param.RoleParam;
import com.mmall.param.TrainingParam;
import com.mmall.util.BeanValidator;
import com.mmall.util.IpUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Service
public class TrainingService {
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    @Resource
    private TrainingMapper trainingMapper;

    @Resource
    private SysUserMapper sysUserMapper;

    @Resource
    private TraineeMapper traineeMapper;

    @Resource
    private SysLogService sysLogService;

    public void save(TrainingParam param) throws ParseException {

        BeanValidator.check(param);
        if (checkExist(param.getTitle())) {
            throw new ParamException("训练计划名称称已经存在");
        }
        Training training = Training.builder().title(param.getTitle()).orgDept(param.getOrgDept()).dot(format.parse(param.getDot()))
                .addr(param.getAddr()).traineeNumber(param.getTraineeNumber()).gun(param.getGun()).bulletNumber(param.getBulletNumber()).memo(param.getMemo()).build();
        trainingMapper.insertSelective(training);
    }

    public void update(TrainingParam param) throws ParseException {
        BeanValidator.check(param);
        Training before = trainingMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before, "待更新的训练计划不存在");

        Training after = Training.builder().id(param.getId()).title(param.getTitle()).orgDept(param.getOrgDept()).dot(format.parse(param.getDot()))
                .addr(param.getAddr()).traineeNumber(param.getTraineeNumber()).gun(param.getGun()).bulletNumber(param.getBulletNumber()).memo(param.getMemo()).build();
        trainingMapper.updateByPrimaryKeySelective(after);

    }
    public void delete(int trainingId) {
        Training training = trainingMapper.selectByPrimaryKey(trainingId);
        Preconditions.checkNotNull(training, "待删除的训练计划不存在，无法删除");

        if (sysUserMapper.countByTrainingId(trainingId) > 0) {//检查当前训练计划下有没有系统用户(sys_user)
            throw new ParamException("当前训练计划下有关联的系统用户，无法删除");
        }

        if (traineeMapper.countByTrainingId(trainingId) > 0) {//检查当前训练计划下有没有参训人员(trainee)
            throw new ParamException("当前训练计划下有关联的参训用户，无法删除");
        }
        //TODO 删除时判断有没有依赖数据
        /*if (sysDeptMapper.countByParentId(dept.getId()) > 0) {
            throw new ParamException("当前部门下面有子部门，无法删除");
        }
        if(sysUserMapper.countByDeptId(dept.getId()) > 0) {
            throw new ParamException("当前部门下面有用户，无法删除");
        }*/
        trainingMapper.deleteByPrimaryKey(trainingId);
    }
    private boolean checkExist(String title) {
        return trainingMapper.countByName(title) > 0;
    }


    public PageResult<Training> getPage(PageQuery page) {
        BeanValidator.check(page);
        int count = trainingMapper.countAll();
        if (count > 0) {
            List<Training> list = trainingMapper.getPage(page);
            return PageResult.<Training>builder().total(count).data(list).build();
        }
        return PageResult.<Training>builder().build();
    }
    public Training getTrainingById(Integer trainingId){
        Training training=trainingMapper.selectByPrimaryKey(trainingId);
        return  training;
    }
}
