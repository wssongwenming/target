package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.Camera;
import com.mmall.model.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CameraMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Camera record);

    int insertSelective(Camera record);

    Camera selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Camera record);

    int updateByPrimaryKey(Camera record);

    int countByIp(@Param("ip") String ip, @Param("id") Integer id);

    int countByMac(@Param("mac") String mac, @Param("id") Integer id);

    int countByNumber(@Param("number") Integer number, @Param("id") Integer id);

    int countByDeviceIndex(@Param("device_index") Integer device_index, @Param("id") Integer id);

    int count();

    List<Camera> getPage(@Param("page") PageQuery page);

    List<Camera> getAll();

    Camera selectByIndex(@Param("device_index") Integer index);

    Camera selectByMac(@Param("mac") String mac);

}