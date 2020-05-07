package com.mmall.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Getter
@Setter
@ToString
public class TrainingParam {
    private Integer id;

    @NotBlank(message = "训练计划名称不可以为空")
    @Length(min = 1, max = 50, message = "用户名长度需要在50个字以内")
    private String title;
    @NotBlank(message = "组织单位不可以为空")
    private String orgDept;
    private String trainigId;
    private Integer traineeNumber;
    @NotBlank(message = "枪械种类不可以为空")
    private String gun;
    @NotNull(message = "每人弹药数量不可以为空")
    private Integer bulletNumber;
    @NotBlank(message = "日期不可以为空")
    private String dot;
    private String addr;
    private String memo;

}
