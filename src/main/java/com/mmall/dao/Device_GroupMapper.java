package com.mmall.dao;

import com.mmall.beans.PageQuery;
import com.mmall.model.Camera;
import com.mmall.model.Device_Group;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Device_GroupMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Device_Group record);

    int insertSelective(Device_Group record);

    Device_Group selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Device_Group record);

    int updateByPrimaryKey(Device_Group record);

    int countByTargetId(@Param("targetId") Integer targetId, @Param("id") Integer id);

    int countByCameraId(@Param("cameraId") Integer cameraId, @Param("id") Integer id);

    int countDisplayId(@Param("displayId") Integer number, @Param("id") Integer id);

    int countByGroupIndex(@Param("group_index") Integer group_index, @Param("id") Integer id);

    int count();

    List<Device_Group> getPage(@Param("page") PageQuery page);

    Device_Group getDeviceGroupByIndex(@Param("group_index") Integer group_index);

    List<Device_Group> getAll();

    Device_Group getDeviceGroupByCameraIndex(@Param("camera_index") Integer camera_index);

    Device_Group getDeviceGroupByDisplayIndex(@Param("display_index") Integer display_index);

    Device_Group getDeviceGroupByTargetIndex(@Param("target_index") Integer target_index);
}