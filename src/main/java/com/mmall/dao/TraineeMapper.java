package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.SysUser;
import com.mmall.model.Trainee;
import com.mmall.model.Training;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TraineeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Trainee record);

    int insertSelective(Trainee record);

    Trainee selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Trainee record);

    int updateByPrimaryKey(Trainee record);

    int countByTrainingId(@Param("trainingId") int trainingId);

    int countByPhone(@Param("phone") String phone,@Param("id") Integer id);

    List<Trainee> getPageByTrainingId(@Param("trainingId") int trainingId, @Param("page") PageQuery page);

    List<Integer> getTraineeIds(@Param("trainingId") int trainingId);

    int countAll(@Param("trainingId") int trainingId);
    int countFinishedShooting (@Param("trainingId") int trainingId);
    int countAbsentShooting (@Param("trainingId") int trainingId);
    int countNotShooting (@Param("trainingId") int trainingId);

}