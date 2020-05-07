package com.mmall.beans;

import com.mmall.model.Trainee;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TraineeGroup {
    private int id;
    private int groupNumber;
    private List<Trainee> traineeList;
    private String traineeIds;

    public int getGroupNumber() {
        return groupNumber;
    }

    public void setGroupNumber(int groupNumber) {
        this.groupNumber = groupNumber;
    }

    public List<Trainee> getTraineeList() {
        return traineeList;
    }

    public void setTraineeList(List<Trainee> traineeList) {
        this.traineeList = traineeList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTraineeIds() {
        return traineeIds;
    }

    public void setTraineeIds(String traineeIds) {
        this.traineeIds = traineeIds;
    }
}
