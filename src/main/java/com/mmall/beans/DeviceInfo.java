package com.mmall.beans;
//封装状态查询命令时封装设备信息最后封装到Command中
public class DeviceInfo {
    private int deviceType;//靶机，采集，显靶分别为0，1，2
    private int deviceGroupIndex;
    private int deviceIndex;
    private int deviceId;

    public int getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(int deviceType) {
        this.deviceType = deviceType;
    }

    public int getDeviceGroupIndex() {
        return deviceGroupIndex;
    }

    public void setDeviceGroupIndex(int deviceGroupIndex) {
        this.deviceGroupIndex = deviceGroupIndex;
    }

    public int getDeviceIndex() {
        return deviceIndex;
    }

    public void setDeviceIndex(int deviceIndex) {
        this.deviceIndex = deviceIndex;
    }

    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }
}
