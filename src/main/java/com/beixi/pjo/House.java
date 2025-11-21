package com.beixi.pjo;

import lombok.Data;
import lombok.ToString;

import java.util.Date;
// get set方法
@Data
//toString
@ToString
public class House {
    private int id;
    private String housenum;
    private String buildnum;
    private String unitnum;
    private Float area;
    private int status;
    private Date addtime;
}
