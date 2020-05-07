package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.Camera;
import com.mmall.model.Target;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TargetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Target record);

    int insertSelective(Target record);

    Target selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Target record);

    int updateByPrimaryKey(Target record);

    int countByIp(@Param("ip") String ip, @Param("id") Integer id);

    int countByMac(@Param("mac") String mac, @Param("id") Integer id);

    int countByNumber(@Param("number") Integer number, @Param("id") Integer id);

    int countByDeviceIndex(@Param("device_index") Integer device_index, @Param("id") Integer id);

    int count();

    List<Target> getPage(@Param("page") PageQuery page);

    List<Target> getAll();

    Target selectByIndex(@Param("device_index")Integer index);


}