package com.mmall.beans;
//点击“开始射击命令”所要传递的数据
//"{\"code\":1,message:\"登陆成功\",\"data\":{\"userId\":\"1\",\"name\":\"张三\",\"department\":\"xxxx单位\",\"shooting_gun\":\"五六式手枪\",\"bullet_count\":10,\"target_number\":\"2\",\"group_number\":\"1\"}}"
public class Command {
    private int code;
    private String message;
    private int dataType;
    private Object data;
    //private ShootingInfo data;
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
    //public ShootingInfo getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
    }
}
