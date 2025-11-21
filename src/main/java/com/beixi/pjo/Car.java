package com.beixi.pjo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Car {
    private int id;
    private int carnum;
    private String area;
    private String location;
    private int size;
    private int status;
    private Date addtime;
}
