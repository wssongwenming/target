package com.mmall.beans;

import com.mmall.model.Trainee;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

/*该bean主要用于封装分组展示的数据*/
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TraineeGroupQuery {

    //靶位的编码,每个编组的人员个数，即为靶位的个数，下标加1即可
    private List<DeviceGroupData>deviceGroupNumberList;

    private List<TraineeGroup> traineeGroupList;

    private int total;

    public List<DeviceGroupData> getDeviceGroupNumberList() {
        return deviceGroupNumberList;
    }

    public void setDeviceGroupNumberList(List<DeviceGroupData> deviceGroupNumberList) {
        this.deviceGroupNumberList = deviceGroupNumberList;
    }

    public List<TraineeGroup> getTraineeGroupList() {
        return traineeGroupList;
    }

    public void setTraineeGroupList(List<TraineeGroup> traineeGroupList) {
        this.traineeGroupList = traineeGroupList;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}
