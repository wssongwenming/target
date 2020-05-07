package com.mmall.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

@Getter
@Setter
@ToString
public class TraineeUpdateParam {

    private Integer id;

    private Integer trainingId;

    private String name;

    private String workunit;

    private String phone;

    private Integer status;

    private String password;

    private String photo;

    private String memo;

    private Integer group_index;

    private Integer target_index;

}
