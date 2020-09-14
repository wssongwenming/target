package com.mmall.dao;

import com.mmall.model.Scores;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface ScoresMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Scores record);

    int insertSelective(Scores record);

    Scores selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Scores record);

    int updateByPrimaryKey(Scores record);

    List<Scores> getByTraineeId(Integer traineeId);

    int count(@Param("traineeId")Integer traineeId);

    int deleteByTraineeId(Integer traineeId);

    BigDecimal getScoresSumByTraineeId(Integer traineeId);

}