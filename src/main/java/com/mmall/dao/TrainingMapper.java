package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.SysUser;
import com.mmall.model.Training;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TrainingMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Training record);

    int insertSelective(Training record);

    Training selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Training record);

    int updateByPrimaryKey(Training record);

    int countByName(@Param("title") String title);

    int countAll();

    List<Training> getPage(@Param("page") PageQuery page);


}