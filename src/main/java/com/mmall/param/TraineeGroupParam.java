package com.mmall.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@ToString
public class TraineeGroupParam {
    private Integer id;
    //@NotNull(message = "编组序号不可为空")
    private Integer group_number;
    //@NotBlank(message = "参训人员编号不可为空")
    private String trainee_ids;
    private String per_status;
    private String all_status;
    private Integer training_id;
}
