package com.mmall.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Pattern;

@Getter
@Setter
@ToString
public class TargetParam {
    private Integer id;
    private Integer device_index;
    @NotBlank(message = "设备名称不可以为空")
    private String name;
    @NotBlank(message = "Mac不可以为空")
    private String mac;

    @Pattern(regexp = "((25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))",message = "IP地址格式无效")
    private String ip;

    private Integer number;

    private Integer status;

    private String memo;
}
