package com.mmall.beans;

public class DeviceGroupData {
    private int deviceGroupIndex;//靶位编号
    private String displayStatus;
    private String cameraStatus;
    private String targetStatus;

    public int getDeviceGroupIndex() {
        return deviceGroupIndex;
    }

    public void setDeviceGroupIndex(int deviceGroupIndex) {
        this.deviceGroupIndex = deviceGroupIndex;
    }

    public String getDisplayStatus() {
        return displayStatus;
    }

    public void setDisplayStatus(String displayStatus) {
        this.displayStatus = displayStatus;
    }

    public String getCameraStatus() {
        return cameraStatus;
    }

    public void setCameraStatus(String cameraStatus) {
        this.cameraStatus = cameraStatus;
    }

    public String getTargetStatus() {
        return targetStatus;
    }

    public void setTargetStatus(String targetStatus) {
        this.targetStatus = targetStatus;
    }
}
