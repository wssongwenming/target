package com.mmall.model;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Training {

    private Integer id;

    private String title;

    private String orgDept;

    private Integer traineeNumber;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date dot;

    private String addr;

    private String memo;

    private String gun;

    private Integer bulletNumber;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getOrgDept() {
        return orgDept;
    }

    public void setOrgDept(String orgDept) {
        this.orgDept = orgDept == null ? null : orgDept.trim();
    }

    public Integer getTraineeNumber() {
        return traineeNumber;
    }

    public void setTraineeNumber(Integer traineeNumber) {
        this.traineeNumber = traineeNumber;
    }

    public Date getDot() {
        return dot;
    }

    public void setDot(Date dot) {
        this.dot = dot;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr == null ? null : addr.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    public String getGun() {
        return gun;
    }

    public void setGun(String gun) {
        this.gun = gun == null ? null : gun.trim();
    }

    public Integer getBulletNumber() {
        return bulletNumber;
    }

    public void setBulletNumber(Integer bulletNumber) {
        this.bulletNumber = bulletNumber;
    }
}