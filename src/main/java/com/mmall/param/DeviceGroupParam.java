package com.mmall.param;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@ToString
public class DeviceGroupParam {
    private Integer id;
    @NotNull(message = "靶位编号不可以为空")
    private Integer group_index;

    @NotNull(message = "靶机设备编号不可以为空")
    private Integer target_id;

    @NotNull(message = "照靶终端编号不可以为空")
    private Integer camera_id;

    @NotNull(message = "显靶终端编号不可以为空")
    private Integer display_id;

    private String status;

    private String memo;
}
