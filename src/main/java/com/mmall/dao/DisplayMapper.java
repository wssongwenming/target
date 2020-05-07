package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.Camera;
import com.mmall.model.Display;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DisplayMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Display record);

    int insertSelective(Display record);

    Display selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Display record);

    int updateByPrimaryKey(Display record);

    int countByIp(@Param("ip") String ip, @Param("id") Integer id);

    int countByMac(@Param("mac") String mac, @Param("id") Integer id);

    int countByNumber(@Param("number") Integer number, @Param("id") Integer id);

    int countByDeviceIndex(@Param("device_index") Integer device_index, @Param("id") Integer id);

    int count();

    List<Display> getPage(@Param("page") PageQuery page);

    List<Display> getAll();

    Display selectByIndex(@Param("device_index")Integer index);


}