package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.Target;
import com.mmall.model.Trainee_Group;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Trainee_GroupMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Trainee_Group record);

    int insertSelective(Trainee_Group record);

    Trainee_Group selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Trainee_Group record);

    int updateByPrimaryKey(Trainee_Group record);

    int countByGroupNumber(@Param("groupNumber") Integer groupNumber, @Param("id") Integer id);

    int deleteAll();
    int count();
    List<Trainee_Group> getPage(@Param("page") PageQuery page);
    List<Trainee_Group> getAll();
    Trainee_Group getTraineeGroupInShooting();
    Trainee_Group getTraineeGroupNext();
    int changeShootingTrainee();
    int changeShootedTrainee();
}