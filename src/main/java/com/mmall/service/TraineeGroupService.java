package com.mmall.service;

import com.google.common.base.Preconditions;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.dao.TargetMapper;
import com.mmall.dao.Trainee_GroupMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.Target;
import com.mmall.model.Trainee;
import com.mmall.model.Trainee_Group;
import com.mmall.param.TargetParam;
import com.mmall.param.TraineeGroupParam;
import com.mmall.util.BeanValidator;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

@Service
public class TraineeGroupService {
    @Resource
    private Trainee_GroupMapper trainee_groupMapper;


    @Resource
    SqlSessionTemplate sqlSessionTemplate;

    public void save(TraineeGroupParam param) throws ParseException {

        BeanValidator.check(param);
        if (checkExistByGroupNumber(param.getGroup_number(),param.getId())) {
            throw new ParamException("分组编号已经存在");
        }

        Trainee_Group trainee_group = Trainee_Group.builder().groupNumber(param.getGroup_number()).
                traineeIds(param.getTrainee_ids()).perStatus(param.getPer_status()).trainingId(param.getTraining_id()).allStatus(param.getAll_status()).build();
        trainee_groupMapper.insertSelective(trainee_group);
    }

    public void deleteAll() {
        trainee_groupMapper.deleteAll();
    }
    public void delete(int groupId) {
        Trainee_Group group = trainee_groupMapper.selectByPrimaryKey(groupId);
        Preconditions.checkNotNull(group, "待删除的编组不存在，无法删除");

        //TODO 删除时判断有没有依赖数据,比如打靶成绩
        trainee_groupMapper.deleteByPrimaryKey(groupId);
    }


    private boolean checkExistByGroupNumber(Integer groupNumber,Integer id) {
        return trainee_groupMapper.countByGroupNumber(groupNumber,id) > 0;
    }

    public void update(TraineeGroupParam param) throws ParseException {
        BeanValidator.check(param);
        if (checkExistByGroupNumber(param.getGroup_number(),param.getId())) {
            throw new ParamException("设备编组已经存在");
        }

        Trainee_Group before = trainee_groupMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before, "待更新的编组不存在");


        Trainee_Group.Trainee_GroupBuilder trainee_groupBuilder=Trainee_Group.builder();
        if(param.getId()!=null)
        {
            trainee_groupBuilder.id(param.getId());
        }
        if(param.getGroup_number()!=null)
        {
            trainee_groupBuilder.groupNumber(param.getGroup_number());
        }
        if(param.getTrainee_ids()!=null)
        {
            trainee_groupBuilder.traineeIds(param.getTrainee_ids());
        }
        if(param.getPer_status()!=null)
        {
            trainee_groupBuilder.perStatus(param.getPer_status());
        }
        if(param.getPer_status()!=null)
        {
            trainee_groupBuilder.perStatus(param.getPer_status());
        }
        if(param.getTraining_id()!=null)
        {
            trainee_groupBuilder.trainingId(param.getTraining_id());
        }
        if(param.getAll_status()!=null)
        {
            trainee_groupBuilder.allStatus(param.getAll_status());
        }

        Trainee_Group after =  trainee_groupBuilder.build();
        trainee_groupMapper.updateByPrimaryKeySelective(after);

    }

    public PageResult<Trainee_Group> getAll() {
        int count = trainee_groupMapper.count();
        if (count > 0) {
            List<Trainee_Group> list = trainee_groupMapper.getAll();
            return PageResult.<Trainee_Group>builder().total(count).data(list).build();
        }
        return PageResult.<Trainee_Group>builder().build();
    }

    public Trainee_Group getTraineeGroupInShooting(){
        return  trainee_groupMapper.getTraineeGroupInShooting();
    }
    public Trainee_Group getTraineeGroupShooted(){
        return  trainee_groupMapper.getTraineeGroupShooted();
    }

    public Trainee_Group getTraineeGroupNext(){
        return  trainee_groupMapper.getTraineeGroupNext();
    }

    public int changeShootingTrainee(){

        int i=trainee_groupMapper.changeShootingTrainee();
        return i;
    }

    public int changeShootedTrainee(){
        int i=trainee_groupMapper.changeShootedTrainee();
        return i;
    }
    public PageResult<Trainee_Group> getPage(PageQuery page) {
        BeanValidator.check(page);
        int count =trainee_groupMapper.count();
        if (count > 0) {
            List<Trainee_Group> list = trainee_groupMapper.getPage(page);
            return PageResult.<Trainee_Group>builder().total(count).data(list).build();
        }
        return PageResult.<Trainee_Group>builder().build();
    }

    public String saveTraineeGroups(List<Object> list){
        Trainee_Group trainee_group;
        SqlSession sqlSession = sqlSessionTemplate.getSqlSessionFactory().openSession(ExecutorType.BATCH, false);//跟上述sql区别
        int size=list.size();
        for (int i = 0; i<size; i++) {
            trainee_group = new Trainee_Group();
/*            trainee.setName((String)((HashMap)list.get(i)).get("name"));
            trainee.setMemo((String)((HashMap)list.get(i)).get("memo"));
            trainee.setPassword((String)((HashMap)list.get(i)).get("password"));
            trainee.setPhone((String)((HashMap)list.get(i)).get("phone"));
            trainee.setStatus(Integer.parseInt(((HashMap)list.get(i)).get("status").toString()));
            trainee.setPhoto((String)((HashMap)list.get(i)).get("photo"));
            trainee.setTrainingId((Integer)((HashMap)list.get(i)).get("trainingid"));
            trainee.setWorkunit((String)((HashMap)list.get(i)).get("workunit"));*/
            //traineeMapper.insertSelective(trainee);
        }
        sqlSession.commit();

        return "ok";
    }

    public  int getTraineeGroupCount(){
        return trainee_groupMapper.count();
    }

    public void startShooting(){//为了避免换靶时，垃圾数据进入先设置一个标识位，所以先借用trainee_group的字段per_status
        trainee_groupMapper.startShooting();
    }
    public void stopShooting(){
        trainee_groupMapper.stopShooting();
    }
    public int getShootingStatus(){
        return trainee_groupMapper.getShootingStatus();

    }
}
