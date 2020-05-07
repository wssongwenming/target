package com.mmall.beans;

//参训人员状态
public interface TraineeStatus {
    int WAITING_SHOOTING = 0;

    int NORMAL_LOGIN = 1;

    int NOT_LOGIN=2;

    int IS_SHOOTING = 3;

    int FINISH_SHOOTING = 4;

    int ABSENT = 5;
}
