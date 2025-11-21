package com.beixi.util;


import com.beixi.dao.HouseDao;
import com.beixi.pjo.House;

import java.util.List;

public class TestUtil {
    public static void main(String[] args) throws Exception {
       List<House> houseList = HouseDao.findHouseList();
        for (House house : houseList) {
            System.out.println(house.toString());
        }
    }
}
