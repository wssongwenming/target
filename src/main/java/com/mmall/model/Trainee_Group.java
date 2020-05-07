package com.mmall.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Trainee_Group {
    private Integer id;

    private Integer groupNumber;

    private String traineeIds;

    private String perStatus;

    private String allStatus;

    private Integer trainingId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGroupNumber() {
        return groupNumber;
    }

    public void setGroupNumber(Integer groupNumber) {
        this.groupNumber = groupNumber;
    }

    public String getTraineeIds() {
        return traineeIds;
    }

    public void setTraineeIds(String traineeIds) {
        this.traineeIds = traineeIds == null ? null : traineeIds.trim();
    }

    public String getPerStatus() {
        return perStatus;
    }

    public void setPerStatus(String perStatus) {
        this.perStatus = perStatus == null ? null : perStatus.trim();
    }

    public String getAllStatus() {
        return allStatus;
    }

    public void setAllStatus(String allStatus) {
        this.allStatus = allStatus == null ? null : allStatus.trim();
    }

    public Integer getTrainingId() {
        return trainingId;
    }

    public void setTrainingId(Integer trainingId) {
        this.trainingId = trainingId;
    }
}