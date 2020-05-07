package com.mmall.beans;

import com.mmall.model.Trainee;

import java.util.List;

public class ShootingRangeData {
    private List<TraineeShooting_DeviceGroup_Data> traineeShooting_deviceGroup_data;//1, 打靶人员的数据,包括状态，相片，成绩,以及靶位设备信息
    private String nextGroupTraineeNames;//2,下一组打靶人员
    private int currentTrainneeGroupIndex;//3,当前第几组
    private int sumOfTraineeGroupCount;//4,总共多少组
    private int traineeCountFinishShooting;//5,已经完成打靶人数
    private int traineeCountNotShooting;//6,未完成打靶人数
    private int sumOfTraineeCount;//7,打靶总人数
    private int traineeCountAbsentShooting;//8,缺席人数

    public List<TraineeShooting_DeviceGroup_Data> getTraineeShooting_deviceGroup_data() {
        return traineeShooting_deviceGroup_data;
    }

    public void setTraineeShooting_deviceGroup_data(List<TraineeShooting_DeviceGroup_Data> traineeShooting_deviceGroup_data) {
        this.traineeShooting_deviceGroup_data = traineeShooting_deviceGroup_data;
    }

    public String getNextGroupTraineeNames() {
        return nextGroupTraineeNames;
    }

    public void setNextGroupTraineeNames(String nextGroupTraineeNames) {
        this.nextGroupTraineeNames = nextGroupTraineeNames;
    }

    public int getSumOfTraineeGroupCount() {
        return sumOfTraineeGroupCount;
    }

    public void setSumOfTraineeGroupCount(int sumOfTraineeGroupCount) {
        this.sumOfTraineeGroupCount = sumOfTraineeGroupCount;
    }

    public int getCurrentTrainneeGroupIndex() {
        return currentTrainneeGroupIndex;
    }

    public void setCurrentTrainneeGroupIndex(int currentTrainneeGroupIndex) {
        this.currentTrainneeGroupIndex = currentTrainneeGroupIndex;
    }

    public int getTraineeCountFinishShooting() {
        return traineeCountFinishShooting;
    }

    public void setTraineeCountFinishShooting(int traineeCountFinishShooting) {
        this.traineeCountFinishShooting = traineeCountFinishShooting;
    }

    public int getTraineeCountNotShooting() {
        return traineeCountNotShooting;
    }

    public void setTraineeCountNotShooting(int traineeCountNotShooting) {
        this.traineeCountNotShooting = traineeCountNotShooting;
    }

    public int getSumOfTraineeCount() {
        return sumOfTraineeCount;
    }

    public void setSumOfTraineeCount(int sumOfTraineeCount) {
        this.sumOfTraineeCount = sumOfTraineeCount;
    }

    public int getTraineeCountAbsentShooting() {
        return traineeCountAbsentShooting;
    }

    public void setTraineeCountAbsentShooting(int traineeCountAbsentShooting) {
        this.traineeCountAbsentShooting = traineeCountAbsentShooting;
    }
}