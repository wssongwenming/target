package com.mmall.beans;
//"{\"code\":1,message:\"登陆成功\",\"data\":{\"userId\":\"1\",\"name\":\"张三\",\"department\":\"xxxx单位\",\"shooting_gun\":\"五六式手枪\",\"bullet_count\":10,\"target_number\":\"2\",\"group_number\":\"1\"}}"
public class ShootingInfo {
    private String userId;
    private String name;
    private String department;
    private String shooting_gun;
    private int bullet_count;
    private String target_number;
    private String group_number;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
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

    public String getShooting_gun() {
        return shooting_gun;
    }

    public void setShooting_gun(String shooting_gun) {
        this.shooting_gun = shooting_gun;
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
