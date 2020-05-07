package com.mmall.beans;
//String signByPassCommand="{\"code\":0,\"message\":\"登陆者信息\",\"index\":1,\"data\":{\"userId\":1,\"name\":\"张三\",\"department\":\"某某单位\",\"password\":\"111111\",\"shooting_gun\":\"手枪\",\"photopath\":\"\",\"bullet_count\":10,\"target_number\":\"12\",\"group_number\":\"1\"}}";
//服务端向Display发出登陆的消息队列命令
public class SignCommand {
    private int code;
    private String message;
    private int dataType;
    private SignInfo data;

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

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
    }

    public SignInfo getData() {
        return data;
    }

    public void setData(SignInfo data) {
        this.data = data;
    }
}
