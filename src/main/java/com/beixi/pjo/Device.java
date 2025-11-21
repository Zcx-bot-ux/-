package com.beixi.pjo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Device {
    private int id;
    private String equipmentCode;
    private String name;
    private String type;
    private String location;
    private Date installDate;
    private String status;
    private Date lastMaintainDate;
    private String maintainer;
    private String remark;
    private Date createDate;
    private Date updateDate;
}
