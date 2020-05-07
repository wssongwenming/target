package com.mmall.beans;
//登陆命令的内容
//String signByPassCommand="{\"code\":0,\"message\":\"登陆者信息\",\"index\":1,\"data\":{\"userId\":1,\"name\":\"张三\",\"department\":\"某某单位\",\"password\":\"111111\",\"shooting_gun\":\"手枪\",\"photopath\":\"\",\"bullet_count\":10,\"target_number\":\"12\",\"group_number\":\"1\"}}";

public class SignInfo {
    private int userId;
    private String name;
    private String department;
    private String password;
    private String shooting_gun;
    private String photopath;
    private int bullet_count;
    private String target_number;
    private String group_number;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getShooting_gun() {
        return shooting_gun;
    }

    public void setShooting_gun(String shooting_gun) {
        this.shooting_gun = shooting_gun;
    }

    public String getPhotopath() {
        return photopath;
    }

    public void setPhotopath(String photopath) {
        this.photopath = photopath;
    }

    public int getBullet_count() {
        return bullet_count;
    }

    public void setBullet_count(int bullet_count) {
        this.bullet_count = bullet_count;
    }

    public String getTarget_number() {
        return target_number;
    }

    public void setTarget_number(String target_number) {
        this.target_number = target_number;
    }

    public String getGroup_number() {
        return group_number;
    }

    public void setGroup_number(String group_number) {
        this.group_number = group_number;
    }
}
